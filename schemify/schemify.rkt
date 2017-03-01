#lang racket/base
(require "match.rkt"
         "known.rkt"
         "import.rkt"
         "struct-type-info.rkt"
         "simple.rkt"
         "find-definition.rkt"
         "mutated.rkt"
         "mutated-state.rkt"
         "left-to-right.rkt")

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
;;     possible, and accept values instead of `variable`s for constant
;;     imports;
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
;;   - optimize away `variable-reference-constant?` uses, which is
;;     important to make keyword-argument function calls work directly
;;     without keywords;
;;
;;   - simplify `define-values` and `let-values` to `define` and
;;     `let`, when possible, and generally avoid `let-values`.

;; Returns (values schemified-linklet import-abi export-info)
;; An import ABI is a list of list of booleans, parallel to the
;; linklet imports, where #t to means that a value is expected, and #f
;; means that a variable (which boxes a value) is expected
(define (schemify-linklet lk prim-knowns get-import-knowns)
  (define (im-int-id id) (if (pair? id) (cadr id) id))
  (define (im-ext-id id) (if (pair? id) (car id) id))
  (define (ex-int-id id) (if (pair? id) (car id) id))
  (define (ex-ext-id id) (if (pair? id) (cadr id) id))
  ;; For imports, map symbols to gensymed `variable` argument names:
  (define imports
    (for/fold ([imports (hasheq)]) ([im-ids (in-list (cadr lk))]
                                    [index (in-naturals)])
      (define grp (import-group (lambda () (get-import-knowns index))))
      (for/fold ([imports imports]) ([im-id (in-list im-ids)])
        (define id (im-int-id im-id))
        (define ext-id (im-ext-id im-id))
        (hash-set imports id (import grp (gensym (symbol->string id)) ext-id)))))
  ;; Ditto for exports:
  (define exports
    (for/fold ([exports (hasheq)]) ([ex (in-list (caddr lk))])
      (define id (if (pair? ex) (car ex) ex))
      (hash-set exports id (gensym (symbol->string id)))))
  ;; Schemify the body, collecting information about defined names:
  (define-values (new-body defn-info mutated)
    (schemify-body* (cdddr lk) prim-knowns imports exports))
  (values
   ;; Build `lambda` with schemified body:
   `(lambda (instance-variable-reference
        ,@(for*/list ([ims (in-list (cadr lk))]
                      [im (in-list ims)])
            (import-id (hash-ref imports (im-int-id im))))
        ,@(for/list ([ex (in-list (caddr lk))])
            (hash-ref exports (ex-int-id ex))))
     ,@new-body)
   ;; Import ABI: request values for constants, `variable`s otherwise
   (for/list ([ims (in-list (cadr lk))])
     (define im-knowns (and (pair? ims)
                            (let ([k/t (import-group-knowns/thunk
                                        (import-grp
                                         (hash-ref imports (im-int-id (car ims)))))])
                              (if (procedure? k/t) #f k/t))))
     (for/list ([im (in-list ims)])
       (and im-knowns
            (known-constant? (hash-ref im-knowns (im-ext-id im) #f)))))
   ;; Convert internal to external identifiers
   (for/fold ([knowns (hasheq)]) ([ex (in-list (caddr lk))])
     (define id (ex-int-id ex))
     (define v (hash-ref defn-info id #f))
     (cond
      [(and v
            (not (set!ed-mutated-state? (hash-ref mutated id #f))))
       (define ext-id (ex-ext-id id))
       (hash-set knowns ext-id v)]
      [else knowns]))))

;; ----------------------------------------

(define (schemify-body l prim-knowns imports exports)
  (define-values (new-body defn-info mutated)
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
      (define-values (new-knowns info)
        (find-definitions form prim-knowns knowns imports mutated))
      new-knowns))
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
        (define schemified (schemify prim-knowns knowns mutated imports exports form))
        (match form
          [`(define-values ,ids ,_)
           (append
            (make-expr-defns accum-exprs)
            (cons
             schemified 
             (let id-loop ([ids ids] [accum-exprs null] [accum-ids accum-ids])
               (cond
                [(null? ids) (loop (cdr l) accum-exprs accum-ids)]
                [(via-variable-mutated-state? (hash-ref mutated (car ids) #f))
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
  (values schemified knowns mutated))

(define (make-set-variable id exports)
  (define ex-var (hash-ref exports id))
  `(variable-set! ,ex-var ,id))

(define (make-expr-defns accum-exprs)
  (for/list ([expr (in-list (reverse accum-exprs))])
    `(define ,(gensym) ,expr)))

;; ----------------------------------------

;; Schemify `let-values` to `let`, etc., and
;; reorganize struct bindings.
(define (schemify prim-knowns knowns mutated imports exports v)
  (let schemify/knowns ([knowns knowns] [v v])
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
                          (make-struct-type-info mk prim-knowns knowns imports mutated)))
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
         (left-to-right/let
          `(let ,(for/list ([id (in-list ids)]
                            [rhs (in-list rhss)])
                   `[,id ,(schemify rhs)])
            ,@(for/list ([body (in-list bodys)])
                (schemify/knowns new-knowns body)))
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
         `(letrec* ,(for/list ([id (in-list ids)]
                               [rhs (in-list rhss)])
                      `[,id ,(schemify/knowns new-knowns rhs)])
           ,@(for/list ([body (in-list bodys)])
               (schemify/knowns new-knowns body)))]
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
                    (known-constant? (import-lookup im)))))]
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
            (if (or (and (known-procedure? (hash-ref-either knowns imports rator))
                         (not (hash-ref mutated rator #f)))
                    (known-procedure? (hash-ref prim-knowns rator #f))
                    (lambda? rator))
                `(,(schemify rator) . ,args)
                `(#%app ,(schemify rator) . ,args))
            prim-knowns knowns imports mutated))]
        [`,_
         (cond
          [(and (symbol? v)
                (via-variable-mutated-state? (hash-ref mutated v #f))
                (hash-ref exports v #f))
           => (lambda (ex-id) `(variable-ref ,ex-id))]
          [(and (symbol? v)
                (hash-ref imports v #f))
           => (lambda (im)
                (if (known-constant? (import-lookup im))
                    ;; Not boxed:
                    (import-id im)
                    ;; Will be boxed, but won't be undefined (because the
                    ;; module system won't link to an instance whose
                    ;; definitions didn't complete):
                    `(variable-ref/no-check ,(import-id im))))]
          [else v])]))))
