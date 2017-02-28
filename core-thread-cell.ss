
(define-record thread-cell (value))

(define (thread-cell-ref c)
  (thread-cell-value c))

(define (thread-cell-set! c v)
  (set-thread-cell-value! c v))
