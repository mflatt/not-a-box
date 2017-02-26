(define vector-copy!
  (case-lambda
   [(dest dest-start src)
    (vector-copy! dest dest-start src 0
                  (if (vector? src) (vector-length src) 0))]
   [(src src-start dest dest-start)
    (vector-copy! dest dest-start src src-start
                  (if (vector? src) (vector-length src) 0))]
   [(dest dest-start src src-start src-end)
    (let loop ([i (- src-end src-start)])
      (unless (zero? i)
        (let ([i (sub1 i)])
          (vector-set! dest (+ dest-start i) (vector-ref src (+ src-start i)))
          (loop i))))]))

(define vector-immutable vector)
(define (vector->immutable-vector x) x)
