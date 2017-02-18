#lang racket/base
(require racket/pretty
         racket/match)

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
          `(,(if (byte-regexp? k) 'byte-regexp 'regexp)
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

;; Recognize forms that produce plain procedures
(define (lambda? v)
  (match v
    [`(lambda . ,_) #t]
    [`(case-lambda . ,_) #t]
    [`(let-values ([(,id) ,rhs]) ,id) (lambda? rhs)]
    [`(letrec-values ([(,id) ,rhs]) ,id) (lambda? rhs)]
    [`(let-values ,_ ,body) (lambda? body)]
    [`(letrec-values ,_ ,body) (lambda? body)]
    [else #f]))

;; Also recognize and keep track of structure-type bindings
(struct struct-type-info (name parent field-count rest))
(define structs (make-hasheq))

(define (make-struct-type-info v)
  (match v
    [`(make-struct-type (quote ,name) ,parent ,fields 0 #f . ,rest)
     (and (symbol? name)
          (or (not parent)
              (hash-ref structs parent #f))
          (exact-nonnegative-integer? fields)
          (struct-type-info name
                            parent
                            fields
                            rest))]
    [`(let-values () ,body)
     (make-struct-type-info body)]
    [else #f]))

;; Locate defined functions and structure types:
(for ([v (in-list l)])
  (match v
    [`(define-values (,id) ,rhs)
     (when (lambda? rhs)
       (set! procs (hash-set procs id #t)))]
    [`(define-values (,struct:s ,make-s ,s? ,acc/muts ...)
       (let-values (((,struct: ,make ,? ,-ref ,-set!) ,(? make-struct-type-info)))
         (values ,struct:
                 ,make
                 ,?
                 ,make-acc/muts ...)))
     (hash-set! structs struct:s #t)
     (set! procs
           (for/fold ([procs procs]) ([id (in-list (list* make-s s? acc/muts))])
             (hash-set procs id #t)))]
    [_ (void)]))

;; Check whether an expression is simple in the sense that
;; its order of evaluation isn't detectable.
;; FIXME: incorrectly assumes that all variables are immutable
(define (simple? e)
  (match e
    [`(lambda . ,_) #t]
    [`(case-lambda . ,_) #t]
    [`(quote . ,_) #t]
    [`(let ([,ids ,rhss] ...) ,body)
     (and (andmap simple? rhss)
          (simple? body))]
    [`(letrec* ([,ids ,rhss] ...) ,body)
     (and (andmap simple? rhss)
          (simple? body))]
    [else
     (or (symbol? e)
         (integer? e)
         (boolean? e)
         (string? e)
         (bytes? e)
         (regexp? e))]))

;; Convert a `let` to nested lets to enforce order; we
;; rely on the fact that the Racket expander generates
;; expressions that have no shadowing (and inroduce
;; shadowing here)
(define (left-to-right/let v)
  (match v
    [`(let (,_) . ,_) v]
    [`(let ([,ids ,rhss] ...) . ,bodys)
     (let loop ([ids ids] [rhss rhss] [binds null])
       (cond
        [(null? (cdr rhss))
         (if (null? binds)
             `(let ([,(car ids) ,(car rhss)])
               . ,bodys)
             `(let ([,(car ids) ,(car rhss)])
               (let ,binds
                    . ,bodys)))]
        [(simple? (car rhss))
         `(let ([,(car ids) ,(car rhss)])
           ,(loop (cdr ids) (cdr rhss) binds))]
        [else
         (define id (car ids))
         `(let ([,id ,(car rhss)])
           ,(loop (cdr ids) (cdr rhss) (cons `[,id ,id] binds)))]))]))

;; Convert a `lte-values` to nested `let-values`es to
;; enforce order
(define (left-to-right/let-values v)
  (define (make-let-values ids rhs body)
    (if (and (pair? ids) (null? (cdr ids)))
        `(let ([,(car ids) ,rhs]) ,body)
        `(let-values ([,ids ,rhs]) ,body)))
  (match v
    [`(let-values (,_) . ,_) v]
    [`(let-values ([(,idss ...) ,rhss] ...) . ,bodys)
     (let loop ([idss idss] [rhss rhss] [binds null])
       (cond
        [(null? (cdr rhss))
         (make-let-values
          (car idss) (car rhss)
          `(let ,binds
            . ,bodys))]
        [else
         (define ids (car idss))
         (make-let-values
          ids
          (car rhss)
          (loop (cdr idss) (cdr rhss) (append (map (lambda (id) `[,id ,id]) ids) binds)))]))]))

;; Convert an application to enforce left-to-right
;; evaluation order
(define (left-to-right/app v)
  (let loop ([l v] [accum null])
    (cond
     [(null? l) (reverse accum)]
     [(simple? (car l))
      (loop (cdr l) (cons (car l) accum))]
     [(andmap simple? (cdr l))
      (append (reverse accum) l)]
     [else
      (define g (gensym 'app_))
      `(let ([,g ,(car l)])
        ,(loop (cdr l) (cons g accum)))])))

;; Simplify `let-values` to `let`, etc., and
;; reorganize struct bindings.
(define ((make-simplify procs) v)
  (let simplify ([v v])
    (match v
      [`(lambda ,formals ,body ...)
       `(lambda ,formals ,@(map simplify body))]
      [`(case-lambda [,formalss ,bodys ...] ...)
       `(case-lambda ,@(for/list ([formals (in-list formalss)]
                             [body (in-list bodys)])
                    `[,formals ,@(map simplify body)]))]
      [`(define-values (,struct:s ,make-s ,s? ,acc/muts ...)
         (let-values (((,struct: ,make ,? ,-ref ,-set!) ,mk))
           (values ,struct:
                   ,make
                   ,?
                   ,make-acc/muts ...)))
       ;; Convert a `make-struct-type` binding into a 
       ;; set of bindings that Chez's cp0 recognizes,
       ;; and push the struct-specific extra work into
       ;; `struct-type-install-properties!`
       (define sti (make-struct-type-info mk))
       (cond
        [sti
         `(begin
           (define ,struct:s (make-record-type-descriptor ',(struct-type-info-name sti)
                                                          ,(struct-type-info-parent sti)
                                                           #f #f #f
                                                          ',(for/vector ([i (in-range (struct-type-info-field-count sti))])
                                                              `(mutable ,(string->symbol (format "f~a" i))))))
           (define ,make-s (record-constructor
                            (make-record-constructor-descriptor ,struct:s #f #f)))
           (define ,s? (record-predicate ,struct:s))
           ,@(for/list ([acc/mut (in-list acc/muts)]
                        [make-acc/mut (in-list make-acc/muts)])
               `(define ,acc/mut
                 ,(match make-acc/mut
                    [`(make-struct-field-accessor ,(? (lambda (v) (eq? v -ref))) ,pos ,_)
                     `(record-accessor ,struct:s ,pos)]
                    [`(make-struct-field-mutator ,(? (lambda (v) (eq? v -set!))) ,pos ,_)
                     `(record-mutator ,struct:s ,pos)]
                    [else (error "oops")])))
           ,@(if (null? (struct-type-info-rest sti))
                 null
                 `((define ,(gensym)
                     (struct-type-install-properties! ,struct:s
                                                      ',(struct-type-info-name sti)
                                                      ,(struct-type-info-field-count sti)
                                                      0
                                                      ,(struct-type-info-parent sti)
                                                      ,@(map simplify (struct-type-info-rest sti)))))))]
        [else
         `(define-values ,(cadr v) ,(simplify (caddr v)))])]
      [`(define-values (,id) ,rhs)
       `(define ,id ,(simplify rhs))]
      [`(define-values ,ids ,rhs)
       `(define-values ,ids ,(simplify rhs))]
      [`(quote ,_) v]
      [`(let-values () ,body)
       (simplify body)]
      [`(let-values () ,bodys ...)
       `(begin ,@(map simplify bodys))]
      [`(let-values ([(,ids) ,rhss] ...) ,bodys ...)
       (define new-procs
         (for/fold ([proc procs]) ([id (in-list ids)]
                                   [rhs (in-list rhss)])
           (if (lambda? rhs)
               (hash-set procs id #t)
               procs)))
       (define body-simplify (make-simplify new-procs))
       (left-to-right/let
        `(let ,(for/list ([id (in-list ids)]
                          [rhs (in-list rhss)])
                 `[,id ,(simplify rhs)])
          ,@(map body-simplify bodys)))]
      [`(let-values ([() (begin ,rhss ... (values))]) ,bodys ...)
       `(begin ,@(map simplify rhss) ,@(map simplify bodys))]
      [`(let-values ([(,idss ...) ,rhss] ...) ,bodys ...)
       (left-to-right/let-values
        `(let-values ,(for/list ([ids (in-list idss)]
                                 [rhs (in-list rhss)])
                        `[,ids ,(simplify rhs)])
          ,@(map simplify bodys)))]
      [`(letrec-values ([(,ids) ,rhss] ...) ,bodys ...)
       (define new-procs
         (for/fold ([proc procs]) ([id (in-list ids)]
                                   [rhs (in-list rhss)])
           (if (lambda? rhs)
               (hash-set procs id #t)
               procs)))
       (define simplify (make-simplify new-procs))
       `(letrec* ,(for/list ([id (in-list ids)]
                             [rhs (in-list rhss)])
                    `[,id ,(simplify rhs)])
         ,@(map simplify bodys))]
      [`(letrec-values ([(,idss ...) ,rhss] ...) ,bodys ...)
       `(letrec-values ,(for/list ([ids (in-list idss)]
                                   [rhs (in-list rhss)])
                          `[,ids ,(simplify rhs)])
         ,@(map simplify bodys))]
      [`(if ,tst ,thn ,els)
       `(if ,(simplify tst) ,(simplify thn) ,(simplify els))]
      [`(with-continuation-mark ,key ,val ,body)
       `(with-continuation-mark ,(simplify key) ,(simplify val) ,(simplify body))]
      [`(begin ,exps ...)
       `(begin . ,(map simplify exps))]
      [`(begin0 ,exps ...)
       `(begin0 . ,(map simplify exps))]
      [`(set! ,id ,rhs)
       `(set! ,id ,(simplify rhs))]
      [`(#%variable-reference . ,_)
       v]
      [`(,rator ,exps ...)
       (let ([args (map simplify exps)])
         (left-to-right/app
          (if (or (hash-ref procs rator #f)
                  (lambda? rator))
              `(,(simplify rator) . ,args)
              `(#%app ,(simplify rator) . ,args))))]
      [_ v])))

(define (top-simplify v)
  ((make-simplify procs) v))

;; Write out converted forms
(for ([v (in-list l)])
  (unless (equal? v '(void))
    (let loop ([v (top-simplify v)])
      (match v
        [`(begin ,vs ...)
         (for-each loop vs)]
        [else
         (pretty-write v)]))))
