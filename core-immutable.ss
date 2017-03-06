
(define immutables (make-weak-eq-hashtable))

(define (immutable? v)
  (or (immutable? v)
      (and (or (string? v)
               (bytes? v)
               (vector? v)
               (box? v))
           (hashtable-ref immutables v #f))))

(define (unsafe-immutable? v)
  (hashtable-ref immutables v #f))

(define (unsafe-mutable? v)
  (not (unsafe-immutable? v)))

(define (set-immutable! v)
  (hashtable-set! immutables v #t))
