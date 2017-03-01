#lang racket/base
(require "match.rkt"
         "known.rkt"
         "import.rkt")

(provide (struct-out struct-type-info)
         make-struct-type-info)

(struct struct-type-info (name parent immediate-field-count field-count pure-constructor? rest))

;; Parse `make-struct-type` forms, returning a `struct-type-info`
;; if the parse succeed:
(define (make-struct-type-info v knowns imports mutated)
  (match v
    [`(make-struct-type (quote ,name) ,parent ,fields 0 #f . ,rest)
     (and (symbol? name)
          (or (not parent)
              (and (known-struct-type? (hash-ref-either knowns imports parent))
                   (not (hash-ref mutated parent #f))))
          (exact-nonnegative-integer? fields)
          (struct-type-info name
                            parent
                            fields
                            (+ fields (if parent
                                          (known-struct-type-field-count
                                           (hash-ref-either knowns imports parent))
                                          0))
                            ;; no guard => pur constructor
                            (or ((length rest) . < . 4)
                                (not (list-ref rest 3)))
                            rest))]
    [`(let-values () ,body)
     (make-struct-type-info body knowns imports mutated)]
    [`,_ #f]))

