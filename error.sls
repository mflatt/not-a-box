(library (error)
  (export error
          raise-argument-error
          raise-arguments-error
          raise-result-error
          raise-mismatch-error
          raise-range-error)
  (import (rename (chezscheme)
                  [error chez:error]))

  (define (error init . args)
    (cond
     [(null? args)
      (cond
       [(symbol? init)
        (error 'error (format "~s" init))]
       [(string? init)
        (error 'error init)]
       [else
        (raise-argument-error 'error "(or/c symbol? string?)" init)])]
     [(symbol? init)
      (unless (string? (car args))
        (raise-argument-error 'error "string?" (car args)))
      (error init (apply format args))]
     [(string? init)
      (error 'error (apply string-append
                           init
                           (let loop ([args args])
                             (cond
                              [(null? args) '()]
                              [else (cons (format " ~s" (car args))
                                          (loop (cdr args)))]))))]
     [else
      (raise-argument-error 'error "(or/c symbol? string?)" init)]))

  (define (raise-argument-error who what arg)
    (error who
           "contract violation\n  expected: ~a\n  given: ~s"
           what arg))

  (define (raise-result-error who what arg)
    (error who
           "contract violation\n  expected: ~a\n  result: ~s"
           what arg))

  (define (raise-arguments-error who what . more)
    (error who (apply
                string-append
                what
                (let loop ([more more])
                  (cond
                   [(null? more) '()]
                   [(string? (car more))
                    (cond
                     [(null? more)
                      (raise-arguments-error 'raise-arguments-error
                                             "missing value after field string"
                                             "string"
                                             (car more))]
                     [else
                      (cons (format "\n  ~a: ~s"
                                    (car more)
                                    (cadr more))
                            (loop (cddr more)))])]
                   [else
                    (raise-argument-error 'raise-arguments-error "string?" (car more))])))))
  
  (define (raise-mismatch-error who what . more)
    (error who "bad arguments: ~a" what))
  
  (define (raise-range-error who what . more)
    (error who "bad arguments: ~a" what)))
