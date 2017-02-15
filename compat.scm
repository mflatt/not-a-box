
(define null '())

(define-values (prop:custom-write custom-write? custom-write-ref)
  (make-struct-type-property 'custom-write))
(define-values (prop:checked-procedure checked-procedure? checked-procedure-ref)
  (make-struct-type-property 'checked-procedure))
(define-values (prop:impersonator-of impersonator-of? impersonator-of-ref)
  (make-struct-type-property 'impersonator-of))
(define-values (prop:arity-string arity-string? arity-string-ref)
  (make-struct-type-property 'arity-string))

(define current-marks (chez:make-parameter null))

(define-syntax with-continuation-mark
  (syntax-rules ()
    [(_ key val body)
     (parameterize ([current-marks (cons (cons key val)
                                         (current-marks))])
       body)]))

(define continuation-mark-set-first
  (case-lambda
    [(marks k) (continuation-mark-set-first marks k #f)]
    [(marks k none-v)
     (let loop ([marks marks])
       (cond
        [(null? marks) none-v]
        [(eq? k (caar marks)) (cdar marks)]
        [else (loop (cdr marks))]))]))

(define (current-continuation-marks)
  (current-marks))

(define (check-for-break) (void))
(define break-enabled-key 'break-enabled-key)
(define make-thread-cell box)

(define exception-handler-key 'exception-handler-key)

(define (abort-current-continuation . args)
  (error 'abort-current-continuation "fixme"))

(define (make-continuation-prompt-tag s) (gensym))
(define (default-continuation-prompt-tag) 'default-prompt-tag)
(define (continuation-prompt-available? s) #t)

(define (call-with-continuation-prompt proc . args) (proc))
(define (call-with-continuation-barrier proc) (proc))

(define call-with-escape-continuation
  call-with-current-continuation)

(define (vector->immutable-vector x) x)
(define vector-immutable vector)

(define box-immutable box)
         
(define (immutable? v) (immutable-hash? v))

(define (flvector? v) #f)
(define (flvector-length v) 0)
(define (flvector-ref v i) 0)
(define (unsafe-flvector-ref v i) 0)
(define (flvector-set! v i val) (void))
(define (unsafe-flvector-set! v i val) (void))
(define (make-flvector n) 'no)

(define unsafe-fxvector-ref fxvector-ref)
(define unsafe-fxvector-set! fxvector-set!)

(define (object-name n) 'unknown-name)

(define (mpair? v) #f)
(define (mcar m) #f)
(define (mcdr m) #f)

(define (exact-integer? n) (and (integer? n) (exact? n)))
(define (exact-nonnegative-integer? n) (and (exact-integer? n) (>= n 0)))
(define (exact-positive-integer? n) (and (exact-integer? n) (> n 0)))
(define (byte? n) (and (exact-integer? n) (>= n 0) (<= n 255)))
(define (string->immutable-string s) s)
(define (procedure-arity-includes? p n) #t)
(define unsafe-car car)
(define unsafe-cdr cdr)
(define unsafe-fl< fl<)
(define unsafe-fl> fl>)
(define unsafe-fl= fl=)
(define unsafe-fl<= fl<=)
(define unsafe-fl>= fl>=)
(define unsafe-fl+ fl+)
(define unsafe-fl- fl-)
(define unsafe-fx< fx<)
(define unsafe-fx> fx>)
(define unsafe-fx>= fx>=)
(define unsafe-fx+ fx+)
(define unsafe-fx- fx-)
(define unsafe-fx= fx=)
(define unsafe-fx<= fx<=)
(define unsafe-fxrshift fxarithmetic-shift-right)
(define unsafe-fxlshift fxarithmetic-shift-left)
(define unsafe-vector-length vector-length)
(define unsafe-vector*-length vector-length)
(define unsafe-vector-ref vector-ref)
(define unsafe-vector*-ref vector-ref)
(define unsafe-vector-set! vector-set!)
(define unsafe-vector*-set! vector-set!)

(define-record keyword (symbol))

(define (string->keyword s)
  (define sym (string->symbol s))
  (or (getprop sym 'keyword #f)
      (let ([kw (make-keyword sym)])
        (putprop sym 'keyword kw)
        kw)))

(define (symbol<? a b)
  (string<? (symbol->string a)
            (symbol->string b)))

(define (keyword<? a b)
  (symbol<? (keyword-symbol a) (keyword-symbol b)))

(define string-locale-downcase string-downcase)

(define (vector-copy! dest d-start src s-start s-end)
  (let loop ([i (- s-end s-start)])
    (unless (zero? i)
      (let ([i (sub1 i)])
        (vector-set! dest (+ d-start i) (vector-ref src (+ s-start i)))
        (loop i)))))

(define unsafe-bytes-ref bytes-ref)
(define unsafe-bytes-set! bytes-set!)
(define unsafe-bytes-length bytes-length)

(define unsafe-string-length string-length)
(define unsafe-string-ref string-ref)
(define unsafe-string-set! string-set!)

(define (box-cas! b v1 v2)
  (and (eq? v1 (unbox b))
       (set-box! b v2)
       #t))

(define (make-weak-box v) (weak-cons v #t))
(define (weak-box? v) (weak-pair? v))
(define (weak-box-value v) (car v))

(define (integer->integer-bytes num size signed? big-endian?)
  (define bstr (make-bytes 4))
  (bytes-set! bstr 0 (bitwise-and num #xFF))
  (bytes-set! bstr 1 (bitwise-and (arithmetic-shift num -8) #xFF))
  (bytes-set! bstr 2 (bitwise-and (arithmetic-shift num -16) #xFF))
  (bytes-set! bstr 3 (bitwise-and (arithmetic-shift num -24) #xFF))
  bstr)

(define (char-graphic? x) #f)

(define eof (eof-object))

(define arithmetic-shift bitwise-arithmetic-shift)

(define (system-type) 'macosx)
(define (system-library-subpath) "x86_64-macosx/3m")
(define (system-path-convention-type) 'unix)

(define (environment-variables-ref e k) #f)
(define (current-environment-variables) #f)

(define (->string p)
  (if (path? p) (path->string p) p))

(define (directory-exists? p)
  (file-directory? (->string p)))

(define (file-or-directory-modify-seconds p)
  (time-second (file-modification-time p)))

(define (resolve-path p) p)
(define (expand-user-path p) p)

(define parameterization-key  'parameterization-key)

(define (extend-parameterization p . args)
  (let loop ([p p] [args args])
    (cond
     [(null? args) p]
     [else (loop (hash-set p (car args) (cadr args))
                 (cddr args))])))

(define mt-hasheq (hasheq))

(define make-parameter
  (case-lambda
    [(v) (make-parameter v (lambda (x) x))]
    [(v guard)
     (define self
       (case-lambda
         [() (hash-ref
              (continuation-mark-set-first
               (current-continuation-marks)
               parameterization-key
               mt-hasheq)
              self
              v)]
         [(v2) (set! v v2)]))
     self]))

(define (reparameterize . args) (void))
             
(define read-decimal-as-inexact
  (make-parameter #t))

(define read-accept-bar-quote
  (make-parameter #t))

(define read-case-sensitive
  (make-parameter #t))

(define current-library-collection-paths
  (make-parameter null))
(define current-library-collection-links
  (make-parameter null))
(define use-collection-link-paths
  (make-parameter null))
(define use-user-specific-search-paths
  (make-parameter null))
(define use-compiled-file-paths
  (make-parameter null))
(define current-compiled-file-roots
  (make-parameter null))

(define current-load/use-compiled
  (make-parameter #f))
(define read-on-demand-source
  (make-parameter #f))

(define current-inspector
  (make-parameter #f))
(define current-code-inspector
  (make-parameter #f))
(define current-print
  (make-parameter write))
(define current-read-interaction
  (make-parameter #f))
(define error-print-source-location
  (make-parameter #t))

(define current-compile
  (make-parameter 'current-compile))
(define current-load
  (make-parameter 'current-load))
(define load-on-demand-enabled
  (make-parameter #f))

(define (cache-configuration id proc) (proc))

(define (find-system-path key)
  #f)

(define (version) "0.1")

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
                                             [(null? fields) accum]
                                             [else (loop (cdr fields) (cons pos accum) (add1 pos))]))]
                       [struct:parent (if (syntax->datum #'parent)
                                          (make-id #'parent "struct:~a" (syntax->datum #'parent))
                                          #f)])
           #'(begin
               (define struct:name (make-record-type-descriptor 'name struct:parent #f #f #f '#((immutable field) ...)))
               (define name? (record-predicate struct:name))
               (define name (make-record-constructor-descriptor struct:name #f #f))
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

(define-values (prop:exn:srclocs exn:srclocs? exn:srclocs-accessor)
  (make-struct-type-property 'exn:srclocs))

(define (log-level? logger v) #f)
(define (log-message . args) (void))
(define (current-logger) 'logger)

(define output-getters (make-weak-eq-hashtable))

(define (open-output-bytes bstr)
  (define-values (p g) (open-bytevector-output-port bstr))
  (hashtable-set! output-getters p g)
  p)
(define (get-output-bytes p)
  ((hashtable-ref output-getters p)))

(define (port-read-handler p) read)

(define (symbol-interned? s) (not (gensym? s)))
(define (string->uninterned-symbol s) (gensym s))
(define (string->unreadable-symbol s) (string->symbol (format "$$~a$$" s)))

;; Not good enough...
(define (make-ephemeron k v)
  (weak-cons k v))
(define (ephemeron-value p)
  (cond
   [(car p) (cdr p)]
   [(cdr p) (set-cdr! p #f) #f]
   [else #f]))

(define-values (prop:evt evt? evt-ref) (make-struct-type-property 'evt))
(define (wrap-evt e v) e)
(define always-evt 'always)
(define (current-thread) 't)
(define (thread-wait t) t)
(define (thread-send t v) t)
(define (make-semaphore) 'sema)
(define (semaphore-post s) (void))
(define (sync . args) #f)
(define (sync/timeout t . args) #f)
(define (semaphore-peek-evt sema) 'sema-peek)
(define (filesystem-change-evt p) 'evt)
(define (filesystem-change-evt-cancel e) (void))
(define (call-with-semaphore s proc . args)
  (apply proc args))

(define (prefab-key? v) #t)
(define (prefab-struct-key v) #f)
(define (prefab-key->struct-type key) #f)
(define (make-prefab-struct key args) (error 'make-prefab-struct "not ready"))
(define (struct->vector s) (error 'struct->vector "not ready"))

(define-struct srcloc (source line column position span))
(define (srcloc->string s) "srcloc-from-string")

(define-struct arity-at-least (value))

(define make-inspector
  (case-lambda
    [() 'inspector]
    [(super) 'inspector]))
(define (inspector-superior? i1 i2) #t)
(define (inspector? v) (eq? v 'inspector))

(define (make-hash-placeholder v) #f)
(define (make-hasheq-placeholder v) #f)
(define (make-hasheqv-placeholder v) #f)
(define (make-placeholder v) #f)
(define (placeholder-set! ph v) (error "no placeholders, yet"))
(define (make-reader-graph v) v)

(define (void? v)
  (eq? v (void)))

(define (eval-jit-enabled) #t)

(define current-load-relative-directory
  (make-parameter #f))

(define read-char-or-special read-char)
(define peek-char-or-special peek-char)

(define datums (make-weak-hash))

(define (datum-intern-literal v)
  (cond
   [(or (number? v)
        (string? v)
        (char? v)
        (bytes? v)
        (regexp? v))
    (or (weak-hash-ref-key datums v)
        (begin
          (hash-set! datums v #t)
          v))]
   [else v]))

(define current-load-extension
  (make-parameter (lambda args (error "no extensions"))))

;; ----------------------------------------

(define (primitive-table key)
  (case key
    [(|#%linklet|) 'ok]))

(include "kernel.scm")
