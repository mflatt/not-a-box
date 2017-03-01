#lang racket/base
(require racket/pretty
         "schemify.rkt"
         "known.rkt")

(define prim-knowns
  ;; Register primitives
  (let ([ns (make-base-namespace)])
    (parameterize ([current-namespace ns])
      (namespace-require 'racket/unsafe/ops)
      (namespace-require 'racket/flonum)
      (namespace-require 'racket/fixnum))
    (for/hasheq ([s (in-list (namespace-mapped-symbols ns))]
                 #:when (with-handlers ([exn:fail? (lambda (x) #f)])
                          (procedure? (eval s ns))))
      (values s a-known-procedure))))

(define-values (schemified info)
  (schemify-linklet '(linklet  () () 5)
                    #;
                    '(linklet 
                      ()
                      ()
                      (define-values (struct:s make-s s? s-ref s-set!)
                        (make-struct-type 's #f 2 0 #f))
                      (define-values (y) (make-s (lambda () x) 5))
                      (define-values (x) (lambda () y))
                      (define-values (done) 'done))
                    #;
                    (call-with-input-file "regexp.rktl" read)
                    prim-knowns
                    (lambda args #hasheq())))

(pretty-print schemified)
