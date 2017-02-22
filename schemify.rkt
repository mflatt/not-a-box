#lang racket/base
(require "match.rkt")

(provide schemify-linklet
         schemify-body)

;; Convert a linklet to a Scheme `lambda`, dealing with several
;; issues:
;;
;;   - imports and exports are represented by `variable` objects that
;;     are passed to the function; to avoid obscuring the program to
;;     the optimizer, though, refer to the definitions of exported
;;     variables instead of going through the `variable`, whenever
;;     possible;
;;
;;   - wrap expressions in a sequence of definitions plus expressions
;;     so that the result body is a sequence of definitions followed
;;     by a single expression;
;;
;;   - convert function calls and `let` forms to enforce left-to-right
;;     evaluation;
;;
;;   - convert function calls to support applicable structs, using
;;     `#%app` whenever a call might go through something other than a
;;     plain function;
;;
;;   - convert `make-struct-type` bindings to a pattern that Chez can
;;     recognize;
;;
;;   - optimize away `variable-reference-constant?` uses as much
;;     as possible
;;
;;   - simplify `define-values` and `let-values` to `define` and
;;     `let`, when possible.

(define (schemify-linklet lk init-procs)
  ;; For imports, map symbols to gensymed `variable` argument names:
  (define imports
    (for*/fold ([imports (hasheq)]) ([ims (in-list (cdadr lk))]
                                     [im (in-list ims)])
      (define id (if (pair? im) (car im) im))
      (hash-set imports id (gensym (symbol->string id)))))
  ;; Ditto for exports:
  (define exports
    (for/fold ([exports (hasheq)]) ([ex (in-list (cdaddr lk))])
      (define id (if (pair? ex) (car ex) ex))
      (hash-set exports id (gensym (symbol->string id)))))
  ;; Build `lambda` with schemified body:
  `(lambda (,@(for*/list ([ims (in-list (cdadr lk))]
                     [im (in-list ims)])
           (hash-ref imports (if (pair? im) (car im) im)))
       ,@(for/list ([ex (in-list (cdaddr lk))])
           (hash-ref exports (if (pair? ex) (car ex) ex))))
    ,@(schemify-body (cdddr lk) init-procs imports exports)))

(define (schemify-body l init-procs imports exports)
  ;; Various conversion steps need information about mutated variables,
  ;; where "mutated" here includes visible implicit mutation, such as
  ;; a variable that might be used before it is defined:
  (define mutated (mutated-in-body l exports))
  ;; While schemifying, recognize definition sequences, and keep them
  ;; together to help the optimizer. Also, add calls to install exported
  ;; values in to the corresponding exported `variable` records.
  (let loop ([l l] [procs init-procs] [structs (hasheq)] [accum null] [need-expr? #f])
    (cond
     [(null? l)
      (append
       (map (make-schemify procs structs mutated imports exports)
            (reverse accum))
       (make-set-variables accum exports)
       (if need-expr?
           '((void))
           null))]
     [else
      (define-values (v new-procs new-structs side-effects? defn?)
        (find-definitions (car l) procs structs (null? (cdr l))))
      (cond
       [(not side-effects?) (loop (cdr l)
                                  new-procs
                                  new-structs
                                  (cons v accum)
                                  #t)]
       [else
        (define schemify (make-schemify new-procs new-structs mutated imports exports))
        (append (map schemify (reverse accum))
                (make-set-variables accum exports)
                (list (schemify v))
                (make-set-variables (list v) exports)
                (loop (cdr l) new-procs new-structs null defn?))])])))

;; Recognize forms that produce plain procedures
(define (lambda? v)
  (match v
    [`(lambda . ,_) #t]
    [`(case-lambda . ,_) #t]
    [`(let-values ([(,id1) ,rhs]) ,id2) (and (eq? id1 id2) (lambda? rhs))]
    [`(letrec-values ([(,id1) ,rhs]) ,id2) (and (eq? id1 id2) (lambda? rhs))]
    [`(let-values ,_ ,body) (lambda? body)]
    [`(letrec-values ,_ ,body) (lambda? body)]
    [`,_ #f]))

;; Check whether an expression is simple in the sense that its order
;; of evaluation isn't detectable. This function receives both
;; schemified and non-schemified expressions.
(define (simple? e mutated)
  (match e
    [`(lambda . ,_) #t]
    [`(case-lambda . ,_) #t]
    [`(quote . ,_) #t]
    [`(#%variable-reference . ,_) #t]
    [`(let-values ([,_ ,rhss] ...) ,body)
     (and (for/and ([rhs (in-list rhss)])
            (simple? rhss mutated))
          (simple? body mutated))]
    [`(let ([,_ ,rhss] ...) ,body)
     (and (for/and ([rhs (in-list rhss)])
            (simple? rhss mutated))
          (simple? body mutated))]
    [`(letrec-values ([(,idss ...) ,rhss] ...) ,body)
     (define mutated+idss (for*/fold ([mutated mutated]) ([ids (in-list idss)]
                                                         [id (in-list ids)])
                            (hash-set mutated id #t)))
     (and (for/and ([rhs (in-list rhss)])
            (simple? rhs mutated+idss))
          (simple? body mutated))]
    [`(letrec* ([,ids ,rhss] ...) ,body)
     (define mutated+ids (for/fold ([mutated mutated]) ([id (in-list ids)])
                           (hash-set mutated id #t)))
     (and (for/and ([rhs (in-list rhss)])
            (simple? rhs mutated+ids))
          (simple? body mutated))]
    [`,_
     (or (and (symbol? e)
              (not (hash-ref mutated e #f)))
         (integer? e)
         (boolean? e)
         (string? e)
         (bytes? e)
         (regexp? e))]))

;; Also recognize and keep track of structure-type bindings
(struct struct-type-info (name parent field-count rest))

;; Parse `make-struct-type` forms, returning a `struct-type-info`
;; if the parse succeed:
(define (make-struct-type-info v structs)
  (match v
    [`(make-struct-type (quote ,name) ,parent ,fields 0 #f . ,rest)
     (and (symbol? name)
          (or (not parent)
              (hash-ref structs parent #f))
          (exact-nonnegative-integer? fields)
          (struct-type-info name
                            parent
                            fields
                            rest))]
    [`(let-values () ,body)
     (make-struct-type-info body structs)]
    [`,_ #f]))

;; Record top-level functions and structure types:
(define (find-definitions v procs structs last?)
  (match v
    [`(define-values (,id) ,rhs)
     (if (lambda? rhs)
         (values v (hash-set procs id #t) structs #f #t)
         (values v procs structs #t #t))]
    [`(define-values (,struct:s ,make-s ,s? ,acc/muts ...)
       (let-values (((,struct: ,make ,? ,-ref ,-set!) ,rhs))
         (values ,struct:2
                 ,make2
                 ,?2
                 ,make-acc/muts ...)))
     (define info (and (eq? struct: struct:2)
                       (eq? make make2)
                       (eq? ? ?2)
                       (make-struct-type-info rhs structs)))
     (cond
      [info
       (values v
               (for/fold ([procs procs]) ([id (in-list (list* make-s s? acc/muts))])
                 (hash-set procs id #t))
               (hash-set structs struct:s #t)
               #f
               #t)]
      [else
       (values v procs structs #t #t)])]
    [`(define-values . ,_)
     (values v procs structs #t #t)]
    [`,_
     (values (if last?
                 v
                 ;; Wrap any top-level expression as a definition
                 `(define-values (,(gensym)) (begin ,v (void))))
             procs
             structs
             #t
             #f)]))

;; Convert a `let` to nested lets to enforce order; we
;; rely on the fact that the Racket expander generates
;; expressions that have no shadowing (and inroduce
;; shadowing here)
(define (left-to-right/let v mutated)
  (match v
    [`(let (,_) . ,_) v]
    [`(let ([,ids ,rhss] ...) . ,bodys)
     (let loop ([ids ids] [rhss rhss] [binds null])
       (cond
        [(null? (cdr rhss))
         (if (null? binds)
             `(let ([,(car ids) ,(car rhss)])
               . ,bodys)
             `(let ([,(car ids) ,(car rhss)])
               (let ,binds
                    . ,bodys)))]
        [(simple? (car rhss) mutated)
         `(let ([,(car ids) ,(car rhss)])
           ,(loop (cdr ids) (cdr rhss) binds))]
        [else
         (define id (car ids))
         `(let ([,id ,(car rhss)])
           ,(loop (cdr ids) (cdr rhss) (cons `[,id ,id] binds)))]))]))

;; Convert a `lte-values` to nested `let-values`es to
;; enforce order
(define (left-to-right/let-values v mutated)
  (define (make-let-values ids rhs body)
    (if (and (pair? ids) (null? (cdr ids)))
        `(let ([,(car ids) ,rhs]) ,body)
        `(call-with-values (lambda () ,rhs)
          (case-lambda 
            [,ids ,body]
            [args (error (format
                          (string-append
                           "result arity mismatch;\n"
                           " expected number of values not received\n"
                           "  received: ~a\n" 
                           "  in: local-binding form"))
                         (length args))]))))
  (match v
    [`(let-values ([,ids ,rhs]) ,body)
     (make-let-values ids rhs body)]
    [`(let-values ([,ids ,rhs]) . ,bodys)
     (make-let-values ids rhs `(begin . ,bodys))]
    [`(let-values ([(,idss ...) ,rhss] ...) . ,bodys)
     (let loop ([idss idss] [rhss rhss] [binds null])
       (cond
        [(null? (cdr rhss))
         (make-let-values
          (car idss) (car rhss)
          `(let ,binds
            . ,bodys))]
        [else
         (define ids (car idss))
         (make-let-values
          ids
          (car rhss)
          (loop (cdr idss) (cdr rhss) (append (map (lambda (id) `[,id ,id]) ids) binds)))]))]))

;; Convert an application to enforce left-to-right
;; evaluation order
(define (left-to-right/app v mutated)
  (let loop ([l v] [accum null])
    (cond
     [(null? l) (reverse accum)]
     [(simple? (car l) mutated)
      (loop (cdr l) (cons (car l) accum))]
     [(andmap (lambda (v) (simple? v mutated)) (cdr l))
      (append (reverse accum) l)]
     [else
      (define g (gensym "app_"))
      `(let ([,g ,(car l)])
        ,(loop (cdr l) (cons g accum)))])))

;; Schemify `let-values` to `let`, etc., and
;; reorganize struct bindings.
(define ((make-schemify procs structs mutated imports exports) v)
  (let schemify ([v v])
    (match v
      [`(lambda ,formals ,body ...)
       `(lambda ,formals ,@(map schemify body))]
      [`(case-lambda [,formalss ,bodys ...] ...)
       `(case-lambda ,@(for/list ([formals (in-list formalss)]
                             [body (in-list bodys)])
                    `[,formals ,@(map schemify body)]))]
      [`(define-values (,struct:s ,make-s ,s? ,acc/muts ...)
         (let-values (((,struct: ,make ,?1 ,-ref ,-set!) ,mk))
           (values ,struct:2
                   ,make2
                   ,?2
                   ,make-acc/muts ...)))
       ;; Convert a `make-struct-type` binding into a 
       ;; set of bindings that Chez's cp0 recognizes,
       ;; and push the struct-specific extra work into
       ;; `struct-type-install-properties!`
       (define sti (and (eq? struct: struct:2)
                        (eq? make make2)
                        (eq? ?1 ?2)
                        (make-struct-type-info mk structs)))
       (cond
        [sti
         `(begin
           (define ,struct:s (make-record-type-descriptor ',(struct-type-info-name sti)
                                                          ,(struct-type-info-parent sti)
                                                           #f #f #f
                                                          ',(for/vector ([i (in-range (struct-type-info-field-count sti))])
                                                              `(mutable ,(string->symbol (format "f~a" i))))))
           (define ,make-s (record-constructor
                            (make-record-constructor-descriptor ,struct:s #f #f)))
           (define ,s? (record-predicate ,struct:s))
           ,@(for/list ([acc/mut (in-list acc/muts)]
                        [make-acc/mut (in-list make-acc/muts)])
               `(define ,acc/mut
                 ,(match make-acc/mut
                    [`(make-struct-field-accessor ,(? (lambda (v) (eq? v -ref))) ,pos ,_)
                     `(record-accessor ,struct:s ,pos)]
                    [`(make-struct-field-mutator ,(? (lambda (v) (eq? v -set!))) ,pos ,_)
                     `(record-mutator ,struct:s ,pos)]
                    [`,_ (error "oops")])))
           ,@(if (null? (struct-type-info-rest sti))
                 null
                 `((define ,(gensym)
                     (struct-type-install-properties! ,struct:s
                                                      ',(struct-type-info-name sti)
                                                      ,(struct-type-info-field-count sti)
                                                      0
                                                      ,(struct-type-info-parent sti)
                                                      ,@(map schemify (struct-type-info-rest sti)))))))]
        [else
         `(define-values ,(cadr v) ,(schemify (caddr v)))])]
      [`(define-values (,id) ,rhs)
       `(define ,id ,(schemify rhs))]
      [`(define-values ,ids ,rhs)
       `(define-values ,ids ,(schemify rhs))]
      [`(quote ,_) v]
      [`(let-values () ,body)
       (schemify body)]
      [`(let-values () ,bodys ...)
       `(begin ,@(map schemify bodys))]
      [`(let-values ([(,ids) ,rhss] ...) ,bodys ...)
       (define new-procs
         (for/fold ([proc procs]) ([id (in-list ids)]
                                   [rhs (in-list rhss)])
           (if (lambda? rhs)
               (hash-set procs id #t)
               procs)))
       (define body-schemify (make-schemify new-procs structs mutated imports exports))
       (left-to-right/let
        `(let ,(for/list ([id (in-list ids)]
                          [rhs (in-list rhss)])
                 `[,id ,(schemify rhs)])
          ,@(map body-schemify bodys))
        mutated)]
      [`(let-values ([() (begin ,rhss ... (values))]) ,bodys ...)
       `(begin ,@(map schemify rhss) ,@(map schemify bodys))]
      [`(let-values ([(,idss ...) ,rhss] ...) ,bodys ...)
       (left-to-right/let-values
        `(let-values ,(for/list ([ids (in-list idss)]
                                 [rhs (in-list rhss)])
                        `[,ids ,(schemify rhs)])
          ,@(map schemify bodys))
        mutated)]
      [`(letrec-values ([(,ids) ,rhss] ...) ,bodys ...)
       (define new-procs
         (for/fold ([proc procs]) ([id (in-list ids)]
                                   [rhs (in-list rhss)])
           (if (lambda? rhs)
               (hash-set procs id #t)
               procs)))
       (define schemify (make-schemify new-procs structs mutated imports exports))
       `(letrec* ,(for/list ([id (in-list ids)]
                             [rhs (in-list rhss)])
                    `[,id ,(schemify rhs)])
         ,@(map schemify bodys))]
      [`(letrec-values ([(,idss ...) ,rhss] ...) ,bodys ...)
       `(letrec*-values ,(for/list ([ids (in-list idss)]
                                    [rhs (in-list rhss)])
                           `[,ids ,(schemify rhs)])
         ,@(map schemify bodys))]
      [`(if ,tst ,thn ,els)
       `(if ,(schemify tst) ,(schemify thn) ,(schemify els))]
      [`(with-continuation-mark ,key ,val ,body)
       `(with-continuation-mark ,(schemify key) ,(schemify val) ,(schemify body))]
      [`(begin ,exps ...)
       `(begin . ,(map schemify exps))]
      [`(begin0 ,exps ...)
       `(begin0 . ,(map schemify exps))]
      [`(set! ,id ,rhs)
       (let ([ex-id (hash-ref exports id #f)])
         (if ex-id
             `(variable-set! ,ex-id ,(schemify rhs))
             `(set! ,id ,(schemify rhs))))]
      [`(variable-reference-constant? (#%variable-reference ,id))
       (not (hash-ref mutated id #f))]
      [`(#%variable-reference . ,_)
       v]
      [`(,rator ,exps ...)
       (let ([args (map schemify exps)])
         (left-to-right/app
          (if (or (hash-ref procs rator #f)
                  (lambda? rator))
              `(,(schemify rator) . ,args)
              `(#%app ,(schemify rator) . ,args))
          mutated))]
      [`,_
       (cond
        [(and (symbol? v)
              (hash-ref mutated v #f)
              (hash-ref exports v #f))
         => (lambda (ex-id) `(variable-ref ,ex-id))]
        [(and (symbol? v)
              (hash-ref imports v #f))
         => (lambda (im-id) `(variable-ref ,im-id))]
        [else v])])))

(define (mutated-in-body l exports)
  ;; Find all defined variables:
  (define pending
    (for/fold ([pending (hasheq)]) ([v (in-list l)])
      (match v
        [`(define-values ,ids ,rhs)
         (for/fold ([pending pending]) ([id (in-list ids)])
           (if (hash-ref exports id #f)
               (hash-set pending id #t)
               pending))]
        [`,_ pending])))
  ;; If an exported variable is used too early, count it as 
  ;; mutated, so that references go through the reified variable
  ;; record
  (let loop ([mutated (hasheq)] [l l] [delay-l null] [pending pending])
    (cond
     [(null? l)
      (for/fold ([mutated mutated]) ([v (in-list delay-l)])
        (find-mutated v mutated pending))]
     [else
      (define form (car l))
      (match form
        [`(define-values ,ids ,rhs)
         (define next-pending (for/fold ([pending pending]) ([id (in-list ids)])
                                (hash-remove pending id)))
         (if (lambda? rhs)
             (loop mutated (cdr l) (cons rhs delay-l) next-pending)
             (let ([mutated (for/fold ([mutated mutated]) ([v (in-list delay-l)])
                              (find-mutated v mutated pending))])
               (loop (find-mutated rhs mutated pending)
                     (cdr l)
                     null
                     next-pending)))]
        [`,_
         (let ([mutated (for/fold ([mutated mutated]) ([v (in-list delay-l)])
                          (find-mutated v mutated pending))])
           (loop (find-mutated form mutated pending)
                 (cdr l)
                 null
                 pending))])])))

;; Schemify `let-values` to `let`, etc., and
;; reorganize struct bindings.
(define (find-mutated v mutated pending)
  (match v
    [`(lambda ,formals ,body ...)
     (find-mutated* body mutated pending)]
    [`(case-lambda [,formalss ,bodys ...] ...)
     (for/fold ([mutated mutated]) ([body (in-list bodys)])
       (find-mutated* body mutated pending))]
    [`(define-values ,ids ,rhs)
     (find-mutated rhs mutated pending)]
    [`(quote ,_) mutated]
    [`(let-values ([(,ids) ,rhss] ...) ,bodys ...)
     (find-mutated* bodys (find-mutated* rhss mutated pending) pending)]
    [`(letrec-values ([(,idss ...) ,rhss] ...) ,bodys ...)
     (define-values (new-mutated simple-so-far?)
       ;; Count a binding as implicitly mutated if it might be referenced
       ;; too early or if a continuation can be captured
       (for/fold ([mutated mutated] [simple-so-far? #t]) ([ids (in-list idss)]
                                                          [rhs (in-list rhss)])
         (define still-simple? (and simple-so-far? (simple? rhs mutated)))
         (if still-simple?
             (values (find-mutated rhs mutated pending) #t)
             (values (find-mutated rhs
                                   (for/fold ([mutated mutated]) ([id (in-list ids)])
                                     (hash-set mutated id #t))
                                   pending)
                     #f))))
     (find-mutated* bodys new-mutated pending)]
    [`(if ,tst ,thn ,els)
     (find-mutated els (find-mutated thn (find-mutated tst mutated pending) pending) pending)]
    [`(with-continuation-mark ,key ,val ,body)
     (find-mutated body (find-mutated val (find-mutated key mutated pending) pending) pending)]
    [`(begin ,exps ...)
     (find-mutated* exps mutated pending)]
    [`(begin0 ,exps ...)
     (find-mutated* exps mutated pending)]
    [`(set! ,id ,rhs)
     (find-mutated rhs (hash-set mutated id #t) pending)]
    [`(#%variable-reference . ,_) mutated]
    [`(,rator ,exps ...)
     (find-mutated* exps (find-mutated rator mutated pending) pending)]
    [`,_
     (if (and (symbol? v)
              (hash-ref pending v #f))
         ;; Early use of a defined variable:
         (hash-set mutated v #t)
         ;; Not an early use:
         mutated)]))

(define (find-mutated* l mutated pending)
  (for/fold ([mutated mutated]) ([v (in-list l)])
    (find-mutated v mutated pending)))

(define (make-set-variables accum exports)
  (for/fold ([assigns null]) ([v (in-list accum)])
    (match v
      [`(define-values (,ids ...) ,_)
       (for/fold ([assigns assigns]) ([id (in-list ids)])
         (define ex-var (hash-ref exports id #f))
         (if ex-var
             (cons `(define ,(gensym) (variable-set! ,ex-var ,id))
                   assigns)
             assigns))]
      [`,_ assigns])))
