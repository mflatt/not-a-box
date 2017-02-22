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
        (chez:error 'error (format "~s" init))]
       [(string? init)
        (chez:error 'error init)]
       [else
        (raise-argument-error 'error "(or/c symbol? string?)" init)])]
     [(symbol? init)
      (unless (string? (car args))
        (raise-argument-error 'error "string?" (car args)))
      (chez:error init (apply format args))]
     [(string? init)
      (chez:error 'error (apply string-append
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
    (error who "bad arguments: ~a" what))

  ;; ----------------------------------------

  (define (eprintf fmt . args)
    (apply fprintf (current-error-port) fmt args))

  (base-exception-handler
   (lambda (v)
     (eprintf "~a: ~a"
              (and (who-condition? v)
                   (condition-who v))
              (cond
               [(format-condition? v)
                (apply format
                       (condition-message v)
                       (condition-irritants v))]
               [(message-condition? v)
                (condition-message v)]
               [else "???"]))
     (when (continuation-condition? v)
       (eprintf "\n  context...:")
       (let loop ([i (inspect/object (condition-continuation v))] [n 100])
         (unless (or (zero? n)
                     (not (eq? (i 'type) 'continuation)))
           (call-with-values (lambda () (i 'source-path))
             (case-lambda
              [()
               (let* ([c (i 'code)]
                      [n (c 'name)])
                 (when n
                   (eprintf "\n   ~a" n)))]
              [(path line col)
               (eprintf "\n   ~a:~a:~a" path line col)]
              [(path pos)
               (eprintf "\n   ~a::~a" path pos)]))
           (unless (zero? (i 'depth))
             (loop (i 'link) (sub1 n))))))
     (eprintf "\n")
     (when (serious-condition? v)
       ((reset-handler))))))
