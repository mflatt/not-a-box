(top-level-program
 (import (rename (except (chezscheme)
                         member memv memq
                         sort vector-sort vector-sort!
                         filter force delay identifier?
                         equal? read-char peek-char
                         close-output-port open-input-file
                         make-input-port make-output-port
                         close-input-port
                         error)
                 [make-parameter chez:make-parameter])
         (regexp)
         (error)
         (hash)
         (immutable-hash)
         (bytes)
         (hash-code)
         (equal)
         (struct)
         (path)
         (port))
 (define-syntax begin0
   (syntax-rules ()
     [(_ expr0 expr ...)
      (let ([l (call-with-values (lambda () expr0) list)])
        expr ...
        (apply values l))]))
 (include "compat.scm")
 (include "expander.scm"))
