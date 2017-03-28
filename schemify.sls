(library (schemify)
  (export schemify-linklet
          schemify-body
          prim-knowns)
  (import (rename (except (chezscheme)
                          apply procedure?
                          list? read-char
                          close-input-port close-output-port
                          make-input-port make-output-port
                          open-input-file open-output-file peek-char
                          error make-parameter input-port? output-port?
                          current-input-port current-output-port current-error-port
                          open-input-string open-output-string get-output-string
                          with-input-from-file with-output-to-file
                          call-with-input-file call-with-output-file
                          format printf fprintf
                          write display newline port-name
                          string-copy! substring
                          gensym symbol->string
                          set-box!
                          date? make-date date-second date-minute date-hour date-day date-month date-year
                          date-week-day date-year-day
                          random
                          dynamic-wind
                          call-with-current-continuation)
                  [void chez:void])
          (rename (core)
                  [correlated? core:correlated?]
                  [correlated-e core:correlated-e])
          (regexp)
          (port)
          (known-primitive))
  
  ;; Bridge for flattened "schemify/wrap.rkt":
  (define (primitive-table kernel)
    (hash 'syntax? core:correlated?
          'syntax-e core:correlated-e))

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
