(import (expander)
        (port))

(define (show v) (write v) (newline))

(boot)
(namespace-require ''|#%kernel|)
(show (expand '1))
(show (eval '((lambda (x) x) 1)))
(eval '(module m '|#%kernel|
        (|#%require| (for-syntax '|#%kernel|))
        (define-syntaxes (m)
          (lambda (stx)
            (quote-syntax 'ex)))
        (define-values (x) (m))
        (|#%provide| x)))
(eval '(|#%require| 'm))
(show (eval 'x))


