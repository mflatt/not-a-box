(import (linklet))

(define l1 (compile-linklet
            '(linklet 
              (import)
              (export f x)
              (define-values (f) (lambda (y) (add1 y)))
              (define-values (x) 5)
              'done)
            'l1))

(define l2 (compile-linklet
            '(linklet 
              (import (f x))
              (export)
              (display (f x))
              (newline))))

(instantiate-linklet l2 (list (instantiate-linklet l1 null)))
