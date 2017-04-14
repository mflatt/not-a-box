;; A "thread cell" is actually an "engine cell" at the core level

;; FIXME: need emphemerons for weak mapping

(define-record-type (thread-cell create-thread-cell thread-cell?)
  (fields default-value per-engine-value))

(define (make-thread-cell v)
  (create-thread-cell v (make-weak-eq-hashtable)))

(define (thread-cell-ref c)
  (unless (thread-cell? c)
    (raise-argument-error 'thread-cell-ref "thread-cell?" c))
  (let ([v (hashtable-ref (thread-cell-per-engine-value c)
                          (current-engine-identity)
                          none)])
    (cond
     [(eq? v none)
      (thread-cell-default-value c)]
     [else v])))

(define (thread-cell-set! c v)
  (unless (thread-cell? c)
    (raise-argument-error 'thread-cell-set! "thread-cell?" c))
  (hashtable-set! (thread-cell-per-engine-value c)
                  (current-engine-identity)
                  v))
