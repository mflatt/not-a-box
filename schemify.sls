(library (schemify)
  (export schemify-linklet
          schemify-body
          primitive-procs)
  (import (rename (except (chezscheme)
                          apply procedure?
                          equal? read-char
                          close-input-port close-output-port
                          make-input-port make-output-port
                          open-input-file peek-char
                          error make-parameter input-port? output-port?
                          current-input-port current-output-port current-error-port
                          open-input-string open-output-string get-output-string
                          format printf fprintf
                          write display newline port-name
                          string-copy! substring
                          date? make-date date-second date-minute date-hour date-day date-month date-year
                          date-week-day date-year-day)
                  [void chez:void])
          (core)
          (regexp)
          (port)
          (primitive-procs))

  (define primitive-procs
    (let loop ([ht (hasheq)] [l primitive-proc-list])
      (cond
       [(null? l) ht]
       [else (loop (hash-set ht (car l) #t)
                   (cdr l))])))

  (include "schemify.scm"))
