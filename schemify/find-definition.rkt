#lang racket/base
(require "match.rkt"
         "known.rkt"
         "import.rkt"
         "struct-type-info.rkt"
         "simple.rkt")

(provide find-definitions
         lambda?)

;; Record top-level functions and structure types:
(define (find-definitions v prim-knowns knowns imports mutated)
  (match v
    [`(define-values (,id) ,rhs)
     (cond
      [(lambda? rhs)
       (hash-set knowns id a-known-procedure)]
      [(simple? rhs prim-knowns knowns imports mutated)
       (hash-set knowns id a-known-unknown)]
      [else knowns])]
    [`(define-values (,struct:s ,make-s ,s? ,acc/muts ...) ; pattern from `struct` or `define-struct`
       (let-values (((,struct: ,make ,? ,-ref ,-set!) ,rhs))
         (values ,struct:2
                 ,make2
                 ,?2
                 ,make-acc/muts ...)))
     (define info (and (eq? struct: struct:2)
                       (eq? make make2)
                       (eq? ? ?2)
                       (make-struct-type-info rhs knowns imports mutated)))
     (cond
      [info
       (define type (gensym (symbol->string make-s)))
       (let* ([knowns (hash-set knowns
                                make-s
                                (if (struct-type-info-pure-constructor? info)
                                    (known-constructor type (struct-type-info-field-count info))
                                    a-known-procedure))]
              [knowns (hash-set knowns
                                s?
                                (known-predicate type))]
              [knowns
               (for/fold ([knowns knowns]) ([id (in-list acc/muts)]
                                            [maker (in-list make-acc/muts)])
                 (cond
                  [(eq? (car maker) -ref)
                   (hash-set knowns id (known-accessor type))]
                  [else
                   (hash-set knowns id (known-mutator type))]))])
         (hash-set knowns struct:s (known-struct-type type (struct-type-info-field-count info))))]
      [else knowns])]
    [`(define-values (,struct:s ,make-s ,s? ,s-ref ,s-set!) ,rhs) ; direct use of `make-struct-type`
     (define info (make-struct-type-info rhs knowns imports mutated))
     (cond
      [info
       (define type (gensym (symbol->string make-s)))
       (let* ([knowns (hash-set knowns
                                make-s
                                (if (struct-type-info-pure-constructor? info)
                                    (known-constructor type (struct-type-info-field-count info))
                                    a-known-procedure))]
              [knowns (hash-set knowns
                                s?
                                (known-predicate type))])
         ;; For now, we don't try to track the position-consuming accessor or mutator
         (hash-set knowns struct:s (known-struct-type type (struct-type-info-field-count info))))]
      [else knowns])]
    [`,_ knowns]))

;; ----------------------------------------

;; Recognize forms that produce plain procedures
(define (lambda? v)
  (match v
    [`(lambda . ,_) #t]
    [`(case-lambda . ,_) #t]
    [`(let-values ([(,id1) ,rhs]) ,id2) (and (eq? id1 id2) (lambda? rhs))]
    [`(letrec-values ([(,id1) ,rhs]) ,id2) (and (eq? id1 id2) (lambda? rhs))]
    [`(let-values ,_ ,body) (lambda? body)]
    [`(letrec-values ,_ ,body) (lambda? body)]
    [`,_ #f]))
