(import (linklet))

(pretty-print
 (compile-linklet '(linklet 
                    (import)
                    (export x g)
                    (define-values (f) (lambda () (g)))
                    (define-values (n) (random))
                    (define-values (g) (lambda () (f)))
                    (define-values (x) 5)
                    'done)))

