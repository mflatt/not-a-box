(import (core))

(define-syntax time
  (syntax-rules ()
    [(_ expr1 expr ...)
     (let-values ([(v cpu user gc) (time-apply (lambda () expr1 expr ...) null)])
       (printf "cpu time: ~s real time: ~s gc time: ~s\n" cpu user gc)
       (apply values v))]))

(define l (values (let loop ([i 1000])
		    (if (zero? i)
			'()
			(cons i (loop (sub1 i)))))))

(printf "large sets\n")
(time
 (let loop ([j 1000])
   (define numbers
     (let loop ([s (seteqv)] [l l])
       (if (null? l)
           s
           (loop (set-add s (car l)) (cdr l)))))
   (unless (zero? j)
     (let loop ([v #f] [i 1000])
       (if (zero? i)
           v
           (loop (set-member? numbers i) (sub1 i))))
     (loop (sub1 j)))))
(time
 (let loop ([j 1000])
   (define numbers
     (let loop ([s (seteq)] [l l])
       (if (null? l)
           s
           (loop (set-add s l) (cdr l)))))
   (unless (zero? j)
     (let loop ([v #f] [l l])
       (if (null? l)
           v
           (loop (set-member? numbers l) (cdr l))))
     (loop (sub1 j)))))

(printf "small tables\n")
(time
 (let loop ([j 100000])
   (define numbers
     (let loop ([s (seteqv)] [i 10])
       (if (zero? i)
           s
           (loop (set-add s i) (sub1 i)))))
   (define numbers2
     (let loop ([s (seteqv)] [i 10])
       (if (zero? i)
           s
           (loop (set-add s i) (sub1 i)))))
   (unless (zero? j)
     (let loop ([v #f] [i 10])
       (if (zero? i)
           v
           (and (subset? numbers numbers2)
                (loop (set-member? numbers i) (sub1 i)))))
     (loop (sub1 j)))))
