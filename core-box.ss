(define box-immutable box)
         
(define (box-cas! b v1 v2)
  (and (eq? v1 (unbox b))
       (set-box! b v2)
       #t))

(define (make-weak-box v) (weak-cons v #t))

(define (weak-box? v) (weak-pair? v))

(define (weak-box-value v)
  (unless (weak-pair? v)
    (raise-argument-error 'weak-box-value "weak-box?" v))
  (let ([c (car v)])
    (if (eq? c #!bwp)
        #f
        c)))
