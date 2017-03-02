(define string-copy!
  (case-lambda
   [(dest dest-start src)
    (unless (and (string? dest) (unsafe-mutable? dest))
      (raise-argument-error 'string-set! "(and/c string? (not/c immutable?))" dest))
    (chez:string-copy! src 0 dest dest-start
                       (if (string? src) (string-length src) 0))]
   [(dest dest-start src src-start)
    (unless (and (string? dest) (unsafe-mutable? dest))
      (raise-argument-error 'string-set! "(and/c string? (not/c immutable?))" dest))
    (chez:string-copy! src src-start dest dest-start
                       (if (and (string? src) (number? src-start))
                           (- (string-length src) src-start)
                           0))]
   [(dest dest-start src src-start src-end)
    (unless (and (string? dest) (unsafe-mutable? dest))
      (raise-argument-error 'string-set! "(and/c string? (not/c immutable?))" dest))
    (chez:string-copy! src src-start dest dest-start
                       (if (and (number? src-start) (number? src-end))
                           (- src-end src-start)
                           0))]))

(define (string-set! s pos c)
  (unless (and (string? s) (unsafe-mutable? s))
    (raise-argument-error 'string-set! "(and/c string? (not/c immutable?))" s))
  (chez:string-set! s pos c))

(define (string->immutable-string x) x)

(define substring
  (case-lambda
   [(s start) (chez:substring s start (if (string? s) (string-length s) 0))]
   [(s start end) (chez:substring s start end)]))
