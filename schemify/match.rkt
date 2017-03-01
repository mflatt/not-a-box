#lang racket/base
(require (for-syntax racket/base))

;; One more time, still yet another pattern matching library again...
(provide match)

(define-syntax (match stx)
  (syntax-case stx (quasiquote)
    [(_ expr [`pattern body0 body ...] ...)
     #`(let ([v expr])
         #,(let loop ([patterns (syntax->list #'(pattern ...))]
                      [bodys (syntax->list #'((body0 body ...) ...))])
             (cond
              [(null? patterns)
               #'(error 'match "failed ~e" v)]
              [else
               (define ids (extract-pattern-variables (car patterns)))
               #`(if #,(check-one #'v (car patterns))
                     (let-values ([#,ids #,(extract-one #'v (car patterns))])
                       . #,(car bodys))
                     #,(loop (cdr patterns) (cdr bodys)))])))]))

(define-for-syntax (extract-pattern-variables pattern)
  (syntax-case pattern (unquote ?)
    [(unquote (? pred?))
     null]
    [(unquote bind-id)
     (if (free-identifier=? #'bind-id #'_)
         null
         (list #'bind-id))]
    [(p1 . p2) (append (extract-pattern-variables #'p1)
                       (extract-pattern-variables #'p2))]
    [else null]))

(define-for-syntax (check-one id pattern)
  (syntax-case pattern (unquote ?)
    [(unquote (? pred?))
     #`(pred? #,id)]
    [(unquote bind-id) #`#t]
    [(pat ellipses)
     (and (identifier? #'ellipses)
          (free-identifier=? #'ellipses (quote-syntax ...)))
     (if (syntax-case #'pat (unquote)
           [(unquote bind-id) #t]
           [_ #f])
         #`(list? #,id)
         #`(and (list? #,id)
                (for/and ([v (in-list #,id)])
                  #,(check-one #'v #'pat))))]
    [(p1 . p2)
     #`(and (pair? #,id)
            (let ([a (car #,id)])
              #,(check-one #'a #'p1))
            (let ([d (cdr #,id)])
              #,(check-one #'d #'p2)))]
    [_
     #`(equal? (quote #,pattern) #,id)]))

(define-for-syntax (extract-one id pattern)
  (syntax-case pattern (unquote ?)
    [(unquote (? pred?))
     #`(values)]
    [(unquote bind-id)
     (if (free-identifier=? #'bind-id #'_)
         #'(values)
         id)]
    [(pat ellipses)
     (and (identifier? #'ellipses)
          (free-identifier=? #'ellipses (quote-syntax ...)))
     (syntax-case #'pat (unquote)
       [(unquote bind-id)
        (if (free-identifier=? #'bind-id #'_)
            #'(values)
            id)]
       [_
        (with-syntax ([pat-ids (extract-pattern-variables #'pat)])
          #`(for/lists pat-ids ([v (in-list #,id)])
              #,(extract-one #'v #'pat)))])]
    [(p1 . p2)
     (let ([ids1 (extract-pattern-variables #'p1)]
           [ids2 (extract-pattern-variables #'p2)])
       (cond
        [(and (null? ids1) (null? ids2))
         #'(values)]
        [(null? ids1)
         #`(let ([d (cdr #,id)])
             #,(extract-one #'d #'p2))]
        [(null? ids2)
         #`(let ([a (car #,id)])
             #,(extract-one #'a #'p1))]
        [else
         #`(let-values ([#,ids1 (let ([a (car #,id)])
                                  #,(extract-one #'a #'p1))]
                        [#,ids2 (let ([d (cdr #,id)])
                                  #,(extract-one #'d #'p2))])
             (values #,@ids1 #,@ids2))]))]
    [_
     #'(values)]))
