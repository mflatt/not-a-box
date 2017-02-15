#lang racket/base
(require racket/include
         racket/unsafe/ops)

;; Run using the built-in C implementation:
'|C -----------------|
(include "regexp-demo.scm")

;; Run the Racket implementation:
'|Racket -----------------|
(let ()
  (define-syntax-rule (linklet () ([int-id ext-id] ...) body ...)
    (begin
      (define ext-id #f) ...
      (let ()
        body ...
        (set! ext-id int-id) ...)))
  (include "regexp.rktl")

  ;; Run using the Racket implementation:
  (include "regexp-demo.scm"))
