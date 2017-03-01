#lang racket/base
(require "match.rkt"
         "known.rkt")

(provide schemify-linklet
         schemify-body
         (all-from-out "known.rkt"))

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

(struct import (grp id ext-id))
(struct import-group ([knowns/thunk #:mutable])) ; starts as a procedure to get table

(define (import-group-knowns grp)
  (define knowns/thunk (import-group-knowns/thunk grp))
  (cond
   [(procedure? knowns/thunk)
    (define knowns (or (knowns/thunk)
                       (hasheq)))
    (set-import-group-knowns/thunk! grp knowns)
    knowns]
   [else knowns/thunk]))

(define (schemify-linklet lk prim-knowns get-import-knowns)
  ;; For imports, map symbols to gensymed `variable` argument names:
  (define imports
    (for/fold ([imports (hasheq)]) ([ims (in-list (cadr lk))]
                                    [index (in-naturals)])
      (define grp (import-group (lambda () (get-import-knowns index))))
      (for/fold ([imports imports]) ([im (in-list ims)])
        (define id (if (pair? im) (cadr im) im))
        (define ext-id (if (pair? im) (cdr im) im))
        (hash-set imports id (import grp (gensym (symbol->string id)) ext-id)))))
  ;; Ditto for exports:
  (define exports
    (for/fold ([exports (hasheq)]) ([ex (in-list (caddr lk))])
      (define id (if (pair? ex) (car ex) ex))
      (hash-set exports id (gensym (symbol->string id)))))
  ;; Schemify the body, collecting information about defined names:
  (define-values (new-body defn-info)
    (schemify-body* (cdddr lk) prim-knowns imports exports))
  ;; Build `lambda` with schemified body:
  (values
   `(lambda (instance-variable-reference
        ,@(for*/list ([ims (in-list (cadr lk))]
                      [im (in-list ims)])
            (import-id (hash-ref imports (if (pair? im) (cadr im) im))))
        ,@(for/list ([ex (in-list (caddr lk))])
            (hash-ref exports (if (pair? ex) (car ex) ex))))
     ,@new-body)
   ;; Convert internal to external identifiers
   (for/fold ([knowns (hasheq)]) ([ex (in-list (caddr lk))])
     (define id (if (pair? ex) (car ex) ex))
     (define v (hash-ref defn-info id #f))
     (cond
      [v
       (define ext-id (if (pair? ex) (cadr ex) ex))
       (hash-set knowns ext-id v)]
      [else knowns]))))

(define (schemify-body l prim-knowns imports exports)
  (define-values (new-body defn-info)
    (schemify-body* l prim-knowns imports exports))
  new-body)

(define (schemify-body* l prim-knowns imports exports)
  ;; Various conversion steps need information about mutated variables,
  ;; where "mutated" here includes visible implicit mutation, such as
  ;; a variable that might be used before it is defined:
  (define mutated (mutated-in-body l exports prim-knowns (hasheq) imports))
  ;; Make another pass to gather known-binding information:
  (define knowns
    (for/fold ([knowns (hasheq)]) ([form (in-list l)])
      (find-definitions form prim-knowns knowns imports mutated)))
  ;; While schemifying, add calls to install exported values in to the
  ;; corresponding exported `variable` records, but delay those
  ;; installs to the end, if possible
  (define schemified
    (let loop ([l l] [accum-exprs null] [accum-ids null])
      (cond
       [(null? l)
        (define set-vars
          (for/list ([id (in-list accum-ids)]
                     #:when (hash-ref exports id #f))
            (make-set-variable id exports)))
        (cond
         [(null? set-vars)
          (cond
           [(null? accum-exprs) '((void))]
           [else (reverse accum-exprs)])]
         [else (append
                (make-expr-defns accum-exprs)
                set-vars)])]
       [else
        (define form (car l))
        (define schemified ((make-schemify prim-knowns knowns mutated imports exports) form))
        (match form
          [`(define-values ,ids ,_)
           (append
            (make-expr-defns accum-exprs)
            (cons
             schemified 
             (let id-loop ([ids ids] [accum-exprs null] [accum-ids accum-ids])
               (cond
                [(null? ids) (loop (cdr l) accum-exprs accum-ids)]
                [(hash-ref mutated (car ids) #f)
                 (define id (car ids))
                 (cond
                  [(hash-ref exports id #f)
                   (id-loop (cdr ids)
                            (cons (make-set-variable id exports)
                                  accum-exprs)
                            accum-ids)]
                  [else
                   (id-loop (cdr ids) accum-exprs accum-ids)])]
                [else
                 (id-loop (cdr ids) accum-exprs (cons (car ids) accum-ids))]))))]
          [`,_
           (loop (cdr l) (cons schemified accum-exprs) accum-ids)])])))
  ;; Return both schemified and known-binding information, where
  ;; the later is used for cross-linklet optimization
  (values schemified knowns))

(define (make-set-variable id exports)
  (define ex-var (hash-ref exports id))
  `(variable-set! ,ex-var ,id))

(define (make-expr-defns accum-exprs)
  (for/list ([expr (in-list (reverse accum-exprs))])
    `(define ,(gensym) ,expr)))

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
(define (simple? e prim-knowns knowns imports mutated)
  (let simple? ([e e])
    (match e
      [`(lambda . ,_) #t]
      [`(case-lambda . ,_) #t]
      [`(quote . ,_) #t]
      [`(#%variable-reference . ,_) #t]
      [`(let-values ([,_ ,rhss] ...) ,body)
       (and (for/and ([rhs (in-list rhss)])
              (simple? rhs))
            (simple? body))]
      [`(let ([,_ ,rhss] ...) ,body)
       (and (for/and ([rhs (in-list rhss)])
              (simple? rhs))
            (simple? body))]
      [`(letrec-values ([(,idss ...) ,rhss] ...) ,body)
       (and (for/and ([rhs (in-list rhss)])
              (simple? rhs))
            (simple? body))]
      [`(letrec* ([,ids ,rhss] ...) ,body)
       (and (for/and ([rhs (in-list rhss)])
              (simple? rhs))
            (simple? body))]
      [`(,proc ,arg)
       (and (symbol? proc)
            (let ([v (hash-ref-either knowns imports proc)])
              (and v
                   (not (hash-ref mutated proc #f))
                   (or (known-predicate? v)
                       (and (known-constructor? v)
                            (= 1 (known-constructor-field-count v))))))
            (simple? arg))]
      [`(,proc . ,args)
       (and (symbol? proc)
            (let ([v (hash-ref-either knowns imports proc)])
              (and (known-constructor? v)
                   (= (length args) (known-constructor-field-count v))))
            (not (hash-ref mutated proc #f))
            (for/and ([arg (in-list args)])
              (simple? arg)))]
      [`,_
       (or (and (symbol? e)
                (let ([v (hash-ref mutated e #f)])
                  (or (not v)
                      (delayed? v))))
           (integer? e)
           (boolean? e)
           (string? e)
           (bytes? e)
           (regexp? e))])))

;; Also recognize and keep track of structure-type bindings
(struct struct-type-info (name parent immediate-field-count field-count pure-constructor? rest))

(define (hash-ref-either knowns imports key)
  (or (hash-ref knowns key #f)
      (let ([im (hash-ref imports key #f)])
        (and im
             (hash-ref (import-group-knowns (import-grp im)) (import-ext-id im) #f)))))

;; Parse `make-struct-type` forms, returning a `struct-type-info`
;; if the parse succeed:
(define (make-struct-type-info v knowns imports mutated)
  (match v
    [`(make-struct-type (quote ,name) ,parent ,fields 0 #f . ,rest)
     (and (symbol? name)
          (or (not parent)
              (and (known-struct-type? (hash-ref-either knowns imports parent))
                   (not (hash-ref mutated parent #f))))
          (exact-nonnegative-integer? fields)
          (struct-type-info name
                            parent
                            fields
                            (+ fields (if parent
                                          (known-struct-type-field-count
                                           (hash-ref-either knowns imports parent))
                                          0))
                            ;; no guard => pur constructor
                            (or ((length rest) . < . 4)
                                (not (list-ref rest 3)))
                            rest))]
    [`(let-values () ,body)
     (make-struct-type-info body knowns imports mutated)]
    [`,_ #f]))

;; Record top-level functions and structure types:
(define (find-definitions v prim-knowns knowns imports mutated)
  (match v
    [`(define-values (,id) ,rhs)
     (cond
      [(lambda? rhs)
       (hash-set knowns id a-known-procedure)]
      [(simple? rhs prim-knowns knowns imports mutated)
       (hash-set knowns id a-known-unknown)]
      [else knowns])]
    [`(define-values (,struct:s ,make-s ,s? ,acc/muts ...) ; pattern from `struct` or `define-struct`
       (let-values (((,struct: ,make ,? ,-ref ,-set!) ,rhs))
         (values ,struct:2
                 ,make2
                 ,?2
                 ,make-acc/muts ...)))
     (define info (and (eq? struct: struct:2)
                       (eq? make make2)
                       (eq? ? ?2)
                       (make-struct-type-info rhs knowns imports mutated)))
     (cond
      [info
       (define type (gensym (symbol->string make-s)))
       (let* ([knowns (hash-set knowns
                                make-s
                                (if (struct-type-info-pure-constructor? info)
                                    (known-constructor type (struct-type-info-field-count info))
                                    a-known-procedure))]
              [knowns (hash-set knowns
                                s?
                                (known-predicate type))]
              [knowns
               (for/fold ([knowns knowns]) ([id (in-list acc/muts)]
                                            [maker (in-list make-acc/muts)])
                 (cond
                  [(eq? (car maker) -ref)
                   (hash-set knowns id (known-accessor type))]
                  [else
                   (hash-set knowns id (known-mutator type))]))])
         (hash-set knowns struct:s (known-struct-type type (struct-type-info-field-count info))))]
      [else knowns])]
    [`(define-values (,struct:s ,make-s ,s? ,s-ref ,s-set!) ,rhs) ; direct use of `make-struct-type`
     (define info (make-struct-type-info rhs knowns imports mutated))
     (cond
      [info
       (define type (gensym (symbol->string make-s)))
       (let* ([knowns (hash-set knowns
                                make-s
                                (if (struct-type-info-pure-constructor? info)
                                    (known-constructor type (struct-type-info-field-count info))
                                    a-known-procedure))]
              [knowns (hash-set knowns
                                s?
                                (known-predicate type))])
         ;; For now, we don't try to track the position-consuming accessor or mutator
         (hash-set knowns struct:s (known-struct-type type (struct-type-info-field-count info))))]
      [else knowns])]
    [`,_ knowns]))

;; Convert a `let` to nested lets to enforce order; we
;; rely on the fact that the Racket expander generates
;; expressions that have no shadowing (and inroduce
;; shadowing here)
(define (left-to-right/let v prim-knowns knowns imports mutated)
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
        [(simple? (car rhss) prim-knowns knowns imports mutated)
         `(let ([,(car ids) ,(car rhss)])
           ,(loop (cdr ids) (cdr rhss) binds))]
        [else
         (define id (car ids))
         `(let ([,id ,(car rhss)])
           ,(loop (cdr ids) (cdr rhss) (cons `[,id ,id] binds)))]))]))

;; Convert a `let-values` to nested `let-values`es to
;; enforce order
(define (left-to-right/let-values v mutated)
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

(define (make-let-values ids rhs body)
  (cond
   [(and (pair? ids) (null? (cdr ids)))
    `(let ([,(car ids) ,rhs]) ,body)]
   [else
    (match (and (null? ids) rhs)
      [`(begin ,rhs (values))
       `(begin ,rhs ,body)]
      [`,_
       `(call-with-values (lambda () ,rhs)
         (case-lambda 
           [,ids ,body]
           [args (raise-result-arity-error ',ids args)]))])]))

;; Convert an application to enforce left-to-right
;; evaluation order
(define (left-to-right/app v prim-knowns knowns imports mutated)
  (let loop ([l v] [accum null])
    (cond
     [(null? l) (reverse accum)]
     [(simple? (car l) prim-knowns knowns imports mutated)
      (loop (cdr l) (cons (car l) accum))]
     [(andmap (lambda (v) (simple? v prim-knowns knowns imports mutated)) (cdr l))
      (append (reverse accum) l)]
     [else
      (define g (gensym "app_"))
      `(let ([,g ,(car l)])
        ,(loop (cdr l) (cons g accum)))])))

;; Schemify `let-values` to `let`, etc., and
;; reorganize struct bindings.
(define ((make-schemify prim-knowns knowns mutated imports exports) v)
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
                        (make-struct-type-info mk knowns imports mutated)))
       (cond
        [sti
         `(begin
           (define ,struct:s (make-record-type-descriptor ',(struct-type-info-name sti)
                                                          ,(schemify (struct-type-info-parent sti))
                                                           #f #f #f
                                                          ',(for/vector ([i (in-range (struct-type-info-immediate-field-count sti))])
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
                                                      ,(struct-type-info-immediate-field-count sti)
                                                      0
                                                      ,(schemify (struct-type-info-parent sti))
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
       (define new-knowns
         (for/fold ([knowns knowns]) ([id (in-list ids)]
                                      [rhs (in-list rhss)])
           (if (lambda? rhs)
               (hash-set knowns id a-known-procedure)
               knowns)))
       (define body-schemify (make-schemify prim-knowns new-knowns mutated imports exports))
       (left-to-right/let
        `(let ,(for/list ([id (in-list ids)]
                          [rhs (in-list rhss)])
                 `[,id ,(schemify rhs)])
          ,@(map body-schemify bodys))
        prim-knowns knowns imports mutated)]
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
       (define new-knowns
         (for/fold ([knowns knowns]) ([id (in-list ids)]
                                      [rhs (in-list rhss)])
           (if (lambda? rhs)
               (hash-set knowns id a-known-procedure)
               knowns)))
       (define schemify (make-schemify prim-knowns new-knowns mutated imports exports))
       `(letrec* ,(for/list ([id (in-list ids)]
                             [rhs (in-list rhss)])
                    `[,id ,(schemify rhs)])
         ,@(map schemify bodys))]
      [`(letrec-values ([(,idss ...) ,rhss] ...) ,bodys ...)
       ;; Convert
       ;;  (letrec*-values ([(id ...) rhs] ...) ....)
       ;; to
       ;;  (letrec* ([vec (call-with-values rhs vector)]
       ;;            [id (vector-ref vec 0)]
       ;;            ... ...)
       ;;    ....)
       `(letrec* ,(apply
                   append
                   (for/list ([ids (in-list idss)]
                              [rhs (in-list rhss)])
                     (let ([rhs (schemify rhs)])
                       (cond
                        [(null? ids)
                         `([,(gensym "lr")
                            ,(make-let-values null rhs '(void))])]
                        [(and (pair? ids) (null? (cdr ids)))
                         `([,(car ids) ,rhs])]
                        [else
                         (define lr (gensym "lr"))
                         `([,lr ,(make-let-values ids rhs `(vector . ,ids))]
                           ,@(for/list ([id (in-list ids)]
                                        [pos (in-naturals)])
                               `[,id (vector-ref ,lr ,pos)]))]))))
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
       (and (not (hash-ref mutated id #f))
            (let ([im (hash-ref imports id #f)])
              (or (not im)
                  (known-constant? (hash-ref (import-group-knowns (import-grp im)) (import-ext-id im) #f)))))]
      [`(#%variable-reference)
       'instance-variable-reference]
      [`(#%variable-reference ,id)
       (define e (hash-ref exports id #f))
       (if e
           `(make-instance-variable-reference 
             instance-variable-reference
             ,e)
           `(make-instance-variable-reference 
             instance-variable-reference
             ,(if (hash-ref mutated v #f)
                  'mutable
                  'immutable)))]
      [`(,rator ,exps ...)
       (let ([args (map schemify exps)])
         (left-to-right/app
          (if (or (known-procedure? (hash-ref-either knowns imports rator))
                  (known-procedure? (hash-ref prim-knowns rator #f))
                  (lambda? rator))
              `(,(schemify rator) . ,args)
              `(#%app ,(schemify rator) . ,args))
          prim-knowns knowns imports mutated))]
      [`,_
       (cond
        [(and (symbol? v)
              (hash-ref mutated v #f)
              (hash-ref exports v #f))
         => (lambda (ex-id) `(variable-ref ,ex-id))]
        [(and (symbol? v)
              (hash-ref imports v #f))
         => (lambda (im) `(variable-ref ,(import-id im)))]
        [else v])])))

(define (mutated-in-body l exports prim-knowns knowns imports)
  ;; Find all `set!`ed variables, and also record all bindings
  ;; that might be used too early as 
  (define mutated (make-hasheq))
  ;; Defined names start out as 'not-ready; start with `exports`,
  ;; because anything exports but not defined is implicitly in an
  ;; undefined state:
  (for ([id (in-hash-keys exports)])
    (hash-set! mutated id 'not-ready))
  ;; Find all defined variables:
  (for ([form (in-list l)])
    (match form
      [`(define-values ,ids ,rhs)
       (for ([id (in-list ids)])
         (hash-set! mutated id 'not-ready))]
      [`,_ (void)]))
  ;; Walk through the body:
  (for/fold ([prev-knowns knowns]) ([form (in-list l)])
    ;; Accumulate known-binding information in this pass, because it's
    ;; helpful to know which variables are bound to constructors.
    ;; Note that we may tentatively classify a binding as a constructor
    ;; before discovering that its mutated via `set!`, but any use of
    ;; that information is correct, because it dynamically precedes
    ;; the `set!`
    (define knowns (find-definitions form prim-knowns prev-knowns imports mutated))
    (match form
      [`(define-values ,ids ,rhs)
       (find-mutated! rhs ids prim-knowns knowns imports mutated)
       ;; For any among `ids` that didn't get a delay and wasn't used
       ;; too early, the variable is now ready, so remove from
       ;; `mutated`:
       (for ([id (in-list ids)])
         (when (eq? 'not-ready (hash-ref mutated id #f))
           (hash-remove! mutated id)))]
      [`,_
       (find-mutated! form #f prim-knowns knowns imports mutated)])
    knowns)
  ;; For definitions that are not yet used, force delays:
  (for ([form (in-list l)])
    (match form
      [`(define-values ,ids ,rhs)
       (for ([id (in-list ids)])
         (define state (hash-ref mutated id #f))
         (when (delayed? state)
           (hash-remove! mutated id)
           (state)))]
      [`,_ (void)]))
  ;; Everything else in `mutated` is either 'set!ed, 'too-early, or unreachable:
  mutated)

(define (delayed? v) (procedure? v))

;; Schemify `let-values` to `let`, etc., and
;; reorganize struct bindings.
(define (find-mutated! v ids prim-knowns knowns imports mutated)
  (define (delay! ids thunk)
    (define done? #f)
    (for ([id (in-list ids)])
      (when (eq? 'not-ready (hash-ref mutated id 'not-ready))
        (hash-set! mutated id (lambda () (unless done?
                                      (set! done? #t)
                                      (thunk)))))))
  (let find-mutated! ([v v] [ids ids])
    (define (find-mutated!* l ids)
      (let loop ([l l])
        (cond
         [(null? l) (void)]
         [(null? (cdr l)) (find-mutated! (car l) ids)]
         [else (find-mutated! (car l) #f) (loop (cdr l))])))
    (match v
      [`(lambda ,formals ,body ...)
       (if ids
           (delay! ids (lambda () (find-mutated!* body #f)))
           (find-mutated!* body #f))]
      [`(case-lambda [,formalss ,bodys ...] ...)
       (if ids
           (delay! ids (lambda () (for ([body (in-list bodys)]) (find-mutated!* body #f))))
           (for ([body (in-list bodys)]) (find-mutated!* body #f)))]
      [`(quote ,_) (void)]
      [`(let-values ([,idss ,rhss] ...) ,bodys ...)
       (for ([ids (in-list idss)]
             [rhs (in-list rhss)])
         ;; an `id` in `ids` can't be referenced too early,
         ;; but it might usefully be delayed
         (find-mutated! rhs ids))
       (find-mutated!* bodys ids)]
      [`(letrec-values ([,idss ,rhss] ...) ,bodys ...)
       (for* ([ids (in-list idss)]
              [id (in-list ids)])
         (hash-set! mutated id 'not-ready))
       (for ([ids (in-list idss)]
             [rhs (in-list rhss)])
         (find-mutated! rhs ids)
         ;; Each `id` in `ids` is now ready (but might also hold a delay):
         (for ([id (in-list ids)])
           (when (eq? 'not-ready (hash-ref mutated id))
             (hash-remove! mutated id))))
       (find-mutated!* bodys ids)]
      [`(if ,tst ,thn ,els)
       (find-mutated! tst #f)
       (find-mutated! thn #f)
       (find-mutated! els #f)]
      [`(with-continuation-mark ,key ,val ,body)
       (find-mutated! key #f)
       (find-mutated! val #f)
       (find-mutated! body ids)]
      [`(begin ,exps ...)
       (find-mutated!* exps ids)]
      [`(begin0 ,exp ,exps ...)
       (find-mutated! exp ids)
       (find-mutated!* exps #f)]
      [`(set! ,id ,rhs)
       (hash-set! mutated id 'set!ed)
       (find-mutated! rhs #f)]
      [`(#%variable-reference . ,_) (void)]
      [`(,rator ,exps ...)
       (cond
        [(and ids
              (symbol? rator)
              (not (hash-ref mutated rator #f))
              (let ([v (hash-ref-either knowns imports rator)])
                (and (known-constructor? v)
                     (= (length exps) (known-constructor-field-count v))))
              (for/and ([exp (in-list exps)])
                (simple? exp prim-knowns knowns imports mutated)))
         ;; Can delay construction
         (delay! ids (lambda () (find-mutated!* exps #f)))]
        [else
         (find-mutated! rator #f)
         (find-mutated!* exps #f)])]
      [`,_
       (when (symbol? v)
         (define state (hash-ref mutated v #f))
         (cond
          [(eq? state 'not-ready)
           (hash-set! mutated v 'too-early)]
          [(delayed? state)
           (cond
            [ids
             ;; Chain delays
             (delay! ids (lambda ()
                           (hash-remove! mutated v)
                           (state)))]
            [else
             (hash-remove! mutated v)
             (state)])]))])))
