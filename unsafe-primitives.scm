
(define unsafe-table
  (make-primitive-table
   
   unsafe-car
   unsafe-cdr
   unsafe-list-tail
   unsafe-list-ref

   unsafe-fx=
   unsafe-fx<
   unsafe-fx>
   unsafe-fx>=
   unsafe-fx<=
   
   unsafe-fx+
   unsafe-fx-
   unsafe-fxrshift
   unsafe-fxlshift

   unsafe-fl=
   unsafe-fl<
   unsafe-fl>
   unsafe-fl>=
   unsafe-fl<=

   unsafe-vector-ref
   unsafe-vector-set!
   unsafe-vector*-ref
   unsafe-vector*-set!
   unsafe-vector-length
   unsafe-vector*-length
   
   unsafe-fxvector-ref
   unsafe-fxvector-set!

   unsafe-flvector-ref
   unsafe-flvector-set!

   unsafe-bytes-length
   unsafe-bytes-ref
   unsafe-bytes-set!

   unsafe-string-length
   unsafe-struct-ref

   unsafe-struct-set!
   
   unsafe-immutable-hash-iterate-key+value
   unsafe-immutable-hash-iterate-pair
   unsafe-immutable-hash-iterate-value
   unsafe-immutable-hash-iterate-key
   unsafe-immutable-hash-iterate-first
   unsafe-immutable-hash-iterate-next
   unsafe-mutable-hash-iterate-key+value
   unsafe-mutable-hash-iterate-pair
   unsafe-mutable-hash-iterate-value
   unsafe-mutable-hash-iterate-key
   unsafe-mutable-hash-iterate-first
   unsafe-mutable-hash-iterate-next
   unsafe-weak-hash-iterate-key+value
   unsafe-weak-hash-iterate-pair
   unsafe-weak-hash-iterate-value
   unsafe-weak-hash-iterate-key
   unsafe-weak-hash-iterate-first
   unsafe-weak-hash-iterate-next

   unsafe-chaperone-procedure
   unsafe-impersonate-procedure))
