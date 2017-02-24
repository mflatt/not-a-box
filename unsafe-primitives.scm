
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
   unsafe-immutable-hash-iterate-first
   unsafe-immutable-hash-iterate-next
   unsafe-immutable-hash-iterate-key))
