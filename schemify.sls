(library (schemify)
  (export schemify-linklet
          schemify-body
          prim-knowns)
  (import (rename (except (chezscheme)
                          apply procedure?
                          list? equal? read-char
                          close-input-port close-output-port
                          make-input-port make-output-port
                          open-input-file peek-char
                          error make-parameter input-port? output-port?
                          current-input-port current-output-port current-error-port
                          open-input-string open-output-string get-output-string
                          format printf fprintf
                          write display newline port-name
                          string-copy! substring
                          gensym symbol->string
                          date? make-date date-second date-minute date-hour date-day date-month date-year
                          date-week-day date-year-day)
                  [void chez:void])
          (core)
          (regexp)
          (port)
          (known-primitive))

  (include "schemify.scm")

  (define (add-known ht syms extract known)
    (let loop ([ht ht] [syms syms])
      (cond
       [(null? syms) ht]
       [else (loop (hash-set ht
                             (extract (car syms))
                             (if (procedure? known)
                                 (known (car syms))
                                 known))
                   (cdr syms))])))

  (define prim-knowns
    (add-known
     (add-known
      (add-known
       (add-known (hasheq) known-procedures (lambda (s) s) a-known-procedure)
       known-struct-type-property/immediate-guards (lambda (s) s)
       a-known-struct-type-property/immediate-guard)
      known-constructors car
      (lambda (s) (known-constructor (car s) (cadr s))))
     known-constants (lambda (x) x)
     a-known-constant)))
