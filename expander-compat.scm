
(define-values (prop:checked-procedure checked-procedure? checked-procedure-ref)
  (make-struct-type-property 'checked-procedure))
(define-values (prop:impersonator-of impersonator-of? impersonator-of-ref)
  (make-struct-type-property 'impersonator-of))
(define-values (prop:arity-string arity-string? arity-string-ref)
  (make-struct-type-property 'arity-string))
(define-values (prop:incomplete-arity incomplete-arity? incomplete-arity-ref)
  (make-struct-type-property 'incomplete-arity))

(define (check-for-break) (void))
(define break-enabled-key 'break-enabled-key)
(define make-thread-cell box)

(define exception-handler-key 'exception-handler-key)

(define (abort-current-continuation . args)
  (error 'abort-current-continuation "fixme"))

(define (make-continuation-prompt-tag s) (gensym))
(define (default-continuation-prompt-tag) 'default-prompt-tag)
(define (continuation-prompt-available? s) #t)

(define call-with-continuation-prompt
  (case-lambda
   [(proc) (proc)]
   [(proc tag) (proc)]
   [(proc tag abort-handler) (proc)]
   [(proc tag abort-handler . args) (apply proc args)]))

(define (call-with-continuation-barrier proc) (proc))

(define call-with-escape-continuation
  call-with-current-continuation)

(define box-immutable box)
         
(define (immutable? v) (immutable-hash? v))

(define (flvector? v) #f)
(define (flvector-length v) 0)
(define (flvector-ref v i) 0)
(define (unsafe-flvector-ref v i) 0)
(define (flvector-set! v i val) (void))
(define (unsafe-flvector-set! v i val) (void))
(define make-flvector
  (case-lambda
   [(n) 'no-flvector]
   [(n val) 'no-flvector]))

(define (object-name n) 'unknown-name)

(define (mpair? v) #f)
(define (mcar m) #f)
(define (mcdr m) #f)

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

(define substring
  (case-lambda
   [(s start) (chez:substring s start (if (string? s) (string-length s) 0))]
   [(s start end) (chez:substring s start end)]))

(define string-copy!
  (case-lambda
   [(dest dest-start src) (chez:string-copy! src 0 dest dest-start
                                             (if (string? src) (string-length src) 0))]
   [(dest dest-start src src-start) (chez:string-copy! src src-start dest dest-start
                                                       (if (and (string? src) (number? src-start)) (- (string-length src) src-start) 0))]
   [(dest dest-start src src-start src-end) (chez:string-copy! src src-start dest dest-start
                                                               (if (and (number? src-start) (number? src-end)) (- src-end src-start) 0))]))

(define (box-cas! b v1 v2)
  (and (eq? v1 (unbox b))
       (set-box! b v2)
       #t))

(define (make-weak-box v) (weak-cons v #t))
(define (weak-box? v) (weak-pair? v))
(define (weak-box-value v) (let ([c (car v)])
                             (if (eq? c #!bwp)
                                 #f
                                 c)))

(define (integer->integer-bytes num size signed? big-endian?)
  (define bstr (make-bytes 4))
  (bytes-set! bstr 0 (bitwise-and num #xFF))
  (bytes-set! bstr 1 (bitwise-and (arithmetic-shift num -8) #xFF))
  (bytes-set! bstr 2 (bitwise-and (arithmetic-shift num -16) #xFF))
  (bytes-set! bstr 3 (bitwise-and (arithmetic-shift num -24) #xFF))
  bstr)

(define (char-graphic? x) #f)

(define system-type
  (case-lambda
   [() 'macosx]
   [(mode)
    (case mode
      [(os) 'macosx]
      [(word) 64]
      [(gc) '3m]
      [(link) 'framework]
      [(machine) "localhost info..."]
      [(so-suffix) (string->bytes/latin-1 ".dylib")]
      [(so-mode) 'local]
      [(fs-change) '#(#f #f #f #f)])]))
      
(define (system-library-subpath) "x86_64-macosx/3m")
(define (system-path-convention-type) 'unix)

(define (environment-variables-ref e k) #f)
(define (current-environment-variables) #f)

(define (->string p)
  (if (path? p) (path->string p) p))

(define (directory-exists? p)
  (file-directory? (->string p)))

(define file-or-directory-modify-seconds
  (case-lambda
   [(p)
    (time-second (file-modification-time p))]
   [(p secs)
    (if secs
        (error 'file-or-directory-modify-seconds "cannot set modify seconds")
        (file-or-directory-modify-seconds p))]
   [(p secs fail)
    (file-or-directory-modify-seconds p secs)]))

(define (resolve-path p) p)
(define (expand-user-path p) p)


(define (reparameterize . args) (void))

(define current-eval
  (make-parameter (lambda args (error "eval not ready"))))
             
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
  (make-parameter (lambda (v)
                    (unless (void? v)
                      (write v)
                      (newline)))))
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

(define-values (prop:exn:srclocs exn:srclocs? exn:srclocs-accessor)
  (make-struct-type-property 'exn:srclocs))

(define (log-level? logger v) #f)
(define (log-message . args) (void))
(define (current-logger) 'logger)

(define (port-read-handler p) read)

(define gensym
  (case-lambda
   [() (chez:gensym)]
   [(s) (cond
         [(string? s) (chez:gensym s)]
         [(symbol? s) (chez:gensym (symbol->string s))]
         [else (raise-argument-error
                'gensym
                "(or/c symbol? string?)"
                s)])]))

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
(define filesystem-change-evt
  (case-lambda
   [(p) (error 'filesystem-change-evt "unsupported")]
   [(p fail) (fail)]))
(define (filesystem-change-evt-cancel e) (void))
(define call-with-semaphore
  (case-lambda
   [(s proc) (proc)]
   [(s proc try-fail) (proc)]
   [(s proc try-fail . args) (apply proc args)]))

(define (prefab-key? v) #t)
(define (prefab-struct-key v) #f)
(define (prefab-key->struct-type key field-count) #f)
(define (make-prefab-struct key args) (error 'make-prefab-struct "not ready"))
(define (struct->vector s) (error 'struct->vector "not ready"))

(define (srcloc->string s) "srcloc-from-string")

(define struct:arity-at-least (make-record-type-descriptor 'arity-at-least #f #f #f #f '#((immutable value))))
(define arity-at-least? (record-predicate struct:arity-at-least))
(define arity-at-least (make-record-constructor-descriptor struct:arity-at-least #f #f))
(define arity-at-least-value (record-accessor struct:arity-at-least 0))
(define make-arity-at-least arity-at-least)

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

(define (eval-jit-enabled) #t)

(define current-load-relative-directory
  (make-parameter #f))

(define read-char-or-special
  (case-lambda [() (read-char)]
               [(in) (read-char in)]
               [(in special src) (read-char in)]))

(define peek-char-or-special
  (case-lambda [() (peek-char)]
               [(in) (peek-char in)]
               [(in skip) (peek-char in skip)]
               [(in skip special src) (peek-char in skip)]))

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

(define (procedure-arity p)
  (arity-at-least 0))

(define string->number
  (case-lambda [(s) (string->number s 10 #f 'decimal-as-inexact)]
               [(s radix) (string->number s radix #f 'decimal-as-inexact)]
               [(s radix mode) (string->number s radix mode 'decimal-as-inexact)]
               [(s radix mode decimal)
                ;; FIXME
                (chez:string->number s radix)]))

;; ----------------------------------------
;; This `datum->syntax` layer is meant to be for just
;; source locations and properties that the compiler might
;; inspect. Probably it should map to Chez annotations.

(define (host:datum->syntax ignored datum srcloc)
  datum)

(define (host:syntax->datum v)
  v)

(define (syntax-property-symbol-keys v)
  null)

(define (syntax-property v k)
  #f)

(define (syntax-e v) (raise-argument-error 'syntax-e "syntax?" v))
(define (syntax-source v) #f)
(define (syntax-line v) #f)
(define (syntax-column v) #f)
(define (syntax-position v) #f)
(define (syntax-span v) #f)

(define (syntax? v) #f)

;; ----------------------------------------

(define tbd-table (make-hasheq))

(define (primitive-table key)
  (case key
    [(|#%linklet|) linklet-table]
    [(|#%kernel|) kernel-table]
    [(|#%read|) tbd-table]
    [(|#%paramz|) tbd-table]
    [(|#%unsafe|) tbd-table]
    [(|#%foreign|) tbd-table]
    [(|#%futures|) tbd-table]
    [(|#%place|) tbd-table]
    [(|#%flfxnum|) tbd-table]
    [(|#%extfl|) tbd-table]
    [(|#%network|) tbd-table]
    [else #f]))

(define-syntax hash-primitive-set!
  (syntax-rules ()
    [(_ ht [local prim]) (hash-set! ht 'prim local)]
    [(_ ht prim) (hash-set! ht 'prim prim)]))

(define-syntax make-primitive-table
  (syntax-rules ()
    [(_ prim ...)
     (let ([ht (make-hasheq)])
       (hash-primitive-set! ht prim)
       ...
       ht)]))

(include "kernel.scm")


(define linklet-table
  (make-primitive-table
   linklet?
   compile-linklet
   recompile-linklet
   eval-linklet
   read-compiled-linklet
   instantiate-linklet
   
   linklet-import-variables
   linklet-export-variables
   
   instance?
   make-instance
   instance-name
   instance-data
   instance-variable-names
   instance-variable-value
   instance-set-variable-value!
   instance-unset-variable!

   linklet-directory?
   hash->linklet-directory
   linklet-directory->hash

   linklet-bundle?
   hash->linklet-bundle
   linklet-bundle->hash
   
   variable-reference?
   variable-reference->instance
   variable-reference-constant?

   primitive-table))
