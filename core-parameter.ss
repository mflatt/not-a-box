
;; Continuation-mark key:
(define parameterization-key (gensym "parameterization-key"))

(define-record parameterization (ht))

(define empty-parameterization (make-parameterization empty-hasheq))

(define (extend-parameterization p . args)
  (let loop ([ht (parameterization-ht p)] [args args])
    (cond
     [(null? args) (make-parameterization ht)]
     [else (loop (immutable-hash-set ht (car args) (make-thread-cell (cadr args)))
                 (cddr args))])))

(define (parameter-cell key)
  (immutable-hash-ref
   (parameterization-ht
    (continuation-mark-set-first
     #f
     parameterization-key
     empty-parameterization))
   key
   #f))

(define make-parameter
  (case-lambda
    [(v) (make-parameter v #f)]
    [(v guard)
     (let ([default-c (make-thread-cell v)])
       (define self
         (case-lambda
           [()
            (let ([c (or (parameter-cell self)
                         default-c)])
              (thread-cell-ref c))]
           [(v)
            (let ([c (or (parameter-cell self)
                         default-c)])
              (thread-cell-set! c (if guard
                                      (guard v)
                                      v)))]))
       self)]))
