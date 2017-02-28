(import (expander)
        (port))

(define (show v) (write v) (newline))

(boot)

(namespace-require ''|#%kernel|)
(expand '1)
(eval '((lambda (x) x) 1))

(eval '(module m '|#%kernel|
        (|#%require| (for-syntax '|#%kernel|))
        (define-syntaxes (m)
          (lambda (stx)
            (quote-syntax 'ex)))
        (define-values (x) (m))
        (|#%provide| x)))
(eval '(|#%require| 'm))
(eval 'x)

(define (run s)
  (eval (read (open-input-string s))))
(run "'x")

;; Set `AS_IF_RACKET` to a linklet-branch Racket executable's
;; path to allow a `racket/base` load to possibly succeed
(current-library-collection-links
 (find-library-collection-links))
(current-library-collection-paths
 (find-library-collection-paths))
(time (eval '(|#%require| racket/base)))
