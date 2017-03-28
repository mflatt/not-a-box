(library (expander)
  (export (rename (1/module-path-index? module-path-index?)
                  (1/identifier-binding identifier-binding)
                  (1/module-declared? module-declared?)
                  (1/bound-identifier=? bound-identifier=?)
                  (1/module-path? module-path?)
                  (seal seal)
                  (1/syntax-shift-phase-level syntax-shift-phase-level)
                  (embedded-load embedded-load)
                  (1/syntax->datum syntax->datum)
                  (1/dynamic-require dynamic-require)
                  (1/namespace-attach-module-declaration namespace-attach-module-declaration)
                  (make-namespace make-namespace)
                  (1/resolved-module-path? resolved-module-path?)
                  (boot boot)
                  (1/current-namespace current-namespace)
                  (expand$1 expand)
                  (1/namespace-mapped-symbols namespace-mapped-symbols)
                  (1/namespace-attach-module namespace-attach-module)
                  (compile-to-linklets compile-to-linklets)
                  (1/module-compiled-indirect-exports module-compiled-indirect-exports)
                  (1/read-accept-compiled read-accept-compiled)
                  (datum->kernel-syntax datum->kernel-syntax)
                  (identifier? identifier?)
                  (1/syntax-e syntax-e)
                  (1/syntax-debug-info syntax-debug-info)
                  (namespace->instance namespace->instance)
                  (1/namespace-module-identifier namespace-module-identifier)
                  (1/eval eval)
                  (1/namespace-require namespace-require)
                  (maybe-syntax->datum maybe-syntax->datum)
                  (maybe-raise-missing-module maybe-raise-missing-module)
                  (syntax?$1 syntax?)
                  (1/read read)
                  (1/module-compiled-exports module-compiled-exports)
                  (1/module-path-index-join module-path-index-join)
                  (1/read-syntax read-syntax)
                  (syntax-property$1 syntax-property)
                  (1/module->language-info module->language-info)
                  (1/namespace-syntax-introduce namespace-syntax-introduce)
                  (1/compile compile)
                  (1/datum->syntax datum->syntax))
          find-library-collection-links
          current-library-collection-links
          current-library-collection-paths
          find-library-collection-paths
          flush)
  (import (rename (except (chezscheme)
                          apply procedure?
                          member memv memq
                          sort vector-sort vector-sort!
                          filter force delay identifier?
                          read-char peek-char
                          close-output-port open-input-file open-output-file
                          make-input-port make-output-port
                          close-input-port
                          error current-eval
                          open-input-file
                          error make-parameter
                          current-input-port current-output-port
                          open-input-string open-output-string get-output-string
                          with-input-from-file with-output-to-file
                          call-with-input-file call-with-output-file
                          format printf
                          write display newline
                          list? input-port? output-port? port-name
                          procedure? apply
                          string-copy! substring
                          gensym symbol->string
                          date? make-date date-second date-minute date-hour date-day date-month date-year
                          date-week-day date-year-day
                          open-input-output-file
                          void sleep random
                          dynamic-wind
                          call-with-current-continuation)
                  [fprintf chez:fprintf]
                  [current-error-port chez:current-error-port]
                  [string->number chez:string->number]
                  [file-exists? chez:file-exists?]
                  [directory-list chez:directory-list])
          (rename (core)
                  ;; These names are not public primitives, so "expander.scm"
                  ;; can define them:
                  [correlated? core:correlated?]
                  [correlated-source core:correlated-source]
                  [correlated-line core:correlated-line]
                  [correlated-column core:correlated-column]
                  [correlated-position core:correlated-position]
                  [correlated-span core:correlated-span]
                  [correlated-e core:correlated-e]
                  [correlated->datum core:correlated->datum]
                  [datum->correlated core:datum->correlated]
                  [correlated-property core:correlated-property]
                  [correlated-property-symbol-keys core:correlated-property-symbol-keys])
          (regexp)
          (port)
          (linklet))
  (include "expander-compat.scm")
  (include "expander.scm")
  (fill-environment!))
