
(define-values (prop:checked-procedure checked-procedure? checked-procedure-ref)
  (make-struct-type-property 'checked-procedure))
(define-values (prop:impersonator-of -impersonator-of? impersonator-of-ref)
  (make-struct-type-property 'impersonator-of))
(define-values (prop:arity-string arity-string? arity-string-ref)
  (make-struct-type-property 'arity-string))
(define-values (prop:incomplete-arity incomplete-arity? incomplete-arity-ref)
  (make-struct-type-property 'incomplete-arity))

(define (checked-procedure-check-and-extract st v alt-proc v1 v2)
  (if (and (record? v st)
           (checked-procedure? v)
           (|#%app| (unsafe-struct-ref v 0) v1 v2))
      (unsafe-struct-ref v 1)
      (|#%app| alt-proc v v1 v2)))

(define (unsafe-chaperone-procedure . args) (error "unsafe-chaperone-procedure not ready"))
(define (unsafe-impersonate-procedure . args) (error "unsafe-impersonate-procedure not ready"))

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

(define (immutable? v) (immutable-hash? v))

(define (equal-secondary-hash-code v) (equal-hash-code v))

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

(define (object-name o)
  (cond
   [(input-port? o) (port-name o)]
   [(output-port? o) (port-name o)]
   [else 'unknown-name]))

(define string-locale-downcase string-downcase)

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

(define (environment-variables-ref e k)
  (getenv (bytes->string/utf-8 k)))
(define (current-environment-variables) #f)
(define (environment-variables-set! e k v)
  (error "environment-variables-set! not ready"))

(define (->string p)
  (if (path? p) (path->string p) p))

(define (directory-exists? p)
  (file-directory? (->string p)))

(define (file-exists? p)
  (chez:file-exists? (->string p)))

(define (directory-list p)
  (map string->path (chez:directory-list (->string p))))

(define file-or-directory-modify-seconds
  (case-lambda
   [(p)
    (time-second (file-modification-time (->string p)))]
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
  (make-parameter #t))
(define use-compiled-file-paths
  (make-parameter null))
(define current-compiled-file-roots
  (make-parameter null))

(define current-load/use-compiled
  (make-parameter #f))
(define read-on-demand-source
  (make-parameter #f))

(define current-code-inspector
  (make-parameter (current-inspector)))
(define current-print
  (make-parameter (lambda (v)
                    (unless (void? v)
                      (write v)
                      (newline)))))
(define current-read-interaction
  (make-parameter #f))
(define error-print-source-location
  (make-parameter #t))
(define current-prompt-read
  (make-parameter #f))

(define current-compile
  (make-parameter 'current-compile))
(define current-load
  (make-parameter 'current-load))
(define load-on-demand-enabled
  (make-parameter #f))

(define print-as-expression
  (make-parameter #t))

(define compile-enforce-module-constants
  (make-parameter #t))

(define (load-extension f) (error "no load-extension"))

(define (cache-configuration id proc) (proc))

(define (open-input-output-file . args) (error "no open-input-output-file"))

(define (find-system-path key)
  (case key
    [(exec-file) (string->path (or (getenv "AS_IF_RACKET") "/usr/bin/racket"))]
    [(config-dir) (string->path "../config")]
    [(collects-dir) (string->path "../collects")]
    [(addon-dir) (string->path "/tmp/addon")]
    [(orig-dir) (string->path (current-directory))]
    [else `(find-system-path-not-ready ,key)]))

(define (version) "0.1")

(define-values (prop:exn:srclocs exn:srclocs? exn:srclocs-accessor)
  (make-struct-type-property 'exn:srclocs))

(define (make-logger . args) 'logger)
(define (log-level? logger level . args) #f)
(define (log-message logger level topic message . args)
  (when (log-level? logger level)
    (chez:fprintf (chez:current-error-port) "~a\n" (if (string? topic)
                                                       topic
                                                       message))))
(define (current-logger) 'logger)
(define (logger? v) (eq? v 'logger))

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

(define (channel? v) #f)
(define (channel-put-evt ch v) #f)

(define (srcloc->string s)
  (and (srcloc-source s)
       (format "~a:~s:~s"
               (srcloc-source s)
               (srcloc-line s)
               (srcloc-column s))))

(define (procedure-arity p)
  (arity-at-least 0))
(define (procedure-arity? v)
  #t)

(define (procedure-reduce-arity p a)
  p)

(define (procedure->method p)
  p)

(define (procedure-rename p name)
  p)

(define (chaperone-procedure p . args) p)
(define (chaperone-procedure* p . args) p)
(define (impersonate-procedure p . args) p)
(define (impersonate-procedure* p . args) p)
(define (chaperone-struct s . args) s)
(define (impersonate-struct s . args) s)

(define (chaperone-of? a b) (equal? a b))
(define (impersonator-of? a b) (equal? a b))

(define (impersonator-property? v) #f)

(define (make-hash-placeholder v) #f)
(define (make-hasheq-placeholder v) #f)
(define (make-hasheqv-placeholder v) #f)
(define (make-placeholder v) #f)
(define (placeholder-set! ph v) (error "no placeholders, yet"))
(define (make-reader-graph v) v)

(define (pseudo-random-generator? v) #f)

(define (list-pair? v) #f)
(define (interned-char? v) #f)
(define (true-object? v) (eq? v #t))

(define (eval-jit-enabled) #t)

(define (current-memory-use . mode) 0)

(define (current-plumber) 'plumber)
(define (plumber-add-flush! p v) (set! at-exit (cons v null)))

(define at-exit null)
(define (flush)
  (let ([l at-exit])
    (set! at-exit null)
    (for-each (lambda (p) (p #f)) l)))

(define current-load-relative-directory
  (make-parameter #f))

(define read-char-or-special
  (case-lambda
   [() (read-char)]
   [(in) (read-char in)]
   [(in special src) (read-char in)]))

(define peek-char-or-special
  (case-lambda
   [() (peek-char)]
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

(define syntax-property
  (case-lambda
   [(v k) #f]
   [(v k val) v]))

(define (syntax-e v) (raise-argument-error 'syntax-e "syntax?" v))
(define (syntax-source v) #f)
(define (syntax-line v) #f)
(define (syntax-column v) #f)
(define (syntax-position v) #f)
(define (syntax-span v) #f)

(define (syntax? v) #f)

;; ----------------------------------------

;; The environment is used to evaluate linklets, so all
;; primitives need to be imported (prefered) or defined
;; (less efficient to access) there
(define (fill-environment!)
  (eval `(import (core) (port) (regexp)))
  
  (let ([install-table
         (lambda (table)
           (hash-for-each table
                          (lambda (k v)
                            (eval `(define ,k ',v)))))])
    (install-table compat-table)))

;; ----------------------------------------

;; The expander needs various tables to set up primitive modules, and
;; the `primitive-table` function is the bridge between worlds

(define tbd-table (make-hasheq))

(define (primitive-table key)
  (case key
    [(|#%linklet|) linklet-table]
    [(|#%kernel|) kernel-table]
    [(|#%read|) tbd-table]
    [(|#%paramz|) tbd-table]
    [(|#%unsafe|) unsafe-table]
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

(include "kernel-primitives.scm")
(include "unsafe-primitives.scm")

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

;; Table of things temporarily defined here; since these are
;; not put in the evaluation einvironment with `(import (core))`,
;; each must be specifically defined
(define compat-table
  (make-primitive-table
   prop:checked-procedure checked-procedure? checked-procedure-ref
   prop:impersonator-of -impersonator-of? impersonator-of-ref
   prop:arity-string arity-string? arity-string-ref
   prop:incomplete-arity incomplete-arity? incomplete-arity-ref

   checked-procedure-check-and-extract

   unsafe-chaperone-procedure
   unsafe-impersonate-procedure

   check-for-break
   break-enabled-key
   make-thread-cell

   exception-handler-key

   abort-current-continuation
   make-continuation-prompt-tag
   default-continuation-prompt-tag
   continuation-prompt-available?
   call-with-continuation-prompt
   call-with-continuation-barrier
   call-with-escape-continuation

   box-immutable
   immutable?

   equal-secondary-hash-code

   flvector?
   flvector-length
   flvector-ref
   unsafe-flvector-ref
   flvector-set!
   unsafe-flvector-set!
   make-flvector

   object-name

   string-locale-downcase

   integer->integer-bytes

   char-graphic?

   system-type
   system-library-subpath
   system-path-convention-type

   environment-variables-ref
   current-environment-variables
   environment-variables-set!

   directory-exists?
   file-exists?
   directory-list
   file-or-directory-modify-seconds
   resolve-path
   expand-user-path
   
   reparameterize
   current-eval
   read-decimal-as-inexact
   read-accept-bar-quote

   read-case-sensitive

   current-library-collection-paths
   current-library-collection-links
   use-collection-link-paths
   use-user-specific-search-paths
   use-compiled-file-paths
   current-compiled-file-roots

   current-load/use-compiled
   read-on-demand-source

   current-code-inspector
   current-print
   current-read-interaction
   error-print-source-location
   current-prompt-read

   current-compile
   current-load
   load-on-demand-enabled

   print-as-expression

   compile-enforce-module-constants

   load-extension
   cache-configuration

   open-input-output-file

   find-system-path

   version

   prop:exn:srclocs exn:srclocs? exn:srclocs-accessor

   make-logger log-level? log-message current-logger logger?

   port-read-handler

   gensym

   symbol-interned?
   string->uninterned-symbol
   string->unreadable-symbol

   make-ephemeron
   ephemeron-value
   prop:evt evt? evt-ref
   wrap-evt
   always-evt
   current-thread
   thread-wait
   thread-send
   make-semaphore
   semaphore-post
   sync
   sync/timeout
   semaphore-peek-evt
   filesystem-change-evt
   filesystem-change-evt-cancel
   call-with-semaphore
   channel?
   channel-put-evt

   srcloc->string
   
   procedure-arity
   procedure-arity?
   procedure-reduce-arity
   procedure->method
   procedure-rename

   chaperone-procedure
   chaperone-procedure*
   impersonate-procedure
   impersonate-procedure*
   chaperone-struct
   impersonate-struct
   chaperone-of?
   impersonator-of?
   impersonator-property?

   make-hash-placeholder
   make-hasheq-placeholder
   make-hasheqv-placeholder
   make-placeholder
   placeholder-set!
   make-reader-graph

   pseudo-random-generator?

   list-pair?
   interned-char?
   true-object?
   
   eval-jit-enabled
   current-memory-use

   current-load-relative-directory
   read-char-or-special
   peek-char-or-special
   datum-intern-literal
   current-load-extension
   string->number
   host:datum->syntax
   host:syntax->datum
   syntax-property-symbol-keys
   syntax-property
   syntax-e
   syntax-source
   syntax-line
   syntax-column
   syntax-position
   syntax-span
   syntax?))
