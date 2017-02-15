(load "hash.sls")

(top-level-program
 (import (chezscheme)
         (hash))

 (define (show v) (write v) (newline))

 (define ht (hash 'a 1 'b 2))
 (show (hash-ref ht 'a))
 (show (hash-ref ht 'b))

 (show (hash-keys-subset? ht ht))
 (show (hash-keys-subset? (hash-remove ht 'a) ht))
 (show (hash-keys-subset? (hash-remove ht 'b) ht))
 (show (hash-keys-subset? (hash-remove ht 'b) (hash-remove ht 'a)))

 (define (gen)
   (cons (random 1000)
         (if (zero? (random 4))
             '()
             (gen))))

 ;; find colliding keys:
 (define-values (k1 k2)
   (let loop ()
     (define l1 (gen))
     (define l2 (gen))
     (if (and (not (equal? l1 l2))
              (equal? (equal-hash l1) (equal-hash l2)))
         (values l1 l2)
         (loop))))

 (show (hash-ref (hash k1 1 k2 2) k1))
 (show (hash-ref (hash k1 1 k2 2) k2))
 (show (hash-keys-subset? (hash k1 1) (hash k1 1 k2 2)))
 (show (hash-keys-subset? (hash 'a 3 'b 5 k1 1 k2 2) (hash 'a 3 k1 1 'b 4 k2 2)))

 (define ht-i
   (let loop ([ht (hash)] [i 1000000])
     (if (= i 0)
         ht
         (loop (hash-set ht i i) (sub1 i)))))

 (show
  (time
   (let loop ([i (hash-iterate-first ht-i)] [n 0])
     (cond
      [i
       (unless (= (hash-iterate-value ht-i i)
                  (hash-ref ht-i (hash-iterate-key ht-i i)))
         (error 'loop "wrong"))
       (loop (hash-iterate-next ht-i i) (add1 n))]
      [else n])))))

