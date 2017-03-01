#lang racket/base
(require "match.rkt"
         "known.rkt"
         "import.rkt")

(provide simple?
         delayed?)

;; To recognize delayed mutated info:
(define (delayed? v) (procedure? v))

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
