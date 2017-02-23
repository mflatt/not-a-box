(library (schemify)
  (export schemify-linklet
          schemify-body
          primitive-procs)
  (import (rename (except (chezscheme)
                          read-char
                          close-input-port close-output-port
                          make-input-port make-output-port
                          open-input-file peek-char
                          error make-parameter input-port? output-port?
                          current-input-port current-output-port current-error-port
                          open-input-string open-output-string get-output-string
                          format printf fprintf
                          write display newline)
                  [void chez:void])
          (hash)
          (error)
          (struct)
          (regexp)
          (bytes)
          (port)
          (primitive-procs))

  (define primitive-procs
    (let loop ([ht (hasheq)] [l primitive-proc-list])
      (cond
       [(null? l) ht]
       [else (loop (hash-set ht (car l) #t)
                   (cdr l))])))

  (include "compat.scm")
  (define (current-inspector) #f)

  (include "schemify.scm"))
