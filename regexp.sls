(library (regexp)
  (export (rename (1/byte-regexp byte-regexp)
                  (1/byte-regexp? byte-regexp?)
                  (1/regexp regexp)
                  (1/regexp-match-peek-positions-immediate/end regexp-match-peek-positions-immediate/end)
                  (1/regexp-match-peek-positions-immediate regexp-match-peek-positions-immediate)
                  (1/regexp-match-peek-positions regexp-match-peek-positions)
                  (1/regexp-max-lookbehind regexp-max-lookbehind)
                  (1/regexp-match/end regexp-match/end)
                  (1/regexp-match-peek regexp-match-peek)
                  (1/regexp-replace* regexp-replace*)
                  (1/pregexp pregexp)
                  (1/regexp-match-positions/end regexp-match-positions/end)
                  (1/regexp-match-peek-immediate regexp-match-peek-immediate)
                  (1/regexp-match? regexp-match?)
                  (1/regexp-match-positions regexp-match-positions)
                  (1/regexp-replace regexp-replace)
                  (1/pregexp? pregexp?)
                  (1/regexp-match-peek-positions/end regexp-match-peek-positions/end)
                  (1/regexp? regexp?)
                  (1/regexp-match regexp-match)
                  (1/byte-pregexp byte-pregexp)
                  (1/byte-pregexp? byte-pregexp?)))
  (import (rename (except (chezscheme)
                          apply procedure?
                          read-char
                          close-input-port close-output-port
                          make-input-port make-output-port
                          open-input-file open-output-file peek-char
                          error make-parameter
                          input-port? output-port?
                          current-input-port current-output-port current-error-port
                          open-input-string open-output-string get-output-string
                          with-input-from-file with-output-to-file
                          call-with-input-file call-with-output-file
                          format printf fprintf
                          write display newline port-name
                          list? string-copy! substring string-set!
                          gensym symbol->string
                          set-box! vector-set!
                          date? make-date date-second date-minute date-hour date-day date-month date-year
                          date-week-day date-year-day
                          random)
                  [void chez:void])
          (core)
          (port))
  (define (char-graphic? x) #f)
  (define (make-continuation-prompt-tag s) (gensym))
  (define (call-with-continuation-prompt proc . args) (proc))
  (define (abort-current-continuation . args)
    (error 'abort-current-continuation "fixme"))
  (include "regexp.scm"))
