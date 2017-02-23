(import (expander)
        (port))

(define (show v) (write v) (newline))

(boot)
(namespace-require ''|#%kernel|)
(show (expand '1))
(show (eval '((lambda (x) x) 1)))
(show (eval '(module m '|#%kernel|
              (define-values (x) 'ex)
              (|#%provide| x))))
(show (eval '(|#%require| 'm)))
(show (eval 'x))


