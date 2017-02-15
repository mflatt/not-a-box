(load "struct.sls")
(load "equal.sls")
(import (struct)
        (equal))

(define (show v) (printf "~s\n" v) v)

(define-values (prop:x x? x-ref) (make-struct-type-property 'x))

(define-values (struct:a make-a a? a-ref a-set!)
  (make-struct-type 'x #f 2 0 #f (list (cons prop:x 5))))
(define-values (struct:b make-b b? b-ref b-set!)
  (make-struct-type 'b #f 2 0 #f (list
                                  (cons prop:equal+hash
                                        (list (lambda (o t eql?)
                                                (eql? (b-x o) (b-x t)))
                                              (lambda (o hc) 0)
                                              (lambda (o hc) 0))))))
(define b-x (make-struct-field-accessor b-ref 0 'x))
(define b-y (make-struct-field-accessor b-ref 1 'y))

(define an-a (make-a 1 2))
(define b1 (make-b 3 4))
(define b2 (make-b 3 4))

(time (let loop ([i 10000000] [v1 (make-b 3 4)] [v2 (make-b 3 4)])
        (cond
         [(= i 0) (list b1 b2)]
         [else (loop (sub1 i) (if (equal? v1 v2) v2 v1) v1)])))

         
(define-values (struct:p make-p p? p-ref p-set!)
  (make-struct-type 'x #f 2 0 #f (list (cons prop:procedure 0))))

(show (|#%app| (make-p (lambda (x) (cons x x)) 'whatever) 10))
