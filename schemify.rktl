;; This is not the original source code. Instead, this is the code after
;; fully expanding and flattening into a single linklet.
(linklet
 ()
 ((known-accessor? known-accessor?)
  (known-predicate-type known-predicate-type)
  (known-procedure? known-procedure?)
  (known-struct-type-field-count known-struct-type-field-count)
  (known-constant? known-constant?)
  (known-mutator? known-mutator?)
  (known-predicate? known-predicate?)
  (known-accessor known-accessor)
  (known-constructor known-constructor)
  (known-accessor-type known-accessor-type)
  (known-struct-type? known-struct-type?)
  (known-constructor-field-count known-constructor-field-count)
  (a-known-constant a-known-constant)
  (a-known-procedure a-known-procedure)
  (known-unknown? known-unknown?)
  (known-mutator known-mutator)
  (a-known-unknown a-known-unknown)
  (known-constant known-constant)
  (known-unknown known-unknown)
  (known-mutator-type known-mutator-type)
  (schemify-body schemify-body)
  (known-predicate known-predicate)
  (known-struct-type-type known-struct-type-type)
  (known-constructor-type known-constructor-type)
  (known-constructor? known-constructor?)
  (known-procedure known-procedure)
  (known-struct-type known-struct-type)
  (schemify-linklet schemify-linklet))
 (define-values
  (qq-append)
  (lambda (a_0 b_0) (if (list? a_0) (append a_0 b_0) (raise-argument-error 'unquote-splicing "list?" a_0))))
 (define-values
  (prop:procedure-accessor procedure-accessor? procedure-accessor-ref)
  (make-struct-type-property
   'procedure
   (lambda (v_0 info-l_0) (if (exact-integer? v_0) (make-struct-field-accessor (list-ref info-l_0 3) v_0) #f))))
 (define-values
  (new-prop:procedure new-procedure? new-procedure-ref)
  (make-struct-type-property 'procedure #f (list (cons prop:procedure values) (cons prop:procedure-accessor values))))
 (define-values
  (check-struct-type)
  (lambda (name_0 what_0)
    (begin
      (if what_0
        (let-values ()
          (if (struct-type? what_0)
            (void)
            (let-values () (raise-argument-error name_0 "(or/c struct-type? #f)" what_0))))
        (void))
      what_0)))
 (define-values
  (reverse$1)
  (lambda (l_0)
    (begin
      (if (list? l_0) (void) (raise-argument-error 'reverse "list?" l_0))
      (letrec-values (((loop_0) (lambda (a_1 l_1) (if (null? l_1) a_1 (loop_0 (cons (car l_1) a_1) (cdr l_1))))))
        (loop_0 null l_0)))))
 (define-values
  (prop:stream stream-via-prop? stream-ref)
  (make-struct-type-property
   'stream
   (lambda (v_1 si_0)
     (begin
       (if (if (vector? v_1)
             (if (= 3 (vector-length v_1))
               (if (procedure? (vector-ref v_1 0))
                 (if (procedure-arity-includes? (vector-ref v_1 0) 1)
                   (if (procedure? (vector-ref v_1 1))
                     (if (procedure-arity-includes? (vector-ref v_1 1) 1)
                       (if (procedure? (vector-ref v_1 2)) (procedure-arity-includes? (vector-ref v_1 2) 1) #f)
                       #f)
                     #f)
                   #f)
                 #f)
               #f)
             #f)
         (void)
         (let-values ()
           (raise-argument-error
            'guard-for-prop:stream
            (string-append
             "(vector/c (procedure-arity-includes/c 1)\n"
             "          (procedure-arity-includes/c 1)\n"
             "          (procedure-arity-includes/c 1))")
            v_1)))
       (vector->immutable-vector v_1)))))
 (define-values
  (prop:gen-sequence sequence-via-prop? sequence-ref)
  (make-struct-type-property
   'sequence
   (lambda (v_2 si_1)
     (begin
       (if (if (procedure? v_2) (procedure-arity-includes? v_2 1) #f)
         (void)
         (let-values () (raise-argument-error 'guard-for-prop:sequence "(procedure-arity-includes/c 1)" v_2)))
       v_2))))
 (define-values
  (struct:range make-range range? range-ref range-set!)
  (make-struct-type
   'stream
   #f
   3
   0
   #f
   (list
    (cons
     prop:stream
     (vector
      (lambda (v_3) (let-values (((cont?_0) (range-ref v_3 2))) (if cont?_0 (not (cont?_0 (range-ref v_3 0))) #f)))
      (lambda (v_4) (range-ref v_4 0))
      (lambda (v_5) (make-range ((range-ref v_5 1) (range-ref v_5 0)) (range-ref v_5 1) (range-ref v_5 2)))))
    (cons
     prop:gen-sequence
     (lambda (v_6) (values values #f (range-ref v_6 1) (range-ref v_6 0) (range-ref v_6 2) #f #f))))))
 (define-values
  (check-range)
  (lambda (a_2 b_1 step_0)
    (begin
      (if (real? a_2) (void) (let-values () (raise-argument-error 'in-range "real?" a_2)))
      (if (real? b_1) (void) (let-values () (raise-argument-error 'in-range "real?" b_1)))
      (if (real? step_0) (void) (let-values () (raise-argument-error 'in-range "real?" step_0))))))
 (define-values
  (check-naturals)
  (lambda (n_0)
    (if (if (integer? n_0) (if (exact? n_0) (>= n_0 0) #f) #f)
      (void)
      (let-values () (raise-argument-error 'in-naturals "exact-nonnegative-integer?" n_0)))))
 (define-values
  (struct:list-stream make-list-stream list-stream? list-stream-ref list-stream-set!)
  (make-struct-type
   'stream
   #f
   1
   0
   #f
   (list
    (cons
     prop:stream
     (vector
      (lambda (v_7) (not (pair? (list-stream-ref v_7 0))))
      (lambda (v_8) (car (list-stream-ref v_8 0)))
      (lambda (v_9) (make-list-stream (cdr (list-stream-ref v_9 0))))))
    (cons prop:gen-sequence (lambda (v_10) (values car cdr values (list-stream-ref v_10 0) pair? #f #f))))))
 (define-values
  (check-list)
  (lambda (l_2) (if (list? l_2) (void) (let-values () (raise-argument-error 'in-list "list?" l_2)))))
 (define-values
  (check-in-hash-keys)
  (lambda (ht_0)
    (if ((lambda (ht_1) (hash? ht_1)) ht_0) (void) (let-values () (raise-argument-error 'in-hash-keys "hash?" ht_0)))))
 (define-values
  (struct:do-stream make-do-stream do-stream? do-stream-ref do-stream-set!)
  (make-struct-type
   'stream
   #f
   3
   0
   #f
   (list
    (cons
     prop:stream
     (vector
      (lambda (v_11) ((do-stream-ref v_11 0)))
      (lambda (v_12) ((do-stream-ref v_12 1)))
      (lambda (v_13) ((do-stream-ref v_13 2))))))))
 (define-values (empty-stream) (make-do-stream (lambda () #t) void void))
 (define-values
  (grow-vector)
  (lambda (vec_0)
    (let-values (((n_1) (vector-length vec_0)))
      (let-values (((new-vec_0) (make-vector (* 2 n_1)))) (begin (vector-copy! new-vec_0 0 vec_0 0 n_1) new-vec_0)))))
 (define-values
  (shrink-vector)
  (lambda (vec_1 i_0)
    (let-values (((new-vec_1) (make-vector i_0))) (begin (vector-copy! new-vec_1 0 vec_1 0 i_0) new-vec_1))))
 (define-values
  (map2)
  (let-values (((map_0)
                (case-lambda
                 ((f_0 l_3)
                  (if (if (procedure? f_0) (if (procedure-arity-includes? f_0 1) (list? l_3) #f) #f)
                    ((letrec-values (((loop_1)
                                      (lambda (l_4)
                                        (if (null? l_4)
                                          (let-values () null)
                                          (let-values ()
                                            (let-values (((r_0) (cdr l_4))) (cons (f_0 (car l_4)) (loop_1 r_0))))))))
                       loop_1)
                     l_3)
                    (map f_0 l_3)))
                 ((f_1 l1_0 l2_0)
                  (if (if (procedure? f_1)
                        (if (procedure-arity-includes? f_1 2)
                          (if (list? l1_0) (if (list? l2_0) (= (length l1_0) (length l2_0)) #f) #f)
                          #f)
                        #f)
                    ((letrec-values (((loop_2)
                                      (lambda (l1_1 l2_1)
                                        (if (null? l1_1)
                                          (let-values () null)
                                          (let-values ()
                                            (let-values (((r1_0) (cdr l1_1)) ((r2_0) (cdr l2_1)))
                                              (cons (f_1 (car l1_1) (car l2_1)) (loop_2 r1_0 r2_0))))))))
                       loop_2)
                     l1_0
                     l2_0)
                    (map f_1 l1_0 l2_0)))
                 ((f_2 l_5 . args_0) (apply map f_2 l_5 args_0)))))
    map_0))
 (define-values
  (andmap2)
  (let-values (((andmap_0)
                (case-lambda
                 ((f_3 l_6)
                  (if (if (procedure? f_3) (if (procedure-arity-includes? f_3 1) (list? l_6) #f) #f)
                    (if (null? l_6)
                      #t
                      ((letrec-values (((loop_3)
                                        (lambda (l_7)
                                          (if (null? (cdr l_7))
                                            (let-values () (f_3 (car l_7)))
                                            (let-values ()
                                              (let-values (((r_1) (cdr l_7))) (if (f_3 (car l_7)) (loop_3 r_1) #f)))))))
                         loop_3)
                       l_6))
                    (andmap f_3 l_6)))
                 ((f_4 l1_2 l2_2)
                  (if (if (procedure? f_4)
                        (if (procedure-arity-includes? f_4 2)
                          (if (list? l1_2) (if (list? l2_2) (= (length l1_2) (length l2_2)) #f) #f)
                          #f)
                        #f)
                    (if (null? l1_2)
                      #t
                      ((letrec-values (((loop_4)
                                        (lambda (l1_3 l2_3)
                                          (if (null? (cdr l1_3))
                                            (let-values () (f_4 (car l1_3) (car l2_3)))
                                            (let-values ()
                                              (let-values (((r1_1) (cdr l1_3)) ((r2_1) (cdr l2_3)))
                                                (if (f_4 (car l1_3) (car l2_3)) (loop_4 r1_1 r2_1) #f)))))))
                         loop_4)
                       l1_2
                       l2_2))
                    (andmap f_4 l1_2 l2_2)))
                 ((f_5 l_8 . args_1) (apply andmap f_5 l_8 args_1)))))
    andmap_0))
 (define-values (no-empty-edge-table) (make-hash))
 (define-values
  (struct:known-constant known-constant known-constant?)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values () (make-struct-type 'known-constant #f 0 0 #f null 'prefab #f '() #f 'known-constant)))))
    (values struct:_0 make-_0 ?_0)))
 (define-values
  (struct:known-unknown known-unknown known-unknown?)
  (let-values (((struct:_1 make-_1 ?_1 -ref_1 -set!_1)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-unknown
                     (let-values (((the-super_0) struct:known-constant))
                       (if (struct-type? the-super_0) the-super_0 (check-struct-type 'struct the-super_0)))
                     0
                     0
                     #f
                     null
                     'prefab
                     #f
                     '()
                     #f
                     'known-unknown)))))
    (values struct:_1 make-_1 ?_1)))
 (define-values
  (struct:known-procedure known-procedure known-procedure?)
  (let-values (((struct:_2 make-_2 ?_2 -ref_2 -set!_2)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-procedure
                     (let-values (((the-super_1) struct:known-constant))
                       (if (struct-type? the-super_1) the-super_1 (check-struct-type 'struct the-super_1)))
                     0
                     0
                     #f
                     null
                     'prefab
                     #f
                     '()
                     #f
                     'known-procedure)))))
    (values struct:_2 make-_2 ?_2)))
 (define-values
  (struct:known-struct-type known-struct-type known-struct-type? known-struct-type-type known-struct-type-field-count)
  (let-values (((struct:_3 make-_3 ?_3 -ref_3 -set!_3)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'known-struct-type #f 2 0 #f null 'prefab #f '(0 1) #f 'known-struct-type)))))
    (values
     struct:_3
     make-_3
     ?_3
     (make-struct-field-accessor -ref_3 0 'type)
     (make-struct-field-accessor -ref_3 1 'field-count))))
 (define-values
  (struct:known-constructor known-constructor known-constructor? known-constructor-type known-constructor-field-count)
  (let-values (((struct:_4 make-_4 ?_4 -ref_4 -set!_4)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-constructor
                     (let-values (((the-super_2) struct:known-procedure))
                       (if (struct-type? the-super_2) the-super_2 (check-struct-type 'struct the-super_2)))
                     2
                     0
                     #f
                     null
                     'prefab
                     #f
                     '(0 1)
                     #f
                     'known-constructor)))))
    (values
     struct:_4
     make-_4
     ?_4
     (make-struct-field-accessor -ref_4 0 'type)
     (make-struct-field-accessor -ref_4 1 'field-count))))
 (define-values
  (struct:known-predicate known-predicate known-predicate? known-predicate-type)
  (let-values (((struct:_5 make-_5 ?_5 -ref_5 -set!_5)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-predicate
                     (let-values (((the-super_3) struct:known-procedure))
                       (if (struct-type? the-super_3) the-super_3 (check-struct-type 'struct the-super_3)))
                     1
                     0
                     #f
                     null
                     'prefab
                     #f
                     '(0)
                     #f
                     'known-predicate)))))
    (values struct:_5 make-_5 ?_5 (make-struct-field-accessor -ref_5 0 'type))))
 (define-values
  (struct:known-accessor known-accessor known-accessor? known-accessor-type)
  (let-values (((struct:_6 make-_6 ?_6 -ref_6 -set!_6)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-accessor
                     (let-values (((the-super_4) struct:known-procedure))
                       (if (struct-type? the-super_4) the-super_4 (check-struct-type 'struct the-super_4)))
                     1
                     0
                     #f
                     null
                     'prefab
                     #f
                     '(0)
                     #f
                     'known-accessor)))))
    (values struct:_6 make-_6 ?_6 (make-struct-field-accessor -ref_6 0 'type))))
 (define-values
  (struct:known-mutator known-mutator known-mutator? known-mutator-type)
  (let-values (((struct:_7 make-_7 ?_7 -ref_7 -set!_7)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-mutator
                     (let-values (((the-super_5) struct:known-procedure))
                       (if (struct-type? the-super_5) the-super_5 (check-struct-type 'struct the-super_5)))
                     1
                     0
                     #f
                     null
                     'prefab
                     #f
                     '(0)
                     #f
                     'known-mutator)))))
    (values struct:_7 make-_7 ?_7 (make-struct-field-accessor -ref_7 0 'type))))
 (define-values (a-known-constant) (known-constant))
 (define-values (a-known-unknown) (known-unknown))
 (define-values (a-known-procedure) (known-procedure))
 (define-values
  (struct:import import1.1 import? import-grp import-id import-ext-id)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'import #f 3 0 #f null (current-inspector) #f '(0 1 2) #f 'import)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'grp)
     (make-struct-field-accessor -ref_0 1 'id)
     (make-struct-field-accessor -ref_0 2 'ext-id))))
 (define-values
  (struct:import-group import-group2.1 import-group? import-group-knowns/thunk set-import-group-knowns/thunk!)
  (let-values (((struct:_8 make-_8 ?_8 -ref_8 -set!_8)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'import-group #f 1 0 #f null (current-inspector) #f '() #f 'import-group)))))
    (values
     struct:_8
     make-_8
     ?_8
     (make-struct-field-accessor -ref_8 0 'knowns/thunk)
     (make-struct-field-mutator -set!_8 0 'knowns/thunk))))
 (define-values
  (import-group-knowns)
  (lambda (grp_0)
    (let-values (((knowns/thunk_0) (import-group-knowns/thunk grp_0)))
      (if (procedure? knowns/thunk_0)
        (let-values ()
          (let-values (((knowns_0) (let-values (((or-part_0) (knowns/thunk_0))) (if or-part_0 or-part_0 (hasheq)))))
            (begin (set-import-group-knowns/thunk! grp_0 knowns_0) knowns_0)))
        (let-values () knowns/thunk_0)))))
 (define-values
  (import-lookup)
  (lambda (im_0) (hash-ref (import-group-knowns (import-grp im_0)) (import-ext-id im_0) #f)))
 (define-values
  (hash-ref-either)
  (lambda (knowns_1 imports_0 key_0)
    (let-values (((or-part_1) (hash-ref knowns_1 key_0 #f)))
      (if or-part_1
        or-part_1
        (let-values (((im_1) (hash-ref imports_0 key_0 #f))) (if im_1 (import-lookup im_1) #f))))))
 (define-values
  (struct:struct-type-info
   struct-type-info1.1
   struct-type-info?
   struct-type-info-name
   struct-type-info-parent
   struct-type-info-immediate-field-count
   struct-type-info-field-count
   struct-type-info-pure-constructor?
   struct-type-info-rest)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'struct-type-info
                     #f
                     6
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '(0 1 2 3 4 5)
                     #f
                     'struct-type-info)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'name)
     (make-struct-field-accessor -ref_0 1 'parent)
     (make-struct-field-accessor -ref_0 2 'immediate-field-count)
     (make-struct-field-accessor -ref_0 3 'field-count)
     (make-struct-field-accessor -ref_0 4 'pure-constructor?)
     (make-struct-field-accessor -ref_0 5 'rest))))
 (define-values
  (make-struct-type-info)
  (lambda (v_14 knowns_2 imports_1 mutated_0)
    (let-values (((v_15) v_14))
      (if (if (pair? v_15)
            (if (let-values (((a_3) (car v_15))) (equal? 'make-struct-type a_3))
              (let-values (((d_0) (cdr v_15)))
                (if (pair? d_0)
                  (if (let-values (((a_4) (car d_0)))
                        (if (pair? a_4)
                          (if (let-values (((a_5) (car a_4))) (equal? 'quote a_5))
                            (let-values (((d_1) (cdr a_4)))
                              (if (pair? d_1)
                                (if (let-values (((a_6) (car d_1))) #t)
                                  (let-values (((d_2) (cdr d_1))) (equal? '() d_2))
                                  #f)
                                #f))
                            #f)
                          #f))
                    (let-values (((d_3) (cdr d_0)))
                      (if (pair? d_3)
                        (if (let-values (((a_7) (car d_3))) #t)
                          (let-values (((d_4) (cdr d_3)))
                            (if (pair? d_4)
                              (if (let-values (((a_8) (car d_4))) #t)
                                (let-values (((d_5) (cdr d_4)))
                                  (if (pair? d_5)
                                    (if (let-values (((a_9) (car d_5))) (equal? 0 a_9))
                                      (let-values (((d_6) (cdr d_5)))
                                        (if (pair? d_6)
                                          (if (let-values (((a_10) (car d_6))) (equal? #f a_10))
                                            (let-values (((d_7) (cdr d_6))) #t)
                                            #f)
                                          #f))
                                      #f)
                                    #f))
                                #f)
                              #f))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((name_1 parent_0 fields_0 rest_0)
                      (let-values (((d_8) (cdr v_15)))
                        (let-values (((name_2)
                                      (let-values (((a_11) (car d_8)))
                                        (let-values (((d_9) (cdr a_11))) (let-values (((a_12) (car d_9))) a_12))))
                                     ((parent_1 fields_1 rest_1)
                                      (let-values (((d_10) (cdr d_8)))
                                        (let-values (((parent_2) (let-values (((a_13) (car d_10))) a_13))
                                                     ((fields_2 rest_2)
                                                      (let-values (((d_11) (cdr d_10)))
                                                        (let-values (((fields_3)
                                                                      (let-values (((a_14) (car d_11))) a_14))
                                                                     ((rest_3)
                                                                      (let-values (((d_12) (cdr d_11)))
                                                                        (let-values (((d_13) (cdr d_12)))
                                                                          (let-values (((d_14) (cdr d_13))) d_14)))))
                                                          (values fields_3 rest_3)))))
                                          (values parent_2 fields_2 rest_2)))))
                          (values name_2 parent_1 fields_1 rest_1)))))
          (if (symbol? name_1)
            (if (let-values (((or-part_2) (not parent_0)))
                  (if or-part_2
                    or-part_2
                    (if (known-struct-type? (hash-ref-either knowns_2 imports_1 parent_0))
                      (not (hash-ref mutated_0 parent_0 #f))
                      #f)))
              (if (exact-nonnegative-integer? fields_0)
                (struct-type-info1.1
                 name_1
                 parent_0
                 fields_0
                 (+
                  fields_0
                  (if parent_0 (known-struct-type-field-count (hash-ref-either knowns_2 imports_1 parent_0)) 0))
                 (let-values (((or-part_3) (< (length rest_0) 4))) (if or-part_3 or-part_3 (not (list-ref rest_0 3))))
                 rest_0)
                #f)
              #f)
            #f))
        (if (if (pair? v_15)
              (if (let-values (((a_15) (car v_15))) (equal? 'let-values a_15))
                (let-values (((d_15) (cdr v_15)))
                  (if (pair? d_15)
                    (if (let-values (((a_16) (car d_15))) (equal? '() a_16))
                      (let-values (((d_16) (cdr d_15)))
                        (if (pair? d_16)
                          (if (let-values (((a_17) (car d_16))) #t)
                            (let-values (((d_17) (cdr d_16))) (equal? '() d_17))
                            #f)
                          #f))
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((body_0)
                        (let-values (((d_18) (cdr v_15)))
                          (let-values (((d_19) (cdr d_18))) (let-values (((a_18) (car d_19))) a_18)))))
            (make-struct-type-info body_0 knowns_2 imports_1 mutated_0))
          (let-values () #f))))))
 (define-values (delayed?) (lambda (v_16) (procedure? v_16)))
 (define-values
  (simple?)
  (lambda (e_0 prim-knowns_0 knowns_3 imports_2 mutated_1)
    ((letrec-values (((simple?_0)
                      (lambda (e_1)
                        (let-values (((v_17) e_1))
                          (if (if (pair? v_17)
                                (if (let-values (((a_19) (car v_17))) (equal? 'lambda a_19))
                                  (let-values (((d_20) (cdr v_17))) #t)
                                  #f)
                                #f)
                            (let-values () #t)
                            (if (if (pair? v_17)
                                  (if (let-values (((a_20) (car v_17))) (equal? 'case-lambda a_20))
                                    (let-values (((d_21) (cdr v_17))) #t)
                                    #f)
                                  #f)
                              (let-values () #t)
                              (if (if (pair? v_17)
                                    (if (let-values (((a_21) (car v_17))) (equal? 'quote a_21))
                                      (let-values (((d_22) (cdr v_17))) #t)
                                      #f)
                                    #f)
                                (let-values () #t)
                                (if (if (pair? v_17)
                                      (if (let-values (((a_22) (car v_17))) (equal? '#%variable-reference a_22))
                                        (let-values (((d_23) (cdr v_17))) #t)
                                        #f)
                                      #f)
                                  (let-values () #t)
                                  (if (if (pair? v_17)
                                        (if (let-values (((a_23) (car v_17))) (equal? 'let-values a_23))
                                          (let-values (((d_24) (cdr v_17)))
                                            (if (pair? d_24)
                                              (if (let-values (((a_24) (car d_24)))
                                                    (if (list? a_24)
                                                      (let-values (((lst_0) a_24))
                                                        (begin
                                                          (check-list lst_0)
                                                          ((letrec-values (((for-loop_0)
                                                                            (lambda (result_0 lst_1)
                                                                              (if (pair? lst_1)
                                                                                (let-values (((v_18) (unsafe-car lst_1))
                                                                                             ((rest_4)
                                                                                              (unsafe-cdr lst_1)))
                                                                                  (let-values (((result_1)
                                                                                                (let-values ()
                                                                                                  (let-values (((result_2)
                                                                                                                (let-values ()
                                                                                                                  (let-values ()
                                                                                                                    (if (pair?
                                                                                                                         v_18)
                                                                                                                      (if (let-values (((a_25)
                                                                                                                                        (car
                                                                                                                                         v_18)))
                                                                                                                            #t)
                                                                                                                        (let-values (((d_25)
                                                                                                                                      (cdr
                                                                                                                                       v_18)))
                                                                                                                          (if (pair?
                                                                                                                               d_25)
                                                                                                                            (if (let-values (((a_26)
                                                                                                                                              (car
                                                                                                                                               d_25)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_26)
                                                                                                                                            (cdr
                                                                                                                                             d_25)))
                                                                                                                                (equal?
                                                                                                                                 '()
                                                                                                                                 d_26))
                                                                                                                              #f)
                                                                                                                            #f))
                                                                                                                        #f)
                                                                                                                      #f)))))
                                                                                                    (values
                                                                                                     result_2)))))
                                                                                    (if (if (not
                                                                                             ((lambda x_0
                                                                                                (not result_1))
                                                                                              v_18))
                                                                                          (not #f)
                                                                                          #f)
                                                                                      (for-loop_0 result_1 rest_4)
                                                                                      result_1)))
                                                                                result_0))))
                                                             for-loop_0)
                                                           #t
                                                           lst_0)))
                                                      #f))
                                                (let-values (((d_27) (cdr d_24)))
                                                  (if (pair? d_27)
                                                    (if (let-values (((a_27) (car d_27))) #t)
                                                      (let-values (((d_28) (cdr d_27))) (equal? '() d_28))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((rhss_0 body_1)
                                                  (let-values (((d_29) (cdr v_17)))
                                                    (let-values (((rhss_1)
                                                                  (let-values (((a_28) (car d_29)))
                                                                    (let-values (((rhss_2)
                                                                                  (let-values (((lst_2) a_28))
                                                                                    (begin
                                                                                      (check-list lst_2)
                                                                                      ((letrec-values (((for-loop_1)
                                                                                                        (lambda (rhss_3
                                                                                                                 lst_3)
                                                                                                          (if (pair?
                                                                                                               lst_3)
                                                                                                            (let-values (((v_19)
                                                                                                                          (unsafe-car
                                                                                                                           lst_3))
                                                                                                                         ((rest_5)
                                                                                                                          (unsafe-cdr
                                                                                                                           lst_3)))
                                                                                                              (let-values (((rhss_4)
                                                                                                                            (let-values (((rhss_5)
                                                                                                                                          rhss_3))
                                                                                                                              (let-values (((rhss_6)
                                                                                                                                            (let-values ()
                                                                                                                                              (let-values (((rhss1_0)
                                                                                                                                                            (let-values ()
                                                                                                                                                              (let-values (((d_1)
                                                                                                                                                                            (cdr
                                                                                                                                                                             v_19)))
                                                                                                                                                                (let-values (((a_6)
                                                                                                                                                                              (car
                                                                                                                                                                               d_1)))
                                                                                                                                                                  a_6)))))
                                                                                                                                                (cons
                                                                                                                                                 rhss1_0
                                                                                                                                                 rhss_5)))))
                                                                                                                                (values
                                                                                                                                 rhss_6)))))
                                                                                                                (if (not
                                                                                                                     #f)
                                                                                                                  (for-loop_1
                                                                                                                   rhss_4
                                                                                                                   rest_5)
                                                                                                                  rhss_4)))
                                                                                                            rhss_3))))
                                                                                         for-loop_1)
                                                                                       null
                                                                                       lst_2)))))
                                                                      (reverse$1 rhss_2))))
                                                                 ((body_2)
                                                                  (let-values (((d_2) (cdr d_29)))
                                                                    (let-values (((a_29) (car d_2))) a_29))))
                                                      (values rhss_1 body_2)))))
                                      (if (let-values (((lst_4) rhss_0))
                                            (begin
                                              (check-list lst_4)
                                              ((letrec-values (((for-loop_2)
                                                                (lambda (result_3 lst_5)
                                                                  (if (pair? lst_5)
                                                                    (let-values (((rhs_0) (unsafe-car lst_5))
                                                                                 ((rest_6) (unsafe-cdr lst_5)))
                                                                      (let-values (((result_4)
                                                                                    (let-values ()
                                                                                      (let-values (((result_5)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (simple?_0
                                                                                                         rhs_0)))))
                                                                                        (values result_5)))))
                                                                        (if (if (not
                                                                                 ((lambda x_1 (not result_4)) rhs_0))
                                                                              (not #f)
                                                                              #f)
                                                                          (for-loop_2 result_4 rest_6)
                                                                          result_4)))
                                                                    result_3))))
                                                 for-loop_2)
                                               #t
                                               lst_4)))
                                        (simple?_0 body_1)
                                        #f))
                                    (if (if (pair? v_17)
                                          (if (let-values (((a_30) (car v_17))) (equal? 'let a_30))
                                            (let-values (((d_30) (cdr v_17)))
                                              (if (pair? d_30)
                                                (if (let-values (((a_31) (car d_30)))
                                                      (if (list? a_31)
                                                        (let-values (((lst_6) a_31))
                                                          (begin
                                                            (check-list lst_6)
                                                            ((letrec-values (((for-loop_3)
                                                                              (lambda (result_6 lst_7)
                                                                                (if (pair? lst_7)
                                                                                  (let-values (((v_20)
                                                                                                (unsafe-car lst_7))
                                                                                               ((rest_7)
                                                                                                (unsafe-cdr lst_7)))
                                                                                    (let-values (((result_7)
                                                                                                  (let-values ()
                                                                                                    (let-values (((result_8)
                                                                                                                  (let-values ()
                                                                                                                    (let-values ()
                                                                                                                      (if (pair?
                                                                                                                           v_20)
                                                                                                                        (if (let-values (((a_32)
                                                                                                                                          (car
                                                                                                                                           v_20)))
                                                                                                                              #t)
                                                                                                                          (let-values (((d_31)
                                                                                                                                        (cdr
                                                                                                                                         v_20)))
                                                                                                                            (if (pair?
                                                                                                                                 d_31)
                                                                                                                              (if (let-values (((a_13)
                                                                                                                                                (car
                                                                                                                                                 d_31)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_11)
                                                                                                                                              (cdr
                                                                                                                                               d_31)))
                                                                                                                                  (equal?
                                                                                                                                   '()
                                                                                                                                   d_11))
                                                                                                                                #f)
                                                                                                                              #f))
                                                                                                                          #f)
                                                                                                                        #f)))))
                                                                                                      (values
                                                                                                       result_8)))))
                                                                                      (if (if (not
                                                                                               ((lambda x_2
                                                                                                  (not result_7))
                                                                                                v_20))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_3 result_7 rest_7)
                                                                                        result_7)))
                                                                                  result_6))))
                                                               for-loop_3)
                                                             #t
                                                             lst_6)))
                                                        #f))
                                                  (let-values (((d_32) (cdr d_30)))
                                                    (if (pair? d_32)
                                                      (if (let-values (((a_14) (car d_32))) #t)
                                                        (let-values (((d_12) (cdr d_32))) (equal? '() d_12))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((rhss_7 body_3)
                                                    (let-values (((d_33) (cdr v_17)))
                                                      (let-values (((rhss_8)
                                                                    (let-values (((a_33) (car d_33)))
                                                                      (let-values (((rhss_9)
                                                                                    (let-values (((lst_8) a_33))
                                                                                      (begin
                                                                                        (check-list lst_8)
                                                                                        ((letrec-values (((for-loop_4)
                                                                                                          (lambda (rhss_10
                                                                                                                   lst_9)
                                                                                                            (if (pair?
                                                                                                                 lst_9)
                                                                                                              (let-values (((v_21)
                                                                                                                            (unsafe-car
                                                                                                                             lst_9))
                                                                                                                           ((rest_8)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_9)))
                                                                                                                (let-values (((rhss_11)
                                                                                                                              (let-values (((rhss_12)
                                                                                                                                            rhss_10))
                                                                                                                                (let-values (((rhss_13)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((rhss2_0)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((d_34)
                                                                                                                                                                              (cdr
                                                                                                                                                                               v_21)))
                                                                                                                                                                  (let-values (((a_34)
                                                                                                                                                                                (car
                                                                                                                                                                                 d_34)))
                                                                                                                                                                    a_34)))))
                                                                                                                                                  (cons
                                                                                                                                                   rhss2_0
                                                                                                                                                   rhss_12)))))
                                                                                                                                  (values
                                                                                                                                   rhss_13)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_4
                                                                                                                     rhss_11
                                                                                                                     rest_8)
                                                                                                                    rhss_11)))
                                                                                                              rhss_10))))
                                                                                           for-loop_4)
                                                                                         null
                                                                                         lst_8)))))
                                                                        (reverse$1 rhss_9))))
                                                                   ((body_4)
                                                                    (let-values (((d_35) (cdr d_33)))
                                                                      (let-values (((a_35) (car d_35))) a_35))))
                                                        (values rhss_8 body_4)))))
                                        (if (let-values (((lst_10) rhss_7))
                                              (begin
                                                (check-list lst_10)
                                                ((letrec-values (((for-loop_5)
                                                                  (lambda (result_9 lst_11)
                                                                    (if (pair? lst_11)
                                                                      (let-values (((rhs_1) (unsafe-car lst_11))
                                                                                   ((rest_9) (unsafe-cdr lst_11)))
                                                                        (let-values (((result_10)
                                                                                      (let-values ()
                                                                                        (let-values (((result_11)
                                                                                                      (let-values ()
                                                                                                        (let-values ()
                                                                                                          (simple?_0
                                                                                                           rhs_1)))))
                                                                                          (values result_11)))))
                                                                          (if (if (not
                                                                                   ((lambda x_3 (not result_10)) rhs_1))
                                                                                (not #f)
                                                                                #f)
                                                                            (for-loop_5 result_10 rest_9)
                                                                            result_10)))
                                                                      result_9))))
                                                   for-loop_5)
                                                 #t
                                                 lst_10)))
                                          (simple?_0 body_3)
                                          #f))
                                      (if (if (pair? v_17)
                                            (if (let-values (((a_36) (car v_17))) (equal? 'letrec-values a_36))
                                              (let-values (((d_36) (cdr v_17)))
                                                (if (pair? d_36)
                                                  (if (let-values (((a_37) (car d_36)))
                                                        (if (list? a_37)
                                                          (let-values (((lst_12) a_37))
                                                            (begin
                                                              (check-list lst_12)
                                                              ((letrec-values (((for-loop_6)
                                                                                (lambda (result_12 lst_13)
                                                                                  (if (pair? lst_13)
                                                                                    (let-values (((v_22)
                                                                                                  (unsafe-car lst_13))
                                                                                                 ((rest_10)
                                                                                                  (unsafe-cdr lst_13)))
                                                                                      (let-values (((result_13)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_14)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (if (pair?
                                                                                                                             v_22)
                                                                                                                          (if (let-values (((a_38)
                                                                                                                                            (car
                                                                                                                                             v_22)))
                                                                                                                                (list?
                                                                                                                                 a_38))
                                                                                                                            (let-values (((d_37)
                                                                                                                                          (cdr
                                                                                                                                           v_22)))
                                                                                                                              (if (pair?
                                                                                                                                   d_37)
                                                                                                                                (if (let-values (((a_39)
                                                                                                                                                  (car
                                                                                                                                                   d_37)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_38)
                                                                                                                                                (cdr
                                                                                                                                                 d_37)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_38))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                            #f)
                                                                                                                          #f)))))
                                                                                                        (values
                                                                                                         result_14)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_4
                                                                                                    (not result_13))
                                                                                                  v_22))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_6 result_13 rest_10)
                                                                                          result_13)))
                                                                                    result_12))))
                                                                 for-loop_6)
                                                               #t
                                                               lst_12)))
                                                          #f))
                                                    (let-values (((d_39) (cdr d_36)))
                                                      (if (pair? d_39)
                                                        (if (let-values (((a_40) (car d_39))) #t)
                                                          (let-values (((d_40) (cdr d_39))) (equal? '() d_40))
                                                          #f)
                                                        #f))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((idss_0 rhss_14 body_5)
                                                      (let-values (((d_41) (cdr v_17)))
                                                        (let-values (((idss_1 rhss_15)
                                                                      (let-values (((a_41) (car d_41)))
                                                                        (let-values (((idss_2 rhss_16)
                                                                                      (let-values (((lst_14) a_41))
                                                                                        (begin
                                                                                          (check-list lst_14)
                                                                                          ((letrec-values (((for-loop_7)
                                                                                                            (lambda (idss_3
                                                                                                                     rhss_17
                                                                                                                     lst_15)
                                                                                                              (if (pair?
                                                                                                                   lst_15)
                                                                                                                (let-values (((v_23)
                                                                                                                              (unsafe-car
                                                                                                                               lst_15))
                                                                                                                             ((rest_11)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_15)))
                                                                                                                  (let-values (((idss_4
                                                                                                                                 rhss_18)
                                                                                                                                (let-values (((idss_5)
                                                                                                                                              idss_3)
                                                                                                                                             ((rhss_19)
                                                                                                                                              rhss_17))
                                                                                                                                  (let-values (((idss_6
                                                                                                                                                 rhss_20)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values (((idss3_0
                                                                                                                                                                 rhss4_0)
                                                                                                                                                                (let-values ()
                                                                                                                                                                  (let-values (((idss_7)
                                                                                                                                                                                (let-values (((a_42)
                                                                                                                                                                                              (car
                                                                                                                                                                                               v_23)))
                                                                                                                                                                                  a_42))
                                                                                                                                                                               ((rhss_21)
                                                                                                                                                                                (let-values (((d_42)
                                                                                                                                                                                              (cdr
                                                                                                                                                                                               v_23)))
                                                                                                                                                                                  (let-values (((a_43)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 d_42)))
                                                                                                                                                                                    a_43))))
                                                                                                                                                                    (values
                                                                                                                                                                     idss_7
                                                                                                                                                                     rhss_21)))))
                                                                                                                                                    (values
                                                                                                                                                     (cons
                                                                                                                                                      idss3_0
                                                                                                                                                      idss_5)
                                                                                                                                                     (cons
                                                                                                                                                      rhss4_0
                                                                                                                                                      rhss_19))))))
                                                                                                                                    (values
                                                                                                                                     idss_6
                                                                                                                                     rhss_20)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_7
                                                                                                                       idss_4
                                                                                                                       rhss_18
                                                                                                                       rest_11)
                                                                                                                      (values
                                                                                                                       idss_4
                                                                                                                       rhss_18))))
                                                                                                                (values
                                                                                                                 idss_3
                                                                                                                 rhss_17)))))
                                                                                             for-loop_7)
                                                                                           null
                                                                                           null
                                                                                           lst_14)))))
                                                                          (values
                                                                           (reverse$1 idss_2)
                                                                           (reverse$1 rhss_16)))))
                                                                     ((body_6)
                                                                      (let-values (((d_43) (cdr d_41)))
                                                                        (let-values (((a_44) (car d_43))) a_44))))
                                                          (values idss_1 rhss_15 body_6)))))
                                          (if (let-values (((lst_16) rhss_14))
                                                (begin
                                                  (check-list lst_16)
                                                  ((letrec-values (((for-loop_8)
                                                                    (lambda (result_15 lst_17)
                                                                      (if (pair? lst_17)
                                                                        (let-values (((rhs_2) (unsafe-car lst_17))
                                                                                     ((rest_12) (unsafe-cdr lst_17)))
                                                                          (let-values (((result_16)
                                                                                        (let-values ()
                                                                                          (let-values (((result_17)
                                                                                                        (let-values ()
                                                                                                          (let-values ()
                                                                                                            (simple?_0
                                                                                                             rhs_2)))))
                                                                                            (values result_17)))))
                                                                            (if (if (not
                                                                                     ((lambda x_5 (not result_16))
                                                                                      rhs_2))
                                                                                  (not #f)
                                                                                  #f)
                                                                              (for-loop_8 result_16 rest_12)
                                                                              result_16)))
                                                                        result_15))))
                                                     for-loop_8)
                                                   #t
                                                   lst_16)))
                                            (simple?_0 body_5)
                                            #f))
                                        (if (if (pair? v_17)
                                              (if (let-values (((a_45) (car v_17))) (equal? 'letrec* a_45))
                                                (let-values (((d_44) (cdr v_17)))
                                                  (if (pair? d_44)
                                                    (if (let-values (((a_46) (car d_44)))
                                                          (if (list? a_46)
                                                            (let-values (((lst_18) a_46))
                                                              (begin
                                                                (check-list lst_18)
                                                                ((letrec-values (((for-loop_9)
                                                                                  (lambda (result_18 lst_19)
                                                                                    (if (pair? lst_19)
                                                                                      (let-values (((v_24)
                                                                                                    (unsafe-car lst_19))
                                                                                                   ((rest_13)
                                                                                                    (unsafe-cdr
                                                                                                     lst_19)))
                                                                                        (let-values (((result_19)
                                                                                                      (let-values ()
                                                                                                        (let-values (((result_20)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (if (pair?
                                                                                                                               v_24)
                                                                                                                            (if (let-values (((a_47)
                                                                                                                                              (car
                                                                                                                                               v_24)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_45)
                                                                                                                                            (cdr
                                                                                                                                             v_24)))
                                                                                                                                (if (pair?
                                                                                                                                     d_45)
                                                                                                                                  (if (let-values (((a_48)
                                                                                                                                                    (car
                                                                                                                                                     d_45)))
                                                                                                                                        #t)
                                                                                                                                    (let-values (((d_46)
                                                                                                                                                  (cdr
                                                                                                                                                   d_45)))
                                                                                                                                      (equal?
                                                                                                                                       '()
                                                                                                                                       d_46))
                                                                                                                                    #f)
                                                                                                                                  #f))
                                                                                                                              #f)
                                                                                                                            #f)))))
                                                                                                          (values
                                                                                                           result_20)))))
                                                                                          (if (if (not
                                                                                                   ((lambda x_6
                                                                                                      (not result_19))
                                                                                                    v_24))
                                                                                                (not #f)
                                                                                                #f)
                                                                                            (for-loop_9
                                                                                             result_19
                                                                                             rest_13)
                                                                                            result_19)))
                                                                                      result_18))))
                                                                   for-loop_9)
                                                                 #t
                                                                 lst_18)))
                                                            #f))
                                                      (let-values (((d_47) (cdr d_44)))
                                                        (if (pair? d_47)
                                                          (if (let-values (((a_49) (car d_47))) #t)
                                                            (let-values (((d_48) (cdr d_47))) (equal? '() d_48))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((ids_0 rhss_22 body_7)
                                                        (let-values (((d_49) (cdr v_17)))
                                                          (let-values (((ids_1 rhss_23)
                                                                        (let-values (((a_50) (car d_49)))
                                                                          (let-values (((ids_2 rhss_24)
                                                                                        (let-values (((lst_20) a_50))
                                                                                          (begin
                                                                                            (check-list lst_20)
                                                                                            ((letrec-values (((for-loop_10)
                                                                                                              (lambda (ids_3
                                                                                                                       rhss_25
                                                                                                                       lst_21)
                                                                                                                (if (pair?
                                                                                                                     lst_21)
                                                                                                                  (let-values (((v_25)
                                                                                                                                (unsafe-car
                                                                                                                                 lst_21))
                                                                                                                               ((rest_14)
                                                                                                                                (unsafe-cdr
                                                                                                                                 lst_21)))
                                                                                                                    (let-values (((ids_4
                                                                                                                                   rhss_26)
                                                                                                                                  (let-values (((ids_5)
                                                                                                                                                ids_3)
                                                                                                                                               ((rhss_27)
                                                                                                                                                rhss_25))
                                                                                                                                    (let-values (((ids_6
                                                                                                                                                   rhss_28)
                                                                                                                                                  (let-values ()
                                                                                                                                                    (let-values (((ids5_0
                                                                                                                                                                   rhss6_0)
                                                                                                                                                                  (let-values ()
                                                                                                                                                                    (let-values (((ids_7)
                                                                                                                                                                                  (let-values (((a_51)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 v_25)))
                                                                                                                                                                                    a_51))
                                                                                                                                                                                 ((rhss_29)
                                                                                                                                                                                  (let-values (((d_50)
                                                                                                                                                                                                (cdr
                                                                                                                                                                                                 v_25)))
                                                                                                                                                                                    (let-values (((a_52)
                                                                                                                                                                                                  (car
                                                                                                                                                                                                   d_50)))
                                                                                                                                                                                      a_52))))
                                                                                                                                                                      (values
                                                                                                                                                                       ids_7
                                                                                                                                                                       rhss_29)))))
                                                                                                                                                      (values
                                                                                                                                                       (cons
                                                                                                                                                        ids5_0
                                                                                                                                                        ids_5)
                                                                                                                                                       (cons
                                                                                                                                                        rhss6_0
                                                                                                                                                        rhss_27))))))
                                                                                                                                      (values
                                                                                                                                       ids_6
                                                                                                                                       rhss_28)))))
                                                                                                                      (if (not
                                                                                                                           #f)
                                                                                                                        (for-loop_10
                                                                                                                         ids_4
                                                                                                                         rhss_26
                                                                                                                         rest_14)
                                                                                                                        (values
                                                                                                                         ids_4
                                                                                                                         rhss_26))))
                                                                                                                  (values
                                                                                                                   ids_3
                                                                                                                   rhss_25)))))
                                                                                               for-loop_10)
                                                                                             null
                                                                                             null
                                                                                             lst_20)))))
                                                                            (values
                                                                             (reverse$1 ids_2)
                                                                             (reverse$1 rhss_24)))))
                                                                       ((body_8)
                                                                        (let-values (((d_51) (cdr d_49)))
                                                                          (let-values (((a_53) (car d_51))) a_53))))
                                                            (values ids_1 rhss_23 body_8)))))
                                            (if (let-values (((lst_22) rhss_22))
                                                  (begin
                                                    (check-list lst_22)
                                                    ((letrec-values (((for-loop_11)
                                                                      (lambda (result_21 lst_23)
                                                                        (if (pair? lst_23)
                                                                          (let-values (((rhs_3) (unsafe-car lst_23))
                                                                                       ((rest_15) (unsafe-cdr lst_23)))
                                                                            (let-values (((result_22)
                                                                                          (let-values ()
                                                                                            (let-values (((result_23)
                                                                                                          (let-values ()
                                                                                                            (let-values ()
                                                                                                              (simple?_0
                                                                                                               rhs_3)))))
                                                                                              (values result_23)))))
                                                                              (if (if (not
                                                                                       ((lambda x_7 (not result_22))
                                                                                        rhs_3))
                                                                                    (not #f)
                                                                                    #f)
                                                                                (for-loop_11 result_22 rest_15)
                                                                                result_22)))
                                                                          result_21))))
                                                       for-loop_11)
                                                     #t
                                                     lst_22)))
                                              (simple?_0 body_7)
                                              #f))
                                          (if (if (pair? v_17)
                                                (if (let-values (((a_54) (car v_17))) #t)
                                                  (let-values (((d_52) (cdr v_17)))
                                                    (if (pair? d_52)
                                                      (if (let-values (((a_55) (car d_52))) #t)
                                                        (let-values (((d_53) (cdr d_52))) (equal? '() d_53))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((proc_0 arg_0)
                                                          (let-values (((proc_1)
                                                                        (let-values (((a_56) (car v_17))) a_56))
                                                                       ((arg_1)
                                                                        (let-values (((d_54) (cdr v_17)))
                                                                          (let-values (((a_57) (car d_54))) a_57))))
                                                            (values proc_1 arg_1))))
                                              (if (symbol? proc_0)
                                                (if (let-values (((v_26) (hash-ref-either knowns_3 imports_2 proc_0)))
                                                      (if v_26
                                                        (if (not (hash-ref mutated_1 proc_0 #f))
                                                          (let-values (((or-part_4) (known-predicate? v_26)))
                                                            (if or-part_4
                                                              or-part_4
                                                              (if (known-constructor? v_26)
                                                                (= 1 (known-constructor-field-count v_26))
                                                                #f)))
                                                          #f)
                                                        #f))
                                                  (simple?_0 arg_0)
                                                  #f)
                                                #f))
                                            (if (if (pair? v_17)
                                                  (if (let-values (((a_58) (car v_17))) #t)
                                                    (let-values (((d_55) (cdr v_17))) #t)
                                                    #f)
                                                  #f)
                                              (let-values (((proc_2 args_2)
                                                            (let-values (((proc_3)
                                                                          (let-values (((a_59) (car v_17))) a_59))
                                                                         ((args_3)
                                                                          (let-values (((d_56) (cdr v_17))) d_56)))
                                                              (values proc_3 args_3))))
                                                (if (symbol? proc_2)
                                                  (if (let-values (((v_27) (hash-ref-either knowns_3 imports_2 proc_2)))
                                                        (if (known-constructor? v_27)
                                                          (= (length args_2) (known-constructor-field-count v_27))
                                                          #f))
                                                    (if (not (hash-ref mutated_1 proc_2 #f))
                                                      (let-values (((lst_24) args_2))
                                                        (begin
                                                          (check-list lst_24)
                                                          ((letrec-values (((for-loop_12)
                                                                            (lambda (result_24 lst_25)
                                                                              (if (pair? lst_25)
                                                                                (let-values (((arg_2)
                                                                                              (unsafe-car lst_25))
                                                                                             ((rest_16)
                                                                                              (unsafe-cdr lst_25)))
                                                                                  (let-values (((result_25)
                                                                                                (let-values ()
                                                                                                  (let-values (((result_26)
                                                                                                                (let-values ()
                                                                                                                  (let-values ()
                                                                                                                    (simple?_0
                                                                                                                     arg_2)))))
                                                                                                    (values
                                                                                                     result_26)))))
                                                                                    (if (if (not
                                                                                             ((lambda x_8
                                                                                                (not result_25))
                                                                                              arg_2))
                                                                                          (not #f)
                                                                                          #f)
                                                                                      (for-loop_12 result_25 rest_16)
                                                                                      result_25)))
                                                                                result_24))))
                                                             for-loop_12)
                                                           #t
                                                           lst_24)))
                                                      #f)
                                                    #f)
                                                  #f))
                                              (let-values ()
                                                (let-values (((or-part_5)
                                                              (if (symbol? e_1)
                                                                (let-values (((v_28) (hash-ref mutated_1 e_1 #f)))
                                                                  (let-values (((or-part_6) (not v_28)))
                                                                    (if or-part_6 or-part_6 (delayed? v_28))))
                                                                #f)))
                                                  (if or-part_5
                                                    or-part_5
                                                    (let-values (((or-part_7) (integer? e_1)))
                                                      (if or-part_7
                                                        or-part_7
                                                        (let-values (((or-part_8) (boolean? e_1)))
                                                          (if or-part_8
                                                            or-part_8
                                                            (let-values (((or-part_9) (string? e_1)))
                                                              (if or-part_9
                                                                or-part_9
                                                                (let-values (((or-part_10) (bytes? e_1)))
                                                                  (if or-part_10
                                                                    or-part_10
                                                                    (regexp? e_1))))))))))))))))))))))))))
       simple?_0)
     e_0)))
 (define-values
  (find-definitions)
  (lambda (v_16 prim-knowns_1 knowns_4 imports_3 mutated_2)
    (let-values (((v_29) v_16))
      (if (if (pair? v_29)
            (if (let-values (((a_60) (car v_29))) (equal? 'define-values a_60))
              (let-values (((d_57) (cdr v_29)))
                (if (pair? d_57)
                  (if (let-values (((a_61) (car d_57)))
                        (if (pair? a_61)
                          (if (let-values (((a_19) (car a_61))) #t)
                            (let-values (((d_20) (cdr a_61))) (equal? '() d_20))
                            #f)
                          #f))
                    (let-values (((d_58) (cdr d_57)))
                      (if (pair? d_58)
                        (if (let-values (((a_62) (car d_58))) #t)
                          (let-values (((d_59) (cdr d_58))) (equal? '() d_59))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((id_0 rhs_4)
                      (let-values (((d_23) (cdr v_29)))
                        (let-values (((id_1) (let-values (((a_24) (car d_23))) (let-values (((a_63) (car a_24))) a_63)))
                                     ((rhs_5)
                                      (let-values (((d_60) (cdr d_23))) (let-values (((a_64) (car d_60))) a_64))))
                          (values id_1 rhs_5)))))
          (if (lambda? rhs_4)
            (let-values () (hash-set knowns_4 id_0 a-known-procedure))
            (if (simple? rhs_4 prim-knowns_1 knowns_4 imports_3 mutated_2)
              (let-values () (hash-set knowns_4 id_0 a-known-unknown))
              (let-values () knowns_4))))
        (if (if (pair? v_29)
              (if (let-values (((a_65) (car v_29))) (equal? 'define-values a_65))
                (let-values (((d_61) (cdr v_29)))
                  (if (pair? d_61)
                    (if (let-values (((a_66) (car d_61)))
                          (if (pair? a_66)
                            (if (let-values (((a_67) (car a_66))) #t)
                              (let-values (((d_62) (cdr a_66)))
                                (if (pair? d_62)
                                  (if (let-values (((a_68) (car d_62))) #t)
                                    (let-values (((d_63) (cdr d_62)))
                                      (if (pair? d_63)
                                        (if (let-values (((a_69) (car d_63))) #t)
                                          (let-values (((d_64) (cdr d_63))) (list? d_64))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                              #f)
                            #f))
                      (let-values (((d_26) (cdr d_61)))
                        (if (pair? d_26)
                          (if (let-values (((a_70) (car d_26)))
                                (if (pair? a_70)
                                  (if (let-values (((a_71) (car a_70))) (equal? 'let-values a_71))
                                    (let-values (((d_65) (cdr a_70)))
                                      (if (pair? d_65)
                                        (if (let-values (((a_72) (car d_65)))
                                              (if (pair? a_72)
                                                (if (let-values (((a_73) (car a_72)))
                                                      (if (pair? a_73)
                                                        (if (let-values (((a_74) (car a_73)))
                                                              (if (pair? a_74)
                                                                (if (let-values (((a_75) (car a_74))) #t)
                                                                  (let-values (((d_66) (cdr a_74)))
                                                                    (if (pair? d_66)
                                                                      (if (let-values (((a_76) (car d_66))) #t)
                                                                        (let-values (((d_67) (cdr d_66)))
                                                                          (if (pair? d_67)
                                                                            (if (let-values (((a_77) (car d_67))) #t)
                                                                              (let-values (((d_68) (cdr d_67)))
                                                                                (if (pair? d_68)
                                                                                  (if (let-values (((a_78) (car d_68)))
                                                                                        #t)
                                                                                    (let-values (((d_69) (cdr d_68)))
                                                                                      (if (pair? d_69)
                                                                                        (if (let-values (((a_79)
                                                                                                          (car d_69)))
                                                                                              #t)
                                                                                          (let-values (((d_70)
                                                                                                        (cdr d_69)))
                                                                                            (equal? '() d_70))
                                                                                          #f)
                                                                                        #f))
                                                                                    #f)
                                                                                  #f))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f))
                                                          (let-values (((d_71) (cdr a_73)))
                                                            (if (pair? d_71)
                                                              (if (let-values (((a_3) (car d_71))) #t)
                                                                (let-values (((d_0) (cdr d_71))) (equal? '() d_0))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f))
                                                  (let-values (((d_72) (cdr a_72))) (equal? '() d_72))
                                                  #f)
                                                #f))
                                          (let-values (((d_73) (cdr d_65)))
                                            (if (pair? d_73)
                                              (if (let-values (((a_80) (car d_73)))
                                                    (if (pair? a_80)
                                                      (if (let-values (((a_6) (car a_80))) (equal? 'values a_6))
                                                        (let-values (((d_2) (cdr a_80)))
                                                          (if (pair? d_2)
                                                            (if (let-values (((a_29) (car d_2))) #t)
                                                              (let-values (((d_74) (cdr d_2)))
                                                                (if (pair? d_74)
                                                                  (if (let-values (((a_81) (car d_74))) #t)
                                                                    (let-values (((d_75) (cdr d_74)))
                                                                      (if (pair? d_75)
                                                                        (if (let-values (((a_82) (car d_75))) #t)
                                                                          (let-values (((d_76) (cdr d_75)))
                                                                            (list? d_76))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                (let-values (((d_6) (cdr d_73))) (equal? '() d_6))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_77) (cdr d_26))) (equal? '() d_77))
                            #f)
                          #f))
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((struct:s_0
                         make-s_0
                         s?_0
                         acc/muts_0
                         struct:_9
                         make_0
                         ?_9
                         -ref_9
                         -set!_9
                         rhs_6
                         struct:2_0
                         make2_0
                         ?2_0
                         make-acc/muts_0)
                        (let-values (((d_78) (cdr v_29)))
                          (let-values (((struct:s_1 make-s_1 s?_1 acc/muts_1)
                                        (let-values (((a_16) (car d_78)))
                                          (let-values (((struct:s_2) (let-values (((a_83) (car a_16))) a_83))
                                                       ((make-s_2 s?_2 acc/muts_2)
                                                        (let-values (((d_19) (cdr a_16)))
                                                          (let-values (((make-s_3)
                                                                        (let-values (((a_84) (car d_19))) a_84))
                                                                       ((s?_3 acc/muts_3)
                                                                        (let-values (((d_34) (cdr d_19)))
                                                                          (let-values (((s?_4)
                                                                                        (let-values (((a_35)
                                                                                                      (car d_34)))
                                                                                          a_35))
                                                                                       ((acc/muts_4)
                                                                                        (let-values (((d_79)
                                                                                                      (cdr d_34)))
                                                                                          d_79)))
                                                                            (values s?_4 acc/muts_4)))))
                                                            (values make-s_3 s?_3 acc/muts_3)))))
                                            (values struct:s_2 make-s_2 s?_2 acc/muts_2))))
                                       ((struct:_10
                                         make_1
                                         ?_10
                                         -ref_10
                                         -set!_10
                                         rhs_7
                                         struct:2_1
                                         make2_1
                                         ?2_1
                                         make-acc/muts_1)
                                        (let-values (((d_80) (cdr d_78)))
                                          (let-values (((a_85) (car d_80)))
                                            (let-values (((d_81) (cdr a_85)))
                                              (let-values (((struct:_11 make_2 ?_11 -ref_11 -set!_11 rhs_8)
                                                            (let-values (((a_86) (car d_81)))
                                                              (let-values (((a_87) (car a_86)))
                                                                (let-values (((struct:_12 make_3 ?_12 -ref_12 -set!_12)
                                                                              (let-values (((a_38) (car a_87)))
                                                                                (let-values (((struct:_13)
                                                                                              (let-values (((a_40)
                                                                                                            (car a_38)))
                                                                                                a_40))
                                                                                             ((make_4
                                                                                               ?_13
                                                                                               -ref_13
                                                                                               -set!_13)
                                                                                              (let-values (((d_40)
                                                                                                            (cdr a_38)))
                                                                                                (let-values (((make_5)
                                                                                                              (let-values (((a_88)
                                                                                                                            (car
                                                                                                                             d_40)))
                                                                                                                a_88))
                                                                                                             ((?_14
                                                                                                               -ref_14
                                                                                                               -set!_14)
                                                                                                              (let-values (((d_82)
                                                                                                                            (cdr
                                                                                                                             d_40)))
                                                                                                                (let-values (((?_15)
                                                                                                                              (let-values (((a_89)
                                                                                                                                            (car
                                                                                                                                             d_82)))
                                                                                                                                a_89))
                                                                                                                             ((-ref_15
                                                                                                                               -set!_15)
                                                                                                                              (let-values (((d_83)
                                                                                                                                            (cdr
                                                                                                                                             d_82)))
                                                                                                                                (let-values (((-ref_16)
                                                                                                                                              (let-values (((a_90)
                                                                                                                                                            (car
                                                                                                                                                             d_83)))
                                                                                                                                                a_90))
                                                                                                                                             ((-set!_16)
                                                                                                                                              (let-values (((d_84)
                                                                                                                                                            (cdr
                                                                                                                                                             d_83)))
                                                                                                                                                (let-values (((a_91)
                                                                                                                                                              (car
                                                                                                                                                               d_84)))
                                                                                                                                                  a_91))))
                                                                                                                                  (values
                                                                                                                                   -ref_16
                                                                                                                                   -set!_16)))))
                                                                                                                  (values
                                                                                                                   ?_15
                                                                                                                   -ref_15
                                                                                                                   -set!_15)))))
                                                                                                  (values
                                                                                                   make_5
                                                                                                   ?_14
                                                                                                   -ref_14
                                                                                                   -set!_14)))))
                                                                                  (values
                                                                                   struct:_13
                                                                                   make_4
                                                                                   ?_13
                                                                                   -ref_13
                                                                                   -set!_13))))
                                                                             ((rhs_9)
                                                                              (let-values (((d_85) (cdr a_87)))
                                                                                (let-values (((a_92) (car d_85)))
                                                                                  a_92))))
                                                                  (values
                                                                   struct:_12
                                                                   make_3
                                                                   ?_12
                                                                   -ref_12
                                                                   -set!_12
                                                                   rhs_9)))))
                                                           ((struct:2_2 make2_2 ?2_2 make-acc/muts_2)
                                                            (let-values (((d_86) (cdr d_81)))
                                                              (let-values (((a_93) (car d_86)))
                                                                (let-values (((d_87) (cdr a_93)))
                                                                  (let-values (((struct:2_3)
                                                                                (let-values (((a_94) (car d_87))) a_94))
                                                                               ((make2_3 ?2_3 make-acc/muts_3)
                                                                                (let-values (((d_88) (cdr d_87)))
                                                                                  (let-values (((make2_4)
                                                                                                (let-values (((a_95)
                                                                                                              (car
                                                                                                               d_88)))
                                                                                                  a_95))
                                                                                               ((?2_4 make-acc/muts_4)
                                                                                                (let-values (((d_89)
                                                                                                              (cdr
                                                                                                               d_88)))
                                                                                                  (let-values (((?2_5)
                                                                                                                (let-values (((a_96)
                                                                                                                              (car
                                                                                                                               d_89)))
                                                                                                                  a_96))
                                                                                                               ((make-acc/muts_5)
                                                                                                                (let-values (((d_90)
                                                                                                                              (cdr
                                                                                                                               d_89)))
                                                                                                                  d_90)))
                                                                                                    (values
                                                                                                     ?2_5
                                                                                                     make-acc/muts_5)))))
                                                                                    (values
                                                                                     make2_4
                                                                                     ?2_4
                                                                                     make-acc/muts_4)))))
                                                                    (values
                                                                     struct:2_3
                                                                     make2_3
                                                                     ?2_3
                                                                     make-acc/muts_3)))))))
                                                (values
                                                 struct:_11
                                                 make_2
                                                 ?_11
                                                 -ref_11
                                                 -set!_11
                                                 rhs_8
                                                 struct:2_2
                                                 make2_2
                                                 ?2_2
                                                 make-acc/muts_2)))))))
                            (values
                             struct:s_1
                             make-s_1
                             s?_1
                             acc/muts_1
                             struct:_10
                             make_1
                             ?_10
                             -ref_10
                             -set!_10
                             rhs_7
                             struct:2_1
                             make2_1
                             ?2_1
                             make-acc/muts_1)))))
            (let-values (((info_0)
                          (if (eq? struct:_9 struct:2_0)
                            (if (eq? make_0 make2_0)
                              (if (eq? ?_9 ?2_0) (make-struct-type-info rhs_6 knowns_4 imports_3 mutated_2) #f)
                              #f)
                            #f)))
              (if info_0
                (let-values ()
                  (let-values (((type_0) (gensym (symbol->string make-s_0))))
                    (let-values (((knowns_5)
                                  (hash-set
                                   knowns_4
                                   make-s_0
                                   (if (struct-type-info-pure-constructor? info_0)
                                     (known-constructor type_0 (struct-type-info-field-count info_0))
                                     a-known-procedure))))
                      (let-values (((knowns_6) (hash-set knowns_5 s?_0 (known-predicate type_0))))
                        (let-values (((knowns_7)
                                      (let-values (((lst_26) acc/muts_0) ((lst_27) make-acc/muts_0))
                                        (begin
                                          (check-list lst_26)
                                          (check-list lst_27)
                                          ((letrec-values (((for-loop_13)
                                                            (lambda (knowns_8 lst_18 lst_28)
                                                              (if (if (pair? lst_18) (pair? lst_28) #f)
                                                                (let-values (((id_2) (unsafe-car lst_18))
                                                                             ((rest_17) (unsafe-cdr lst_18))
                                                                             ((maker_0) (unsafe-car lst_28))
                                                                             ((rest_13) (unsafe-cdr lst_28)))
                                                                  (let-values (((knowns_9)
                                                                                (let-values (((knowns_10) knowns_8))
                                                                                  (let-values (((knowns_11)
                                                                                                (let-values ()
                                                                                                  (if (eq?
                                                                                                       (car maker_0)
                                                                                                       -ref_9)
                                                                                                    (let-values ()
                                                                                                      (hash-set
                                                                                                       knowns_10
                                                                                                       id_2
                                                                                                       (known-accessor
                                                                                                        type_0)))
                                                                                                    (let-values ()
                                                                                                      (hash-set
                                                                                                       knowns_10
                                                                                                       id_2
                                                                                                       (known-mutator
                                                                                                        type_0)))))))
                                                                                    (values knowns_11)))))
                                                                    (if (not #f)
                                                                      (for-loop_13 knowns_9 rest_17 rest_13)
                                                                      knowns_9)))
                                                                knowns_8))))
                                             for-loop_13)
                                           knowns_6
                                           lst_26
                                           lst_27)))))
                          (hash-set
                           knowns_7
                           struct:s_0
                           (known-struct-type type_0 (struct-type-info-field-count info_0))))))))
                (let-values () knowns_4))))
          (if (if (pair? v_29)
                (if (let-values (((a_47) (car v_29))) (equal? 'define-values a_47))
                  (let-values (((d_45) (cdr v_29)))
                    (if (pair? d_45)
                      (if (let-values (((a_48) (car d_45)))
                            (if (pair? a_48)
                              (if (let-values (((a_97) (car a_48))) #t)
                                (let-values (((d_91) (cdr a_48)))
                                  (if (pair? d_91)
                                    (if (let-values (((a_98) (car d_91))) #t)
                                      (let-values (((d_92) (cdr d_91)))
                                        (if (pair? d_92)
                                          (if (let-values (((a_99) (car d_92))) #t)
                                            (let-values (((d_93) (cdr d_92)))
                                              (if (pair? d_93)
                                                (if (let-values (((a_100) (car d_93))) #t)
                                                  (let-values (((d_94) (cdr d_93)))
                                                    (if (pair? d_94)
                                                      (if (let-values (((a_101) (car d_94))) #t)
                                                        (let-values (((d_95) (cdr d_94))) (equal? '() d_95))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f))
                                            #f)
                                          #f))
                                      #f)
                                    #f))
                                #f)
                              #f))
                        (let-values (((d_96) (cdr d_45)))
                          (if (pair? d_96)
                            (if (let-values (((a_102) (car d_96))) #t)
                              (let-values (((d_97) (cdr d_96))) (equal? '() d_97))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((struct:s_3 make-s_4 s?_5 s-ref_0 s-set!_0 rhs_10)
                          (let-values (((d_98) (cdr v_29)))
                            (let-values (((struct:s_4 make-s_5 s?_6 s-ref_1 s-set!_1)
                                          (let-values (((a_103) (car d_98)))
                                            (let-values (((struct:s_5) (let-values (((a_51) (car a_103))) a_51))
                                                         ((make-s_6 s?_7 s-ref_2 s-set!_2)
                                                          (let-values (((d_50) (cdr a_103)))
                                                            (let-values (((make-s_7)
                                                                          (let-values (((a_104) (car d_50))) a_104))
                                                                         ((s?_8 s-ref_3 s-set!_3)
                                                                          (let-values (((d_99) (cdr d_50)))
                                                                            (let-values (((s?_9)
                                                                                          (let-values (((a_105)
                                                                                                        (car d_99)))
                                                                                            a_105))
                                                                                         ((s-ref_4 s-set!_4)
                                                                                          (let-values (((d_100)
                                                                                                        (cdr d_99)))
                                                                                            (let-values (((s-ref_5)
                                                                                                          (let-values (((a_54)
                                                                                                                        (car
                                                                                                                         d_100)))
                                                                                                            a_54))
                                                                                                         ((s-set!_5)
                                                                                                          (let-values (((d_52)
                                                                                                                        (cdr
                                                                                                                         d_100)))
                                                                                                            (let-values (((a_55)
                                                                                                                          (car
                                                                                                                           d_52)))
                                                                                                              a_55))))
                                                                                              (values
                                                                                               s-ref_5
                                                                                               s-set!_5)))))
                                                                              (values s?_9 s-ref_4 s-set!_4)))))
                                                              (values make-s_7 s?_8 s-ref_3 s-set!_3)))))
                                              (values struct:s_5 make-s_6 s?_7 s-ref_2 s-set!_2))))
                                         ((rhs_11)
                                          (let-values (((d_53) (cdr d_98))) (let-values (((a_106) (car d_53))) a_106))))
                              (values struct:s_4 make-s_5 s?_6 s-ref_1 s-set!_1 rhs_11)))))
              (let-values (((info_1) (make-struct-type-info rhs_10 knowns_4 imports_3 mutated_2)))
                (if info_1
                  (let-values ()
                    (let-values (((type_1) (gensym (symbol->string make-s_4))))
                      (let-values (((knowns_12)
                                    (hash-set
                                     knowns_4
                                     make-s_4
                                     (if (struct-type-info-pure-constructor? info_1)
                                       (known-constructor type_1 (struct-type-info-field-count info_1))
                                       a-known-procedure))))
                        (let-values (((knowns_13) (hash-set knowns_12 s?_5 (known-predicate type_1))))
                          (hash-set
                           knowns_13
                           struct:s_3
                           (known-struct-type type_1 (struct-type-info-field-count info_1)))))))
                  (let-values () knowns_4))))
            (let-values () knowns_4)))))))
 (define-values
  (lambda?)
  (lambda (v_30)
    (let-values (((v_31) v_30))
      (if (if (pair? v_31)
            (if (let-values (((a_107) (car v_31))) (equal? 'lambda a_107)) (let-values (((d_101) (cdr v_31))) #t) #f)
            #f)
        (let-values () #t)
        (if (if (pair? v_31)
              (if (let-values (((a_58) (car v_31))) (equal? 'case-lambda a_58))
                (let-values (((d_55) (cdr v_31))) #t)
                #f)
              #f)
          (let-values () #t)
          (if (if (pair? v_31)
                (if (let-values (((a_108) (car v_31))) (equal? 'let-values a_108))
                  (let-values (((d_102) (cdr v_31)))
                    (if (pair? d_102)
                      (if (let-values (((a_109) (car d_102)))
                            (if (pair? a_109)
                              (if (let-values (((a_110) (car a_109)))
                                    (if (pair? a_110)
                                      (if (let-values (((a_59) (car a_110)))
                                            (if (pair? a_59)
                                              (if (let-values (((a_111) (car a_59))) #t)
                                                (let-values (((d_103) (cdr a_59))) (equal? '() d_103))
                                                #f)
                                              #f))
                                        (let-values (((d_104) (cdr a_110)))
                                          (if (pair? d_104)
                                            (if (let-values (((a_112) (car d_104))) #t)
                                              (let-values (((d_105) (cdr d_104))) (equal? '() d_105))
                                              #f)
                                            #f))
                                        #f)
                                      #f))
                                (let-values (((d_106) (cdr a_109))) (equal? '() d_106))
                                #f)
                              #f))
                        (let-values (((d_107) (cdr d_102)))
                          (if (pair? d_107)
                            (if (let-values (((a_113) (car d_107))) #t)
                              (let-values (((d_108) (cdr d_107))) (equal? '() d_108))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((id1_0 rhs_12 id2_0)
                          (let-values (((d_109) (cdr v_31)))
                            (let-values (((id1_1 rhs_13)
                                          (let-values (((a_114) (car d_109)))
                                            (let-values (((a_115) (car a_114)))
                                              (let-values (((id1_2)
                                                            (let-values (((a_116) (car a_115)))
                                                              (let-values (((a_117) (car a_116))) a_117)))
                                                           ((rhs_14)
                                                            (let-values (((d_110) (cdr a_115)))
                                                              (let-values (((a_118) (car d_110))) a_118))))
                                                (values id1_2 rhs_14)))))
                                         ((id2_1)
                                          (let-values (((d_111) (cdr d_109)))
                                            (let-values (((a_119) (car d_111))) a_119))))
                              (values id1_1 rhs_13 id2_1)))))
              (if (eq? id1_0 id2_0) (lambda? rhs_12) #f))
            (if (if (pair? v_31)
                  (if (let-values (((a_120) (car v_31))) (equal? 'letrec-values a_120))
                    (let-values (((d_112) (cdr v_31)))
                      (if (pair? d_112)
                        (if (let-values (((a_121) (car d_112)))
                              (if (pair? a_121)
                                (if (let-values (((a_122) (car a_121)))
                                      (if (pair? a_122)
                                        (if (let-values (((a_123) (car a_122)))
                                              (if (pair? a_123)
                                                (if (let-values (((a_124) (car a_123))) #t)
                                                  (let-values (((d_113) (cdr a_123))) (equal? '() d_113))
                                                  #f)
                                                #f))
                                          (let-values (((d_114) (cdr a_122)))
                                            (if (pair? d_114)
                                              (if (let-values (((a_125) (car d_114))) #t)
                                                (let-values (((d_115) (cdr d_114))) (equal? '() d_115))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                  (let-values (((d_116) (cdr a_121))) (equal? '() d_116))
                                  #f)
                                #f))
                          (let-values (((d_117) (cdr d_112)))
                            (if (pair? d_117)
                              (if (let-values (((a_126) (car d_117))) #t)
                                (let-values (((d_118) (cdr d_117))) (equal? '() d_118))
                                #f)
                              #f))
                          #f)
                        #f))
                    #f)
                  #f)
              (let-values (((id1_3 rhs_15 id2_2)
                            (let-values (((d_119) (cdr v_31)))
                              (let-values (((id1_4 rhs_16)
                                            (let-values (((a_127) (car d_119)))
                                              (let-values (((a_128) (car a_127)))
                                                (let-values (((id1_5)
                                                              (let-values (((a_129) (car a_128)))
                                                                (let-values (((a_130) (car a_129))) a_130)))
                                                             ((rhs_17)
                                                              (let-values (((d_120) (cdr a_128)))
                                                                (let-values (((a_131) (car d_120))) a_131))))
                                                  (values id1_5 rhs_17)))))
                                           ((id2_3)
                                            (let-values (((d_121) (cdr d_119)))
                                              (let-values (((a_132) (car d_121))) a_132))))
                                (values id1_4 rhs_16 id2_3)))))
                (if (eq? id1_3 id2_2) (lambda? rhs_15) #f))
              (if (if (pair? v_31)
                    (if (let-values (((a_133) (car v_31))) (equal? 'let-values a_133))
                      (let-values (((d_122) (cdr v_31)))
                        (if (pair? d_122)
                          (if (let-values (((a_134) (car d_122))) #t)
                            (let-values (((d_123) (cdr d_122)))
                              (if (pair? d_123)
                                (if (let-values (((a_135) (car d_123))) #t)
                                  (let-values (((d_124) (cdr d_123))) (equal? '() d_124))
                                  #f)
                                #f))
                            #f)
                          #f))
                      #f)
                    #f)
                (let-values (((body_9)
                              (let-values (((d_125) (cdr v_31)))
                                (let-values (((d_126) (cdr d_125))) (let-values (((a_136) (car d_126))) a_136)))))
                  (lambda? body_9))
                (if (if (pair? v_31)
                      (if (let-values (((a_137) (car v_31))) (equal? 'letrec-values a_137))
                        (let-values (((d_127) (cdr v_31)))
                          (if (pair? d_127)
                            (if (let-values (((a_138) (car d_127))) #t)
                              (let-values (((d_128) (cdr d_127)))
                                (if (pair? d_128)
                                  (if (let-values (((a_139) (car d_128))) #t)
                                    (let-values (((d_129) (cdr d_128))) (equal? '() d_129))
                                    #f)
                                  #f))
                              #f)
                            #f))
                        #f)
                      #f)
                  (let-values (((body_10)
                                (let-values (((d_130) (cdr v_31)))
                                  (let-values (((d_131) (cdr d_130))) (let-values (((a_140) (car d_131))) a_140)))))
                    (lambda? body_10))
                  (let-values () #f))))))))))
 (define-values
  (mutated-in-body)
  (lambda (l_0 exports_0 prim-knowns_0 knowns_3 imports_2)
    (let-values (((mutated_1) (make-hasheq)))
      (begin
        (let-values (((ht_2) exports_0))
          (begin
            (check-in-hash-keys ht_2)
            ((letrec-values (((for-loop_14)
                              (lambda (i_1)
                                (if i_1
                                  (let-values (((id_3) (hash-iterate-key ht_2 i_1)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (hash-set! mutated_1 id_3 'not-ready))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_14 (hash-iterate-next ht_2 i_1)) (values))))
                                  (values)))))
               for-loop_14)
             (hash-iterate-first ht_2))))
        (void)
        (let-values (((lst_29) l_0))
          (begin
            (check-list lst_29)
            ((letrec-values (((for-loop_15)
                              (lambda (lst_30)
                                (if (pair? lst_30)
                                  (let-values (((form_0) (unsafe-car lst_30)) ((rest_18) (unsafe-cdr lst_30)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (let-values (((v_32) form_0))
                                                                          (if (if (pair? v_32)
                                                                                (if (let-values (((a_141) (car v_32)))
                                                                                      (equal? 'define-values a_141))
                                                                                  (let-values (((d_132) (cdr v_32)))
                                                                                    (if (pair? d_132)
                                                                                      (if (let-values (((a_142)
                                                                                                        (car d_132)))
                                                                                            #t)
                                                                                        (let-values (((d_133)
                                                                                                      (cdr d_132)))
                                                                                          (if (pair? d_133)
                                                                                            (if (let-values (((a_63)
                                                                                                              (car
                                                                                                               d_133)))
                                                                                                  #t)
                                                                                              (let-values (((d_60)
                                                                                                            (cdr
                                                                                                             d_133)))
                                                                                                (equal? '() d_60))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_8 rhs_18)
                                                                                          (let-values (((d_61)
                                                                                                        (cdr v_32)))
                                                                                            (let-values (((ids_9)
                                                                                                          (let-values (((a_143)
                                                                                                                        (car
                                                                                                                         d_61)))
                                                                                                            a_143))
                                                                                                         ((rhs_19)
                                                                                                          (let-values (((d_134)
                                                                                                                        (cdr
                                                                                                                         d_61)))
                                                                                                            (let-values (((a_25)
                                                                                                                          (car
                                                                                                                           d_134)))
                                                                                                              a_25))))
                                                                                              (values ids_9 rhs_19)))))
                                                                              (begin
                                                                                (let-values (((lst_31) ids_8))
                                                                                  (begin
                                                                                    (check-list lst_31)
                                                                                    ((letrec-values (((for-loop_16)
                                                                                                      (lambda (lst_32)
                                                                                                        (if (pair?
                                                                                                             lst_32)
                                                                                                          (let-values (((id_4)
                                                                                                                        (unsafe-car
                                                                                                                         lst_32))
                                                                                                                       ((rest_19)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_32)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (hash-set!
                                                                                                                                                 mutated_1
                                                                                                                                                 id_4
                                                                                                                                                 'not-ready))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_16
                                                                                                                 rest_19)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_16)
                                                                                     lst_31)))
                                                                                (void)))
                                                                            (let-values () (void)))))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_15 rest_18) (values))))
                                  (values)))))
               for-loop_15)
             lst_29)))
        (void)
        (let-values (((lst_33) l_0))
          (begin
            (check-list lst_33)
            ((letrec-values (((for-loop_17)
                              (lambda (prev-knowns_0 lst_34)
                                (if (pair? lst_34)
                                  (let-values (((form_1) (unsafe-car lst_34)) ((rest_20) (unsafe-cdr lst_34)))
                                    (let-values (((prev-knowns_1)
                                                  (let-values (((prev-knowns_2) prev-knowns_0))
                                                    (let-values (((prev-knowns_3)
                                                                  (let-values ()
                                                                    (let-values (((knowns_14)
                                                                                  (find-definitions
                                                                                   form_1
                                                                                   prim-knowns_0
                                                                                   prev-knowns_2
                                                                                   imports_2
                                                                                   mutated_1)))
                                                                      (begin
                                                                        (let-values (((v_14) form_1))
                                                                          (if (if (pair? v_14)
                                                                                (if (let-values (((a_144) (car v_14)))
                                                                                      (equal? 'define-values a_144))
                                                                                  (let-values (((d_135) (cdr v_14)))
                                                                                    (if (pair? d_135)
                                                                                      (if (let-values (((a_145)
                                                                                                        (car d_135)))
                                                                                            #t)
                                                                                        (let-values (((d_71)
                                                                                                      (cdr d_135)))
                                                                                          (if (pair? d_71)
                                                                                            (if (let-values (((a_3)
                                                                                                              (car
                                                                                                               d_71)))
                                                                                                  #t)
                                                                                              (let-values (((d_0)
                                                                                                            (cdr d_71)))
                                                                                                (equal? '() d_0))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_10 rhs_20)
                                                                                          (let-values (((d_1)
                                                                                                        (cdr v_14)))
                                                                                            (let-values (((ids_11)
                                                                                                          (let-values (((a_29)
                                                                                                                        (car
                                                                                                                         d_1)))
                                                                                                            a_29))
                                                                                                         ((rhs_21)
                                                                                                          (let-values (((d_74)
                                                                                                                        (cdr
                                                                                                                         d_1)))
                                                                                                            (let-values (((a_81)
                                                                                                                          (car
                                                                                                                           d_74)))
                                                                                                              a_81))))
                                                                                              (values ids_11 rhs_21)))))
                                                                              (begin
                                                                                (find-mutated!
                                                                                 rhs_20
                                                                                 ids_10
                                                                                 prim-knowns_0
                                                                                 knowns_14
                                                                                 imports_2
                                                                                 mutated_1)
                                                                                (let-values (((lst_35) ids_10))
                                                                                  (begin
                                                                                    (check-list lst_35)
                                                                                    ((letrec-values (((for-loop_18)
                                                                                                      (lambda (lst_36)
                                                                                                        (if (pair?
                                                                                                             lst_36)
                                                                                                          (let-values (((id_5)
                                                                                                                        (unsafe-car
                                                                                                                         lst_36))
                                                                                                                       ((rest_21)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_36)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (if (eq?
                                                                                                                                                     'not-ready
                                                                                                                                                     (hash-ref
                                                                                                                                                      mutated_1
                                                                                                                                                      id_5
                                                                                                                                                      #f))
                                                                                                                                                  (let-values ()
                                                                                                                                                    (hash-remove!
                                                                                                                                                     mutated_1
                                                                                                                                                     id_5))
                                                                                                                                                  (void)))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_18
                                                                                                                 rest_21)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_18)
                                                                                     lst_35)))
                                                                                (void)))
                                                                            (let-values ()
                                                                              (find-mutated!
                                                                               form_1
                                                                               #f
                                                                               prim-knowns_0
                                                                               knowns_14
                                                                               imports_2
                                                                               mutated_1))))
                                                                        knowns_14)))))
                                                      (values prev-knowns_3)))))
                                      (if (not #f) (for-loop_17 prev-knowns_1 rest_20) prev-knowns_1)))
                                  prev-knowns_0))))
               for-loop_17)
             knowns_3
             lst_33)))
        (let-values (((lst_37) l_0))
          (begin
            (check-list lst_37)
            ((letrec-values (((for-loop_19)
                              (lambda (lst_38)
                                (if (pair? lst_38)
                                  (let-values (((form_2) (unsafe-car lst_38)) ((rest_0) (unsafe-cdr lst_38)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (let-values (((v_33) form_2))
                                                                          (if (if (pair? v_33)
                                                                                (if (let-values (((a_146) (car v_33)))
                                                                                      (equal? 'define-values a_146))
                                                                                  (let-values (((d_136) (cdr v_33)))
                                                                                    (if (pair? d_136)
                                                                                      (if (let-values (((a_147)
                                                                                                        (car d_136)))
                                                                                            #t)
                                                                                        (let-values (((d_137)
                                                                                                      (cdr d_136)))
                                                                                          (if (pair? d_137)
                                                                                            (if (let-values (((a_11)
                                                                                                              (car
                                                                                                               d_137)))
                                                                                                  #t)
                                                                                              (let-values (((d_9)
                                                                                                            (cdr
                                                                                                             d_137)))
                                                                                                (equal? '() d_9))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_12 rhs_22)
                                                                                          (let-values (((d_78)
                                                                                                        (cdr v_33)))
                                                                                            (let-values (((ids_13)
                                                                                                          (let-values (((a_13)
                                                                                                                        (car
                                                                                                                         d_78)))
                                                                                                            a_13))
                                                                                                         ((rhs_23)
                                                                                                          (let-values (((d_11)
                                                                                                                        (cdr
                                                                                                                         d_78)))
                                                                                                            (let-values (((a_148)
                                                                                                                          (car
                                                                                                                           d_11)))
                                                                                                              a_148))))
                                                                                              (values ids_13 rhs_23)))))
                                                                              (begin
                                                                                (let-values (((lst_39) ids_12))
                                                                                  (begin
                                                                                    (check-list lst_39)
                                                                                    ((letrec-values (((for-loop_20)
                                                                                                      (lambda (lst_40)
                                                                                                        (if (pair?
                                                                                                             lst_40)
                                                                                                          (let-values (((id_6)
                                                                                                                        (unsafe-car
                                                                                                                         lst_40))
                                                                                                                       ((rest_22)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_40)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((state_0)
                                                                                                                                                              (hash-ref
                                                                                                                                                               mutated_1
                                                                                                                                                               id_6
                                                                                                                                                               #f)))
                                                                                                                                                  (if (delayed?
                                                                                                                                                       state_0)
                                                                                                                                                    (let-values ()
                                                                                                                                                      (begin
                                                                                                                                                        (hash-remove!
                                                                                                                                                         mutated_1
                                                                                                                                                         id_6)
                                                                                                                                                        (state_0)))
                                                                                                                                                    (void))))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_20
                                                                                                                 rest_22)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_20)
                                                                                     lst_39)))
                                                                                (void)))
                                                                            (let-values () (void)))))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_19 rest_0) (values))))
                                  (values)))))
               for-loop_19)
             lst_37)))
        (void)
        mutated_1))))
 (define-values
  (find-mutated!)
  (lambda (v_34 ids_14 prim-knowns_2 knowns_15 imports_4 mutated_3)
    (let-values (((delay!_0)
                  (lambda (ids_15 thunk_0)
                    (let-values (((done?_0) #f))
                      (begin
                        (let-values (((lst_41) ids_15))
                          (begin
                            (check-list lst_41)
                            ((letrec-values (((for-loop_21)
                                              (lambda (lst_42)
                                                (if (pair? lst_42)
                                                  (let-values (((id_7) (unsafe-car lst_42))
                                                               ((rest_23) (unsafe-cdr lst_42)))
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (let-values ((()
                                                                                  (let-values ()
                                                                                    (begin
                                                                                      (let-values ()
                                                                                        (if (eq?
                                                                                             'not-ready
                                                                                             (hash-ref
                                                                                              mutated_3
                                                                                              id_7
                                                                                              'not-ready))
                                                                                          (let-values ()
                                                                                            (hash-set!
                                                                                             mutated_3
                                                                                             id_7
                                                                                             (lambda ()
                                                                                               (if done?_0
                                                                                                 (void)
                                                                                                 (let-values ()
                                                                                                   (begin
                                                                                                     (set! done?_0 #t)
                                                                                                     (thunk_0)))))))
                                                                                          (void)))
                                                                                      (values)))))
                                                                      (values)))))
                                                      (if (not #f) (for-loop_21 rest_23) (values))))
                                                  (values)))))
                               for-loop_21)
                             lst_41)))
                        (void))))))
      ((letrec-values (((find-mutated!_0)
                        (lambda (v_35 ids_16)
                          (let-values (((find-mutated!*_0)
                                        (lambda (l_9 ids_17)
                                          ((letrec-values (((loop_5)
                                                            (lambda (l_10)
                                                              (if (null? l_10)
                                                                (let-values () (void))
                                                                (if (null? (cdr l_10))
                                                                  (let-values () (find-mutated!_0 (car l_10) ids_17))
                                                                  (let-values ()
                                                                    (begin
                                                                      (find-mutated!_0 (car l_10) #f)
                                                                      (loop_5 (cdr l_10)))))))))
                                             loop_5)
                                           l_9))))
                            (let-values (((v_36) v_35))
                              (if (if (pair? v_36)
                                    (if (let-values (((a_149) (car v_36))) (equal? 'lambda a_149))
                                      (let-values (((d_138) (cdr v_36)))
                                        (if (pair? d_138)
                                          (if (let-values (((a_150) (car d_138))) #t)
                                            (let-values (((d_139) (cdr d_138))) (list? d_139))
                                            #f)
                                          #f))
                                      #f)
                                    #f)
                                (let-values (((formals_0 body_11)
                                              (let-values (((d_140) (cdr v_36)))
                                                (let-values (((formals_1) (let-values (((a_87) (car d_140))) a_87))
                                                             ((body_12) (let-values (((d_141) (cdr d_140))) d_141)))
                                                  (values formals_1 body_12)))))
                                  (if ids_16
                                    (delay!_0 ids_16 (lambda () (find-mutated!*_0 body_11 #f)))
                                    (find-mutated!*_0 body_11 #f)))
                                (if (if (pair? v_36)
                                      (if (let-values (((a_151) (car v_36))) (equal? 'case-lambda a_151))
                                        (let-values (((d_142) (cdr v_36)))
                                          (if (list? d_142)
                                            (let-values (((lst_43) d_142))
                                              (begin
                                                (check-list lst_43)
                                                ((letrec-values (((for-loop_22)
                                                                  (lambda (result_14 lst_44)
                                                                    (if (pair? lst_44)
                                                                      (let-values (((v_37) (unsafe-car lst_44))
                                                                                   ((rest_24) (unsafe-cdr lst_44)))
                                                                        (let-values (((result_27)
                                                                                      (let-values ()
                                                                                        (let-values (((result_28)
                                                                                                      (let-values ()
                                                                                                        (let-values ()
                                                                                                          (if (pair?
                                                                                                               v_37)
                                                                                                            (if (let-values (((a_40)
                                                                                                                              (car
                                                                                                                               v_37)))
                                                                                                                  #t)
                                                                                                              (let-values (((d_40)
                                                                                                                            (cdr
                                                                                                                             v_37)))
                                                                                                                (list?
                                                                                                                 d_40))
                                                                                                              #f)
                                                                                                            #f)))))
                                                                                          (values result_28)))))
                                                                          (if (if (not
                                                                                   ((lambda x_9 (not result_27)) v_37))
                                                                                (not #f)
                                                                                #f)
                                                                            (for-loop_22 result_27 rest_24)
                                                                            result_27)))
                                                                      result_14))))
                                                   for-loop_22)
                                                 #t
                                                 lst_43)))
                                            #f))
                                        #f)
                                      #f)
                                  (let-values (((formalss_0 bodys_0)
                                                (let-values (((d_41) (cdr v_36)))
                                                  (let-values (((formalss_1 bodys_1)
                                                                (let-values (((lst_45) d_41))
                                                                  (begin
                                                                    (check-list lst_45)
                                                                    ((letrec-values (((for-loop_23)
                                                                                      (lambda (formalss_2
                                                                                               bodys_2
                                                                                               lst_14)
                                                                                        (if (pair? lst_14)
                                                                                          (let-values (((v_38)
                                                                                                        (unsafe-car
                                                                                                         lst_14))
                                                                                                       ((rest_25)
                                                                                                        (unsafe-cdr
                                                                                                         lst_14)))
                                                                                            (let-values (((formalss_3
                                                                                                           bodys_3)
                                                                                                          (let-values (((formalss_4)
                                                                                                                        formalss_2)
                                                                                                                       ((bodys_4)
                                                                                                                        bodys_2))
                                                                                                            (let-values (((formalss_5
                                                                                                                           bodys_5)
                                                                                                                          (let-values ()
                                                                                                                            (let-values (((formalss1_0
                                                                                                                                           bodys2_0)
                                                                                                                                          (let-values ()
                                                                                                                                            (let-values (((formalss_6)
                                                                                                                                                          (let-values (((a_152)
                                                                                                                                                                        (car
                                                                                                                                                                         v_38)))
                                                                                                                                                            a_152))
                                                                                                                                                         ((bodys_6)
                                                                                                                                                          (let-values (((d_143)
                                                                                                                                                                        (cdr
                                                                                                                                                                         v_38)))
                                                                                                                                                            d_143)))
                                                                                                                                              (values
                                                                                                                                               formalss_6
                                                                                                                                               bodys_6)))))
                                                                                                                              (values
                                                                                                                               (cons
                                                                                                                                formalss1_0
                                                                                                                                formalss_4)
                                                                                                                               (cons
                                                                                                                                bodys2_0
                                                                                                                                bodys_4))))))
                                                                                                              (values
                                                                                                               formalss_5
                                                                                                               bodys_5)))))
                                                                                              (if (not #f)
                                                                                                (for-loop_23
                                                                                                 formalss_3
                                                                                                 bodys_3
                                                                                                 rest_25)
                                                                                                (values
                                                                                                 formalss_3
                                                                                                 bodys_3))))
                                                                                          (values
                                                                                           formalss_2
                                                                                           bodys_2)))))
                                                                       for-loop_23)
                                                                     null
                                                                     null
                                                                     lst_45)))))
                                                    (values (reverse$1 formalss_1) (reverse$1 bodys_1))))))
                                    (if ids_16
                                      (delay!_0
                                       ids_16
                                       (lambda ()
                                         (begin
                                           (let-values (((lst_46) bodys_0))
                                             (begin
                                               (check-list lst_46)
                                               ((letrec-values (((for-loop_24)
                                                                 (lambda (lst_47)
                                                                   (if (pair? lst_47)
                                                                     (let-values (((body_13) (unsafe-car lst_47))
                                                                                  ((rest_26) (unsafe-cdr lst_47)))
                                                                       (let-values ((()
                                                                                     (let-values ()
                                                                                       (let-values ((()
                                                                                                     (let-values ()
                                                                                                       (begin
                                                                                                         (let-values ()
                                                                                                           (find-mutated!*_0
                                                                                                            body_13
                                                                                                            #f))
                                                                                                         (values)))))
                                                                                         (values)))))
                                                                         (if (not #f) (for-loop_24 rest_26) (values))))
                                                                     (values)))))
                                                  for-loop_24)
                                                lst_46)))
                                           (void))))
                                      (begin
                                        (let-values (((lst_48) bodys_0))
                                          (begin
                                            (check-list lst_48)
                                            ((letrec-values (((for-loop_25)
                                                              (lambda (lst_16)
                                                                (if (pair? lst_16)
                                                                  (let-values (((body_14) (unsafe-car lst_16))
                                                                               ((rest_27) (unsafe-cdr lst_16)))
                                                                    (let-values ((()
                                                                                  (let-values ()
                                                                                    (let-values ((()
                                                                                                  (let-values ()
                                                                                                    (begin
                                                                                                      (let-values ()
                                                                                                        (find-mutated!*_0
                                                                                                         body_14
                                                                                                         #f))
                                                                                                      (values)))))
                                                                                      (values)))))
                                                                      (if (not #f) (for-loop_25 rest_27) (values))))
                                                                  (values)))))
                                               for-loop_25)
                                             lst_48)))
                                        (void))))
                                  (if (if (pair? v_36)
                                        (if (let-values (((a_153) (car v_36))) (equal? 'quote a_153))
                                          (let-values (((d_144) (cdr v_36)))
                                            (if (pair? d_144)
                                              (if (let-values (((a_154) (car d_144))) #t)
                                                (let-values (((d_145) (cdr d_144))) (equal? '() d_145))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values () (void))
                                    (if (if (pair? v_36)
                                          (if (let-values (((a_155) (car v_36))) (equal? 'let-values a_155))
                                            (let-values (((d_146) (cdr v_36)))
                                              (if (pair? d_146)
                                                (if (let-values (((a_156) (car d_146)))
                                                      (if (list? a_156)
                                                        (let-values (((lst_27) a_156))
                                                          (begin
                                                            (check-list lst_27)
                                                            ((letrec-values (((for-loop_13)
                                                                              (lambda (result_29 lst_18)
                                                                                (if (pair? lst_18)
                                                                                  (let-values (((v_39)
                                                                                                (unsafe-car lst_18))
                                                                                               ((rest_28)
                                                                                                (unsafe-cdr lst_18)))
                                                                                    (let-values (((result_30)
                                                                                                  (let-values ()
                                                                                                    (let-values (((result_31)
                                                                                                                  (let-values ()
                                                                                                                    (let-values ()
                                                                                                                      (if (pair?
                                                                                                                           v_39)
                                                                                                                        (if (let-values (((a_157)
                                                                                                                                          (car
                                                                                                                                           v_39)))
                                                                                                                              #t)
                                                                                                                          (let-values (((d_147)
                                                                                                                                        (cdr
                                                                                                                                         v_39)))
                                                                                                                            (if (pair?
                                                                                                                                 d_147)
                                                                                                                              (if (let-values (((a_158)
                                                                                                                                                (car
                                                                                                                                                 d_147)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_148)
                                                                                                                                              (cdr
                                                                                                                                               d_147)))
                                                                                                                                  (equal?
                                                                                                                                   '()
                                                                                                                                   d_148))
                                                                                                                                #f)
                                                                                                                              #f))
                                                                                                                          #f)
                                                                                                                        #f)))))
                                                                                                      (values
                                                                                                       result_31)))))
                                                                                      (if (if (not
                                                                                               ((lambda x_10
                                                                                                  (not result_30))
                                                                                                v_39))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_13 result_30 rest_28)
                                                                                        result_30)))
                                                                                  result_29))))
                                                               for-loop_13)
                                                             #t
                                                             lst_27)))
                                                        #f))
                                                  (let-values (((d_149) (cdr d_146))) (list? d_149))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((idss_8 rhss_30 bodys_7)
                                                    (let-values (((d_92) (cdr v_36)))
                                                      (let-values (((idss_9 rhss_31)
                                                                    (let-values (((a_159) (car d_92)))
                                                                      (let-values (((idss_10 rhss_32)
                                                                                    (let-values (((lst_49) a_159))
                                                                                      (begin
                                                                                        (check-list lst_49)
                                                                                        ((letrec-values (((for-loop_26)
                                                                                                          (lambda (idss_11
                                                                                                                   rhss_33
                                                                                                                   lst_50)
                                                                                                            (if (pair?
                                                                                                                 lst_50)
                                                                                                              (let-values (((v_40)
                                                                                                                            (unsafe-car
                                                                                                                             lst_50))
                                                                                                                           ((rest_29)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_50)))
                                                                                                                (let-values (((idss_12
                                                                                                                               rhss_25)
                                                                                                                              (let-values (((idss_13)
                                                                                                                                            idss_11)
                                                                                                                                           ((rhss_34)
                                                                                                                                            rhss_33))
                                                                                                                                (let-values (((idss_14
                                                                                                                                               rhss_35)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((idss3_1
                                                                                                                                                               rhss4_1)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((idss_15)
                                                                                                                                                                              (let-values (((a_160)
                                                                                                                                                                                            (car
                                                                                                                                                                                             v_40)))
                                                                                                                                                                                a_160))
                                                                                                                                                                             ((rhss_36)
                                                                                                                                                                              (let-values (((d_150)
                                                                                                                                                                                            (cdr
                                                                                                                                                                                             v_40)))
                                                                                                                                                                                (let-values (((a_161)
                                                                                                                                                                                              (car
                                                                                                                                                                                               d_150)))
                                                                                                                                                                                  a_161))))
                                                                                                                                                                  (values
                                                                                                                                                                   idss_15
                                                                                                                                                                   rhss_36)))))
                                                                                                                                                  (values
                                                                                                                                                   (cons
                                                                                                                                                    idss3_1
                                                                                                                                                    idss_13)
                                                                                                                                                   (cons
                                                                                                                                                    rhss4_1
                                                                                                                                                    rhss_34))))))
                                                                                                                                  (values
                                                                                                                                   idss_14
                                                                                                                                   rhss_35)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_26
                                                                                                                     idss_12
                                                                                                                     rhss_25
                                                                                                                     rest_29)
                                                                                                                    (values
                                                                                                                     idss_12
                                                                                                                     rhss_25))))
                                                                                                              (values
                                                                                                               idss_11
                                                                                                               rhss_33)))))
                                                                                           for-loop_26)
                                                                                         null
                                                                                         null
                                                                                         lst_49)))))
                                                                        (values
                                                                         (reverse$1 idss_10)
                                                                         (reverse$1 rhss_32)))))
                                                                   ((bodys_8)
                                                                    (let-values (((d_151) (cdr d_92))) d_151)))
                                                        (values idss_9 rhss_31 bodys_8)))))
                                        (begin
                                          (let-values (((lst_51) idss_8) ((lst_52) rhss_30))
                                            (begin
                                              (check-list lst_51)
                                              (check-list lst_52)
                                              ((letrec-values (((for-loop_27)
                                                                (lambda (lst_53 lst_54)
                                                                  (if (if (pair? lst_53) (pair? lst_54) #f)
                                                                    (let-values (((ids_18) (unsafe-car lst_53))
                                                                                 ((rest_30) (unsafe-cdr lst_53))
                                                                                 ((rhs_24) (unsafe-car lst_54))
                                                                                 ((rest_31) (unsafe-cdr lst_54)))
                                                                      (let-values ((()
                                                                                    (let-values ()
                                                                                      (let-values ((()
                                                                                                    (let-values ()
                                                                                                      (begin
                                                                                                        (let-values ()
                                                                                                          (find-mutated!_0
                                                                                                           rhs_24
                                                                                                           ids_18))
                                                                                                        (values)))))
                                                                                        (values)))))
                                                                        (if (not #f)
                                                                          (for-loop_27 rest_30 rest_31)
                                                                          (values))))
                                                                    (values)))))
                                                 for-loop_27)
                                               lst_51
                                               lst_52)))
                                          (void)
                                          (find-mutated!*_0 bodys_7 ids_16)))
                                      (if (if (pair? v_36)
                                            (if (let-values (((a_162) (car v_36))) (equal? 'letrec-values a_162))
                                              (let-values (((d_152) (cdr v_36)))
                                                (if (pair? d_152)
                                                  (if (let-values (((a_163) (car d_152)))
                                                        (if (list? a_163)
                                                          (let-values (((lst_55) a_163))
                                                            (begin
                                                              (check-list lst_55)
                                                              ((letrec-values (((for-loop_28)
                                                                                (lambda (result_23 lst_56)
                                                                                  (if (pair? lst_56)
                                                                                    (let-values (((v_41)
                                                                                                  (unsafe-car lst_56))
                                                                                                 ((rest_32)
                                                                                                  (unsafe-cdr lst_56)))
                                                                                      (let-values (((result_32)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_33)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (if (pair?
                                                                                                                             v_41)
                                                                                                                          (if (let-values (((a_164)
                                                                                                                                            (car
                                                                                                                                             v_41)))
                                                                                                                                #t)
                                                                                                                            (let-values (((d_153)
                                                                                                                                          (cdr
                                                                                                                                           v_41)))
                                                                                                                              (if (pair?
                                                                                                                                   d_153)
                                                                                                                                (if (let-values (((a_165)
                                                                                                                                                  (car
                                                                                                                                                   d_153)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_154)
                                                                                                                                                (cdr
                                                                                                                                                 d_153)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_154))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                            #f)
                                                                                                                          #f)))))
                                                                                                        (values
                                                                                                         result_33)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_11
                                                                                                    (not result_32))
                                                                                                  v_41))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_28
                                                                                           result_32
                                                                                           rest_32)
                                                                                          result_32)))
                                                                                    result_23))))
                                                                 for-loop_28)
                                                               #t
                                                               lst_55)))
                                                          #f))
                                                    (let-values (((d_155) (cdr d_152))) (list? d_155))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((idss_16 rhss_37 bodys_9)
                                                      (let-values (((d_55) (cdr v_36)))
                                                        (let-values (((idss_17 rhss_38)
                                                                      (let-values (((a_110) (car d_55)))
                                                                        (let-values (((idss_18 rhss_39)
                                                                                      (let-values (((lst_57) a_110))
                                                                                        (begin
                                                                                          (check-list lst_57)
                                                                                          ((letrec-values (((for-loop_29)
                                                                                                            (lambda (idss_19
                                                                                                                     rhss_40
                                                                                                                     lst_25)
                                                                                                              (if (pair?
                                                                                                                   lst_25)
                                                                                                                (let-values (((v_42)
                                                                                                                              (unsafe-car
                                                                                                                               lst_25))
                                                                                                                             ((rest_16)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_25)))
                                                                                                                  (let-values (((idss_20
                                                                                                                                 rhss_41)
                                                                                                                                (let-values (((idss_21)
                                                                                                                                              idss_19)
                                                                                                                                             ((rhss_42)
                                                                                                                                              rhss_40))
                                                                                                                                  (let-values (((idss_22
                                                                                                                                                 rhss_43)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values (((idss5_0
                                                                                                                                                                 rhss6_1)
                                                                                                                                                                (let-values ()
                                                                                                                                                                  (let-values (((idss_23)
                                                                                                                                                                                (let-values (((a_166)
                                                                                                                                                                                              (car
                                                                                                                                                                                               v_42)))
                                                                                                                                                                                  a_166))
                                                                                                                                                                               ((rhss_44)
                                                                                                                                                                                (let-values (((d_156)
                                                                                                                                                                                              (cdr
                                                                                                                                                                                               v_42)))
                                                                                                                                                                                  (let-values (((a_116)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 d_156)))
                                                                                                                                                                                    a_116))))
                                                                                                                                                                    (values
                                                                                                                                                                     idss_23
                                                                                                                                                                     rhss_44)))))
                                                                                                                                                    (values
                                                                                                                                                     (cons
                                                                                                                                                      idss5_0
                                                                                                                                                      idss_21)
                                                                                                                                                     (cons
                                                                                                                                                      rhss6_1
                                                                                                                                                      rhss_42))))))
                                                                                                                                    (values
                                                                                                                                     idss_22
                                                                                                                                     rhss_43)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_29
                                                                                                                       idss_20
                                                                                                                       rhss_41
                                                                                                                       rest_16)
                                                                                                                      (values
                                                                                                                       idss_20
                                                                                                                       rhss_41))))
                                                                                                                (values
                                                                                                                 idss_19
                                                                                                                 rhss_40)))))
                                                                                             for-loop_29)
                                                                                           null
                                                                                           null
                                                                                           lst_57)))))
                                                                          (values
                                                                           (reverse$1 idss_18)
                                                                           (reverse$1 rhss_39)))))
                                                                     ((bodys_10)
                                                                      (let-values (((d_157) (cdr d_55))) d_157)))
                                                          (values idss_17 rhss_38 bodys_10)))))
                                          (begin
                                            (let-values (((lst_58) idss_16))
                                              (begin
                                                (check-list lst_58)
                                                ((letrec-values (((for-loop_30)
                                                                  (lambda (lst_59)
                                                                    (if (pair? lst_59)
                                                                      (let-values (((ids_19) (unsafe-car lst_59))
                                                                                   ((rest_33) (unsafe-cdr lst_59)))
                                                                        (let-values ((()
                                                                                      (let-values (((lst_60) ids_19))
                                                                                        (begin
                                                                                          (check-list lst_60)
                                                                                          ((letrec-values (((for-loop_31)
                                                                                                            (lambda (lst_61)
                                                                                                              (if (pair?
                                                                                                                   lst_61)
                                                                                                                (let-values (((id_8)
                                                                                                                              (unsafe-car
                                                                                                                               lst_61))
                                                                                                                             ((rest_34)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_61)))
                                                                                                                  (let-values ((()
                                                                                                                                (let-values ()
                                                                                                                                  (let-values ((()
                                                                                                                                                (let-values ()
                                                                                                                                                  (begin
                                                                                                                                                    (let-values ()
                                                                                                                                                      (hash-set!
                                                                                                                                                       mutated_3
                                                                                                                                                       id_8
                                                                                                                                                       'not-ready))
                                                                                                                                                    (values)))))
                                                                                                                                    (values)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_31
                                                                                                                       rest_34)
                                                                                                                      (values))))
                                                                                                                (values)))))
                                                                                             for-loop_31)
                                                                                           lst_60)))))
                                                                          (if (not #f) (for-loop_30 rest_33) (values))))
                                                                      (values)))))
                                                   for-loop_30)
                                                 lst_58)))
                                            (void)
                                            (let-values (((lst_62) idss_16) ((lst_63) rhss_37))
                                              (begin
                                                (check-list lst_62)
                                                (check-list lst_63)
                                                ((letrec-values (((for-loop_32)
                                                                  (lambda (lst_64 lst_65)
                                                                    (if (if (pair? lst_64) (pair? lst_65) #f)
                                                                      (let-values (((ids_20) (unsafe-car lst_64))
                                                                                   ((rest_35) (unsafe-cdr lst_64))
                                                                                   ((rhs_25) (unsafe-car lst_65))
                                                                                   ((rest_36) (unsafe-cdr lst_65)))
                                                                        (let-values ((()
                                                                                      (let-values ()
                                                                                        (let-values ((()
                                                                                                      (let-values ()
                                                                                                        (begin
                                                                                                          (let-values ()
                                                                                                            (begin
                                                                                                              (find-mutated!_0
                                                                                                               rhs_25
                                                                                                               ids_20)
                                                                                                              (let-values (((lst_66)
                                                                                                                            ids_20))
                                                                                                                (begin
                                                                                                                  (check-list
                                                                                                                   lst_66)
                                                                                                                  ((letrec-values (((for-loop_33)
                                                                                                                                    (lambda (lst_67)
                                                                                                                                      (if (pair?
                                                                                                                                           lst_67)
                                                                                                                                        (let-values (((id_9)
                                                                                                                                                      (unsafe-car
                                                                                                                                                       lst_67))
                                                                                                                                                     ((rest_37)
                                                                                                                                                      (unsafe-cdr
                                                                                                                                                       lst_67)))
                                                                                                                                          (let-values ((()
                                                                                                                                                        (let-values ()
                                                                                                                                                          (let-values ((()
                                                                                                                                                                        (let-values ()
                                                                                                                                                                          (begin
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (if (eq?
                                                                                                                                                                                   'not-ready
                                                                                                                                                                                   (hash-ref
                                                                                                                                                                                    mutated_3
                                                                                                                                                                                    id_9))
                                                                                                                                                                                (let-values ()
                                                                                                                                                                                  (hash-remove!
                                                                                                                                                                                   mutated_3
                                                                                                                                                                                   id_9))
                                                                                                                                                                                (void)))
                                                                                                                                                                            (values)))))
                                                                                                                                                            (values)))))
                                                                                                                                            (if (not
                                                                                                                                                 #f)
                                                                                                                                              (for-loop_33
                                                                                                                                               rest_37)
                                                                                                                                              (values))))
                                                                                                                                        (values)))))
                                                                                                                     for-loop_33)
                                                                                                                   lst_66)))
                                                                                                              (void)))
                                                                                                          (values)))))
                                                                                          (values)))))
                                                                          (if (not #f)
                                                                            (for-loop_32 rest_35 rest_36)
                                                                            (values))))
                                                                      (values)))))
                                                   for-loop_32)
                                                 lst_62
                                                 lst_63)))
                                            (void)
                                            (find-mutated!*_0 bodys_9 ids_16)))
                                        (if (if (pair? v_36)
                                              (if (let-values (((a_167) (car v_36))) (equal? 'if a_167))
                                                (let-values (((d_158) (cdr v_36)))
                                                  (if (pair? d_158)
                                                    (if (let-values (((a_128) (car d_158))) #t)
                                                      (let-values (((d_159) (cdr d_158)))
                                                        (if (pair? d_159)
                                                          (if (let-values (((a_168) (car d_159))) #t)
                                                            (let-values (((d_160) (cdr d_159)))
                                                              (if (pair? d_160)
                                                                (if (let-values (((a_130) (car d_160))) #t)
                                                                  (let-values (((d_120) (cdr d_160)))
                                                                    (equal? '() d_120))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((tst_0 thn_0 els_0)
                                                        (let-values (((d_161) (cdr v_36)))
                                                          (let-values (((tst_1)
                                                                        (let-values (((a_135) (car d_161))) a_135))
                                                                       ((thn_1 els_1)
                                                                        (let-values (((d_124) (cdr d_161)))
                                                                          (let-values (((thn_2)
                                                                                        (let-values (((a_169)
                                                                                                      (car d_124)))
                                                                                          a_169))
                                                                                       ((els_2)
                                                                                        (let-values (((d_162)
                                                                                                      (cdr d_124)))
                                                                                          (let-values (((a_137)
                                                                                                        (car d_162)))
                                                                                            a_137))))
                                                                            (values thn_2 els_2)))))
                                                            (values tst_1 thn_1 els_1)))))
                                            (begin
                                              (find-mutated!_0 tst_0 #f)
                                              (find-mutated!_0 thn_0 #f)
                                              (find-mutated!_0 els_0 #f)))
                                          (if (if (pair? v_36)
                                                (if (let-values (((a_170) (car v_36)))
                                                      (equal? 'with-continuation-mark a_170))
                                                  (let-values (((d_163) (cdr v_36)))
                                                    (if (pair? d_163)
                                                      (if (let-values (((a_171) (car d_163))) #t)
                                                        (let-values (((d_164) (cdr d_163)))
                                                          (if (pair? d_164)
                                                            (if (let-values (((a_172) (car d_164))) #t)
                                                              (let-values (((d_165) (cdr d_164)))
                                                                (if (pair? d_165)
                                                                  (if (let-values (((a_173) (car d_165))) #t)
                                                                    (let-values (((d_131) (cdr d_165)))
                                                                      (equal? '() d_131))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((key_1 val_0 body_15)
                                                          (let-values (((d_166) (cdr v_36)))
                                                            (let-values (((key_2)
                                                                          (let-values (((a_174) (car d_166))) a_174))
                                                                         ((val_1 body_16)
                                                                          (let-values (((d_167) (cdr d_166)))
                                                                            (let-values (((val_2)
                                                                                          (let-values (((a_175)
                                                                                                        (car d_167)))
                                                                                            a_175))
                                                                                         ((body_17)
                                                                                          (let-values (((d_168)
                                                                                                        (cdr d_167)))
                                                                                            (let-values (((a_176)
                                                                                                          (car d_168)))
                                                                                              a_176))))
                                                                              (values val_2 body_17)))))
                                                              (values key_2 val_1 body_16)))))
                                              (begin
                                                (find-mutated!_0 key_1 #f)
                                                (find-mutated!_0 val_0 #f)
                                                (find-mutated!_0 body_15 ids_16)))
                                            (if (if (pair? v_36)
                                                  (if (let-values (((a_177) (car v_36))) (equal? 'begin a_177))
                                                    (let-values (((d_169) (cdr v_36))) (list? d_169))
                                                    #f)
                                                  #f)
                                              (let-values (((exps_0) (let-values (((d_170) (cdr v_36))) d_170)))
                                                (find-mutated!*_0 exps_0 ids_16))
                                              (if (if (pair? v_36)
                                                    (if (let-values (((a_178) (car v_36))) (equal? 'begin0 a_178))
                                                      (let-values (((d_171) (cdr v_36)))
                                                        (if (pair? d_171)
                                                          (if (let-values (((a_179) (car d_171))) #t)
                                                            (let-values (((d_172) (cdr d_171))) (list? d_172))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f)
                                                (let-values (((exp_0 exps_1)
                                                              (let-values (((d_173) (cdr v_36)))
                                                                (let-values (((exp_1)
                                                                              (let-values (((a_180) (car d_173)))
                                                                                a_180))
                                                                             ((exps_2)
                                                                              (let-values (((d_174) (cdr d_173)))
                                                                                d_174)))
                                                                  (values exp_1 exps_2)))))
                                                  (begin (find-mutated!_0 exp_0 ids_16) (find-mutated!*_0 exps_1 #f)))
                                                (if (if (pair? v_36)
                                                      (if (let-values (((a_181) (car v_36))) (equal? 'set! a_181))
                                                        (let-values (((d_175) (cdr v_36)))
                                                          (if (pair? d_175)
                                                            (if (let-values (((a_182) (car d_175))) #t)
                                                              (let-values (((d_176) (cdr d_175)))
                                                                (if (pair? d_176)
                                                                  (if (let-values (((a_183) (car d_176))) #t)
                                                                    (let-values (((d_177) (cdr d_176)))
                                                                      (equal? '() d_177))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((id_10 rhs_26)
                                                                (let-values (((d_178) (cdr v_36)))
                                                                  (let-values (((id_11)
                                                                                (let-values (((a_184) (car d_178)))
                                                                                  a_184))
                                                                               ((rhs_27)
                                                                                (let-values (((d_179) (cdr d_178)))
                                                                                  (let-values (((a_185) (car d_179)))
                                                                                    a_185))))
                                                                    (values id_11 rhs_27)))))
                                                    (begin
                                                      (hash-set! mutated_3 id_10 'set!ed)
                                                      (find-mutated!_0 rhs_26 #f)))
                                                  (if (if (pair? v_36)
                                                        (if (let-values (((a_186) (car v_36)))
                                                              (equal? '#%variable-reference a_186))
                                                          (let-values (((d_180) (cdr v_36))) #t)
                                                          #f)
                                                        #f)
                                                    (let-values () (void))
                                                    (if (if (pair? v_36)
                                                          (if (let-values (((a_187) (car v_36))) #t)
                                                            (let-values (((d_181) (cdr v_36))) (list? d_181))
                                                            #f)
                                                          #f)
                                                      (let-values (((rator_0 exps_3)
                                                                    (let-values (((rator_1)
                                                                                  (let-values (((a_188) (car v_36)))
                                                                                    a_188))
                                                                                 ((exps_4)
                                                                                  (let-values (((d_182) (cdr v_36)))
                                                                                    d_182)))
                                                                      (values rator_1 exps_4))))
                                                        (if (if ids_16
                                                              (if (symbol? rator_0)
                                                                (if (not (hash-ref mutated_3 rator_0 #f))
                                                                  (if (let-values (((v_43)
                                                                                    (hash-ref-either
                                                                                     knowns_15
                                                                                     imports_4
                                                                                     rator_0)))
                                                                        (if (known-constructor? v_43)
                                                                          (=
                                                                           (length exps_3)
                                                                           (known-constructor-field-count v_43))
                                                                          #f))
                                                                    (let-values (((lst_68) exps_3))
                                                                      (begin
                                                                        (check-list lst_68)
                                                                        ((letrec-values (((for-loop_34)
                                                                                          (lambda (result_34 lst_69)
                                                                                            (if (pair? lst_69)
                                                                                              (let-values (((exp_2)
                                                                                                            (unsafe-car
                                                                                                             lst_69))
                                                                                                           ((rest_38)
                                                                                                            (unsafe-cdr
                                                                                                             lst_69)))
                                                                                                (let-values (((result_35)
                                                                                                              (let-values ()
                                                                                                                (let-values (((result_36)
                                                                                                                              (let-values ()
                                                                                                                                (let-values ()
                                                                                                                                  (simple?
                                                                                                                                   exp_2
                                                                                                                                   prim-knowns_2
                                                                                                                                   knowns_15
                                                                                                                                   imports_4
                                                                                                                                   mutated_3)))))
                                                                                                                  (values
                                                                                                                   result_36)))))
                                                                                                  (if (if (not
                                                                                                           ((lambda x_12
                                                                                                              (not
                                                                                                               result_35))
                                                                                                            exp_2))
                                                                                                        (not #f)
                                                                                                        #f)
                                                                                                    (for-loop_34
                                                                                                     result_35
                                                                                                     rest_38)
                                                                                                    result_35)))
                                                                                              result_34))))
                                                                           for-loop_34)
                                                                         #t
                                                                         lst_68)))
                                                                    #f)
                                                                  #f)
                                                                #f)
                                                              #f)
                                                          (let-values ()
                                                            (delay!_0 ids_16 (lambda () (find-mutated!*_0 exps_3 #f))))
                                                          (let-values ()
                                                            (begin
                                                              (find-mutated!_0 rator_0 #f)
                                                              (find-mutated!*_0 exps_3 #f)))))
                                                      (let-values ()
                                                        (if (symbol? v_35)
                                                          (let-values ()
                                                            (let-values (((state_1) (hash-ref mutated_3 v_35 #f)))
                                                              (if (eq? state_1 'not-ready)
                                                                (let-values () (hash-set! mutated_3 v_35 'too-early))
                                                                (if (delayed? state_1)
                                                                  (let-values ()
                                                                    (if ids_16
                                                                      (let-values ()
                                                                        (delay!_0
                                                                         ids_16
                                                                         (lambda ()
                                                                           (begin
                                                                             (hash-remove! mutated_3 v_35)
                                                                             (state_1)))))
                                                                      (let-values ()
                                                                        (begin
                                                                          (hash-remove! mutated_3 v_35)
                                                                          (state_1)))))
                                                                  (void)))))
                                                          (void))))))))))))))))))))
         find-mutated!_0)
       v_34
       ids_14))))
 (define-values
  (left-to-right/let)
  (lambda (v_16 prim-knowns_1 knowns_4 imports_3 mutated_2)
    (let-values (((v_29) v_16))
      (if (if (pair? v_29)
            (if (let-values (((a_60) (car v_29))) (equal? 'let a_60))
              (let-values (((d_57) (cdr v_29)))
                (if (pair? d_57)
                  (if (let-values (((a_61) (car d_57)))
                        (if (pair? a_61)
                          (if (let-values (((a_19) (car a_61))) #t)
                            (let-values (((d_20) (cdr a_61))) (equal? '() d_20))
                            #f)
                          #f))
                    (let-values (((d_58) (cdr d_57))) #t)
                    #f)
                  #f))
              #f)
            #f)
        (let-values () v_16)
        (if (if (pair? v_29)
              (if (let-values (((a_62) (car v_29))) (equal? 'let a_62))
                (let-values (((d_59) (cdr v_29)))
                  (if (pair? d_59)
                    (if (let-values (((a_189) (car d_59)))
                          (if (list? a_189)
                            (let-values (((lst_70) a_189))
                              (begin
                                (check-list lst_70)
                                ((letrec-values (((for-loop_35)
                                                  (lambda (result_37 lst_71)
                                                    (if (pair? lst_71)
                                                      (let-values (((v_44) (unsafe-car lst_71))
                                                                   ((rest_39) (unsafe-cdr lst_71)))
                                                        (let-values (((result_38)
                                                                      (let-values ()
                                                                        (let-values (((result_39)
                                                                                      (let-values ()
                                                                                        (let-values ()
                                                                                          (if (pair? v_44)
                                                                                            (if (let-values (((a_190)
                                                                                                              (car
                                                                                                               v_44)))
                                                                                                  #t)
                                                                                              (let-values (((d_183)
                                                                                                            (cdr v_44)))
                                                                                                (if (pair? d_183)
                                                                                                  (if (let-values (((a_67)
                                                                                                                    (car
                                                                                                                     d_183)))
                                                                                                        #t)
                                                                                                    (let-values (((d_62)
                                                                                                                  (cdr
                                                                                                                   d_183)))
                                                                                                      (equal? '() d_62))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f)))))
                                                                          (values result_39)))))
                                                          (if (if (not ((lambda x_13 (not result_38)) v_44))
                                                                (not #f)
                                                                #f)
                                                            (for-loop_35 result_38 rest_39)
                                                            result_38)))
                                                      result_37))))
                                   for-loop_35)
                                 #t
                                 lst_70)))
                            #f))
                      (let-values (((d_63) (cdr d_59))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_21 rhss_45 bodys_11)
                        (let-values (((d_184) (cdr v_29)))
                          (let-values (((ids_22 rhss_46)
                                        (let-values (((a_73) (car d_184)))
                                          (let-values (((ids_23 rhss_47)
                                                        (let-values (((lst_72) a_73))
                                                          (begin
                                                            (check-list lst_72)
                                                            ((letrec-values (((for-loop_36)
                                                                              (lambda (ids_24 rhss_2 lst_2)
                                                                                (if (pair? lst_2)
                                                                                  (let-values (((v_14)
                                                                                                (unsafe-car lst_2))
                                                                                               ((rest_40)
                                                                                                (unsafe-cdr lst_2)))
                                                                                    (let-values (((ids_25 rhss_48)
                                                                                                  (let-values (((ids_26)
                                                                                                                ids_24)
                                                                                                               ((rhss_4)
                                                                                                                rhss_2))
                                                                                                    (let-values (((ids_27
                                                                                                                   rhss_6)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((ids1_0
                                                                                                                                   rhss2_1)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values (((ids_11)
                                                                                                                                                  (let-values (((a_29)
                                                                                                                                                                (car
                                                                                                                                                                 v_14)))
                                                                                                                                                    a_29))
                                                                                                                                                 ((rhss_49)
                                                                                                                                                  (let-values (((d_74)
                                                                                                                                                                (cdr
                                                                                                                                                                 v_14)))
                                                                                                                                                    (let-values (((a_81)
                                                                                                                                                                  (car
                                                                                                                                                                   d_74)))
                                                                                                                                                      a_81))))
                                                                                                                                      (values
                                                                                                                                       ids_11
                                                                                                                                       rhss_49)))))
                                                                                                                      (values
                                                                                                                       (cons
                                                                                                                        ids1_0
                                                                                                                        ids_26)
                                                                                                                       (cons
                                                                                                                        rhss2_1
                                                                                                                        rhss_4))))))
                                                                                                      (values
                                                                                                       ids_27
                                                                                                       rhss_6)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_36
                                                                                         ids_25
                                                                                         rhss_48
                                                                                         rest_40)
                                                                                        (values ids_25 rhss_48))))
                                                                                  (values ids_24 rhss_2)))))
                                                               for-loop_36)
                                                             null
                                                             null
                                                             lst_72)))))
                                            (values (reverse$1 ids_23) (reverse$1 rhss_47)))))
                                       ((bodys_12) (let-values (((d_75) (cdr d_184))) d_75)))
                            (values ids_22 rhss_46 bodys_12)))))
            ((letrec-values (((loop_6)
                              (lambda (ids_28 rhss_50 binds_0)
                                (if (null? (cdr rhss_50))
                                  (let-values ()
                                    (if (null? binds_0)
                                      (list* 'let (list (list (car ids_28) (car rhss_50))) bodys_11)
                                      (list
                                       'let
                                       (list (list (car ids_28) (car rhss_50)))
                                       (list* 'let binds_0 bodys_11))))
                                  (if (simple? (car rhss_50) prim-knowns_1 knowns_4 imports_3 mutated_2)
                                    (let-values ()
                                      (list
                                       'let
                                       (list (list (car ids_28) (car rhss_50)))
                                       (loop_6 (cdr ids_28) (cdr rhss_50) binds_0)))
                                    (let-values ()
                                      (let-values (((id_12) (car ids_28)))
                                        (list
                                         'let
                                         (list (list id_12 (car rhss_50)))
                                         (loop_6 (cdr ids_28) (cdr rhss_50) (cons (list id_12 id_12) binds_0))))))))))
               loop_6)
             ids_21
             rhss_45
             null))
          (error 'match "failed ~e" v_29))))))
 (define-values
  (left-to-right/let-values)
  (lambda (v_45 mutated_4)
    (let-values (((v_46) v_45))
      (if (if (pair? v_46)
            (if (let-values (((a_191) (car v_46))) (equal? 'let-values a_191))
              (let-values (((d_8) (cdr v_46)))
                (if (pair? d_8)
                  (if (let-values (((a_146) (car d_8)))
                        (if (pair? a_146)
                          (if (let-values (((a_192) (car a_146)))
                                (if (pair? a_192)
                                  (if (let-values (((a_147) (car a_192))) #t)
                                    (let-values (((d_137) (cdr a_192)))
                                      (if (pair? d_137)
                                        (if (let-values (((a_11) (car d_137))) #t)
                                          (let-values (((d_9) (cdr d_137))) (equal? '() d_9))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_185) (cdr a_146))) (equal? '() d_185))
                            #f)
                          #f))
                    (let-values (((d_10) (cdr d_8)))
                      (if (pair? d_10)
                        (if (let-values (((a_193) (car d_10))) #t)
                          (let-values (((d_186) (cdr d_10))) (equal? '() d_186))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((ids_29 rhs_28 body_18)
                      (let-values (((d_187) (cdr v_46)))
                        (let-values (((ids_30 rhs_29)
                                      (let-values (((a_194) (car d_187)))
                                        (let-values (((a_195) (car a_194)))
                                          (let-values (((ids_31) (let-values (((a_15) (car a_195))) a_15))
                                                       ((rhs_30)
                                                        (let-values (((d_15) (cdr a_195)))
                                                          (let-values (((a_16) (car d_15))) a_16))))
                                            (values ids_31 rhs_30)))))
                                     ((body_19)
                                      (let-values (((d_16) (cdr d_187))) (let-values (((a_17) (car d_16))) a_17))))
                          (values ids_30 rhs_29 body_19)))))
          (make-let-values ids_29 rhs_28 body_18))
        (if (if (pair? v_46)
              (if (let-values (((a_196) (car v_46))) (equal? 'let-values a_196))
                (let-values (((d_188) (cdr v_46)))
                  (if (pair? d_188)
                    (if (let-values (((a_83) (car d_188)))
                          (if (pair? a_83)
                            (if (let-values (((a_197) (car a_83)))
                                  (if (pair? a_197)
                                    (if (let-values (((a_18) (car a_197))) #t)
                                      (let-values (((d_189) (cdr a_197)))
                                        (if (pair? d_189)
                                          (if (let-values (((a_198) (car d_189))) #t)
                                            (let-values (((d_190) (cdr d_189))) (equal? '() d_190))
                                            #f)
                                          #f))
                                      #f)
                                    #f))
                              (let-values (((d_34) (cdr a_83))) (equal? '() d_34))
                              #f)
                            #f))
                      (let-values (((d_191) (cdr d_188))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_32 rhs_31 bodys_13)
                        (let-values (((d_80) (cdr v_46)))
                          (let-values (((ids_17 rhs_32)
                                        (let-values (((a_199) (car d_80)))
                                          (let-values (((a_149) (car a_199)))
                                            (let-values (((ids_33) (let-values (((a_200) (car a_149))) a_200))
                                                         ((rhs_33)
                                                          (let-values (((d_192) (cdr a_149)))
                                                            (let-values (((a_201) (car d_192))) a_201))))
                                              (values ids_33 rhs_33)))))
                                       ((bodys_14) (let-values (((d_140) (cdr d_80))) d_140)))
                            (values ids_17 rhs_32 bodys_14)))))
            (make-let-values ids_32 rhs_31 (list* 'begin bodys_13)))
          (if (if (pair? v_46)
                (if (let-values (((a_202) (car v_46))) (equal? 'let-values a_202))
                  (let-values (((d_193) (cdr v_46)))
                    (if (pair? d_193)
                      (if (let-values (((a_87) (car d_193)))
                            (if (list? a_87)
                              (let-values (((lst_13) a_87))
                                (begin
                                  (check-list lst_13)
                                  ((letrec-values (((for-loop_37)
                                                    (lambda (result_40 lst_43)
                                                      (if (pair? lst_43)
                                                        (let-values (((v_47) (unsafe-car lst_43))
                                                                     ((rest_41) (unsafe-cdr lst_43)))
                                                          (let-values (((result_41)
                                                                        (let-values ()
                                                                          (let-values (((result_42)
                                                                                        (let-values ()
                                                                                          (let-values ()
                                                                                            (if (pair? v_47)
                                                                                              (if (let-values (((a_203)
                                                                                                                (car
                                                                                                                 v_47)))
                                                                                                    (list? a_203))
                                                                                                (let-values (((d_194)
                                                                                                              (cdr
                                                                                                               v_47)))
                                                                                                  (if (pair? d_194)
                                                                                                    (if (let-values (((a_204)
                                                                                                                      (car
                                                                                                                       d_194)))
                                                                                                          #t)
                                                                                                      (let-values (((d_195)
                                                                                                                    (cdr
                                                                                                                     d_194)))
                                                                                                        (equal?
                                                                                                         '()
                                                                                                         d_195))
                                                                                                      #f)
                                                                                                    #f))
                                                                                                #f)
                                                                                              #f)))))
                                                                            (values result_42)))))
                                                            (if (if (not ((lambda x_14 (not result_41)) v_47))
                                                                  (not #f)
                                                                  #f)
                                                              (for-loop_37 result_41 rest_41)
                                                              result_41)))
                                                        result_40))))
                                     for-loop_37)
                                   #t
                                   lst_13)))
                              #f))
                        (let-values (((d_196) (cdr d_193))) #t)
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((idss_24 rhss_51 bodys_15)
                          (let-values (((d_197) (cdr v_46)))
                            (let-values (((idss_25 rhss_52)
                                          (let-values (((a_205) (car d_197)))
                                            (let-values (((idss_26 rhss_53)
                                                          (let-values (((lst_73) a_205))
                                                            (begin
                                                              (check-list lst_73)
                                                              ((letrec-values (((for-loop_38)
                                                                                (lambda (idss_27 rhss_54 lst_74)
                                                                                  (if (pair? lst_74)
                                                                                    (let-values (((v_48)
                                                                                                  (unsafe-car lst_74))
                                                                                                 ((rest_42)
                                                                                                  (unsafe-cdr lst_74)))
                                                                                      (let-values (((idss_28 rhss_55)
                                                                                                    (let-values (((idss_29)
                                                                                                                  idss_27)
                                                                                                                 ((rhss_56)
                                                                                                                  rhss_54))
                                                                                                      (let-values (((idss_30
                                                                                                                     rhss_57)
                                                                                                                    (let-values ()
                                                                                                                      (let-values (((idss3_2
                                                                                                                                     rhss4_2)
                                                                                                                                    (let-values ()
                                                                                                                                      (let-values (((idss_31)
                                                                                                                                                    (let-values (((a_206)
                                                                                                                                                                  (car
                                                                                                                                                                   v_48)))
                                                                                                                                                      a_206))
                                                                                                                                                   ((rhss_58)
                                                                                                                                                    (let-values (((d_198)
                                                                                                                                                                  (cdr
                                                                                                                                                                   v_48)))
                                                                                                                                                      (let-values (((a_95)
                                                                                                                                                                    (car
                                                                                                                                                                     d_198)))
                                                                                                                                                        a_95))))
                                                                                                                                        (values
                                                                                                                                         idss_31
                                                                                                                                         rhss_58)))))
                                                                                                                        (values
                                                                                                                         (cons
                                                                                                                          idss3_2
                                                                                                                          idss_29)
                                                                                                                         (cons
                                                                                                                          rhss4_2
                                                                                                                          rhss_56))))))
                                                                                                        (values
                                                                                                         idss_30
                                                                                                         rhss_57)))))
                                                                                        (if (not #f)
                                                                                          (for-loop_38
                                                                                           idss_28
                                                                                           rhss_55
                                                                                           rest_42)
                                                                                          (values idss_28 rhss_55))))
                                                                                    (values idss_27 rhss_54)))))
                                                                 for-loop_38)
                                                               null
                                                               null
                                                               lst_73)))))
                                              (values (reverse$1 idss_26) (reverse$1 rhss_53)))))
                                         ((bodys_16) (let-values (((d_89) (cdr d_197))) d_89)))
                              (values idss_25 rhss_52 bodys_16)))))
              ((letrec-values (((loop_7)
                                (lambda (idss_32 rhss_59 binds_1)
                                  (if (null? (cdr rhss_59))
                                    (let-values ()
                                      (make-let-values (car idss_32) (car rhss_59) (list* 'let binds_1 bodys_15)))
                                    (let-values ()
                                      (let-values (((ids_34) (car idss_32)))
                                        (make-let-values
                                         ids_34
                                         (car rhss_59)
                                         (loop_7
                                          (cdr idss_32)
                                          (cdr rhss_59)
                                          (append (map2 (lambda (id_13) (list id_13 id_13)) ids_34) binds_1)))))))))
                 loop_7)
               idss_24
               rhss_51
               null))
            (error 'match "failed ~e" v_46)))))))
 (define-values
  (left-to-right/app)
  (lambda (v_49 prim-knowns_3 knowns_7 imports_5 mutated_5)
    ((letrec-values (((loop_8)
                      (lambda (l_11 accum_0)
                        (if (null? l_11)
                          (let-values () (reverse$1 accum_0))
                          (if (simple? (car l_11) prim-knowns_3 knowns_7 imports_5 mutated_5)
                            (let-values () (loop_8 (cdr l_11) (cons (car l_11) accum_0)))
                            (if (andmap2
                                 (lambda (v_39) (simple? v_39 prim-knowns_3 knowns_7 imports_5 mutated_5))
                                 (cdr l_11))
                              (let-values () (append (reverse$1 accum_0) l_11))
                              (let-values ()
                                (let-values (((g_0) (gensym "app_")))
                                  (list
                                   'let
                                   (list (list g_0 (car l_11)))
                                   (loop_8 (cdr l_11) (cons g_0 accum_0)))))))))))
       loop_8)
     v_49
     null)))
 (define-values
  (make-let-values)
  (lambda (ids_35 rhs_34 body_20)
    (if (if (pair? ids_35) (null? (cdr ids_35)) #f)
      (let-values () (list 'let (list (list (car ids_35) rhs_34)) body_20))
      (let-values ()
        (let-values (((v_50) (if (null? ids_35) rhs_34 #f)))
          (if (if (pair? v_50)
                (if (let-values (((a_207) (car v_50))) (equal? 'begin a_207))
                  (let-values (((d_199) (cdr v_50)))
                    (if (pair? d_199)
                      (if (let-values (((a_47) (car d_199))) #t)
                        (let-values (((d_45) (cdr d_199)))
                          (if (pair? d_45)
                            (if (let-values (((a_48) (car d_45)))
                                  (if (pair? a_48)
                                    (if (let-values (((a_97) (car a_48))) (equal? 'values a_97))
                                      (let-values (((d_91) (cdr a_48))) (equal? '() d_91))
                                      #f)
                                    #f))
                              (let-values (((d_47) (cdr d_45))) (equal? '() d_47))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((rhs_35) (let-values (((d_48) (cdr v_50))) (let-values (((a_208) (car d_48))) a_208))))
              (list 'begin rhs_35 body_20))
            (let-values ()
              (list
               'call-with-values
               (list 'lambda '() rhs_34)
               (list
                'case-lambda
                (list ids_35 body_20)
                (list 'args (list* 'raise-result-arity-error (list 'quote ids_35) '(args))))))))))))
 (define-values
  (schemify-linklet)
  (lambda (lk_0 prim-knowns_1 get-import-knowns_0)
    (let-values (((im-int-id_0) (lambda (id_14) (if (pair? id_14) (cadr id_14) id_14))))
      (let-values (((im-ext-id_0) (lambda (id_15) (if (pair? id_15) (car id_15) id_15))))
        (let-values (((ex-int-id_0) (lambda (id_16) (if (pair? id_16) (car id_16) id_16))))
          (let-values (((ex-ext-id_0) (lambda (id_0) (if (pair? id_0) (cadr id_0) id_0))))
            (let-values (((imports_6)
                          (let-values (((lst_70) (cadr lk_0)) ((start_0) 0))
                            (begin
                              (check-list lst_70)
                              (check-naturals start_0)
                              ((letrec-values (((for-loop_39)
                                                (lambda (imports_7 lst_75 pos_0)
                                                  (if (if (pair? lst_75) #t #f)
                                                    (let-values (((im-ids_0) (unsafe-car lst_75))
                                                                 ((rest_43) (unsafe-cdr lst_75))
                                                                 ((index_0) pos_0))
                                                      (let-values (((imports_8)
                                                                    (let-values (((imports_9) imports_7))
                                                                      (let-values (((imports_10)
                                                                                    (let-values ()
                                                                                      (let-values (((grp_1)
                                                                                                    (import-group2.1
                                                                                                     (lambda ()
                                                                                                       (get-import-knowns_0
                                                                                                        index_0)))))
                                                                                        (let-values (((lst_76)
                                                                                                      im-ids_0))
                                                                                          (begin
                                                                                            (check-list lst_76)
                                                                                            ((letrec-values (((for-loop_40)
                                                                                                              (lambda (imports_11
                                                                                                                       lst_77)
                                                                                                                (if (pair?
                                                                                                                     lst_77)
                                                                                                                  (let-values (((im-id_0)
                                                                                                                                (unsafe-car
                                                                                                                                 lst_77))
                                                                                                                               ((rest_44)
                                                                                                                                (unsafe-cdr
                                                                                                                                 lst_77)))
                                                                                                                    (let-values (((imports_12)
                                                                                                                                  (let-values (((imports_13)
                                                                                                                                                imports_11))
                                                                                                                                    (let-values (((imports_14)
                                                                                                                                                  (let-values ()
                                                                                                                                                    (let-values (((id_17)
                                                                                                                                                                  (im-int-id_0
                                                                                                                                                                   im-id_0)))
                                                                                                                                                      (let-values (((ext-id_0)
                                                                                                                                                                    (im-ext-id_0
                                                                                                                                                                     im-id_0)))
                                                                                                                                                        (hash-set
                                                                                                                                                         imports_13
                                                                                                                                                         id_17
                                                                                                                                                         (import1.1
                                                                                                                                                          grp_1
                                                                                                                                                          (gensym
                                                                                                                                                           (symbol->string
                                                                                                                                                            id_17))
                                                                                                                                                          ext-id_0)))))))
                                                                                                                                      (values
                                                                                                                                       imports_14)))))
                                                                                                                      (if (not
                                                                                                                           #f)
                                                                                                                        (for-loop_40
                                                                                                                         imports_12
                                                                                                                         rest_44)
                                                                                                                        imports_12)))
                                                                                                                  imports_11))))
                                                                                               for-loop_40)
                                                                                             imports_9
                                                                                             lst_76)))))))
                                                                        (values imports_10)))))
                                                        (if (not #f)
                                                          (for-loop_39 imports_8 rest_43 (+ pos_0 1))
                                                          imports_8)))
                                                    imports_7))))
                                 for-loop_39)
                               (hasheq)
                               lst_70
                               start_0)))))
              (let-values (((exports_1)
                            (let-values (((lst_78) (caddr lk_0)))
                              (begin
                                (check-list lst_78)
                                ((letrec-values (((for-loop_41)
                                                  (lambda (exports_2 lst_79)
                                                    (if (pair? lst_79)
                                                      (let-values (((ex_0) (unsafe-car lst_79))
                                                                   ((rest_45) (unsafe-cdr lst_79)))
                                                        (let-values (((exports_3)
                                                                      (let-values (((exports_4) exports_2))
                                                                        (let-values (((exports_5)
                                                                                      (let-values ()
                                                                                        (let-values (((id_18)
                                                                                                      (if (pair? ex_0)
                                                                                                        (car ex_0)
                                                                                                        ex_0)))
                                                                                          (hash-set
                                                                                           exports_4
                                                                                           id_18
                                                                                           (gensym
                                                                                            (symbol->string id_18)))))))
                                                                          (values exports_5)))))
                                                          (if (not #f) (for-loop_41 exports_3 rest_45) exports_3)))
                                                      exports_2))))
                                   for-loop_41)
                                 (hasheq)
                                 lst_78)))))
                (let-values (((new-body_0 defn-info_0) (schemify-body* (cdddr lk_0) prim-knowns_1 imports_6 exports_1)))
                  (values
                   (list*
                    'lambda
                    (list*
                     'instance-variable-reference
                     (qq-append
                      (let-values (((lst_80) (cadr lk_0)))
                        (begin
                          (check-list lst_80)
                          ((letrec-values (((for-loop_42)
                                            (lambda (lst_81)
                                              (if (pair? lst_81)
                                                (let-values (((ims_0) (unsafe-car lst_81))
                                                             ((rest_46) (unsafe-cdr lst_81)))
                                                  (let-values (((post-guard-var_0) (lambda () #t)))
                                                    (let-values (((lst_82) ims_0))
                                                      (begin
                                                        (check-list lst_82)
                                                        ((letrec-values (((for-loop_43)
                                                                          (lambda (lst_83)
                                                                            (if (pair? lst_83)
                                                                              (let-values (((im_2) (unsafe-car lst_83))
                                                                                           ((rest_47)
                                                                                            (unsafe-cdr lst_83)))
                                                                                (let-values (((post-guard-var_1)
                                                                                              (lambda () #t)))
                                                                                  (let-values ()
                                                                                    (let-values (((elem_0)
                                                                                                  (let-values ()
                                                                                                    (let-values ()
                                                                                                      (import-id
                                                                                                       (hash-ref
                                                                                                        imports_6
                                                                                                        (im-int-id_0
                                                                                                         im_2)))))))
                                                                                      (let-values (((result_43)
                                                                                                    (if (post-guard-var_1)
                                                                                                      (for-loop_43
                                                                                                       rest_47)
                                                                                                      (if (post-guard-var_0)
                                                                                                        (for-loop_42
                                                                                                         rest_46)
                                                                                                        null))))
                                                                                        (cons elem_0 result_43))))))
                                                                              (if (post-guard-var_0)
                                                                                (for-loop_42 rest_46)
                                                                                null)))))
                                                           for-loop_43)
                                                         lst_82)))))
                                                null))))
                             for-loop_42)
                           lst_80)))
                      (let-values (((lst_84) (caddr lk_0)))
                        (begin
                          (check-list lst_84)
                          ((letrec-values (((for-loop_44)
                                            (lambda (lst_37)
                                              (if (pair? lst_37)
                                                (let-values (((ex_1) (unsafe-car lst_37))
                                                             ((rest_48) (unsafe-cdr lst_37)))
                                                  (let-values (((post-guard-var_2) (lambda () #t)))
                                                    (let-values ()
                                                      (let-values (((elem_1)
                                                                    (let-values ()
                                                                      (let-values ()
                                                                        (hash-ref exports_1 (ex-int-id_0 ex_1))))))
                                                        (let-values (((result_44)
                                                                      (if (post-guard-var_2)
                                                                        (for-loop_44 rest_48)
                                                                        null)))
                                                          (cons elem_1 result_44))))))
                                                null))))
                             for-loop_44)
                           lst_84)))))
                    new-body_0)
                   (let-values (((lst_6) (cadr lk_0)))
                     (begin
                       (check-list lst_6)
                       ((letrec-values (((for-loop_3)
                                         (lambda (lst_85)
                                           (if (pair? lst_85)
                                             (let-values (((ims_1) (unsafe-car lst_85)) ((rest_49) (unsafe-cdr lst_85)))
                                               (let-values (((post-guard-var_3) (lambda () #t)))
                                                 (let-values ()
                                                   (let-values (((elem_2)
                                                                 (let-values ()
                                                                   (let-values ()
                                                                     (let-values (((im-knowns_0)
                                                                                   (if (pair? ims_1)
                                                                                     (let-values (((k/t_0)
                                                                                                   (import-group-knowns/thunk
                                                                                                    (import-grp
                                                                                                     (hash-ref
                                                                                                      imports_6
                                                                                                      (im-int-id_0
                                                                                                       (car ims_1)))))))
                                                                                       (if (procedure? k/t_0) #f k/t_0))
                                                                                     #f)))
                                                                       (let-values (((lst_86) ims_1))
                                                                         (begin
                                                                           (check-list lst_86)
                                                                           ((letrec-values (((for-loop_45)
                                                                                             (lambda (lst_87)
                                                                                               (if (pair? lst_87)
                                                                                                 (let-values (((im_3)
                                                                                                               (unsafe-car
                                                                                                                lst_87))
                                                                                                              ((rest_50)
                                                                                                               (unsafe-cdr
                                                                                                                lst_87)))
                                                                                                   (let-values (((post-guard-var_4)
                                                                                                                 (lambda ()
                                                                                                                   #t)))
                                                                                                     (let-values ()
                                                                                                       (let-values (((elem_3)
                                                                                                                     (let-values ()
                                                                                                                       (let-values ()
                                                                                                                         (if im-knowns_0
                                                                                                                           (known-constant?
                                                                                                                            (hash-ref
                                                                                                                             im-knowns_0
                                                                                                                             (im-ext-id_0
                                                                                                                              im_3)
                                                                                                                             #f))
                                                                                                                           #f)))))
                                                                                                         (let-values (((result_45)
                                                                                                                       (if (post-guard-var_4)
                                                                                                                         (for-loop_45
                                                                                                                          rest_50)
                                                                                                                         null)))
                                                                                                           (cons
                                                                                                            elem_3
                                                                                                            result_45))))))
                                                                                                 null))))
                                                                              for-loop_45)
                                                                            lst_86))))))))
                                                     (let-values (((result_46)
                                                                   (if (post-guard-var_3) (for-loop_3 rest_49) null)))
                                                       (cons elem_2 result_46))))))
                                             null))))
                          for-loop_3)
                        lst_6)))
                   (let-values (((lst_88) (caddr lk_0)))
                     (begin
                       (check-list lst_88)
                       ((letrec-values (((for-loop_46)
                                         (lambda (knowns_16 lst_89)
                                           (if (pair? lst_89)
                                             (let-values (((ex_2) (unsafe-car lst_89)) ((rest_51) (unsafe-cdr lst_89)))
                                               (let-values (((knowns_17)
                                                             (let-values (((knowns_18) knowns_16))
                                                               (let-values (((knowns_19)
                                                                             (let-values ()
                                                                               (let-values (((id_19)
                                                                                             (ex-int-id_0 ex_2)))
                                                                                 (let-values (((v_21)
                                                                                               (hash-ref
                                                                                                defn-info_0
                                                                                                id_19
                                                                                                #f)))
                                                                                   (if v_21
                                                                                     (let-values ()
                                                                                       (let-values (((ext-id_1)
                                                                                                     (ex-ext-id_0
                                                                                                      id_19)))
                                                                                         (hash-set
                                                                                          knowns_18
                                                                                          ext-id_1
                                                                                          v_21)))
                                                                                     (let-values () knowns_18)))))))
                                                                 (values knowns_19)))))
                                                 (if (not #f) (for-loop_46 knowns_17 rest_51) knowns_17)))
                                             knowns_16))))
                          for-loop_46)
                        (hasheq)
                        lst_88)))))))))))))
 (define-values
  (schemify-body)
  (lambda (l_12 prim-knowns_4 imports_15 exports_6)
    (let-values (((new-body_1 defn-info_1) (schemify-body* l_12 prim-knowns_4 imports_15 exports_6))) new-body_1)))
 (define-values
  (schemify-body*)
  (lambda (l_13 prim-knowns_5 imports_16 exports_7)
    (let-values (((mutated_6) (mutated-in-body l_13 exports_7 prim-knowns_5 (hasheq) imports_16)))
      (let-values (((knowns_20)
                    (let-values (((lst_90) l_13))
                      (begin
                        (check-list lst_90)
                        ((letrec-values (((for-loop_47)
                                          (lambda (knowns_21 lst_91)
                                            (if (pair? lst_91)
                                              (let-values (((form_3) (unsafe-car lst_91))
                                                           ((rest_52) (unsafe-cdr lst_91)))
                                                (let-values (((knowns_22)
                                                              (let-values (((knowns_23) knowns_21))
                                                                (let-values (((knowns_24)
                                                                              (let-values ()
                                                                                (find-definitions
                                                                                 form_3
                                                                                 prim-knowns_5
                                                                                 knowns_23
                                                                                 imports_16
                                                                                 mutated_6))))
                                                                  (values knowns_24)))))
                                                  (if (not #f) (for-loop_47 knowns_22 rest_52) knowns_22)))
                                              knowns_21))))
                           for-loop_47)
                         (hasheq)
                         lst_90)))))
        (let-values (((schemified_0)
                      ((letrec-values (((loop_9)
                                        (lambda (l_14 accum-exprs_0 accum-ids_0)
                                          (if (null? l_14)
                                            (let-values ()
                                              (let-values (((set-vars_0)
                                                            (let-values (((lst_43) accum-ids_0))
                                                              (begin
                                                                (check-list lst_43)
                                                                ((letrec-values (((for-loop_22)
                                                                                  (lambda (lst_92)
                                                                                    (if (pair? lst_92)
                                                                                      (let-values (((id_20)
                                                                                                    (unsafe-car lst_92))
                                                                                                   ((rest_53)
                                                                                                    (unsafe-cdr
                                                                                                     lst_92)))
                                                                                        (let-values (((post-guard-var_5)
                                                                                                      (lambda () #t)))
                                                                                          (let-values ()
                                                                                            (if (hash-ref
                                                                                                 exports_7
                                                                                                 id_20
                                                                                                 #f)
                                                                                              (let-values ()
                                                                                                (let-values (((elem_4)
                                                                                                              (let-values ()
                                                                                                                (let-values ()
                                                                                                                  (make-set-variable
                                                                                                                   id_20
                                                                                                                   exports_7)))))
                                                                                                  (let-values (((result_47)
                                                                                                                (if (post-guard-var_5)
                                                                                                                  (for-loop_22
                                                                                                                   rest_53)
                                                                                                                  null)))
                                                                                                    (cons
                                                                                                     elem_4
                                                                                                     result_47))))
                                                                                              (if (post-guard-var_5)
                                                                                                (for-loop_22 rest_53)
                                                                                                null)))))
                                                                                      null))))
                                                                   for-loop_22)
                                                                 lst_43)))))
                                                (if (null? set-vars_0)
                                                  (let-values ()
                                                    (if (null? accum-exprs_0)
                                                      (let-values () '((void)))
                                                      (let-values () (reverse$1 accum-exprs_0))))
                                                  (let-values () (append (make-expr-defns accum-exprs_0) set-vars_0)))))
                                            (let-values ()
                                              (let-values (((form_4) (car l_14)))
                                                (let-values (((schemified_1)
                                                              (schemify
                                                               prim-knowns_5
                                                               knowns_20
                                                               mutated_6
                                                               imports_16
                                                               exports_7
                                                               form_4)))
                                                  (let-values (((v_51) form_4))
                                                    (if (if (pair? v_51)
                                                          (if (let-values (((a_209) (car v_51)))
                                                                (equal? 'define-values a_209))
                                                            (let-values (((d_200) (cdr v_51)))
                                                              (if (pair? d_200)
                                                                (if (let-values (((a_210) (car d_200))) #t)
                                                                  (let-values (((d_41) (cdr d_200)))
                                                                    (if (pair? d_41)
                                                                      (if (let-values (((a_88) (car d_41))) #t)
                                                                        (let-values (((d_82) (cdr d_41)))
                                                                          (equal? '() d_82))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f)
                                                      (let-values (((ids_36)
                                                                    (let-values (((d_201) (cdr v_51)))
                                                                      (let-values (((a_205) (car d_201))) a_205))))
                                                        (append
                                                         (make-expr-defns accum-exprs_0)
                                                         (cons
                                                          schemified_1
                                                          ((letrec-values (((id-loop_0)
                                                                            (lambda (ids_37 accum-exprs_1 accum-ids_1)
                                                                              (if (null? ids_37)
                                                                                (let-values ()
                                                                                  (loop_9
                                                                                   (cdr l_14)
                                                                                   accum-exprs_1
                                                                                   accum-ids_1))
                                                                                (if (hash-ref mutated_6 (car ids_37) #f)
                                                                                  (let-values ()
                                                                                    (let-values (((id_21) (car ids_37)))
                                                                                      (if (hash-ref exports_7 id_21 #f)
                                                                                        (let-values ()
                                                                                          (id-loop_0
                                                                                           (cdr ids_37)
                                                                                           (cons
                                                                                            (make-set-variable
                                                                                             id_21
                                                                                             exports_7)
                                                                                            accum-exprs_1)
                                                                                           accum-ids_1))
                                                                                        (let-values ()
                                                                                          (id-loop_0
                                                                                           (cdr ids_37)
                                                                                           accum-exprs_1
                                                                                           accum-ids_1)))))
                                                                                  (let-values ()
                                                                                    (id-loop_0
                                                                                     (cdr ids_37)
                                                                                     accum-exprs_1
                                                                                     (cons
                                                                                      (car ids_37)
                                                                                      accum-ids_1))))))))
                                                             id-loop_0)
                                                           ids_36
                                                           null
                                                           accum-ids_0))))
                                                      (let-values ()
                                                        (loop_9
                                                         (cdr l_14)
                                                         (cons schemified_1 accum-exprs_0)
                                                         accum-ids_0)))))))))))
                         loop_9)
                       l_13
                       null
                       null)))
          (values schemified_0 knowns_20))))))
 (define-values
  (make-set-variable)
  (lambda (id_22 exports_8)
    (let-values (((ex-var_0) (hash-ref exports_8 id_22))) (list 'variable-set! ex-var_0 id_22))))
 (define-values
  (make-expr-defns)
  (lambda (accum-exprs_2)
    (let-values (((lst_93) (reverse$1 accum-exprs_2)))
      (begin
        (check-list lst_93)
        ((letrec-values (((for-loop_48)
                          (lambda (lst_94)
                            (if (pair? lst_94)
                              (let-values (((expr_0) (unsafe-car lst_94)) ((rest_54) (unsafe-cdr lst_94)))
                                (let-values (((post-guard-var_6) (lambda () #t)))
                                  (let-values ()
                                    (let-values (((elem_5)
                                                  (let-values () (let-values () (list 'define (gensym) expr_0)))))
                                      (let-values (((result_48) (if (post-guard-var_6) (for-loop_48 rest_54) null)))
                                        (cons elem_5 result_48))))))
                              null))))
           for-loop_48)
         lst_93)))))
 (define-values
  (schemify)
  (lambda (prim-knowns_6 knowns_25 mutated_7 imports_17 exports_9 v_52)
    ((letrec-values (((schemify/knowns_0)
                      (lambda (knowns_26 v_53)
                        ((letrec-values (((schemify_0)
                                          (lambda (v_54)
                                            (let-values (((v_55) v_54))
                                              (if (if (pair? v_55)
                                                    (if (let-values (((a_211) (car v_55))) (equal? 'lambda a_211))
                                                      (let-values (((d_202) (cdr v_55)))
                                                        (if (pair? d_202)
                                                          (if (let-values (((a_212) (car d_202))) #t)
                                                            (let-values (((d_203) (cdr d_202))) (list? d_203))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f)
                                                (let-values (((formals_2 body_21)
                                                              (let-values (((d_204) (cdr v_55)))
                                                                (let-values (((formals_3)
                                                                              (let-values (((a_213) (car d_204)))
                                                                                a_213))
                                                                             ((body_22)
                                                                              (let-values (((d_205) (cdr d_204)))
                                                                                d_205)))
                                                                  (values formals_3 body_22)))))
                                                  (list* 'lambda formals_2 (map2 schemify_0 body_21)))
                                                (if (if (pair? v_55)
                                                      (if (let-values (((a_214) (car v_55)))
                                                            (equal? 'case-lambda a_214))
                                                        (let-values (((d_206) (cdr v_55)))
                                                          (if (list? d_206)
                                                            (let-values (((lst_95) d_206))
                                                              (begin
                                                                (check-list lst_95)
                                                                ((letrec-values (((for-loop_49)
                                                                                  (lambda (result_20 lst_96)
                                                                                    (if (pair? lst_96)
                                                                                      (let-values (((v_56)
                                                                                                    (unsafe-car lst_96))
                                                                                                   ((rest_55)
                                                                                                    (unsafe-cdr
                                                                                                     lst_96)))
                                                                                        (let-values (((result_49)
                                                                                                      (let-values ()
                                                                                                        (let-values (((result_50)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (if (pair?
                                                                                                                               v_56)
                                                                                                                            (if (let-values (((a_49)
                                                                                                                                              (car
                                                                                                                                               v_56)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_48)
                                                                                                                                            (cdr
                                                                                                                                             v_56)))
                                                                                                                                (list?
                                                                                                                                 d_48))
                                                                                                                              #f)
                                                                                                                            #f)))))
                                                                                                          (values
                                                                                                           result_50)))))
                                                                                          (if (if (not
                                                                                                   ((lambda x_15
                                                                                                      (not result_49))
                                                                                                    v_56))
                                                                                                (not #f)
                                                                                                #f)
                                                                                            (for-loop_49
                                                                                             result_49
                                                                                             rest_55)
                                                                                            result_49)))
                                                                                      result_20))))
                                                                   for-loop_49)
                                                                 #t
                                                                 lst_95)))
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((formalss_7 bodys_17)
                                                                (let-values (((d_49) (cdr v_55)))
                                                                  (let-values (((formalss_8 bodys_18)
                                                                                (let-values (((lst_97) d_49))
                                                                                  (begin
                                                                                    (check-list lst_97)
                                                                                    ((letrec-values (((for-loop_50)
                                                                                                      (lambda (formalss_9
                                                                                                               bodys_19
                                                                                                               lst_20)
                                                                                                        (if (pair?
                                                                                                             lst_20)
                                                                                                          (let-values (((v_57)
                                                                                                                        (unsafe-car
                                                                                                                         lst_20))
                                                                                                                       ((rest_56)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_20)))
                                                                                                            (let-values (((formalss_10
                                                                                                                           bodys_20)
                                                                                                                          (let-values (((formalss_11)
                                                                                                                                        formalss_9)
                                                                                                                                       ((bodys_21)
                                                                                                                                        bodys_19))
                                                                                                                            (let-values (((formalss_12
                                                                                                                                           bodys_22)
                                                                                                                                          (let-values ()
                                                                                                                                            (let-values (((formalss1_1
                                                                                                                                                           bodys2_1)
                                                                                                                                                          (let-values ()
                                                                                                                                                            (let-values (((formalss_13)
                                                                                                                                                                          (let-values (((a_215)
                                                                                                                                                                                        (car
                                                                                                                                                                                         v_57)))
                                                                                                                                                                            a_215))
                                                                                                                                                                         ((bodys_23)
                                                                                                                                                                          (let-values (((d_207)
                                                                                                                                                                                        (cdr
                                                                                                                                                                                         v_57)))
                                                                                                                                                                            d_207)))
                                                                                                                                                              (values
                                                                                                                                                               formalss_13
                                                                                                                                                               bodys_23)))))
                                                                                                                                              (values
                                                                                                                                               (cons
                                                                                                                                                formalss1_1
                                                                                                                                                formalss_11)
                                                                                                                                               (cons
                                                                                                                                                bodys2_1
                                                                                                                                                bodys_21))))))
                                                                                                                              (values
                                                                                                                               formalss_12
                                                                                                                               bodys_22)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_50
                                                                                                                 formalss_10
                                                                                                                 bodys_20
                                                                                                                 rest_56)
                                                                                                                (values
                                                                                                                 formalss_10
                                                                                                                 bodys_20))))
                                                                                                          (values
                                                                                                           formalss_9
                                                                                                           bodys_19)))))
                                                                                       for-loop_50)
                                                                                     null
                                                                                     null
                                                                                     lst_97)))))
                                                                    (values
                                                                     (reverse$1 formalss_8)
                                                                     (reverse$1 bodys_18))))))
                                                    (list*
                                                     'case-lambda
                                                     (let-values (((lst_98) formalss_7) ((lst_51) bodys_17))
                                                       (begin
                                                         (check-list lst_98)
                                                         (check-list lst_51)
                                                         ((letrec-values (((for-loop_51)
                                                                           (lambda (lst_99 lst_53)
                                                                             (if (if (pair? lst_99) (pair? lst_53) #f)
                                                                               (let-values (((formals_4)
                                                                                             (unsafe-car lst_99))
                                                                                            ((rest_57)
                                                                                             (unsafe-cdr lst_99))
                                                                                            ((body_23)
                                                                                             (unsafe-car lst_53))
                                                                                            ((rest_58)
                                                                                             (unsafe-cdr lst_53)))
                                                                                 (let-values (((post-guard-var_7)
                                                                                               (lambda () #t)))
                                                                                   (let-values ()
                                                                                     (let-values (((elem_6)
                                                                                                   (let-values ()
                                                                                                     (let-values ()
                                                                                                       (list*
                                                                                                        formals_4
                                                                                                        (map2
                                                                                                         schemify_0
                                                                                                         body_23))))))
                                                                                       (let-values (((result_51)
                                                                                                     (if (post-guard-var_7)
                                                                                                       (for-loop_51
                                                                                                        rest_57
                                                                                                        rest_58)
                                                                                                       null)))
                                                                                         (cons elem_6 result_51))))))
                                                                               null))))
                                                            for-loop_51)
                                                          lst_98
                                                          lst_51)))))
                                                  (if (if (pair? v_55)
                                                        (if (let-values (((a_163) (car v_55)))
                                                              (equal? 'define-values a_163))
                                                          (let-values (((d_208) (cdr v_55)))
                                                            (if (pair? d_208)
                                                              (if (let-values (((a_216) (car d_208)))
                                                                    (if (pair? a_216)
                                                                      (if (let-values (((a_217) (car a_216))) #t)
                                                                        (let-values (((d_209) (cdr a_216)))
                                                                          (if (pair? d_209)
                                                                            (if (let-values (((a_54) (car d_209))) #t)
                                                                              (let-values (((d_52) (cdr d_209)))
                                                                                (if (pair? d_52)
                                                                                  (if (let-values (((a_55) (car d_52)))
                                                                                        #t)
                                                                                    (let-values (((d_53) (cdr d_52)))
                                                                                      (list? d_53))
                                                                                    #f)
                                                                                  #f))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f))
                                                                (let-values (((d_210) (cdr d_208)))
                                                                  (if (pair? d_210)
                                                                    (if (let-values (((a_164) (car d_210)))
                                                                          (if (pair? a_164)
                                                                            (if (let-values (((a_218) (car a_164)))
                                                                                  (equal? 'let-values a_218))
                                                                              (let-values (((d_211) (cdr a_164)))
                                                                                (if (pair? d_211)
                                                                                  (if (let-values (((a_56) (car d_211)))
                                                                                        (if (pair? a_56)
                                                                                          (if (let-values (((a_219)
                                                                                                            (car a_56)))
                                                                                                (if (pair? a_219)
                                                                                                  (if (let-values (((a_57)
                                                                                                                    (car
                                                                                                                     a_219)))
                                                                                                        (if (pair? a_57)
                                                                                                          (if (let-values (((a_107)
                                                                                                                            (car
                                                                                                                             a_57)))
                                                                                                                #t)
                                                                                                            (let-values (((d_101)
                                                                                                                          (cdr
                                                                                                                           a_57)))
                                                                                                              (if (pair?
                                                                                                                   d_101)
                                                                                                                (if (let-values (((a_58)
                                                                                                                                  (car
                                                                                                                                   d_101)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_55)
                                                                                                                                (cdr
                                                                                                                                 d_101)))
                                                                                                                    (if (pair?
                                                                                                                         d_55)
                                                                                                                      (if (let-values (((a_108)
                                                                                                                                        (car
                                                                                                                                         d_55)))
                                                                                                                            #t)
                                                                                                                        (let-values (((d_102)
                                                                                                                                      (cdr
                                                                                                                                       d_55)))
                                                                                                                          (if (pair?
                                                                                                                               d_102)
                                                                                                                            (if (let-values (((a_109)
                                                                                                                                              (car
                                                                                                                                               d_102)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_212)
                                                                                                                                            (cdr
                                                                                                                                             d_102)))
                                                                                                                                (if (pair?
                                                                                                                                     d_212)
                                                                                                                                  (if (let-values (((a_59)
                                                                                                                                                    (car
                                                                                                                                                     d_212)))
                                                                                                                                        #t)
                                                                                                                                    (let-values (((d_56)
                                                                                                                                                  (cdr
                                                                                                                                                   d_212)))
                                                                                                                                      (equal?
                                                                                                                                       '()
                                                                                                                                       d_56))
                                                                                                                                    #f)
                                                                                                                                  #f))
                                                                                                                              #f)
                                                                                                                            #f))
                                                                                                                        #f)
                                                                                                                      #f))
                                                                                                                  #f)
                                                                                                                #f))
                                                                                                            #f)
                                                                                                          #f))
                                                                                                    (let-values (((d_103)
                                                                                                                  (cdr
                                                                                                                   a_219)))
                                                                                                      (if (pair? d_103)
                                                                                                        (if (let-values (((a_220)
                                                                                                                          (car
                                                                                                                           d_103)))
                                                                                                              #t)
                                                                                                          (let-values (((d_213)
                                                                                                                        (cdr
                                                                                                                         d_103)))
                                                                                                            (equal?
                                                                                                             '()
                                                                                                             d_213))
                                                                                                          #f)
                                                                                                        #f))
                                                                                                    #f)
                                                                                                  #f))
                                                                                            (let-values (((d_105)
                                                                                                          (cdr a_56)))
                                                                                              (equal? '() d_105))
                                                                                            #f)
                                                                                          #f))
                                                                                    (let-values (((d_106) (cdr d_211)))
                                                                                      (if (pair? d_106)
                                                                                        (if (let-values (((a_221)
                                                                                                          (car d_106)))
                                                                                              (if (pair? a_221)
                                                                                                (if (let-values (((a_113)
                                                                                                                  (car
                                                                                                                   a_221)))
                                                                                                      (equal?
                                                                                                       'values
                                                                                                       a_113))
                                                                                                  (let-values (((d_108)
                                                                                                                (cdr
                                                                                                                 a_221)))
                                                                                                    (if (pair? d_108)
                                                                                                      (if (let-values (((a_222)
                                                                                                                        (car
                                                                                                                         d_108)))
                                                                                                            #t)
                                                                                                        (let-values (((d_214)
                                                                                                                      (cdr
                                                                                                                       d_108)))
                                                                                                          (if (pair?
                                                                                                               d_214)
                                                                                                            (if (let-values (((a_223)
                                                                                                                              (car
                                                                                                                               d_214)))
                                                                                                                  #t)
                                                                                                              (let-values (((d_109)
                                                                                                                            (cdr
                                                                                                                             d_214)))
                                                                                                                (if (pair?
                                                                                                                     d_109)
                                                                                                                  (if (let-values (((a_224)
                                                                                                                                    (car
                                                                                                                                     d_109)))
                                                                                                                        #t)
                                                                                                                    (let-values (((d_215)
                                                                                                                                  (cdr
                                                                                                                                   d_109)))
                                                                                                                      (list?
                                                                                                                       d_215))
                                                                                                                    #f)
                                                                                                                  #f))
                                                                                                              #f)
                                                                                                            #f))
                                                                                                        #f)
                                                                                                      #f))
                                                                                                  #f)
                                                                                                #f))
                                                                                          (let-values (((d_216)
                                                                                                        (cdr d_106)))
                                                                                            (equal? '() d_216))
                                                                                          #f)
                                                                                        #f))
                                                                                    #f)
                                                                                  #f))
                                                                              #f)
                                                                            #f))
                                                                      (let-values (((d_217) (cdr d_210)))
                                                                        (equal? '() d_217))
                                                                      #f)
                                                                    #f))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f)
                                                    (let-values (((struct:s_6
                                                                   make-s_8
                                                                   s?_10
                                                                   acc/muts_5
                                                                   struct:_14
                                                                   make_6
                                                                   ?1_0
                                                                   -ref_17
                                                                   -set!_17
                                                                   mk_0
                                                                   struct:2_4
                                                                   make2_5
                                                                   ?2_6
                                                                   make-acc/muts_6)
                                                                  (let-values (((d_218) (cdr v_55)))
                                                                    (let-values (((struct:s_7 make-s_9 s?_11 acc/muts_6)
                                                                                  (let-values (((a_167) (car d_218)))
                                                                                    (let-values (((struct:s_8)
                                                                                                  (let-values (((a_129)
                                                                                                                (car
                                                                                                                 a_167)))
                                                                                                    a_129))
                                                                                                 ((make-s_10
                                                                                                   s?_12
                                                                                                   acc/muts_7)
                                                                                                  (let-values (((d_219)
                                                                                                                (cdr
                                                                                                                 a_167)))
                                                                                                    (let-values (((make-s_11)
                                                                                                                  (let-values (((a_132)
                                                                                                                                (car
                                                                                                                                 d_219)))
                                                                                                                    a_132))
                                                                                                                 ((s?_13
                                                                                                                   acc/muts_8)
                                                                                                                  (let-values (((d_161)
                                                                                                                                (cdr
                                                                                                                                 d_219)))
                                                                                                                    (let-values (((s?_14)
                                                                                                                                  (let-values (((a_225)
                                                                                                                                                (car
                                                                                                                                                 d_161)))
                                                                                                                                    a_225))
                                                                                                                                 ((acc/muts_9)
                                                                                                                                  (let-values (((d_220)
                                                                                                                                                (cdr
                                                                                                                                                 d_161)))
                                                                                                                                    d_220)))
                                                                                                                      (values
                                                                                                                       s?_14
                                                                                                                       acc/muts_9)))))
                                                                                                      (values
                                                                                                       make-s_11
                                                                                                       s?_13
                                                                                                       acc/muts_8)))))
                                                                                      (values
                                                                                       struct:s_8
                                                                                       make-s_10
                                                                                       s?_12
                                                                                       acc/muts_7))))
                                                                                 ((struct:_15
                                                                                   make_7
                                                                                   ?1_1
                                                                                   -ref_18
                                                                                   -set!_18
                                                                                   mk_1
                                                                                   struct:2_5
                                                                                   make2_6
                                                                                   ?2_7
                                                                                   make-acc/muts_7)
                                                                                  (let-values (((d_124) (cdr d_218)))
                                                                                    (let-values (((a_226) (car d_124)))
                                                                                      (let-values (((d_125)
                                                                                                    (cdr a_226)))
                                                                                        (let-values (((struct:_16
                                                                                                       make_8
                                                                                                       ?1_2
                                                                                                       -ref_19
                                                                                                       -set!_19
                                                                                                       mk_2)
                                                                                                      (let-values (((a_227)
                                                                                                                    (car
                                                                                                                     d_125)))
                                                                                                        (let-values (((a_140)
                                                                                                                      (car
                                                                                                                       a_227)))
                                                                                                          (let-values (((struct:_17
                                                                                                                         make_9
                                                                                                                         ?1_3
                                                                                                                         -ref_20
                                                                                                                         -set!_20)
                                                                                                                        (let-values (((a_174)
                                                                                                                                      (car
                                                                                                                                       a_140)))
                                                                                                                          (let-values (((struct:_18)
                                                                                                                                        (let-values (((a_176)
                                                                                                                                                      (car
                                                                                                                                                       a_174)))
                                                                                                                                          a_176))
                                                                                                                                       ((make_10
                                                                                                                                         ?1_4
                                                                                                                                         -ref_21
                                                                                                                                         -set!_21)
                                                                                                                                        (let-values (((d_221)
                                                                                                                                                      (cdr
                                                                                                                                                       a_174)))
                                                                                                                                          (let-values (((make_11)
                                                                                                                                                        (let-values (((a_228)
                                                                                                                                                                      (car
                                                                                                                                                                       d_221)))
                                                                                                                                                          a_228))
                                                                                                                                                       ((?1_5
                                                                                                                                                         -ref_22
                                                                                                                                                         -set!_22)
                                                                                                                                                        (let-values (((d_222)
                                                                                                                                                                      (cdr
                                                                                                                                                                       d_221)))
                                                                                                                                                          (let-values (((?1_6)
                                                                                                                                                                        (let-values (((a_229)
                                                                                                                                                                                      (car
                                                                                                                                                                                       d_222)))
                                                                                                                                                                          a_229))
                                                                                                                                                                       ((-ref_23
                                                                                                                                                                         -set!_23)
                                                                                                                                                                        (let-values (((d_223)
                                                                                                                                                                                      (cdr
                                                                                                                                                                                       d_222)))
                                                                                                                                                                          (let-values (((-ref_24)
                                                                                                                                                                                        (let-values (((a_230)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       d_223)))
                                                                                                                                                                                          a_230))
                                                                                                                                                                                       ((-set!_24)
                                                                                                                                                                                        (let-values (((d_224)
                                                                                                                                                                                                      (cdr
                                                                                                                                                                                                       d_223)))
                                                                                                                                                                                          (let-values (((a_231)
                                                                                                                                                                                                        (car
                                                                                                                                                                                                         d_224)))
                                                                                                                                                                                            a_231))))
                                                                                                                                                                            (values
                                                                                                                                                                             -ref_24
                                                                                                                                                                             -set!_24)))))
                                                                                                                                                            (values
                                                                                                                                                             ?1_6
                                                                                                                                                             -ref_23
                                                                                                                                                             -set!_23)))))
                                                                                                                                            (values
                                                                                                                                             make_11
                                                                                                                                             ?1_5
                                                                                                                                             -ref_22
                                                                                                                                             -set!_22)))))
                                                                                                                            (values
                                                                                                                             struct:_18
                                                                                                                             make_10
                                                                                                                             ?1_4
                                                                                                                             -ref_21
                                                                                                                             -set!_21))))
                                                                                                                       ((mk_3)
                                                                                                                        (let-values (((d_225)
                                                                                                                                      (cdr
                                                                                                                                       a_140)))
                                                                                                                          (let-values (((a_232)
                                                                                                                                        (car
                                                                                                                                         d_225)))
                                                                                                                            a_232))))
                                                                                                            (values
                                                                                                             struct:_17
                                                                                                             make_9
                                                                                                             ?1_3
                                                                                                             -ref_20
                                                                                                             -set!_20
                                                                                                             mk_3)))))
                                                                                                     ((struct:2_6
                                                                                                       make2_7
                                                                                                       ?2_8
                                                                                                       make-acc/muts_8)
                                                                                                      (let-values (((d_226)
                                                                                                                    (cdr
                                                                                                                     d_125)))
                                                                                                        (let-values (((a_233)
                                                                                                                      (car
                                                                                                                       d_226)))
                                                                                                          (let-values (((d_227)
                                                                                                                        (cdr
                                                                                                                         a_233)))
                                                                                                            (let-values (((struct:2_7)
                                                                                                                          (let-values (((a_184)
                                                                                                                                        (car
                                                                                                                                         d_227)))
                                                                                                                            a_184))
                                                                                                                         ((make2_8
                                                                                                                           ?2_9
                                                                                                                           make-acc/muts_9)
                                                                                                                          (let-values (((d_179)
                                                                                                                                        (cdr
                                                                                                                                         d_227)))
                                                                                                                            (let-values (((make2_9)
                                                                                                                                          (let-values (((a_187)
                                                                                                                                                        (car
                                                                                                                                                         d_179)))
                                                                                                                                            a_187))
                                                                                                                                         ((?2_10
                                                                                                                                           make-acc/muts_10)
                                                                                                                                          (let-values (((d_181)
                                                                                                                                                        (cdr
                                                                                                                                                         d_179)))
                                                                                                                                            (let-values (((?2_11)
                                                                                                                                                          (let-values (((a_234)
                                                                                                                                                                        (car
                                                                                                                                                                         d_181)))
                                                                                                                                                            a_234))
                                                                                                                                                         ((make-acc/muts_11)
                                                                                                                                                          (let-values (((d_228)
                                                                                                                                                                        (cdr
                                                                                                                                                                         d_181)))
                                                                                                                                                            d_228)))
                                                                                                                                              (values
                                                                                                                                               ?2_11
                                                                                                                                               make-acc/muts_11)))))
                                                                                                                              (values
                                                                                                                               make2_9
                                                                                                                               ?2_10
                                                                                                                               make-acc/muts_10)))))
                                                                                                              (values
                                                                                                               struct:2_7
                                                                                                               make2_8
                                                                                                               ?2_9
                                                                                                               make-acc/muts_9)))))))
                                                                                          (values
                                                                                           struct:_16
                                                                                           make_8
                                                                                           ?1_2
                                                                                           -ref_19
                                                                                           -set!_19
                                                                                           mk_2
                                                                                           struct:2_6
                                                                                           make2_7
                                                                                           ?2_8
                                                                                           make-acc/muts_8)))))))
                                                                      (values
                                                                       struct:s_7
                                                                       make-s_9
                                                                       s?_11
                                                                       acc/muts_6
                                                                       struct:_15
                                                                       make_7
                                                                       ?1_1
                                                                       -ref_18
                                                                       -set!_18
                                                                       mk_1
                                                                       struct:2_5
                                                                       make2_6
                                                                       ?2_7
                                                                       make-acc/muts_7)))))
                                                      (let-values (((sti_0)
                                                                    (if (eq? struct:_14 struct:2_4)
                                                                      (if (eq? make_6 make2_5)
                                                                        (if (eq? ?1_0 ?2_6)
                                                                          (make-struct-type-info
                                                                           mk_0
                                                                           knowns_26
                                                                           imports_17
                                                                           mutated_7)
                                                                          #f)
                                                                        #f)
                                                                      #f)))
                                                        (if sti_0
                                                          (let-values ()
                                                            (list*
                                                             'begin
                                                             (list
                                                              'define
                                                              struct:s_6
                                                              (list
                                                               'make-record-type-descriptor
                                                               (list 'quote (struct-type-info-name sti_0))
                                                               (schemify_0 (struct-type-info-parent sti_0))
                                                               #f
                                                               #f
                                                               #f
                                                               (list
                                                                'quote
                                                                (let-values (((vec_2 i_2)
                                                                              (let-values (((start_1) 0)
                                                                                           ((end_0)
                                                                                            (struct-type-info-immediate-field-count
                                                                                             sti_0))
                                                                                           ((inc_0) 1))
                                                                                (begin
                                                                                  (check-range start_1 end_0 inc_0)
                                                                                  ((letrec-values (((for-loop_52)
                                                                                                    (lambda (vec_3
                                                                                                             i_3
                                                                                                             pos_1)
                                                                                                      (if (<
                                                                                                           pos_1
                                                                                                           end_0)
                                                                                                        (let-values (((i_4)
                                                                                                                      pos_1))
                                                                                                          (let-values (((vec_4
                                                                                                                         i_5)
                                                                                                                        (let-values (((vec_5)
                                                                                                                                      vec_3)
                                                                                                                                     ((i_6)
                                                                                                                                      i_3))
                                                                                                                          (let-values (((vec_6
                                                                                                                                         i_7)
                                                                                                                                        (let-values ()
                                                                                                                                          (let-values (((new-vec_2)
                                                                                                                                                        (if (eq?
                                                                                                                                                             i_6
                                                                                                                                                             (unsafe-vector*-length
                                                                                                                                                              vec_5))
                                                                                                                                                          (grow-vector
                                                                                                                                                           vec_5)
                                                                                                                                                          vec_5)))
                                                                                                                                            (begin
                                                                                                                                              (unsafe-vector*-set!
                                                                                                                                               new-vec_2
                                                                                                                                               i_6
                                                                                                                                               (let-values ()
                                                                                                                                                 (list
                                                                                                                                                  'mutable
                                                                                                                                                  (string->symbol
                                                                                                                                                   (format
                                                                                                                                                    "f~a"
                                                                                                                                                    i_4)))))
                                                                                                                                              (values
                                                                                                                                               new-vec_2
                                                                                                                                               (unsafe-fx+
                                                                                                                                                i_6
                                                                                                                                                1)))))))
                                                                                                                            (values
                                                                                                                             vec_6
                                                                                                                             i_7)))))
                                                                                                            (if (not #f)
                                                                                                              (for-loop_52
                                                                                                               vec_4
                                                                                                               i_5
                                                                                                               (+
                                                                                                                pos_1
                                                                                                                inc_0))
                                                                                                              (values
                                                                                                               vec_4
                                                                                                               i_5))))
                                                                                                        (values
                                                                                                         vec_3
                                                                                                         i_3)))))
                                                                                     for-loop_52)
                                                                                   (make-vector 16)
                                                                                   0
                                                                                   start_1)))))
                                                                  (shrink-vector vec_2 i_2)))))
                                                             (list
                                                              'define
                                                              make-s_8
                                                              (list
                                                               'record-constructor
                                                               (list*
                                                                'make-record-constructor-descriptor
                                                                struct:s_6
                                                                '(#f #f))))
                                                             (list 'define s?_10 (list 'record-predicate struct:s_6))
                                                             (qq-append
                                                              (let-values (((lst_100) acc/muts_5)
                                                                           ((lst_101) make-acc/muts_6))
                                                                (begin
                                                                  (check-list lst_100)
                                                                  (check-list lst_101)
                                                                  ((letrec-values (((for-loop_53)
                                                                                    (lambda (lst_102 lst_103)
                                                                                      (if (if (pair? lst_102)
                                                                                            (pair? lst_103)
                                                                                            #f)
                                                                                        (let-values (((acc/mut_0)
                                                                                                      (unsafe-car
                                                                                                       lst_102))
                                                                                                     ((rest_59)
                                                                                                      (unsafe-cdr
                                                                                                       lst_102))
                                                                                                     ((make-acc/mut_0)
                                                                                                      (unsafe-car
                                                                                                       lst_103))
                                                                                                     ((rest_60)
                                                                                                      (unsafe-cdr
                                                                                                       lst_103)))
                                                                                          (let-values (((post-guard-var_8)
                                                                                                        (lambda () #t)))
                                                                                            (let-values ()
                                                                                              (let-values (((elem_7)
                                                                                                            (let-values ()
                                                                                                              (let-values ()
                                                                                                                (list
                                                                                                                 'define
                                                                                                                 acc/mut_0
                                                                                                                 (let-values (((v_58)
                                                                                                                               make-acc/mut_0))
                                                                                                                   (if (if (pair?
                                                                                                                            v_58)
                                                                                                                         (if (let-values (((a_235)
                                                                                                                                           (car
                                                                                                                                            v_58)))
                                                                                                                               (equal?
                                                                                                                                'make-struct-field-accessor
                                                                                                                                a_235))
                                                                                                                           (let-values (((d_229)
                                                                                                                                         (cdr
                                                                                                                                          v_58)))
                                                                                                                             (if (pair?
                                                                                                                                  d_229)
                                                                                                                               (if (let-values (((a_236)
                                                                                                                                                 (car
                                                                                                                                                  d_229)))
                                                                                                                                     ((lambda (v_59)
                                                                                                                                        (eq?
                                                                                                                                         v_59
                                                                                                                                         -ref_17))
                                                                                                                                      a_236))
                                                                                                                                 (let-values (((d_230)
                                                                                                                                               (cdr
                                                                                                                                                d_229)))
                                                                                                                                   (if (pair?
                                                                                                                                        d_230)
                                                                                                                                     (if (let-values (((a_237)
                                                                                                                                                       (car
                                                                                                                                                        d_230)))
                                                                                                                                           #t)
                                                                                                                                       (let-values (((d_231)
                                                                                                                                                     (cdr
                                                                                                                                                      d_230)))
                                                                                                                                         (if (pair?
                                                                                                                                              d_231)
                                                                                                                                           (if (let-values (((a_238)
                                                                                                                                                             (car
                                                                                                                                                              d_231)))
                                                                                                                                                 #t)
                                                                                                                                             (let-values (((d_232)
                                                                                                                                                           (cdr
                                                                                                                                                            d_231)))
                                                                                                                                               (equal?
                                                                                                                                                '()
                                                                                                                                                d_232))
                                                                                                                                             #f)
                                                                                                                                           #f))
                                                                                                                                       #f)
                                                                                                                                     #f))
                                                                                                                                 #f)
                                                                                                                               #f))
                                                                                                                           #f)
                                                                                                                         #f)
                                                                                                                     (let-values (((pos_2)
                                                                                                                                   (let-values (((d_233)
                                                                                                                                                 (cdr
                                                                                                                                                  v_58)))
                                                                                                                                     (let-values (((d_234)
                                                                                                                                                   (cdr
                                                                                                                                                    d_233)))
                                                                                                                                       (let-values (((a_239)
                                                                                                                                                     (car
                                                                                                                                                      d_234)))
                                                                                                                                         a_239)))))
                                                                                                                       (list
                                                                                                                        'record-accessor
                                                                                                                        struct:s_6
                                                                                                                        pos_2))
                                                                                                                     (if (if (pair?
                                                                                                                              v_58)
                                                                                                                           (if (let-values (((a_240)
                                                                                                                                             (car
                                                                                                                                              v_58)))
                                                                                                                                 (equal?
                                                                                                                                  'make-struct-field-mutator
                                                                                                                                  a_240))
                                                                                                                             (let-values (((d_235)
                                                                                                                                           (cdr
                                                                                                                                            v_58)))
                                                                                                                               (if (pair?
                                                                                                                                    d_235)
                                                                                                                                 (if (let-values (((a_241)
                                                                                                                                                   (car
                                                                                                                                                    d_235)))
                                                                                                                                       ((lambda (v_60)
                                                                                                                                          (eq?
                                                                                                                                           v_60
                                                                                                                                           -set!_17))
                                                                                                                                        a_241))
                                                                                                                                   (let-values (((d_236)
                                                                                                                                                 (cdr
                                                                                                                                                  d_235)))
                                                                                                                                     (if (pair?
                                                                                                                                          d_236)
                                                                                                                                       (if (let-values (((a_242)
                                                                                                                                                         (car
                                                                                                                                                          d_236)))
                                                                                                                                             #t)
                                                                                                                                         (let-values (((d_237)
                                                                                                                                                       (cdr
                                                                                                                                                        d_236)))
                                                                                                                                           (if (pair?
                                                                                                                                                d_237)
                                                                                                                                             (if (let-values (((a_243)
                                                                                                                                                               (car
                                                                                                                                                                d_237)))
                                                                                                                                                   #t)
                                                                                                                                               (let-values (((d_238)
                                                                                                                                                             (cdr
                                                                                                                                                              d_237)))
                                                                                                                                                 (equal?
                                                                                                                                                  '()
                                                                                                                                                  d_238))
                                                                                                                                               #f)
                                                                                                                                             #f))
                                                                                                                                         #f)
                                                                                                                                       #f))
                                                                                                                                   #f)
                                                                                                                                 #f))
                                                                                                                             #f)
                                                                                                                           #f)
                                                                                                                       (let-values (((pos_3)
                                                                                                                                     (let-values (((d_239)
                                                                                                                                                   (cdr
                                                                                                                                                    v_58)))
                                                                                                                                       (let-values (((d_240)
                                                                                                                                                     (cdr
                                                                                                                                                      d_239)))
                                                                                                                                         (let-values (((a_244)
                                                                                                                                                       (car
                                                                                                                                                        d_240)))
                                                                                                                                           a_244)))))
                                                                                                                         (list
                                                                                                                          'record-mutator
                                                                                                                          struct:s_6
                                                                                                                          pos_3))
                                                                                                                       (let-values ()
                                                                                                                         (error
                                                                                                                          "oops"))))))))))
                                                                                                (let-values (((result_52)
                                                                                                              (if (post-guard-var_8)
                                                                                                                (for-loop_53
                                                                                                                 rest_59
                                                                                                                 rest_60)
                                                                                                                null)))
                                                                                                  (cons
                                                                                                   elem_7
                                                                                                   result_52))))))
                                                                                        null))))
                                                                     for-loop_53)
                                                                   lst_100
                                                                   lst_101)))
                                                              (if (null? (struct-type-info-rest sti_0))
                                                                null
                                                                (list
                                                                 (list
                                                                  'define
                                                                  (gensym)
                                                                  (list*
                                                                   'struct-type-install-properties!
                                                                   struct:s_6
                                                                   (list 'quote (struct-type-info-name sti_0))
                                                                   (struct-type-info-immediate-field-count sti_0)
                                                                   0
                                                                   (schemify_0 (struct-type-info-parent sti_0))
                                                                   (map2
                                                                    schemify_0
                                                                    (struct-type-info-rest sti_0)))))))))
                                                          (let-values ()
                                                            (list
                                                             'define-values
                                                             (cadr v_54)
                                                             (schemify_0 (caddr v_54)))))))
                                                    (if (if (pair? v_55)
                                                          (if (let-values (((a_245) (car v_55)))
                                                                (equal? 'define-values a_245))
                                                            (let-values (((d_241) (cdr v_55)))
                                                              (if (pair? d_241)
                                                                (if (let-values (((a_246) (car d_241)))
                                                                      (if (pair? a_246)
                                                                        (if (let-values (((a_247) (car a_246))) #t)
                                                                          (let-values (((d_242) (cdr a_246)))
                                                                            (equal? '() d_242))
                                                                          #f)
                                                                        #f))
                                                                  (let-values (((d_243) (cdr d_241)))
                                                                    (if (pair? d_243)
                                                                      (if (let-values (((a_248) (car d_243))) #t)
                                                                        (let-values (((d_244) (cdr d_243)))
                                                                          (equal? '() d_244))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f)
                                                      (let-values (((id_23 rhs_36)
                                                                    (let-values (((d_245) (cdr v_55)))
                                                                      (let-values (((id_24)
                                                                                    (let-values (((a_249) (car d_245)))
                                                                                      (let-values (((a_250)
                                                                                                    (car a_249)))
                                                                                        a_250)))
                                                                                   ((rhs_37)
                                                                                    (let-values (((d_246) (cdr d_245)))
                                                                                      (let-values (((a_251)
                                                                                                    (car d_246)))
                                                                                        a_251))))
                                                                        (values id_24 rhs_37)))))
                                                        (list 'define id_23 (schemify_0 rhs_36)))
                                                      (if (if (pair? v_55)
                                                            (if (let-values (((a_252) (car v_55)))
                                                                  (equal? 'define-values a_252))
                                                              (let-values (((d_247) (cdr v_55)))
                                                                (if (pair? d_247)
                                                                  (if (let-values (((a_253) (car d_247))) #t)
                                                                    (let-values (((d_248) (cdr d_247)))
                                                                      (if (pair? d_248)
                                                                        (if (let-values (((a_254) (car d_248))) #t)
                                                                          (let-values (((d_249) (cdr d_248)))
                                                                            (equal? '() d_249))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f)
                                                        (let-values (((ids_38 rhs_38)
                                                                      (let-values (((d_250) (cdr v_55)))
                                                                        (let-values (((ids_39)
                                                                                      (let-values (((a_255)
                                                                                                    (car d_250)))
                                                                                        a_255))
                                                                                     ((rhs_39)
                                                                                      (let-values (((d_251)
                                                                                                    (cdr d_250)))
                                                                                        (let-values (((a_256)
                                                                                                      (car d_251)))
                                                                                          a_256))))
                                                                          (values ids_39 rhs_39)))))
                                                          (list 'define-values ids_38 (schemify_0 rhs_38)))
                                                        (if (if (pair? v_55)
                                                              (if (let-values (((a_257) (car v_55)))
                                                                    (equal? 'quote a_257))
                                                                (let-values (((d_252) (cdr v_55)))
                                                                  (if (pair? d_252)
                                                                    (if (let-values (((a_258) (car d_252))) #t)
                                                                      (let-values (((d_253) (cdr d_252)))
                                                                        (equal? '() d_253))
                                                                      #f)
                                                                    #f))
                                                                #f)
                                                              #f)
                                                          (let-values () v_54)
                                                          (if (if (pair? v_55)
                                                                (if (let-values (((a_259) (car v_55)))
                                                                      (equal? 'let-values a_259))
                                                                  (let-values (((d_254) (cdr v_55)))
                                                                    (if (pair? d_254)
                                                                      (if (let-values (((a_260) (car d_254)))
                                                                            (equal? '() a_260))
                                                                        (let-values (((d_255) (cdr d_254)))
                                                                          (if (pair? d_255)
                                                                            (if (let-values (((a_261) (car d_255))) #t)
                                                                              (let-values (((d_256) (cdr d_255)))
                                                                                (equal? '() d_256))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f)
                                                            (let-values (((body_24)
                                                                          (let-values (((d_257) (cdr v_55)))
                                                                            (let-values (((d_258) (cdr d_257)))
                                                                              (let-values (((a_262) (car d_258)))
                                                                                a_262)))))
                                                              (schemify_0 body_24))
                                                            (if (if (pair? v_55)
                                                                  (if (let-values (((a_263) (car v_55)))
                                                                        (equal? 'let-values a_263))
                                                                    (let-values (((d_259) (cdr v_55)))
                                                                      (if (pair? d_259)
                                                                        (if (let-values (((a_264) (car d_259)))
                                                                              (equal? '() a_264))
                                                                          (let-values (((d_260) (cdr d_259)))
                                                                            (list? d_260))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f)
                                                              (let-values (((bodys_24)
                                                                            (let-values (((d_261) (cdr v_55)))
                                                                              (let-values (((d_262) (cdr d_261)))
                                                                                d_262))))
                                                                (list* 'begin (map2 schemify_0 bodys_24)))
                                                              (if (if (pair? v_55)
                                                                    (if (let-values (((a_265) (car v_55)))
                                                                          (equal? 'let-values a_265))
                                                                      (let-values (((d_263) (cdr v_55)))
                                                                        (if (pair? d_263)
                                                                          (if (let-values (((a_266) (car d_263)))
                                                                                (if (list? a_266)
                                                                                  (let-values (((lst_104) a_266))
                                                                                    (begin
                                                                                      (check-list lst_104)
                                                                                      ((letrec-values (((for-loop_54)
                                                                                                        (lambda (result_53
                                                                                                                 lst_105)
                                                                                                          (if (pair?
                                                                                                               lst_105)
                                                                                                            (let-values (((v_61)
                                                                                                                          (unsafe-car
                                                                                                                           lst_105))
                                                                                                                         ((rest_61)
                                                                                                                          (unsafe-cdr
                                                                                                                           lst_105)))
                                                                                                              (let-values (((result_54)
                                                                                                                            (let-values ()
                                                                                                                              (let-values (((result_55)
                                                                                                                                            (let-values ()
                                                                                                                                              (let-values ()
                                                                                                                                                (if (pair?
                                                                                                                                                     v_61)
                                                                                                                                                  (if (let-values (((a_267)
                                                                                                                                                                    (car
                                                                                                                                                                     v_61)))
                                                                                                                                                        (if (pair?
                                                                                                                                                             a_267)
                                                                                                                                                          (if (let-values (((a_268)
                                                                                                                                                                            (car
                                                                                                                                                                             a_267)))
                                                                                                                                                                #t)
                                                                                                                                                            (let-values (((d_264)
                                                                                                                                                                          (cdr
                                                                                                                                                                           a_267)))
                                                                                                                                                              (equal?
                                                                                                                                                               '()
                                                                                                                                                               d_264))
                                                                                                                                                            #f)
                                                                                                                                                          #f))
                                                                                                                                                    (let-values (((d_265)
                                                                                                                                                                  (cdr
                                                                                                                                                                   v_61)))
                                                                                                                                                      (if (pair?
                                                                                                                                                           d_265)
                                                                                                                                                        (if (let-values (((a_269)
                                                                                                                                                                          (car
                                                                                                                                                                           d_265)))
                                                                                                                                                              #t)
                                                                                                                                                          (let-values (((d_266)
                                                                                                                                                                        (cdr
                                                                                                                                                                         d_265)))
                                                                                                                                                            (equal?
                                                                                                                                                             '()
                                                                                                                                                             d_266))
                                                                                                                                                          #f)
                                                                                                                                                        #f))
                                                                                                                                                    #f)
                                                                                                                                                  #f)))))
                                                                                                                                (values
                                                                                                                                 result_55)))))
                                                                                                                (if (if (not
                                                                                                                         ((lambda x_16
                                                                                                                            (not
                                                                                                                             result_54))
                                                                                                                          v_61))
                                                                                                                      (not
                                                                                                                       #f)
                                                                                                                      #f)
                                                                                                                  (for-loop_54
                                                                                                                   result_54
                                                                                                                   rest_61)
                                                                                                                  result_54)))
                                                                                                            result_53))))
                                                                                         for-loop_54)
                                                                                       #t
                                                                                       lst_104)))
                                                                                  #f))
                                                                            (let-values (((d_267) (cdr d_263)))
                                                                              (list? d_267))
                                                                            #f)
                                                                          #f))
                                                                      #f)
                                                                    #f)
                                                                (let-values (((ids_40 rhss_60 bodys_25)
                                                                              (let-values (((d_268) (cdr v_55)))
                                                                                (let-values (((ids_41 rhss_61)
                                                                                              (let-values (((a_270)
                                                                                                            (car
                                                                                                             d_268)))
                                                                                                (let-values (((ids_42
                                                                                                               rhss_62)
                                                                                                              (let-values (((lst_106)
                                                                                                                            a_270))
                                                                                                                (begin
                                                                                                                  (check-list
                                                                                                                   lst_106)
                                                                                                                  ((letrec-values (((for-loop_55)
                                                                                                                                    (lambda (ids_43
                                                                                                                                             rhss_63
                                                                                                                                             lst_107)
                                                                                                                                      (if (pair?
                                                                                                                                           lst_107)
                                                                                                                                        (let-values (((v_62)
                                                                                                                                                      (unsafe-car
                                                                                                                                                       lst_107))
                                                                                                                                                     ((rest_62)
                                                                                                                                                      (unsafe-cdr
                                                                                                                                                       lst_107)))
                                                                                                                                          (let-values (((ids_44
                                                                                                                                                         rhss_64)
                                                                                                                                                        (let-values (((ids_45)
                                                                                                                                                                      ids_43)
                                                                                                                                                                     ((rhss_65)
                                                                                                                                                                      rhss_63))
                                                                                                                                                          (let-values (((ids_46
                                                                                                                                                                         rhss_66)
                                                                                                                                                                        (let-values ()
                                                                                                                                                                          (let-values (((ids3_0
                                                                                                                                                                                         rhss4_3)
                                                                                                                                                                                        (let-values ()
                                                                                                                                                                                          (let-values (((ids_47)
                                                                                                                                                                                                        (let-values (((a_271)
                                                                                                                                                                                                                      (car
                                                                                                                                                                                                                       v_62)))
                                                                                                                                                                                                          (let-values (((a_272)
                                                                                                                                                                                                                        (car
                                                                                                                                                                                                                         a_271)))
                                                                                                                                                                                                            a_272)))
                                                                                                                                                                                                       ((rhss_67)
                                                                                                                                                                                                        (let-values (((d_269)
                                                                                                                                                                                                                      (cdr
                                                                                                                                                                                                                       v_62)))
                                                                                                                                                                                                          (let-values (((a_273)
                                                                                                                                                                                                                        (car
                                                                                                                                                                                                                         d_269)))
                                                                                                                                                                                                            a_273))))
                                                                                                                                                                                            (values
                                                                                                                                                                                             ids_47
                                                                                                                                                                                             rhss_67)))))
                                                                                                                                                                            (values
                                                                                                                                                                             (cons
                                                                                                                                                                              ids3_0
                                                                                                                                                                              ids_45)
                                                                                                                                                                             (cons
                                                                                                                                                                              rhss4_3
                                                                                                                                                                              rhss_65))))))
                                                                                                                                                            (values
                                                                                                                                                             ids_46
                                                                                                                                                             rhss_66)))))
                                                                                                                                            (if (not
                                                                                                                                                 #f)
                                                                                                                                              (for-loop_55
                                                                                                                                               ids_44
                                                                                                                                               rhss_64
                                                                                                                                               rest_62)
                                                                                                                                              (values
                                                                                                                                               ids_44
                                                                                                                                               rhss_64))))
                                                                                                                                        (values
                                                                                                                                         ids_43
                                                                                                                                         rhss_63)))))
                                                                                                                     for-loop_55)
                                                                                                                   null
                                                                                                                   null
                                                                                                                   lst_106)))))
                                                                                                  (values
                                                                                                   (reverse$1 ids_42)
                                                                                                   (reverse$1
                                                                                                    rhss_62)))))
                                                                                             ((bodys_26)
                                                                                              (let-values (((d_270)
                                                                                                            (cdr
                                                                                                             d_268)))
                                                                                                d_270)))
                                                                                  (values ids_41 rhss_61 bodys_26)))))
                                                                  (let-values (((new-knowns_0)
                                                                                (let-values (((lst_108) ids_40)
                                                                                             ((lst_109) rhss_60))
                                                                                  (begin
                                                                                    (check-list lst_108)
                                                                                    (check-list lst_109)
                                                                                    ((letrec-values (((for-loop_56)
                                                                                                      (lambda (knowns_27
                                                                                                               lst_110
                                                                                                               lst_111)
                                                                                                        (if (if (pair?
                                                                                                                 lst_110)
                                                                                                              (pair?
                                                                                                               lst_111)
                                                                                                              #f)
                                                                                                          (let-values (((id_25)
                                                                                                                        (unsafe-car
                                                                                                                         lst_110))
                                                                                                                       ((rest_63)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_110))
                                                                                                                       ((rhs_40)
                                                                                                                        (unsafe-car
                                                                                                                         lst_111))
                                                                                                                       ((rest_64)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_111)))
                                                                                                            (let-values (((knowns_28)
                                                                                                                          (let-values (((knowns_29)
                                                                                                                                        knowns_27))
                                                                                                                            (let-values (((knowns_30)
                                                                                                                                          (let-values ()
                                                                                                                                            (if (lambda?
                                                                                                                                                 rhs_40)
                                                                                                                                              (hash-set
                                                                                                                                               knowns_29
                                                                                                                                               id_25
                                                                                                                                               a-known-procedure)
                                                                                                                                              knowns_29))))
                                                                                                                              (values
                                                                                                                               knowns_30)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_56
                                                                                                                 knowns_28
                                                                                                                 rest_63
                                                                                                                 rest_64)
                                                                                                                knowns_28)))
                                                                                                          knowns_27))))
                                                                                       for-loop_56)
                                                                                     knowns_26
                                                                                     lst_108
                                                                                     lst_109)))))
                                                                    (left-to-right/let
                                                                     (list*
                                                                      'let
                                                                      (let-values (((lst_112) ids_40)
                                                                                   ((lst_113) rhss_60))
                                                                        (begin
                                                                          (check-list lst_112)
                                                                          (check-list lst_113)
                                                                          ((letrec-values (((for-loop_57)
                                                                                            (lambda (lst_114 lst_115)
                                                                                              (if (if (pair? lst_114)
                                                                                                    (pair? lst_115)
                                                                                                    #f)
                                                                                                (let-values (((id_26)
                                                                                                              (unsafe-car
                                                                                                               lst_114))
                                                                                                             ((rest_65)
                                                                                                              (unsafe-cdr
                                                                                                               lst_114))
                                                                                                             ((rhs_41)
                                                                                                              (unsafe-car
                                                                                                               lst_115))
                                                                                                             ((rest_66)
                                                                                                              (unsafe-cdr
                                                                                                               lst_115)))
                                                                                                  (let-values (((post-guard-var_9)
                                                                                                                (lambda ()
                                                                                                                  #t)))
                                                                                                    (let-values ()
                                                                                                      (let-values (((elem_8)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (list
                                                                                                                         id_26
                                                                                                                         (schemify_0
                                                                                                                          rhs_41))))))
                                                                                                        (let-values (((result_56)
                                                                                                                      (if (post-guard-var_9)
                                                                                                                        (for-loop_57
                                                                                                                         rest_65
                                                                                                                         rest_66)
                                                                                                                        null)))
                                                                                                          (cons
                                                                                                           elem_8
                                                                                                           result_56))))))
                                                                                                null))))
                                                                             for-loop_57)
                                                                           lst_112
                                                                           lst_113)))
                                                                      (let-values (((lst_116) bodys_25))
                                                                        (begin
                                                                          (check-list lst_116)
                                                                          ((letrec-values (((for-loop_58)
                                                                                            (lambda (lst_117)
                                                                                              (if (pair? lst_117)
                                                                                                (let-values (((body_25)
                                                                                                              (unsafe-car
                                                                                                               lst_117))
                                                                                                             ((rest_67)
                                                                                                              (unsafe-cdr
                                                                                                               lst_117)))
                                                                                                  (let-values (((post-guard-var_10)
                                                                                                                (lambda ()
                                                                                                                  #t)))
                                                                                                    (let-values ()
                                                                                                      (let-values (((elem_9)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (schemify/knowns_0
                                                                                                                         new-knowns_0
                                                                                                                         body_25)))))
                                                                                                        (let-values (((result_57)
                                                                                                                      (if (post-guard-var_10)
                                                                                                                        (for-loop_58
                                                                                                                         rest_67)
                                                                                                                        null)))
                                                                                                          (cons
                                                                                                           elem_9
                                                                                                           result_57))))))
                                                                                                null))))
                                                                             for-loop_58)
                                                                           lst_116))))
                                                                     prim-knowns_6
                                                                     knowns_26
                                                                     imports_17
                                                                     mutated_7)))
                                                                (if (if (pair? v_55)
                                                                      (if (let-values (((a_274) (car v_55)))
                                                                            (equal? 'let-values a_274))
                                                                        (let-values (((d_271) (cdr v_55)))
                                                                          (if (pair? d_271)
                                                                            (if (let-values (((a_275) (car d_271)))
                                                                                  (if (pair? a_275)
                                                                                    (if (let-values (((a_276)
                                                                                                      (car a_275)))
                                                                                          (if (pair? a_276)
                                                                                            (if (let-values (((a_277)
                                                                                                              (car
                                                                                                               a_276)))
                                                                                                  (equal? '() a_277))
                                                                                              (let-values (((d_272)
                                                                                                            (cdr
                                                                                                             a_276)))
                                                                                                (if (pair? d_272)
                                                                                                  (if (let-values (((a_278)
                                                                                                                    (car
                                                                                                                     d_272)))
                                                                                                        (if (pair?
                                                                                                             a_278)
                                                                                                          (if (let-values (((a_279)
                                                                                                                            (car
                                                                                                                             a_278)))
                                                                                                                (equal?
                                                                                                                 'begin
                                                                                                                 a_279))
                                                                                                            (let-values (((d_273)
                                                                                                                          (cdr
                                                                                                                           a_278)))
                                                                                                              (if (pair?
                                                                                                                   d_273)
                                                                                                                (if (let-values (((a_280)
                                                                                                                                  (car
                                                                                                                                   d_273)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_274)
                                                                                                                                (cdr
                                                                                                                                 d_273)))
                                                                                                                    (if (pair?
                                                                                                                         d_274)
                                                                                                                      (if (let-values (((a_281)
                                                                                                                                        (car
                                                                                                                                         d_274)))
                                                                                                                            (equal?
                                                                                                                             '...
                                                                                                                             a_281))
                                                                                                                        (let-values (((d_275)
                                                                                                                                      (cdr
                                                                                                                                       d_274)))
                                                                                                                          (if (pair?
                                                                                                                               d_275)
                                                                                                                            (if (let-values (((a_282)
                                                                                                                                              (car
                                                                                                                                               d_275)))
                                                                                                                                  (if (pair?
                                                                                                                                       a_282)
                                                                                                                                    (if (let-values (((a_283)
                                                                                                                                                      (car
                                                                                                                                                       a_282)))
                                                                                                                                          (equal?
                                                                                                                                           'values
                                                                                                                                           a_283))
                                                                                                                                      (let-values (((d_276)
                                                                                                                                                    (cdr
                                                                                                                                                     a_282)))
                                                                                                                                        (equal?
                                                                                                                                         '()
                                                                                                                                         d_276))
                                                                                                                                      #f)
                                                                                                                                    #f))
                                                                                                                              (let-values (((d_277)
                                                                                                                                            (cdr
                                                                                                                                             d_275)))
                                                                                                                                (equal?
                                                                                                                                 '()
                                                                                                                                 d_277))
                                                                                                                              #f)
                                                                                                                            #f))
                                                                                                                        #f)
                                                                                                                      #f))
                                                                                                                  #f)
                                                                                                                #f))
                                                                                                            #f)
                                                                                                          #f))
                                                                                                    (let-values (((d_278)
                                                                                                                  (cdr
                                                                                                                   d_272)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_278))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f))
                                                                                      (let-values (((d_279)
                                                                                                    (cdr a_275)))
                                                                                        (equal? '() d_279))
                                                                                      #f)
                                                                                    #f))
                                                                              (let-values (((d_280) (cdr d_271)))
                                                                                (list? d_280))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f)
                                                                  (let-values (((rhss_68 bodys_27)
                                                                                (let-values (((d_281) (cdr v_55)))
                                                                                  (let-values (((rhss_69)
                                                                                                (let-values (((a_284)
                                                                                                              (car
                                                                                                               d_281)))
                                                                                                  (let-values (((a_285)
                                                                                                                (car
                                                                                                                 a_284)))
                                                                                                    (let-values (((d_282)
                                                                                                                  (cdr
                                                                                                                   a_285)))
                                                                                                      (let-values (((a_286)
                                                                                                                    (car
                                                                                                                     d_282)))
                                                                                                        (let-values (((d_283)
                                                                                                                      (cdr
                                                                                                                       a_286)))
                                                                                                          (let-values (((a_287)
                                                                                                                        (car
                                                                                                                         d_283)))
                                                                                                            a_287)))))))
                                                                                               ((bodys_28)
                                                                                                (let-values (((d_284)
                                                                                                              (cdr
                                                                                                               d_281)))
                                                                                                  d_284)))
                                                                                    (values rhss_69 bodys_28)))))
                                                                    (list*
                                                                     'begin
                                                                     (qq-append
                                                                      (map2 schemify_0 rhss_68)
                                                                      (map2 schemify_0 bodys_27))))
                                                                  (if (if (pair? v_55)
                                                                        (if (let-values (((a_288) (car v_55)))
                                                                              (equal? 'let-values a_288))
                                                                          (let-values (((d_285) (cdr v_55)))
                                                                            (if (pair? d_285)
                                                                              (if (let-values (((a_289) (car d_285)))
                                                                                    (if (list? a_289)
                                                                                      (let-values (((lst_118) a_289))
                                                                                        (begin
                                                                                          (check-list lst_118)
                                                                                          ((letrec-values (((for-loop_59)
                                                                                                            (lambda (result_58
                                                                                                                     lst_119)
                                                                                                              (if (pair?
                                                                                                                   lst_119)
                                                                                                                (let-values (((v_63)
                                                                                                                              (unsafe-car
                                                                                                                               lst_119))
                                                                                                                             ((rest_68)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_119)))
                                                                                                                  (let-values (((result_59)
                                                                                                                                (let-values ()
                                                                                                                                  (let-values (((result_60)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values ()
                                                                                                                                                    (if (pair?
                                                                                                                                                         v_63)
                                                                                                                                                      (if (let-values (((a_290)
                                                                                                                                                                        (car
                                                                                                                                                                         v_63)))
                                                                                                                                                            (list?
                                                                                                                                                             a_290))
                                                                                                                                                        (let-values (((d_286)
                                                                                                                                                                      (cdr
                                                                                                                                                                       v_63)))
                                                                                                                                                          (if (pair?
                                                                                                                                                               d_286)
                                                                                                                                                            (if (let-values (((a_291)
                                                                                                                                                                              (car
                                                                                                                                                                               d_286)))
                                                                                                                                                                  #t)
                                                                                                                                                              (let-values (((d_287)
                                                                                                                                                                            (cdr
                                                                                                                                                                             d_286)))
                                                                                                                                                                (equal?
                                                                                                                                                                 '()
                                                                                                                                                                 d_287))
                                                                                                                                                              #f)
                                                                                                                                                            #f))
                                                                                                                                                        #f)
                                                                                                                                                      #f)))))
                                                                                                                                    (values
                                                                                                                                     result_60)))))
                                                                                                                    (if (if (not
                                                                                                                             ((lambda x_17
                                                                                                                                (not
                                                                                                                                 result_59))
                                                                                                                              v_63))
                                                                                                                          (not
                                                                                                                           #f)
                                                                                                                          #f)
                                                                                                                      (for-loop_59
                                                                                                                       result_59
                                                                                                                       rest_68)
                                                                                                                      result_59)))
                                                                                                                result_58))))
                                                                                             for-loop_59)
                                                                                           #t
                                                                                           lst_118)))
                                                                                      #f))
                                                                                (let-values (((d_288) (cdr d_285)))
                                                                                  (list? d_288))
                                                                                #f)
                                                                              #f))
                                                                          #f)
                                                                        #f)
                                                                    (let-values (((idss_33 rhss_70 bodys_29)
                                                                                  (let-values (((d_289) (cdr v_55)))
                                                                                    (let-values (((idss_34 rhss_71)
                                                                                                  (let-values (((a_292)
                                                                                                                (car
                                                                                                                 d_289)))
                                                                                                    (let-values (((idss_35
                                                                                                                   rhss_72)
                                                                                                                  (let-values (((lst_120)
                                                                                                                                a_292))
                                                                                                                    (begin
                                                                                                                      (check-list
                                                                                                                       lst_120)
                                                                                                                      ((letrec-values (((for-loop_60)
                                                                                                                                        (lambda (idss_36
                                                                                                                                                 rhss_73
                                                                                                                                                 lst_121)
                                                                                                                                          (if (pair?
                                                                                                                                               lst_121)
                                                                                                                                            (let-values (((v_64)
                                                                                                                                                          (unsafe-car
                                                                                                                                                           lst_121))
                                                                                                                                                         ((rest_69)
                                                                                                                                                          (unsafe-cdr
                                                                                                                                                           lst_121)))
                                                                                                                                              (let-values (((idss_37
                                                                                                                                                             rhss_74)
                                                                                                                                                            (let-values (((idss_38)
                                                                                                                                                                          idss_36)
                                                                                                                                                                         ((rhss_75)
                                                                                                                                                                          rhss_73))
                                                                                                                                                              (let-values (((idss_39
                                                                                                                                                                             rhss_76)
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (let-values (((idss5_1
                                                                                                                                                                                             rhss6_2)
                                                                                                                                                                                            (let-values ()
                                                                                                                                                                                              (let-values (((idss_40)
                                                                                                                                                                                                            (let-values (((a_293)
                                                                                                                                                                                                                          (car
                                                                                                                                                                                                                           v_64)))
                                                                                                                                                                                                              a_293))
                                                                                                                                                                                                           ((rhss_77)
                                                                                                                                                                                                            (let-values (((d_290)
                                                                                                                                                                                                                          (cdr
                                                                                                                                                                                                                           v_64)))
                                                                                                                                                                                                              (let-values (((a_294)
                                                                                                                                                                                                                            (car
                                                                                                                                                                                                                             d_290)))
                                                                                                                                                                                                                a_294))))
                                                                                                                                                                                                (values
                                                                                                                                                                                                 idss_40
                                                                                                                                                                                                 rhss_77)))))
                                                                                                                                                                                (values
                                                                                                                                                                                 (cons
                                                                                                                                                                                  idss5_1
                                                                                                                                                                                  idss_38)
                                                                                                                                                                                 (cons
                                                                                                                                                                                  rhss6_2
                                                                                                                                                                                  rhss_75))))))
                                                                                                                                                                (values
                                                                                                                                                                 idss_39
                                                                                                                                                                 rhss_76)))))
                                                                                                                                                (if (not
                                                                                                                                                     #f)
                                                                                                                                                  (for-loop_60
                                                                                                                                                   idss_37
                                                                                                                                                   rhss_74
                                                                                                                                                   rest_69)
                                                                                                                                                  (values
                                                                                                                                                   idss_37
                                                                                                                                                   rhss_74))))
                                                                                                                                            (values
                                                                                                                                             idss_36
                                                                                                                                             rhss_73)))))
                                                                                                                         for-loop_60)
                                                                                                                       null
                                                                                                                       null
                                                                                                                       lst_120)))))
                                                                                                      (values
                                                                                                       (reverse$1
                                                                                                        idss_35)
                                                                                                       (reverse$1
                                                                                                        rhss_72)))))
                                                                                                 ((bodys_30)
                                                                                                  (let-values (((d_291)
                                                                                                                (cdr
                                                                                                                 d_289)))
                                                                                                    d_291)))
                                                                                      (values
                                                                                       idss_34
                                                                                       rhss_71
                                                                                       bodys_30)))))
                                                                      (left-to-right/let-values
                                                                       (list*
                                                                        'let-values
                                                                        (let-values (((lst_122) idss_33)
                                                                                     ((lst_123) rhss_70))
                                                                          (begin
                                                                            (check-list lst_122)
                                                                            (check-list lst_123)
                                                                            ((letrec-values (((for-loop_61)
                                                                                              (lambda (lst_124 lst_125)
                                                                                                (if (if (pair? lst_124)
                                                                                                      (pair? lst_125)
                                                                                                      #f)
                                                                                                  (let-values (((ids_48)
                                                                                                                (unsafe-car
                                                                                                                 lst_124))
                                                                                                               ((rest_70)
                                                                                                                (unsafe-cdr
                                                                                                                 lst_124))
                                                                                                               ((rhs_42)
                                                                                                                (unsafe-car
                                                                                                                 lst_125))
                                                                                                               ((rest_71)
                                                                                                                (unsafe-cdr
                                                                                                                 lst_125)))
                                                                                                    (let-values (((post-guard-var_11)
                                                                                                                  (lambda ()
                                                                                                                    #t)))
                                                                                                      (let-values ()
                                                                                                        (let-values (((elem_10)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (list
                                                                                                                           ids_48
                                                                                                                           (schemify_0
                                                                                                                            rhs_42))))))
                                                                                                          (let-values (((result_61)
                                                                                                                        (if (post-guard-var_11)
                                                                                                                          (for-loop_61
                                                                                                                           rest_70
                                                                                                                           rest_71)
                                                                                                                          null)))
                                                                                                            (cons
                                                                                                             elem_10
                                                                                                             result_61))))))
                                                                                                  null))))
                                                                               for-loop_61)
                                                                             lst_122
                                                                             lst_123)))
                                                                        (map2 schemify_0 bodys_29))
                                                                       mutated_7))
                                                                    (if (if (pair? v_55)
                                                                          (if (let-values (((a_295) (car v_55)))
                                                                                (equal? 'letrec-values a_295))
                                                                            (let-values (((d_292) (cdr v_55)))
                                                                              (if (pair? d_292)
                                                                                (if (let-values (((a_296) (car d_292)))
                                                                                      (if (list? a_296)
                                                                                        (let-values (((lst_126) a_296))
                                                                                          (begin
                                                                                            (check-list lst_126)
                                                                                            ((letrec-values (((for-loop_62)
                                                                                                              (lambda (result_62
                                                                                                                       lst_127)
                                                                                                                (if (pair?
                                                                                                                     lst_127)
                                                                                                                  (let-values (((v_65)
                                                                                                                                (unsafe-car
                                                                                                                                 lst_127))
                                                                                                                               ((rest_72)
                                                                                                                                (unsafe-cdr
                                                                                                                                 lst_127)))
                                                                                                                    (let-values (((result_63)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values (((result_64)
                                                                                                                                                  (let-values ()
                                                                                                                                                    (let-values ()
                                                                                                                                                      (if (pair?
                                                                                                                                                           v_65)
                                                                                                                                                        (if (let-values (((a_297)
                                                                                                                                                                          (car
                                                                                                                                                                           v_65)))
                                                                                                                                                              (if (pair?
                                                                                                                                                                   a_297)
                                                                                                                                                                (if (let-values (((a_298)
                                                                                                                                                                                  (car
                                                                                                                                                                                   a_297)))
                                                                                                                                                                      #t)
                                                                                                                                                                  (let-values (((d_293)
                                                                                                                                                                                (cdr
                                                                                                                                                                                 a_297)))
                                                                                                                                                                    (equal?
                                                                                                                                                                     '()
                                                                                                                                                                     d_293))
                                                                                                                                                                  #f)
                                                                                                                                                                #f))
                                                                                                                                                          (let-values (((d_294)
                                                                                                                                                                        (cdr
                                                                                                                                                                         v_65)))
                                                                                                                                                            (if (pair?
                                                                                                                                                                 d_294)
                                                                                                                                                              (if (let-values (((a_299)
                                                                                                                                                                                (car
                                                                                                                                                                                 d_294)))
                                                                                                                                                                    #t)
                                                                                                                                                                (let-values (((d_295)
                                                                                                                                                                              (cdr
                                                                                                                                                                               d_294)))
                                                                                                                                                                  (equal?
                                                                                                                                                                   '()
                                                                                                                                                                   d_295))
                                                                                                                                                                #f)
                                                                                                                                                              #f))
                                                                                                                                                          #f)
                                                                                                                                                        #f)))))
                                                                                                                                      (values
                                                                                                                                       result_64)))))
                                                                                                                      (if (if (not
                                                                                                                               ((lambda x_18
                                                                                                                                  (not
                                                                                                                                   result_63))
                                                                                                                                v_65))
                                                                                                                            (not
                                                                                                                             #f)
                                                                                                                            #f)
                                                                                                                        (for-loop_62
                                                                                                                         result_63
                                                                                                                         rest_72)
                                                                                                                        result_63)))
                                                                                                                  result_62))))
                                                                                               for-loop_62)
                                                                                             #t
                                                                                             lst_126)))
                                                                                        #f))
                                                                                  (let-values (((d_296) (cdr d_292)))
                                                                                    (list? d_296))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f)
                                                                      (let-values (((ids_49 rhss_78 bodys_31)
                                                                                    (let-values (((d_297) (cdr v_55)))
                                                                                      (let-values (((ids_50 rhss_79)
                                                                                                    (let-values (((a_300)
                                                                                                                  (car
                                                                                                                   d_297)))
                                                                                                      (let-values (((ids_51
                                                                                                                     rhss_80)
                                                                                                                    (let-values (((lst_128)
                                                                                                                                  a_300))
                                                                                                                      (begin
                                                                                                                        (check-list
                                                                                                                         lst_128)
                                                                                                                        ((letrec-values (((for-loop_63)
                                                                                                                                          (lambda (ids_52
                                                                                                                                                   rhss_81
                                                                                                                                                   lst_129)
                                                                                                                                            (if (pair?
                                                                                                                                                 lst_129)
                                                                                                                                              (let-values (((v_66)
                                                                                                                                                            (unsafe-car
                                                                                                                                                             lst_129))
                                                                                                                                                           ((rest_73)
                                                                                                                                                            (unsafe-cdr
                                                                                                                                                             lst_129)))
                                                                                                                                                (let-values (((ids_53
                                                                                                                                                               rhss_82)
                                                                                                                                                              (let-values (((ids_54)
                                                                                                                                                                            ids_52)
                                                                                                                                                                           ((rhss_83)
                                                                                                                                                                            rhss_81))
                                                                                                                                                                (let-values (((ids_55
                                                                                                                                                                               rhss_84)
                                                                                                                                                                              (let-values ()
                                                                                                                                                                                (let-values (((ids7_0
                                                                                                                                                                                               rhss8_0)
                                                                                                                                                                                              (let-values ()
                                                                                                                                                                                                (let-values (((ids_56)
                                                                                                                                                                                                              (let-values (((a_301)
                                                                                                                                                                                                                            (car
                                                                                                                                                                                                                             v_66)))
                                                                                                                                                                                                                (let-values (((a_302)
                                                                                                                                                                                                                              (car
                                                                                                                                                                                                                               a_301)))
                                                                                                                                                                                                                  a_302)))
                                                                                                                                                                                                             ((rhss_85)
                                                                                                                                                                                                              (let-values (((d_298)
                                                                                                                                                                                                                            (cdr
                                                                                                                                                                                                                             v_66)))
                                                                                                                                                                                                                (let-values (((a_303)
                                                                                                                                                                                                                              (car
                                                                                                                                                                                                                               d_298)))
                                                                                                                                                                                                                  a_303))))
                                                                                                                                                                                                  (values
                                                                                                                                                                                                   ids_56
                                                                                                                                                                                                   rhss_85)))))
                                                                                                                                                                                  (values
                                                                                                                                                                                   (cons
                                                                                                                                                                                    ids7_0
                                                                                                                                                                                    ids_54)
                                                                                                                                                                                   (cons
                                                                                                                                                                                    rhss8_0
                                                                                                                                                                                    rhss_83))))))
                                                                                                                                                                  (values
                                                                                                                                                                   ids_55
                                                                                                                                                                   rhss_84)))))
                                                                                                                                                  (if (not
                                                                                                                                                       #f)
                                                                                                                                                    (for-loop_63
                                                                                                                                                     ids_53
                                                                                                                                                     rhss_82
                                                                                                                                                     rest_73)
                                                                                                                                                    (values
                                                                                                                                                     ids_53
                                                                                                                                                     rhss_82))))
                                                                                                                                              (values
                                                                                                                                               ids_52
                                                                                                                                               rhss_81)))))
                                                                                                                           for-loop_63)
                                                                                                                         null
                                                                                                                         null
                                                                                                                         lst_128)))))
                                                                                                        (values
                                                                                                         (reverse$1
                                                                                                          ids_51)
                                                                                                         (reverse$1
                                                                                                          rhss_80)))))
                                                                                                   ((bodys_32)
                                                                                                    (let-values (((d_299)
                                                                                                                  (cdr
                                                                                                                   d_297)))
                                                                                                      d_299)))
                                                                                        (values
                                                                                         ids_50
                                                                                         rhss_79
                                                                                         bodys_32)))))
                                                                        (let-values (((new-knowns_1)
                                                                                      (let-values (((lst_130) ids_49)
                                                                                                   ((lst_131) rhss_78))
                                                                                        (begin
                                                                                          (check-list lst_130)
                                                                                          (check-list lst_131)
                                                                                          ((letrec-values (((for-loop_64)
                                                                                                            (lambda (knowns_31
                                                                                                                     lst_132
                                                                                                                     lst_133)
                                                                                                              (if (if (pair?
                                                                                                                       lst_132)
                                                                                                                    (pair?
                                                                                                                     lst_133)
                                                                                                                    #f)
                                                                                                                (let-values (((id_27)
                                                                                                                              (unsafe-car
                                                                                                                               lst_132))
                                                                                                                             ((rest_74)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_132))
                                                                                                                             ((rhs_43)
                                                                                                                              (unsafe-car
                                                                                                                               lst_133))
                                                                                                                             ((rest_75)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_133)))
                                                                                                                  (let-values (((knowns_32)
                                                                                                                                (let-values (((knowns_33)
                                                                                                                                              knowns_31))
                                                                                                                                  (let-values (((knowns_34)
                                                                                                                                                (let-values ()
                                                                                                                                                  (if (lambda?
                                                                                                                                                       rhs_43)
                                                                                                                                                    (hash-set
                                                                                                                                                     knowns_33
                                                                                                                                                     id_27
                                                                                                                                                     a-known-procedure)
                                                                                                                                                    knowns_33))))
                                                                                                                                    (values
                                                                                                                                     knowns_34)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_64
                                                                                                                       knowns_32
                                                                                                                       rest_74
                                                                                                                       rest_75)
                                                                                                                      knowns_32)))
                                                                                                                knowns_31))))
                                                                                             for-loop_64)
                                                                                           knowns_26
                                                                                           lst_130
                                                                                           lst_131)))))
                                                                          (list*
                                                                           'letrec*
                                                                           (let-values (((lst_134) ids_49)
                                                                                        ((lst_135) rhss_78))
                                                                             (begin
                                                                               (check-list lst_134)
                                                                               (check-list lst_135)
                                                                               ((letrec-values (((for-loop_65)
                                                                                                 (lambda (lst_136
                                                                                                          lst_137)
                                                                                                   (if (if (pair?
                                                                                                            lst_136)
                                                                                                         (pair? lst_137)
                                                                                                         #f)
                                                                                                     (let-values (((id_28)
                                                                                                                   (unsafe-car
                                                                                                                    lst_136))
                                                                                                                  ((rest_76)
                                                                                                                   (unsafe-cdr
                                                                                                                    lst_136))
                                                                                                                  ((rhs_44)
                                                                                                                   (unsafe-car
                                                                                                                    lst_137))
                                                                                                                  ((rest_77)
                                                                                                                   (unsafe-cdr
                                                                                                                    lst_137)))
                                                                                                       (let-values (((post-guard-var_12)
                                                                                                                     (lambda ()
                                                                                                                       #t)))
                                                                                                         (let-values ()
                                                                                                           (let-values (((elem_11)
                                                                                                                         (let-values ()
                                                                                                                           (let-values ()
                                                                                                                             (list
                                                                                                                              id_28
                                                                                                                              (schemify_0
                                                                                                                               rhs_44))))))
                                                                                                             (let-values (((result_65)
                                                                                                                           (if (post-guard-var_12)
                                                                                                                             (for-loop_65
                                                                                                                              rest_76
                                                                                                                              rest_77)
                                                                                                                             null)))
                                                                                                               (cons
                                                                                                                elem_11
                                                                                                                result_65))))))
                                                                                                     null))))
                                                                                  for-loop_65)
                                                                                lst_134
                                                                                lst_135)))
                                                                           (let-values (((lst_138) bodys_31))
                                                                             (begin
                                                                               (check-list lst_138)
                                                                               ((letrec-values (((for-loop_66)
                                                                                                 (lambda (lst_139)
                                                                                                   (if (pair? lst_139)
                                                                                                     (let-values (((body_26)
                                                                                                                   (unsafe-car
                                                                                                                    lst_139))
                                                                                                                  ((rest_78)
                                                                                                                   (unsafe-cdr
                                                                                                                    lst_139)))
                                                                                                       (let-values (((post-guard-var_13)
                                                                                                                     (lambda ()
                                                                                                                       #t)))
                                                                                                         (let-values ()
                                                                                                           (let-values (((elem_12)
                                                                                                                         (let-values ()
                                                                                                                           (let-values ()
                                                                                                                             (schemify/knowns_0
                                                                                                                              new-knowns_1
                                                                                                                              body_26)))))
                                                                                                             (let-values (((result_66)
                                                                                                                           (if (post-guard-var_13)
                                                                                                                             (for-loop_66
                                                                                                                              rest_78)
                                                                                                                             null)))
                                                                                                               (cons
                                                                                                                elem_12
                                                                                                                result_66))))))
                                                                                                     null))))
                                                                                  for-loop_66)
                                                                                lst_138))))))
                                                                      (if (if (pair? v_55)
                                                                            (if (let-values (((a_304) (car v_55)))
                                                                                  (equal? 'letrec-values a_304))
                                                                              (let-values (((d_300) (cdr v_55)))
                                                                                (if (pair? d_300)
                                                                                  (if (let-values (((a_305)
                                                                                                    (car d_300)))
                                                                                        (if (list? a_305)
                                                                                          (let-values (((lst_140)
                                                                                                        a_305))
                                                                                            (begin
                                                                                              (check-list lst_140)
                                                                                              ((letrec-values (((for-loop_67)
                                                                                                                (lambda (result_67
                                                                                                                         lst_141)
                                                                                                                  (if (pair?
                                                                                                                       lst_141)
                                                                                                                    (let-values (((v_67)
                                                                                                                                  (unsafe-car
                                                                                                                                   lst_141))
                                                                                                                                 ((rest_79)
                                                                                                                                  (unsafe-cdr
                                                                                                                                   lst_141)))
                                                                                                                      (let-values (((result_68)
                                                                                                                                    (let-values ()
                                                                                                                                      (let-values (((result_69)
                                                                                                                                                    (let-values ()
                                                                                                                                                      (let-values ()
                                                                                                                                                        (if (pair?
                                                                                                                                                             v_67)
                                                                                                                                                          (if (let-values (((a_306)
                                                                                                                                                                            (car
                                                                                                                                                                             v_67)))
                                                                                                                                                                (list?
                                                                                                                                                                 a_306))
                                                                                                                                                            (let-values (((d_301)
                                                                                                                                                                          (cdr
                                                                                                                                                                           v_67)))
                                                                                                                                                              (if (pair?
                                                                                                                                                                   d_301)
                                                                                                                                                                (if (let-values (((a_307)
                                                                                                                                                                                  (car
                                                                                                                                                                                   d_301)))
                                                                                                                                                                      #t)
                                                                                                                                                                  (let-values (((d_302)
                                                                                                                                                                                (cdr
                                                                                                                                                                                 d_301)))
                                                                                                                                                                    (equal?
                                                                                                                                                                     '()
                                                                                                                                                                     d_302))
                                                                                                                                                                  #f)
                                                                                                                                                                #f))
                                                                                                                                                            #f)
                                                                                                                                                          #f)))))
                                                                                                                                        (values
                                                                                                                                         result_69)))))
                                                                                                                        (if (if (not
                                                                                                                                 ((lambda x_19
                                                                                                                                    (not
                                                                                                                                     result_68))
                                                                                                                                  v_67))
                                                                                                                              (not
                                                                                                                               #f)
                                                                                                                              #f)
                                                                                                                          (for-loop_67
                                                                                                                           result_68
                                                                                                                           rest_79)
                                                                                                                          result_68)))
                                                                                                                    result_67))))
                                                                                                 for-loop_67)
                                                                                               #t
                                                                                               lst_140)))
                                                                                          #f))
                                                                                    (let-values (((d_303) (cdr d_300)))
                                                                                      (list? d_303))
                                                                                    #f)
                                                                                  #f))
                                                                              #f)
                                                                            #f)
                                                                        (let-values (((idss_41 rhss_86 bodys_33)
                                                                                      (let-values (((d_304) (cdr v_55)))
                                                                                        (let-values (((idss_42 rhss_87)
                                                                                                      (let-values (((a_308)
                                                                                                                    (car
                                                                                                                     d_304)))
                                                                                                        (let-values (((idss_43
                                                                                                                       rhss_88)
                                                                                                                      (let-values (((lst_142)
                                                                                                                                    a_308))
                                                                                                                        (begin
                                                                                                                          (check-list
                                                                                                                           lst_142)
                                                                                                                          ((letrec-values (((for-loop_68)
                                                                                                                                            (lambda (idss_44
                                                                                                                                                     rhss_89
                                                                                                                                                     lst_143)
                                                                                                                                              (if (pair?
                                                                                                                                                   lst_143)
                                                                                                                                                (let-values (((v_68)
                                                                                                                                                              (unsafe-car
                                                                                                                                                               lst_143))
                                                                                                                                                             ((rest_80)
                                                                                                                                                              (unsafe-cdr
                                                                                                                                                               lst_143)))
                                                                                                                                                  (let-values (((idss_45
                                                                                                                                                                 rhss_90)
                                                                                                                                                                (let-values (((idss_46)
                                                                                                                                                                              idss_44)
                                                                                                                                                                             ((rhss_91)
                                                                                                                                                                              rhss_89))
                                                                                                                                                                  (let-values (((idss_47
                                                                                                                                                                                 rhss_92)
                                                                                                                                                                                (let-values ()
                                                                                                                                                                                  (let-values (((idss9_0
                                                                                                                                                                                                 rhss10_0)
                                                                                                                                                                                                (let-values ()
                                                                                                                                                                                                  (let-values (((idss_48)
                                                                                                                                                                                                                (let-values (((a_309)
                                                                                                                                                                                                                              (car
                                                                                                                                                                                                                               v_68)))
                                                                                                                                                                                                                  a_309))
                                                                                                                                                                                                               ((rhss_93)
                                                                                                                                                                                                                (let-values (((d_305)
                                                                                                                                                                                                                              (cdr
                                                                                                                                                                                                                               v_68)))
                                                                                                                                                                                                                  (let-values (((a_310)
                                                                                                                                                                                                                                (car
                                                                                                                                                                                                                                 d_305)))
                                                                                                                                                                                                                    a_310))))
                                                                                                                                                                                                    (values
                                                                                                                                                                                                     idss_48
                                                                                                                                                                                                     rhss_93)))))
                                                                                                                                                                                    (values
                                                                                                                                                                                     (cons
                                                                                                                                                                                      idss9_0
                                                                                                                                                                                      idss_46)
                                                                                                                                                                                     (cons
                                                                                                                                                                                      rhss10_0
                                                                                                                                                                                      rhss_91))))))
                                                                                                                                                                    (values
                                                                                                                                                                     idss_47
                                                                                                                                                                     rhss_92)))))
                                                                                                                                                    (if (not
                                                                                                                                                         #f)
                                                                                                                                                      (for-loop_68
                                                                                                                                                       idss_45
                                                                                                                                                       rhss_90
                                                                                                                                                       rest_80)
                                                                                                                                                      (values
                                                                                                                                                       idss_45
                                                                                                                                                       rhss_90))))
                                                                                                                                                (values
                                                                                                                                                 idss_44
                                                                                                                                                 rhss_89)))))
                                                                                                                             for-loop_68)
                                                                                                                           null
                                                                                                                           null
                                                                                                                           lst_142)))))
                                                                                                          (values
                                                                                                           (reverse$1
                                                                                                            idss_43)
                                                                                                           (reverse$1
                                                                                                            rhss_88)))))
                                                                                                     ((bodys_34)
                                                                                                      (let-values (((d_306)
                                                                                                                    (cdr
                                                                                                                     d_304)))
                                                                                                        d_306)))
                                                                                          (values
                                                                                           idss_42
                                                                                           rhss_87
                                                                                           bodys_34)))))
                                                                          (list*
                                                                           'letrec*
                                                                           (apply
                                                                            append
                                                                            (let-values (((lst_144) idss_41)
                                                                                         ((lst_145) rhss_86))
                                                                              (begin
                                                                                (check-list lst_144)
                                                                                (check-list lst_145)
                                                                                ((letrec-values (((for-loop_69)
                                                                                                  (lambda (lst_146
                                                                                                           lst_147)
                                                                                                    (if (if (pair?
                                                                                                             lst_146)
                                                                                                          (pair?
                                                                                                           lst_147)
                                                                                                          #f)
                                                                                                      (let-values (((ids_57)
                                                                                                                    (unsafe-car
                                                                                                                     lst_146))
                                                                                                                   ((rest_81)
                                                                                                                    (unsafe-cdr
                                                                                                                     lst_146))
                                                                                                                   ((rhs_45)
                                                                                                                    (unsafe-car
                                                                                                                     lst_147))
                                                                                                                   ((rest_82)
                                                                                                                    (unsafe-cdr
                                                                                                                     lst_147)))
                                                                                                        (let-values (((post-guard-var_14)
                                                                                                                      (lambda ()
                                                                                                                        #t)))
                                                                                                          (let-values ()
                                                                                                            (let-values (((elem_13)
                                                                                                                          (let-values ()
                                                                                                                            (let-values ()
                                                                                                                              (let-values (((rhs_46)
                                                                                                                                            (schemify_0
                                                                                                                                             rhs_45)))
                                                                                                                                (if (null?
                                                                                                                                     ids_57)
                                                                                                                                  (let-values ()
                                                                                                                                    (list
                                                                                                                                     (list
                                                                                                                                      (gensym
                                                                                                                                       "lr")
                                                                                                                                      (make-let-values
                                                                                                                                       null
                                                                                                                                       rhs_46
                                                                                                                                       '(void)))))
                                                                                                                                  (if (if (pair?
                                                                                                                                           ids_57)
                                                                                                                                        (null?
                                                                                                                                         (cdr
                                                                                                                                          ids_57))
                                                                                                                                        #f)
                                                                                                                                    (let-values ()
                                                                                                                                      (list
                                                                                                                                       (list
                                                                                                                                        (car
                                                                                                                                         ids_57)
                                                                                                                                        rhs_46)))
                                                                                                                                    (let-values ()
                                                                                                                                      (let-values (((lr_0)
                                                                                                                                                    (gensym
                                                                                                                                                     "lr")))
                                                                                                                                        (list*
                                                                                                                                         (list
                                                                                                                                          lr_0
                                                                                                                                          (make-let-values
                                                                                                                                           ids_57
                                                                                                                                           rhs_46
                                                                                                                                           (list*
                                                                                                                                            'vector
                                                                                                                                            ids_57)))
                                                                                                                                         (let-values (((lst_148)
                                                                                                                                                       ids_57)
                                                                                                                                                      ((start_2)
                                                                                                                                                       0))
                                                                                                                                           (begin
                                                                                                                                             (check-list
                                                                                                                                              lst_148)
                                                                                                                                             (check-naturals
                                                                                                                                              start_2)
                                                                                                                                             ((letrec-values (((for-loop_70)
                                                                                                                                                               (lambda (lst_149
                                                                                                                                                                        pos_4)
                                                                                                                                                                 (if (if (pair?
                                                                                                                                                                          lst_149)
                                                                                                                                                                       #t
                                                                                                                                                                       #f)
                                                                                                                                                                   (let-values (((id_29)
                                                                                                                                                                                 (unsafe-car
                                                                                                                                                                                  lst_149))
                                                                                                                                                                                ((rest_83)
                                                                                                                                                                                 (unsafe-cdr
                                                                                                                                                                                  lst_149))
                                                                                                                                                                                ((pos_5)
                                                                                                                                                                                 pos_4))
                                                                                                                                                                     (let-values (((post-guard-var_15)
                                                                                                                                                                                   (lambda ()
                                                                                                                                                                                     #t)))
                                                                                                                                                                       (let-values ()
                                                                                                                                                                         (let-values (((elem_14)
                                                                                                                                                                                       (let-values ()
                                                                                                                                                                                         (let-values ()
                                                                                                                                                                                           (list
                                                                                                                                                                                            id_29
                                                                                                                                                                                            (list
                                                                                                                                                                                             'vector-ref
                                                                                                                                                                                             lr_0
                                                                                                                                                                                             pos_5))))))
                                                                                                                                                                           (let-values (((result_70)
                                                                                                                                                                                         (if (post-guard-var_15)
                                                                                                                                                                                           (for-loop_70
                                                                                                                                                                                            rest_83
                                                                                                                                                                                            (+
                                                                                                                                                                                             pos_4
                                                                                                                                                                                             1))
                                                                                                                                                                                           null)))
                                                                                                                                                                             (cons
                                                                                                                                                                              elem_14
                                                                                                                                                                              result_70))))))
                                                                                                                                                                   null))))
                                                                                                                                                for-loop_70)
                                                                                                                                              lst_148
                                                                                                                                              start_2)))))))))))))
                                                                                                              (let-values (((result_71)
                                                                                                                            (if (post-guard-var_14)
                                                                                                                              (for-loop_69
                                                                                                                               rest_81
                                                                                                                               rest_82)
                                                                                                                              null)))
                                                                                                                (cons
                                                                                                                 elem_13
                                                                                                                 result_71))))))
                                                                                                      null))))
                                                                                   for-loop_69)
                                                                                 lst_144
                                                                                 lst_145))))
                                                                           (map2 schemify_0 bodys_33)))
                                                                        (if (if (pair? v_55)
                                                                              (if (let-values (((a_311) (car v_55)))
                                                                                    (equal? 'if a_311))
                                                                                (let-values (((d_307) (cdr v_55)))
                                                                                  (if (pair? d_307)
                                                                                    (if (let-values (((a_312)
                                                                                                      (car d_307)))
                                                                                          #t)
                                                                                      (let-values (((d_308)
                                                                                                    (cdr d_307)))
                                                                                        (if (pair? d_308)
                                                                                          (if (let-values (((a_313)
                                                                                                            (car
                                                                                                             d_308)))
                                                                                                #t)
                                                                                            (let-values (((d_309)
                                                                                                          (cdr d_308)))
                                                                                              (if (pair? d_309)
                                                                                                (if (let-values (((a_314)
                                                                                                                  (car
                                                                                                                   d_309)))
                                                                                                      #t)
                                                                                                  (let-values (((d_310)
                                                                                                                (cdr
                                                                                                                 d_309)))
                                                                                                    (equal? '() d_310))
                                                                                                  #f)
                                                                                                #f))
                                                                                            #f)
                                                                                          #f))
                                                                                      #f)
                                                                                    #f))
                                                                                #f)
                                                                              #f)
                                                                          (let-values (((tst_2 thn_3 els_3)
                                                                                        (let-values (((d_311)
                                                                                                      (cdr v_55)))
                                                                                          (let-values (((tst_3)
                                                                                                        (let-values (((a_315)
                                                                                                                      (car
                                                                                                                       d_311)))
                                                                                                          a_315))
                                                                                                       ((thn_4 els_4)
                                                                                                        (let-values (((d_312)
                                                                                                                      (cdr
                                                                                                                       d_311)))
                                                                                                          (let-values (((thn_5)
                                                                                                                        (let-values (((a_316)
                                                                                                                                      (car
                                                                                                                                       d_312)))
                                                                                                                          a_316))
                                                                                                                       ((els_5)
                                                                                                                        (let-values (((d_313)
                                                                                                                                      (cdr
                                                                                                                                       d_312)))
                                                                                                                          (let-values (((a_317)
                                                                                                                                        (car
                                                                                                                                         d_313)))
                                                                                                                            a_317))))
                                                                                                            (values
                                                                                                             thn_5
                                                                                                             els_5)))))
                                                                                            (values
                                                                                             tst_3
                                                                                             thn_4
                                                                                             els_4)))))
                                                                            (list
                                                                             'if
                                                                             (schemify_0 tst_2)
                                                                             (schemify_0 thn_3)
                                                                             (schemify_0 els_3)))
                                                                          (if (if (pair? v_55)
                                                                                (if (let-values (((a_318) (car v_55)))
                                                                                      (equal?
                                                                                       'with-continuation-mark
                                                                                       a_318))
                                                                                  (let-values (((d_314) (cdr v_55)))
                                                                                    (if (pair? d_314)
                                                                                      (if (let-values (((a_319)
                                                                                                        (car d_314)))
                                                                                            #t)
                                                                                        (let-values (((d_315)
                                                                                                      (cdr d_314)))
                                                                                          (if (pair? d_315)
                                                                                            (if (let-values (((a_320)
                                                                                                              (car
                                                                                                               d_315)))
                                                                                                  #t)
                                                                                              (let-values (((d_316)
                                                                                                            (cdr
                                                                                                             d_315)))
                                                                                                (if (pair? d_316)
                                                                                                  (if (let-values (((a_321)
                                                                                                                    (car
                                                                                                                     d_316)))
                                                                                                        #t)
                                                                                                    (let-values (((d_317)
                                                                                                                  (cdr
                                                                                                                   d_316)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_317))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((key_3 val_3 body_27)
                                                                                          (let-values (((d_318)
                                                                                                        (cdr v_55)))
                                                                                            (let-values (((key_4)
                                                                                                          (let-values (((a_322)
                                                                                                                        (car
                                                                                                                         d_318)))
                                                                                                            a_322))
                                                                                                         ((val_4
                                                                                                           body_28)
                                                                                                          (let-values (((d_319)
                                                                                                                        (cdr
                                                                                                                         d_318)))
                                                                                                            (let-values (((val_5)
                                                                                                                          (let-values (((a_323)
                                                                                                                                        (car
                                                                                                                                         d_319)))
                                                                                                                            a_323))
                                                                                                                         ((body_29)
                                                                                                                          (let-values (((d_320)
                                                                                                                                        (cdr
                                                                                                                                         d_319)))
                                                                                                                            (let-values (((a_324)
                                                                                                                                          (car
                                                                                                                                           d_320)))
                                                                                                                              a_324))))
                                                                                                              (values
                                                                                                               val_5
                                                                                                               body_29)))))
                                                                                              (values
                                                                                               key_4
                                                                                               val_4
                                                                                               body_28)))))
                                                                              (list
                                                                               'with-continuation-mark
                                                                               (schemify_0 key_3)
                                                                               (schemify_0 val_3)
                                                                               (schemify_0 body_27)))
                                                                            (if (if (pair? v_55)
                                                                                  (if (let-values (((a_325) (car v_55)))
                                                                                        (equal? 'begin a_325))
                                                                                    (let-values (((d_321) (cdr v_55)))
                                                                                      (list? d_321))
                                                                                    #f)
                                                                                  #f)
                                                                              (let-values (((exps_5)
                                                                                            (let-values (((d_322)
                                                                                                          (cdr v_55)))
                                                                                              d_322)))
                                                                                (list* 'begin (map2 schemify_0 exps_5)))
                                                                              (if (if (pair? v_55)
                                                                                    (if (let-values (((a_326)
                                                                                                      (car v_55)))
                                                                                          (equal? 'begin0 a_326))
                                                                                      (let-values (((d_323) (cdr v_55)))
                                                                                        (list? d_323))
                                                                                      #f)
                                                                                    #f)
                                                                                (let-values (((exps_6)
                                                                                              (let-values (((d_324)
                                                                                                            (cdr v_55)))
                                                                                                d_324)))
                                                                                  (list*
                                                                                   'begin0
                                                                                   (map2 schemify_0 exps_6)))
                                                                                (if (if (pair? v_55)
                                                                                      (if (let-values (((a_327)
                                                                                                        (car v_55)))
                                                                                            (equal? 'set! a_327))
                                                                                        (let-values (((d_325)
                                                                                                      (cdr v_55)))
                                                                                          (if (pair? d_325)
                                                                                            (if (let-values (((a_328)
                                                                                                              (car
                                                                                                               d_325)))
                                                                                                  #t)
                                                                                              (let-values (((d_326)
                                                                                                            (cdr
                                                                                                             d_325)))
                                                                                                (if (pair? d_326)
                                                                                                  (if (let-values (((a_329)
                                                                                                                    (car
                                                                                                                     d_326)))
                                                                                                        #t)
                                                                                                    (let-values (((d_327)
                                                                                                                  (cdr
                                                                                                                   d_326)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_327))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f)
                                                                                  (let-values (((id_30 rhs_47)
                                                                                                (let-values (((d_328)
                                                                                                              (cdr
                                                                                                               v_55)))
                                                                                                  (let-values (((id_31)
                                                                                                                (let-values (((a_330)
                                                                                                                              (car
                                                                                                                               d_328)))
                                                                                                                  a_330))
                                                                                                               ((rhs_48)
                                                                                                                (let-values (((d_329)
                                                                                                                              (cdr
                                                                                                                               d_328)))
                                                                                                                  (let-values (((a_331)
                                                                                                                                (car
                                                                                                                                 d_329)))
                                                                                                                    a_331))))
                                                                                                    (values
                                                                                                     id_31
                                                                                                     rhs_48)))))
                                                                                    (let-values (((ex-id_0)
                                                                                                  (hash-ref
                                                                                                   exports_9
                                                                                                   id_30
                                                                                                   #f)))
                                                                                      (if ex-id_0
                                                                                        (list
                                                                                         'variable-set!
                                                                                         ex-id_0
                                                                                         (schemify_0 rhs_47))
                                                                                        (list
                                                                                         'set!
                                                                                         id_30
                                                                                         (schemify_0 rhs_47)))))
                                                                                  (if (if (pair? v_55)
                                                                                        (if (let-values (((a_332)
                                                                                                          (car v_55)))
                                                                                              (equal?
                                                                                               'variable-reference-constant?
                                                                                               a_332))
                                                                                          (let-values (((d_330)
                                                                                                        (cdr v_55)))
                                                                                            (if (pair? d_330)
                                                                                              (if (let-values (((a_333)
                                                                                                                (car
                                                                                                                 d_330)))
                                                                                                    (if (pair? a_333)
                                                                                                      (if (let-values (((a_334)
                                                                                                                        (car
                                                                                                                         a_333)))
                                                                                                            (equal?
                                                                                                             '#%variable-reference
                                                                                                             a_334))
                                                                                                        (let-values (((d_331)
                                                                                                                      (cdr
                                                                                                                       a_333)))
                                                                                                          (if (pair?
                                                                                                               d_331)
                                                                                                            (if (let-values (((a_335)
                                                                                                                              (car
                                                                                                                               d_331)))
                                                                                                                  #t)
                                                                                                              (let-values (((d_332)
                                                                                                                            (cdr
                                                                                                                             d_331)))
                                                                                                                (equal?
                                                                                                                 '()
                                                                                                                 d_332))
                                                                                                              #f)
                                                                                                            #f))
                                                                                                        #f)
                                                                                                      #f))
                                                                                                (let-values (((d_333)
                                                                                                              (cdr
                                                                                                               d_330)))
                                                                                                  (equal? '() d_333))
                                                                                                #f)
                                                                                              #f))
                                                                                          #f)
                                                                                        #f)
                                                                                    (let-values (((id_32)
                                                                                                  (let-values (((d_334)
                                                                                                                (cdr
                                                                                                                 v_55)))
                                                                                                    (let-values (((a_336)
                                                                                                                  (car
                                                                                                                   d_334)))
                                                                                                      (let-values (((d_335)
                                                                                                                    (cdr
                                                                                                                     a_336)))
                                                                                                        (let-values (((a_337)
                                                                                                                      (car
                                                                                                                       d_335)))
                                                                                                          a_337))))))
                                                                                      (if (not
                                                                                           (hash-ref
                                                                                            mutated_7
                                                                                            id_32
                                                                                            #f))
                                                                                        (let-values (((im_4)
                                                                                                      (hash-ref
                                                                                                       imports_17
                                                                                                       id_32
                                                                                                       #f)))
                                                                                          (let-values (((or-part_11)
                                                                                                        (not im_4)))
                                                                                            (if or-part_11
                                                                                              or-part_11
                                                                                              (known-constant?
                                                                                               (import-lookup im_4)))))
                                                                                        #f))
                                                                                    (if (if (pair? v_55)
                                                                                          (if (let-values (((a_338)
                                                                                                            (car v_55)))
                                                                                                (equal?
                                                                                                 '#%variable-reference
                                                                                                 a_338))
                                                                                            (let-values (((d_336)
                                                                                                          (cdr v_55)))
                                                                                              (equal? '() d_336))
                                                                                            #f)
                                                                                          #f)
                                                                                      (let-values ()
                                                                                        'instance-variable-reference)
                                                                                      (if (if (pair? v_55)
                                                                                            (if (let-values (((a_339)
                                                                                                              (car
                                                                                                               v_55)))
                                                                                                  (equal?
                                                                                                   '#%variable-reference
                                                                                                   a_339))
                                                                                              (let-values (((d_337)
                                                                                                            (cdr v_55)))
                                                                                                (if (pair? d_337)
                                                                                                  (if (let-values (((a_340)
                                                                                                                    (car
                                                                                                                     d_337)))
                                                                                                        #t)
                                                                                                    (let-values (((d_338)
                                                                                                                  (cdr
                                                                                                                   d_337)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_338))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f)
                                                                                        (let-values (((id_33)
                                                                                                      (let-values (((d_339)
                                                                                                                    (cdr
                                                                                                                     v_55)))
                                                                                                        (let-values (((a_341)
                                                                                                                      (car
                                                                                                                       d_339)))
                                                                                                          a_341))))
                                                                                          (let-values (((e_2)
                                                                                                        (hash-ref
                                                                                                         exports_9
                                                                                                         id_33
                                                                                                         #f)))
                                                                                            (if e_2
                                                                                              (list
                                                                                               'make-instance-variable-reference
                                                                                               'instance-variable-reference
                                                                                               e_2)
                                                                                              (list
                                                                                               'make-instance-variable-reference
                                                                                               'instance-variable-reference
                                                                                               (if (hash-ref
                                                                                                    mutated_7
                                                                                                    v_54
                                                                                                    #f)
                                                                                                 'mutable
                                                                                                 'immutable)))))
                                                                                        (if (if (pair? v_55)
                                                                                              (if (let-values (((a_342)
                                                                                                                (car
                                                                                                                 v_55)))
                                                                                                    #t)
                                                                                                (let-values (((d_340)
                                                                                                              (cdr
                                                                                                               v_55)))
                                                                                                  (list? d_340))
                                                                                                #f)
                                                                                              #f)
                                                                                          (let-values (((rator_2 exps_7)
                                                                                                        (let-values (((rator_3)
                                                                                                                      (let-values (((a_343)
                                                                                                                                    (car
                                                                                                                                     v_55)))
                                                                                                                        a_343))
                                                                                                                     ((exps_8)
                                                                                                                      (let-values (((d_341)
                                                                                                                                    (cdr
                                                                                                                                     v_55)))
                                                                                                                        d_341)))
                                                                                                          (values
                                                                                                           rator_3
                                                                                                           exps_8))))
                                                                                            (let-values (((args_4)
                                                                                                          (map2
                                                                                                           schemify_0
                                                                                                           exps_7)))
                                                                                              (left-to-right/app
                                                                                               (if (let-values (((or-part_12)
                                                                                                                 (known-procedure?
                                                                                                                  (hash-ref-either
                                                                                                                   knowns_26
                                                                                                                   imports_17
                                                                                                                   rator_2))))
                                                                                                     (if or-part_12
                                                                                                       or-part_12
                                                                                                       (let-values (((or-part_13)
                                                                                                                     (known-procedure?
                                                                                                                      (hash-ref
                                                                                                                       prim-knowns_6
                                                                                                                       rator_2
                                                                                                                       #f))))
                                                                                                         (if or-part_13
                                                                                                           or-part_13
                                                                                                           (lambda?
                                                                                                            rator_2)))))
                                                                                                 (list*
                                                                                                  (schemify_0 rator_2)
                                                                                                  args_4)
                                                                                                 (list*
                                                                                                  '#%app
                                                                                                  (schemify_0 rator_2)
                                                                                                  args_4))
                                                                                               prim-knowns_6
                                                                                               knowns_26
                                                                                               imports_17
                                                                                               mutated_7)))
                                                                                          (let-values ()
                                                                                            (let-values (((c1_0)
                                                                                                          (if (symbol?
                                                                                                               v_54)
                                                                                                            (if (hash-ref
                                                                                                                 mutated_7
                                                                                                                 v_54
                                                                                                                 #f)
                                                                                                              (hash-ref
                                                                                                               exports_9
                                                                                                               v_54
                                                                                                               #f)
                                                                                                              #f)
                                                                                                            #f)))
                                                                                              (if c1_0
                                                                                                ((lambda (ex-id_1)
                                                                                                   (list
                                                                                                    'variable-ref
                                                                                                    ex-id_1))
                                                                                                 c1_0)
                                                                                                (let-values (((c2_0)
                                                                                                              (if (symbol?
                                                                                                                   v_54)
                                                                                                                (hash-ref
                                                                                                                 imports_17
                                                                                                                 v_54
                                                                                                                 #f)
                                                                                                                #f)))
                                                                                                  (if c2_0
                                                                                                    ((lambda (im_5)
                                                                                                       (if (known-constant?
                                                                                                            (import-lookup
                                                                                                             im_5))
                                                                                                         (import-id
                                                                                                          im_5)
                                                                                                         (list
                                                                                                          'variable-ref
                                                                                                          (import-id
                                                                                                           im_5))))
                                                                                                     c2_0)
                                                                                                    (let-values ()
                                                                                                      v_54))))))))))))))))))))))))))))))))
                           schemify_0)
                         v_53))))
       schemify/knowns_0)
     knowns_25
     v_52))))
