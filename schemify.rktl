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
  (known-struct-type-property/immediate-guard known-struct-type-property/immediate-guard)
  (known-predicate? known-predicate?)
  (known-accessor known-accessor)
  (known-constructor known-constructor)
  (known-accessor-type known-accessor-type)
  (known-struct-type? known-struct-type?)
  (known-constructor-field-count known-constructor-field-count)
  (a-known-constant a-known-constant)
  (a-known-procedure a-known-procedure)
  (known-struct-type-property/immediate-guard? known-struct-type-property/immediate-guard?)
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
  (a-known-struct-type-property/immediate-guard a-known-struct-type-property/immediate-guard)
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
 (define-values (no-empty-edge-table) (make-hash))
 (define-values (kernel-table) (primitive-table '#%kernel))
 (define-values
  (correlated?)
  (let-values (((or-part_0) (if kernel-table (hash-ref kernel-table 'syntax?) #f)))
    (if or-part_0 or-part_0 (lambda (x_0) #f))))
 (define-values
  (correlated-e)
  (let-values (((or-part_1) (if kernel-table (hash-ref kernel-table 'syntax-e) #f)))
    (if or-part_1 or-part_1 (lambda (x_1) x_1))))
 (define-values (unwrap) (lambda (v_14) (if (correlated? v_14) (correlated-e v_14) v_14)))
 (define-values
  (unwrap-list)
  (lambda (v_15)
    (if (null? v_15)
      (let-values () null)
      (if (pair? v_15)
        (let-values ()
          (let-values (((r_1) (unwrap-list (cdr v_15)))) (if (eq? r_1 (cdr v_15)) v_15 (cons (car v_15) r_1))))
        (if (correlated? v_15) (let-values () (unwrap-list (correlated-e v_15))) (let-values () v_15))))))
 (define-values (wrap-car) (lambda (v_16) (if (correlated? v_16) (car (correlated-e v_16)) (car v_16))))
 (define-values (wrap-cdr) (lambda (v_17) (if (correlated? v_17) (cdr (correlated-e v_17)) (cdr v_17))))
 (define-values (wrap-pair?) (lambda (v_18) (pair? (unwrap v_18))))
 (define-values (wrap-null?) (lambda (v_19) (null? (unwrap v_19))))
 (define-values
  (wrap-list?)
  (lambda (v_20)
    (if (null? v_20)
      (let-values () #t)
      (if (correlated? v_20)
        (let-values () (wrap-list? (correlated-e v_20)))
        (if (pair? v_20) (let-values () (wrap-list? (cdr v_20))) (let-values () #f))))))
 (define-values (wrap-eq?) (lambda (a_3 b_2) (eq? (unwrap a_3) (unwrap b_2))))
 (define-values
  (wrap-equal?)
  (lambda (a_4 b_3)
    (let-values (((b_4) (unwrap b_3)))
      (let-values (((or-part_2) (if (not (pair? a_4)) (equal? a_4 b_4) #f)))
        (if or-part_2
          or-part_2
          (if (pair? a_4)
            (if (pair? b_4) (if (wrap-equal? (car a_4) (car b_4)) (wrap-equal? (car a_4) (car b_4)) #f) #f)
            #f))))))
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
 (define-values
  (struct:known-struct-type-property/immediate-guard
   known-struct-type-property/immediate-guard
   known-struct-type-property/immediate-guard?)
  (let-values (((struct:_8 make-_8 ?_8 -ref_8 -set!_8)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-struct-type-property/immediate-guard
                     #f
                     0
                     0
                     #f
                     null
                     'prefab
                     #f
                     '()
                     #f
                     'known-struct-type-property/immediate-guard)))))
    (values struct:_8 make-_8 ?_8)))
 (define-values (a-known-constant) (known-constant))
 (define-values (a-known-unknown) (known-unknown))
 (define-values (a-known-procedure) (known-procedure))
 (define-values (a-known-struct-type-property/immediate-guard) (known-struct-type-property/immediate-guard))
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
  (let-values (((struct:_9 make-_9 ?_9 -ref_9 -set!_9)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'import-group #f 1 0 #f null (current-inspector) #f '() #f 'import-group)))))
    (values
     struct:_9
     make-_9
     ?_9
     (make-struct-field-accessor -ref_9 0 'knowns/thunk)
     (make-struct-field-mutator -set!_9 0 'knowns/thunk))))
 (define-values
  (import-group-knowns)
  (lambda (grp_0)
    (let-values (((knowns/thunk_0) (import-group-knowns/thunk grp_0)))
      (if (procedure? knowns/thunk_0)
        (let-values ()
          (let-values (((knowns_0) (let-values (((or-part_3) (knowns/thunk_0))) (if or-part_3 or-part_3 (hasheq)))))
            (begin (set-import-group-knowns/thunk! grp_0 knowns_0) knowns_0)))
        (let-values () knowns/thunk_0)))))
 (define-values
  (import-lookup)
  (lambda (im_0) (hash-ref (import-group-knowns (import-grp im_0)) (import-ext-id im_0) #f)))
 (define-values
  (hash-ref-either)
  (lambda (knowns_1 imports_0 key_0)
    (let-values (((or-part_4) (hash-ref knowns_1 key_0 #f)))
      (if or-part_4
        or-part_4
        (let-values (((im_1) (hash-ref imports_0 key_0 #f))) (if im_1 (import-lookup im_1) #f))))))
 (define-values (delayed-mutated-state?) (lambda (v_21) (procedure? v_21)))
 (define-values
  (simple-mutated-state?)
  (lambda (v_22) (let-values (((or-part_5) (not v_22))) (if or-part_5 or-part_5 (delayed-mutated-state? v_22)))))
 (define-values (not-ready-mutated-state?) (lambda (v_23) (eq? v_23 'not-ready)))
 (define-values
  (via-variable-mutated-state?)
  (lambda (v_24) (let-values (((or-part_6) (eq? v_24 'set!ed))) (if or-part_6 or-part_6 (eq? v_24 'undefined)))))
 (define-values (set!ed-mutated-state?) (lambda (v_25) (eq? v_25 'set!ed)))
 (define-values
  (simple?)
  (lambda (e_0 prim-knowns_0 knowns_2 imports_1 mutated_0)
    ((letrec-values (((simple?_0)
                      (lambda (e_1)
                        (let-values (((v_26) e_1))
                          (if (let-values (((p_0) (unwrap v_26)))
                                (if (pair? p_0)
                                  (if (let-values (((a_5) (car p_0))) (wrap-equal? 'lambda a_5))
                                    (let-values (((d_0) (cdr p_0))) #t)
                                    #f)
                                  #f))
                            (let-values () #t)
                            (if (let-values (((p_1) (unwrap v_26)))
                                  (if (pair? p_1)
                                    (if (let-values (((a_6) (car p_1))) (wrap-equal? 'case-lambda a_6))
                                      (let-values (((d_1) (cdr p_1))) #t)
                                      #f)
                                    #f))
                              (let-values () #t)
                              (if (let-values (((p_2) (unwrap v_26)))
                                    (if (pair? p_2)
                                      (if (let-values (((a_7) (car p_2))) (wrap-equal? 'quote a_7))
                                        (let-values (((d_2) (cdr p_2))) #t)
                                        #f)
                                      #f))
                                (let-values () #t)
                                (if (let-values (((p_3) (unwrap v_26)))
                                      (if (pair? p_3)
                                        (if (let-values (((a_8) (car p_3))) (wrap-equal? '#%variable-reference a_8))
                                          (let-values (((d_3) (cdr p_3))) #t)
                                          #f)
                                        #f))
                                  (let-values () #t)
                                  (if (let-values (((p_4) (unwrap v_26)))
                                        (if (pair? p_4)
                                          (if (let-values (((a_9) (car p_4))) (wrap-equal? 'let-values a_9))
                                            (let-values (((d_4) (cdr p_4)))
                                              (let-values (((p_5) (unwrap d_4)))
                                                (if (pair? p_5)
                                                  (if (let-values (((a_3) (car p_5)))
                                                        (if (wrap-list? a_3)
                                                          (let-values (((lst_0) a_3))
                                                            (begin
                                                              (void)
                                                              ((letrec-values (((for-loop_0)
                                                                                (lambda (result_0 lst_1)
                                                                                  (if (not (wrap-null? lst_1))
                                                                                    (let-values (((v_27)
                                                                                                  (if (wrap-pair? lst_1)
                                                                                                    (wrap-car lst_1)
                                                                                                    lst_1))
                                                                                                 ((rest_0)
                                                                                                  (if (wrap-pair? lst_1)
                                                                                                    (wrap-cdr lst_1)
                                                                                                    null)))
                                                                                      (let-values (((result_1)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_2)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (let-values (((p_6)
                                                                                                                                      (unwrap
                                                                                                                                       v_27)))
                                                                                                                          (if (pair?
                                                                                                                               p_6)
                                                                                                                            (if (let-values (((a_10)
                                                                                                                                              (car
                                                                                                                                               p_6)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_5)
                                                                                                                                            (cdr
                                                                                                                                             p_6)))
                                                                                                                                (let-values (((p_7)
                                                                                                                                              (unwrap
                                                                                                                                               d_5)))
                                                                                                                                  (if (pair?
                                                                                                                                       p_7)
                                                                                                                                    (if (let-values (((a_11)
                                                                                                                                                      (car
                                                                                                                                                       p_7)))
                                                                                                                                          #t)
                                                                                                                                      (let-values (((d_6)
                                                                                                                                                    (cdr
                                                                                                                                                     p_7)))
                                                                                                                                        (wrap-equal?
                                                                                                                                         '()
                                                                                                                                         d_6))
                                                                                                                                      #f)
                                                                                                                                    #f)))
                                                                                                                              #f)
                                                                                                                            #f))))))
                                                                                                        (values
                                                                                                         result_2)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_2
                                                                                                    (not result_1))
                                                                                                  v_27))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_0 result_1 rest_0)
                                                                                          result_1)))
                                                                                    result_0))))
                                                                 for-loop_0)
                                                               #t
                                                               lst_0)))
                                                          #f))
                                                    (let-values (((d_7) (cdr p_5)))
                                                      (let-values (((p_8) (unwrap d_7)))
                                                        (if (pair? p_8)
                                                          (if (let-values (((a_12) (car p_8))) #t)
                                                            (let-values (((d_8) (cdr p_8))) (wrap-equal? '() d_8))
                                                            #f)
                                                          #f)))
                                                    #f)
                                                  #f)))
                                            #f)
                                          #f))
                                    (let-values (((rhss_0 body_0)
                                                  (let-values (((d_9) (cdr (unwrap v_26))))
                                                    (let-values (((p_9) (unwrap d_9)))
                                                      (let-values (((rhss_1)
                                                                    (let-values (((a_13) (car p_9)))
                                                                      (let-values (((rhss_2)
                                                                                    (let-values (((lst_2) a_13))
                                                                                      (begin
                                                                                        (void)
                                                                                        ((letrec-values (((for-loop_1)
                                                                                                          (lambda (rhss_3
                                                                                                                   lst_3)
                                                                                                            (if (not
                                                                                                                 (wrap-null?
                                                                                                                  lst_3))
                                                                                                              (let-values (((v_28)
                                                                                                                            (if (wrap-pair?
                                                                                                                                 lst_3)
                                                                                                                              (wrap-car
                                                                                                                               lst_3)
                                                                                                                              lst_3))
                                                                                                                           ((rest_1)
                                                                                                                            (if (wrap-pair?
                                                                                                                                 lst_3)
                                                                                                                              (wrap-cdr
                                                                                                                               lst_3)
                                                                                                                              null)))
                                                                                                                (let-values (((rhss_4)
                                                                                                                              (let-values (((rhss_5)
                                                                                                                                            rhss_3))
                                                                                                                                (let-values (((rhss_6)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((rhss1_0)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((d_10)
                                                                                                                                                                              (cdr
                                                                                                                                                                               (unwrap
                                                                                                                                                                                v_28))))
                                                                                                                                                                  (let-values (((a_14)
                                                                                                                                                                                (car
                                                                                                                                                                                 (unwrap
                                                                                                                                                                                  d_10))))
                                                                                                                                                                    a_14)))))
                                                                                                                                                  (cons
                                                                                                                                                   rhss1_0
                                                                                                                                                   rhss_5)))))
                                                                                                                                  (values
                                                                                                                                   rhss_6)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_1
                                                                                                                     rhss_4
                                                                                                                     rest_1)
                                                                                                                    rhss_4)))
                                                                                                              rhss_3))))
                                                                                           for-loop_1)
                                                                                         null
                                                                                         lst_2)))))
                                                                        (reverse$1 rhss_2))))
                                                                   ((body_1)
                                                                    (let-values (((d_11) (cdr p_9)))
                                                                      (let-values (((a_15) (car (unwrap d_11))))
                                                                        a_15))))
                                                        (values rhss_1 body_1))))))
                                      (if (let-values (((lst_4) rhss_0))
                                            (begin
                                              (check-list lst_4)
                                              ((letrec-values (((for-loop_2)
                                                                (lambda (result_3 lst_5)
                                                                  (if (pair? lst_5)
                                                                    (let-values (((rhs_0) (unsafe-car lst_5))
                                                                                 ((rest_2) (unsafe-cdr lst_5)))
                                                                      (let-values (((result_4)
                                                                                    (let-values ()
                                                                                      (let-values (((result_5)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (simple?_0
                                                                                                         rhs_0)))))
                                                                                        (values result_5)))))
                                                                        (if (if (not
                                                                                 ((lambda x_3 (not result_4)) rhs_0))
                                                                              (not #f)
                                                                              #f)
                                                                          (for-loop_2 result_4 rest_2)
                                                                          result_4)))
                                                                    result_3))))
                                                 for-loop_2)
                                               #t
                                               lst_4)))
                                        (simple?_0 body_0)
                                        #f))
                                    (if (let-values (((p_10) (unwrap v_26)))
                                          (if (pair? p_10)
                                            (if (let-values (((a_16) (car p_10))) (wrap-equal? 'let a_16))
                                              (let-values (((d_12) (cdr p_10)))
                                                (let-values (((p_11) (unwrap d_12)))
                                                  (if (pair? p_11)
                                                    (if (let-values (((a_17) (car p_11)))
                                                          (if (wrap-list? a_17)
                                                            (let-values (((lst_6) a_17))
                                                              (begin
                                                                (void)
                                                                ((letrec-values (((for-loop_3)
                                                                                  (lambda (result_6 lst_7)
                                                                                    (if (not (wrap-null? lst_7))
                                                                                      (let-values (((v_29)
                                                                                                    (if (wrap-pair?
                                                                                                         lst_7)
                                                                                                      (wrap-car lst_7)
                                                                                                      lst_7))
                                                                                                   ((rest_3)
                                                                                                    (if (wrap-pair?
                                                                                                         lst_7)
                                                                                                      (wrap-cdr lst_7)
                                                                                                      null)))
                                                                                        (let-values (((result_7)
                                                                                                      (let-values ()
                                                                                                        (let-values (((result_8)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (let-values (((p_12)
                                                                                                                                        (unwrap
                                                                                                                                         v_29)))
                                                                                                                            (if (pair?
                                                                                                                                 p_12)
                                                                                                                              (if (let-values (((a_18)
                                                                                                                                                (car
                                                                                                                                                 p_12)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_13)
                                                                                                                                              (cdr
                                                                                                                                               p_12)))
                                                                                                                                  (let-values (((p_13)
                                                                                                                                                (unwrap
                                                                                                                                                 d_13)))
                                                                                                                                    (if (pair?
                                                                                                                                         p_13)
                                                                                                                                      (if (let-values (((a_19)
                                                                                                                                                        (car
                                                                                                                                                         p_13)))
                                                                                                                                            #t)
                                                                                                                                        (let-values (((d_14)
                                                                                                                                                      (cdr
                                                                                                                                                       p_13)))
                                                                                                                                          (wrap-equal?
                                                                                                                                           '()
                                                                                                                                           d_14))
                                                                                                                                        #f)
                                                                                                                                      #f)))
                                                                                                                                #f)
                                                                                                                              #f))))))
                                                                                                          (values
                                                                                                           result_8)))))
                                                                                          (if (if (not
                                                                                                   ((lambda x_4
                                                                                                      (not result_7))
                                                                                                    v_29))
                                                                                                (not #f)
                                                                                                #f)
                                                                                            (for-loop_3 result_7 rest_3)
                                                                                            result_7)))
                                                                                      result_6))))
                                                                   for-loop_3)
                                                                 #t
                                                                 lst_6)))
                                                            #f))
                                                      (let-values (((d_15) (cdr p_11)))
                                                        (let-values (((p_14) (unwrap d_15)))
                                                          (if (pair? p_14)
                                                            (if (let-values (((a_20) (car p_14))) #t)
                                                              (let-values (((d_16) (cdr p_14))) (wrap-equal? '() d_16))
                                                              #f)
                                                            #f)))
                                                      #f)
                                                    #f)))
                                              #f)
                                            #f))
                                      (let-values (((rhss_7 body_2)
                                                    (let-values (((d_17) (cdr (unwrap v_26))))
                                                      (let-values (((p_15) (unwrap d_17)))
                                                        (let-values (((rhss_8)
                                                                      (let-values (((a_21) (car p_15)))
                                                                        (let-values (((rhss_9)
                                                                                      (let-values (((lst_8) a_21))
                                                                                        (begin
                                                                                          (void)
                                                                                          ((letrec-values (((for-loop_4)
                                                                                                            (lambda (rhss_10
                                                                                                                     lst_9)
                                                                                                              (if (not
                                                                                                                   (wrap-null?
                                                                                                                    lst_9))
                                                                                                                (let-values (((v_30)
                                                                                                                              (if (wrap-pair?
                                                                                                                                   lst_9)
                                                                                                                                (wrap-car
                                                                                                                                 lst_9)
                                                                                                                                lst_9))
                                                                                                                             ((rest_4)
                                                                                                                              (if (wrap-pair?
                                                                                                                                   lst_9)
                                                                                                                                (wrap-cdr
                                                                                                                                 lst_9)
                                                                                                                                null)))
                                                                                                                  (let-values (((rhss_11)
                                                                                                                                (let-values (((rhss_12)
                                                                                                                                              rhss_10))
                                                                                                                                  (let-values (((rhss_13)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values (((rhss2_0)
                                                                                                                                                                (let-values ()
                                                                                                                                                                  (let-values (((d_18)
                                                                                                                                                                                (cdr
                                                                                                                                                                                 (unwrap
                                                                                                                                                                                  v_30))))
                                                                                                                                                                    (let-values (((a_22)
                                                                                                                                                                                  (car
                                                                                                                                                                                   (unwrap
                                                                                                                                                                                    d_18))))
                                                                                                                                                                      a_22)))))
                                                                                                                                                    (cons
                                                                                                                                                     rhss2_0
                                                                                                                                                     rhss_12)))))
                                                                                                                                    (values
                                                                                                                                     rhss_13)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_4
                                                                                                                       rhss_11
                                                                                                                       rest_4)
                                                                                                                      rhss_11)))
                                                                                                                rhss_10))))
                                                                                             for-loop_4)
                                                                                           null
                                                                                           lst_8)))))
                                                                          (reverse$1 rhss_9))))
                                                                     ((body_3)
                                                                      (let-values (((d_19) (cdr p_15)))
                                                                        (let-values (((a_23) (car (unwrap d_19))))
                                                                          a_23))))
                                                          (values rhss_8 body_3))))))
                                        (if (let-values (((lst_10) rhss_7))
                                              (begin
                                                (check-list lst_10)
                                                ((letrec-values (((for-loop_5)
                                                                  (lambda (result_9 lst_11)
                                                                    (if (pair? lst_11)
                                                                      (let-values (((rhs_1) (unsafe-car lst_11))
                                                                                   ((rest_5) (unsafe-cdr lst_11)))
                                                                        (let-values (((result_10)
                                                                                      (let-values ()
                                                                                        (let-values (((result_11)
                                                                                                      (let-values ()
                                                                                                        (let-values ()
                                                                                                          (simple?_0
                                                                                                           rhs_1)))))
                                                                                          (values result_11)))))
                                                                          (if (if (not
                                                                                   ((lambda x_5 (not result_10)) rhs_1))
                                                                                (not #f)
                                                                                #f)
                                                                            (for-loop_5 result_10 rest_5)
                                                                            result_10)))
                                                                      result_9))))
                                                   for-loop_5)
                                                 #t
                                                 lst_10)))
                                          (simple?_0 body_2)
                                          #f))
                                      (if (let-values (((p_16) (unwrap v_26)))
                                            (if (pair? p_16)
                                              (if (let-values (((a_24) (car p_16))) (wrap-equal? 'letrec-values a_24))
                                                (let-values (((d_20) (cdr p_16)))
                                                  (let-values (((p_17) (unwrap d_20)))
                                                    (if (pair? p_17)
                                                      (if (let-values (((a_25) (car p_17)))
                                                            (if (wrap-list? a_25)
                                                              (let-values (((lst_12) a_25))
                                                                (begin
                                                                  (void)
                                                                  ((letrec-values (((for-loop_6)
                                                                                    (lambda (result_12 lst_13)
                                                                                      (if (not (wrap-null? lst_13))
                                                                                        (let-values (((v_31)
                                                                                                      (if (wrap-pair?
                                                                                                           lst_13)
                                                                                                        (wrap-car
                                                                                                         lst_13)
                                                                                                        lst_13))
                                                                                                     ((rest_6)
                                                                                                      (if (wrap-pair?
                                                                                                           lst_13)
                                                                                                        (wrap-cdr
                                                                                                         lst_13)
                                                                                                        null)))
                                                                                          (let-values (((result_13)
                                                                                                        (let-values ()
                                                                                                          (let-values (((result_14)
                                                                                                                        (let-values ()
                                                                                                                          (let-values ()
                                                                                                                            (let-values (((p_18)
                                                                                                                                          (unwrap
                                                                                                                                           v_31)))
                                                                                                                              (if (pair?
                                                                                                                                   p_18)
                                                                                                                                (if (let-values (((a_26)
                                                                                                                                                  (car
                                                                                                                                                   p_18)))
                                                                                                                                      (wrap-list?
                                                                                                                                       a_26))
                                                                                                                                  (let-values (((d_21)
                                                                                                                                                (cdr
                                                                                                                                                 p_18)))
                                                                                                                                    (let-values (((p_19)
                                                                                                                                                  (unwrap
                                                                                                                                                   d_21)))
                                                                                                                                      (if (pair?
                                                                                                                                           p_19)
                                                                                                                                        (if (let-values (((a_27)
                                                                                                                                                          (car
                                                                                                                                                           p_19)))
                                                                                                                                              #t)
                                                                                                                                          (let-values (((d_22)
                                                                                                                                                        (cdr
                                                                                                                                                         p_19)))
                                                                                                                                            (wrap-equal?
                                                                                                                                             '()
                                                                                                                                             d_22))
                                                                                                                                          #f)
                                                                                                                                        #f)))
                                                                                                                                  #f)
                                                                                                                                #f))))))
                                                                                                            (values
                                                                                                             result_14)))))
                                                                                            (if (if (not
                                                                                                     ((lambda x_6
                                                                                                        (not result_13))
                                                                                                      v_31))
                                                                                                  (not #f)
                                                                                                  #f)
                                                                                              (for-loop_6
                                                                                               result_13
                                                                                               rest_6)
                                                                                              result_13)))
                                                                                        result_12))))
                                                                     for-loop_6)
                                                                   #t
                                                                   lst_12)))
                                                              #f))
                                                        (let-values (((d_23) (cdr p_17)))
                                                          (let-values (((p_20) (unwrap d_23)))
                                                            (if (pair? p_20)
                                                              (if (let-values (((a_28) (car p_20))) #t)
                                                                (let-values (((d_24) (cdr p_20)))
                                                                  (wrap-equal? '() d_24))
                                                                #f)
                                                              #f)))
                                                        #f)
                                                      #f)))
                                                #f)
                                              #f))
                                        (let-values (((idss_0 rhss_14 body_4)
                                                      (let-values (((d_25) (cdr (unwrap v_26))))
                                                        (let-values (((p_21) (unwrap d_25)))
                                                          (let-values (((idss_1 rhss_15)
                                                                        (let-values (((a_29) (car p_21)))
                                                                          (let-values (((idss_2 rhss_16)
                                                                                        (let-values (((lst_14) a_29))
                                                                                          (begin
                                                                                            (void)
                                                                                            ((letrec-values (((for-loop_7)
                                                                                                              (lambda (idss_3
                                                                                                                       rhss_17
                                                                                                                       lst_15)
                                                                                                                (if (not
                                                                                                                     (wrap-null?
                                                                                                                      lst_15))
                                                                                                                  (let-values (((v_32)
                                                                                                                                (if (wrap-pair?
                                                                                                                                     lst_15)
                                                                                                                                  (wrap-car
                                                                                                                                   lst_15)
                                                                                                                                  lst_15))
                                                                                                                               ((rest_7)
                                                                                                                                (if (wrap-pair?
                                                                                                                                     lst_15)
                                                                                                                                  (wrap-cdr
                                                                                                                                   lst_15)
                                                                                                                                  null)))
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
                                                                                                                                                                    (let-values (((p_22)
                                                                                                                                                                                  (unwrap
                                                                                                                                                                                   v_32)))
                                                                                                                                                                      (let-values (((idss_7)
                                                                                                                                                                                    (let-values (((a_30)
                                                                                                                                                                                                  (car
                                                                                                                                                                                                   p_22)))
                                                                                                                                                                                      (unwrap-list
                                                                                                                                                                                       a_30)))
                                                                                                                                                                                   ((rhss_21)
                                                                                                                                                                                    (let-values (((d_26)
                                                                                                                                                                                                  (cdr
                                                                                                                                                                                                   p_22)))
                                                                                                                                                                                      (let-values (((a_31)
                                                                                                                                                                                                    (car
                                                                                                                                                                                                     (unwrap
                                                                                                                                                                                                      d_26))))
                                                                                                                                                                                        a_31))))
                                                                                                                                                                        (values
                                                                                                                                                                         idss_7
                                                                                                                                                                         rhss_21))))))
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
                                                                                                                         rest_7)
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
                                                                       ((body_5)
                                                                        (let-values (((d_27) (cdr p_21)))
                                                                          (let-values (((a_32) (car (unwrap d_27))))
                                                                            a_32))))
                                                            (values idss_1 rhss_15 body_5))))))
                                          (if (let-values (((lst_16) rhss_14))
                                                (begin
                                                  (check-list lst_16)
                                                  ((letrec-values (((for-loop_8)
                                                                    (lambda (result_15 lst_17)
                                                                      (if (pair? lst_17)
                                                                        (let-values (((rhs_2) (unsafe-car lst_17))
                                                                                     ((rest_8) (unsafe-cdr lst_17)))
                                                                          (let-values (((result_16)
                                                                                        (let-values ()
                                                                                          (let-values (((result_17)
                                                                                                        (let-values ()
                                                                                                          (let-values ()
                                                                                                            (simple?_0
                                                                                                             rhs_2)))))
                                                                                            (values result_17)))))
                                                                            (if (if (not
                                                                                     ((lambda x_7 (not result_16))
                                                                                      rhs_2))
                                                                                  (not #f)
                                                                                  #f)
                                                                              (for-loop_8 result_16 rest_8)
                                                                              result_16)))
                                                                        result_15))))
                                                     for-loop_8)
                                                   #t
                                                   lst_16)))
                                            (simple?_0 body_4)
                                            #f))
                                        (if (let-values (((p_23) (unwrap v_26)))
                                              (if (pair? p_23)
                                                (if (let-values (((a_33) (car p_23))) (wrap-equal? 'letrec* a_33))
                                                  (let-values (((d_28) (cdr p_23)))
                                                    (let-values (((p_24) (unwrap d_28)))
                                                      (if (pair? p_24)
                                                        (if (let-values (((a_34) (car p_24)))
                                                              (if (wrap-list? a_34)
                                                                (let-values (((lst_18) a_34))
                                                                  (begin
                                                                    (void)
                                                                    ((letrec-values (((for-loop_9)
                                                                                      (lambda (result_18 lst_19)
                                                                                        (if (not (wrap-null? lst_19))
                                                                                          (let-values (((v_33)
                                                                                                        (if (wrap-pair?
                                                                                                             lst_19)
                                                                                                          (wrap-car
                                                                                                           lst_19)
                                                                                                          lst_19))
                                                                                                       ((rest_9)
                                                                                                        (if (wrap-pair?
                                                                                                             lst_19)
                                                                                                          (wrap-cdr
                                                                                                           lst_19)
                                                                                                          null)))
                                                                                            (let-values (((result_19)
                                                                                                          (let-values ()
                                                                                                            (let-values (((result_20)
                                                                                                                          (let-values ()
                                                                                                                            (let-values ()
                                                                                                                              (let-values (((p_25)
                                                                                                                                            (unwrap
                                                                                                                                             v_33)))
                                                                                                                                (if (pair?
                                                                                                                                     p_25)
                                                                                                                                  (if (let-values (((a_35)
                                                                                                                                                    (car
                                                                                                                                                     p_25)))
                                                                                                                                        #t)
                                                                                                                                    (let-values (((d_29)
                                                                                                                                                  (cdr
                                                                                                                                                   p_25)))
                                                                                                                                      (let-values (((p_26)
                                                                                                                                                    (unwrap
                                                                                                                                                     d_29)))
                                                                                                                                        (if (pair?
                                                                                                                                             p_26)
                                                                                                                                          (if (let-values (((a_36)
                                                                                                                                                            (car
                                                                                                                                                             p_26)))
                                                                                                                                                #t)
                                                                                                                                            (let-values (((d_30)
                                                                                                                                                          (cdr
                                                                                                                                                           p_26)))
                                                                                                                                              (wrap-equal?
                                                                                                                                               '()
                                                                                                                                               d_30))
                                                                                                                                            #f)
                                                                                                                                          #f)))
                                                                                                                                    #f)
                                                                                                                                  #f))))))
                                                                                                              (values
                                                                                                               result_20)))))
                                                                                              (if (if (not
                                                                                                       ((lambda x_8
                                                                                                          (not
                                                                                                           result_19))
                                                                                                        v_33))
                                                                                                    (not #f)
                                                                                                    #f)
                                                                                                (for-loop_9
                                                                                                 result_19
                                                                                                 rest_9)
                                                                                                result_19)))
                                                                                          result_18))))
                                                                       for-loop_9)
                                                                     #t
                                                                     lst_18)))
                                                                #f))
                                                          (let-values (((d_31) (cdr p_24)))
                                                            (let-values (((p_27) (unwrap d_31)))
                                                              (if (pair? p_27)
                                                                (if (let-values (((a_37) (car p_27))) #t)
                                                                  (let-values (((d_32) (cdr p_27)))
                                                                    (wrap-equal? '() d_32))
                                                                  #f)
                                                                #f)))
                                                          #f)
                                                        #f)))
                                                  #f)
                                                #f))
                                          (let-values (((ids_0 rhss_22 body_6)
                                                        (let-values (((d_33) (cdr (unwrap v_26))))
                                                          (let-values (((p_28) (unwrap d_33)))
                                                            (let-values (((ids_1 rhss_23)
                                                                          (let-values (((a_38) (car p_28)))
                                                                            (let-values (((ids_2 rhss_24)
                                                                                          (let-values (((lst_20) a_38))
                                                                                            (begin
                                                                                              (void)
                                                                                              ((letrec-values (((for-loop_10)
                                                                                                                (lambda (ids_3
                                                                                                                         rhss_25
                                                                                                                         lst_21)
                                                                                                                  (if (not
                                                                                                                       (wrap-null?
                                                                                                                        lst_21))
                                                                                                                    (let-values (((v_34)
                                                                                                                                  (if (wrap-pair?
                                                                                                                                       lst_21)
                                                                                                                                    (wrap-car
                                                                                                                                     lst_21)
                                                                                                                                    lst_21))
                                                                                                                                 ((rest_10)
                                                                                                                                  (if (wrap-pair?
                                                                                                                                       lst_21)
                                                                                                                                    (wrap-cdr
                                                                                                                                     lst_21)
                                                                                                                                    null)))
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
                                                                                                                                                                      (let-values (((p_29)
                                                                                                                                                                                    (unwrap
                                                                                                                                                                                     v_34)))
                                                                                                                                                                        (let-values (((ids_7)
                                                                                                                                                                                      (let-values (((a_39)
                                                                                                                                                                                                    (car
                                                                                                                                                                                                     p_29)))
                                                                                                                                                                                        a_39))
                                                                                                                                                                                     ((rhss_29)
                                                                                                                                                                                      (let-values (((d_34)
                                                                                                                                                                                                    (cdr
                                                                                                                                                                                                     p_29)))
                                                                                                                                                                                        (let-values (((a_40)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       (unwrap
                                                                                                                                                                                                        d_34))))
                                                                                                                                                                                          a_40))))
                                                                                                                                                                          (values
                                                                                                                                                                           ids_7
                                                                                                                                                                           rhss_29))))))
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
                                                                                                                           rest_10)
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
                                                                         ((body_7)
                                                                          (let-values (((d_35) (cdr p_28)))
                                                                            (let-values (((a_41) (car (unwrap d_35))))
                                                                              a_41))))
                                                              (values ids_1 rhss_23 body_7))))))
                                            (if (let-values (((lst_22) rhss_22))
                                                  (begin
                                                    (check-list lst_22)
                                                    ((letrec-values (((for-loop_11)
                                                                      (lambda (result_21 lst_23)
                                                                        (if (pair? lst_23)
                                                                          (let-values (((rhs_3) (unsafe-car lst_23))
                                                                                       ((rest_11) (unsafe-cdr lst_23)))
                                                                            (let-values (((result_22)
                                                                                          (let-values ()
                                                                                            (let-values (((result_23)
                                                                                                          (let-values ()
                                                                                                            (let-values ()
                                                                                                              (simple?_0
                                                                                                               rhs_3)))))
                                                                                              (values result_23)))))
                                                                              (if (if (not
                                                                                       ((lambda x_9 (not result_22))
                                                                                        rhs_3))
                                                                                    (not #f)
                                                                                    #f)
                                                                                (for-loop_11 result_22 rest_11)
                                                                                result_22)))
                                                                          result_21))))
                                                       for-loop_11)
                                                     #t
                                                     lst_22)))
                                              (simple?_0 body_6)
                                              #f))
                                          (if (let-values (((p_30) (unwrap v_26)))
                                                (if (pair? p_30)
                                                  (if (let-values (((a_42) (car p_30))) #t)
                                                    (let-values (((d_36) (cdr p_30)))
                                                      (let-values (((p_31) (unwrap d_36)))
                                                        (if (pair? p_31)
                                                          (if (let-values (((a_43) (car p_31))) #t)
                                                            (let-values (((d_37) (cdr p_31))) (wrap-equal? '() d_37))
                                                            #f)
                                                          #f)))
                                                    #f)
                                                  #f))
                                            (let-values (((proc_0 arg_0)
                                                          (let-values (((p_32) (unwrap v_26)))
                                                            (let-values (((proc_1)
                                                                          (let-values (((a_44) (car p_32))) a_44))
                                                                         ((arg_1)
                                                                          (let-values (((d_38) (cdr p_32)))
                                                                            (let-values (((a_45) (car (unwrap d_38))))
                                                                              a_45))))
                                                              (values proc_1 arg_1)))))
                                              (let-values (((proc_2) (unwrap proc_0)))
                                                (if (symbol? proc_2)
                                                  (if (let-values (((v_35)
                                                                    (let-values (((or-part_7)
                                                                                  (hash-ref-either
                                                                                   knowns_2
                                                                                   imports_1
                                                                                   proc_2)))
                                                                      (if or-part_7
                                                                        or-part_7
                                                                        (hash-ref prim-knowns_0 proc_2 #f)))))
                                                        (if v_35
                                                          (if (not (hash-ref mutated_0 proc_2 #f))
                                                            (let-values (((or-part_8) (known-predicate? v_35)))
                                                              (if or-part_8
                                                                or-part_8
                                                                (if (known-constructor? v_35)
                                                                  (let-values (((c_0)
                                                                                (known-constructor-field-count v_35)))
                                                                    (let-values (((or-part_9) (eq? c_0 'any)))
                                                                      (if or-part_9 or-part_9 (= 1 c_0))))
                                                                  #f)))
                                                            #f)
                                                          #f))
                                                    (simple?_0 arg_0)
                                                    #f)
                                                  #f)))
                                            (if (let-values (((p_33) (unwrap v_26)))
                                                  (if (pair? p_33)
                                                    (if (let-values (((a_46) (car p_33))) #t)
                                                      (let-values (((d_39) (cdr p_33))) #t)
                                                      #f)
                                                    #f))
                                              (let-values (((proc_3 args_1)
                                                            (let-values (((p_34) (unwrap v_26)))
                                                              (let-values (((proc_4)
                                                                            (let-values (((a_47) (car p_34))) a_47))
                                                                           ((args_2)
                                                                            (let-values (((d_40) (cdr p_34))) d_40)))
                                                                (values proc_4 args_2)))))
                                                (let-values (((proc_5) (unwrap proc_3)))
                                                  (if (symbol? proc_5)
                                                    (if (let-values (((v_36)
                                                                      (let-values (((or-part_10)
                                                                                    (hash-ref-either
                                                                                     knowns_2
                                                                                     imports_1
                                                                                     proc_5)))
                                                                        (if or-part_10
                                                                          or-part_10
                                                                          (hash-ref prim-knowns_0 proc_5 #f)))))
                                                          (if (known-constructor? v_36)
                                                            (let-values (((c_1) (known-constructor-field-count v_36)))
                                                              (let-values (((or-part_11) (eq? c_1 'any)))
                                                                (if or-part_11 or-part_11 (= (length args_1) c_1))))
                                                            #f))
                                                      (if (simple-mutated-state? (hash-ref mutated_0 proc_5 #f))
                                                        (let-values (((lst_24) args_1))
                                                          (begin
                                                            (check-list lst_24)
                                                            ((letrec-values (((for-loop_12)
                                                                              (lambda (result_24 lst_25)
                                                                                (if (pair? lst_25)
                                                                                  (let-values (((arg_2)
                                                                                                (unsafe-car lst_25))
                                                                                               ((rest_12)
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
                                                                                               ((lambda x_10
                                                                                                  (not result_25))
                                                                                                arg_2))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_12 result_25 rest_12)
                                                                                        result_25)))
                                                                                  result_24))))
                                                               for-loop_12)
                                                             #t
                                                             lst_24)))
                                                        #f)
                                                      #f)
                                                    #f)))
                                              (let-values ()
                                                (let-values (((e_2) (unwrap e_1)))
                                                  (let-values (((or-part_12)
                                                                (if (symbol? e_2)
                                                                  (simple-mutated-state? (hash-ref mutated_0 e_2 #f))
                                                                  #f)))
                                                    (if or-part_12
                                                      or-part_12
                                                      (let-values (((or-part_13) (integer? e_2)))
                                                        (if or-part_13
                                                          or-part_13
                                                          (let-values (((or-part_14) (boolean? e_2)))
                                                            (if or-part_14
                                                              or-part_14
                                                              (let-values (((or-part_15) (string? e_2)))
                                                                (if or-part_15
                                                                  or-part_15
                                                                  (let-values (((or-part_16) (bytes? e_2)))
                                                                    (if or-part_16
                                                                      or-part_16
                                                                      (regexp? e_2)))))))))))))))))))))))))))
       simple?_0)
     e_0)))
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
 (define-values (struct-type-info-rest-properties-list-pos) 0)
 (define-values
  (make-struct-type-info)
  (lambda (v_37 prim-knowns_1 knowns_3 imports_2 mutated_1)
    (let-values (((v_38) v_37))
      (if (let-values (((p_35) (unwrap v_38)))
            (if (pair? p_35)
              (if (let-values (((a_48) (car p_35))) (wrap-equal? 'make-struct-type a_48))
                (let-values (((d_41) (cdr p_35)))
                  (let-values (((p_36) (unwrap d_41)))
                    (if (pair? p_36)
                      (if (let-values (((a_49) (car p_36)))
                            (let-values (((p_37) (unwrap a_49)))
                              (if (pair? p_37)
                                (if (let-values (((a_50) (car p_37))) (wrap-equal? 'quote a_50))
                                  (let-values (((d_42) (cdr p_37)))
                                    (let-values (((p_38) (unwrap d_42)))
                                      (if (pair? p_38)
                                        (if (let-values (((a_51) (car p_38))) #t)
                                          (let-values (((d_43) (cdr p_38))) (wrap-equal? '() d_43))
                                          #f)
                                        #f)))
                                  #f)
                                #f)))
                        (let-values (((d_44) (cdr p_36)))
                          (let-values (((p_39) (unwrap d_44)))
                            (if (pair? p_39)
                              (if (let-values (((a_14) (car p_39))) #t)
                                (let-values (((d_11) (cdr p_39)))
                                  (let-values (((p_40) (unwrap d_11)))
                                    (if (pair? p_40)
                                      (if (let-values (((a_52) (car p_40))) #t)
                                        (let-values (((d_45) (cdr p_40)))
                                          (let-values (((p_41) (unwrap d_45)))
                                            (if (pair? p_41)
                                              (if (let-values (((a_53) (car p_41))) (wrap-equal? 0 a_53))
                                                (let-values (((d_46) (cdr p_41)))
                                                  (let-values (((p_42) (unwrap d_46)))
                                                    (if (pair? p_42)
                                                      (if (let-values (((a_54) (car p_42))) (wrap-equal? #f a_54))
                                                        (let-values (((d_47) (cdr p_42))) #t)
                                                        #f)
                                                      #f)))
                                                #f)
                                              #f)))
                                        #f)
                                      #f)))
                                #f)
                              #f)))
                        #f)
                      #f)))
                #f)
              #f))
        (let-values (((name_1 parent_0 fields_0 rest_13)
                      (let-values (((d_12) (cdr (unwrap v_38))))
                        (let-values (((p_11) (unwrap d_12)))
                          (let-values (((name_2)
                                        (let-values (((a_55) (car p_11)))
                                          (let-values (((d_48) (cdr (unwrap a_55))))
                                            (let-values (((a_56) (car (unwrap d_48)))) a_56))))
                                       ((parent_1 fields_1 rest_14)
                                        (let-values (((d_49) (cdr p_11)))
                                          (let-values (((p_43) (unwrap d_49)))
                                            (let-values (((parent_2) (let-values (((a_57) (car p_43))) a_57))
                                                         ((fields_2 rest_15)
                                                          (let-values (((d_50) (cdr p_43)))
                                                            (let-values (((p_44) (unwrap d_50)))
                                                              (let-values (((fields_3)
                                                                            (let-values (((a_58) (car p_44))) a_58))
                                                                           ((rest_16)
                                                                            (let-values (((d_51) (cdr p_44)))
                                                                              (let-values (((d_52) (cdr (unwrap d_51))))
                                                                                (let-values (((d_16)
                                                                                              (cdr (unwrap d_52))))
                                                                                  d_16)))))
                                                                (values fields_3 rest_16))))))
                                              (values parent_2 fields_2 rest_15))))))
                            (values name_2 parent_1 fields_1 rest_14))))))
          (let-values (((u-name_0) (unwrap name_1)) ((u-parent_0) (unwrap parent_0)))
            (if (symbol? u-name_0)
              (if (let-values (((or-part_17) (not u-parent_0)))
                    (if or-part_17
                      or-part_17
                      (let-values (((or-part_18) (known-struct-type? (hash-ref prim-knowns_1 u-parent_0 #f))))
                        (if or-part_18
                          or-part_18
                          (if (known-struct-type? (hash-ref-either knowns_3 imports_2 u-parent_0))
                            (simple-mutated-state? (hash-ref mutated_1 u-parent_0 #f))
                            #f)))))
                (if (exact-nonnegative-integer? fields_0)
                  (struct-type-info1.1
                   name_1
                   parent_0
                   fields_0
                   (+
                    fields_0
                    (if parent_0 (known-struct-type-field-count (hash-ref-either knowns_3 imports_2 u-parent_0)) 0))
                   (let-values (((or-part_19) (< (length rest_13) 4)))
                     (if or-part_19 or-part_19 (not (list-ref rest_13 3))))
                   rest_13)
                  #f)
                #f)
              #f)))
        (if (let-values (((p_45) (unwrap v_38)))
              (if (pair? p_45)
                (if (let-values (((a_21) (car p_45))) (wrap-equal? 'let-values a_21))
                  (let-values (((d_53) (cdr p_45)))
                    (let-values (((p_46) (unwrap d_53)))
                      (if (pair? p_46)
                        (if (let-values (((a_59) (car p_46))) (wrap-equal? '() a_59))
                          (let-values (((d_54) (cdr p_46)))
                            (let-values (((p_47) (unwrap d_54)))
                              (if (pair? p_47)
                                (if (let-values (((a_60) (car p_47))) #t)
                                  (let-values (((d_55) (cdr p_47))) (wrap-equal? '() d_55))
                                  #f)
                                #f)))
                          #f)
                        #f)))
                  #f)
                #f))
          (let-values (((body_8)
                        (let-values (((d_56) (cdr (unwrap v_38))))
                          (let-values (((d_57) (cdr (unwrap d_56))))
                            (let-values (((a_61) (car (unwrap d_57)))) a_61)))))
            (make-struct-type-info body_8 prim-knowns_1 knowns_3 imports_2 mutated_1))
          (let-values () #f))))))
 (define-values
  (pure-properties-list?)
  (lambda (e_3 prim-knowns_2 knowns_4 imports_3 mutated_2)
    (let-values (((v_39) e_3))
      (if (let-values (((p_48) (unwrap v_39)))
            (if (pair? p_48)
              (if (let-values (((a_62) (car p_48))) (wrap-equal? 'list a_62))
                (let-values (((d_58) (cdr p_48)))
                  (if (wrap-list? d_58)
                    (let-values (((lst_26) d_58))
                      (begin
                        (void)
                        ((letrec-values (((for-loop_13)
                                          (lambda (result_27 lst_27)
                                            (if (not (wrap-null? lst_27))
                                              (let-values (((v_40) (if (wrap-pair? lst_27) (wrap-car lst_27) lst_27))
                                                           ((rest_17) (if (wrap-pair? lst_27) (wrap-cdr lst_27) null)))
                                                (let-values (((result_28)
                                                              (let-values ()
                                                                (let-values (((result_29)
                                                                              (let-values ()
                                                                                (let-values ()
                                                                                  (let-values (((p_49) (unwrap v_40)))
                                                                                    (if (pair? p_49)
                                                                                      (if (let-values (((a_63)
                                                                                                        (car p_49)))
                                                                                            (wrap-equal? 'cons a_63))
                                                                                        (let-values (((d_59)
                                                                                                      (cdr p_49)))
                                                                                          (let-values (((p_50)
                                                                                                        (unwrap d_59)))
                                                                                            (if (pair? p_50)
                                                                                              (if (let-values (((a_64)
                                                                                                                (car
                                                                                                                 p_50)))
                                                                                                    #t)
                                                                                                (let-values (((d_60)
                                                                                                              (cdr
                                                                                                               p_50)))
                                                                                                  (let-values (((p_51)
                                                                                                                (unwrap
                                                                                                                 d_60)))
                                                                                                    (if (pair? p_51)
                                                                                                      (if (let-values (((a_65)
                                                                                                                        (car
                                                                                                                         p_51)))
                                                                                                            #t)
                                                                                                        (let-values (((d_61)
                                                                                                                      (cdr
                                                                                                                       p_51)))
                                                                                                          (wrap-equal?
                                                                                                           '()
                                                                                                           d_61))
                                                                                                        #f)
                                                                                                      #f)))
                                                                                                #f)
                                                                                              #f)))
                                                                                        #f)
                                                                                      #f))))))
                                                                  (values result_29)))))
                                                  (if (if (not ((lambda x_11 (not result_28)) v_40)) (not #f) #f)
                                                    (for-loop_13 result_28 rest_17)
                                                    result_28)))
                                              result_27))))
                           for-loop_13)
                         #t
                         lst_26)))
                    #f))
                #f)
              #f))
        (let-values (((props_0 vals_0)
                      (let-values (((d_21) (cdr (unwrap v_39))))
                        (let-values (((props_1 vals_1)
                                      (let-values (((lst_28) d_21))
                                        (begin
                                          (void)
                                          ((letrec-values (((for-loop_14)
                                                            (lambda (props_2 vals_2 lst_29)
                                                              (if (not (wrap-null? lst_29))
                                                                (let-values (((v_41)
                                                                              (if (wrap-pair? lst_29)
                                                                                (wrap-car lst_29)
                                                                                lst_29))
                                                                             ((rest_18)
                                                                              (if (wrap-pair? lst_29)
                                                                                (wrap-cdr lst_29)
                                                                                null)))
                                                                  (let-values (((props_3 vals_3)
                                                                                (let-values (((props_4) props_2)
                                                                                             ((vals_4) vals_2))
                                                                                  (let-values (((props_5 vals_5)
                                                                                                (let-values ()
                                                                                                  (let-values (((props3_0
                                                                                                                 vals4_0)
                                                                                                                (let-values ()
                                                                                                                  (let-values (((d_62)
                                                                                                                                (cdr
                                                                                                                                 (unwrap
                                                                                                                                  v_41))))
                                                                                                                    (let-values (((p_52)
                                                                                                                                  (unwrap
                                                                                                                                   d_62)))
                                                                                                                      (let-values (((props_6)
                                                                                                                                    (let-values (((a_66)
                                                                                                                                                  (car
                                                                                                                                                   p_52)))
                                                                                                                                      a_66))
                                                                                                                                   ((vals_6)
                                                                                                                                    (let-values (((d_63)
                                                                                                                                                  (cdr
                                                                                                                                                   p_52)))
                                                                                                                                      (let-values (((a_67)
                                                                                                                                                    (car
                                                                                                                                                     (unwrap
                                                                                                                                                      d_63))))
                                                                                                                                        a_67))))
                                                                                                                        (values
                                                                                                                         props_6
                                                                                                                         vals_6)))))))
                                                                                                    (values
                                                                                                     (cons
                                                                                                      props3_0
                                                                                                      props_4)
                                                                                                     (cons
                                                                                                      vals4_0
                                                                                                      vals_4))))))
                                                                                    (values props_5 vals_5)))))
                                                                    (if (not #f)
                                                                      (for-loop_14 props_3 vals_3 rest_18)
                                                                      (values props_3 vals_3))))
                                                                (values props_2 vals_2)))))
                                             for-loop_14)
                                           null
                                           null
                                           lst_28)))))
                          (values (reverse$1 props_1) (reverse$1 vals_1))))))
          (let-values (((lst_30) props_0) ((lst_31) vals_0))
            (begin
              (check-list lst_30)
              (check-list lst_31)
              ((letrec-values (((for-loop_15)
                                (lambda (result_30 lst_32 lst_33)
                                  (if (if (pair? lst_32) (pair? lst_33) #f)
                                    (let-values (((prop_0) (unsafe-car lst_32))
                                                 ((rest_19) (unsafe-cdr lst_32))
                                                 ((val_0) (unsafe-car lst_33))
                                                 ((rest_20) (unsafe-cdr lst_33)))
                                      (let-values (((result_31)
                                                    (let-values ()
                                                      (let-values (((result_32)
                                                                    (let-values ()
                                                                      (let-values ()
                                                                        (let-values (((u-prop_0) (unwrap prop_0)))
                                                                          (if (symbol? u-prop_0)
                                                                            (if (let-values (((or-part_20)
                                                                                              (known-struct-type-property/immediate-guard?
                                                                                               (hash-ref
                                                                                                prim-knowns_2
                                                                                                u-prop_0
                                                                                                #f))))
                                                                                  (if or-part_20
                                                                                    or-part_20
                                                                                    (known-struct-type-property/immediate-guard?
                                                                                     (hash-ref-either
                                                                                      knowns_4
                                                                                      imports_3
                                                                                      u-prop_0))))
                                                                              (simple?
                                                                               val_0
                                                                               prim-knowns_2
                                                                               knowns_4
                                                                               imports_3
                                                                               mutated_2)
                                                                              #f)
                                                                            #f))))))
                                                        (values result_32)))))
                                        (if (if (not ((lambda x_12 (not result_31)) prop_0))
                                              (if (not ((lambda x_13 (not result_31)) val_0)) (not #f) #f)
                                              #f)
                                          (for-loop_15 result_31 rest_19 rest_20)
                                          result_31)))
                                    result_30))))
                 for-loop_15)
               #t
               lst_30
               lst_31))))
        (if (wrap-equal? 'null v_39)
          (let-values () #t)
          (if (let-values (((p_53) (unwrap v_39)))
                (if (pair? p_53)
                  (if (let-values (((a_68) (car p_53))) (wrap-equal? 'quote a_68))
                    (let-values (((d_64) (cdr p_53)))
                      (let-values (((p_54) (unwrap d_64)))
                        (if (pair? p_54)
                          (if (let-values (((a_69) (car p_54))) (wrap-equal? '() a_69))
                            (let-values (((d_65) (cdr p_54))) (wrap-equal? '() d_65))
                            #f)
                          #f)))
                    #f)
                  #f))
            (let-values () #t)
            (let-values () #f)))))))
 (define-values
  (find-definitions)
  (lambda (v_21 prim-knowns_0 knowns_2 imports_1 mutated_0)
    (let-values (((v_42) v_21))
      (if (let-values (((p_55) (unwrap v_42)))
            (if (pair? p_55)
              (if (let-values (((a_70) (car p_55))) (wrap-equal? 'define-values a_70))
                (let-values (((d_66) (cdr p_55)))
                  (let-values (((p_56) (unwrap d_66)))
                    (if (pair? p_56)
                      (if (let-values (((a_71) (car p_56)))
                            (let-values (((p_1) (unwrap a_71)))
                              (if (pair? p_1)
                                (if (let-values (((a_6) (car p_1))) #t)
                                  (let-values (((d_1) (cdr p_1))) (wrap-equal? '() d_1))
                                  #f)
                                #f)))
                        (let-values (((d_67) (cdr p_56)))
                          (let-values (((p_57) (unwrap d_67)))
                            (if (pair? p_57)
                              (if (let-values (((a_72) (car p_57))) #t)
                                (let-values (((d_68) (cdr p_57))) (wrap-equal? '() d_68))
                                #f)
                              #f)))
                        #f)
                      #f)))
                #f)
              #f))
        (let-values (((id_0 rhs_4)
                      (let-values (((d_69) (cdr (unwrap v_42))))
                        (let-values (((p_58) (unwrap d_69)))
                          (let-values (((id_1)
                                        (let-values (((a_3) (car p_58)))
                                          (let-values (((a_73) (car (unwrap a_3)))) a_73)))
                                       ((rhs_5)
                                        (let-values (((d_70) (cdr p_58)))
                                          (let-values (((a_74) (car (unwrap d_70)))) a_74))))
                            (values id_1 rhs_5))))))
          (values
           (if (lambda? rhs_4)
             (let-values () (hash-set knowns_2 (unwrap id_0) a-known-procedure))
             (if (simple? rhs_4 prim-knowns_0 knowns_2 imports_1 mutated_0)
               (let-values () (hash-set knowns_2 (unwrap id_0) a-known-unknown))
               (let-values () knowns_2)))
           #f))
        (if (let-values (((p_59) (unwrap v_42)))
              (if (pair? p_59)
                (if (let-values (((a_75) (car p_59))) (wrap-equal? 'define-values a_75))
                  (let-values (((d_71) (cdr p_59)))
                    (let-values (((p_60) (unwrap d_71)))
                      (if (pair? p_60)
                        (if (let-values (((a_76) (car p_60)))
                              (let-values (((p_61) (unwrap a_76)))
                                (if (pair? p_61)
                                  (if (let-values (((a_77) (car p_61))) #t)
                                    (let-values (((d_72) (cdr p_61)))
                                      (let-values (((p_62) (unwrap d_72)))
                                        (if (pair? p_62)
                                          (if (let-values (((a_78) (car p_62))) #t)
                                            (let-values (((d_73) (cdr p_62)))
                                              (let-values (((p_63) (unwrap d_73)))
                                                (if (pair? p_63)
                                                  (if (let-values (((a_79) (car p_63))) #t)
                                                    (let-values (((d_7) (cdr p_63))) (wrap-list? d_7))
                                                    #f)
                                                  #f)))
                                            #f)
                                          #f)))
                                    #f)
                                  #f)))
                          (let-values (((d_74) (cdr p_60)))
                            (let-values (((p_64) (unwrap d_74)))
                              (if (pair? p_64)
                                (if (let-values (((a_80) (car p_64)))
                                      (let-values (((p_65) (unwrap a_80)))
                                        (if (pair? p_65)
                                          (if (let-values (((a_81) (car p_65))) (wrap-equal? 'let-values a_81))
                                            (let-values (((d_9) (cdr p_65)))
                                              (let-values (((p_9) (unwrap d_9)))
                                                (if (pair? p_9)
                                                  (if (let-values (((a_82) (car p_9)))
                                                        (let-values (((p_66) (unwrap a_82)))
                                                          (if (pair? p_66)
                                                            (if (let-values (((a_13) (car p_66)))
                                                                  (let-values (((p_67) (unwrap a_13)))
                                                                    (if (pair? p_67)
                                                                      (if (let-values (((a_83) (car p_67)))
                                                                            (let-values (((p_36) (unwrap a_83)))
                                                                              (if (pair? p_36)
                                                                                (if (let-values (((a_49) (car p_36)))
                                                                                      #t)
                                                                                  (let-values (((d_75) (cdr p_36)))
                                                                                    (let-values (((p_68) (unwrap d_75)))
                                                                                      (if (pair? p_68)
                                                                                        (if (let-values (((a_84)
                                                                                                          (car p_68)))
                                                                                              #t)
                                                                                          (let-values (((d_76)
                                                                                                        (cdr p_68)))
                                                                                            (let-values (((p_69)
                                                                                                          (unwrap
                                                                                                           d_76)))
                                                                                              (if (pair? p_69)
                                                                                                (if (let-values (((a_85)
                                                                                                                  (car
                                                                                                                   p_69)))
                                                                                                      #t)
                                                                                                  (let-values (((d_44)
                                                                                                                (cdr
                                                                                                                 p_69)))
                                                                                                    (let-values (((p_39)
                                                                                                                  (unwrap
                                                                                                                   d_44)))
                                                                                                      (if (pair? p_39)
                                                                                                        (if (let-values (((a_14)
                                                                                                                          (car
                                                                                                                           p_39)))
                                                                                                              #t)
                                                                                                          (let-values (((d_11)
                                                                                                                        (cdr
                                                                                                                         p_39)))
                                                                                                            (let-values (((p_40)
                                                                                                                          (unwrap
                                                                                                                           d_11)))
                                                                                                              (if (pair?
                                                                                                                   p_40)
                                                                                                                (if (let-values (((a_52)
                                                                                                                                  (car
                                                                                                                                   p_40)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_45)
                                                                                                                                (cdr
                                                                                                                                 p_40)))
                                                                                                                    (wrap-equal?
                                                                                                                     '()
                                                                                                                     d_45))
                                                                                                                  #f)
                                                                                                                #f)))
                                                                                                          #f)
                                                                                                        #f)))
                                                                                                  #f)
                                                                                                #f)))
                                                                                          #f)
                                                                                        #f)))
                                                                                  #f)
                                                                                #f)))
                                                                        (let-values (((d_77) (cdr p_67)))
                                                                          (let-values (((p_70) (unwrap d_77)))
                                                                            (if (pair? p_70)
                                                                              (if (let-values (((a_86) (car p_70))) #t)
                                                                                (let-values (((d_78) (cdr p_70)))
                                                                                  (wrap-equal? '() d_78))
                                                                                #f)
                                                                              #f)))
                                                                        #f)
                                                                      #f)))
                                                              (let-values (((d_79) (cdr p_66))) (wrap-equal? '() d_79))
                                                              #f)
                                                            #f)))
                                                    (let-values (((d_47) (cdr p_9)))
                                                      (let-values (((p_71) (unwrap d_47)))
                                                        (if (pair? p_71)
                                                          (if (let-values (((a_87) (car p_71)))
                                                                (let-values (((p_10) (unwrap a_87)))
                                                                  (if (pair? p_10)
                                                                    (if (let-values (((a_16) (car p_10)))
                                                                          (wrap-equal? 'values a_16))
                                                                      (let-values (((d_12) (cdr p_10)))
                                                                        (let-values (((p_11) (unwrap d_12)))
                                                                          (if (pair? p_11)
                                                                            (if (let-values (((a_17) (car p_11))) #t)
                                                                              (let-values (((d_80) (cdr p_11)))
                                                                                (let-values (((p_72) (unwrap d_80)))
                                                                                  (if (pair? p_72)
                                                                                    (if (let-values (((a_88)
                                                                                                      (car p_72)))
                                                                                          #t)
                                                                                      (let-values (((d_81) (cdr p_72)))
                                                                                        (let-values (((p_73)
                                                                                                      (unwrap d_81)))
                                                                                          (if (pair? p_73)
                                                                                            (if (let-values (((a_56)
                                                                                                              (car
                                                                                                               p_73)))
                                                                                                  #t)
                                                                                              (let-values (((d_49)
                                                                                                            (cdr p_73)))
                                                                                                (wrap-list? d_49))
                                                                                              #f)
                                                                                            #f)))
                                                                                      #f)
                                                                                    #f)))
                                                                              #f)
                                                                            #f)))
                                                                      #f)
                                                                    #f)))
                                                            (let-values (((d_82) (cdr p_71))) (wrap-equal? '() d_82))
                                                            #f)
                                                          #f)))
                                                    #f)
                                                  #f)))
                                            #f)
                                          #f)))
                                  (let-values (((d_83) (cdr p_64))) (wrap-equal? '() d_83))
                                  #f)
                                #f)))
                          #f)
                        #f)))
                  #f)
                #f))
          (let-values (((struct:s_0
                         make-s_0
                         s?_0
                         acc/muts_0
                         struct:_10
                         make_0
                         ?_10
                         -ref_10
                         -set!_10
                         rhs_6
                         struct:2_0
                         make2_0
                         ?2_0
                         make-acc/muts_0)
                        (let-values (((d_84) (cdr (unwrap v_42))))
                          (let-values (((p_74) (unwrap d_84)))
                            (let-values (((struct:s_1 make-s_1 s?_1 acc/muts_1)
                                          (let-values (((a_22) (car p_74)))
                                            (let-values (((p_75) (unwrap a_22)))
                                              (let-values (((struct:s_2) (let-values (((a_62) (car p_75))) a_62))
                                                           ((make-s_2 s?_2 acc/muts_2)
                                                            (let-values (((d_58) (cdr p_75)))
                                                              (let-values (((p_76) (unwrap d_58)))
                                                                (let-values (((make-s_3)
                                                                              (let-values (((a_89) (car p_76))) a_89))
                                                                             ((s?_3 acc/muts_3)
                                                                              (let-values (((d_85) (cdr p_76)))
                                                                                (let-values (((p_77) (unwrap d_85)))
                                                                                  (let-values (((s?_4)
                                                                                                (let-values (((a_25)
                                                                                                              (car
                                                                                                               p_77)))
                                                                                                  a_25))
                                                                                               ((acc/muts_4)
                                                                                                (let-values (((d_86)
                                                                                                              (cdr
                                                                                                               p_77)))
                                                                                                  (unwrap-list d_86))))
                                                                                    (values s?_4 acc/muts_4))))))
                                                                  (values make-s_3 s?_3 acc/muts_3))))))
                                                (values struct:s_2 make-s_2 s?_2 acc/muts_2)))))
                                         ((struct:_11
                                           make_1
                                           ?_11
                                           -ref_11
                                           -set!_11
                                           rhs_7
                                           struct:2_1
                                           make2_1
                                           ?2_1
                                           make-acc/muts_1)
                                          (let-values (((d_59) (cdr p_74)))
                                            (let-values (((a_90) (car (unwrap d_59))))
                                              (let-values (((d_87) (cdr (unwrap a_90))))
                                                (let-values (((p_78) (unwrap d_87)))
                                                  (let-values (((struct:_12 make_2 ?_12 -ref_12 -set!_12 rhs_8)
                                                                (let-values (((a_91) (car p_78)))
                                                                  (let-values (((a_92) (car (unwrap a_91))))
                                                                    (let-values (((p_20) (unwrap a_92)))
                                                                      (let-values (((struct:_13
                                                                                     make_3
                                                                                     ?_13
                                                                                     -ref_13
                                                                                     -set!_13)
                                                                                    (let-values (((a_93) (car p_20)))
                                                                                      (let-values (((p_79)
                                                                                                    (unwrap a_93)))
                                                                                        (let-values (((struct:_14)
                                                                                                      (let-values (((a_94)
                                                                                                                    (car
                                                                                                                     p_79)))
                                                                                                        a_94))
                                                                                                     ((make_4
                                                                                                       ?_14
                                                                                                       -ref_14
                                                                                                       -set!_14)
                                                                                                      (let-values (((d_88)
                                                                                                                    (cdr
                                                                                                                     p_79)))
                                                                                                        (let-values (((p_80)
                                                                                                                      (unwrap
                                                                                                                       d_88)))
                                                                                                          (let-values (((make_5)
                                                                                                                        (let-values (((a_95)
                                                                                                                                      (car
                                                                                                                                       p_80)))
                                                                                                                          a_95))
                                                                                                                       ((?_15
                                                                                                                         -ref_15
                                                                                                                         -set!_15)
                                                                                                                        (let-values (((d_89)
                                                                                                                                      (cdr
                                                                                                                                       p_80)))
                                                                                                                          (let-values (((p_81)
                                                                                                                                        (unwrap
                                                                                                                                         d_89)))
                                                                                                                            (let-values (((?_16)
                                                                                                                                          (let-values (((a_96)
                                                                                                                                                        (car
                                                                                                                                                         p_81)))
                                                                                                                                            a_96))
                                                                                                                                         ((-ref_16
                                                                                                                                           -set!_16)
                                                                                                                                          (let-values (((d_90)
                                                                                                                                                        (cdr
                                                                                                                                                         p_81)))
                                                                                                                                            (let-values (((p_22)
                                                                                                                                                          (unwrap
                                                                                                                                                           d_90)))
                                                                                                                                              (let-values (((-ref_17)
                                                                                                                                                            (let-values (((a_30)
                                                                                                                                                                          (car
                                                                                                                                                                           p_22)))
                                                                                                                                                              a_30))
                                                                                                                                                           ((-set!_17)
                                                                                                                                                            (let-values (((d_26)
                                                                                                                                                                          (cdr
                                                                                                                                                                           p_22)))
                                                                                                                                                              (let-values (((a_31)
                                                                                                                                                                            (car
                                                                                                                                                                             (unwrap
                                                                                                                                                                              d_26))))
                                                                                                                                                                a_31))))
                                                                                                                                                (values
                                                                                                                                                 -ref_17
                                                                                                                                                 -set!_17))))))
                                                                                                                              (values
                                                                                                                               ?_16
                                                                                                                               -ref_16
                                                                                                                               -set!_16))))))
                                                                                                            (values
                                                                                                             make_5
                                                                                                             ?_15
                                                                                                             -ref_15
                                                                                                             -set!_15))))))
                                                                                          (values
                                                                                           struct:_14
                                                                                           make_4
                                                                                           ?_14
                                                                                           -ref_14
                                                                                           -set!_14)))))
                                                                                   ((rhs_9)
                                                                                    (let-values (((d_27) (cdr p_20)))
                                                                                      (let-values (((a_32)
                                                                                                    (car
                                                                                                     (unwrap d_27))))
                                                                                        a_32))))
                                                                        (values
                                                                         struct:_13
                                                                         make_3
                                                                         ?_13
                                                                         -ref_13
                                                                         -set!_13
                                                                         rhs_9))))))
                                                               ((struct:2_2 make2_2 ?2_2 make-acc/muts_2)
                                                                (let-values (((d_91) (cdr p_78)))
                                                                  (let-values (((a_97) (car (unwrap d_91))))
                                                                    (let-values (((d_92) (cdr (unwrap a_97))))
                                                                      (let-values (((p_82) (unwrap d_92)))
                                                                        (let-values (((struct:2_3)
                                                                                      (let-values (((a_98) (car p_82)))
                                                                                        a_98))
                                                                                     ((make2_3 ?2_3 make-acc/muts_3)
                                                                                      (let-values (((d_93) (cdr p_82)))
                                                                                        (let-values (((p_23)
                                                                                                      (unwrap d_93)))
                                                                                          (let-values (((make2_4)
                                                                                                        (let-values (((a_34)
                                                                                                                      (car
                                                                                                                       p_23)))
                                                                                                          a_34))
                                                                                                       ((?2_4
                                                                                                         make-acc/muts_4)
                                                                                                        (let-values (((d_94)
                                                                                                                      (cdr
                                                                                                                       p_23)))
                                                                                                          (let-values (((p_83)
                                                                                                                        (unwrap
                                                                                                                         d_94)))
                                                                                                            (let-values (((?2_5)
                                                                                                                          (let-values (((a_99)
                                                                                                                                        (car
                                                                                                                                         p_83)))
                                                                                                                            a_99))
                                                                                                                         ((make-acc/muts_5)
                                                                                                                          (let-values (((d_95)
                                                                                                                                        (cdr
                                                                                                                                         p_83)))
                                                                                                                            (unwrap-list
                                                                                                                             d_95))))
                                                                                                              (values
                                                                                                               ?2_5
                                                                                                               make-acc/muts_5))))))
                                                                                            (values
                                                                                             make2_4
                                                                                             ?2_4
                                                                                             make-acc/muts_4))))))
                                                                          (values
                                                                           struct:2_3
                                                                           make2_3
                                                                           ?2_3
                                                                           make-acc/muts_3))))))))
                                                    (values
                                                     struct:_12
                                                     make_2
                                                     ?_12
                                                     -ref_12
                                                     -set!_12
                                                     rhs_8
                                                     struct:2_2
                                                     make2_2
                                                     ?2_2
                                                     make-acc/muts_2))))))))
                              (values
                               struct:s_1
                               make-s_1
                               s?_1
                               acc/muts_1
                               struct:_11
                               make_1
                               ?_11
                               -ref_11
                               -set!_11
                               rhs_7
                               struct:2_1
                               make2_1
                               ?2_1
                               make-acc/muts_1))))))
            (let-values (((info_0)
                          (if (wrap-eq? struct:_10 struct:2_0)
                            (if (wrap-eq? make_0 make2_0)
                              (if (wrap-eq? ?_10 ?2_0)
                                (make-struct-type-info rhs_6 prim-knowns_0 knowns_2 imports_1 mutated_0)
                                #f)
                              #f)
                            #f)))
              (if info_0
                (let-values ()
                  (let-values (((type_0) (gensym (symbol->string (unwrap make-s_0)))))
                    (let-values (((knowns_5)
                                  (hash-set
                                   knowns_2
                                   (unwrap make-s_0)
                                   (if (struct-type-info-pure-constructor? info_0)
                                     (known-constructor type_0 (struct-type-info-field-count info_0))
                                     a-known-procedure))))
                      (let-values (((knowns_6) (hash-set knowns_5 (unwrap s?_0) (known-predicate type_0))))
                        (let-values (((knowns_7)
                                      (let-values (((lst_34) acc/muts_0) ((lst_35) make-acc/muts_0))
                                        (begin
                                          (check-list lst_34)
                                          (check-list lst_35)
                                          ((letrec-values (((for-loop_16)
                                                            (lambda (knowns_8 lst_36 lst_37)
                                                              (if (if (pair? lst_36) (pair? lst_37) #f)
                                                                (let-values (((id_2) (unsafe-car lst_36))
                                                                             ((rest_21) (unsafe-cdr lst_36))
                                                                             ((maker_0) (unsafe-car lst_37))
                                                                             ((rest_22) (unsafe-cdr lst_37)))
                                                                  (let-values (((knowns_9)
                                                                                (let-values (((knowns_10) knowns_8))
                                                                                  (let-values (((knowns_11)
                                                                                                (let-values ()
                                                                                                  (if (wrap-eq?
                                                                                                       (wrap-car
                                                                                                        maker_0)
                                                                                                       -ref_10)
                                                                                                    (let-values ()
                                                                                                      (hash-set
                                                                                                       knowns_10
                                                                                                       (unwrap id_2)
                                                                                                       (known-accessor
                                                                                                        type_0)))
                                                                                                    (let-values ()
                                                                                                      (hash-set
                                                                                                       knowns_10
                                                                                                       (unwrap id_2)
                                                                                                       (known-mutator
                                                                                                        type_0)))))))
                                                                                    (values knowns_11)))))
                                                                    (if (not #f)
                                                                      (for-loop_16 knowns_9 rest_21 rest_22)
                                                                      knowns_9)))
                                                                knowns_8))))
                                             for-loop_16)
                                           knowns_6
                                           lst_34
                                           lst_35)))))
                          (values
                           (hash-set
                            knowns_7
                            (unwrap struct:s_0)
                            (known-struct-type type_0 (struct-type-info-field-count info_0)))
                           info_0))))))
                (let-values () (values knowns_2 #f)))))
          (if (let-values (((p_28) (unwrap v_42)))
                (if (pair? p_28)
                  (if (let-values (((a_100) (car p_28))) (wrap-equal? 'define-values a_100))
                    (let-values (((d_96) (cdr p_28)))
                      (let-values (((p_84) (unwrap d_96)))
                        (if (pair? p_84)
                          (if (let-values (((a_38) (car p_84)))
                                (let-values (((p_85) (unwrap a_38)))
                                  (if (pair? p_85)
                                    (if (let-values (((a_101) (car p_85))) #t)
                                      (let-values (((d_97) (cdr p_85)))
                                        (let-values (((p_86) (unwrap d_97)))
                                          (if (pair? p_86)
                                            (if (let-values (((a_102) (car p_86))) #t)
                                              (let-values (((d_98) (cdr p_86)))
                                                (let-values (((p_87) (unwrap d_98)))
                                                  (if (pair? p_87)
                                                    (if (let-values (((a_103) (car p_87))) #t)
                                                      (let-values (((d_99) (cdr p_87)))
                                                        (let-values (((p_88) (unwrap d_99)))
                                                          (if (pair? p_88)
                                                            (if (let-values (((a_104) (car p_88))) #t)
                                                              (let-values (((d_100) (cdr p_88)))
                                                                (let-values (((p_89) (unwrap d_100)))
                                                                  (if (pair? p_89)
                                                                    (if (let-values (((a_105) (car p_89))) #t)
                                                                      (let-values (((d_101) (cdr p_89)))
                                                                        (wrap-equal? '() d_101))
                                                                      #f)
                                                                    #f)))
                                                              #f)
                                                            #f)))
                                                      #f)
                                                    #f)))
                                              #f)
                                            #f)))
                                      #f)
                                    #f)))
                            (let-values (((d_102) (cdr p_84)))
                              (let-values (((p_90) (unwrap d_102)))
                                (if (pair? p_90)
                                  (if (let-values (((a_106) (car p_90))) #t)
                                    (let-values (((d_103) (cdr p_90))) (wrap-equal? '() d_103))
                                    #f)
                                  #f)))
                            #f)
                          #f)))
                    #f)
                  #f))
            (let-values (((struct:s_3 make-s_4 s?_5 s-ref_0 s-set!_0 rhs_10)
                          (let-values (((d_104) (cdr (unwrap v_42))))
                            (let-values (((p_91) (unwrap d_104)))
                              (let-values (((struct:s_4 make-s_5 s?_6 s-ref_1 s-set!_1)
                                            (let-values (((a_107) (car p_91)))
                                              (let-values (((p_92) (unwrap a_107)))
                                                (let-values (((struct:s_5) (let-values (((a_108) (car p_92))) a_108))
                                                             ((make-s_6 s?_7 s-ref_2 s-set!_2)
                                                              (let-values (((d_105) (cdr p_92)))
                                                                (let-values (((p_93) (unwrap d_105)))
                                                                  (let-values (((make-s_7)
                                                                                (let-values (((a_109) (car p_93)))
                                                                                  a_109))
                                                                               ((s?_8 s-ref_3 s-set!_3)
                                                                                (let-values (((d_106) (cdr p_93)))
                                                                                  (let-values (((p_94) (unwrap d_106)))
                                                                                    (let-values (((s?_9)
                                                                                                  (let-values (((a_110)
                                                                                                                (car
                                                                                                                 p_94)))
                                                                                                    a_110))
                                                                                                 ((s-ref_4 s-set!_4)
                                                                                                  (let-values (((d_107)
                                                                                                                (cdr
                                                                                                                 p_94)))
                                                                                                    (let-values (((p_33)
                                                                                                                  (unwrap
                                                                                                                   d_107)))
                                                                                                      (let-values (((s-ref_5)
                                                                                                                    (let-values (((a_111)
                                                                                                                                  (car
                                                                                                                                   p_33)))
                                                                                                                      a_111))
                                                                                                                   ((s-set!_5)
                                                                                                                    (let-values (((d_108)
                                                                                                                                  (cdr
                                                                                                                                   p_33)))
                                                                                                                      (let-values (((a_112)
                                                                                                                                    (car
                                                                                                                                     (unwrap
                                                                                                                                      d_108))))
                                                                                                                        a_112))))
                                                                                                        (values
                                                                                                         s-ref_5
                                                                                                         s-set!_5))))))
                                                                                      (values
                                                                                       s?_9
                                                                                       s-ref_4
                                                                                       s-set!_4))))))
                                                                    (values make-s_7 s?_8 s-ref_3 s-set!_3))))))
                                                  (values struct:s_5 make-s_6 s?_7 s-ref_2 s-set!_2)))))
                                           ((rhs_11)
                                            (let-values (((d_109) (cdr p_91)))
                                              (let-values (((a_113) (car (unwrap d_109)))) a_113))))
                                (values struct:s_4 make-s_5 s?_6 s-ref_1 s-set!_1 rhs_11))))))
              (let-values (((info_1) (make-struct-type-info rhs_10 prim-knowns_0 knowns_2 imports_1 mutated_0)))
                (if info_1
                  (let-values ()
                    (let-values (((type_1) (gensym (symbol->string (unwrap make-s_4)))))
                      (values
                       (let-values (((knowns_12)
                                     (hash-set
                                      knowns_2
                                      (unwrap make-s_4)
                                      (if (struct-type-info-pure-constructor? info_1)
                                        (known-constructor type_1 (struct-type-info-field-count info_1))
                                        a-known-procedure))))
                         (let-values (((knowns_13) (hash-set knowns_12 (unwrap s?_5) (known-predicate type_1))))
                           (hash-set
                            knowns_13
                            (unwrap struct:s_3)
                            (known-struct-type type_1 (struct-type-info-field-count info_1)))))
                       info_1)))
                  (let-values () (values knowns_2 #f)))))
            (if (let-values (((p_95) (unwrap v_42)))
                  (if (pair? p_95)
                    (if (let-values (((a_114) (car p_95))) (wrap-equal? 'define-values a_114))
                      (let-values (((d_110) (cdr p_95)))
                        (let-values (((p_96) (unwrap d_110)))
                          (if (pair? p_96)
                            (if (let-values (((a_115) (car p_96)))
                                  (let-values (((p_97) (unwrap a_115)))
                                    (if (pair? p_97)
                                      (if (let-values (((a_116) (car p_97))) #t)
                                        (let-values (((d_111) (cdr p_97)))
                                          (let-values (((p_98) (unwrap d_111)))
                                            (if (pair? p_98)
                                              (if (let-values (((a_117) (car p_98))) #t)
                                                (let-values (((d_112) (cdr p_98)))
                                                  (let-values (((p_99) (unwrap d_112)))
                                                    (if (pair? p_99)
                                                      (if (let-values (((a_118) (car p_99))) #t)
                                                        (let-values (((d_113) (cdr p_99))) (wrap-equal? '() d_113))
                                                        #f)
                                                      #f)))
                                                #f)
                                              #f)))
                                        #f)
                                      #f)))
                              (let-values (((d_114) (cdr p_96)))
                                (let-values (((p_100) (unwrap d_114)))
                                  (if (pair? p_100)
                                    (if (let-values (((a_119) (car p_100)))
                                          (let-values (((p_101) (unwrap a_119)))
                                            (if (pair? p_101)
                                              (if (let-values (((a_120) (car p_101)))
                                                    (wrap-equal? 'make-struct-type-property a_120))
                                                (let-values (((d_115) (cdr p_101)))
                                                  (let-values (((p_102) (unwrap d_115)))
                                                    (if (pair? p_102)
                                                      (if (let-values (((a_121) (car p_102))) #t)
                                                        (let-values (((d_116) (cdr p_102))) #t)
                                                        #f)
                                                      #f)))
                                                #f)
                                              #f)))
                                      (let-values (((d_117) (cdr p_100))) (wrap-equal? '() d_117))
                                      #f)
                                    #f)))
                              #f)
                            #f)))
                      #f)
                    #f))
              (let-values (((prop:s_0 s?_10 s-ref_6 rest_23)
                            (let-values (((d_118) (cdr (unwrap v_42))))
                              (let-values (((p_103) (unwrap d_118)))
                                (let-values (((prop:s_1 s?_11 s-ref_7)
                                              (let-values (((a_122) (car p_103)))
                                                (let-values (((p_104) (unwrap a_122)))
                                                  (let-values (((prop:s_2) (let-values (((a_123) (car p_104))) a_123))
                                                               ((s?_12 s-ref_8)
                                                                (let-values (((d_119) (cdr p_104)))
                                                                  (let-values (((p_105) (unwrap d_119)))
                                                                    (let-values (((s?_13)
                                                                                  (let-values (((a_124) (car p_105)))
                                                                                    a_124))
                                                                                 ((s-ref_9)
                                                                                  (let-values (((d_120) (cdr p_105)))
                                                                                    (let-values (((a_125)
                                                                                                  (car (unwrap d_120))))
                                                                                      a_125))))
                                                                      (values s?_13 s-ref_9))))))
                                                    (values prop:s_2 s?_12 s-ref_8)))))
                                             ((rest_24)
                                              (let-values (((d_121) (cdr p_103)))
                                                (let-values (((a_126) (car (unwrap d_121))))
                                                  (let-values (((d_122) (cdr (unwrap a_126))))
                                                    (let-values (((d_123) (cdr (unwrap d_122)))) d_123))))))
                                  (values prop:s_1 s?_11 s-ref_7 rest_24))))))
                (let-values (((type_2) (gensym (symbol->string prop:s_0))))
                  (values
                   (let-values (((knowns_14) (hash-set knowns_2 (unwrap s-ref_6) (known-accessor type_2))))
                     (let-values (((knowns_15) (hash-set knowns_14 (unwrap s?_10) (known-predicate type_2))))
                       (if (let-values (((or-part_21) (null? (unwrap rest_23))))
                             (if or-part_21
                               or-part_21
                               (if (not (wrap-car rest_23)) (null? (unwrap (wrap-cdr rest_23))) #f)))
                         (let-values ()
                           (hash-set knowns_15 (unwrap prop:s_0) a-known-struct-type-property/immediate-guard))
                         (let-values () knowns_15))))
                   #f)))
              (let-values () (values knowns_2 #f)))))))))
 (define-values
  (lambda?)
  (lambda (v_43)
    (let-values (((v_44) v_43))
      (if (let-values (((p_106) (unwrap v_44)))
            (if (pair? p_106)
              (if (let-values (((a_127) (car p_106))) (wrap-equal? 'lambda a_127))
                (let-values (((d_124) (cdr p_106))) #t)
                #f)
              #f))
        (let-values () #t)
        (if (let-values (((p_107) (unwrap v_44)))
              (if (pair? p_107)
                (if (let-values (((a_128) (car p_107))) (wrap-equal? 'case-lambda a_128))
                  (let-values (((d_125) (cdr p_107))) #t)
                  #f)
                #f))
          (let-values () #t)
          (if (let-values (((p_108) (unwrap v_44)))
                (if (pair? p_108)
                  (if (let-values (((a_129) (car p_108))) (wrap-equal? 'let-values a_129))
                    (let-values (((d_126) (cdr p_108)))
                      (let-values (((p_109) (unwrap d_126)))
                        (if (pair? p_109)
                          (if (let-values (((a_130) (car p_109)))
                                (let-values (((p_110) (unwrap a_130)))
                                  (if (pair? p_110)
                                    (if (let-values (((a_131) (car p_110)))
                                          (let-values (((p_111) (unwrap a_131)))
                                            (if (pair? p_111)
                                              (if (let-values (((a_132) (car p_111)))
                                                    (let-values (((p_112) (unwrap a_132)))
                                                      (if (pair? p_112)
                                                        (if (let-values (((a_133) (car p_112))) #t)
                                                          (let-values (((d_127) (cdr p_112))) (wrap-equal? '() d_127))
                                                          #f)
                                                        #f)))
                                                (let-values (((d_128) (cdr p_111)))
                                                  (let-values (((p_113) (unwrap d_128)))
                                                    (if (pair? p_113)
                                                      (if (let-values (((a_134) (car p_113))) #t)
                                                        (let-values (((d_129) (cdr p_113))) (wrap-equal? '() d_129))
                                                        #f)
                                                      #f)))
                                                #f)
                                              #f)))
                                      (let-values (((d_130) (cdr p_110))) (wrap-equal? '() d_130))
                                      #f)
                                    #f)))
                            (let-values (((d_131) (cdr p_109)))
                              (let-values (((p_114) (unwrap d_131)))
                                (if (pair? p_114)
                                  (if (let-values (((a_135) (car p_114))) #t)
                                    (let-values (((d_132) (cdr p_114))) (wrap-equal? '() d_132))
                                    #f)
                                  #f)))
                            #f)
                          #f)))
                    #f)
                  #f))
            (let-values (((id_3 rhs_12 body_9)
                          (let-values (((d_133) (cdr (unwrap v_44))))
                            (let-values (((p_115) (unwrap d_133)))
                              (let-values (((id_4 rhs_13)
                                            (let-values (((a_136) (car p_115)))
                                              (let-values (((a_137) (car (unwrap a_136))))
                                                (let-values (((p_116) (unwrap a_137)))
                                                  (let-values (((id_5)
                                                                (let-values (((a_138) (car p_116)))
                                                                  (let-values (((a_139) (car (unwrap a_138)))) a_139)))
                                                               ((rhs_14)
                                                                (let-values (((d_134) (cdr p_116)))
                                                                  (let-values (((a_140) (car (unwrap d_134)))) a_140))))
                                                    (values id_5 rhs_14))))))
                                           ((body_10)
                                            (let-values (((d_135) (cdr p_115)))
                                              (let-values (((a_141) (car (unwrap d_135)))) a_141))))
                                (values id_4 rhs_13 body_10))))))
              (let-values (((or-part_22) (if (wrap-eq? id_3 body_9) (lambda? rhs_12) #f)))
                (if or-part_22 or-part_22 (lambda? body_9))))
            (if (let-values (((p_117) (unwrap v_44)))
                  (if (pair? p_117)
                    (if (let-values (((a_142) (car p_117))) (wrap-equal? 'letrec-values a_142))
                      (let-values (((d_136) (cdr p_117)))
                        (let-values (((p_118) (unwrap d_136)))
                          (if (pair? p_118)
                            (if (let-values (((a_143) (car p_118)))
                                  (let-values (((p_119) (unwrap a_143)))
                                    (if (pair? p_119)
                                      (if (let-values (((a_144) (car p_119)))
                                            (let-values (((p_120) (unwrap a_144)))
                                              (if (pair? p_120)
                                                (if (let-values (((a_145) (car p_120)))
                                                      (let-values (((p_121) (unwrap a_145)))
                                                        (if (pair? p_121)
                                                          (if (let-values (((a_146) (car p_121))) #t)
                                                            (let-values (((d_137) (cdr p_121))) (wrap-equal? '() d_137))
                                                            #f)
                                                          #f)))
                                                  (let-values (((d_138) (cdr p_120)))
                                                    (let-values (((p_122) (unwrap d_138)))
                                                      (if (pair? p_122)
                                                        (if (let-values (((a_147) (car p_122))) #t)
                                                          (let-values (((d_139) (cdr p_122))) (wrap-equal? '() d_139))
                                                          #f)
                                                        #f)))
                                                  #f)
                                                #f)))
                                        (let-values (((d_140) (cdr p_119))) (wrap-equal? '() d_140))
                                        #f)
                                      #f)))
                              (let-values (((d_141) (cdr p_118)))
                                (let-values (((p_123) (unwrap d_141)))
                                  (if (pair? p_123)
                                    (if (let-values (((a_148) (car p_123))) #t)
                                      (let-values (((d_142) (cdr p_123))) (wrap-equal? '() d_142))
                                      #f)
                                    #f)))
                              #f)
                            #f)))
                      #f)
                    #f))
              (let-values (((id_6 rhs_15 body_11)
                            (let-values (((d_143) (cdr (unwrap v_44))))
                              (let-values (((p_124) (unwrap d_143)))
                                (let-values (((id_7 rhs_16)
                                              (let-values (((a_149) (car p_124)))
                                                (let-values (((a_150) (car (unwrap a_149))))
                                                  (let-values (((p_125) (unwrap a_150)))
                                                    (let-values (((id_8)
                                                                  (let-values (((a_151) (car p_125)))
                                                                    (let-values (((a_152) (car (unwrap a_151))))
                                                                      a_152)))
                                                                 ((rhs_17)
                                                                  (let-values (((d_144) (cdr p_125)))
                                                                    (let-values (((a_153) (car (unwrap d_144))))
                                                                      a_153))))
                                                      (values id_8 rhs_17))))))
                                             ((body_12)
                                              (let-values (((d_145) (cdr p_124)))
                                                (let-values (((a_154) (car (unwrap d_145)))) a_154))))
                                  (values id_7 rhs_16 body_12))))))
                (let-values (((or-part_23) (if (wrap-eq? id_6 body_11) (lambda? rhs_15) #f)))
                  (if or-part_23 or-part_23 (lambda? body_11))))
              (if (let-values (((p_126) (unwrap v_44)))
                    (if (pair? p_126)
                      (if (let-values (((a_155) (car p_126))) (wrap-equal? 'let-values a_155))
                        (let-values (((d_146) (cdr p_126)))
                          (let-values (((p_127) (unwrap d_146)))
                            (if (pair? p_127)
                              (if (let-values (((a_156) (car p_127))) #t)
                                (let-values (((d_147) (cdr p_127)))
                                  (let-values (((p_128) (unwrap d_147)))
                                    (if (pair? p_128)
                                      (if (let-values (((a_157) (car p_128))) #t)
                                        (let-values (((d_148) (cdr p_128))) (wrap-equal? '() d_148))
                                        #f)
                                      #f)))
                                #f)
                              #f)))
                        #f)
                      #f))
                (let-values (((body_13)
                              (let-values (((d_149) (cdr (unwrap v_44))))
                                (let-values (((d_150) (cdr (unwrap d_149))))
                                  (let-values (((a_158) (car (unwrap d_150)))) a_158)))))
                  (lambda? body_13))
                (if (let-values (((p_129) (unwrap v_44)))
                      (if (pair? p_129)
                        (if (let-values (((a_159) (car p_129))) (wrap-equal? 'letrec-values a_159))
                          (let-values (((d_151) (cdr p_129)))
                            (let-values (((p_130) (unwrap d_151)))
                              (if (pair? p_130)
                                (if (let-values (((a_160) (car p_130))) #t)
                                  (let-values (((d_152) (cdr p_130)))
                                    (let-values (((p_131) (unwrap d_152)))
                                      (if (pair? p_131)
                                        (if (let-values (((a_161) (car p_131))) #t)
                                          (let-values (((d_153) (cdr p_131))) (wrap-equal? '() d_153))
                                          #f)
                                        #f)))
                                  #f)
                                #f)))
                          #f)
                        #f))
                  (let-values (((body_14)
                                (let-values (((d_154) (cdr (unwrap v_44))))
                                  (let-values (((d_155) (cdr (unwrap d_154))))
                                    (let-values (((a_162) (car (unwrap d_155)))) a_162)))))
                    (lambda? body_14))
                  (let-values () #f))))))))))
 (define-values
  (mutated-in-body)
  (lambda (l_0 exports_0 prim-knowns_3 knowns_16 imports_4)
    (let-values (((mutated_3) (make-hasheq)))
      (begin
        (let-values (((ht_2) exports_0))
          (begin
            (check-in-hash-keys ht_2)
            ((letrec-values (((for-loop_17)
                              (lambda (i_1)
                                (if i_1
                                  (let-values (((id_9) (hash-iterate-key ht_2 i_1)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (hash-set! mutated_3 id_9 'undefined))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_17 (hash-iterate-next ht_2 i_1)) (values))))
                                  (values)))))
               for-loop_17)
             (hash-iterate-first ht_2))))
        (void)
        (let-values (((lst_38) l_0))
          (begin
            (check-list lst_38)
            ((letrec-values (((for-loop_18)
                              (lambda (lst_39)
                                (if (pair? lst_39)
                                  (let-values (((form_0) (unsafe-car lst_39)) ((rest_25) (unsafe-cdr lst_39)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (let-values (((v_45) form_0))
                                                                          (if (let-values (((p_132) (unwrap v_45)))
                                                                                (if (pair? p_132)
                                                                                  (if (let-values (((a_163)
                                                                                                    (car p_132)))
                                                                                        (wrap-equal?
                                                                                         'define-values
                                                                                         a_163))
                                                                                    (let-values (((d_156) (cdr p_132)))
                                                                                      (let-values (((p_133)
                                                                                                    (unwrap d_156)))
                                                                                        (if (pair? p_133)
                                                                                          (if (let-values (((a_164)
                                                                                                            (car
                                                                                                             p_133)))
                                                                                                (wrap-list? a_164))
                                                                                            (let-values (((d_157)
                                                                                                          (cdr p_133)))
                                                                                              (let-values (((p_134)
                                                                                                            (unwrap
                                                                                                             d_157)))
                                                                                                (if (pair? p_134)
                                                                                                  (if (let-values (((a_165)
                                                                                                                    (car
                                                                                                                     p_134)))
                                                                                                        #t)
                                                                                                    (let-values (((d_158)
                                                                                                                  (cdr
                                                                                                                   p_134)))
                                                                                                      (wrap-equal?
                                                                                                       '()
                                                                                                       d_158))
                                                                                                    #f)
                                                                                                  #f)))
                                                                                            #f)
                                                                                          #f)))
                                                                                    #f)
                                                                                  #f))
                                                                            (let-values (((ids_8 rhs_18)
                                                                                          (let-values (((d_159)
                                                                                                        (cdr
                                                                                                         (unwrap
                                                                                                          v_45))))
                                                                                            (let-values (((p_59)
                                                                                                          (unwrap
                                                                                                           d_159)))
                                                                                              (let-values (((ids_9)
                                                                                                            (let-values (((a_166)
                                                                                                                          (car
                                                                                                                           p_59)))
                                                                                                              (unwrap-list
                                                                                                               a_166)))
                                                                                                           ((rhs_19)
                                                                                                            (let-values (((d_160)
                                                                                                                          (cdr
                                                                                                                           p_59)))
                                                                                                              (let-values (((a_167)
                                                                                                                            (car
                                                                                                                             (unwrap
                                                                                                                              d_160))))
                                                                                                                a_167))))
                                                                                                (values
                                                                                                 ids_9
                                                                                                 rhs_19))))))
                                                                              (begin
                                                                                (let-values (((lst_40) ids_8))
                                                                                  (begin
                                                                                    (check-list lst_40)
                                                                                    ((letrec-values (((for-loop_19)
                                                                                                      (lambda (lst_41)
                                                                                                        (if (pair?
                                                                                                             lst_41)
                                                                                                          (let-values (((id_10)
                                                                                                                        (unsafe-car
                                                                                                                         lst_41))
                                                                                                                       ((rest_26)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_41)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (hash-set!
                                                                                                                                                 mutated_3
                                                                                                                                                 (unwrap
                                                                                                                                                  id_10)
                                                                                                                                                 'not-ready))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_19
                                                                                                                 rest_26)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_19)
                                                                                     lst_40)))
                                                                                (void)))
                                                                            (let-values () (void)))))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_18 rest_25) (values))))
                                  (values)))))
               for-loop_18)
             lst_38)))
        (void)
        (let-values (((lst_42) l_0))
          (begin
            (check-list lst_42)
            ((letrec-values (((for-loop_20)
                              (lambda (prev-knowns_0 lst_43)
                                (if (pair? lst_43)
                                  (let-values (((form_1) (unsafe-car lst_43)) ((rest_27) (unsafe-cdr lst_43)))
                                    (let-values (((prev-knowns_1)
                                                  (let-values (((prev-knowns_2) prev-knowns_0))
                                                    (let-values (((prev-knowns_3)
                                                                  (let-values ()
                                                                    (let-values (((knowns_17 info_2)
                                                                                  (find-definitions
                                                                                   form_1
                                                                                   prim-knowns_3
                                                                                   prev-knowns_2
                                                                                   imports_4
                                                                                   mutated_3)))
                                                                      (begin
                                                                        (let-values (((v_38) form_1))
                                                                          (if (let-values (((p_35) (unwrap v_38)))
                                                                                (if (pair? p_35)
                                                                                  (if (let-values (((a_48) (car p_35)))
                                                                                        (wrap-equal?
                                                                                         'define-values
                                                                                         a_48))
                                                                                    (let-values (((d_41) (cdr p_35)))
                                                                                      (let-values (((p_36)
                                                                                                    (unwrap d_41)))
                                                                                        (if (pair? p_36)
                                                                                          (if (let-values (((a_49)
                                                                                                            (car p_36)))
                                                                                                (wrap-list? a_49))
                                                                                            (let-values (((d_75)
                                                                                                          (cdr p_36)))
                                                                                              (let-values (((p_68)
                                                                                                            (unwrap
                                                                                                             d_75)))
                                                                                                (if (pair? p_68)
                                                                                                  (if (let-values (((a_84)
                                                                                                                    (car
                                                                                                                     p_68)))
                                                                                                        #t)
                                                                                                    (let-values (((d_76)
                                                                                                                  (cdr
                                                                                                                   p_68)))
                                                                                                      (wrap-equal?
                                                                                                       '()
                                                                                                       d_76))
                                                                                                    #f)
                                                                                                  #f)))
                                                                                            #f)
                                                                                          #f)))
                                                                                    #f)
                                                                                  #f))
                                                                            (let-values (((ids_10 rhs_20)
                                                                                          (let-values (((d_44)
                                                                                                        (cdr
                                                                                                         (unwrap
                                                                                                          v_38))))
                                                                                            (let-values (((p_39)
                                                                                                          (unwrap
                                                                                                           d_44)))
                                                                                              (let-values (((ids_11)
                                                                                                            (let-values (((a_15)
                                                                                                                          (car
                                                                                                                           p_39)))
                                                                                                              (unwrap-list
                                                                                                               a_15)))
                                                                                                           ((rhs_21)
                                                                                                            (let-values (((d_161)
                                                                                                                          (cdr
                                                                                                                           p_39)))
                                                                                                              (let-values (((a_168)
                                                                                                                            (car
                                                                                                                             (unwrap
                                                                                                                              d_161))))
                                                                                                                a_168))))
                                                                                                (values
                                                                                                 ids_11
                                                                                                 rhs_21))))))
                                                                              (begin
                                                                                (if info_2
                                                                                  (let-values ()
                                                                                    (begin
                                                                                      (let-values (((lst_44)
                                                                                                    (struct-type-info-rest
                                                                                                     info_2))
                                                                                                   ((start_0) 0))
                                                                                        (begin
                                                                                          (check-list lst_44)
                                                                                          (check-naturals start_0)
                                                                                          ((letrec-values (((for-loop_21)
                                                                                                            (lambda (lst_45
                                                                                                                     pos_0)
                                                                                                              (if (if (pair?
                                                                                                                       lst_45)
                                                                                                                    #t
                                                                                                                    #f)
                                                                                                                (let-values (((e_4)
                                                                                                                              (unsafe-car
                                                                                                                               lst_45))
                                                                                                                             ((rest_28)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_45))
                                                                                                                             ((pos_1)
                                                                                                                              pos_0))
                                                                                                                  (let-values ((()
                                                                                                                                (let-values ()
                                                                                                                                  (let-values ((()
                                                                                                                                                (let-values ()
                                                                                                                                                  (begin
                                                                                                                                                    (let-values ()
                                                                                                                                                      (if (if (=
                                                                                                                                                               pos_1
                                                                                                                                                               struct-type-info-rest-properties-list-pos)
                                                                                                                                                            (pure-properties-list?
                                                                                                                                                             e_4
                                                                                                                                                             prim-knowns_3
                                                                                                                                                             knowns_17
                                                                                                                                                             imports_4
                                                                                                                                                             mutated_3)
                                                                                                                                                            #f)
                                                                                                                                                        (void)
                                                                                                                                                        (let-values ()
                                                                                                                                                          (find-mutated!
                                                                                                                                                           e_4
                                                                                                                                                           ids_10
                                                                                                                                                           prim-knowns_3
                                                                                                                                                           knowns_17
                                                                                                                                                           imports_4
                                                                                                                                                           mutated_3))))
                                                                                                                                                    (values)))))
                                                                                                                                    (values)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_21
                                                                                                                       rest_28
                                                                                                                       (+
                                                                                                                        pos_0
                                                                                                                        1))
                                                                                                                      (values))))
                                                                                                                (values)))))
                                                                                             for-loop_21)
                                                                                           lst_44
                                                                                           start_0)))
                                                                                      (void)))
                                                                                  (let-values ()
                                                                                    (find-mutated!
                                                                                     rhs_20
                                                                                     ids_10
                                                                                     prim-knowns_3
                                                                                     knowns_17
                                                                                     imports_4
                                                                                     mutated_3)))
                                                                                (let-values (((lst_46) ids_10))
                                                                                  (begin
                                                                                    (check-list lst_46)
                                                                                    ((letrec-values (((for-loop_22)
                                                                                                      (lambda (lst_47)
                                                                                                        (if (pair?
                                                                                                             lst_47)
                                                                                                          (let-values (((id_11)
                                                                                                                        (unsafe-car
                                                                                                                         lst_47))
                                                                                                                       ((rest_29)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_47)))
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
                                                                                                                                                      (unwrap
                                                                                                                                                       id_11)
                                                                                                                                                      #f))
                                                                                                                                                  (let-values ()
                                                                                                                                                    (hash-remove!
                                                                                                                                                     mutated_3
                                                                                                                                                     id_11))
                                                                                                                                                  (void)))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_22
                                                                                                                 rest_29)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_22)
                                                                                     lst_46)))
                                                                                (void)))
                                                                            (let-values ()
                                                                              (find-mutated!
                                                                               form_1
                                                                               #f
                                                                               prim-knowns_3
                                                                               knowns_17
                                                                               imports_4
                                                                               mutated_3))))
                                                                        knowns_17)))))
                                                      (values prev-knowns_3)))))
                                      (if (not #f) (for-loop_20 prev-knowns_1 rest_27) prev-knowns_1)))
                                  prev-knowns_0))))
               for-loop_20)
             knowns_16
             lst_42)))
        (let-values (((lst_6) l_0))
          (begin
            (check-list lst_6)
            ((letrec-values (((for-loop_3)
                              (lambda (lst_48)
                                (if (pair? lst_48)
                                  (let-values (((form_2) (unsafe-car lst_48)) ((rest_30) (unsafe-cdr lst_48)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (let-values (((v_46) form_2))
                                                                          (if (let-values (((p_135) (unwrap v_46)))
                                                                                (if (pair? p_135)
                                                                                  (if (let-values (((a_169)
                                                                                                    (car p_135)))
                                                                                        (wrap-equal?
                                                                                         'define-values
                                                                                         a_169))
                                                                                    (let-values (((d_83) (cdr p_135)))
                                                                                      (let-values (((p_12)
                                                                                                    (unwrap d_83)))
                                                                                        (if (pair? p_12)
                                                                                          (if (let-values (((a_18)
                                                                                                            (car p_12)))
                                                                                                (wrap-list? a_18))
                                                                                            (let-values (((d_13)
                                                                                                          (cdr p_12)))
                                                                                              (let-values (((p_13)
                                                                                                            (unwrap
                                                                                                             d_13)))
                                                                                                (if (pair? p_13)
                                                                                                  (if (let-values (((a_19)
                                                                                                                    (car
                                                                                                                     p_13)))
                                                                                                        #t)
                                                                                                    (let-values (((d_14)
                                                                                                                  (cdr
                                                                                                                   p_13)))
                                                                                                      (wrap-equal?
                                                                                                       '()
                                                                                                       d_14))
                                                                                                    #f)
                                                                                                  #f)))
                                                                                            #f)
                                                                                          #f)))
                                                                                    #f)
                                                                                  #f))
                                                                            (let-values (((ids_12 rhs_22)
                                                                                          (let-values (((d_51)
                                                                                                        (cdr
                                                                                                         (unwrap
                                                                                                          v_46))))
                                                                                            (let-values (((p_136)
                                                                                                          (unwrap
                                                                                                           d_51)))
                                                                                              (let-values (((ids_13)
                                                                                                            (let-values (((a_170)
                                                                                                                          (car
                                                                                                                           p_136)))
                                                                                                              (unwrap-list
                                                                                                               a_170)))
                                                                                                           ((rhs_23)
                                                                                                            (let-values (((d_17)
                                                                                                                          (cdr
                                                                                                                           p_136)))
                                                                                                              (let-values (((a_0)
                                                                                                                            (car
                                                                                                                             (unwrap
                                                                                                                              d_17))))
                                                                                                                a_0))))
                                                                                                (values
                                                                                                 ids_13
                                                                                                 rhs_23))))))
                                                                              (begin
                                                                                (let-values (((lst_49) ids_12))
                                                                                  (begin
                                                                                    (check-list lst_49)
                                                                                    ((letrec-values (((for-loop_23)
                                                                                                      (lambda (lst_50)
                                                                                                        (if (pair?
                                                                                                             lst_50)
                                                                                                          (let-values (((id_12)
                                                                                                                        (unsafe-car
                                                                                                                         lst_50))
                                                                                                                       ((rest_31)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_50)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((id_13)
                                                                                                                                                              (unwrap
                                                                                                                                                               id_12)))
                                                                                                                                                  (let-values (((state_0)
                                                                                                                                                                (hash-ref
                                                                                                                                                                 mutated_3
                                                                                                                                                                 id_13
                                                                                                                                                                 #f)))
                                                                                                                                                    (if (delayed-mutated-state?
                                                                                                                                                         state_0)
                                                                                                                                                      (let-values ()
                                                                                                                                                        (begin
                                                                                                                                                          (hash-remove!
                                                                                                                                                           mutated_3
                                                                                                                                                           id_13)
                                                                                                                                                          (state_0)))
                                                                                                                                                      (void)))))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_23
                                                                                                                 rest_31)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_23)
                                                                                     lst_49)))
                                                                                (void)))
                                                                            (let-values () (void)))))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_3 rest_30) (values))))
                                  (values)))))
               for-loop_3)
             lst_6)))
        (void)
        mutated_3))))
 (define-values
  (find-mutated!)
  (lambda (v_47 ids_14 prim-knowns_4 knowns_18 imports_5 mutated_4)
    (let-values (((delay!_0)
                  (lambda (ids_15 thunk_0)
                    (let-values (((done?_0) #f))
                      (begin
                        (let-values (((lst_51) ids_15))
                          (begin
                            (check-list lst_51)
                            ((letrec-values (((for-loop_24)
                                              (lambda (lst_52)
                                                (if (pair? lst_52)
                                                  (let-values (((id_14) (unsafe-car lst_52))
                                                               ((rest_32) (unsafe-cdr lst_52)))
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (let-values ((()
                                                                                  (let-values ()
                                                                                    (begin
                                                                                      (let-values ()
                                                                                        (let-values (((id_15)
                                                                                                      (unwrap id_14)))
                                                                                          (if (eq?
                                                                                               'not-ready
                                                                                               (hash-ref
                                                                                                mutated_4
                                                                                                id_15
                                                                                                'not-ready))
                                                                                            (let-values ()
                                                                                              (hash-set!
                                                                                               mutated_4
                                                                                               id_15
                                                                                               (lambda ()
                                                                                                 (if done?_0
                                                                                                   (void)
                                                                                                   (let-values ()
                                                                                                     (begin
                                                                                                       (set! done?_0 #t)
                                                                                                       (thunk_0)))))))
                                                                                            (void))))
                                                                                      (values)))))
                                                                      (values)))))
                                                      (if (not #f) (for-loop_24 rest_32) (values))))
                                                  (values)))))
                               for-loop_24)
                             lst_51)))
                        (void))))))
      ((letrec-values (((find-mutated!_0)
                        (lambda (v_48 ids_16)
                          (let-values (((find-mutated!*_0)
                                        (lambda (l_6 ids_17)
                                          ((letrec-values (((loop_3)
                                                            (lambda (l_7)
                                                              (if (null? l_7)
                                                                (let-values () (void))
                                                                (if (null? (cdr l_7))
                                                                  (let-values () (find-mutated!_0 (car l_7) ids_17))
                                                                  (let-values ()
                                                                    (begin
                                                                      (find-mutated!_0 (car l_7) #f)
                                                                      (loop_3 (cdr l_7)))))))))
                                             loop_3)
                                           l_6))))
                            (let-values (((v_49) v_48))
                              (if (let-values (((p_49) (unwrap v_49)))
                                    (if (pair? p_49)
                                      (if (let-values (((a_63) (car p_49))) (wrap-equal? 'lambda a_63))
                                        (let-values (((d_59) (cdr p_49)))
                                          (let-values (((p_50) (unwrap d_59)))
                                            (if (pair? p_50)
                                              (if (let-values (((a_64) (car p_50))) #t)
                                                (let-values (((d_60) (cdr p_50))) (wrap-list? d_60))
                                                #f)
                                              #f)))
                                        #f)
                                      #f))
                                (let-values (((formals_0 body_15)
                                              (let-values (((d_61) (cdr (unwrap v_49))))
                                                (let-values (((p_137) (unwrap d_61)))
                                                  (let-values (((formals_1) (let-values (((a_171) (car p_137))) a_171))
                                                               ((body_16)
                                                                (let-values (((d_162) (cdr p_137)))
                                                                  (unwrap-list d_162))))
                                                    (values formals_1 body_16))))))
                                  (if ids_16
                                    (delay!_0 ids_16 (lambda () (find-mutated!*_0 body_15 #f)))
                                    (find-mutated!*_0 body_15 #f)))
                                (if (let-values (((p_138) (unwrap v_49)))
                                      (if (pair? p_138)
                                        (if (let-values (((a_172) (car p_138))) (wrap-equal? 'case-lambda a_172))
                                          (let-values (((d_163) (cdr p_138)))
                                            (if (wrap-list? d_163)
                                              (let-values (((lst_53) d_163))
                                                (begin
                                                  (void)
                                                  ((letrec-values (((for-loop_25)
                                                                    (lambda (result_33 lst_54)
                                                                      (if (not (wrap-null? lst_54))
                                                                        (let-values (((v_50)
                                                                                      (if (wrap-pair? lst_54)
                                                                                        (wrap-car lst_54)
                                                                                        lst_54))
                                                                                     ((rest_33)
                                                                                      (if (wrap-pair? lst_54)
                                                                                        (wrap-cdr lst_54)
                                                                                        null)))
                                                                          (let-values (((result_34)
                                                                                        (let-values ()
                                                                                          (let-values (((result_35)
                                                                                                        (let-values ()
                                                                                                          (let-values ()
                                                                                                            (let-values (((p_79)
                                                                                                                          (unwrap
                                                                                                                           v_50)))
                                                                                                              (if (pair?
                                                                                                                   p_79)
                                                                                                                (if (let-values (((a_173)
                                                                                                                                  (car
                                                                                                                                   p_79)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_164)
                                                                                                                                (cdr
                                                                                                                                 p_79)))
                                                                                                                    (wrap-list?
                                                                                                                     d_164))
                                                                                                                  #f)
                                                                                                                #f))))))
                                                                                            (values result_35)))))
                                                                            (if (if (not
                                                                                     ((lambda x_14 (not result_34))
                                                                                      v_50))
                                                                                  (not #f)
                                                                                  #f)
                                                                              (for-loop_25 result_34 rest_33)
                                                                              result_34)))
                                                                        result_33))))
                                                     for-loop_25)
                                                   #t
                                                   lst_53)))
                                              #f))
                                          #f)
                                        #f))
                                  (let-values (((formalss_0 bodys_0)
                                                (let-values (((d_165) (cdr (unwrap v_49))))
                                                  (let-values (((formalss_1 bodys_1)
                                                                (let-values (((lst_55) d_165))
                                                                  (begin
                                                                    (void)
                                                                    ((letrec-values (((for-loop_26)
                                                                                      (lambda (formalss_2
                                                                                               bodys_2
                                                                                               lst_56)
                                                                                        (if (not (wrap-null? lst_56))
                                                                                          (let-values (((v_51)
                                                                                                        (if (wrap-pair?
                                                                                                             lst_56)
                                                                                                          (wrap-car
                                                                                                           lst_56)
                                                                                                          lst_56))
                                                                                                       ((rest_34)
                                                                                                        (if (wrap-pair?
                                                                                                             lst_56)
                                                                                                          (wrap-cdr
                                                                                                           lst_56)
                                                                                                          null)))
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
                                                                                                                                            (let-values (((p_139)
                                                                                                                                                          (unwrap
                                                                                                                                                           v_51)))
                                                                                                                                              (let-values (((formalss_6)
                                                                                                                                                            (let-values (((a_174)
                                                                                                                                                                          (car
                                                                                                                                                                           p_139)))
                                                                                                                                                              a_174))
                                                                                                                                                           ((bodys_6)
                                                                                                                                                            (let-values (((d_166)
                                                                                                                                                                          (cdr
                                                                                                                                                                           p_139)))
                                                                                                                                                              (unwrap-list
                                                                                                                                                               d_166))))
                                                                                                                                                (values
                                                                                                                                                 formalss_6
                                                                                                                                                 bodys_6))))))
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
                                                                                                (for-loop_26
                                                                                                 formalss_3
                                                                                                 bodys_3
                                                                                                 rest_34)
                                                                                                (values
                                                                                                 formalss_3
                                                                                                 bodys_3))))
                                                                                          (values
                                                                                           formalss_2
                                                                                           bodys_2)))))
                                                                       for-loop_26)
                                                                     null
                                                                     null
                                                                     lst_55)))))
                                                    (values (reverse$1 formalss_1) (reverse$1 bodys_1))))))
                                    (if ids_16
                                      (delay!_0
                                       ids_16
                                       (lambda ()
                                         (begin
                                           (let-values (((lst_16) bodys_0))
                                             (begin
                                               (check-list lst_16)
                                               ((letrec-values (((for-loop_8)
                                                                 (lambda (lst_57)
                                                                   (if (pair? lst_57)
                                                                     (let-values (((body_17) (unsafe-car lst_57))
                                                                                  ((rest_35) (unsafe-cdr lst_57)))
                                                                       (let-values ((()
                                                                                     (let-values ()
                                                                                       (let-values ((()
                                                                                                     (let-values ()
                                                                                                       (begin
                                                                                                         (let-values ()
                                                                                                           (find-mutated!*_0
                                                                                                            body_17
                                                                                                            #f))
                                                                                                         (values)))))
                                                                                         (values)))))
                                                                         (if (not #f) (for-loop_8 rest_35) (values))))
                                                                     (values)))))
                                                  for-loop_8)
                                                lst_16)))
                                           (void))))
                                      (begin
                                        (let-values (((lst_58) bodys_0))
                                          (begin
                                            (check-list lst_58)
                                            ((letrec-values (((for-loop_27)
                                                              (lambda (lst_59)
                                                                (if (pair? lst_59)
                                                                  (let-values (((body_18) (unsafe-car lst_59))
                                                                               ((rest_36) (unsafe-cdr lst_59)))
                                                                    (let-values ((()
                                                                                  (let-values ()
                                                                                    (let-values ((()
                                                                                                  (let-values ()
                                                                                                    (begin
                                                                                                      (let-values ()
                                                                                                        (find-mutated!*_0
                                                                                                         body_18
                                                                                                         #f))
                                                                                                      (values)))))
                                                                                      (values)))))
                                                                      (if (not #f) (for-loop_27 rest_36) (values))))
                                                                  (values)))))
                                               for-loop_27)
                                             lst_58)))
                                        (void))))
                                  (if (let-values (((p_23) (unwrap v_49)))
                                        (if (pair? p_23)
                                          (if (let-values (((a_33) (car p_23))) (wrap-equal? 'quote a_33))
                                            (let-values (((d_28) (cdr p_23)))
                                              (let-values (((p_24) (unwrap d_28)))
                                                (if (pair? p_24)
                                                  (if (let-values (((a_34) (car p_24))) #t)
                                                    (let-values (((d_94) (cdr p_24))) (wrap-equal? '() d_94))
                                                    #f)
                                                  #f)))
                                            #f)
                                          #f))
                                    (let-values () (void))
                                    (if (let-values (((p_83) (unwrap v_49)))
                                          (if (pair? p_83)
                                            (if (let-values (((a_175) (car p_83))) (wrap-equal? 'let-values a_175))
                                              (let-values (((d_167) (cdr p_83)))
                                                (let-values (((p_140) (unwrap d_167)))
                                                  (if (pair? p_140)
                                                    (if (let-values (((a_176) (car p_140)))
                                                          (if (wrap-list? a_176)
                                                            (let-values (((lst_60) a_176))
                                                              (begin
                                                                (void)
                                                                ((letrec-values (((for-loop_28)
                                                                                  (lambda (result_20 lst_61)
                                                                                    (if (not (wrap-null? lst_61))
                                                                                      (let-values (((v_52)
                                                                                                    (if (wrap-pair?
                                                                                                         lst_61)
                                                                                                      (wrap-car lst_61)
                                                                                                      lst_61))
                                                                                                   ((rest_37)
                                                                                                    (if (wrap-pair?
                                                                                                         lst_61)
                                                                                                      (wrap-cdr lst_61)
                                                                                                      null)))
                                                                                        (let-values (((result_36)
                                                                                                      (let-values ()
                                                                                                        (let-values (((result_37)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (let-values (((p_141)
                                                                                                                                        (unwrap
                                                                                                                                         v_52)))
                                                                                                                            (if (pair?
                                                                                                                                 p_141)
                                                                                                                              (if (let-values (((a_177)
                                                                                                                                                (car
                                                                                                                                                 p_141)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_168)
                                                                                                                                              (cdr
                                                                                                                                               p_141)))
                                                                                                                                  (let-values (((p_142)
                                                                                                                                                (unwrap
                                                                                                                                                 d_168)))
                                                                                                                                    (if (pair?
                                                                                                                                         p_142)
                                                                                                                                      (if (let-values (((a_178)
                                                                                                                                                        (car
                                                                                                                                                         p_142)))
                                                                                                                                            #t)
                                                                                                                                        (let-values (((d_169)
                                                                                                                                                      (cdr
                                                                                                                                                       p_142)))
                                                                                                                                          (wrap-equal?
                                                                                                                                           '()
                                                                                                                                           d_169))
                                                                                                                                        #f)
                                                                                                                                      #f)))
                                                                                                                                #f)
                                                                                                                              #f))))))
                                                                                                          (values
                                                                                                           result_37)))))
                                                                                          (if (if (not
                                                                                                   ((lambda x_15
                                                                                                      (not result_36))
                                                                                                    v_52))
                                                                                                (not #f)
                                                                                                #f)
                                                                                            (for-loop_28
                                                                                             result_36
                                                                                             rest_37)
                                                                                            result_36)))
                                                                                      result_20))))
                                                                   for-loop_28)
                                                                 #t
                                                                 lst_60)))
                                                            #f))
                                                      (let-values (((d_170) (cdr p_140))) (wrap-list? d_170))
                                                      #f)
                                                    #f)))
                                              #f)
                                            #f))
                                      (let-values (((idss_8 rhss_30 bodys_7)
                                                    (let-values (((d_96) (cdr (unwrap v_49))))
                                                      (let-values (((p_84) (unwrap d_96)))
                                                        (let-values (((idss_9 rhss_31)
                                                                      (let-values (((a_179) (car p_84)))
                                                                        (let-values (((idss_10 rhss_32)
                                                                                      (let-values (((lst_62) a_179))
                                                                                        (begin
                                                                                          (void)
                                                                                          ((letrec-values (((for-loop_29)
                                                                                                            (lambda (idss_11
                                                                                                                     rhss_33
                                                                                                                     lst_63)
                                                                                                              (if (not
                                                                                                                   (wrap-null?
                                                                                                                    lst_63))
                                                                                                                (let-values (((v_53)
                                                                                                                              (if (wrap-pair?
                                                                                                                                   lst_63)
                                                                                                                                (wrap-car
                                                                                                                                 lst_63)
                                                                                                                                lst_63))
                                                                                                                             ((rest_38)
                                                                                                                              (if (wrap-pair?
                                                                                                                                   lst_63)
                                                                                                                                (wrap-cdr
                                                                                                                                 lst_63)
                                                                                                                                null)))
                                                                                                                  (let-values (((idss_12
                                                                                                                                 rhss_34)
                                                                                                                                (let-values (((idss_13)
                                                                                                                                              idss_11)
                                                                                                                                             ((rhss_35)
                                                                                                                                              rhss_33))
                                                                                                                                  (let-values (((idss_14
                                                                                                                                                 rhss_36)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values (((idss3_1
                                                                                                                                                                 rhss4_1)
                                                                                                                                                                (let-values ()
                                                                                                                                                                  (let-values (((p_143)
                                                                                                                                                                                (unwrap
                                                                                                                                                                                 v_53)))
                                                                                                                                                                    (let-values (((idss_15)
                                                                                                                                                                                  (let-values (((a_180)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 p_143)))
                                                                                                                                                                                    a_180))
                                                                                                                                                                                 ((rhss_37)
                                                                                                                                                                                  (let-values (((d_171)
                                                                                                                                                                                                (cdr
                                                                                                                                                                                                 p_143)))
                                                                                                                                                                                    (let-values (((a_181)
                                                                                                                                                                                                  (car
                                                                                                                                                                                                   (unwrap
                                                                                                                                                                                                    d_171))))
                                                                                                                                                                                      a_181))))
                                                                                                                                                                      (values
                                                                                                                                                                       idss_15
                                                                                                                                                                       rhss_37))))))
                                                                                                                                                    (values
                                                                                                                                                     (cons
                                                                                                                                                      idss3_1
                                                                                                                                                      idss_13)
                                                                                                                                                     (cons
                                                                                                                                                      rhss4_1
                                                                                                                                                      rhss_35))))))
                                                                                                                                    (values
                                                                                                                                     idss_14
                                                                                                                                     rhss_36)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_29
                                                                                                                       idss_12
                                                                                                                       rhss_34
                                                                                                                       rest_38)
                                                                                                                      (values
                                                                                                                       idss_12
                                                                                                                       rhss_34))))
                                                                                                                (values
                                                                                                                 idss_11
                                                                                                                 rhss_33)))))
                                                                                             for-loop_29)
                                                                                           null
                                                                                           null
                                                                                           lst_62)))))
                                                                          (values
                                                                           (reverse$1 idss_10)
                                                                           (reverse$1 rhss_32)))))
                                                                     ((bodys_8)
                                                                      (let-values (((d_172) (cdr p_84)))
                                                                        (unwrap-list d_172))))
                                                          (values idss_9 rhss_31 bodys_8))))))
                                        (begin
                                          (let-values (((lst_64) idss_8) ((lst_23) rhss_30))
                                            (begin
                                              (check-list lst_64)
                                              (check-list lst_23)
                                              ((letrec-values (((for-loop_30)
                                                                (lambda (lst_65 lst_66)
                                                                  (if (if (pair? lst_65) (pair? lst_66) #f)
                                                                    (let-values (((ids_18) (unsafe-car lst_65))
                                                                                 ((rest_39) (unsafe-cdr lst_65))
                                                                                 ((rhs_24) (unsafe-car lst_66))
                                                                                 ((rest_40) (unsafe-cdr lst_66)))
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
                                                                          (for-loop_30 rest_39 rest_40)
                                                                          (values))))
                                                                    (values)))))
                                                 for-loop_30)
                                               lst_64
                                               lst_23)))
                                          (void)
                                          (find-mutated!*_0 bodys_7 ids_16)))
                                      (if (let-values (((p_144) (unwrap v_49)))
                                            (if (pair? p_144)
                                              (if (let-values (((a_182) (car p_144)))
                                                    (wrap-equal? 'letrec-values a_182))
                                                (let-values (((d_173) (cdr p_144)))
                                                  (let-values (((p_145) (unwrap d_173)))
                                                    (if (pair? p_145)
                                                      (if (let-values (((a_108) (car p_145)))
                                                            (if (wrap-list? a_108)
                                                              (let-values (((lst_67) a_108))
                                                                (begin
                                                                  (void)
                                                                  ((letrec-values (((for-loop_31)
                                                                                    (lambda (result_38 lst_68)
                                                                                      (if (not (wrap-null? lst_68))
                                                                                        (let-values (((v_54)
                                                                                                      (if (wrap-pair?
                                                                                                           lst_68)
                                                                                                        (wrap-car
                                                                                                         lst_68)
                                                                                                        lst_68))
                                                                                                     ((rest_41)
                                                                                                      (if (wrap-pair?
                                                                                                           lst_68)
                                                                                                        (wrap-cdr
                                                                                                         lst_68)
                                                                                                        null)))
                                                                                          (let-values (((result_39)
                                                                                                        (let-values ()
                                                                                                          (let-values (((result_40)
                                                                                                                        (let-values ()
                                                                                                                          (let-values ()
                                                                                                                            (let-values (((p_146)
                                                                                                                                          (unwrap
                                                                                                                                           v_54)))
                                                                                                                              (if (pair?
                                                                                                                                   p_146)
                                                                                                                                (if (let-values (((a_183)
                                                                                                                                                  (car
                                                                                                                                                   p_146)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_174)
                                                                                                                                                (cdr
                                                                                                                                                 p_146)))
                                                                                                                                    (let-values (((p_147)
                                                                                                                                                  (unwrap
                                                                                                                                                   d_174)))
                                                                                                                                      (if (pair?
                                                                                                                                           p_147)
                                                                                                                                        (if (let-values (((a_184)
                                                                                                                                                          (car
                                                                                                                                                           p_147)))
                                                                                                                                              #t)
                                                                                                                                          (let-values (((d_175)
                                                                                                                                                        (cdr
                                                                                                                                                         p_147)))
                                                                                                                                            (wrap-equal?
                                                                                                                                             '()
                                                                                                                                             d_175))
                                                                                                                                          #f)
                                                                                                                                        #f)))
                                                                                                                                  #f)
                                                                                                                                #f))))))
                                                                                                            (values
                                                                                                             result_40)))))
                                                                                            (if (if (not
                                                                                                     ((lambda x_16
                                                                                                        (not result_39))
                                                                                                      v_54))
                                                                                                  (not #f)
                                                                                                  #f)
                                                                                              (for-loop_31
                                                                                               result_39
                                                                                               rest_41)
                                                                                              result_39)))
                                                                                        result_38))))
                                                                     for-loop_31)
                                                                   #t
                                                                   lst_67)))
                                                              #f))
                                                        (let-values (((d_39) (cdr p_145))) (wrap-list? d_39))
                                                        #f)
                                                      #f)))
                                                #f)
                                              #f))
                                        (let-values (((idss_16 rhss_38 bodys_9)
                                                      (let-values (((d_109) (cdr (unwrap v_49))))
                                                        (let-values (((p_148) (unwrap d_109)))
                                                          (let-values (((idss_17 rhss_39)
                                                                        (let-values (((a_185) (car p_148)))
                                                                          (let-values (((idss_18 rhss_40)
                                                                                        (let-values (((lst_69) a_185))
                                                                                          (begin
                                                                                            (void)
                                                                                            ((letrec-values (((for-loop_32)
                                                                                                              (lambda (idss_19
                                                                                                                       rhss_41
                                                                                                                       lst_25)
                                                                                                                (if (not
                                                                                                                     (wrap-null?
                                                                                                                      lst_25))
                                                                                                                  (let-values (((v_55)
                                                                                                                                (if (wrap-pair?
                                                                                                                                     lst_25)
                                                                                                                                  (wrap-car
                                                                                                                                   lst_25)
                                                                                                                                  lst_25))
                                                                                                                               ((rest_12)
                                                                                                                                (if (wrap-pair?
                                                                                                                                     lst_25)
                                                                                                                                  (wrap-cdr
                                                                                                                                   lst_25)
                                                                                                                                  null)))
                                                                                                                    (let-values (((idss_20
                                                                                                                                   rhss_42)
                                                                                                                                  (let-values (((idss_21)
                                                                                                                                                idss_19)
                                                                                                                                               ((rhss_43)
                                                                                                                                                rhss_41))
                                                                                                                                    (let-values (((idss_22
                                                                                                                                                   rhss_44)
                                                                                                                                                  (let-values ()
                                                                                                                                                    (let-values (((idss5_0
                                                                                                                                                                   rhss6_1)
                                                                                                                                                                  (let-values ()
                                                                                                                                                                    (let-values (((p_101)
                                                                                                                                                                                  (unwrap
                                                                                                                                                                                   v_55)))
                                                                                                                                                                      (let-values (((idss_23)
                                                                                                                                                                                    (let-values (((a_186)
                                                                                                                                                                                                  (car
                                                                                                                                                                                                   p_101)))
                                                                                                                                                                                      a_186))
                                                                                                                                                                                   ((rhss_45)
                                                                                                                                                                                    (let-values (((d_176)
                                                                                                                                                                                                  (cdr
                                                                                                                                                                                                   p_101)))
                                                                                                                                                                                      (let-values (((a_187)
                                                                                                                                                                                                    (car
                                                                                                                                                                                                     (unwrap
                                                                                                                                                                                                      d_176))))
                                                                                                                                                                                        a_187))))
                                                                                                                                                                        (values
                                                                                                                                                                         idss_23
                                                                                                                                                                         rhss_45))))))
                                                                                                                                                      (values
                                                                                                                                                       (cons
                                                                                                                                                        idss5_0
                                                                                                                                                        idss_21)
                                                                                                                                                       (cons
                                                                                                                                                        rhss6_1
                                                                                                                                                        rhss_43))))))
                                                                                                                                      (values
                                                                                                                                       idss_22
                                                                                                                                       rhss_44)))))
                                                                                                                      (if (not
                                                                                                                           #f)
                                                                                                                        (for-loop_32
                                                                                                                         idss_20
                                                                                                                         rhss_42
                                                                                                                         rest_12)
                                                                                                                        (values
                                                                                                                         idss_20
                                                                                                                         rhss_42))))
                                                                                                                  (values
                                                                                                                   idss_19
                                                                                                                   rhss_41)))))
                                                                                               for-loop_32)
                                                                                             null
                                                                                             null
                                                                                             lst_69)))))
                                                                            (values
                                                                             (reverse$1 idss_18)
                                                                             (reverse$1 rhss_40)))))
                                                                       ((bodys_10)
                                                                        (let-values (((d_117) (cdr p_148)))
                                                                          (unwrap-list d_117))))
                                                            (values idss_17 rhss_39 bodys_10))))))
                                          (begin
                                            (let-values (((lst_70) idss_16))
                                              (begin
                                                (check-list lst_70)
                                                ((letrec-values (((for-loop_33)
                                                                  (lambda (lst_71)
                                                                    (if (pair? lst_71)
                                                                      (let-values (((ids_19) (unsafe-car lst_71))
                                                                                   ((rest_42) (unsafe-cdr lst_71)))
                                                                        (let-values ((()
                                                                                      (let-values (((lst_72) ids_19))
                                                                                        (begin
                                                                                          (void)
                                                                                          ((letrec-values (((for-loop_34)
                                                                                                            (lambda (lst_73)
                                                                                                              (if (not
                                                                                                                   (wrap-null?
                                                                                                                    lst_73))
                                                                                                                (let-values (((id_16)
                                                                                                                              (if (wrap-pair?
                                                                                                                                   lst_73)
                                                                                                                                (wrap-car
                                                                                                                                 lst_73)
                                                                                                                                lst_73))
                                                                                                                             ((rest_24)
                                                                                                                              (if (wrap-pair?
                                                                                                                                   lst_73)
                                                                                                                                (wrap-cdr
                                                                                                                                 lst_73)
                                                                                                                                null)))
                                                                                                                  (let-values ((()
                                                                                                                                (let-values ()
                                                                                                                                  (let-values ((()
                                                                                                                                                (let-values ()
                                                                                                                                                  (begin
                                                                                                                                                    (let-values ()
                                                                                                                                                      (hash-set!
                                                                                                                                                       mutated_4
                                                                                                                                                       (unwrap
                                                                                                                                                        id_16)
                                                                                                                                                       'not-ready))
                                                                                                                                                    (values)))))
                                                                                                                                    (values)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_34
                                                                                                                       rest_24)
                                                                                                                      (values))))
                                                                                                                (values)))))
                                                                                             for-loop_34)
                                                                                           lst_72)))))
                                                                          (if (not #f) (for-loop_33 rest_42) (values))))
                                                                      (values)))))
                                                   for-loop_33)
                                                 lst_70)))
                                            (void)
                                            (let-values (((lst_74) idss_16) ((lst_75) rhss_38))
                                              (begin
                                                (check-list lst_74)
                                                (check-list lst_75)
                                                ((letrec-values (((for-loop_35)
                                                                  (lambda (lst_76 lst_77)
                                                                    (if (if (pair? lst_76) (pair? lst_77) #f)
                                                                      (let-values (((ids_20) (unsafe-car lst_76))
                                                                                   ((rest_43) (unsafe-cdr lst_76))
                                                                                   ((rhs_25) (unsafe-car lst_77))
                                                                                   ((rest_44) (unsafe-cdr lst_77)))
                                                                        (let-values ((()
                                                                                      (let-values ()
                                                                                        (let-values ((()
                                                                                                      (let-values ()
                                                                                                        (begin
                                                                                                          (let-values ()
                                                                                                            (begin
                                                                                                              (find-mutated!_0
                                                                                                               rhs_25
                                                                                                               (unwrap-list
                                                                                                                ids_20))
                                                                                                              (let-values (((lst_78)
                                                                                                                            ids_20))
                                                                                                                (begin
                                                                                                                  (void)
                                                                                                                  ((letrec-values (((for-loop_36)
                                                                                                                                    (lambda (lst_79)
                                                                                                                                      (if (not
                                                                                                                                           (wrap-null?
                                                                                                                                            lst_79))
                                                                                                                                        (let-values (((id_17)
                                                                                                                                                      (if (wrap-pair?
                                                                                                                                                           lst_79)
                                                                                                                                                        (wrap-car
                                                                                                                                                         lst_79)
                                                                                                                                                        lst_79))
                                                                                                                                                     ((rest_45)
                                                                                                                                                      (if (wrap-pair?
                                                                                                                                                           lst_79)
                                                                                                                                                        (wrap-cdr
                                                                                                                                                         lst_79)
                                                                                                                                                        null)))
                                                                                                                                          (let-values ((()
                                                                                                                                                        (let-values ()
                                                                                                                                                          (let-values ((()
                                                                                                                                                                        (let-values ()
                                                                                                                                                                          (begin
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (let-values (((id_18)
                                                                                                                                                                                            (unwrap
                                                                                                                                                                                             id_17)))
                                                                                                                                                                                (if (eq?
                                                                                                                                                                                     'not-ready
                                                                                                                                                                                     (hash-ref
                                                                                                                                                                                      mutated_4
                                                                                                                                                                                      id_18))
                                                                                                                                                                                  (let-values ()
                                                                                                                                                                                    (hash-remove!
                                                                                                                                                                                     mutated_4
                                                                                                                                                                                     id_18))
                                                                                                                                                                                  (void))))
                                                                                                                                                                            (values)))))
                                                                                                                                                            (values)))))
                                                                                                                                            (if (not
                                                                                                                                                 #f)
                                                                                                                                              (for-loop_36
                                                                                                                                               rest_45)
                                                                                                                                              (values))))
                                                                                                                                        (values)))))
                                                                                                                     for-loop_36)
                                                                                                                   lst_78)))
                                                                                                              (void)))
                                                                                                          (values)))))
                                                                                          (values)))))
                                                                          (if (not #f)
                                                                            (for-loop_35 rest_43 rest_44)
                                                                            (values))))
                                                                      (values)))))
                                                   for-loop_35)
                                                 lst_74
                                                 lst_75)))
                                            (void)
                                            (find-mutated!*_0 bodys_9 ids_16)))
                                        (if (let-values (((p_149) (unwrap v_49)))
                                              (if (pair? p_149)
                                                (if (let-values (((a_188) (car p_149))) (wrap-equal? 'if a_188))
                                                  (let-values (((d_177) (cdr p_149)))
                                                    (let-values (((p_150) (unwrap d_177)))
                                                      (if (pair? p_150)
                                                        (if (let-values (((a_189) (car p_150))) #t)
                                                          (let-values (((d_178) (cdr p_150)))
                                                            (let-values (((p_151) (unwrap d_178)))
                                                              (if (pair? p_151)
                                                                (if (let-values (((a_190) (car p_151))) #t)
                                                                  (let-values (((d_179) (cdr p_151)))
                                                                    (let-values (((p_152) (unwrap d_179)))
                                                                      (if (pair? p_152)
                                                                        (if (let-values (((a_191) (car p_152))) #t)
                                                                          (let-values (((d_180) (cdr p_152)))
                                                                            (wrap-equal? '() d_180))
                                                                          #f)
                                                                        #f)))
                                                                  #f)
                                                                #f)))
                                                          #f)
                                                        #f)))
                                                  #f)
                                                #f))
                                          (let-values (((tst_0 thn_0 els_0)
                                                        (let-values (((d_181) (cdr (unwrap v_49))))
                                                          (let-values (((p_153) (unwrap d_181)))
                                                            (let-values (((tst_1)
                                                                          (let-values (((a_131) (car p_153))) a_131))
                                                                         ((thn_1 els_1)
                                                                          (let-values (((d_182) (cdr p_153)))
                                                                            (let-values (((p_154) (unwrap d_182)))
                                                                              (let-values (((thn_2)
                                                                                            (let-values (((a_192)
                                                                                                          (car p_154)))
                                                                                              a_192))
                                                                                           ((els_2)
                                                                                            (let-values (((d_128)
                                                                                                          (cdr p_154)))
                                                                                              (let-values (((a_193)
                                                                                                            (car
                                                                                                             (unwrap
                                                                                                              d_128))))
                                                                                                a_193))))
                                                                                (values thn_2 els_2))))))
                                                              (values tst_1 thn_1 els_1))))))
                                            (begin
                                              (find-mutated!_0 tst_0 #f)
                                              (find-mutated!_0 thn_0 #f)
                                              (find-mutated!_0 els_0 #f)))
                                          (if (let-values (((p_155) (unwrap v_49)))
                                                (if (pair? p_155)
                                                  (if (let-values (((a_194) (car p_155)))
                                                        (wrap-equal? 'with-continuation-mark a_194))
                                                    (let-values (((d_130) (cdr p_155)))
                                                      (let-values (((p_156) (unwrap d_130)))
                                                        (if (pair? p_156)
                                                          (if (let-values (((a_195) (car p_156))) #t)
                                                            (let-values (((d_183) (cdr p_156)))
                                                              (let-values (((p_157) (unwrap d_183)))
                                                                (if (pair? p_157)
                                                                  (if (let-values (((a_196) (car p_157))) #t)
                                                                    (let-values (((d_184) (cdr p_157)))
                                                                      (let-values (((p_158) (unwrap d_184)))
                                                                        (if (pair? p_158)
                                                                          (if (let-values (((a_197) (car p_158))) #t)
                                                                            (let-values (((d_185) (cdr p_158)))
                                                                              (wrap-equal? '() d_185))
                                                                            #f)
                                                                          #f)))
                                                                    #f)
                                                                  #f)))
                                                            #f)
                                                          #f)))
                                                    #f)
                                                  #f))
                                            (let-values (((key_1 val_1 body_10)
                                                          (let-values (((d_186) (cdr (unwrap v_49))))
                                                            (let-values (((p_159) (unwrap d_186)))
                                                              (let-values (((key_2)
                                                                            (let-values (((a_138) (car p_159))) a_138))
                                                                           ((val_2 body_19)
                                                                            (let-values (((d_187) (cdr p_159)))
                                                                              (let-values (((p_160) (unwrap d_187)))
                                                                                (let-values (((val_3)
                                                                                              (let-values (((a_141)
                                                                                                            (car
                                                                                                             p_160)))
                                                                                                a_141))
                                                                                             ((body_20)
                                                                                              (let-values (((d_188)
                                                                                                            (cdr
                                                                                                             p_160)))
                                                                                                (let-values (((a_198)
                                                                                                              (car
                                                                                                               (unwrap
                                                                                                                d_188))))
                                                                                                  a_198))))
                                                                                  (values val_3 body_20))))))
                                                                (values key_2 val_2 body_19))))))
                                              (begin
                                                (find-mutated!_0 key_1 #f)
                                                (find-mutated!_0 val_1 #f)
                                                (find-mutated!_0 body_10 ids_16)))
                                            (if (let-values (((p_161) (unwrap v_49)))
                                                  (if (pair? p_161)
                                                    (if (let-values (((a_199) (car p_161))) (wrap-equal? 'begin a_199))
                                                      (let-values (((d_189) (cdr p_161))) (wrap-list? d_189))
                                                      #f)
                                                    #f))
                                              (let-values (((exps_0)
                                                            (let-values (((d_190) (cdr (unwrap v_49))))
                                                              (unwrap-list d_190))))
                                                (find-mutated!*_0 exps_0 ids_16))
                                              (if (let-values (((p_162) (unwrap v_49)))
                                                    (if (pair? p_162)
                                                      (if (let-values (((a_200) (car p_162)))
                                                            (wrap-equal? 'begin0 a_200))
                                                        (let-values (((d_191) (cdr p_162)))
                                                          (let-values (((p_121) (unwrap d_191)))
                                                            (if (pair? p_121)
                                                              (if (let-values (((a_146) (car p_121))) #t)
                                                                (let-values (((d_137) (cdr p_121))) (wrap-list? d_137))
                                                                #f)
                                                              #f)))
                                                        #f)
                                                      #f))
                                                (let-values (((exp_0 exps_1)
                                                              (let-values (((d_192) (cdr (unwrap v_49))))
                                                                (let-values (((p_163) (unwrap d_192)))
                                                                  (let-values (((exp_1)
                                                                                (let-values (((a_201) (car p_163)))
                                                                                  a_201))
                                                                               ((exps_2)
                                                                                (let-values (((d_193) (cdr p_163)))
                                                                                  (unwrap-list d_193))))
                                                                    (values exp_1 exps_2))))))
                                                  (begin (find-mutated!_0 exp_0 ids_16) (find-mutated!*_0 exps_1 #f)))
                                                (if (let-values (((p_164) (unwrap v_49)))
                                                      (if (pair? p_164)
                                                        (if (let-values (((a_202) (car p_164)))
                                                              (wrap-equal? 'set! a_202))
                                                          (let-values (((d_194) (cdr p_164)))
                                                            (let-values (((p_165) (unwrap d_194)))
                                                              (if (pair? p_165)
                                                                (if (let-values (((a_203) (car p_165))) #t)
                                                                  (let-values (((d_195) (cdr p_165)))
                                                                    (let-values (((p_166) (unwrap d_195)))
                                                                      (if (pair? p_166)
                                                                        (if (let-values (((a_204) (car p_166))) #t)
                                                                          (let-values (((d_196) (cdr p_166)))
                                                                            (wrap-equal? '() d_196))
                                                                          #f)
                                                                        #f)))
                                                                  #f)
                                                                #f)))
                                                          #f)
                                                        #f))
                                                  (let-values (((id_19 rhs_26)
                                                                (let-values (((d_197) (cdr (unwrap v_49))))
                                                                  (let-values (((p_167) (unwrap d_197)))
                                                                    (let-values (((id_20)
                                                                                  (let-values (((a_152) (car p_167)))
                                                                                    a_152))
                                                                                 ((rhs_27)
                                                                                  (let-values (((d_144) (cdr p_167)))
                                                                                    (let-values (((a_153)
                                                                                                  (car (unwrap d_144))))
                                                                                      a_153))))
                                                                      (values id_20 rhs_27))))))
                                                    (begin
                                                      (hash-set! mutated_4 id_19 'set!ed)
                                                      (find-mutated!_0 rhs_26 #f)))
                                                  (if (let-values (((p_168) (unwrap v_49)))
                                                        (if (pair? p_168)
                                                          (if (let-values (((a_154) (car p_168)))
                                                                (wrap-equal? '#%variable-reference a_154))
                                                            (let-values (((d_198) (cdr p_168))) #t)
                                                            #f)
                                                          #f))
                                                    (let-values () (void))
                                                    (if (let-values (((p_126) (unwrap v_49)))
                                                          (if (pair? p_126)
                                                            (if (let-values (((a_155) (car p_126))) #t)
                                                              (let-values (((d_146) (cdr p_126))) (wrap-list? d_146))
                                                              #f)
                                                            #f))
                                                      (let-values (((rator_0 exps_3)
                                                                    (let-values (((p_169) (unwrap v_49)))
                                                                      (let-values (((rator_1)
                                                                                    (let-values (((a_205) (car p_169)))
                                                                                      a_205))
                                                                                   ((exps_4)
                                                                                    (let-values (((d_199) (cdr p_169)))
                                                                                      (unwrap-list d_199))))
                                                                        (values rator_1 exps_4)))))
                                                        (if (if ids_16
                                                              (if (symbol? rator_0)
                                                                (if (not (hash-ref mutated_4 rator_0 #f))
                                                                  (if (let-values (((v_56)
                                                                                    (hash-ref-either
                                                                                     knowns_18
                                                                                     imports_5
                                                                                     rator_0)))
                                                                        (if (known-constructor? v_56)
                                                                          (=
                                                                           (length exps_3)
                                                                           (known-constructor-field-count v_56))
                                                                          #f))
                                                                    (let-values (((lst_80) exps_3))
                                                                      (begin
                                                                        (check-list lst_80)
                                                                        ((letrec-values (((for-loop_37)
                                                                                          (lambda (result_41 lst_81)
                                                                                            (if (pair? lst_81)
                                                                                              (let-values (((exp_2)
                                                                                                            (unsafe-car
                                                                                                             lst_81))
                                                                                                           ((rest_46)
                                                                                                            (unsafe-cdr
                                                                                                             lst_81)))
                                                                                                (let-values (((result_42)
                                                                                                              (let-values ()
                                                                                                                (let-values (((result_43)
                                                                                                                              (let-values ()
                                                                                                                                (let-values ()
                                                                                                                                  (simple?
                                                                                                                                   exp_2
                                                                                                                                   prim-knowns_4
                                                                                                                                   knowns_18
                                                                                                                                   imports_5
                                                                                                                                   mutated_4)))))
                                                                                                                  (values
                                                                                                                   result_43)))))
                                                                                                  (if (if (not
                                                                                                           ((lambda x_17
                                                                                                              (not
                                                                                                               result_42))
                                                                                                            exp_2))
                                                                                                        (not #f)
                                                                                                        #f)
                                                                                                    (for-loop_37
                                                                                                     result_42
                                                                                                     rest_46)
                                                                                                    result_42)))
                                                                                              result_41))))
                                                                           for-loop_37)
                                                                         #t
                                                                         lst_80)))
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
                                                        (if (symbol? v_48)
                                                          (let-values ()
                                                            (let-values (((state_1) (hash-ref mutated_4 v_48 #f)))
                                                              (if (not-ready-mutated-state? state_1)
                                                                (let-values () (hash-set! mutated_4 v_48 'too-early))
                                                                (if (delayed-mutated-state? state_1)
                                                                  (let-values ()
                                                                    (if ids_16
                                                                      (let-values ()
                                                                        (delay!_0
                                                                         ids_16
                                                                         (lambda ()
                                                                           (begin
                                                                             (hash-remove! mutated_4 v_48)
                                                                             (state_1)))))
                                                                      (let-values ()
                                                                        (begin
                                                                          (hash-remove! mutated_4 v_48)
                                                                          (state_1)))))
                                                                  (void)))))
                                                          (void))))))))))))))))))))
         find-mutated!_0)
       v_47
       ids_14))))
 (define-values
  (left-to-right/let)
  (lambda (ids_21 rhss_46 bodys_11 unannotate_0 prim-knowns_5 knowns_19 imports_6 mutated_5)
    (if (null? (cdr ids_21))
      (let-values () (list* 'let (list (list (car ids_21) (car rhss_46))) bodys_11))
      (let-values ()
        ((letrec-values (((loop_4)
                          (lambda (ids_22 rhss_47 binds_0)
                            (if (null? (cdr rhss_47))
                              (let-values ()
                                (if (null? binds_0)
                                  (list* 'let (list (list (car ids_22) (car rhss_47))) bodys_11)
                                  (list 'let (list (list (car ids_22) (car rhss_47))) (list* 'let binds_0 bodys_11))))
                              (if (simple? (unannotate_0 (car rhss_47)) prim-knowns_5 knowns_19 imports_6 mutated_5)
                                (let-values ()
                                  (list
                                   'let
                                   (list (list (car ids_22) (car rhss_47)))
                                   (loop_4 (cdr ids_22) (cdr rhss_47) binds_0)))
                                (let-values ()
                                  (let-values (((id_21) (car ids_22)))
                                    (list
                                     'let
                                     (list (list id_21 (car rhss_47)))
                                     (loop_4 (cdr ids_22) (cdr rhss_47) (cons (list id_21 id_21) binds_0))))))))))
           loop_4)
         ids_21
         rhss_46
         null)))))
 (define-values
  (left-to-right/let-values)
  (lambda (idss_24 rhss_48 bodys_12 mutated_6)
    (if (null? (cdr idss_24))
      (let-values () (make-let-values (car idss_24) (car rhss_48) (list* 'begin bodys_12)))
      (let-values ()
        ((letrec-values (((loop_5)
                          (lambda (idss_25 rhss_49 binds_1)
                            (if (null? (cdr rhss_49))
                              (let-values ()
                                (make-let-values (car idss_25) (car rhss_49) (list* 'let binds_1 bodys_12)))
                              (let-values ()
                                (let-values (((ids_23) (car idss_25)))
                                  (make-let-values
                                   ids_23
                                   (car rhss_49)
                                   (loop_5
                                    (cdr idss_25)
                                    (cdr rhss_49)
                                    (append
                                     (let-values (((lst_82) ids_23))
                                       (begin
                                         (void)
                                         ((letrec-values (((for-loop_38)
                                                           (lambda (lst_83)
                                                             (if (not (wrap-null? lst_83))
                                                               (let-values (((id_22)
                                                                             (if (wrap-pair? lst_83)
                                                                               (wrap-car lst_83)
                                                                               lst_83))
                                                                            ((rest_47)
                                                                             (if (wrap-pair? lst_83)
                                                                               (wrap-cdr lst_83)
                                                                               null)))
                                                                 (let-values (((post-guard-var_0) (lambda () #t)))
                                                                   (let-values ()
                                                                     (let-values (((elem_0)
                                                                                   (let-values ()
                                                                                     (let-values ()
                                                                                       (list id_22 id_22)))))
                                                                       (let-values (((result_44)
                                                                                     (if (post-guard-var_0)
                                                                                       (for-loop_38 rest_47)
                                                                                       null)))
                                                                         (cons elem_0 result_44))))))
                                                               null))))
                                            for-loop_38)
                                          lst_82)))
                                     binds_1)))))))))
           loop_5)
         idss_24
         rhss_48
         null)))))
 (define-values
  (left-to-right/app)
  (lambda (rator_2 rands_0 plain-app?_0 unannotate_1 prim-knowns_6 knowns_20 imports_7 mutated_7)
    ((letrec-values (((loop_6)
                      (lambda (l_8 accum_0 pending-non-simple_0 pending-id_0)
                        (if (null? l_8)
                          (let-values ()
                            (let-values (((app_0)
                                          (if pending-non-simple_0
                                            (let-values ()
                                              ((letrec-values (((loop_7)
                                                                (lambda (accum_1 rev-accum_0)
                                                                  (if (null? accum_1)
                                                                    (let-values () rev-accum_0)
                                                                    (if (eq? (car accum_1) pending-id_0)
                                                                      (let-values ()
                                                                        (loop_7
                                                                         (cdr accum_1)
                                                                         (cons pending-non-simple_0 rev-accum_0)))
                                                                      (let-values ()
                                                                        (loop_7
                                                                         (cdr accum_1)
                                                                         (cons (car accum_1) rev-accum_0))))))))
                                                 loop_7)
                                               accum_0
                                               null))
                                            (let-values () (reverse$1 accum_0)))))
                              (if plain-app?_0 app_0 (list* '#%app app_0))))
                          (if (simple? (unannotate_1 (car l_8)) prim-knowns_6 knowns_20 imports_7 mutated_7)
                            (let-values ()
                              (loop_6 (cdr l_8) (cons (car l_8) accum_0) pending-non-simple_0 pending-id_0))
                            (if pending-non-simple_0
                              (let-values ()
                                (list 'let (list (list pending-id_0 pending-non-simple_0)) (loop_6 l_8 accum_0 #f #f)))
                              (let-values ()
                                (let-values (((g_0) (gensym "app_")))
                                  (loop_6 (cdr l_8) (cons g_0 accum_0) (car l_8) g_0)))))))))
       loop_6)
     (cons rator_2 rands_0)
     null
     #f
     #f)))
 (define-values
  (make-let-values)
  (lambda (ids_24 rhs_28 body_1)
    (if (if (pair? ids_24) (null? (cdr ids_24)) #f)
      (let-values () (list 'let (list (list (car ids_24) rhs_28)) body_1))
      (let-values ()
        (let-values (((v_57) (if (null? ids_24) rhs_28 #f)))
          (if (let-values (((p_67) (unwrap v_57)))
                (if (pair? p_67)
                  (if (let-values (((a_83) (car p_67))) (wrap-equal? 'begin a_83))
                    (let-values (((d_200) (cdr p_67)))
                      (let-values (((p_170) (unwrap d_200)))
                        (if (pair? p_170)
                          (if (let-values (((a_206) (car p_170))) #t)
                            (let-values (((d_201) (cdr p_170)))
                              (let-values (((p_171) (unwrap d_201)))
                                (if (pair? p_171)
                                  (if (let-values (((a_207) (car p_171)))
                                        (let-values (((p_69) (unwrap a_207)))
                                          (if (pair? p_69)
                                            (if (let-values (((a_85) (car p_69))) (wrap-equal? 'values a_85))
                                              (let-values (((d_44) (cdr p_69))) (wrap-equal? '() d_44))
                                              #f)
                                            #f)))
                                    (let-values (((d_10) (cdr p_171))) (wrap-equal? '() d_10))
                                    #f)
                                  #f)))
                            #f)
                          #f)))
                    #f)
                  #f))
            (let-values (((rhs_29)
                          (let-values (((d_11) (cdr (unwrap v_57)))) (let-values (((a_15) (car (unwrap d_11)))) a_15))))
              (list 'begin rhs_29 body_1))
            (let-values ()
              (list
               'call-with-values
               (list 'lambda '() rhs_28)
               (list
                'case-lambda
                (list ids_24 body_1)
                (list 'args (list* 'raise-result-arity-error (list 'quote ids_24) '(args))))))))))))
 (define-values
  (schemify-linklet)
  (lambda (lk_0 annotate_0 unannotate_2 prim-knowns_7 get-import-knowns_0)
    (let-values (((im-int-id_0) (lambda (id_9) (unwrap (if (pair? id_9) (cadr id_9) id_9)))))
      (let-values (((im-ext-id_0) (lambda (id_23) (unwrap (if (pair? id_23) (car id_23) id_23)))))
        (let-values (((ex-int-id_0) (lambda (id_24) (unwrap (if (pair? id_24) (car id_24) id_24)))))
          (let-values (((ex-ext-id_0) (lambda (id_21) (unwrap (if (pair? id_21) (cadr id_21) id_21)))))
            (let-values (((v_58) lk_0))
              (if (let-values (((p_2) (unwrap v_58)))
                    (if (pair? p_2)
                      (if (let-values (((a_7) (car p_2))) (wrap-equal? 'linklet a_7))
                        (let-values (((d_2) (cdr p_2)))
                          (let-values (((p_3) (unwrap d_2)))
                            (if (pair? p_3)
                              (if (let-values (((a_8) (car p_3))) #t)
                                (let-values (((d_3) (cdr p_3)))
                                  (let-values (((p_4) (unwrap d_3)))
                                    (if (pair? p_4)
                                      (if (let-values (((a_9) (car p_4))) #t) (let-values (((d_4) (cdr p_4))) #t) #f)
                                      #f)))
                                #f)
                              #f)))
                        #f)
                      #f))
                (let-values (((im-idss_0 ex-ids_0 bodys_13)
                              (let-values (((d_70) (cdr (unwrap v_58))))
                                (let-values (((p_172) (unwrap d_70)))
                                  (let-values (((im-idss_1) (let-values (((a_166) (car p_172))) a_166))
                                               ((ex-ids_1 bodys_14)
                                                (let-values (((d_160) (cdr p_172)))
                                                  (let-values (((p_61) (unwrap d_160)))
                                                    (let-values (((ex-ids_2) (let-values (((a_208) (car p_61))) a_208))
                                                                 ((bodys_15) (let-values (((d_202) (cdr p_61))) d_202)))
                                                      (values ex-ids_2 bodys_15))))))
                                    (values im-idss_1 ex-ids_1 bodys_14))))))
                  (let-values (((imports_8)
                                (let-values (((lst_84) im-idss_0) ((start_1) 0))
                                  (begin
                                    (check-list lst_84)
                                    (check-naturals start_1)
                                    ((letrec-values (((for-loop_39)
                                                      (lambda (imports_9 lst_85 pos_2)
                                                        (if (if (pair? lst_85) #t #f)
                                                          (let-values (((im-ids_0) (unsafe-car lst_85))
                                                                       ((rest_48) (unsafe-cdr lst_85))
                                                                       ((index_0) pos_2))
                                                            (let-values (((imports_10)
                                                                          (let-values (((imports_11) imports_9))
                                                                            (let-values (((imports_12)
                                                                                          (let-values ()
                                                                                            (let-values (((grp_1)
                                                                                                          (import-group2.1
                                                                                                           (lambda ()
                                                                                                             (get-import-knowns_0
                                                                                                              index_0)))))
                                                                                              (let-values (((lst_3)
                                                                                                            im-ids_0))
                                                                                                (begin
                                                                                                  (check-list lst_3)
                                                                                                  ((letrec-values (((for-loop_40)
                                                                                                                    (lambda (imports_13
                                                                                                                             lst_86)
                                                                                                                      (if (pair?
                                                                                                                           lst_86)
                                                                                                                        (let-values (((im-id_0)
                                                                                                                                      (unsafe-car
                                                                                                                                       lst_86))
                                                                                                                                     ((rest_49)
                                                                                                                                      (unsafe-cdr
                                                                                                                                       lst_86)))
                                                                                                                          (let-values (((imports_14)
                                                                                                                                        (let-values (((imports_15)
                                                                                                                                                      imports_13))
                                                                                                                                          (let-values (((imports_16)
                                                                                                                                                        (let-values ()
                                                                                                                                                          (let-values (((id_25)
                                                                                                                                                                        (im-int-id_0
                                                                                                                                                                         im-id_0)))
                                                                                                                                                            (let-values (((ext-id_0)
                                                                                                                                                                          (im-ext-id_0
                                                                                                                                                                           im-id_0)))
                                                                                                                                                              (hash-set
                                                                                                                                                               imports_15
                                                                                                                                                               id_25
                                                                                                                                                               (import1.1
                                                                                                                                                                grp_1
                                                                                                                                                                (gensym
                                                                                                                                                                 (symbol->string
                                                                                                                                                                  id_25))
                                                                                                                                                                ext-id_0)))))))
                                                                                                                                            (values
                                                                                                                                             imports_16)))))
                                                                                                                            (if (not
                                                                                                                                 #f)
                                                                                                                              (for-loop_40
                                                                                                                               imports_14
                                                                                                                               rest_49)
                                                                                                                              imports_14)))
                                                                                                                        imports_13))))
                                                                                                     for-loop_40)
                                                                                                   imports_11
                                                                                                   lst_3)))))))
                                                                              (values imports_12)))))
                                                              (if (not #f)
                                                                (for-loop_39 imports_10 rest_48 (+ pos_2 1))
                                                                imports_10)))
                                                          imports_9))))
                                       for-loop_39)
                                     (hasheq)
                                     lst_84
                                     start_1)))))
                    (let-values (((exports_1)
                                  (let-values (((lst_4) ex-ids_0))
                                    (begin
                                      (check-list lst_4)
                                      ((letrec-values (((for-loop_2)
                                                        (lambda (exports_2 lst_5)
                                                          (if (pair? lst_5)
                                                            (let-values (((ex-id_0) (unsafe-car lst_5))
                                                                         ((rest_2) (unsafe-cdr lst_5)))
                                                              (let-values (((exports_3)
                                                                            (let-values (((exports_4) exports_2))
                                                                              (let-values (((exports_5)
                                                                                            (let-values ()
                                                                                              (let-values (((id_26)
                                                                                                            (ex-int-id_0
                                                                                                             ex-id_0)))
                                                                                                (hash-set
                                                                                                 exports_4
                                                                                                 id_26
                                                                                                 (gensym
                                                                                                  (symbol->string
                                                                                                   id_26)))))))
                                                                                (values exports_5)))))
                                                                (if (not #f) (for-loop_2 exports_3 rest_2) exports_3)))
                                                            exports_2))))
                                         for-loop_2)
                                       (hasheq)
                                       lst_4)))))
                      (let-values (((new-body_0 defn-info_0 mutated_8)
                                    (schemify-body*
                                     bodys_13
                                     annotate_0
                                     unannotate_2
                                     prim-knowns_7
                                     imports_8
                                     exports_1)))
                        (values
                         (list*
                          'lambda
                          (list*
                           'instance-variable-reference
                           (qq-append
                            (let-values (((lst_46) im-idss_0))
                              (begin
                                (check-list lst_46)
                                ((letrec-values (((for-loop_22)
                                                  (lambda (lst_47)
                                                    (if (pair? lst_47)
                                                      (let-values (((im-ids_1) (unsafe-car lst_47))
                                                                   ((rest_29) (unsafe-cdr lst_47)))
                                                        (let-values (((post-guard-var_1) (lambda () #t)))
                                                          (let-values (((lst_87) im-ids_1))
                                                            (begin
                                                              (check-list lst_87)
                                                              ((letrec-values (((for-loop_41)
                                                                                (lambda (lst_7)
                                                                                  (if (pair? lst_7)
                                                                                    (let-values (((im-id_1)
                                                                                                  (unsafe-car lst_7))
                                                                                                 ((rest_3)
                                                                                                  (unsafe-cdr lst_7)))
                                                                                      (let-values (((post-guard-var_2)
                                                                                                    (lambda () #t)))
                                                                                        (let-values ()
                                                                                          (let-values (((elem_1)
                                                                                                        (let-values ()
                                                                                                          (let-values ()
                                                                                                            (import-id
                                                                                                             (hash-ref
                                                                                                              imports_8
                                                                                                              (im-int-id_0
                                                                                                               im-id_1)))))))
                                                                                            (let-values (((result_8)
                                                                                                          (if (post-guard-var_2)
                                                                                                            (for-loop_41
                                                                                                             rest_3)
                                                                                                            (if (post-guard-var_1)
                                                                                                              (for-loop_22
                                                                                                               rest_29)
                                                                                                              null))))
                                                                                              (cons
                                                                                               elem_1
                                                                                               result_8))))))
                                                                                    (if (post-guard-var_1)
                                                                                      (for-loop_22 rest_29)
                                                                                      null)))))
                                                                 for-loop_41)
                                                               lst_87)))))
                                                      null))))
                                   for-loop_22)
                                 lst_46)))
                            (let-values (((lst_88) ex-ids_0))
                              (begin
                                (check-list lst_88)
                                ((letrec-values (((for-loop_42)
                                                  (lambda (lst_89)
                                                    (if (pair? lst_89)
                                                      (let-values (((ex-id_1) (unsafe-car lst_89))
                                                                   ((rest_50) (unsafe-cdr lst_89)))
                                                        (let-values (((post-guard-var_3) (lambda () #t)))
                                                          (let-values ()
                                                            (let-values (((elem_2)
                                                                          (let-values ()
                                                                            (let-values ()
                                                                              (hash-ref
                                                                               exports_1
                                                                               (ex-int-id_0 ex-id_1))))))
                                                              (let-values (((result_45)
                                                                            (if (post-guard-var_3)
                                                                              (for-loop_42 rest_50)
                                                                              null)))
                                                                (cons elem_2 result_45))))))
                                                      null))))
                                   for-loop_42)
                                 lst_88)))))
                          new-body_0)
                         (let-values (((lst_90) im-idss_0))
                           (begin
                             (check-list lst_90)
                             ((letrec-values (((for-loop_43)
                                               (lambda (lst_91)
                                                 (if (pair? lst_91)
                                                   (let-values (((im-ids_2) (unsafe-car lst_91))
                                                                ((rest_51) (unsafe-cdr lst_91)))
                                                     (let-values (((post-guard-var_4) (lambda () #t)))
                                                       (let-values ()
                                                         (let-values (((elem_3)
                                                                       (let-values ()
                                                                         (let-values ()
                                                                           (let-values (((im-knowns_0)
                                                                                         (if (pair? (unwrap im-ids_2))
                                                                                           (let-values (((k/t_0)
                                                                                                         (import-group-knowns/thunk
                                                                                                          (import-grp
                                                                                                           (hash-ref
                                                                                                            imports_8
                                                                                                            (im-int-id_0
                                                                                                             (wrap-car
                                                                                                              im-ids_2)))))))
                                                                                             (if (procedure? k/t_0)
                                                                                               #f
                                                                                               k/t_0))
                                                                                           #f)))
                                                                             (let-values (((lst_50) im-ids_2))
                                                                               (begin
                                                                                 (check-list lst_50)
                                                                                 ((letrec-values (((for-loop_44)
                                                                                                   (lambda (lst_8)
                                                                                                     (if (pair? lst_8)
                                                                                                       (let-values (((im-id_2)
                                                                                                                     (unsafe-car
                                                                                                                      lst_8))
                                                                                                                    ((rest_52)
                                                                                                                     (unsafe-cdr
                                                                                                                      lst_8)))
                                                                                                         (let-values (((post-guard-var_5)
                                                                                                                       (lambda ()
                                                                                                                         #t)))
                                                                                                           (let-values ()
                                                                                                             (let-values (((elem_4)
                                                                                                                           (let-values ()
                                                                                                                             (let-values ()
                                                                                                                               (if im-knowns_0
                                                                                                                                 (known-constant?
                                                                                                                                  (hash-ref
                                                                                                                                   im-knowns_0
                                                                                                                                   (im-ext-id_0
                                                                                                                                    im-id_2)
                                                                                                                                   #f))
                                                                                                                                 #f)))))
                                                                                                               (let-values (((result_46)
                                                                                                                             (if (post-guard-var_5)
                                                                                                                               (for-loop_44
                                                                                                                                rest_52)
                                                                                                                               null)))
                                                                                                                 (cons
                                                                                                                  elem_4
                                                                                                                  result_46))))))
                                                                                                       null))))
                                                                                    for-loop_44)
                                                                                  lst_50))))))))
                                                           (let-values (((result_47)
                                                                         (if (post-guard-var_4)
                                                                           (for-loop_43 rest_51)
                                                                           null)))
                                                             (cons elem_3 result_47))))))
                                                   null))))
                                for-loop_43)
                              lst_90)))
                         (let-values (((lst_92) ex-ids_0))
                           (begin
                             (check-list lst_92)
                             ((letrec-values (((for-loop_45)
                                               (lambda (knowns_21 lst_93)
                                                 (if (pair? lst_93)
                                                   (let-values (((ex-id_2) (unsafe-car lst_93))
                                                                ((rest_53) (unsafe-cdr lst_93)))
                                                     (let-values (((knowns_22)
                                                                   (let-values (((knowns_23) knowns_21))
                                                                     (let-values (((knowns_24)
                                                                                   (let-values ()
                                                                                     (let-values (((id_14)
                                                                                                   (ex-int-id_0
                                                                                                    ex-id_2)))
                                                                                       (let-values (((v_59)
                                                                                                     (hash-ref
                                                                                                      defn-info_0
                                                                                                      id_14
                                                                                                      #f)))
                                                                                         (if (if v_59
                                                                                               (not
                                                                                                (set!ed-mutated-state?
                                                                                                 (hash-ref
                                                                                                  mutated_8
                                                                                                  id_14
                                                                                                  #f)))
                                                                                               #f)
                                                                                           (let-values ()
                                                                                             (let-values (((ext-id_1)
                                                                                                           (ex-ext-id_0
                                                                                                            ex-id_2)))
                                                                                               (hash-set
                                                                                                knowns_23
                                                                                                ext-id_1
                                                                                                v_59)))
                                                                                           (let-values ()
                                                                                             knowns_23)))))))
                                                                       (values knowns_24)))))
                                                       (if (not #f) (for-loop_45 knowns_22 rest_53) knowns_22)))
                                                   knowns_21))))
                                for-loop_45)
                              (hasheq)
                              lst_92))))))))
                (error 'match "failed ~e" v_58)))))))))
 (define-values
  (schemify-body)
  (lambda (l_9 annotate_1 unannotate_3 prim-knowns_8 imports_17 exports_6)
    (let-values (((new-body_1 defn-info_1 mutated_9)
                  (schemify-body* l_9 annotate_1 unannotate_3 prim-knowns_8 imports_17 exports_6)))
      new-body_1)))
 (define-values
  (schemify-body*)
  (lambda (l_10 annotate_2 unannotate_4 prim-knowns_9 imports_18 exports_7)
    (let-values (((mutated_10) (mutated-in-body l_10 exports_7 prim-knowns_9 (hasheq) imports_18)))
      (let-values (((knowns_25)
                    (let-values (((lst_94) l_10))
                      (begin
                        (check-list lst_94)
                        ((letrec-values (((for-loop_46)
                                          (lambda (knowns_26 lst_95)
                                            (if (pair? lst_95)
                                              (let-values (((form_3) (unsafe-car lst_95))
                                                           ((rest_54) (unsafe-cdr lst_95)))
                                                (let-values (((knowns_27)
                                                              (let-values (((knowns_28) knowns_26))
                                                                (let-values (((knowns_29)
                                                                              (let-values ()
                                                                                (let-values (((new-knowns_0 info_3)
                                                                                              (find-definitions
                                                                                               form_3
                                                                                               prim-knowns_9
                                                                                               knowns_28
                                                                                               imports_18
                                                                                               mutated_10)))
                                                                                  new-knowns_0))))
                                                                  (values knowns_29)))))
                                                  (if (not #f) (for-loop_46 knowns_27 rest_54) knowns_27)))
                                              knowns_26))))
                           for-loop_46)
                         (hasheq)
                         lst_94)))))
        (let-values (((schemified_0)
                      ((letrec-values (((loop_8)
                                        (lambda (l_11 accum-exprs_0 accum-ids_0)
                                          (if (null? l_11)
                                            (let-values ()
                                              (let-values (((set-vars_0)
                                                            (let-values (((lst_96) accum-ids_0))
                                                              (begin
                                                                (check-list lst_96)
                                                                ((letrec-values (((for-loop_47)
                                                                                  (lambda (lst_97)
                                                                                    (if (pair? lst_97)
                                                                                      (let-values (((id_27)
                                                                                                    (unsafe-car lst_97))
                                                                                                   ((rest_55)
                                                                                                    (unsafe-cdr
                                                                                                     lst_97)))
                                                                                        (let-values (((post-guard-var_6)
                                                                                                      (lambda () #t)))
                                                                                          (let-values ()
                                                                                            (if (hash-ref
                                                                                                 exports_7
                                                                                                 id_27
                                                                                                 #f)
                                                                                              (let-values ()
                                                                                                (let-values (((elem_5)
                                                                                                              (let-values ()
                                                                                                                (let-values ()
                                                                                                                  (make-set-variable
                                                                                                                   id_27
                                                                                                                   exports_7)))))
                                                                                                  (let-values (((result_48)
                                                                                                                (if (post-guard-var_6)
                                                                                                                  (for-loop_47
                                                                                                                   rest_55)
                                                                                                                  null)))
                                                                                                    (cons
                                                                                                     elem_5
                                                                                                     result_48))))
                                                                                              (if (post-guard-var_6)
                                                                                                (for-loop_47 rest_55)
                                                                                                null)))))
                                                                                      null))))
                                                                   for-loop_47)
                                                                 lst_96)))))
                                                (if (null? set-vars_0)
                                                  (let-values ()
                                                    (if (null? accum-exprs_0)
                                                      (let-values () '((void)))
                                                      (let-values () (reverse$1 accum-exprs_0))))
                                                  (let-values () (append (make-expr-defns accum-exprs_0) set-vars_0)))))
                                            (let-values ()
                                              (let-values (((form_4) (car l_11)))
                                                (let-values (((schemified_1)
                                                              (schemify
                                                               form_4
                                                               annotate_2
                                                               unannotate_4
                                                               prim-knowns_9
                                                               knowns_25
                                                               mutated_10
                                                               imports_18
                                                               exports_7)))
                                                  (let-values (((v_60) form_4))
                                                    (if (let-values (((p_173) (unwrap v_60)))
                                                          (if (pair? p_173)
                                                            (if (let-values (((a_209) (car p_173)))
                                                                  (wrap-equal? 'define-values a_209))
                                                              (let-values (((d_203) (cdr p_173)))
                                                                (let-values (((p_174) (unwrap d_203)))
                                                                  (if (pair? p_174)
                                                                    (if (let-values (((a_210) (car p_174))) #t)
                                                                      (let-values (((d_204) (cdr p_174)))
                                                                        (let-values (((p_175) (unwrap d_204)))
                                                                          (if (pair? p_175)
                                                                            (if (let-values (((a_211) (car p_175))) #t)
                                                                              (let-values (((d_205) (cdr p_175)))
                                                                                (wrap-equal? '() d_205))
                                                                              #f)
                                                                            #f)))
                                                                      #f)
                                                                    #f)))
                                                              #f)
                                                            #f))
                                                      (let-values (((ids_25)
                                                                    (let-values (((d_90) (cdr (unwrap v_60))))
                                                                      (let-values (((a_212) (car (unwrap d_90))))
                                                                        a_212))))
                                                        (append
                                                         (make-expr-defns accum-exprs_0)
                                                         (cons
                                                          schemified_1
                                                          ((letrec-values (((id-loop_0)
                                                                            (lambda (ids_26 accum-exprs_1 accum-ids_1)
                                                                              (if (wrap-null? ids_26)
                                                                                (let-values ()
                                                                                  (loop_8
                                                                                   (wrap-cdr l_11)
                                                                                   accum-exprs_1
                                                                                   accum-ids_1))
                                                                                (if (via-variable-mutated-state?
                                                                                     (hash-ref
                                                                                      mutated_10
                                                                                      (unwrap (wrap-car ids_26))
                                                                                      #f))
                                                                                  (let-values ()
                                                                                    (let-values (((id_28)
                                                                                                  (unwrap
                                                                                                   (wrap-car ids_26))))
                                                                                      (if (hash-ref exports_7 id_28 #f)
                                                                                        (let-values ()
                                                                                          (id-loop_0
                                                                                           (wrap-cdr ids_26)
                                                                                           (cons
                                                                                            (make-set-variable
                                                                                             id_28
                                                                                             exports_7)
                                                                                            accum-exprs_1)
                                                                                           accum-ids_1))
                                                                                        (let-values ()
                                                                                          (id-loop_0
                                                                                           (wrap-cdr ids_26)
                                                                                           accum-exprs_1
                                                                                           accum-ids_1)))))
                                                                                  (let-values ()
                                                                                    (id-loop_0
                                                                                     (wrap-cdr ids_26)
                                                                                     accum-exprs_1
                                                                                     (cons
                                                                                      (unwrap (wrap-car ids_26))
                                                                                      accum-ids_1))))))))
                                                             id-loop_0)
                                                           ids_25
                                                           null
                                                           accum-ids_0))))
                                                      (let-values ()
                                                        (loop_8
                                                         (wrap-cdr l_11)
                                                         (cons schemified_1 accum-exprs_0)
                                                         accum-ids_0)))))))))))
                         loop_8)
                       l_10
                       null
                       null)))
          (values schemified_0 knowns_25 mutated_10))))))
 (define-values
  (make-set-variable)
  (lambda (id_29 exports_8)
    (let-values (((ex-var_0) (hash-ref exports_8 (unwrap id_29)))) (list 'variable-set! ex-var_0 id_29))))
 (define-values
  (make-expr-defns)
  (lambda (accum-exprs_2)
    (let-values (((lst_57) (reverse$1 accum-exprs_2)))
      (begin
        (check-list lst_57)
        ((letrec-values (((for-loop_48)
                          (lambda (lst_98)
                            (if (pair? lst_98)
                              (let-values (((expr_0) (unsafe-car lst_98)) ((rest_56) (unsafe-cdr lst_98)))
                                (let-values (((post-guard-var_7) (lambda () #t)))
                                  (let-values ()
                                    (let-values (((elem_6)
                                                  (let-values () (let-values () (list 'define (gensym) expr_0)))))
                                      (let-values (((result_49) (if (post-guard-var_7) (for-loop_48 rest_56) null)))
                                        (cons elem_6 result_49))))))
                              null))))
           for-loop_48)
         lst_57)))))
 (define-values
  (schemify)
  (lambda (v_61 annotate_3 unannotate_5 prim-knowns_10 knowns_30 mutated_11 imports_19 exports_9)
    ((letrec-values (((schemify/knowns_0)
                      (lambda (knowns_31 v_62)
                        ((letrec-values (((schemify_0)
                                          (lambda (v_63)
                                            (annotate_3
                                             v_63
                                             (let-values (((v_64) v_63))
                                               (if (let-values (((p_25) (unwrap v_64)))
                                                     (if (pair? p_25)
                                                       (if (let-values (((a_35) (car p_25))) (wrap-equal? 'lambda a_35))
                                                         (let-values (((d_29) (cdr p_25)))
                                                           (let-values (((p_26) (unwrap d_29)))
                                                             (if (pair? p_26)
                                                               (if (let-values (((a_36) (car p_26))) #t)
                                                                 (let-values (((d_30) (cdr p_26))) (wrap-list? d_30))
                                                                 #f)
                                                               #f)))
                                                         #f)
                                                       #f))
                                                 (let-values (((formals_2 body_21)
                                                               (let-values (((d_168) (cdr (unwrap v_64))))
                                                                 (let-values (((p_142) (unwrap d_168)))
                                                                   (let-values (((formals_3)
                                                                                 (let-values (((a_213) (car p_142)))
                                                                                   a_213))
                                                                                ((body_22)
                                                                                 (let-values (((d_170) (cdr p_142)))
                                                                                   (unwrap-list d_170))))
                                                                     (values formals_3 body_22))))))
                                                   (list* 'lambda formals_2 (map2 schemify_0 body_21)))
                                                 (if (let-values (((p_176) (unwrap v_64)))
                                                       (if (pair? p_176)
                                                         (if (let-values (((a_214) (car p_176)))
                                                               (wrap-equal? 'case-lambda a_214))
                                                           (let-values (((d_206) (cdr p_176)))
                                                             (if (wrap-list? d_206)
                                                               (let-values (((lst_99) d_206))
                                                                 (begin
                                                                   (void)
                                                                   ((letrec-values (((for-loop_49)
                                                                                     (lambda (result_50 lst_100)
                                                                                       (if (not (wrap-null? lst_100))
                                                                                         (let-values (((v_65)
                                                                                                       (if (wrap-pair?
                                                                                                            lst_100)
                                                                                                         (wrap-car
                                                                                                          lst_100)
                                                                                                         lst_100))
                                                                                                      ((rest_57)
                                                                                                       (if (wrap-pair?
                                                                                                            lst_100)
                                                                                                         (wrap-cdr
                                                                                                          lst_100)
                                                                                                         null)))
                                                                                           (let-values (((result_51)
                                                                                                         (let-values ()
                                                                                                           (let-values (((result_52)
                                                                                                                         (let-values ()
                                                                                                                           (let-values ()
                                                                                                                             (let-values (((p_87)
                                                                                                                                           (unwrap
                                                                                                                                            v_65)))
                                                                                                                               (if (pair?
                                                                                                                                    p_87)
                                                                                                                                 (if (let-values (((a_103)
                                                                                                                                                   (car
                                                                                                                                                    p_87)))
                                                                                                                                       #t)
                                                                                                                                   (let-values (((d_99)
                                                                                                                                                 (cdr
                                                                                                                                                  p_87)))
                                                                                                                                     (wrap-list?
                                                                                                                                      d_99))
                                                                                                                                   #f)
                                                                                                                                 #f))))))
                                                                                                             (values
                                                                                                              result_52)))))
                                                                                             (if (if (not
                                                                                                      ((lambda x_18
                                                                                                         (not
                                                                                                          result_51))
                                                                                                       v_65))
                                                                                                   (not #f)
                                                                                                   #f)
                                                                                               (for-loop_49
                                                                                                result_51
                                                                                                rest_57)
                                                                                               result_51)))
                                                                                         result_50))))
                                                                      for-loop_49)
                                                                    #t
                                                                    lst_99)))
                                                               #f))
                                                           #f)
                                                         #f))
                                                   (let-values (((formalss_7 bodys_16)
                                                                 (let-values (((d_207) (cdr (unwrap v_64))))
                                                                   (let-values (((formalss_8 bodys_17)
                                                                                 (let-values (((lst_101) d_207))
                                                                                   (begin
                                                                                     (void)
                                                                                     ((letrec-values (((for-loop_50)
                                                                                                       (lambda (formalss_9
                                                                                                                bodys_18
                                                                                                                lst_102)
                                                                                                         (if (not
                                                                                                              (wrap-null?
                                                                                                               lst_102))
                                                                                                           (let-values (((v_66)
                                                                                                                         (if (wrap-pair?
                                                                                                                              lst_102)
                                                                                                                           (wrap-car
                                                                                                                            lst_102)
                                                                                                                           lst_102))
                                                                                                                        ((rest_58)
                                                                                                                         (if (wrap-pair?
                                                                                                                              lst_102)
                                                                                                                           (wrap-cdr
                                                                                                                            lst_102)
                                                                                                                           null)))
                                                                                                             (let-values (((formalss_10
                                                                                                                            bodys_19)
                                                                                                                           (let-values (((formalss_11)
                                                                                                                                         formalss_9)
                                                                                                                                        ((bodys_20)
                                                                                                                                         bodys_18))
                                                                                                                             (let-values (((formalss_12
                                                                                                                                            bodys_21)
                                                                                                                                           (let-values ()
                                                                                                                                             (let-values (((formalss1_1
                                                                                                                                                            bodys2_1)
                                                                                                                                                           (let-values ()
                                                                                                                                                             (let-values (((p_177)
                                                                                                                                                                           (unwrap
                                                                                                                                                                            v_66)))
                                                                                                                                                               (let-values (((formalss_13)
                                                                                                                                                                             (let-values (((a_107)
                                                                                                                                                                                           (car
                                                                                                                                                                                            p_177)))
                                                                                                                                                                               a_107))
                                                                                                                                                                            ((bodys_22)
                                                                                                                                                                             (let-values (((d_208)
                                                                                                                                                                                           (cdr
                                                                                                                                                                                            p_177)))
                                                                                                                                                                               (unwrap-list
                                                                                                                                                                                d_208))))
                                                                                                                                                                 (values
                                                                                                                                                                  formalss_13
                                                                                                                                                                  bodys_22))))))
                                                                                                                                               (values
                                                                                                                                                (cons
                                                                                                                                                 formalss1_1
                                                                                                                                                 formalss_11)
                                                                                                                                                (cons
                                                                                                                                                 bodys2_1
                                                                                                                                                 bodys_20))))))
                                                                                                                               (values
                                                                                                                                formalss_12
                                                                                                                                bodys_21)))))
                                                                                                               (if (not
                                                                                                                    #f)
                                                                                                                 (for-loop_50
                                                                                                                  formalss_10
                                                                                                                  bodys_19
                                                                                                                  rest_58)
                                                                                                                 (values
                                                                                                                  formalss_10
                                                                                                                  bodys_19))))
                                                                                                           (values
                                                                                                            formalss_9
                                                                                                            bodys_18)))))
                                                                                        for-loop_50)
                                                                                      null
                                                                                      null
                                                                                      lst_101)))))
                                                                     (values
                                                                      (reverse$1 formalss_8)
                                                                      (reverse$1 bodys_17))))))
                                                     (list*
                                                      'case-lambda
                                                      (let-values (((lst_103) formalss_7) ((lst_104) bodys_16))
                                                        (begin
                                                          (check-list lst_103)
                                                          (check-list lst_104)
                                                          ((letrec-values (((for-loop_51)
                                                                            (lambda (lst_105 lst_106)
                                                                              (if (if (pair? lst_105)
                                                                                    (pair? lst_106)
                                                                                    #f)
                                                                                (let-values (((formals_4)
                                                                                              (unsafe-car lst_105))
                                                                                             ((rest_59)
                                                                                              (unsafe-cdr lst_105))
                                                                                             ((body_23)
                                                                                              (unsafe-car lst_106))
                                                                                             ((rest_60)
                                                                                              (unsafe-cdr lst_106)))
                                                                                  (let-values (((post-guard-var_8)
                                                                                                (lambda () #t)))
                                                                                    (let-values ()
                                                                                      (let-values (((elem_7)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (list*
                                                                                                         formals_4
                                                                                                         (map2
                                                                                                          schemify_0
                                                                                                          body_23))))))
                                                                                        (let-values (((result_53)
                                                                                                      (if (post-guard-var_8)
                                                                                                        (for-loop_51
                                                                                                         rest_59
                                                                                                         rest_60)
                                                                                                        null)))
                                                                                          (cons elem_7 result_53))))))
                                                                                null))))
                                                             for-loop_51)
                                                           lst_103
                                                           lst_104)))))
                                                   (if (let-values (((p_178) (unwrap v_64)))
                                                         (if (pair? p_178)
                                                           (if (let-values (((a_45) (car p_178)))
                                                                 (wrap-equal? 'define-values a_45))
                                                             (let-values (((d_209) (cdr p_178)))
                                                               (let-values (((p_146) (unwrap d_209)))
                                                                 (if (pair? p_146)
                                                                   (if (let-values (((a_183) (car p_146)))
                                                                         (let-values (((p_179) (unwrap a_183)))
                                                                           (if (pair? p_179)
                                                                             (if (let-values (((a_110) (car p_179))) #t)
                                                                               (let-values (((d_107) (cdr p_179)))
                                                                                 (let-values (((p_33) (unwrap d_107)))
                                                                                   (if (pair? p_33)
                                                                                     (if (let-values (((a_46)
                                                                                                       (car p_33)))
                                                                                           #t)
                                                                                       (let-values (((d_39) (cdr p_33)))
                                                                                         (let-values (((p_180)
                                                                                                       (unwrap d_39)))
                                                                                           (if (pair? p_180)
                                                                                             (if (let-values (((a_215)
                                                                                                               (car
                                                                                                                p_180)))
                                                                                                   #t)
                                                                                               (let-values (((d_210)
                                                                                                             (cdr
                                                                                                              p_180)))
                                                                                                 (wrap-list? d_210))
                                                                                               #f)
                                                                                             #f)))
                                                                                       #f)
                                                                                     #f)))
                                                                               #f)
                                                                             #f)))
                                                                     (let-values (((d_109) (cdr p_146)))
                                                                       (let-values (((p_148) (unwrap d_109)))
                                                                         (if (pair? p_148)
                                                                           (if (let-values (((a_47) (car p_148)))
                                                                                 (let-values (((p_181) (unwrap a_47)))
                                                                                   (if (pair? p_181)
                                                                                     (if (let-values (((a_216)
                                                                                                       (car p_181)))
                                                                                           (wrap-equal?
                                                                                            'let-values
                                                                                            a_216))
                                                                                       (let-values (((d_211)
                                                                                                     (cdr p_181)))
                                                                                         (let-values (((p_95)
                                                                                                       (unwrap d_211)))
                                                                                           (if (pair? p_95)
                                                                                             (if (let-values (((a_114)
                                                                                                               (car
                                                                                                                p_95)))
                                                                                                   (let-values (((p_182)
                                                                                                                 (unwrap
                                                                                                                  a_114)))
                                                                                                     (if (pair? p_182)
                                                                                                       (if (let-values (((a_217)
                                                                                                                         (car
                                                                                                                          p_182)))
                                                                                                             (let-values (((p_183)
                                                                                                                           (unwrap
                                                                                                                            a_217)))
                                                                                                               (if (pair?
                                                                                                                    p_183)
                                                                                                                 (if (let-values (((a_218)
                                                                                                                                   (car
                                                                                                                                    p_183)))
                                                                                                                       (let-values (((p_184)
                                                                                                                                     (unwrap
                                                                                                                                      a_218)))
                                                                                                                         (if (pair?
                                                                                                                              p_184)
                                                                                                                           (if (let-values (((a_219)
                                                                                                                                             (car
                                                                                                                                              p_184)))
                                                                                                                                 #t)
                                                                                                                             (let-values (((d_212)
                                                                                                                                           (cdr
                                                                                                                                            p_184)))
                                                                                                                               (let-values (((p_185)
                                                                                                                                             (unwrap
                                                                                                                                              d_212)))
                                                                                                                                 (if (pair?
                                                                                                                                      p_185)
                                                                                                                                   (if (let-values (((a_220)
                                                                                                                                                     (car
                                                                                                                                                      p_185)))
                                                                                                                                         #t)
                                                                                                                                     (let-values (((d_213)
                                                                                                                                                   (cdr
                                                                                                                                                    p_185)))
                                                                                                                                       (let-values (((p_186)
                                                                                                                                                     (unwrap
                                                                                                                                                      d_213)))
                                                                                                                                         (if (pair?
                                                                                                                                              p_186)
                                                                                                                                           (if (let-values (((a_221)
                                                                                                                                                             (car
                                                                                                                                                              p_186)))
                                                                                                                                                 #t)
                                                                                                                                             (let-values (((d_114)
                                                                                                                                                           (cdr
                                                                                                                                                            p_186)))
                                                                                                                                               (let-values (((p_100)
                                                                                                                                                             (unwrap
                                                                                                                                                              d_114)))
                                                                                                                                                 (if (pair?
                                                                                                                                                      p_100)
                                                                                                                                                   (if (let-values (((a_119)
                                                                                                                                                                     (car
                                                                                                                                                                      p_100)))
                                                                                                                                                         #t)
                                                                                                                                                     (let-values (((d_214)
                                                                                                                                                                   (cdr
                                                                                                                                                                    p_100)))
                                                                                                                                                       (let-values (((p_187)
                                                                                                                                                                     (unwrap
                                                                                                                                                                      d_214)))
                                                                                                                                                         (if (pair?
                                                                                                                                                              p_187)
                                                                                                                                                           (if (let-values (((a_222)
                                                                                                                                                                             (car
                                                                                                                                                                              p_187)))
                                                                                                                                                                 #t)
                                                                                                                                                             (let-values (((d_215)
                                                                                                                                                                           (cdr
                                                                                                                                                                            p_187)))
                                                                                                                                                               (wrap-equal?
                                                                                                                                                                '()
                                                                                                                                                                d_215))
                                                                                                                                                             #f)
                                                                                                                                                           #f)))
                                                                                                                                                     #f)
                                                                                                                                                   #f)))
                                                                                                                                             #f)
                                                                                                                                           #f)))
                                                                                                                                     #f)
                                                                                                                                   #f)))
                                                                                                                             #f)
                                                                                                                           #f)))
                                                                                                                   (let-values (((d_176)
                                                                                                                                 (cdr
                                                                                                                                  p_183)))
                                                                                                                     (let-values (((p_188)
                                                                                                                                   (unwrap
                                                                                                                                    d_176)))
                                                                                                                       (if (pair?
                                                                                                                            p_188)
                                                                                                                         (if (let-values (((a_223)
                                                                                                                                           (car
                                                                                                                                            p_188)))
                                                                                                                               #t)
                                                                                                                           (let-values (((d_216)
                                                                                                                                         (cdr
                                                                                                                                          p_188)))
                                                                                                                             (wrap-equal?
                                                                                                                              '()
                                                                                                                              d_216))
                                                                                                                           #f)
                                                                                                                         #f)))
                                                                                                                   #f)
                                                                                                                 #f)))
                                                                                                         (let-values (((d_217)
                                                                                                                       (cdr
                                                                                                                        p_182)))
                                                                                                           (wrap-equal?
                                                                                                            '()
                                                                                                            d_217))
                                                                                                         #f)
                                                                                                       #f)))
                                                                                               (let-values (((d_218)
                                                                                                             (cdr
                                                                                                              p_95)))
                                                                                                 (let-values (((p_189)
                                                                                                               (unwrap
                                                                                                                d_218)))
                                                                                                   (if (pair? p_189)
                                                                                                     (if (let-values (((a_224)
                                                                                                                       (car
                                                                                                                        p_189)))
                                                                                                           (let-values (((p_103)
                                                                                                                         (unwrap
                                                                                                                          a_224)))
                                                                                                             (if (pair?
                                                                                                                  p_103)
                                                                                                               (if (let-values (((a_225)
                                                                                                                                 (car
                                                                                                                                  p_103)))
                                                                                                                     (wrap-equal?
                                                                                                                      'values
                                                                                                                      a_225))
                                                                                                                 (let-values (((d_219)
                                                                                                                               (cdr
                                                                                                                                p_103)))
                                                                                                                   (let-values (((p_190)
                                                                                                                                 (unwrap
                                                                                                                                  d_219)))
                                                                                                                     (if (pair?
                                                                                                                          p_190)
                                                                                                                       (if (let-values (((a_226)
                                                                                                                                         (car
                                                                                                                                          p_190)))
                                                                                                                             #t)
                                                                                                                         (let-values (((d_220)
                                                                                                                                       (cdr
                                                                                                                                        p_190)))
                                                                                                                           (let-values (((p_104)
                                                                                                                                         (unwrap
                                                                                                                                          d_220)))
                                                                                                                             (if (pair?
                                                                                                                                  p_104)
                                                                                                                               (if (let-values (((a_227)
                                                                                                                                                 (car
                                                                                                                                                  p_104)))
                                                                                                                                     #t)
                                                                                                                                 (let-values (((d_221)
                                                                                                                                               (cdr
                                                                                                                                                p_104)))
                                                                                                                                   (let-values (((p_191)
                                                                                                                                                 (unwrap
                                                                                                                                                  d_221)))
                                                                                                                                     (if (pair?
                                                                                                                                          p_191)
                                                                                                                                       (if (let-values (((a_123)
                                                                                                                                                         (car
                                                                                                                                                          p_191)))
                                                                                                                                             #t)
                                                                                                                                         (let-values (((d_119)
                                                                                                                                                       (cdr
                                                                                                                                                        p_191)))
                                                                                                                                           (wrap-list?
                                                                                                                                            d_119))
                                                                                                                                         #f)
                                                                                                                                       #f)))
                                                                                                                                 #f)
                                                                                                                               #f)))
                                                                                                                         #f)
                                                                                                                       #f)))
                                                                                                                 #f)
                                                                                                               #f)))
                                                                                                       (let-values (((d_222)
                                                                                                                     (cdr
                                                                                                                      p_189)))
                                                                                                         (wrap-equal?
                                                                                                          '()
                                                                                                          d_222))
                                                                                                       #f)
                                                                                                     #f)))
                                                                                               #f)
                                                                                             #f)))
                                                                                       #f)
                                                                                     #f)))
                                                                             (let-values (((d_223) (cdr p_148)))
                                                                               (wrap-equal? '() d_223))
                                                                             #f)
                                                                           #f)))
                                                                     #f)
                                                                   #f)))
                                                             #f)
                                                           #f))
                                                     (let-values (((struct:s_6
                                                                    make-s_8
                                                                    s?_14
                                                                    acc/muts_5
                                                                    struct:_15
                                                                    make_6
                                                                    ?1_0
                                                                    -ref_18
                                                                    -set!_18
                                                                    mk_0
                                                                    struct:2_4
                                                                    make2_5
                                                                    ?2_6
                                                                    make-acc/muts_6)
                                                                   (let-values (((d_179) (cdr (unwrap v_64))))
                                                                     (let-values (((p_152) (unwrap d_179)))
                                                                       (let-values (((struct:s_7
                                                                                      make-s_9
                                                                                      s?_15
                                                                                      acc/muts_6)
                                                                                     (let-values (((a_133) (car p_152)))
                                                                                       (let-values (((p_192)
                                                                                                     (unwrap a_133)))
                                                                                         (let-values (((struct:s_8)
                                                                                                       (let-values (((a_228)
                                                                                                                     (car
                                                                                                                      p_192)))
                                                                                                         a_228))
                                                                                                      ((make-s_10
                                                                                                        s?_16
                                                                                                        acc/muts_7)
                                                                                                       (let-values (((d_131)
                                                                                                                     (cdr
                                                                                                                      p_192)))
                                                                                                         (let-values (((p_114)
                                                                                                                       (unwrap
                                                                                                                        d_131)))
                                                                                                           (let-values (((make-s_11)
                                                                                                                         (let-values (((a_229)
                                                                                                                                       (car
                                                                                                                                        p_114)))
                                                                                                                           a_229))
                                                                                                                        ((s?_17
                                                                                                                          acc/muts_8)
                                                                                                                         (let-values (((d_224)
                                                                                                                                       (cdr
                                                                                                                                        p_114)))
                                                                                                                           (let-values (((p_193)
                                                                                                                                         (unwrap
                                                                                                                                          d_224)))
                                                                                                                             (let-values (((s?_18)
                                                                                                                                           (let-values (((a_230)
                                                                                                                                                         (car
                                                                                                                                                          p_193)))
                                                                                                                                             a_230))
                                                                                                                                          ((acc/muts_9)
                                                                                                                                           (let-values (((d_225)
                                                                                                                                                         (cdr
                                                                                                                                                          p_193)))
                                                                                                                                             (unwrap-list
                                                                                                                                              d_225))))
                                                                                                                               (values
                                                                                                                                s?_18
                                                                                                                                acc/muts_9))))))
                                                                                                             (values
                                                                                                              make-s_11
                                                                                                              s?_17
                                                                                                              acc/muts_8))))))
                                                                                           (values
                                                                                            struct:s_8
                                                                                            make-s_10
                                                                                            s?_16
                                                                                            acc/muts_7)))))
                                                                                    ((struct:_16
                                                                                      make_7
                                                                                      ?1_1
                                                                                      -ref_19
                                                                                      -set!_19
                                                                                      mk_1
                                                                                      struct:2_5
                                                                                      make2_6
                                                                                      ?2_7
                                                                                      make-acc/muts_7)
                                                                                     (let-values (((d_186) (cdr p_152)))
                                                                                       (let-values (((a_137)
                                                                                                     (car
                                                                                                      (unwrap d_186))))
                                                                                         (let-values (((d_226)
                                                                                                       (cdr
                                                                                                        (unwrap
                                                                                                         a_137))))
                                                                                           (let-values (((p_194)
                                                                                                         (unwrap
                                                                                                          d_226)))
                                                                                             (let-values (((struct:_17
                                                                                                            make_8
                                                                                                            ?1_2
                                                                                                            -ref_20
                                                                                                            -set!_20
                                                                                                            mk_2)
                                                                                                           (let-values (((a_199)
                                                                                                                         (car
                                                                                                                          p_194)))
                                                                                                             (let-values (((a_231)
                                                                                                                           (car
                                                                                                                            (unwrap
                                                                                                                             a_199))))
                                                                                                               (let-values (((p_195)
                                                                                                                             (unwrap
                                                                                                                              a_231)))
                                                                                                                 (let-values (((struct:_18
                                                                                                                                make_9
                                                                                                                                ?1_3
                                                                                                                                -ref_21
                                                                                                                                -set!_21)
                                                                                                                               (let-values (((a_232)
                                                                                                                                             (car
                                                                                                                                              p_195)))
                                                                                                                                 (let-values (((p_196)
                                                                                                                                               (unwrap
                                                                                                                                                a_232)))
                                                                                                                                   (let-values (((struct:_19)
                                                                                                                                                 (let-values (((a_201)
                                                                                                                                                               (car
                                                                                                                                                                p_196)))
                                                                                                                                                   a_201))
                                                                                                                                                ((make_10
                                                                                                                                                  ?1_4
                                                                                                                                                  -ref_22
                                                                                                                                                  -set!_22)
                                                                                                                                                 (let-values (((d_193)
                                                                                                                                                               (cdr
                                                                                                                                                                p_196)))
                                                                                                                                                   (let-values (((p_164)
                                                                                                                                                                 (unwrap
                                                                                                                                                                  d_193)))
                                                                                                                                                     (let-values (((make_11)
                                                                                                                                                                   (let-values (((a_233)
                                                                                                                                                                                 (car
                                                                                                                                                                                  p_164)))
                                                                                                                                                                     a_233))
                                                                                                                                                                  ((?1_5
                                                                                                                                                                    -ref_23
                                                                                                                                                                    -set!_23)
                                                                                                                                                                   (let-values (((d_227)
                                                                                                                                                                                 (cdr
                                                                                                                                                                                  p_164)))
                                                                                                                                                                     (let-values (((p_197)
                                                                                                                                                                                   (unwrap
                                                                                                                                                                                    d_227)))
                                                                                                                                                                       (let-values (((?1_6)
                                                                                                                                                                                     (let-values (((a_234)
                                                                                                                                                                                                   (car
                                                                                                                                                                                                    p_197)))
                                                                                                                                                                                       a_234))
                                                                                                                                                                                    ((-ref_24
                                                                                                                                                                                      -set!_24)
                                                                                                                                                                                     (let-values (((d_228)
                                                                                                                                                                                                   (cdr
                                                                                                                                                                                                    p_197)))
                                                                                                                                                                                       (let-values (((p_198)
                                                                                                                                                                                                     (unwrap
                                                                                                                                                                                                      d_228)))
                                                                                                                                                                                         (let-values (((-ref_25)
                                                                                                                                                                                                       (let-values (((a_235)
                                                                                                                                                                                                                     (car
                                                                                                                                                                                                                      p_198)))
                                                                                                                                                                                                         a_235))
                                                                                                                                                                                                      ((-set!_25)
                                                                                                                                                                                                       (let-values (((d_229)
                                                                                                                                                                                                                     (cdr
                                                                                                                                                                                                                      p_198)))
                                                                                                                                                                                                         (let-values (((a_236)
                                                                                                                                                                                                                       (car
                                                                                                                                                                                                                        (unwrap
                                                                                                                                                                                                                         d_229))))
                                                                                                                                                                                                           a_236))))
                                                                                                                                                                                           (values
                                                                                                                                                                                            -ref_25
                                                                                                                                                                                            -set!_25))))))
                                                                                                                                                                         (values
                                                                                                                                                                          ?1_6
                                                                                                                                                                          -ref_24
                                                                                                                                                                          -set!_24))))))
                                                                                                                                                       (values
                                                                                                                                                        make_11
                                                                                                                                                        ?1_5
                                                                                                                                                        -ref_23
                                                                                                                                                        -set!_23))))))
                                                                                                                                     (values
                                                                                                                                      struct:_19
                                                                                                                                      make_10
                                                                                                                                      ?1_4
                                                                                                                                      -ref_22
                                                                                                                                      -set!_22)))))
                                                                                                                              ((mk_3)
                                                                                                                               (let-values (((d_230)
                                                                                                                                             (cdr
                                                                                                                                              p_195)))
                                                                                                                                 (let-values (((a_237)
                                                                                                                                               (car
                                                                                                                                                (unwrap
                                                                                                                                                 d_230))))
                                                                                                                                   a_237))))
                                                                                                                   (values
                                                                                                                    struct:_18
                                                                                                                    make_9
                                                                                                                    ?1_3
                                                                                                                    -ref_21
                                                                                                                    -set!_21
                                                                                                                    mk_3))))))
                                                                                                          ((struct:2_6
                                                                                                            make2_7
                                                                                                            ?2_8
                                                                                                            make-acc/muts_8)
                                                                                                           (let-values (((d_231)
                                                                                                                         (cdr
                                                                                                                          p_194)))
                                                                                                             (let-values (((a_155)
                                                                                                                           (car
                                                                                                                            (unwrap
                                                                                                                             d_231))))
                                                                                                               (let-values (((d_146)
                                                                                                                             (cdr
                                                                                                                              (unwrap
                                                                                                                               a_155))))
                                                                                                                 (let-values (((p_127)
                                                                                                                               (unwrap
                                                                                                                                d_146)))
                                                                                                                   (let-values (((struct:2_7)
                                                                                                                                 (let-values (((a_205)
                                                                                                                                               (car
                                                                                                                                                p_127)))
                                                                                                                                   a_205))
                                                                                                                                ((make2_8
                                                                                                                                  ?2_9
                                                                                                                                  make-acc/muts_9)
                                                                                                                                 (let-values (((d_199)
                                                                                                                                               (cdr
                                                                                                                                                p_127)))
                                                                                                                                   (let-values (((p_199)
                                                                                                                                                 (unwrap
                                                                                                                                                  d_199)))
                                                                                                                                     (let-values (((make2_9)
                                                                                                                                                   (let-values (((a_159)
                                                                                                                                                                 (car
                                                                                                                                                                  p_199)))
                                                                                                                                                     a_159))
                                                                                                                                                  ((?2_10
                                                                                                                                                    make-acc/muts_10)
                                                                                                                                                   (let-values (((d_151)
                                                                                                                                                                 (cdr
                                                                                                                                                                  p_199)))
                                                                                                                                                     (let-values (((p_130)
                                                                                                                                                                   (unwrap
                                                                                                                                                                    d_151)))
                                                                                                                                                       (let-values (((?2_11)
                                                                                                                                                                     (let-values (((a_238)
                                                                                                                                                                                   (car
                                                                                                                                                                                    p_130)))
                                                                                                                                                                       a_238))
                                                                                                                                                                    ((make-acc/muts_11)
                                                                                                                                                                     (let-values (((d_232)
                                                                                                                                                                                   (cdr
                                                                                                                                                                                    p_130)))
                                                                                                                                                                       (unwrap-list
                                                                                                                                                                        d_232))))
                                                                                                                                                         (values
                                                                                                                                                          ?2_11
                                                                                                                                                          make-acc/muts_11))))))
                                                                                                                                       (values
                                                                                                                                        make2_9
                                                                                                                                        ?2_10
                                                                                                                                        make-acc/muts_10))))))
                                                                                                                     (values
                                                                                                                      struct:2_7
                                                                                                                      make2_8
                                                                                                                      ?2_9
                                                                                                                      make-acc/muts_9))))))))
                                                                                               (values
                                                                                                struct:_17
                                                                                                make_8
                                                                                                ?1_2
                                                                                                -ref_20
                                                                                                -set!_20
                                                                                                mk_2
                                                                                                struct:2_6
                                                                                                make2_7
                                                                                                ?2_8
                                                                                                make-acc/muts_8))))))))
                                                                         (values
                                                                          struct:s_7
                                                                          make-s_9
                                                                          s?_15
                                                                          acc/muts_6
                                                                          struct:_16
                                                                          make_7
                                                                          ?1_1
                                                                          -ref_19
                                                                          -set!_19
                                                                          mk_1
                                                                          struct:2_5
                                                                          make2_6
                                                                          ?2_7
                                                                          make-acc/muts_7))))))
                                                       (let-values (((sti_0)
                                                                     (if (wrap-eq? struct:_15 struct:2_4)
                                                                       (if (wrap-eq? make_6 make2_5)
                                                                         (if (wrap-eq? ?1_0 ?2_6)
                                                                           (make-struct-type-info
                                                                            mk_0
                                                                            prim-knowns_10
                                                                            knowns_31
                                                                            imports_19
                                                                            mutated_11)
                                                                           #f)
                                                                         #f)
                                                                       #f)))
                                                         (if (if sti_0
                                                               (simple-mutated-state?
                                                                (hash-ref mutated_11 (unwrap struct:_15) #f))
                                                               #f)
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
                                                                               (let-values (((start_2) 0)
                                                                                            ((end_0)
                                                                                             (struct-type-info-immediate-field-count
                                                                                              sti_0))
                                                                                            ((inc_0) 1))
                                                                                 (begin
                                                                                   (check-range start_2 end_0 inc_0)
                                                                                   ((letrec-values (((for-loop_52)
                                                                                                     (lambda (vec_3
                                                                                                              i_3
                                                                                                              pos_3)
                                                                                                       (if (<
                                                                                                            pos_3
                                                                                                            end_0)
                                                                                                         (let-values (((i_4)
                                                                                                                       pos_3))
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
                                                                                                             (if (not
                                                                                                                  #f)
                                                                                                               (for-loop_52
                                                                                                                vec_4
                                                                                                                i_5
                                                                                                                (+
                                                                                                                 pos_3
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
                                                                                    start_2)))))
                                                                   (shrink-vector vec_2 i_2)))))
                                                              (qq-append
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
                                                                    (map2 schemify_0 (struct-type-info-rest sti_0))))))
                                                               (list*
                                                                (list
                                                                 'define
                                                                 make-s_8
                                                                 (list
                                                                  'record-constructor
                                                                  (list*
                                                                   'make-record-constructor-descriptor
                                                                   struct:s_6
                                                                   '(#f #f))))
                                                                (list 'define s?_14 (list 'record-predicate struct:s_6))
                                                                (let-values (((lst_107) acc/muts_5)
                                                                             ((lst_108) make-acc/muts_6))
                                                                  (begin
                                                                    (check-list lst_107)
                                                                    (check-list lst_108)
                                                                    ((letrec-values (((for-loop_53)
                                                                                      (lambda (lst_109 lst_110)
                                                                                        (if (if (pair? lst_109)
                                                                                              (pair? lst_110)
                                                                                              #f)
                                                                                          (let-values (((acc/mut_0)
                                                                                                        (unsafe-car
                                                                                                         lst_109))
                                                                                                       ((rest_61)
                                                                                                        (unsafe-cdr
                                                                                                         lst_109))
                                                                                                       ((make-acc/mut_0)
                                                                                                        (unsafe-car
                                                                                                         lst_110))
                                                                                                       ((rest_62)
                                                                                                        (unsafe-cdr
                                                                                                         lst_110)))
                                                                                            (let-values (((post-guard-var_9)
                                                                                                          (lambda ()
                                                                                                            #t)))
                                                                                              (let-values ()
                                                                                                (let-values (((elem_8)
                                                                                                              (let-values ()
                                                                                                                (let-values ()
                                                                                                                  (list
                                                                                                                   'define
                                                                                                                   acc/mut_0
                                                                                                                   (let-values (((v_67)
                                                                                                                                 make-acc/mut_0))
                                                                                                                     (if (let-values (((p_200)
                                                                                                                                       (unwrap
                                                                                                                                        v_67)))
                                                                                                                           (if (pair?
                                                                                                                                p_200)
                                                                                                                             (if (let-values (((a_239)
                                                                                                                                               (car
                                                                                                                                                p_200)))
                                                                                                                                   (wrap-equal?
                                                                                                                                    'make-struct-field-accessor
                                                                                                                                    a_239))
                                                                                                                               (let-values (((d_233)
                                                                                                                                             (cdr
                                                                                                                                              p_200)))
                                                                                                                                 (let-values (((p_201)
                                                                                                                                               (unwrap
                                                                                                                                                d_233)))
                                                                                                                                   (if (pair?
                                                                                                                                        p_201)
                                                                                                                                     (if (let-values (((a_240)
                                                                                                                                                       (car
                                                                                                                                                        p_201)))
                                                                                                                                           ((lambda (v_68)
                                                                                                                                              (wrap-eq?
                                                                                                                                               v_68
                                                                                                                                               -ref_18))
                                                                                                                                            a_240))
                                                                                                                                       (let-values (((d_234)
                                                                                                                                                     (cdr
                                                                                                                                                      p_201)))
                                                                                                                                         (let-values (((p_202)
                                                                                                                                                       (unwrap
                                                                                                                                                        d_234)))
                                                                                                                                           (if (pair?
                                                                                                                                                p_202)
                                                                                                                                             (if (let-values (((a_241)
                                                                                                                                                               (car
                                                                                                                                                                p_202)))
                                                                                                                                                   #t)
                                                                                                                                               (let-values (((d_235)
                                                                                                                                                             (cdr
                                                                                                                                                              p_202)))
                                                                                                                                                 (let-values (((p_203)
                                                                                                                                                               (unwrap
                                                                                                                                                                d_235)))
                                                                                                                                                   (if (pair?
                                                                                                                                                        p_203)
                                                                                                                                                     (if (let-values (((a_242)
                                                                                                                                                                       (car
                                                                                                                                                                        p_203)))
                                                                                                                                                           #t)
                                                                                                                                                       (let-values (((d_236)
                                                                                                                                                                     (cdr
                                                                                                                                                                      p_203)))
                                                                                                                                                         (wrap-equal?
                                                                                                                                                          '()
                                                                                                                                                          d_236))
                                                                                                                                                       #f)
                                                                                                                                                     #f)))
                                                                                                                                               #f)
                                                                                                                                             #f)))
                                                                                                                                       #f)
                                                                                                                                     #f)))
                                                                                                                               #f)
                                                                                                                             #f))
                                                                                                                       (let-values (((pos_4)
                                                                                                                                     (let-values (((d_237)
                                                                                                                                                   (cdr
                                                                                                                                                    (unwrap
                                                                                                                                                     v_67))))
                                                                                                                                       (let-values (((d_238)
                                                                                                                                                     (cdr
                                                                                                                                                      (unwrap
                                                                                                                                                       d_237))))
                                                                                                                                         (let-values (((a_243)
                                                                                                                                                       (car
                                                                                                                                                        (unwrap
                                                                                                                                                         d_238))))
                                                                                                                                           a_243)))))
                                                                                                                         (list
                                                                                                                          'record-accessor
                                                                                                                          struct:s_6
                                                                                                                          pos_4))
                                                                                                                       (if (let-values (((p_204)
                                                                                                                                         (unwrap
                                                                                                                                          v_67)))
                                                                                                                             (if (pair?
                                                                                                                                  p_204)
                                                                                                                               (if (let-values (((a_244)
                                                                                                                                                 (car
                                                                                                                                                  p_204)))
                                                                                                                                     (wrap-equal?
                                                                                                                                      'make-struct-field-mutator
                                                                                                                                      a_244))
                                                                                                                                 (let-values (((d_239)
                                                                                                                                               (cdr
                                                                                                                                                p_204)))
                                                                                                                                   (let-values (((p_205)
                                                                                                                                                 (unwrap
                                                                                                                                                  d_239)))
                                                                                                                                     (if (pair?
                                                                                                                                          p_205)
                                                                                                                                       (if (let-values (((a_245)
                                                                                                                                                         (car
                                                                                                                                                          p_205)))
                                                                                                                                             ((lambda (v_69)
                                                                                                                                                (wrap-eq?
                                                                                                                                                 v_69
                                                                                                                                                 -set!_18))
                                                                                                                                              a_245))
                                                                                                                                         (let-values (((d_240)
                                                                                                                                                       (cdr
                                                                                                                                                        p_205)))
                                                                                                                                           (let-values (((p_206)
                                                                                                                                                         (unwrap
                                                                                                                                                          d_240)))
                                                                                                                                             (if (pair?
                                                                                                                                                  p_206)
                                                                                                                                               (if (let-values (((a_246)
                                                                                                                                                                 (car
                                                                                                                                                                  p_206)))
                                                                                                                                                     #t)
                                                                                                                                                 (let-values (((d_241)
                                                                                                                                                               (cdr
                                                                                                                                                                p_206)))
                                                                                                                                                   (let-values (((p_207)
                                                                                                                                                                 (unwrap
                                                                                                                                                                  d_241)))
                                                                                                                                                     (if (pair?
                                                                                                                                                          p_207)
                                                                                                                                                       (if (let-values (((a_247)
                                                                                                                                                                         (car
                                                                                                                                                                          p_207)))
                                                                                                                                                             #t)
                                                                                                                                                         (let-values (((d_242)
                                                                                                                                                                       (cdr
                                                                                                                                                                        p_207)))
                                                                                                                                                           (wrap-equal?
                                                                                                                                                            '()
                                                                                                                                                            d_242))
                                                                                                                                                         #f)
                                                                                                                                                       #f)))
                                                                                                                                                 #f)
                                                                                                                                               #f)))
                                                                                                                                         #f)
                                                                                                                                       #f)))
                                                                                                                                 #f)
                                                                                                                               #f))
                                                                                                                         (let-values (((pos_5)
                                                                                                                                       (let-values (((d_243)
                                                                                                                                                     (cdr
                                                                                                                                                      (unwrap
                                                                                                                                                       v_67))))
                                                                                                                                         (let-values (((d_244)
                                                                                                                                                       (cdr
                                                                                                                                                        (unwrap
                                                                                                                                                         d_243))))
                                                                                                                                           (let-values (((a_248)
                                                                                                                                                         (car
                                                                                                                                                          (unwrap
                                                                                                                                                           d_244))))
                                                                                                                                             a_248)))))
                                                                                                                           (list
                                                                                                                            'record-mutator
                                                                                                                            struct:s_6
                                                                                                                            pos_5))
                                                                                                                         (let-values ()
                                                                                                                           (error
                                                                                                                            "oops"))))))))))
                                                                                                  (let-values (((result_54)
                                                                                                                (if (post-guard-var_9)
                                                                                                                  (for-loop_53
                                                                                                                   rest_61
                                                                                                                   rest_62)
                                                                                                                  null)))
                                                                                                    (cons
                                                                                                     elem_8
                                                                                                     result_54))))))
                                                                                          null))))
                                                                       for-loop_53)
                                                                     lst_107
                                                                     lst_108)))))))
                                                           (let-values ()
                                                             (let-values (((v_70) v_63))
                                                               (if (let-values (((p_208) (unwrap v_70)))
                                                                     (if (pair? p_208)
                                                                       (if (let-values (((a_249) (car p_208))) #t)
                                                                         (let-values (((d_245) (cdr p_208)))
                                                                           (let-values (((p_209) (unwrap d_245)))
                                                                             (if (pair? p_209)
                                                                               (if (let-values (((a_250) (car p_209)))
                                                                                     #t)
                                                                                 (let-values (((d_246) (cdr p_209)))
                                                                                   (let-values (((p_210)
                                                                                                 (unwrap d_246)))
                                                                                     (if (pair? p_210)
                                                                                       (if (let-values (((a_251)
                                                                                                         (car p_210)))
                                                                                             #t)
                                                                                         (let-values (((d_247)
                                                                                                       (cdr p_210)))
                                                                                           (wrap-equal? '() d_247))
                                                                                         #f)
                                                                                       #f)))
                                                                                 #f)
                                                                               #f)))
                                                                         #f)
                                                                       #f))
                                                                 (let-values (((ids_27 rhs_30)
                                                                               (let-values (((d_248)
                                                                                             (cdr (unwrap v_70))))
                                                                                 (let-values (((p_211) (unwrap d_248)))
                                                                                   (let-values (((ids_28)
                                                                                                 (let-values (((a_252)
                                                                                                               (car
                                                                                                                p_211)))
                                                                                                   a_252))
                                                                                                ((rhs_31)
                                                                                                 (let-values (((d_249)
                                                                                                               (cdr
                                                                                                                p_211)))
                                                                                                   (let-values (((a_253)
                                                                                                                 (car
                                                                                                                  (unwrap
                                                                                                                   d_249))))
                                                                                                     a_253))))
                                                                                     (values ids_28 rhs_31))))))
                                                                   (list 'define-values ids_27 (schemify_0 rhs_30)))
                                                                 (error 'match "failed ~e" v_70)))))))
                                                     (if (let-values (((p_212) (unwrap v_64)))
                                                           (if (pair? p_212)
                                                             (if (let-values (((a_254) (car p_212)))
                                                                   (wrap-equal? 'define-values a_254))
                                                               (let-values (((d_250) (cdr p_212)))
                                                                 (let-values (((p_213) (unwrap d_250)))
                                                                   (if (pair? p_213)
                                                                     (if (let-values (((a_255) (car p_213)))
                                                                           (let-values (((p_214) (unwrap a_255)))
                                                                             (if (pair? p_214)
                                                                               (if (let-values (((a_256) (car p_214)))
                                                                                     #t)
                                                                                 (let-values (((d_251) (cdr p_214)))
                                                                                   (wrap-equal? '() d_251))
                                                                                 #f)
                                                                               #f)))
                                                                       (let-values (((d_252) (cdr p_213)))
                                                                         (let-values (((p_215) (unwrap d_252)))
                                                                           (if (pair? p_215)
                                                                             (if (let-values (((a_257) (car p_215))) #t)
                                                                               (let-values (((d_253) (cdr p_215)))
                                                                                 (wrap-equal? '() d_253))
                                                                               #f)
                                                                             #f)))
                                                                       #f)
                                                                     #f)))
                                                               #f)
                                                             #f))
                                                       (let-values (((id_30 rhs_32)
                                                                     (let-values (((d_254) (cdr (unwrap v_64))))
                                                                       (let-values (((p_216) (unwrap d_254)))
                                                                         (let-values (((id_31)
                                                                                       (let-values (((a_258)
                                                                                                     (car p_216)))
                                                                                         (let-values (((a_259)
                                                                                                       (car
                                                                                                        (unwrap
                                                                                                         a_258))))
                                                                                           a_259)))
                                                                                      ((rhs_33)
                                                                                       (let-values (((d_255)
                                                                                                     (cdr p_216)))
                                                                                         (let-values (((a_260)
                                                                                                       (car
                                                                                                        (unwrap
                                                                                                         d_255))))
                                                                                           a_260))))
                                                                           (values id_31 rhs_33))))))
                                                         (list 'define id_30 (schemify_0 rhs_32)))
                                                       (if (let-values (((p_217) (unwrap v_64)))
                                                             (if (pair? p_217)
                                                               (if (let-values (((a_261) (car p_217)))
                                                                     (wrap-equal? 'define-values a_261))
                                                                 (let-values (((d_256) (cdr p_217)))
                                                                   (let-values (((p_218) (unwrap d_256)))
                                                                     (if (pair? p_218)
                                                                       (if (let-values (((a_262) (car p_218))) #t)
                                                                         (let-values (((d_257) (cdr p_218)))
                                                                           (let-values (((p_219) (unwrap d_257)))
                                                                             (if (pair? p_219)
                                                                               (if (let-values (((a_263) (car p_219)))
                                                                                     #t)
                                                                                 (let-values (((d_258) (cdr p_219)))
                                                                                   (wrap-equal? '() d_258))
                                                                                 #f)
                                                                               #f)))
                                                                         #f)
                                                                       #f)))
                                                                 #f)
                                                               #f))
                                                         (let-values (((ids_29 rhs_34)
                                                                       (let-values (((d_259) (cdr (unwrap v_64))))
                                                                         (let-values (((p_220) (unwrap d_259)))
                                                                           (let-values (((ids_30)
                                                                                         (let-values (((a_264)
                                                                                                       (car p_220)))
                                                                                           a_264))
                                                                                        ((rhs_35)
                                                                                         (let-values (((d_260)
                                                                                                       (cdr p_220)))
                                                                                           (let-values (((a_265)
                                                                                                         (car
                                                                                                          (unwrap
                                                                                                           d_260))))
                                                                                             a_265))))
                                                                             (values ids_30 rhs_35))))))
                                                           (list 'define-values ids_29 (schemify_0 rhs_34)))
                                                         (if (let-values (((p_221) (unwrap v_64)))
                                                               (if (pair? p_221)
                                                                 (if (let-values (((a_266) (car p_221)))
                                                                       (wrap-equal? 'quote a_266))
                                                                   (let-values (((d_261) (cdr p_221)))
                                                                     (let-values (((p_222) (unwrap d_261)))
                                                                       (if (pair? p_222)
                                                                         (if (let-values (((a_267) (car p_222))) #t)
                                                                           (let-values (((d_262) (cdr p_222)))
                                                                             (wrap-equal? '() d_262))
                                                                           #f)
                                                                         #f)))
                                                                   #f)
                                                                 #f))
                                                           (let-values () v_63)
                                                           (if (let-values (((p_223) (unwrap v_64)))
                                                                 (if (pair? p_223)
                                                                   (if (let-values (((a_268) (car p_223)))
                                                                         (wrap-equal? 'let-values a_268))
                                                                     (let-values (((d_263) (cdr p_223)))
                                                                       (let-values (((p_224) (unwrap d_263)))
                                                                         (if (pair? p_224)
                                                                           (if (let-values (((a_269) (car p_224)))
                                                                                 (wrap-equal? '() a_269))
                                                                             (let-values (((d_264) (cdr p_224)))
                                                                               (let-values (((p_225) (unwrap d_264)))
                                                                                 (if (pair? p_225)
                                                                                   (if (let-values (((a_270)
                                                                                                     (car p_225)))
                                                                                         #t)
                                                                                     (let-values (((d_265) (cdr p_225)))
                                                                                       (wrap-equal? '() d_265))
                                                                                     #f)
                                                                                   #f)))
                                                                             #f)
                                                                           #f)))
                                                                     #f)
                                                                   #f))
                                                             (let-values (((body_24)
                                                                           (let-values (((d_266) (cdr (unwrap v_64))))
                                                                             (let-values (((d_267)
                                                                                           (cdr (unwrap d_266))))
                                                                               (let-values (((a_271)
                                                                                             (car (unwrap d_267))))
                                                                                 a_271)))))
                                                               (schemify_0 body_24))
                                                             (if (let-values (((p_226) (unwrap v_64)))
                                                                   (if (pair? p_226)
                                                                     (if (let-values (((a_272) (car p_226)))
                                                                           (wrap-equal? 'let-values a_272))
                                                                       (let-values (((d_268) (cdr p_226)))
                                                                         (let-values (((p_227) (unwrap d_268)))
                                                                           (if (pair? p_227)
                                                                             (if (let-values (((a_273) (car p_227)))
                                                                                   (wrap-equal? '() a_273))
                                                                               (let-values (((d_269) (cdr p_227)))
                                                                                 (wrap-list? d_269))
                                                                               #f)
                                                                             #f)))
                                                                       #f)
                                                                     #f))
                                                               (let-values (((bodys_23)
                                                                             (let-values (((d_270) (cdr (unwrap v_64))))
                                                                               (let-values (((d_271)
                                                                                             (cdr (unwrap d_270))))
                                                                                 (unwrap-list d_271)))))
                                                                 (list* 'begin (map2 schemify_0 bodys_23)))
                                                               (if (let-values (((p_228) (unwrap v_64)))
                                                                     (if (pair? p_228)
                                                                       (if (let-values (((a_274) (car p_228)))
                                                                             (wrap-equal? 'let-values a_274))
                                                                         (let-values (((d_272) (cdr p_228)))
                                                                           (let-values (((p_229) (unwrap d_272)))
                                                                             (if (pair? p_229)
                                                                               (if (let-values (((a_275) (car p_229)))
                                                                                     (if (wrap-list? a_275)
                                                                                       (let-values (((lst_111) a_275))
                                                                                         (begin
                                                                                           (void)
                                                                                           ((letrec-values (((for-loop_54)
                                                                                                             (lambda (result_55
                                                                                                                      lst_112)
                                                                                                               (if (not
                                                                                                                    (wrap-null?
                                                                                                                     lst_112))
                                                                                                                 (let-values (((v_71)
                                                                                                                               (if (wrap-pair?
                                                                                                                                    lst_112)
                                                                                                                                 (wrap-car
                                                                                                                                  lst_112)
                                                                                                                                 lst_112))
                                                                                                                              ((rest_63)
                                                                                                                               (if (wrap-pair?
                                                                                                                                    lst_112)
                                                                                                                                 (wrap-cdr
                                                                                                                                  lst_112)
                                                                                                                                 null)))
                                                                                                                   (let-values (((result_56)
                                                                                                                                 (let-values ()
                                                                                                                                   (let-values (((result_57)
                                                                                                                                                 (let-values ()
                                                                                                                                                   (let-values ()
                                                                                                                                                     (let-values (((p_230)
                                                                                                                                                                   (unwrap
                                                                                                                                                                    v_71)))
                                                                                                                                                       (if (pair?
                                                                                                                                                            p_230)
                                                                                                                                                         (if (let-values (((a_276)
                                                                                                                                                                           (car
                                                                                                                                                                            p_230)))
                                                                                                                                                               (let-values (((p_231)
                                                                                                                                                                             (unwrap
                                                                                                                                                                              a_276)))
                                                                                                                                                                 (if (pair?
                                                                                                                                                                      p_231)
                                                                                                                                                                   (if (let-values (((a_277)
                                                                                                                                                                                     (car
                                                                                                                                                                                      p_231)))
                                                                                                                                                                         #t)
                                                                                                                                                                     (let-values (((d_273)
                                                                                                                                                                                   (cdr
                                                                                                                                                                                    p_231)))
                                                                                                                                                                       (wrap-equal?
                                                                                                                                                                        '()
                                                                                                                                                                        d_273))
                                                                                                                                                                     #f)
                                                                                                                                                                   #f)))
                                                                                                                                                           (let-values (((d_274)
                                                                                                                                                                         (cdr
                                                                                                                                                                          p_230)))
                                                                                                                                                             (let-values (((p_232)
                                                                                                                                                                           (unwrap
                                                                                                                                                                            d_274)))
                                                                                                                                                               (if (pair?
                                                                                                                                                                    p_232)
                                                                                                                                                                 (if (let-values (((a_278)
                                                                                                                                                                                   (car
                                                                                                                                                                                    p_232)))
                                                                                                                                                                       #t)
                                                                                                                                                                   (let-values (((d_275)
                                                                                                                                                                                 (cdr
                                                                                                                                                                                  p_232)))
                                                                                                                                                                     (wrap-equal?
                                                                                                                                                                      '()
                                                                                                                                                                      d_275))
                                                                                                                                                                   #f)
                                                                                                                                                                 #f)))
                                                                                                                                                           #f)
                                                                                                                                                         #f))))))
                                                                                                                                     (values
                                                                                                                                      result_57)))))
                                                                                                                     (if (if (not
                                                                                                                              ((lambda x_19
                                                                                                                                 (not
                                                                                                                                  result_56))
                                                                                                                               v_71))
                                                                                                                           (not
                                                                                                                            #f)
                                                                                                                           #f)
                                                                                                                       (for-loop_54
                                                                                                                        result_56
                                                                                                                        rest_63)
                                                                                                                       result_56)))
                                                                                                                 result_55))))
                                                                                              for-loop_54)
                                                                                            #t
                                                                                            lst_111)))
                                                                                       #f))
                                                                                 (let-values (((d_276) (cdr p_229)))
                                                                                   (wrap-list? d_276))
                                                                                 #f)
                                                                               #f)))
                                                                         #f)
                                                                       #f))
                                                                 (let-values (((ids_31 rhss_50 bodys_24)
                                                                               (let-values (((d_277)
                                                                                             (cdr (unwrap v_64))))
                                                                                 (let-values (((p_233) (unwrap d_277)))
                                                                                   (let-values (((ids_32 rhss_51)
                                                                                                 (let-values (((a_279)
                                                                                                               (car
                                                                                                                p_233)))
                                                                                                   (let-values (((ids_33
                                                                                                                  rhss_52)
                                                                                                                 (let-values (((lst_113)
                                                                                                                               a_279))
                                                                                                                   (begin
                                                                                                                     (void)
                                                                                                                     ((letrec-values (((for-loop_55)
                                                                                                                                       (lambda (ids_34
                                                                                                                                                rhss_53
                                                                                                                                                lst_114)
                                                                                                                                         (if (not
                                                                                                                                              (wrap-null?
                                                                                                                                               lst_114))
                                                                                                                                           (let-values (((v_72)
                                                                                                                                                         (if (wrap-pair?
                                                                                                                                                              lst_114)
                                                                                                                                                           (wrap-car
                                                                                                                                                            lst_114)
                                                                                                                                                           lst_114))
                                                                                                                                                        ((rest_64)
                                                                                                                                                         (if (wrap-pair?
                                                                                                                                                              lst_114)
                                                                                                                                                           (wrap-cdr
                                                                                                                                                            lst_114)
                                                                                                                                                           null)))
                                                                                                                                             (let-values (((ids_35
                                                                                                                                                            rhss_54)
                                                                                                                                                           (let-values (((ids_36)
                                                                                                                                                                         ids_34)
                                                                                                                                                                        ((rhss_55)
                                                                                                                                                                         rhss_53))
                                                                                                                                                             (let-values (((ids_37
                                                                                                                                                                            rhss_56)
                                                                                                                                                                           (let-values ()
                                                                                                                                                                             (let-values (((ids3_0
                                                                                                                                                                                            rhss4_2)
                                                                                                                                                                                           (let-values ()
                                                                                                                                                                                             (let-values (((p_234)
                                                                                                                                                                                                           (unwrap
                                                                                                                                                                                                            v_72)))
                                                                                                                                                                                               (let-values (((ids_38)
                                                                                                                                                                                                             (let-values (((a_280)
                                                                                                                                                                                                                           (car
                                                                                                                                                                                                                            p_234)))
                                                                                                                                                                                                               (let-values (((a_281)
                                                                                                                                                                                                                             (car
                                                                                                                                                                                                                              (unwrap
                                                                                                                                                                                                                               a_280))))
                                                                                                                                                                                                                 a_281)))
                                                                                                                                                                                                            ((rhss_57)
                                                                                                                                                                                                             (let-values (((d_278)
                                                                                                                                                                                                                           (cdr
                                                                                                                                                                                                                            p_234)))
                                                                                                                                                                                                               (let-values (((a_282)
                                                                                                                                                                                                                             (car
                                                                                                                                                                                                                              (unwrap
                                                                                                                                                                                                                               d_278))))
                                                                                                                                                                                                                 a_282))))
                                                                                                                                                                                                 (values
                                                                                                                                                                                                  ids_38
                                                                                                                                                                                                  rhss_57))))))
                                                                                                                                                                               (values
                                                                                                                                                                                (cons
                                                                                                                                                                                 ids3_0
                                                                                                                                                                                 ids_36)
                                                                                                                                                                                (cons
                                                                                                                                                                                 rhss4_2
                                                                                                                                                                                 rhss_55))))))
                                                                                                                                                               (values
                                                                                                                                                                ids_37
                                                                                                                                                                rhss_56)))))
                                                                                                                                               (if (not
                                                                                                                                                    #f)
                                                                                                                                                 (for-loop_55
                                                                                                                                                  ids_35
                                                                                                                                                  rhss_54
                                                                                                                                                  rest_64)
                                                                                                                                                 (values
                                                                                                                                                  ids_35
                                                                                                                                                  rhss_54))))
                                                                                                                                           (values
                                                                                                                                            ids_34
                                                                                                                                            rhss_53)))))
                                                                                                                        for-loop_55)
                                                                                                                      null
                                                                                                                      null
                                                                                                                      lst_113)))))
                                                                                                     (values
                                                                                                      (reverse$1 ids_33)
                                                                                                      (reverse$1
                                                                                                       rhss_52)))))
                                                                                                ((bodys_25)
                                                                                                 (let-values (((d_279)
                                                                                                               (cdr
                                                                                                                p_233)))
                                                                                                   (unwrap-list
                                                                                                    d_279))))
                                                                                     (values
                                                                                      ids_32
                                                                                      rhss_51
                                                                                      bodys_25))))))
                                                                   (let-values (((new-knowns_1)
                                                                                 (let-values (((lst_115) ids_31)
                                                                                              ((lst_116) rhss_50))
                                                                                   (begin
                                                                                     (check-list lst_115)
                                                                                     (check-list lst_116)
                                                                                     ((letrec-values (((for-loop_56)
                                                                                                       (lambda (knowns_32
                                                                                                                lst_117
                                                                                                                lst_118)
                                                                                                         (if (if (pair?
                                                                                                                  lst_117)
                                                                                                               (pair?
                                                                                                                lst_118)
                                                                                                               #f)
                                                                                                           (let-values (((id_32)
                                                                                                                         (unsafe-car
                                                                                                                          lst_117))
                                                                                                                        ((rest_65)
                                                                                                                         (unsafe-cdr
                                                                                                                          lst_117))
                                                                                                                        ((rhs_36)
                                                                                                                         (unsafe-car
                                                                                                                          lst_118))
                                                                                                                        ((rest_66)
                                                                                                                         (unsafe-cdr
                                                                                                                          lst_118)))
                                                                                                             (let-values (((knowns_33)
                                                                                                                           (let-values (((knowns_34)
                                                                                                                                         knowns_32))
                                                                                                                             (let-values (((knowns_35)
                                                                                                                                           (let-values ()
                                                                                                                                             (if (lambda?
                                                                                                                                                  rhs_36)
                                                                                                                                               (hash-set
                                                                                                                                                knowns_34
                                                                                                                                                (unwrap
                                                                                                                                                 id_32)
                                                                                                                                                a-known-procedure)
                                                                                                                                               knowns_34))))
                                                                                                                               (values
                                                                                                                                knowns_35)))))
                                                                                                               (if (not
                                                                                                                    #f)
                                                                                                                 (for-loop_56
                                                                                                                  knowns_33
                                                                                                                  rest_65
                                                                                                                  rest_66)
                                                                                                                 knowns_33)))
                                                                                                           knowns_32))))
                                                                                        for-loop_56)
                                                                                      knowns_31
                                                                                      lst_115
                                                                                      lst_116)))))
                                                                     (left-to-right/let
                                                                      ids_31
                                                                      (let-values (((lst_119) rhss_50))
                                                                        (begin
                                                                          (check-list lst_119)
                                                                          ((letrec-values (((for-loop_57)
                                                                                            (lambda (lst_120)
                                                                                              (if (pair? lst_120)
                                                                                                (let-values (((rhs_37)
                                                                                                              (unsafe-car
                                                                                                               lst_120))
                                                                                                             ((rest_67)
                                                                                                              (unsafe-cdr
                                                                                                               lst_120)))
                                                                                                  (let-values (((post-guard-var_10)
                                                                                                                (lambda ()
                                                                                                                  #t)))
                                                                                                    (let-values ()
                                                                                                      (let-values (((elem_9)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (schemify_0
                                                                                                                         rhs_37)))))
                                                                                                        (let-values (((result_58)
                                                                                                                      (if (post-guard-var_10)
                                                                                                                        (for-loop_57
                                                                                                                         rest_67)
                                                                                                                        null)))
                                                                                                          (cons
                                                                                                           elem_9
                                                                                                           result_58))))))
                                                                                                null))))
                                                                             for-loop_57)
                                                                           lst_119)))
                                                                      (let-values (((lst_121) bodys_24))
                                                                        (begin
                                                                          (check-list lst_121)
                                                                          ((letrec-values (((for-loop_58)
                                                                                            (lambda (lst_122)
                                                                                              (if (pair? lst_122)
                                                                                                (let-values (((body_25)
                                                                                                              (unsafe-car
                                                                                                               lst_122))
                                                                                                             ((rest_68)
                                                                                                              (unsafe-cdr
                                                                                                               lst_122)))
                                                                                                  (let-values (((post-guard-var_11)
                                                                                                                (lambda ()
                                                                                                                  #t)))
                                                                                                    (let-values ()
                                                                                                      (let-values (((elem_10)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (schemify/knowns_0
                                                                                                                         new-knowns_1
                                                                                                                         body_25)))))
                                                                                                        (let-values (((result_59)
                                                                                                                      (if (post-guard-var_11)
                                                                                                                        (for-loop_58
                                                                                                                         rest_68)
                                                                                                                        null)))
                                                                                                          (cons
                                                                                                           elem_10
                                                                                                           result_59))))))
                                                                                                null))))
                                                                             for-loop_58)
                                                                           lst_121)))
                                                                      unannotate_5
                                                                      prim-knowns_10
                                                                      knowns_31
                                                                      imports_19
                                                                      mutated_11)))
                                                                 (if (let-values (((p_235) (unwrap v_64)))
                                                                       (if (pair? p_235)
                                                                         (if (let-values (((a_283) (car p_235)))
                                                                               (wrap-equal? 'let-values a_283))
                                                                           (let-values (((d_280) (cdr p_235)))
                                                                             (let-values (((p_236) (unwrap d_280)))
                                                                               (if (pair? p_236)
                                                                                 (if (let-values (((a_284) (car p_236)))
                                                                                       (let-values (((p_237)
                                                                                                     (unwrap a_284)))
                                                                                         (if (pair? p_237)
                                                                                           (if (let-values (((a_285)
                                                                                                             (car
                                                                                                              p_237)))
                                                                                                 (let-values (((p_238)
                                                                                                               (unwrap
                                                                                                                a_285)))
                                                                                                   (if (pair? p_238)
                                                                                                     (if (let-values (((a_286)
                                                                                                                       (car
                                                                                                                        p_238)))
                                                                                                           (wrap-equal?
                                                                                                            '()
                                                                                                            a_286))
                                                                                                       (let-values (((d_281)
                                                                                                                     (cdr
                                                                                                                      p_238)))
                                                                                                         (let-values (((p_239)
                                                                                                                       (unwrap
                                                                                                                        d_281)))
                                                                                                           (if (pair?
                                                                                                                p_239)
                                                                                                             (if (let-values (((a_287)
                                                                                                                               (car
                                                                                                                                p_239)))
                                                                                                                   (let-values (((p_240)
                                                                                                                                 (unwrap
                                                                                                                                  a_287)))
                                                                                                                     (if (pair?
                                                                                                                          p_240)
                                                                                                                       (if (let-values (((a_288)
                                                                                                                                         (car
                                                                                                                                          p_240)))
                                                                                                                             (wrap-equal?
                                                                                                                              'begin
                                                                                                                              a_288))
                                                                                                                         (let-values (((d_282)
                                                                                                                                       (cdr
                                                                                                                                        p_240)))
                                                                                                                           (let-values (((p_241)
                                                                                                                                         (unwrap
                                                                                                                                          d_282)))
                                                                                                                             (if (pair?
                                                                                                                                  p_241)
                                                                                                                               (if (let-values (((a_289)
                                                                                                                                                 (car
                                                                                                                                                  p_241)))
                                                                                                                                     #t)
                                                                                                                                 (let-values (((d_283)
                                                                                                                                               (cdr
                                                                                                                                                p_241)))
                                                                                                                                   (let-values (((p_242)
                                                                                                                                                 (unwrap
                                                                                                                                                  d_283)))
                                                                                                                                     (if (pair?
                                                                                                                                          p_242)
                                                                                                                                       (if (let-values (((a_290)
                                                                                                                                                         (car
                                                                                                                                                          p_242)))
                                                                                                                                             (wrap-equal?
                                                                                                                                              '...
                                                                                                                                              a_290))
                                                                                                                                         (let-values (((d_284)
                                                                                                                                                       (cdr
                                                                                                                                                        p_242)))
                                                                                                                                           (let-values (((p_243)
                                                                                                                                                         (unwrap
                                                                                                                                                          d_284)))
                                                                                                                                             (if (pair?
                                                                                                                                                  p_243)
                                                                                                                                               (if (let-values (((a_291)
                                                                                                                                                                 (car
                                                                                                                                                                  p_243)))
                                                                                                                                                     (let-values (((p_244)
                                                                                                                                                                   (unwrap
                                                                                                                                                                    a_291)))
                                                                                                                                                       (if (pair?
                                                                                                                                                            p_244)
                                                                                                                                                         (if (let-values (((a_292)
                                                                                                                                                                           (car
                                                                                                                                                                            p_244)))
                                                                                                                                                               (wrap-equal?
                                                                                                                                                                'values
                                                                                                                                                                a_292))
                                                                                                                                                           (let-values (((d_285)
                                                                                                                                                                         (cdr
                                                                                                                                                                          p_244)))
                                                                                                                                                             (wrap-equal?
                                                                                                                                                              '()
                                                                                                                                                              d_285))
                                                                                                                                                           #f)
                                                                                                                                                         #f)))
                                                                                                                                                 (let-values (((d_286)
                                                                                                                                                               (cdr
                                                                                                                                                                p_243)))
                                                                                                                                                   (wrap-equal?
                                                                                                                                                    '()
                                                                                                                                                    d_286))
                                                                                                                                                 #f)
                                                                                                                                               #f)))
                                                                                                                                         #f)
                                                                                                                                       #f)))
                                                                                                                                 #f)
                                                                                                                               #f)))
                                                                                                                         #f)
                                                                                                                       #f)))
                                                                                                               (let-values (((d_287)
                                                                                                                             (cdr
                                                                                                                              p_239)))
                                                                                                                 (wrap-equal?
                                                                                                                  '()
                                                                                                                  d_287))
                                                                                                               #f)
                                                                                                             #f)))
                                                                                                       #f)
                                                                                                     #f)))
                                                                                             (let-values (((d_288)
                                                                                                           (cdr p_237)))
                                                                                               (wrap-equal? '() d_288))
                                                                                             #f)
                                                                                           #f)))
                                                                                   (let-values (((d_289) (cdr p_236)))
                                                                                     (wrap-list? d_289))
                                                                                   #f)
                                                                                 #f)))
                                                                           #f)
                                                                         #f))
                                                                   (let-values (((rhss_58 bodys_26)
                                                                                 (let-values (((d_290)
                                                                                               (cdr (unwrap v_64))))
                                                                                   (let-values (((p_245)
                                                                                                 (unwrap d_290)))
                                                                                     (let-values (((rhss_59)
                                                                                                   (let-values (((a_293)
                                                                                                                 (car
                                                                                                                  p_245)))
                                                                                                     (let-values (((a_294)
                                                                                                                   (car
                                                                                                                    (unwrap
                                                                                                                     a_293))))
                                                                                                       (let-values (((d_291)
                                                                                                                     (cdr
                                                                                                                      (unwrap
                                                                                                                       a_294))))
                                                                                                         (let-values (((a_295)
                                                                                                                       (car
                                                                                                                        (unwrap
                                                                                                                         d_291))))
                                                                                                           (let-values (((d_292)
                                                                                                                         (cdr
                                                                                                                          (unwrap
                                                                                                                           a_295))))
                                                                                                             (let-values (((a_296)
                                                                                                                           (car
                                                                                                                            (unwrap
                                                                                                                             d_292))))
                                                                                                               a_296)))))))
                                                                                                  ((bodys_27)
                                                                                                   (let-values (((d_293)
                                                                                                                 (cdr
                                                                                                                  p_245)))
                                                                                                     (unwrap-list
                                                                                                      d_293))))
                                                                                       (values rhss_59 bodys_27))))))
                                                                     (list*
                                                                      'begin
                                                                      (qq-append
                                                                       (map2 schemify_0 rhss_58)
                                                                       (map2 schemify_0 bodys_26))))
                                                                   (if (let-values (((p_246) (unwrap v_64)))
                                                                         (if (pair? p_246)
                                                                           (if (let-values (((a_297) (car p_246)))
                                                                                 (wrap-equal? 'let-values a_297))
                                                                             (let-values (((d_294) (cdr p_246)))
                                                                               (let-values (((p_247) (unwrap d_294)))
                                                                                 (if (pair? p_247)
                                                                                   (if (let-values (((a_298)
                                                                                                     (car p_247)))
                                                                                         (if (wrap-list? a_298)
                                                                                           (let-values (((lst_123)
                                                                                                         a_298))
                                                                                             (begin
                                                                                               (void)
                                                                                               ((letrec-values (((for-loop_59)
                                                                                                                 (lambda (result_60
                                                                                                                          lst_124)
                                                                                                                   (if (not
                                                                                                                        (wrap-null?
                                                                                                                         lst_124))
                                                                                                                     (let-values (((v_73)
                                                                                                                                   (if (wrap-pair?
                                                                                                                                        lst_124)
                                                                                                                                     (wrap-car
                                                                                                                                      lst_124)
                                                                                                                                     lst_124))
                                                                                                                                  ((rest_69)
                                                                                                                                   (if (wrap-pair?
                                                                                                                                        lst_124)
                                                                                                                                     (wrap-cdr
                                                                                                                                      lst_124)
                                                                                                                                     null)))
                                                                                                                       (let-values (((result_61)
                                                                                                                                     (let-values ()
                                                                                                                                       (let-values (((result_62)
                                                                                                                                                     (let-values ()
                                                                                                                                                       (let-values ()
                                                                                                                                                         (let-values (((p_248)
                                                                                                                                                                       (unwrap
                                                                                                                                                                        v_73)))
                                                                                                                                                           (if (pair?
                                                                                                                                                                p_248)
                                                                                                                                                             (if (let-values (((a_299)
                                                                                                                                                                               (car
                                                                                                                                                                                p_248)))
                                                                                                                                                                   #t)
                                                                                                                                                               (let-values (((d_295)
                                                                                                                                                                             (cdr
                                                                                                                                                                              p_248)))
                                                                                                                                                                 (let-values (((p_249)
                                                                                                                                                                               (unwrap
                                                                                                                                                                                d_295)))
                                                                                                                                                                   (if (pair?
                                                                                                                                                                        p_249)
                                                                                                                                                                     (if (let-values (((a_300)
                                                                                                                                                                                       (car
                                                                                                                                                                                        p_249)))
                                                                                                                                                                           #t)
                                                                                                                                                                       (let-values (((d_296)
                                                                                                                                                                                     (cdr
                                                                                                                                                                                      p_249)))
                                                                                                                                                                         (wrap-equal?
                                                                                                                                                                          '()
                                                                                                                                                                          d_296))
                                                                                                                                                                       #f)
                                                                                                                                                                     #f)))
                                                                                                                                                               #f)
                                                                                                                                                             #f))))))
                                                                                                                                         (values
                                                                                                                                          result_62)))))
                                                                                                                         (if (if (not
                                                                                                                                  ((lambda x_20
                                                                                                                                     (not
                                                                                                                                      result_61))
                                                                                                                                   v_73))
                                                                                                                               (not
                                                                                                                                #f)
                                                                                                                               #f)
                                                                                                                           (for-loop_59
                                                                                                                            result_61
                                                                                                                            rest_69)
                                                                                                                           result_61)))
                                                                                                                     result_60))))
                                                                                                  for-loop_59)
                                                                                                #t
                                                                                                lst_123)))
                                                                                           #f))
                                                                                     (let-values (((d_297) (cdr p_247)))
                                                                                       (wrap-list? d_297))
                                                                                     #f)
                                                                                   #f)))
                                                                             #f)
                                                                           #f))
                                                                     (let-values (((idss_26 rhss_60 bodys_28)
                                                                                   (let-values (((d_298)
                                                                                                 (cdr (unwrap v_64))))
                                                                                     (let-values (((p_250)
                                                                                                   (unwrap d_298)))
                                                                                       (let-values (((idss_27 rhss_61)
                                                                                                     (let-values (((a_301)
                                                                                                                   (car
                                                                                                                    p_250)))
                                                                                                       (let-values (((idss_28
                                                                                                                      rhss_62)
                                                                                                                     (let-values (((lst_125)
                                                                                                                                   a_301))
                                                                                                                       (begin
                                                                                                                         (void)
                                                                                                                         ((letrec-values (((for-loop_60)
                                                                                                                                           (lambda (idss_29
                                                                                                                                                    rhss_63
                                                                                                                                                    lst_126)
                                                                                                                                             (if (not
                                                                                                                                                  (wrap-null?
                                                                                                                                                   lst_126))
                                                                                                                                               (let-values (((v_74)
                                                                                                                                                             (if (wrap-pair?
                                                                                                                                                                  lst_126)
                                                                                                                                                               (wrap-car
                                                                                                                                                                lst_126)
                                                                                                                                                               lst_126))
                                                                                                                                                            ((rest_70)
                                                                                                                                                             (if (wrap-pair?
                                                                                                                                                                  lst_126)
                                                                                                                                                               (wrap-cdr
                                                                                                                                                                lst_126)
                                                                                                                                                               null)))
                                                                                                                                                 (let-values (((idss_30
                                                                                                                                                                rhss_64)
                                                                                                                                                               (let-values (((idss_31)
                                                                                                                                                                             idss_29)
                                                                                                                                                                            ((rhss_65)
                                                                                                                                                                             rhss_63))
                                                                                                                                                                 (let-values (((idss_32
                                                                                                                                                                                rhss_66)
                                                                                                                                                                               (let-values ()
                                                                                                                                                                                 (let-values (((idss5_1
                                                                                                                                                                                                rhss6_2)
                                                                                                                                                                                               (let-values ()
                                                                                                                                                                                                 (let-values (((p_251)
                                                                                                                                                                                                               (unwrap
                                                                                                                                                                                                                v_74)))
                                                                                                                                                                                                   (let-values (((idss_33)
                                                                                                                                                                                                                 (let-values (((a_302)
                                                                                                                                                                                                                               (car
                                                                                                                                                                                                                                p_251)))
                                                                                                                                                                                                                   a_302))
                                                                                                                                                                                                                ((rhss_67)
                                                                                                                                                                                                                 (let-values (((d_299)
                                                                                                                                                                                                                               (cdr
                                                                                                                                                                                                                                p_251)))
                                                                                                                                                                                                                   (let-values (((a_303)
                                                                                                                                                                                                                                 (car
                                                                                                                                                                                                                                  (unwrap
                                                                                                                                                                                                                                   d_299))))
                                                                                                                                                                                                                     a_303))))
                                                                                                                                                                                                     (values
                                                                                                                                                                                                      idss_33
                                                                                                                                                                                                      rhss_67))))))
                                                                                                                                                                                   (values
                                                                                                                                                                                    (cons
                                                                                                                                                                                     idss5_1
                                                                                                                                                                                     idss_31)
                                                                                                                                                                                    (cons
                                                                                                                                                                                     rhss6_2
                                                                                                                                                                                     rhss_65))))))
                                                                                                                                                                   (values
                                                                                                                                                                    idss_32
                                                                                                                                                                    rhss_66)))))
                                                                                                                                                   (if (not
                                                                                                                                                        #f)
                                                                                                                                                     (for-loop_60
                                                                                                                                                      idss_30
                                                                                                                                                      rhss_64
                                                                                                                                                      rest_70)
                                                                                                                                                     (values
                                                                                                                                                      idss_30
                                                                                                                                                      rhss_64))))
                                                                                                                                               (values
                                                                                                                                                idss_29
                                                                                                                                                rhss_63)))))
                                                                                                                            for-loop_60)
                                                                                                                          null
                                                                                                                          null
                                                                                                                          lst_125)))))
                                                                                                         (values
                                                                                                          (reverse$1
                                                                                                           idss_28)
                                                                                                          (reverse$1
                                                                                                           rhss_62)))))
                                                                                                    ((bodys_29)
                                                                                                     (let-values (((d_300)
                                                                                                                   (cdr
                                                                                                                    p_250)))
                                                                                                       (unwrap-list
                                                                                                        d_300))))
                                                                                         (values
                                                                                          idss_27
                                                                                          rhss_61
                                                                                          bodys_29))))))
                                                                       (left-to-right/let-values
                                                                        idss_26
                                                                        (let-values (((lst_127) rhss_60))
                                                                          (begin
                                                                            (check-list lst_127)
                                                                            ((letrec-values (((for-loop_61)
                                                                                              (lambda (lst_128)
                                                                                                (if (pair? lst_128)
                                                                                                  (let-values (((rhs_38)
                                                                                                                (unsafe-car
                                                                                                                 lst_128))
                                                                                                               ((rest_71)
                                                                                                                (unsafe-cdr
                                                                                                                 lst_128)))
                                                                                                    (let-values (((post-guard-var_12)
                                                                                                                  (lambda ()
                                                                                                                    #t)))
                                                                                                      (let-values ()
                                                                                                        (let-values (((elem_11)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (schemify_0
                                                                                                                           rhs_38)))))
                                                                                                          (let-values (((result_63)
                                                                                                                        (if (post-guard-var_12)
                                                                                                                          (for-loop_61
                                                                                                                           rest_71)
                                                                                                                          null)))
                                                                                                            (cons
                                                                                                             elem_11
                                                                                                             result_63))))))
                                                                                                  null))))
                                                                               for-loop_61)
                                                                             lst_127)))
                                                                        (map2 schemify_0 bodys_28)
                                                                        mutated_11))
                                                                     (if (let-values (((p_252) (unwrap v_64)))
                                                                           (if (pair? p_252)
                                                                             (if (let-values (((a_304) (car p_252)))
                                                                                   (wrap-equal? 'letrec-values a_304))
                                                                               (let-values (((d_301) (cdr p_252)))
                                                                                 (let-values (((p_253) (unwrap d_301)))
                                                                                   (if (pair? p_253)
                                                                                     (if (let-values (((a_305)
                                                                                                       (car p_253)))
                                                                                           (if (wrap-list? a_305)
                                                                                             (let-values (((lst_129)
                                                                                                           a_305))
                                                                                               (begin
                                                                                                 (void)
                                                                                                 ((letrec-values (((for-loop_62)
                                                                                                                   (lambda (result_64
                                                                                                                            lst_130)
                                                                                                                     (if (not
                                                                                                                          (wrap-null?
                                                                                                                           lst_130))
                                                                                                                       (let-values (((v_75)
                                                                                                                                     (if (wrap-pair?
                                                                                                                                          lst_130)
                                                                                                                                       (wrap-car
                                                                                                                                        lst_130)
                                                                                                                                       lst_130))
                                                                                                                                    ((rest_72)
                                                                                                                                     (if (wrap-pair?
                                                                                                                                          lst_130)
                                                                                                                                       (wrap-cdr
                                                                                                                                        lst_130)
                                                                                                                                       null)))
                                                                                                                         (let-values (((result_65)
                                                                                                                                       (let-values ()
                                                                                                                                         (let-values (((result_66)
                                                                                                                                                       (let-values ()
                                                                                                                                                         (let-values ()
                                                                                                                                                           (let-values (((p_254)
                                                                                                                                                                         (unwrap
                                                                                                                                                                          v_75)))
                                                                                                                                                             (if (pair?
                                                                                                                                                                  p_254)
                                                                                                                                                               (if (let-values (((a_306)
                                                                                                                                                                                 (car
                                                                                                                                                                                  p_254)))
                                                                                                                                                                     (let-values (((p_255)
                                                                                                                                                                                   (unwrap
                                                                                                                                                                                    a_306)))
                                                                                                                                                                       (if (pair?
                                                                                                                                                                            p_255)
                                                                                                                                                                         (if (let-values (((a_307)
                                                                                                                                                                                           (car
                                                                                                                                                                                            p_255)))
                                                                                                                                                                               #t)
                                                                                                                                                                           (let-values (((d_302)
                                                                                                                                                                                         (cdr
                                                                                                                                                                                          p_255)))
                                                                                                                                                                             (wrap-equal?
                                                                                                                                                                              '()
                                                                                                                                                                              d_302))
                                                                                                                                                                           #f)
                                                                                                                                                                         #f)))
                                                                                                                                                                 (let-values (((d_303)
                                                                                                                                                                               (cdr
                                                                                                                                                                                p_254)))
                                                                                                                                                                   (let-values (((p_256)
                                                                                                                                                                                 (unwrap
                                                                                                                                                                                  d_303)))
                                                                                                                                                                     (if (pair?
                                                                                                                                                                          p_256)
                                                                                                                                                                       (if (let-values (((a_308)
                                                                                                                                                                                         (car
                                                                                                                                                                                          p_256)))
                                                                                                                                                                             #t)
                                                                                                                                                                         (let-values (((d_304)
                                                                                                                                                                                       (cdr
                                                                                                                                                                                        p_256)))
                                                                                                                                                                           (wrap-equal?
                                                                                                                                                                            '()
                                                                                                                                                                            d_304))
                                                                                                                                                                         #f)
                                                                                                                                                                       #f)))
                                                                                                                                                                 #f)
                                                                                                                                                               #f))))))
                                                                                                                                           (values
                                                                                                                                            result_66)))))
                                                                                                                           (if (if (not
                                                                                                                                    ((lambda x_21
                                                                                                                                       (not
                                                                                                                                        result_65))
                                                                                                                                     v_75))
                                                                                                                                 (not
                                                                                                                                  #f)
                                                                                                                                 #f)
                                                                                                                             (for-loop_62
                                                                                                                              result_65
                                                                                                                              rest_72)
                                                                                                                             result_65)))
                                                                                                                       result_64))))
                                                                                                    for-loop_62)
                                                                                                  #t
                                                                                                  lst_129)))
                                                                                             #f))
                                                                                       (let-values (((d_305)
                                                                                                     (cdr p_253)))
                                                                                         (wrap-list? d_305))
                                                                                       #f)
                                                                                     #f)))
                                                                               #f)
                                                                             #f))
                                                                       (let-values (((ids_39 rhss_68 bodys_30)
                                                                                     (let-values (((d_306)
                                                                                                   (cdr (unwrap v_64))))
                                                                                       (let-values (((p_257)
                                                                                                     (unwrap d_306)))
                                                                                         (let-values (((ids_40 rhss_69)
                                                                                                       (let-values (((a_309)
                                                                                                                     (car
                                                                                                                      p_257)))
                                                                                                         (let-values (((ids_41
                                                                                                                        rhss_70)
                                                                                                                       (let-values (((lst_131)
                                                                                                                                     a_309))
                                                                                                                         (begin
                                                                                                                           (void)
                                                                                                                           ((letrec-values (((for-loop_63)
                                                                                                                                             (lambda (ids_42
                                                                                                                                                      rhss_71
                                                                                                                                                      lst_132)
                                                                                                                                               (if (not
                                                                                                                                                    (wrap-null?
                                                                                                                                                     lst_132))
                                                                                                                                                 (let-values (((v_76)
                                                                                                                                                               (if (wrap-pair?
                                                                                                                                                                    lst_132)
                                                                                                                                                                 (wrap-car
                                                                                                                                                                  lst_132)
                                                                                                                                                                 lst_132))
                                                                                                                                                              ((rest_73)
                                                                                                                                                               (if (wrap-pair?
                                                                                                                                                                    lst_132)
                                                                                                                                                                 (wrap-cdr
                                                                                                                                                                  lst_132)
                                                                                                                                                                 null)))
                                                                                                                                                   (let-values (((ids_43
                                                                                                                                                                  rhss_72)
                                                                                                                                                                 (let-values (((ids_44)
                                                                                                                                                                               ids_42)
                                                                                                                                                                              ((rhss_73)
                                                                                                                                                                               rhss_71))
                                                                                                                                                                   (let-values (((ids_45
                                                                                                                                                                                  rhss_74)
                                                                                                                                                                                 (let-values ()
                                                                                                                                                                                   (let-values (((ids7_0
                                                                                                                                                                                                  rhss8_0)
                                                                                                                                                                                                 (let-values ()
                                                                                                                                                                                                   (let-values (((p_258)
                                                                                                                                                                                                                 (unwrap
                                                                                                                                                                                                                  v_76)))
                                                                                                                                                                                                     (let-values (((ids_46)
                                                                                                                                                                                                                   (let-values (((a_310)
                                                                                                                                                                                                                                 (car
                                                                                                                                                                                                                                  p_258)))
                                                                                                                                                                                                                     (let-values (((a_311)
                                                                                                                                                                                                                                   (car
                                                                                                                                                                                                                                    (unwrap
                                                                                                                                                                                                                                     a_310))))
                                                                                                                                                                                                                       a_311)))
                                                                                                                                                                                                                  ((rhss_75)
                                                                                                                                                                                                                   (let-values (((d_307)
                                                                                                                                                                                                                                 (cdr
                                                                                                                                                                                                                                  p_258)))
                                                                                                                                                                                                                     (let-values (((a_312)
                                                                                                                                                                                                                                   (car
                                                                                                                                                                                                                                    (unwrap
                                                                                                                                                                                                                                     d_307))))
                                                                                                                                                                                                                       a_312))))
                                                                                                                                                                                                       (values
                                                                                                                                                                                                        ids_46
                                                                                                                                                                                                        rhss_75))))))
                                                                                                                                                                                     (values
                                                                                                                                                                                      (cons
                                                                                                                                                                                       ids7_0
                                                                                                                                                                                       ids_44)
                                                                                                                                                                                      (cons
                                                                                                                                                                                       rhss8_0
                                                                                                                                                                                       rhss_73))))))
                                                                                                                                                                     (values
                                                                                                                                                                      ids_45
                                                                                                                                                                      rhss_74)))))
                                                                                                                                                     (if (not
                                                                                                                                                          #f)
                                                                                                                                                       (for-loop_63
                                                                                                                                                        ids_43
                                                                                                                                                        rhss_72
                                                                                                                                                        rest_73)
                                                                                                                                                       (values
                                                                                                                                                        ids_43
                                                                                                                                                        rhss_72))))
                                                                                                                                                 (values
                                                                                                                                                  ids_42
                                                                                                                                                  rhss_71)))))
                                                                                                                              for-loop_63)
                                                                                                                            null
                                                                                                                            null
                                                                                                                            lst_131)))))
                                                                                                           (values
                                                                                                            (reverse$1
                                                                                                             ids_41)
                                                                                                            (reverse$1
                                                                                                             rhss_70)))))
                                                                                                      ((bodys_31)
                                                                                                       (let-values (((d_308)
                                                                                                                     (cdr
                                                                                                                      p_257)))
                                                                                                         (unwrap-list
                                                                                                          d_308))))
                                                                                           (values
                                                                                            ids_40
                                                                                            rhss_69
                                                                                            bodys_31))))))
                                                                         (let-values (((new-knowns_2)
                                                                                       (let-values (((lst_133) ids_39)
                                                                                                    ((lst_134) rhss_68))
                                                                                         (begin
                                                                                           (check-list lst_133)
                                                                                           (check-list lst_134)
                                                                                           ((letrec-values (((for-loop_64)
                                                                                                             (lambda (knowns_36
                                                                                                                      lst_135
                                                                                                                      lst_136)
                                                                                                               (if (if (pair?
                                                                                                                        lst_135)
                                                                                                                     (pair?
                                                                                                                      lst_136)
                                                                                                                     #f)
                                                                                                                 (let-values (((id_33)
                                                                                                                               (unsafe-car
                                                                                                                                lst_135))
                                                                                                                              ((rest_74)
                                                                                                                               (unsafe-cdr
                                                                                                                                lst_135))
                                                                                                                              ((rhs_39)
                                                                                                                               (unsafe-car
                                                                                                                                lst_136))
                                                                                                                              ((rest_75)
                                                                                                                               (unsafe-cdr
                                                                                                                                lst_136)))
                                                                                                                   (let-values (((knowns_37)
                                                                                                                                 (let-values (((knowns_38)
                                                                                                                                               knowns_36))
                                                                                                                                   (let-values (((knowns_39)
                                                                                                                                                 (let-values ()
                                                                                                                                                   (if (lambda?
                                                                                                                                                        rhs_39)
                                                                                                                                                     (hash-set
                                                                                                                                                      knowns_38
                                                                                                                                                      (unwrap
                                                                                                                                                       id_33)
                                                                                                                                                      a-known-procedure)
                                                                                                                                                     knowns_38))))
                                                                                                                                     (values
                                                                                                                                      knowns_39)))))
                                                                                                                     (if (not
                                                                                                                          #f)
                                                                                                                       (for-loop_64
                                                                                                                        knowns_37
                                                                                                                        rest_74
                                                                                                                        rest_75)
                                                                                                                       knowns_37)))
                                                                                                                 knowns_36))))
                                                                                              for-loop_64)
                                                                                            knowns_31
                                                                                            lst_133
                                                                                            lst_134)))))
                                                                           (list*
                                                                            'letrec*
                                                                            (let-values (((lst_137) ids_39)
                                                                                         ((lst_138) rhss_68))
                                                                              (begin
                                                                                (check-list lst_137)
                                                                                (check-list lst_138)
                                                                                ((letrec-values (((for-loop_65)
                                                                                                  (lambda (lst_139
                                                                                                           lst_140)
                                                                                                    (if (if (pair?
                                                                                                             lst_139)
                                                                                                          (pair?
                                                                                                           lst_140)
                                                                                                          #f)
                                                                                                      (let-values (((id_34)
                                                                                                                    (unsafe-car
                                                                                                                     lst_139))
                                                                                                                   ((rest_76)
                                                                                                                    (unsafe-cdr
                                                                                                                     lst_139))
                                                                                                                   ((rhs_40)
                                                                                                                    (unsafe-car
                                                                                                                     lst_140))
                                                                                                                   ((rest_77)
                                                                                                                    (unsafe-cdr
                                                                                                                     lst_140)))
                                                                                                        (let-values (((post-guard-var_13)
                                                                                                                      (lambda ()
                                                                                                                        #t)))
                                                                                                          (let-values ()
                                                                                                            (let-values (((elem_12)
                                                                                                                          (let-values ()
                                                                                                                            (let-values ()
                                                                                                                              (list
                                                                                                                               id_34
                                                                                                                               (schemify/knowns_0
                                                                                                                                new-knowns_2
                                                                                                                                rhs_40))))))
                                                                                                              (let-values (((result_67)
                                                                                                                            (if (post-guard-var_13)
                                                                                                                              (for-loop_65
                                                                                                                               rest_76
                                                                                                                               rest_77)
                                                                                                                              null)))
                                                                                                                (cons
                                                                                                                 elem_12
                                                                                                                 result_67))))))
                                                                                                      null))))
                                                                                   for-loop_65)
                                                                                 lst_137
                                                                                 lst_138)))
                                                                            (let-values (((lst_141) bodys_30))
                                                                              (begin
                                                                                (check-list lst_141)
                                                                                ((letrec-values (((for-loop_66)
                                                                                                  (lambda (lst_142)
                                                                                                    (if (pair? lst_142)
                                                                                                      (let-values (((body_26)
                                                                                                                    (unsafe-car
                                                                                                                     lst_142))
                                                                                                                   ((rest_78)
                                                                                                                    (unsafe-cdr
                                                                                                                     lst_142)))
                                                                                                        (let-values (((post-guard-var_14)
                                                                                                                      (lambda ()
                                                                                                                        #t)))
                                                                                                          (let-values ()
                                                                                                            (let-values (((elem_13)
                                                                                                                          (let-values ()
                                                                                                                            (let-values ()
                                                                                                                              (schemify/knowns_0
                                                                                                                               new-knowns_2
                                                                                                                               body_26)))))
                                                                                                              (let-values (((result_68)
                                                                                                                            (if (post-guard-var_14)
                                                                                                                              (for-loop_66
                                                                                                                               rest_78)
                                                                                                                              null)))
                                                                                                                (cons
                                                                                                                 elem_13
                                                                                                                 result_68))))))
                                                                                                      null))))
                                                                                   for-loop_66)
                                                                                 lst_141))))))
                                                                       (if (let-values (((p_259) (unwrap v_64)))
                                                                             (if (pair? p_259)
                                                                               (if (let-values (((a_313) (car p_259)))
                                                                                     (wrap-equal? 'letrec-values a_313))
                                                                                 (let-values (((d_309) (cdr p_259)))
                                                                                   (let-values (((p_260)
                                                                                                 (unwrap d_309)))
                                                                                     (if (pair? p_260)
                                                                                       (if (let-values (((a_314)
                                                                                                         (car p_260)))
                                                                                             (if (wrap-list? a_314)
                                                                                               (let-values (((lst_143)
                                                                                                             a_314))
                                                                                                 (begin
                                                                                                   (void)
                                                                                                   ((letrec-values (((for-loop_67)
                                                                                                                     (lambda (result_69
                                                                                                                              lst_144)
                                                                                                                       (if (not
                                                                                                                            (wrap-null?
                                                                                                                             lst_144))
                                                                                                                         (let-values (((v_77)
                                                                                                                                       (if (wrap-pair?
                                                                                                                                            lst_144)
                                                                                                                                         (wrap-car
                                                                                                                                          lst_144)
                                                                                                                                         lst_144))
                                                                                                                                      ((rest_79)
                                                                                                                                       (if (wrap-pair?
                                                                                                                                            lst_144)
                                                                                                                                         (wrap-cdr
                                                                                                                                          lst_144)
                                                                                                                                         null)))
                                                                                                                           (let-values (((result_70)
                                                                                                                                         (let-values ()
                                                                                                                                           (let-values (((result_71)
                                                                                                                                                         (let-values ()
                                                                                                                                                           (let-values ()
                                                                                                                                                             (let-values (((p_261)
                                                                                                                                                                           (unwrap
                                                                                                                                                                            v_77)))
                                                                                                                                                               (if (pair?
                                                                                                                                                                    p_261)
                                                                                                                                                                 (if (let-values (((a_315)
                                                                                                                                                                                   (car
                                                                                                                                                                                    p_261)))
                                                                                                                                                                       #t)
                                                                                                                                                                   (let-values (((d_310)
                                                                                                                                                                                 (cdr
                                                                                                                                                                                  p_261)))
                                                                                                                                                                     (let-values (((p_262)
                                                                                                                                                                                   (unwrap
                                                                                                                                                                                    d_310)))
                                                                                                                                                                       (if (pair?
                                                                                                                                                                            p_262)
                                                                                                                                                                         (if (let-values (((a_316)
                                                                                                                                                                                           (car
                                                                                                                                                                                            p_262)))
                                                                                                                                                                               #t)
                                                                                                                                                                           (let-values (((d_311)
                                                                                                                                                                                         (cdr
                                                                                                                                                                                          p_262)))
                                                                                                                                                                             (wrap-equal?
                                                                                                                                                                              '()
                                                                                                                                                                              d_311))
                                                                                                                                                                           #f)
                                                                                                                                                                         #f)))
                                                                                                                                                                   #f)
                                                                                                                                                                 #f))))))
                                                                                                                                             (values
                                                                                                                                              result_71)))))
                                                                                                                             (if (if (not
                                                                                                                                      ((lambda x_22
                                                                                                                                         (not
                                                                                                                                          result_70))
                                                                                                                                       v_77))
                                                                                                                                   (not
                                                                                                                                    #f)
                                                                                                                                   #f)
                                                                                                                               (for-loop_67
                                                                                                                                result_70
                                                                                                                                rest_79)
                                                                                                                               result_70)))
                                                                                                                         result_69))))
                                                                                                      for-loop_67)
                                                                                                    #t
                                                                                                    lst_143)))
                                                                                               #f))
                                                                                         (let-values (((d_312)
                                                                                                       (cdr p_260)))
                                                                                           (wrap-list? d_312))
                                                                                         #f)
                                                                                       #f)))
                                                                                 #f)
                                                                               #f))
                                                                         (let-values (((idss_34 rhss_76 bodys_32)
                                                                                       (let-values (((d_313)
                                                                                                     (cdr
                                                                                                      (unwrap v_64))))
                                                                                         (let-values (((p_263)
                                                                                                       (unwrap d_313)))
                                                                                           (let-values (((idss_35
                                                                                                          rhss_77)
                                                                                                         (let-values (((a_317)
                                                                                                                       (car
                                                                                                                        p_263)))
                                                                                                           (let-values (((idss_36
                                                                                                                          rhss_78)
                                                                                                                         (let-values (((lst_145)
                                                                                                                                       a_317))
                                                                                                                           (begin
                                                                                                                             (void)
                                                                                                                             ((letrec-values (((for-loop_68)
                                                                                                                                               (lambda (idss_37
                                                                                                                                                        rhss_79
                                                                                                                                                        lst_146)
                                                                                                                                                 (if (not
                                                                                                                                                      (wrap-null?
                                                                                                                                                       lst_146))
                                                                                                                                                   (let-values (((v_78)
                                                                                                                                                                 (if (wrap-pair?
                                                                                                                                                                      lst_146)
                                                                                                                                                                   (wrap-car
                                                                                                                                                                    lst_146)
                                                                                                                                                                   lst_146))
                                                                                                                                                                ((rest_80)
                                                                                                                                                                 (if (wrap-pair?
                                                                                                                                                                      lst_146)
                                                                                                                                                                   (wrap-cdr
                                                                                                                                                                    lst_146)
                                                                                                                                                                   null)))
                                                                                                                                                     (let-values (((idss_38
                                                                                                                                                                    rhss_80)
                                                                                                                                                                   (let-values (((idss_39)
                                                                                                                                                                                 idss_37)
                                                                                                                                                                                ((rhss_81)
                                                                                                                                                                                 rhss_79))
                                                                                                                                                                     (let-values (((idss_40
                                                                                                                                                                                    rhss_82)
                                                                                                                                                                                   (let-values ()
                                                                                                                                                                                     (let-values (((idss9_0
                                                                                                                                                                                                    rhss10_0)
                                                                                                                                                                                                   (let-values ()
                                                                                                                                                                                                     (let-values (((p_264)
                                                                                                                                                                                                                   (unwrap
                                                                                                                                                                                                                    v_78)))
                                                                                                                                                                                                       (let-values (((idss_41)
                                                                                                                                                                                                                     (let-values (((a_318)
                                                                                                                                                                                                                                   (car
                                                                                                                                                                                                                                    p_264)))
                                                                                                                                                                                                                       a_318))
                                                                                                                                                                                                                    ((rhss_83)
                                                                                                                                                                                                                     (let-values (((d_314)
                                                                                                                                                                                                                                   (cdr
                                                                                                                                                                                                                                    p_264)))
                                                                                                                                                                                                                       (let-values (((a_319)
                                                                                                                                                                                                                                     (car
                                                                                                                                                                                                                                      (unwrap
                                                                                                                                                                                                                                       d_314))))
                                                                                                                                                                                                                         a_319))))
                                                                                                                                                                                                         (values
                                                                                                                                                                                                          idss_41
                                                                                                                                                                                                          rhss_83))))))
                                                                                                                                                                                       (values
                                                                                                                                                                                        (cons
                                                                                                                                                                                         idss9_0
                                                                                                                                                                                         idss_39)
                                                                                                                                                                                        (cons
                                                                                                                                                                                         rhss10_0
                                                                                                                                                                                         rhss_81))))))
                                                                                                                                                                       (values
                                                                                                                                                                        idss_40
                                                                                                                                                                        rhss_82)))))
                                                                                                                                                       (if (not
                                                                                                                                                            #f)
                                                                                                                                                         (for-loop_68
                                                                                                                                                          idss_38
                                                                                                                                                          rhss_80
                                                                                                                                                          rest_80)
                                                                                                                                                         (values
                                                                                                                                                          idss_38
                                                                                                                                                          rhss_80))))
                                                                                                                                                   (values
                                                                                                                                                    idss_37
                                                                                                                                                    rhss_79)))))
                                                                                                                                for-loop_68)
                                                                                                                              null
                                                                                                                              null
                                                                                                                              lst_145)))))
                                                                                                             (values
                                                                                                              (reverse$1
                                                                                                               idss_36)
                                                                                                              (reverse$1
                                                                                                               rhss_78)))))
                                                                                                        ((bodys_33)
                                                                                                         (let-values (((d_315)
                                                                                                                       (cdr
                                                                                                                        p_263)))
                                                                                                           (unwrap-list
                                                                                                            d_315))))
                                                                                             (values
                                                                                              idss_35
                                                                                              rhss_77
                                                                                              bodys_33))))))
                                                                           (list*
                                                                            'letrec*
                                                                            (apply
                                                                             append
                                                                             (let-values (((lst_147) idss_34)
                                                                                          ((lst_148) rhss_76))
                                                                               (begin
                                                                                 (void)
                                                                                 (check-list lst_148)
                                                                                 ((letrec-values (((for-loop_69)
                                                                                                   (lambda (lst_149
                                                                                                            lst_150)
                                                                                                     (if (if (not
                                                                                                              (wrap-null?
                                                                                                               lst_149))
                                                                                                           (pair?
                                                                                                            lst_150)
                                                                                                           #f)
                                                                                                       (let-values (((ids_47)
                                                                                                                     (if (wrap-pair?
                                                                                                                          lst_149)
                                                                                                                       (wrap-car
                                                                                                                        lst_149)
                                                                                                                       lst_149))
                                                                                                                    ((rest_81)
                                                                                                                     (if (wrap-pair?
                                                                                                                          lst_149)
                                                                                                                       (wrap-cdr
                                                                                                                        lst_149)
                                                                                                                       null))
                                                                                                                    ((rhs_41)
                                                                                                                     (unsafe-car
                                                                                                                      lst_150))
                                                                                                                    ((rest_82)
                                                                                                                     (unsafe-cdr
                                                                                                                      lst_150)))
                                                                                                         (let-values (((post-guard-var_15)
                                                                                                                       (lambda ()
                                                                                                                         #t)))
                                                                                                           (let-values ()
                                                                                                             (let-values (((elem_14)
                                                                                                                           (let-values ()
                                                                                                                             (let-values ()
                                                                                                                               (let-values (((rhs_42)
                                                                                                                                             (schemify_0
                                                                                                                                              rhs_41)))
                                                                                                                                 (if (null?
                                                                                                                                      ids_47)
                                                                                                                                   (let-values ()
                                                                                                                                     (list
                                                                                                                                      (list
                                                                                                                                       (gensym
                                                                                                                                        "lr")
                                                                                                                                       (make-let-values
                                                                                                                                        null
                                                                                                                                        rhs_42
                                                                                                                                        '(void)))))
                                                                                                                                   (if (if (pair?
                                                                                                                                            ids_47)
                                                                                                                                         (null?
                                                                                                                                          (cdr
                                                                                                                                           ids_47))
                                                                                                                                         #f)
                                                                                                                                     (let-values ()
                                                                                                                                       (list
                                                                                                                                        (list
                                                                                                                                         (car
                                                                                                                                          ids_47)
                                                                                                                                         rhs_42)))
                                                                                                                                     (let-values ()
                                                                                                                                       (let-values (((lr_0)
                                                                                                                                                     (gensym
                                                                                                                                                      "lr")))
                                                                                                                                         (list*
                                                                                                                                          (list
                                                                                                                                           lr_0
                                                                                                                                           (make-let-values
                                                                                                                                            ids_47
                                                                                                                                            rhs_42
                                                                                                                                            (list*
                                                                                                                                             'vector
                                                                                                                                             ids_47)))
                                                                                                                                          (let-values (((lst_151)
                                                                                                                                                        ids_47)
                                                                                                                                                       ((start_3)
                                                                                                                                                        0))
                                                                                                                                            (begin
                                                                                                                                              (check-list
                                                                                                                                               lst_151)
                                                                                                                                              (check-naturals
                                                                                                                                               start_3)
                                                                                                                                              ((letrec-values (((for-loop_70)
                                                                                                                                                                (lambda (lst_152
                                                                                                                                                                         pos_6)
                                                                                                                                                                  (if (if (pair?
                                                                                                                                                                           lst_152)
                                                                                                                                                                        #t
                                                                                                                                                                        #f)
                                                                                                                                                                    (let-values (((id_35)
                                                                                                                                                                                  (unsafe-car
                                                                                                                                                                                   lst_152))
                                                                                                                                                                                 ((rest_83)
                                                                                                                                                                                  (unsafe-cdr
                                                                                                                                                                                   lst_152))
                                                                                                                                                                                 ((pos_7)
                                                                                                                                                                                  pos_6))
                                                                                                                                                                      (let-values (((post-guard-var_16)
                                                                                                                                                                                    (lambda ()
                                                                                                                                                                                      #t)))
                                                                                                                                                                        (let-values ()
                                                                                                                                                                          (let-values (((elem_15)
                                                                                                                                                                                        (let-values ()
                                                                                                                                                                                          (let-values ()
                                                                                                                                                                                            (list
                                                                                                                                                                                             id_35
                                                                                                                                                                                             (list
                                                                                                                                                                                              'vector-ref
                                                                                                                                                                                              lr_0
                                                                                                                                                                                              pos_7))))))
                                                                                                                                                                            (let-values (((result_72)
                                                                                                                                                                                          (if (post-guard-var_16)
                                                                                                                                                                                            (for-loop_70
                                                                                                                                                                                             rest_83
                                                                                                                                                                                             (+
                                                                                                                                                                                              pos_6
                                                                                                                                                                                              1))
                                                                                                                                                                                            null)))
                                                                                                                                                                              (cons
                                                                                                                                                                               elem_15
                                                                                                                                                                               result_72))))))
                                                                                                                                                                    null))))
                                                                                                                                                 for-loop_70)
                                                                                                                                               lst_151
                                                                                                                                               start_3)))))))))))))
                                                                                                               (let-values (((result_73)
                                                                                                                             (if (post-guard-var_15)
                                                                                                                               (for-loop_69
                                                                                                                                rest_81
                                                                                                                                rest_82)
                                                                                                                               null)))
                                                                                                                 (cons
                                                                                                                  elem_14
                                                                                                                  result_73))))))
                                                                                                       null))))
                                                                                    for-loop_69)
                                                                                  lst_147
                                                                                  lst_148))))
                                                                            (map2 schemify_0 bodys_32)))
                                                                         (if (let-values (((p_265) (unwrap v_64)))
                                                                               (if (pair? p_265)
                                                                                 (if (let-values (((a_320) (car p_265)))
                                                                                       (wrap-equal? 'if a_320))
                                                                                   (let-values (((d_316) (cdr p_265)))
                                                                                     (let-values (((p_266)
                                                                                                   (unwrap d_316)))
                                                                                       (if (pair? p_266)
                                                                                         (if (let-values (((a_321)
                                                                                                           (car p_266)))
                                                                                               #t)
                                                                                           (let-values (((d_317)
                                                                                                         (cdr p_266)))
                                                                                             (let-values (((p_267)
                                                                                                           (unwrap
                                                                                                            d_317)))
                                                                                               (if (pair? p_267)
                                                                                                 (if (let-values (((a_322)
                                                                                                                   (car
                                                                                                                    p_267)))
                                                                                                       #t)
                                                                                                   (let-values (((d_318)
                                                                                                                 (cdr
                                                                                                                  p_267)))
                                                                                                     (let-values (((p_268)
                                                                                                                   (unwrap
                                                                                                                    d_318)))
                                                                                                       (if (pair? p_268)
                                                                                                         (if (let-values (((a_323)
                                                                                                                           (car
                                                                                                                            p_268)))
                                                                                                               #t)
                                                                                                           (let-values (((d_319)
                                                                                                                         (cdr
                                                                                                                          p_268)))
                                                                                                             (wrap-equal?
                                                                                                              '()
                                                                                                              d_319))
                                                                                                           #f)
                                                                                                         #f)))
                                                                                                   #f)
                                                                                                 #f)))
                                                                                           #f)
                                                                                         #f)))
                                                                                   #f)
                                                                                 #f))
                                                                           (let-values (((tst_2 thn_3 els_3)
                                                                                         (let-values (((d_320)
                                                                                                       (cdr
                                                                                                        (unwrap v_64))))
                                                                                           (let-values (((p_269)
                                                                                                         (unwrap
                                                                                                          d_320)))
                                                                                             (let-values (((tst_3)
                                                                                                           (let-values (((a_324)
                                                                                                                         (car
                                                                                                                          p_269)))
                                                                                                             a_324))
                                                                                                          ((thn_4 els_4)
                                                                                                           (let-values (((d_321)
                                                                                                                         (cdr
                                                                                                                          p_269)))
                                                                                                             (let-values (((p_270)
                                                                                                                           (unwrap
                                                                                                                            d_321)))
                                                                                                               (let-values (((thn_5)
                                                                                                                             (let-values (((a_325)
                                                                                                                                           (car
                                                                                                                                            p_270)))
                                                                                                                               a_325))
                                                                                                                            ((els_5)
                                                                                                                             (let-values (((d_322)
                                                                                                                                           (cdr
                                                                                                                                            p_270)))
                                                                                                                               (let-values (((a_326)
                                                                                                                                             (car
                                                                                                                                              (unwrap
                                                                                                                                               d_322))))
                                                                                                                                 a_326))))
                                                                                                                 (values
                                                                                                                  thn_5
                                                                                                                  els_5))))))
                                                                                               (values
                                                                                                tst_3
                                                                                                thn_4
                                                                                                els_4))))))
                                                                             (list
                                                                              'if
                                                                              (schemify_0 tst_2)
                                                                              (schemify_0 thn_3)
                                                                              (schemify_0 els_3)))
                                                                           (if (let-values (((p_271) (unwrap v_64)))
                                                                                 (if (pair? p_271)
                                                                                   (if (let-values (((a_327)
                                                                                                     (car p_271)))
                                                                                         (wrap-equal?
                                                                                          'with-continuation-mark
                                                                                          a_327))
                                                                                     (let-values (((d_323) (cdr p_271)))
                                                                                       (let-values (((p_272)
                                                                                                     (unwrap d_323)))
                                                                                         (if (pair? p_272)
                                                                                           (if (let-values (((a_328)
                                                                                                             (car
                                                                                                              p_272)))
                                                                                                 #t)
                                                                                             (let-values (((d_324)
                                                                                                           (cdr p_272)))
                                                                                               (let-values (((p_273)
                                                                                                             (unwrap
                                                                                                              d_324)))
                                                                                                 (if (pair? p_273)
                                                                                                   (if (let-values (((a_329)
                                                                                                                     (car
                                                                                                                      p_273)))
                                                                                                         #t)
                                                                                                     (let-values (((d_325)
                                                                                                                   (cdr
                                                                                                                    p_273)))
                                                                                                       (let-values (((p_274)
                                                                                                                     (unwrap
                                                                                                                      d_325)))
                                                                                                         (if (pair?
                                                                                                              p_274)
                                                                                                           (if (let-values (((a_330)
                                                                                                                             (car
                                                                                                                              p_274)))
                                                                                                                 #t)
                                                                                                             (let-values (((d_326)
                                                                                                                           (cdr
                                                                                                                            p_274)))
                                                                                                               (wrap-equal?
                                                                                                                '()
                                                                                                                d_326))
                                                                                                             #f)
                                                                                                           #f)))
                                                                                                     #f)
                                                                                                   #f)))
                                                                                             #f)
                                                                                           #f)))
                                                                                     #f)
                                                                                   #f))
                                                                             (let-values (((key_3 val_4 body_27)
                                                                                           (let-values (((d_327)
                                                                                                         (cdr
                                                                                                          (unwrap
                                                                                                           v_64))))
                                                                                             (let-values (((p_275)
                                                                                                           (unwrap
                                                                                                            d_327)))
                                                                                               (let-values (((key_4)
                                                                                                             (let-values (((a_331)
                                                                                                                           (car
                                                                                                                            p_275)))
                                                                                                               a_331))
                                                                                                            ((val_5
                                                                                                              body_28)
                                                                                                             (let-values (((d_328)
                                                                                                                           (cdr
                                                                                                                            p_275)))
                                                                                                               (let-values (((p_276)
                                                                                                                             (unwrap
                                                                                                                              d_328)))
                                                                                                                 (let-values (((val_6)
                                                                                                                               (let-values (((a_332)
                                                                                                                                             (car
                                                                                                                                              p_276)))
                                                                                                                                 a_332))
                                                                                                                              ((body_29)
                                                                                                                               (let-values (((d_329)
                                                                                                                                             (cdr
                                                                                                                                              p_276)))
                                                                                                                                 (let-values (((a_333)
                                                                                                                                               (car
                                                                                                                                                (unwrap
                                                                                                                                                 d_329))))
                                                                                                                                   a_333))))
                                                                                                                   (values
                                                                                                                    val_6
                                                                                                                    body_29))))))
                                                                                                 (values
                                                                                                  key_4
                                                                                                  val_5
                                                                                                  body_28))))))
                                                                               (list
                                                                                'with-continuation-mark
                                                                                (schemify_0 key_3)
                                                                                (schemify_0 val_4)
                                                                                (schemify_0 body_27)))
                                                                             (if (let-values (((p_277) (unwrap v_64)))
                                                                                   (if (pair? p_277)
                                                                                     (if (let-values (((a_334)
                                                                                                       (car p_277)))
                                                                                           (wrap-equal? 'begin a_334))
                                                                                       (let-values (((d_330)
                                                                                                     (cdr p_277)))
                                                                                         (wrap-list? d_330))
                                                                                       #f)
                                                                                     #f))
                                                                               (let-values (((exps_5)
                                                                                             (let-values (((d_331)
                                                                                                           (cdr
                                                                                                            (unwrap
                                                                                                             v_64))))
                                                                                               (unwrap-list d_331))))
                                                                                 (list*
                                                                                  'begin
                                                                                  (map2 schemify_0 exps_5)))
                                                                               (if (let-values (((p_278) (unwrap v_64)))
                                                                                     (if (pair? p_278)
                                                                                       (if (let-values (((a_335)
                                                                                                         (car p_278)))
                                                                                             (wrap-equal?
                                                                                              'begin0
                                                                                              a_335))
                                                                                         (let-values (((d_332)
                                                                                                       (cdr p_278)))
                                                                                           (wrap-list? d_332))
                                                                                         #f)
                                                                                       #f))
                                                                                 (let-values (((exps_6)
                                                                                               (let-values (((d_333)
                                                                                                             (cdr
                                                                                                              (unwrap
                                                                                                               v_64))))
                                                                                                 (unwrap-list d_333))))
                                                                                   (list*
                                                                                    'begin0
                                                                                    (map2 schemify_0 exps_6)))
                                                                                 (if (let-values (((p_279)
                                                                                                   (unwrap v_64)))
                                                                                       (if (pair? p_279)
                                                                                         (if (let-values (((a_336)
                                                                                                           (car p_279)))
                                                                                               (wrap-equal?
                                                                                                'set!
                                                                                                a_336))
                                                                                           (let-values (((d_334)
                                                                                                         (cdr p_279)))
                                                                                             (let-values (((p_280)
                                                                                                           (unwrap
                                                                                                            d_334)))
                                                                                               (if (pair? p_280)
                                                                                                 (if (let-values (((a_337)
                                                                                                                   (car
                                                                                                                    p_280)))
                                                                                                       #t)
                                                                                                   (let-values (((d_335)
                                                                                                                 (cdr
                                                                                                                  p_280)))
                                                                                                     (let-values (((p_281)
                                                                                                                   (unwrap
                                                                                                                    d_335)))
                                                                                                       (if (pair? p_281)
                                                                                                         (if (let-values (((a_338)
                                                                                                                           (car
                                                                                                                            p_281)))
                                                                                                               #t)
                                                                                                           (let-values (((d_336)
                                                                                                                         (cdr
                                                                                                                          p_281)))
                                                                                                             (wrap-equal?
                                                                                                              '()
                                                                                                              d_336))
                                                                                                           #f)
                                                                                                         #f)))
                                                                                                   #f)
                                                                                                 #f)))
                                                                                           #f)
                                                                                         #f))
                                                                                   (let-values (((id_36 rhs_43)
                                                                                                 (let-values (((d_337)
                                                                                                               (cdr
                                                                                                                (unwrap
                                                                                                                 v_64))))
                                                                                                   (let-values (((p_282)
                                                                                                                 (unwrap
                                                                                                                  d_337)))
                                                                                                     (let-values (((id_37)
                                                                                                                   (let-values (((a_339)
                                                                                                                                 (car
                                                                                                                                  p_282)))
                                                                                                                     a_339))
                                                                                                                  ((rhs_44)
                                                                                                                   (let-values (((d_338)
                                                                                                                                 (cdr
                                                                                                                                  p_282)))
                                                                                                                     (let-values (((a_340)
                                                                                                                                   (car
                                                                                                                                    (unwrap
                                                                                                                                     d_338))))
                                                                                                                       a_340))))
                                                                                                       (values
                                                                                                        id_37
                                                                                                        rhs_44))))))
                                                                                     (let-values (((ex-id_3)
                                                                                                   (hash-ref
                                                                                                    exports_9
                                                                                                    (unwrap id_36)
                                                                                                    #f)))
                                                                                       (if ex-id_3
                                                                                         (list
                                                                                          'variable-set!
                                                                                          ex-id_3
                                                                                          (schemify_0 rhs_43))
                                                                                         (list
                                                                                          'set!
                                                                                          id_36
                                                                                          (schemify_0 rhs_43)))))
                                                                                   (if (let-values (((p_283)
                                                                                                     (unwrap v_64)))
                                                                                         (if (pair? p_283)
                                                                                           (if (let-values (((a_341)
                                                                                                             (car
                                                                                                              p_283)))
                                                                                                 (wrap-equal?
                                                                                                  'variable-reference-constant?
                                                                                                  a_341))
                                                                                             (let-values (((d_339)
                                                                                                           (cdr p_283)))
                                                                                               (let-values (((p_284)
                                                                                                             (unwrap
                                                                                                              d_339)))
                                                                                                 (if (pair? p_284)
                                                                                                   (if (let-values (((a_342)
                                                                                                                     (car
                                                                                                                      p_284)))
                                                                                                         (let-values (((p_285)
                                                                                                                       (unwrap
                                                                                                                        a_342)))
                                                                                                           (if (pair?
                                                                                                                p_285)
                                                                                                             (if (let-values (((a_343)
                                                                                                                               (car
                                                                                                                                p_285)))
                                                                                                                   (wrap-equal?
                                                                                                                    '#%variable-reference
                                                                                                                    a_343))
                                                                                                               (let-values (((d_340)
                                                                                                                             (cdr
                                                                                                                              p_285)))
                                                                                                                 (let-values (((p_286)
                                                                                                                               (unwrap
                                                                                                                                d_340)))
                                                                                                                   (if (pair?
                                                                                                                        p_286)
                                                                                                                     (if (let-values (((a_344)
                                                                                                                                       (car
                                                                                                                                        p_286)))
                                                                                                                           #t)
                                                                                                                       (let-values (((d_341)
                                                                                                                                     (cdr
                                                                                                                                      p_286)))
                                                                                                                         (wrap-equal?
                                                                                                                          '()
                                                                                                                          d_341))
                                                                                                                       #f)
                                                                                                                     #f)))
                                                                                                               #f)
                                                                                                             #f)))
                                                                                                     (let-values (((d_342)
                                                                                                                   (cdr
                                                                                                                    p_284)))
                                                                                                       (wrap-equal?
                                                                                                        '()
                                                                                                        d_342))
                                                                                                     #f)
                                                                                                   #f)))
                                                                                             #f)
                                                                                           #f))
                                                                                     (let-values (((id_38)
                                                                                                   (let-values (((d_343)
                                                                                                                 (cdr
                                                                                                                  (unwrap
                                                                                                                   v_64))))
                                                                                                     (let-values (((a_345)
                                                                                                                   (car
                                                                                                                    (unwrap
                                                                                                                     d_343))))
                                                                                                       (let-values (((d_344)
                                                                                                                     (cdr
                                                                                                                      (unwrap
                                                                                                                       a_345))))
                                                                                                         (let-values (((a_346)
                                                                                                                       (car
                                                                                                                        (unwrap
                                                                                                                         d_344))))
                                                                                                           a_346))))))
                                                                                       (let-values (((id_39)
                                                                                                     (unwrap id_38)))
                                                                                         (if (not
                                                                                              (hash-ref
                                                                                               mutated_11
                                                                                               id_39
                                                                                               #f))
                                                                                           (let-values (((im_2)
                                                                                                         (hash-ref
                                                                                                          imports_19
                                                                                                          id_39
                                                                                                          #f)))
                                                                                             (let-values (((or-part_24)
                                                                                                           (not im_2)))
                                                                                               (if or-part_24
                                                                                                 or-part_24
                                                                                                 (known-constant?
                                                                                                  (import-lookup
                                                                                                   im_2)))))
                                                                                           #f)))
                                                                                     (if (let-values (((p_287)
                                                                                                       (unwrap v_64)))
                                                                                           (if (pair? p_287)
                                                                                             (if (let-values (((a_347)
                                                                                                               (car
                                                                                                                p_287)))
                                                                                                   (wrap-equal?
                                                                                                    '#%variable-reference
                                                                                                    a_347))
                                                                                               (let-values (((d_345)
                                                                                                             (cdr
                                                                                                              p_287)))
                                                                                                 (wrap-equal?
                                                                                                  '()
                                                                                                  d_345))
                                                                                               #f)
                                                                                             #f))
                                                                                       (let-values ()
                                                                                         'instance-variable-reference)
                                                                                       (if (let-values (((p_288)
                                                                                                         (unwrap v_64)))
                                                                                             (if (pair? p_288)
                                                                                               (if (let-values (((a_348)
                                                                                                                 (car
                                                                                                                  p_288)))
                                                                                                     (wrap-equal?
                                                                                                      '#%variable-reference
                                                                                                      a_348))
                                                                                                 (let-values (((d_346)
                                                                                                               (cdr
                                                                                                                p_288)))
                                                                                                   (let-values (((p_289)
                                                                                                                 (unwrap
                                                                                                                  d_346)))
                                                                                                     (if (pair? p_289)
                                                                                                       (if (let-values (((a_349)
                                                                                                                         (car
                                                                                                                          p_289)))
                                                                                                             #t)
                                                                                                         (let-values (((d_347)
                                                                                                                       (cdr
                                                                                                                        p_289)))
                                                                                                           (wrap-equal?
                                                                                                            '()
                                                                                                            d_347))
                                                                                                         #f)
                                                                                                       #f)))
                                                                                                 #f)
                                                                                               #f))
                                                                                         (let-values (((id_40)
                                                                                                       (let-values (((d_348)
                                                                                                                     (cdr
                                                                                                                      (unwrap
                                                                                                                       v_64))))
                                                                                                         (let-values (((a_350)
                                                                                                                       (car
                                                                                                                        (unwrap
                                                                                                                         d_348))))
                                                                                                           a_350))))
                                                                                           (let-values (((e_5)
                                                                                                         (hash-ref
                                                                                                          exports_9
                                                                                                          (unwrap id_40)
                                                                                                          #f)))
                                                                                             (if e_5
                                                                                               (list
                                                                                                'make-instance-variable-reference
                                                                                                'instance-variable-reference
                                                                                                e_5)
                                                                                               (list
                                                                                                'make-instance-variable-reference
                                                                                                'instance-variable-reference
                                                                                                (if (hash-ref
                                                                                                     mutated_11
                                                                                                     (unwrap id_40)
                                                                                                     #f)
                                                                                                  'mutable
                                                                                                  'immutable)))))
                                                                                         (if (let-values (((p_290)
                                                                                                           (unwrap
                                                                                                            v_64)))
                                                                                               (if (pair? p_290)
                                                                                                 (if (let-values (((a_351)
                                                                                                                   (car
                                                                                                                    p_290)))
                                                                                                       #t)
                                                                                                   (let-values (((d_349)
                                                                                                                 (cdr
                                                                                                                  p_290)))
                                                                                                     (wrap-list? d_349))
                                                                                                   #f)
                                                                                                 #f))
                                                                                           (let-values (((rator_3
                                                                                                          exps_7)
                                                                                                         (let-values (((p_291)
                                                                                                                       (unwrap
                                                                                                                        v_64)))
                                                                                                           (let-values (((rator_4)
                                                                                                                         (let-values (((a_352)
                                                                                                                                       (car
                                                                                                                                        p_291)))
                                                                                                                           a_352))
                                                                                                                        ((exps_8)
                                                                                                                         (let-values (((d_350)
                                                                                                                                       (cdr
                                                                                                                                        p_291)))
                                                                                                                           (unwrap-list
                                                                                                                            d_350))))
                                                                                                             (values
                                                                                                              rator_4
                                                                                                              exps_8)))))
                                                                                             (let-values (((s-rator_0)
                                                                                                           (schemify_0
                                                                                                            rator_3))
                                                                                                          ((args_3)
                                                                                                           (map2
                                                                                                            schemify_0
                                                                                                            exps_7))
                                                                                                          ((u-rator_0)
                                                                                                           (unwrap
                                                                                                            rator_3)))
                                                                                               (let-values (((plain-app?_1)
                                                                                                             (let-values (((or-part_25)
                                                                                                                           (if (known-procedure?
                                                                                                                                (hash-ref-either
                                                                                                                                 knowns_31
                                                                                                                                 imports_19
                                                                                                                                 u-rator_0))
                                                                                                                             (not
                                                                                                                              (hash-ref
                                                                                                                               mutated_11
                                                                                                                               u-rator_0
                                                                                                                               #f))
                                                                                                                             #f)))
                                                                                                               (if or-part_25
                                                                                                                 or-part_25
                                                                                                                 (let-values (((or-part_26)
                                                                                                                               (known-procedure?
                                                                                                                                (hash-ref
                                                                                                                                 prim-knowns_10
                                                                                                                                 u-rator_0
                                                                                                                                 #f))))
                                                                                                                   (if or-part_26
                                                                                                                     or-part_26
                                                                                                                     (lambda?
                                                                                                                      rator_3)))))))
                                                                                                 (left-to-right/app
                                                                                                  s-rator_0
                                                                                                  args_3
                                                                                                  plain-app?_1
                                                                                                  unannotate_5
                                                                                                  prim-knowns_10
                                                                                                  knowns_31
                                                                                                  imports_19
                                                                                                  mutated_11))))
                                                                                           (let-values ()
                                                                                             (let-values (((u-v_0)
                                                                                                           (unwrap
                                                                                                            v_63)))
                                                                                               (let-values (((c1_0)
                                                                                                             (if (symbol?
                                                                                                                  u-v_0)
                                                                                                               (if (via-variable-mutated-state?
                                                                                                                    (hash-ref
                                                                                                                     mutated_11
                                                                                                                     u-v_0
                                                                                                                     #f))
                                                                                                                 (hash-ref
                                                                                                                  exports_9
                                                                                                                  u-v_0
                                                                                                                  #f)
                                                                                                                 #f)
                                                                                                               #f)))
                                                                                                 (if c1_0
                                                                                                   ((lambda (ex-id_4)
                                                                                                      (list
                                                                                                       'variable-ref
                                                                                                       ex-id_4))
                                                                                                    c1_0)
                                                                                                   (let-values (((c2_0)
                                                                                                                 (if (symbol?
                                                                                                                      u-v_0)
                                                                                                                   (hash-ref
                                                                                                                    imports_19
                                                                                                                    u-v_0
                                                                                                                    #f)
                                                                                                                   #f)))
                                                                                                     (if c2_0
                                                                                                       ((lambda (im_3)
                                                                                                          (if (known-constant?
                                                                                                               (import-lookup
                                                                                                                im_3))
                                                                                                            (import-id
                                                                                                             im_3)
                                                                                                            (list
                                                                                                             'variable-ref/no-check
                                                                                                             (import-id
                                                                                                              im_3))))
                                                                                                        c2_0)
                                                                                                       (let-values ()
                                                                                                         v_63))))))))))))))))))))))))))))))))))
                           schemify_0)
                         v_62))))
       schemify/knowns_0)
     knowns_30
     v_61))))
