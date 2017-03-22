;; locking code for core-hash.ss

;; https://lwn.net/Articles/590243/
;; Synchronization Without Contention Mellor-Crummey Scott (MCS lock)
;; eventually 
#|
(define-record mcs-spinlock (next locked?))

(define (create-mcs-spinlock) (make-mcs-spinlock #f #f))
|#

(define (make-lock)
  (make-mutex))

(define (lock-acquire lock)
  (mutex-acquire lock))

(define (lock-release lock)
  (mutex-release lock))
