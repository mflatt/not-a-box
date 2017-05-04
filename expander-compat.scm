;; Temporary compatibility stubs

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

(define (prop:chaperone-unsafe-undefined chaperone-unsafe-undefined? chaperone-unsafe-undefined-ref)
  (make-struct-type-property 'chaperone-unsafe-undefined))

(define (chaperone-struct-unsafe-undefined v) v)

(define (equal-secondary-hash-code v) (equal-hash-code v))

(define fx->fl fixnum->flonum)
(define fxrshift fxarithmetic-shift-right)
(define fxlshift fxarithmetic-shift-left)
(define shared-fxvector fxvector)
(define make-shared-fxvector make-fxvector)

(define fl->fx flonum->fixnum)
(define ->fl real->flonum)
(define (fl->exact-integer fl) (inexact->exact (flfloor fl)))
(define unsafe-flrandom random)

(define flreal-part real-part)
(define flimag-part imag-part)
(define make-flrectangular make-rectangular)

(define (flvector . args) 'flvector)
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
(define shared-flvector flvector)
(define make-shared-flvector make-flvector)
(define (flvector-copy vec) 'flvector)

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

(define (integer-bytes->integer b) 0)

(define (char-graphic? x) #f)

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

(define (load s) ((current-load) s #f))

(define (load-extension f) (error "no load-extension"))

(define (cache-configuration id proc) (proc))

(define (open-input-output-file . args) (error "no open-input-output-file"))

(define (find-system-path key)
  (case key
    [(exec-file) (or (let ([s (getenv "LINKLET_RACKET")])
                       (and s
                            (build-path s "racket" "bin" "racket")))
                     (string->path "/usr/local/bin/racket"))]
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
(define (logger-name v) #f)

(define (port-read-handler p) read)

;; Not good enough...
(define (make-ephemeron k v)
  (weak-cons k v))
(define (ephemeron-value p)
  (cond
   [(car p) (cdr p)]
   [(cdr p) (set-cdr! p #f) #f]
   [else #f]))

(define (thread-resume t) (void))
(define (thread-send t v) t)
(define (thread-receive-evt t) 'thread-receive-evt)
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

(define (srcloc->string s)
  (and (srcloc-source s)
       (format "~a:~s:~s"
               (srcloc-source s)
               (srcloc-line s)
               (srcloc-column s))))

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

(define (list-pair? v) #f)
(define (interned-char? v) #f)
(define (true-object? v) (eq? v #t))

(define (eval-jit-enabled) #t)

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
        (let ([v (cond
                  [(string? v) (string->immutable-string v)]
                  [(bytes? v) (bytes->immutable-bytes v)]
                  [else v])])
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

(define (bytes-open-converter . _) #f)
(define (bytes-convert . _) #f)
(define (file-stream-buffer-mode . _) #f)
(define (file-truncate f sz) (truncate-file f sz))
(define (flush-output p) (flush-output-port p))
(define (link-exists? l) #f)
;; ----------------------------------------

;; The environment is used to evaluate linklets, so all
;; primitives need to be imported (prefered) or defined
;; (less efficient to access) there
(define (fill-environment!)
  (eval `(import (rename (core)
                         [correlated? syntax?]
                         [correlated-source syntax-source]
                         [correlated-line syntax-line]
                         [correlated-column syntax-column]
                         [correlated-position syntax-position]
                         [correlated-span syntax-span]
                         [correlated-e syntax-e]
                         [correlated->datum syntax->datum]
                         [datum->correlated datum->syntax]
                         [correlated-property syntax-property]
                         [correlated-property-symbol-keys syntax-property-symbol-keys])
                 (thread)
                 (port)
                 (regexp)
                 (linklet)))
  
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
    [(|#%flfxnum|) flfxnum-table]
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
(include "flfxnum-primitives.scm")

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

;; Table of things temporarily defined here; since these are not put
;; in the evaluation environment with `(import (core) (thread) ....)`,
;; each must be specifically defined
(define compat-table
  (make-primitive-table
   primitive-table
   
   prop:checked-procedure checked-procedure? checked-procedure-ref
   prop:impersonator-of -impersonator-of? impersonator-of-ref
   prop:arity-string arity-string? arity-string-ref
   prop:incomplete-arity incomplete-arity? incomplete-arity-ref

   checked-procedure-check-and-extract

   unsafe-chaperone-procedure
   unsafe-impersonate-procedure

   equal-secondary-hash-code

   fx->fl
   fxrshift
   fxlshift
   shared-fxvector
   make-shared-fxvector

   fl->fx
   ->fl
   fl->exact-integer
   unsafe-flrandom
   
   flreal-part
   flimag-part
   make-flrectangular

   flvector
   flvector?
   flvector-length
   flvector-ref
   unsafe-flvector-ref
   flvector-set!
   unsafe-flvector-set!
   make-flvector
   shared-flvector
   make-shared-flvector

   object-name

   string-locale-downcase

   integer->integer-bytes
   integer-bytes->integer
   file-stream-buffer-mode
   logger-name
   file-truncate
   flush-output
   link-exists?
   
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
   load
   load-on-demand-enabled

   print-as-expression

   compile-enforce-module-constants

   load-extension
   cache-configuration

   open-input-output-file

   bytes-open-converter
   bytes-convert
   path->directory-path
   collect-garbage
   find-system-path
   ;find-user-path

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
   thread-send
   filesystem-change-evt
   filesystem-change-evt-cancel
   call-with-semaphore

   srcloc->string
   
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

   prop:chaperone-unsafe-undefined
   chaperone-struct-unsafe-undefined))
