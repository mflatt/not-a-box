(import (expander))

(define (show v) (write v) (newline))

(boot)
(namespace-require ''|#%kernel|)
(show (expand '1))
(show (eval '((lambda (x) x) 1)))
