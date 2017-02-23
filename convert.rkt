#lang racket/base
(require racket/pretty
         racket/match
         "schemify.rkt")

(define l (cdddr (read)))

(define rxes (make-hash))

;; Hack to deal with a special case in "expander.rktl":
(define (nested-hash? v)
  (and (pair? v)
       (eq? #f (car v))
       (hash? (cdr v))))

;; Gather all literal regexps and hash tables
(define (rx v)
  (cond
   [(or (regexp? v) (byte-regexp? v))
    (define s (gensym 'rx))
    (hash-set! rxes v s)]
   [(or (pregexp? v) (byte-pregexp? v))
    (define s (gensym 'px))
    (hash-set! rxes v s)]
   [(or (hash? v)
        (nested-hash? v))
    (define s (gensym 'hash))
    (hash-set! rxes v s)]
   [(pair? v)
    (rx (car v))
    (rx (cdr v))]))

(rx l)

;; Set a hook to redirect literal regexps and
;; hash tables to lifted bindings
(pretty-print-size-hook
 (lambda (v display? out)
   (cond
    [(and (pair? v)
          (pair? (cdr v))
          (eq? 'quote (car v))
          (or (regexp? (cadr v))
              (byte-regexp? (cadr v))
              (pregexp? (cadr v))
              (byte-pregexp? (cadr v))
              (hash? (cadr v))
              (nested-hash? (cadr v))))
     10]
    [(bytes? v) (* 3 (bytes-length v))]
    [(and (symbol? v) (regexp-match? #rx"#" (symbol->string v)))
     (+ 2 (string-length (symbol->string v)))]
    [(char? v) 5]
    [else #f])))

;; This hook goes with `pretty-print-size-hook`
(pretty-print-print-hook
 (lambda (v display? out)
   (cond
    [(and (pair? v)
          (eq? 'quote (car v))
          (or (regexp? (cadr v))
              (byte-regexp? (cadr v))
              (pregexp? (cadr v))
              (byte-pregexp? (cadr v))
              (hash? (cadr v))
              (nested-hash? (cadr v))))
     (write (hash-ref rxes (cadr v)) out)]
    [(bytes? v)
     (display "#vu8")
     (write (bytes->list v) out)]
    [(symbol? v)
     (write-string (format "|~a|" v) out)]
    [(char? v)
     (write-string (format "#\\x~x" (char->integer v)) out)]
    [else #f])))

;; Write out lifted regexp and hash-table literals
(for ([(k v) (in-hash rxes)])
  (pretty-write
   `(define ,v
     ,(let loop ([k k])
        (cond
         [(or (regexp? k)
              (byte-regexp? k))
          `(,(cond [(byte-regexp? k)  'byte-regexp]
                   [(byte-pregexp? k) 'byte-pregexp]
                   [(pregexp? k)      'pregexp]
                   [else              'regexp])
            ,(object-name k))]
         [(hash? k)
          `(,(cond
              [(hash-equal? k) 'hash]
              [(hash-eqv? k) 'hasheqv]
              [else 'hasheq])
            ,@(for*/list ([(k v) (in-hash k)]
                          [e (in-list (list k v))])
                `(quote ,e)))]
         [(pair? k)
          `(cons ,(loop (car k)) ,(loop (cdr k)))]
         [else k])))))

;; Keep track of symbols that are known to be plain
;; functions. This information is used to limit
;; insersion of `#%app` forms that deal with applicable
;; structs.
(define procs (hasheq))

;; Register primitives:
(let ([ns (make-base-namespace)])
  (parameterize ([current-namespace ns])
    (namespace-require 'racket/unsafe/ops)
    (namespace-require 'racket/flonum)
    (namespace-require 'racket/fixnum))
  (for ([s (in-list (namespace-mapped-symbols ns))])
    (with-handlers ([exn:fail? void])
      (when (procedure? (eval s ns))
        (set! procs (hash-set procs s #t))))))

;; Write out converted forms
(for ([v (in-list (schemify-body l procs #hasheq() #hasheq()))])
  (unless (equal? v '(void))
    (let loop ([v v])
      (match v
        [`(begin ,vs ...)
         (for-each loop vs)]
        [else
         (pretty-write v)]))))
