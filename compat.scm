
(define-syntax begin0
  (syntax-rules ()
    [(_ expr0 expr ...)
     (let ([l (call-with-values (lambda () expr0) list)])
       expr ...
       (apply values l))]))

(define null '())
(define eof #!eof)

(define (void . args) (chez:void))
(define (void? v) (eq? v (chez:void)))

(define (exact-integer? n) (and (integer? n) (exact? n)))
(define (exact-nonnegative-integer? n) (and (exact-integer? n) (>= n 0)))
(define (exact-positive-integer? n) (and (exact-integer? n) (> n 0)))
(define (byte? n) (and (exact-integer? n) (>= n 0) (<= n 255)))

(define (procedure-arity-includes? p n) #t)

(define arithmetic-shift bitwise-arithmetic-shift)

(define unsafe-car #3%car)
(define unsafe-cdr #3%cdr)
(define unsafe-list-tail #3%list-tail)
(define unsafe-list-ref #3%list-ref)

(define unsafe-fl< #3%fl<)
(define unsafe-fl> #3%fl>)
(define unsafe-fl= #3%fl=)
(define unsafe-fl<= #3%fl<=)
(define unsafe-fl>= #3%fl>=)
(define unsafe-fl+ #3%fl+)
(define unsafe-fl- #3%fl-)
(define unsafe-fx< #3%fx<)
(define unsafe-fx> #3%fx>)
(define unsafe-fx>= #3%fx>=)
(define unsafe-fx+ #3%fx+)
(define unsafe-fx- #3%fx-)
(define unsafe-fx= #3%fx=)
(define unsafe-fx<= #3%fx<=)
(define unsafe-fxrshift fxarithmetic-shift-right)
(define unsafe-fxlshift fxarithmetic-shift-left)

(define vector-copy!
  (case-lambda
   [(dest d-start src) (vector-copy! dest d-start src 0 (vector-length src))]
   [(dest d-start src s-start) (vector-copy! dest d-start src s-start (vector-length src))]
   [(dest d-start src s-start s-end)
    (let loop ([i (- s-end s-start)])
      (unless (zero? i)
        (let ([i (sub1 i)])
          (vector-set! dest (+ d-start i) (vector-ref src (+ s-start i)))
          (loop i))))]))

(define unsafe-vector-length #3%vector-length)
(define unsafe-vector*-length #3%vector-length)
(define unsafe-vector-ref #3%vector-ref)
(define unsafe-vector*-ref #3%vector-ref)
(define unsafe-vector-set! #3%vector-set!)
(define unsafe-vector*-set! #3%vector-set!)

(define vector-immutable vector)
(define (vector->immutable-vector x) x)

(define unsafe-bytes-length #3%bytevector-length)
(define unsafe-bytes-ref #3%bytevector-u8-ref)
(define unsafe-bytes-set! #3%bytevector-u8-set!)

(define unsafe-string-length #3%string-length)
(define unsafe-string-ref #3%string-ref)
(define unsafe-string-set! #3%string-set!)
(define (string->immutable-string x) x)

(define unsafe-fxvector-ref #3%fxvector-ref)
(define unsafe-fxvector-set! #3%fxvector-set!)
