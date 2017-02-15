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

(define procs (hasheq))

;; Primitives:
(let ([ns (make-base-namespace)])
  (parameterize ([current-namespace ns])
    (namespace-require 'racket/unsafe/ops)
    (namespace-require 'racket/flonum)
    (namespace-require 'racket/fixnum))
  (for ([s (in-list (namespace-mapped-symbols ns))])
    (with-handlers ([exn:fail? void])
      (when (procedure? (eval s ns))
        (set! procs (hash-set procs s #t))))))

(define (lambda? v)
  (match v
    [`(lambda . ,_) #t]
    [`(case-lambda . ,_) #t]
    [`(let-values ([(,id) ,rhs]) ,id) (lambda? rhs)]
    [`(letrec-values ([(,id) ,rhs]) ,id) (lambda? rhs)]
    [`(let-values ,_ ,body) (lambda? body)]
    [`(letrec-values ,_ ,body) (lambda? body)]
    [else #f]))

;; Defined functions:
(for ([v (in-list l)])
  (match v
    [`(define-values (,id) ,rhs)
     (when (lambda? rhs)
       (set! procs (hash-set procs id #t)))]
    #;
    [`(define-values ,ids
       (let-values (((struct: ,make ,? .-ref ,-set!)
                     ,(? make-struct-type? rhs)))
         (let ()
           (let ()
             (make-struct-type
              'input-port
              #f
              19
              0
              #f
              null
              (current-inspector)
              #f
              '(0 1 2 3 4 5 6 7 8 9 10)
              #f
              'input-port)))))
     (void)]
    [_ (void)]))

(define ((make-rewrite procs) v)
  (let rewrite ([v v])
    (match v
      [`(lambda ,formals ,body ...)
       `(lambda ,formals ,@(map rewrite body))]
      [`(case-lambda [,formalss ,bodys ...] ...)
       `(case-lambda ,@(for/list ([formals (in-list formalss)]
                             [body (in-list bodys)])
                    `[,formals ,@(map rewrite body)]))]
      [`(define-values (,id) ,rhs)
       `(define ,id ,(rewrite rhs))]
      [`(define-values ,ids ,rhs)
       `(define-values ,ids ,(rewrite rhs))]
      [`(quote ,_) v]
      [`(let-values () ,body)
       (rewrite body)]
      [`(let-values () ,bodys ...)
       `(let () ,@(map rewrite bodys))]
      [`(let-values ([(,id) ,rhs]) ,bodys ...)
       (define new-procs (if (lambda? rhs)
                             (hash-set procs id #t)
                             procs))
       (define rewrite (make-rewrite new-procs))
       `(let ([,id ,(rewrite rhs)]) ,@(map rewrite bodys))]
      [`(let-values ([(,idss ...) ,rhss] ...) ,bodys ...)
       `(let-values ,(for/list ([ids (in-list idss)]
                                [rhs (in-list rhss)])
                       `[,ids ,(rewrite rhs)])
         ,@(map rewrite bodys))]
      [`(letrec-values ([(,ids) ,rhss] ...) ,bodys ...)
       (define new-procs
         (for/fold ([proc procs]) ([id (in-list ids)]
                                   [rhs (in-list rhss)])
           (if (lambda? rhs)
               (hash-set procs id #t)
               procs)))
       (define rewrite (make-rewrite new-procs))
       `(letrec ,(for/list ([id (in-list ids)]
                            [rhs (in-list rhss)])
                   `[,id ,(rewrite rhs)])
         ,@(map rewrite bodys))]
      [`(letrec-values ([(,idss ...) ,rhss] ...) ,bodys ...)
       `(letrec-values ,(for/list ([ids (in-list idss)]
                                   [rhs (in-list rhss)])
                          `[,ids ,(rewrite rhs)])
         ,@(map rewrite bodys))]
      [`(if ,tst ,thn ,els)
       `(if ,(rewrite tst) ,(rewrite thn) ,(rewrite els))]
      [`(with-continuation-mark ,key ,val ,body)
       `(with-continuation-mark ,(rewrite key) ,(rewrite val) ,(rewrite body))]
      [`(begin ,exps ...)
       `(begin . ,(map rewrite exps))]
      [`(begin0 ,exps ...)
       `(begin0 . ,(map rewrite exps))]
      [`(set! ,id ,rhs)
       `(set! ,id ,(rewrite rhs))]
      [`(#%variable-reference . ,_)
       v]
      [`(,rator ,exps ...)
       (let ([args (map rewrite exps)])
         (if (or (hash-ref procs rator #f)
                 (lambda? rator))
             `(,(rewrite rator) . ,args)
             `(#%app ,(rewrite rator) . ,args)))]
      [_ v])))

(for ([v (in-list l)])
  (unless (equal? v '(void))
    (pretty-write ((make-rewrite procs) v))))
