(library (error)
  (export with-continuation-mark
          continuation-mark-set-first
          current-continuation-marks

          parameterization-key
          make-parameter
          extend-parameterization

          error-print-width
          error-value->string-handler

          current-inspector
          make-inspector

          struct:exn exn exn? exn-message exn-continuation-marks
          struct:exn:fail exn:fail exn:fail?
          struct:exn:fail:contract exn:fail:contract exn:fail:contract?
          struct:exn:fail:contract:variable exn:fail:contract:variable exn:fail:contract:variable?
          struct:exn:fail:filesystem exn:fail:filesystem exn:fail:filesystem?
          struct:exn:fail:read exn:fail:read exn:fail:read? exn:fail:read-srclocs
          struct:exn:fail:read:eof exn:fail:read:eof exn:fail:read:eof?
          struct:exn:fail:read:non-char exn:fail:read:non-char exn:fail:read:non-char?

          struct:srcloc srcloc srcloc?
          srcloc-source srcloc-line srcloc-column srcloc-position srcloc-span

          raise-argument-error
          raise-arguments-error
          raise-result-error
          raise-mismatch-error
          raise-range-error
          raise-result-arity-error)
  (import (immutable-hash)
          (struct)
          (rename (chezscheme)
                  [make-parameter chez:make-parameter]))

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
              mt-hasheq
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

  (define mt-hasheq (hasheq))
  
  (define (extend-parameterization p . args)
    (let loop ([p p] [args args])
      (cond
       [(null? args) p]
       [else (loop (immutable-hash-set p (car args) (cadr args))
                   (cddr args))])))

  (define make-parameter
    (case-lambda
     [(v) (make-parameter v (lambda (x) x))]
     [(v guard)
      (define self
        (case-lambda
         [() (immutable-hash-ref
              (continuation-mark-set-first
               (current-continuation-marks)
               parameterization-key
               mt-hasheq)
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
  
  (define-syntax struct
    (lambda (stx)
      (syntax-case stx  ()
        [(_ name (field ...))
         #'(struct name #f (field ...))]
        [(_ name parent (field ...))
         (let ([make-id (lambda (id fmt . args)
                          (datum->syntax id
                                         (string->symbol (apply format fmt args))))])
           (with-syntax ([struct:name (make-id #'name "struct:~a" (syntax->datum #'name))]
                         [name? (make-id #'name "~a?" (syntax->datum #'name))]
                         [(name-field ...) (map (lambda (field)
                                                  (make-id field "~a-~a" (syntax->datum #'name) (syntax->datum field)))
                                                #'(field ...))]
                         [(field-index ...) (let loop ([fields #'(field ...)] [accum '()] [pos 0])
                                              (cond
                                               [(null? fields) (reverse accum)]
                                               [else (loop (cdr fields) (cons pos accum) (add1 pos))]))]
                         [struct:parent (if (syntax->datum #'parent)
                                            (make-id #'parent "struct:~a" (syntax->datum #'parent))
                                            #f)])
             #'(begin
                 (define struct:name (make-record-type-descriptor 'name struct:parent #f #f #f '#((immutable field) ...)))
                 (define name? (record-predicate struct:name))
                 (define name (record-constructor (make-record-constructor-descriptor struct:name #f #f)))
                 (define name-field (record-accessor struct:name field-index))
                 ...)))])))

  (define-syntax define-struct
    (lambda (stx)
      (syntax-case stx ()
        [(_ name . rest)
         (with-syntax ([make-name
                        (datum->syntax #'name
                                       (string->symbol (format "make-~a" (syntax->datum #'name))))])
           #'(begin
               (struct name . rest)
               (define make-name name)))])))
  
  (struct exn (message continuation-marks))
  (struct exn:fail exn ())
  (struct exn:fail:filesystem exn:fail ())
  (struct exn:fail:read exn:fail (srclocs))
  (struct exn:fail:read:non-char exn:fail:read ())
  (struct exn:fail:read:eof exn:fail:read ())
  (struct exn:fail:contract exn:fail ())
  (struct exn:fail:contract:variable exn:fail:contract ())

  (define-struct srcloc (source line column position span))

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
                                  ((error-value->string-handler)
                                   (cadr more)
                                   (error-print-width)))
                   (loop (cddr more)))])]
          [else
           (raise-argument-error 'raise-arguments-error "string?" (car more))])))
      (current-continuation-marks))))

  (define (do-raise-argument-error e-who tag who what arg)
    (unless (symbol? who)
      (raise-argument-error e-who "symbol?" who))
    (unless (string? what)
      (raise-argument-error e-who "string?" what))
    (raise
     (exn:fail:contract
      (string-append (symbol->string who)
                     ": contract violation\n  expected: "
                     what
                     "\n  " tag ": "
                     ((error-value->string-handler)
                      arg
                      (error-print-width)))
      (current-continuation-marks))))

  (define (raise-argument-error who what arg)
    (do-raise-argument-error 'raise-argument-error "given" who what arg))

  (define (raise-result-error who what arg)
    (do-raise-argument-error 'raise-result-error "result" who what arg))
  
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

  (define (raise-result-arity-error expected-args args)
    (raise
     (exn:fail:contract
      (string-append
       "result arity mismatch;\n"
       " expected number of values not received\n"
       "  received: " (length args) "\n" 
       "  in: local-binding form")
      (current-continuation-marks))))

  ;; ----------------------------------------

  (define (eprintf fmt . args)
    (apply fprintf (current-error-port) fmt args))

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
