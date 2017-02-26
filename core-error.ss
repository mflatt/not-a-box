;; Temporary:
(define (procedure-arity-includes? v n) #t)

;; ----------------------------------------

(define-record continuation-mark-set (marks k))

(define current-marks (chez:make-parameter '()))

(define-syntax with-continuation-mark
  (syntax-rules ()
    [(_ key val body)
     (parameterize ([current-marks (cons (cons key val)
                                         (current-marks))])
       body)]))

(define continuation-mark-set-first
  (case-lambda
    [(marks k) (continuation-mark-set-first marks k #f)]
    [(marks k none-v prompt-tag) (continuation-mark-set-first marks k none-v)]
    [(marks k none-v)
     (let loop ([marks (or (and marks
                                (continuation-mark-set-marks marks))
                           (current-marks))])
       (cond
        [(null? marks)
         (if (eq? k parameterization-key)
             empty-parameterization
             none-v)]
        [(eq? k (caar marks)) (cdar marks)]
        [else (loop (cdr marks))]))]))

(define (current-continuation-marks)
  (call/cc
   (lambda (k)
     (make-continuation-mark-set (current-marks)
                                 k))))

;; ----------------------------------------

(define parameterization-key (gensym "parameterization-key"))

(define-record parameterization (ht))

(define empty-parameterization (make-parameterization empty-hasheq))

(define (extend-parameterization p . args)
  (let loop ([ht (parameterization-ht p)] [args args])
    (cond
     [(null? args) (make-parameterization ht)]
     [else (loop (hamt-set ht (car args) (cadr args))
                 (cddr args))])))

(define make-parameter
  (case-lambda
    [(v) (make-parameter v (lambda (x) x))]
    [(v guard)
     (define self
       (case-lambda
         [() (hamt-ref
              (parameterization-ht
               (continuation-mark-set-first
                (current-continuation-marks)
                parameterization-key
                empty-parameterization))
              self
              (lambda () v))]
         [(v2) (set! v v2)]))
     self]))

;; ----------------------------------------

(define error-print-width
  (make-parameter 256
                  (lambda (v)
                    (unless (and (integer? v)
                                 (exact? v)
                                 (>= v 3))
                      (raise-argument-error 'error-print-width
                                            "(and/c exact-integer? (>=/c 3))"
                                            v))
                    v)))

(define error-value->string-handler
  (make-parameter (lambda (v len) "[?error-value->string-handler not ready?]")
                  (lambda (v)
                    (unless (and (procedure? v)
                                 (procedure-arity-includes? v 2))
                      (raise-argument-error 'error-value->string-handler
                                            "(procedure-arity-includes?/c 2)"
                                            v))
                    v)))

;; ----------------------------------------

(define current-inspector
  (make-parameter root-inspector
                  (lambda (v)
                    (unless (inspector? v)
                      (raise-argument-error 'current-inspector
                                            "inspector?"
                                            v))
                    v)))

(define make-inspector
  (case-lambda
    [() (new-inspector (current-inspector))]
    [(i)
     (unless (inspector? i)
       (raise-argument-error 'current-inspector
                             "inspector?"
                             i))
     (new-inspector i)]))

;; ----------------------------------------

(struct exn (message continuation-marks))
(struct exn:break exn (continuation))
(struct exn:break:hang-up exn:break ())
(struct exn:break:terminate exn:break ())
(struct exn:fail exn ())
(struct exn:fail:contract exn:fail ())
(struct exn:fail:contract:arity exn:fail:contract ())
(struct exn:fail:contract:divide-by-zero exn:fail:contract ())
(struct exn:fail:contract:non-fixnum-result exn:fail:contract ())
(struct exn:fail:contract:continuation exn:fail:contract ())
(struct exn:fail:contract:variable exn:fail:contract ())
(struct exn:fail:read exn:fail (srclocs))
(struct exn:fail:read:non-char exn:fail:read ())
(struct exn:fail:read:eof exn:fail:read ())
(struct exn:fail:filesystem exn:fail ())
(struct exn:fail:filesystem:exists exn:fail:filesystem ())
(struct exn:fail:filesystem:version exn:fail:filesystem ())
(struct exn:fail:filesystem:errno exn:fail:filesystem (errno))
(struct exn:fail:network exn:fail ())
(struct exn:fail:network:errno exn:fail:network (errno))
(struct exn:fail:out-of-memory exn:fail ())
(struct exn:fail:unsupported exn:fail ())
(struct exn:fail:user exn:fail ())

;; ----------------------------------------

(define (raise-arguments-error who what . more)
  (unless (symbol? who)
    (raise-argument-error 'raise-arguments-error "symbol?" who))
  (unless (string? what)
    (raise-argument-error 'raise-arguments-error "string?" what))
  (raise
   (exn:fail:contract
    (apply
     string-append
     (symbol->string who)
     ": "
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
           (cons (string-append "\n  "
                                (car more) ": "
                                (error-value->string (cadr more)))
                 (loop (cddr more)))])]
        [else
         (raise-argument-error 'raise-arguments-error "string?" (car more))])))
    (current-continuation-marks))))

(define (do-raise-argument-error e-who tag who what pos arg args)
  (unless (symbol? who)
    (raise-argument-error e-who "symbol?" who))
  (unless (string? what)
    (raise-argument-error e-who "string?" what))
  (when pos
    (unless (and (integer? pos)
                 (exact? pos)
                 (not (negative? pos)))
      (raise-argument-error e-who "exact-nonnegative-integer?" pos)))
  (raise
   (exn:fail:contract
    (string-append (symbol->string who)
                   ": contract violation\n  expected: "
                   what
                   "\n  " tag ": "
                   (error-value->string
                    (if pos (list-ref (cons arg args) pos) arg))
                   (if (and pos (pair? args))
                       (apply
                        string-append
                        "\n  other arguments:"
                        (let loop ([pos pos] [args (cons arg args)])
                          (cond
                           [(null? args) '()]
                           [(zero? pos) (loop (sub1 pos) (cdr args))]
                           [else (cons (string-append "\n   " (error-value->string (car args)))
                                       (loop (sub1 pos) (cdr args)))])))))
    (current-continuation-marks))))
    

(define (error-value->string v)
  ((error-value->string-handler)
   v
   (error-print-width)))

(define raise-argument-error
  (case-lambda
    [(who what arg)
     (do-raise-argument-error 'raise-argument-error "given" who what #f arg #f)]
    [(who what pos arg . args)
     (do-raise-argument-error 'raise-argument-error "given" who what pos arg args)]))

(define (raise-result-error who what arg)
  (do-raise-argument-error 'raise-result-error "result" who what #f arg #f))

(define (do-raise-type-error e-who tag who what pos arg args)
  (unless (symbol? who)
    (raise-argument-error e-who "symbol?" who))
  (unless (string? what)
    (raise-argument-error e-who "string?" what))
  (when pos
    (unless (and (integer? pos)
                 (exact? pos)
                 (not (negative? pos)))
      (raise-argument-error e-who "exact-nonnegative-integer?" pos)))
  (raise
   (exn:fail:contract
    (string-append (symbol->string who)
                   ": expected argument ot type <" what ">"
                   "; given: "
                   (error-value->string
                    (if pos (list-ref (cons arg args) pos) arg))
                   (if (and pos (pair? args))
                       (apply
                        string-append
                        "; other arguments:"
                        (let loop ([pos pos] [args (cons arg args)])
                          (cond
                           [(null? args) '()]
                           [(zero? pos) (loop (sub1 pos) (cdr args))]
                           [else (cons (string-append " " (error-value->string (car args)))
                                       (loop (sub1 pos) (cdr args)))])))))
    (current-continuation-marks))))

(define raise-type-error
  (case-lambda
    [(who what arg)
     (do-raise-type-error 'raise-argument-error "given" who what #f arg #f)]
    [(who what pos arg . args)
     (do-raise-type-error 'raise-argument-error "given" who what pos arg args)]))

(define (raise-mismatch-error who what . more)
  (unless (symbol? who)
    (raise-argument-error 'raise-mismatch-error "symbol?" who))
  (unless (string? what)
    (raise-argument-error 'raise-mismatch-error "string?" what))
  (raise
   (exn:fail:contract
    (apply
     string-append
     (symbol->string who)
     ": "
     what
     (let loop ([more more])
       (cond
        [(null? more) '()]
        [else
         (cons ((error-value->string-handler)
                (cadr more)
                (error-print-width))
               (loop (cdr more)))])))
    (current-continuation-marks))))

(define (raise-range-error who
                           type-description	 	 	 	 
                           index-prefix	 	 	 	 
                           index	 	 	 	 
                           in-value	 	 	 	 
                           lower-bound	 	 	 	 
                           upper-bound	 	 	 	 
                           alt-lower-bound)
  (unless (symbol? who)
    (raise-argument-error 'raise-range-error "symbol?" who))
  (unless (string? type-description)
    (raise-argument-error 'raise-range-error "string?" type-description))
  (unless (string? index-prefix)
    (raise-argument-error 'raise-range-error "string?" index-prefix))
  (raise
   (exn:fail:contract
    (apply
     string-append
     (symbol->string who)
     ": "
     "range error...")
    (current-continuation-marks))))

(define (raise-arity-error name arity . args)
  (raise
   (exn:fail:contract:arity
    (string-append
     "arity mismatch;\n"
     " the expected number of arguments does not match the given number\n"
     (expected-arity-string arity)
     "  given: " (number->string (length args)))
    (current-continuation-marks))))
  
(define (expected-arity-string arity)
  (define (expected s) (string-append "  expected: " s "\n"))
  (cond
   [(number? arity) (expected (number->string arity))]
   [(arity-at-least? arity) (expected
                             (string-append "at least "
                                            (number->string (arity-at-least-value arity))))]
   [else ""]))

(define (raise-result-arity-error expected-args args)
  (raise
   (exn:fail:contract
    (string-append
     "result arity mismatch;\n"
     " expected number of values not received\n"
     "  received: " (number->string (length args)) "\n" 
     "  in: local-binding form")
    (current-continuation-marks))))

;; ----------------------------------------

(define (eprintf fmt . args)
  (apply fprintf (current-error-port) fmt args))

(define (set-base-exception-handler!)
  (base-exception-handler
   (lambda (v)
     (eprintf "~a~a"
              (if (who-condition? v)
                  (format "~a: " (condition-who v))
                  "")
              (cond
               [(exn? v)
                (exn-message v)]
               [(format-condition? v)
                (apply format
                       (condition-message v)
                       (condition-irritants v))]
               [(syntax-violation? v)
                (let ([show (lambda (s)
                              (cond
                               [(not s) ""]
                               [else (format " ~s" (syntax->datum s))]))])
                  (format "~a~a~a"
                          (condition-message v)
                          (show (syntax-violation-form v))
                          (show (syntax-violation-subform v))))]
               [(message-condition? v)
                (condition-message v)]
               [else (format "~s" v)]))
     (when (or (continuation-condition? v)
               (exn? v))
       (eprintf "\n  context...:")
       (let loop ([i (inspect/object (if (exn? v)
                                         (continuation-mark-set-k (exn-continuation-marks v))
                                         (condition-continuation v)))]
                  [n 10])
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
