(library (schemify)
  (export schemify-linklet
          schemify-body
          primitive-procs)
  (import (except (chezscheme)
                  error)
          (hash)
          (error)
          (struct)
          (regexp)
          (bytes)
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
