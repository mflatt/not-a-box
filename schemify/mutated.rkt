#lang racket/base
(require "match.rkt"
         "known.rkt"
         "import.rkt"
         "simple.rkt"
         "find-definition.rkt")

(provide mutated-in-body
         delayed?)

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
