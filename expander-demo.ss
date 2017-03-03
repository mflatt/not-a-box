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
  (show (eval (read (open-input-string s)))))
;; (run "'x")

;; Set `LINKLET_RACKET` to a built linklet-branch Racket checkout
;; to allow a `racket/base` load to possibly succeed
(when (getenv "LINKLET_RACKET")
  (current-library-collection-links
   (find-library-collection-links))
  (current-library-collection-paths
   (find-library-collection-paths))
  
  (time (eval '(|#%require| racket/base)))

  ;;(time (eval `(|#%require| (file ,(string-append (getenv "LINKLET_RACKET") "/pkgs/regexp/demo.rkt")))))
  (time (eval `(|#%require| (file ,(string-append (getenv "LINKLET_RACKET") "/pkgs/expander/main.rkt")))))
  
  )
