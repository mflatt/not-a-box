
(define (immutable? v)
  (or (hamt? v)
      (cond
       [(string? v) (string-immutable? v)]
       [(bytes? v) (bytevector-immutable? v)]
       [(vector? v) (vector-immutable? v)]
       [(box? v) (box-immutable? v)]
       [else #f])))
