#lang racket/base
(require "match.rkt"
         "simple.rkt")

(provide left-to-right/let
         left-to-right/let-values
         left-to-right/app
         
         make-let-values)

;; Convert a `let` to nested lets to enforce order; we
;; rely on the fact that the Racket expander generates
;; expressions that have no shadowing (and inroduce
;; shadowing here)
(define (left-to-right/let v prim-knowns knowns imports mutated)
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
        [(simple? (car rhss) prim-knowns knowns imports mutated)
         `(let ([,(car ids) ,(car rhss)])
           ,(loop (cdr ids) (cdr rhss) binds))]
        [else
         (define id (car ids))
         `(let ([,id ,(car rhss)])
           ,(loop (cdr ids) (cdr rhss) (cons `[,id ,id] binds)))]))]))

;; Convert a `let-values` to nested `let-values`es to
;; enforce order
(define (left-to-right/let-values v mutated)
  (match v
    [`(let-values ([,ids ,rhs]) ,body)
     (make-let-values ids rhs body)]
    [`(let-values ([,ids ,rhs]) . ,bodys)
     (make-let-values ids rhs `(begin . ,bodys))]
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
(define (left-to-right/app v prim-knowns knowns imports mutated)
  (let loop ([l v] [accum null])
    (cond
     [(null? l) (reverse accum)]
     [(simple? (car l) prim-knowns knowns imports mutated)
      (loop (cdr l) (cons (car l) accum))]
     [(andmap (lambda (v) (simple? v prim-knowns knowns imports mutated)) (cdr l))
      (append (reverse accum) l)]
     [else
      (define g (gensym "app_"))
      `(let ([,g ,(car l)])
        ,(loop (cdr l) (cons g accum)))])))

;; ----------------------------------------

(define (make-let-values ids rhs body)
  (cond
   [(and (pair? ids) (null? (cdr ids)))
    `(let ([,(car ids) ,rhs]) ,body)]
   [else
    (match (and (null? ids) rhs)
      [`(begin ,rhs (values))
       `(begin ,rhs ,body)]
      [`,_
       `(call-with-values (lambda () ,rhs)
         (case-lambda 
           [,ids ,body]
           [args (raise-result-arity-error ',ids args)]))])]))
