#lang racket/base

;; Ths module uses `#:omit-define-syntaxes` and doesn't use
;; `struct-out` so that none of the exports are syntax bindings.

(provide known-constant known-constant?
         known-procedure known-procedure?
         known-struct-type known-struct-type? known-struct-type-type known-struct-type-field-count
         known-constructor known-constructor? known-constructor-type known-constructor-field-count
         known-predicate known-predicate? known-predicate-type
         known-accessor known-accessor? known-accessor-type
         known-mutator known-mutator? known-mutator-type
         
         a-known-constant
         a-known-procedure)

(struct known-constant () #:prefab #:omit-define-syntaxes)
(struct known-procedure () #:prefab #:omit-define-syntaxes)
(struct known-struct-type (type field-count) #:prefab #:omit-define-syntaxes)
(struct known-constructor (type field-count) #:prefab #:omit-define-syntaxes #:super struct:known-procedure)
(struct known-predicate (type) #:prefab #:omit-define-syntaxes #:super struct:known-procedure)
(struct known-accessor (type) #:prefab #:omit-define-syntaxes #:super struct:known-procedure)
(struct known-mutator (type) #:prefab #:omit-define-syntaxes #:super struct:known-procedure)

(define a-known-constant (known-constant))
(define a-known-procedure (known-procedure))
