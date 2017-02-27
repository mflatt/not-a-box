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
  (schemify-linklet)
  (lambda (lk_0 prim-knowns_0 get-import-knowns_0)
    (let-values (((imports_0)
                  (let-values (((lst_0) (cadr lk_0)) ((start_0) 0))
                    (begin
                      (check-list lst_0)
                      (check-naturals start_0)
                      ((letrec-values (((for-loop_0)
                                        (lambda (imports_1 lst_1 pos_0)
                                          (if (if (pair? lst_1) #t #f)
                                            (let-values (((ims_0) (unsafe-car lst_1))
                                                         ((rest_0) (unsafe-cdr lst_1))
                                                         ((index_0) pos_0))
                                              (let-values (((imports_2)
                                                            (let-values (((imports_3) imports_1))
                                                              (let-values (((imports_4)
                                                                            (let-values ()
                                                                              (let-values (((grp_1)
                                                                                            (import-group2.1
                                                                                             (lambda ()
                                                                                               (get-import-knowns_0
                                                                                                index_0)))))
                                                                                (let-values (((lst_2) ims_0))
                                                                                  (begin
                                                                                    (check-list lst_2)
                                                                                    ((letrec-values (((for-loop_1)
                                                                                                      (lambda (imports_5
                                                                                                               lst_3)
                                                                                                        (if (pair?
                                                                                                             lst_3)
                                                                                                          (let-values (((im_0)
                                                                                                                        (unsafe-car
                                                                                                                         lst_3))
                                                                                                                       ((rest_1)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_3)))
                                                                                                            (let-values (((imports_6)
                                                                                                                          (let-values (((imports_7)
                                                                                                                                        imports_5))
                                                                                                                            (let-values (((imports_8)
                                                                                                                                          (let-values ()
                                                                                                                                            (let-values (((id_0)
                                                                                                                                                          (if (pair?
                                                                                                                                                               im_0)
                                                                                                                                                            (cadr
                                                                                                                                                             im_0)
                                                                                                                                                            im_0)))
                                                                                                                                              (let-values (((ext-id_0)
                                                                                                                                                            (if (pair?
                                                                                                                                                                 im_0)
                                                                                                                                                              (cdr
                                                                                                                                                               im_0)
                                                                                                                                                              im_0)))
                                                                                                                                                (hash-set
                                                                                                                                                 imports_7
                                                                                                                                                 id_0
                                                                                                                                                 (import1.1
                                                                                                                                                  grp_1
                                                                                                                                                  (gensym
                                                                                                                                                   (symbol->string
                                                                                                                                                    id_0))
                                                                                                                                                  ext-id_0)))))))
                                                                                                                              (values
                                                                                                                               imports_8)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_1
                                                                                                                 imports_6
                                                                                                                 rest_1)
                                                                                                                imports_6)))
                                                                                                          imports_5))))
                                                                                       for-loop_1)
                                                                                     imports_3
                                                                                     lst_2)))))))
                                                                (values imports_4)))))
                                                (if (not #f) (for-loop_0 imports_2 rest_0 (+ pos_0 1)) imports_2)))
                                            imports_1))))
                         for-loop_0)
                       (hasheq)
                       lst_0
                       start_0)))))
      (let-values (((exports_0)
                    (let-values (((lst_4) (caddr lk_0)))
                      (begin
                        (check-list lst_4)
                        ((letrec-values (((for-loop_2)
                                          (lambda (exports_1 lst_5)
                                            (if (pair? lst_5)
                                              (let-values (((ex_0) (unsafe-car lst_5)) ((rest_2) (unsafe-cdr lst_5)))
                                                (let-values (((exports_2)
                                                              (let-values (((exports_3) exports_1))
                                                                (let-values (((exports_4)
                                                                              (let-values ()
                                                                                (let-values (((id_1)
                                                                                              (if (pair? ex_0)
                                                                                                (car ex_0)
                                                                                                ex_0)))
                                                                                  (hash-set
                                                                                   exports_3
                                                                                   id_1
                                                                                   (gensym (symbol->string id_1)))))))
                                                                  (values exports_4)))))
                                                  (if (not #f) (for-loop_2 exports_2 rest_2) exports_2)))
                                              exports_1))))
                           for-loop_2)
                         (hasheq)
                         lst_4)))))
        (let-values (((new-body_0 defn-info_0) (schemify-body* (cdddr lk_0) prim-knowns_0 imports_0 exports_0)))
          (values
           (list*
            'lambda
            (list*
             'instance-variable-reference
             (qq-append
              (let-values (((lst_6) (cadr lk_0)))
                (begin
                  (check-list lst_6)
                  ((letrec-values (((for-loop_3)
                                    (lambda (lst_7)
                                      (if (pair? lst_7)
                                        (let-values (((ims_1) (unsafe-car lst_7)) ((rest_3) (unsafe-cdr lst_7)))
                                          (let-values (((post-guard-var_0) (lambda () #t)))
                                            (let-values (((lst_8) ims_1))
                                              (begin
                                                (check-list lst_8)
                                                ((letrec-values (((for-loop_4)
                                                                  (lambda (lst_9)
                                                                    (if (pair? lst_9)
                                                                      (let-values (((im_1) (unsafe-car lst_9))
                                                                                   ((rest_4) (unsafe-cdr lst_9)))
                                                                        (let-values (((post-guard-var_1)
                                                                                      (lambda () #t)))
                                                                          (let-values ()
                                                                            (let-values (((elem_0)
                                                                                          (let-values ()
                                                                                            (let-values ()
                                                                                              (import-id
                                                                                               (hash-ref
                                                                                                imports_0
                                                                                                (if (pair? im_1)
                                                                                                  (cadr im_1)
                                                                                                  im_1)))))))
                                                                              (let-values (((result_0)
                                                                                            (if (post-guard-var_1)
                                                                                              (for-loop_4 rest_4)
                                                                                              (if (post-guard-var_0)
                                                                                                (for-loop_3 rest_3)
                                                                                                null))))
                                                                                (cons elem_0 result_0))))))
                                                                      (if (post-guard-var_0)
                                                                        (for-loop_3 rest_3)
                                                                        null)))))
                                                   for-loop_4)
                                                 lst_8)))))
                                        null))))
                     for-loop_3)
                   lst_6)))
              (let-values (((lst_10) (caddr lk_0)))
                (begin
                  (check-list lst_10)
                  ((letrec-values (((for-loop_5)
                                    (lambda (lst_11)
                                      (if (pair? lst_11)
                                        (let-values (((ex_1) (unsafe-car lst_11)) ((rest_5) (unsafe-cdr lst_11)))
                                          (let-values (((post-guard-var_2) (lambda () #t)))
                                            (let-values ()
                                              (let-values (((elem_1)
                                                            (let-values ()
                                                              (let-values ()
                                                                (hash-ref
                                                                 exports_0
                                                                 (if (pair? ex_1) (car ex_1) ex_1))))))
                                                (let-values (((result_1)
                                                              (if (post-guard-var_2) (for-loop_5 rest_5) null)))
                                                  (cons elem_1 result_1))))))
                                        null))))
                     for-loop_5)
                   lst_10)))))
            new-body_0)
           (let-values (((lst_12) (caddr lk_0)))
             (begin
               (check-list lst_12)
               ((letrec-values (((for-loop_6)
                                 (lambda (knowns_1 lst_13)
                                   (if (pair? lst_13)
                                     (let-values (((ex_2) (unsafe-car lst_13)) ((rest_6) (unsafe-cdr lst_13)))
                                       (let-values (((knowns_2)
                                                     (let-values (((knowns_3) knowns_1))
                                                       (let-values (((knowns_4)
                                                                     (let-values ()
                                                                       (let-values (((id_2)
                                                                                     (if (pair? ex_2) (car ex_2) ex_2)))
                                                                         (let-values (((v_14)
                                                                                       (hash-ref defn-info_0 id_2 #f)))
                                                                           (if v_14
                                                                             (let-values ()
                                                                               (let-values (((ext-id_1)
                                                                                             (if (pair? ex_2)
                                                                                               (cadr ex_2)
                                                                                               ex_2)))
                                                                                 (hash-set knowns_3 ext-id_1 v_14)))
                                                                             (let-values () knowns_3)))))))
                                                         (values knowns_4)))))
                                         (if (not #f) (for-loop_6 knowns_2 rest_6) knowns_2)))
                                     knowns_1))))
                  for-loop_6)
                (hasheq)
                lst_12)))))))))
 (define-values
  (schemify-body)
  (lambda (l_9 prim-knowns_1 imports_9 exports_5)
    (let-values (((new-body_1 defn-info_1) (schemify-body* l_9 prim-knowns_1 imports_9 exports_5))) new-body_1)))
 (define-values
  (schemify-body*)
  (lambda (l_10 prim-knowns_2 imports_10 exports_6)
    (let-values (((mutated_0) (mutated-in-body l_10 exports_6 prim-knowns_2 (hasheq) imports_10)))
      ((letrec-values (((loop_5)
                        (lambda (l_11 knowns_5 accum-exprs_0 accum-ids_0)
                          (if (null? l_11)
                            (let-values ()
                              (let-values (((set-vars_0)
                                            (let-values (((lst_14) accum-ids_0))
                                              (begin
                                                (check-list lst_14)
                                                ((letrec-values (((for-loop_7)
                                                                  (lambda (lst_15)
                                                                    (if (pair? lst_15)
                                                                      (let-values (((id_3) (unsafe-car lst_15))
                                                                                   ((rest_7) (unsafe-cdr lst_15)))
                                                                        (let-values (((post-guard-var_3)
                                                                                      (lambda () #t)))
                                                                          (let-values ()
                                                                            (if (hash-ref exports_6 id_3 #f)
                                                                              (let-values ()
                                                                                (let-values (((elem_2)
                                                                                              (let-values ()
                                                                                                (let-values ()
                                                                                                  (make-set-variable
                                                                                                   id_3
                                                                                                   exports_6)))))
                                                                                  (let-values (((result_2)
                                                                                                (if (post-guard-var_3)
                                                                                                  (for-loop_7 rest_7)
                                                                                                  null)))
                                                                                    (cons elem_2 result_2))))
                                                                              (if (post-guard-var_3)
                                                                                (for-loop_7 rest_7)
                                                                                null)))))
                                                                      null))))
                                                   for-loop_7)
                                                 lst_14)))))
                                (values
                                 (if (null? set-vars_0)
                                   (let-values ()
                                     (if (null? accum-exprs_0)
                                       (let-values () '((void)))
                                       (let-values () (reverse$1 accum-exprs_0))))
                                   (let-values () (append (make-expr-defns accum-exprs_0) set-vars_0)))
                                 knowns_5)))
                            (let-values ()
                              (let-values (((form_0) (car l_11)))
                                (let-values (((new-knowns_0)
                                              (find-definitions form_0 prim-knowns_2 knowns_5 imports_10 mutated_0)))
                                  (let-values (((schemified_0)
                                                ((make-schemify
                                                  prim-knowns_2
                                                  new-knowns_0
                                                  mutated_0
                                                  imports_10
                                                  exports_6)
                                                 form_0)))
                                    (let-values (((v_15) form_0))
                                      (if (if (pair? v_15)
                                            (if (let-values (((a_3) (car v_15))) (equal? 'define-values a_3))
                                              (let-values (((d_0) (cdr v_15)))
                                                (if (pair? d_0)
                                                  (if (let-values (((a_4) (car d_0))) #t)
                                                    (let-values (((d_1) (cdr d_0)))
                                                      (if (pair? d_1)
                                                        (if (let-values (((a_5) (car d_1))) #t)
                                                          (let-values (((d_2) (cdr d_1))) (equal? '() d_2))
                                                          #f)
                                                        #f))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((ids_0)
                                                      (let-values (((d_3) (cdr v_15)))
                                                        (let-values (((a_6) (car d_3))) a_6))))
                                          (let-values (((rest-schemified_0 defn-info_2)
                                                        ((letrec-values (((id-loop_0)
                                                                          (lambda (ids_1 accum-exprs_1 accum-ids_1)
                                                                            (if (null? ids_1)
                                                                              (let-values ()
                                                                                (loop_5
                                                                                 (cdr l_11)
                                                                                 new-knowns_0
                                                                                 accum-exprs_1
                                                                                 accum-ids_1))
                                                                              (if (hash-ref mutated_0 (car ids_1) #f)
                                                                                (let-values ()
                                                                                  (let-values (((id_4) (car ids_1)))
                                                                                    (if (hash-ref exports_6 id_4 #f)
                                                                                      (let-values ()
                                                                                        (id-loop_0
                                                                                         (cdr ids_1)
                                                                                         (cons
                                                                                          (make-set-variable
                                                                                           id_4
                                                                                           exports_6)
                                                                                          accum-exprs_1)
                                                                                         accum-ids_1))
                                                                                      (let-values ()
                                                                                        (id-loop_0
                                                                                         (cdr ids_1)
                                                                                         accum-exprs_1
                                                                                         accum-ids_1)))))
                                                                                (let-values ()
                                                                                  (id-loop_0
                                                                                   (cdr ids_1)
                                                                                   accum-exprs_1
                                                                                   (cons (car ids_1) accum-ids_1))))))))
                                                           id-loop_0)
                                                         ids_0
                                                         null
                                                         accum-ids_0)))
                                            (values
                                             (append
                                              (make-expr-defns accum-exprs_0)
                                              (cons schemified_0 rest-schemified_0))
                                             defn-info_2)))
                                        (let-values ()
                                          (loop_5
                                           (cdr l_11)
                                           knowns_5
                                           (cons schemified_0 accum-exprs_0)
                                           accum-ids_0))))))))))))
         loop_5)
       l_10
       (hasheq)
       null
       null))))
 (define-values
  (make-set-variable)
  (lambda (id_5 exports_7) (let-values (((ex-var_0) (hash-ref exports_7 id_5))) (list 'variable-set! ex-var_0 id_5))))
 (define-values
  (make-expr-defns)
  (lambda (accum-exprs_2)
    (let-values (((lst_16) (reverse$1 accum-exprs_2)))
      (begin
        (check-list lst_16)
        ((letrec-values (((for-loop_8)
                          (lambda (lst_17)
                            (if (pair? lst_17)
                              (let-values (((expr_0) (unsafe-car lst_17)) ((rest_8) (unsafe-cdr lst_17)))
                                (let-values (((post-guard-var_4) (lambda () #t)))
                                  (let-values ()
                                    (let-values (((elem_3)
                                                  (let-values () (let-values () (list 'define (gensym) expr_0)))))
                                      (let-values (((result_3) (if (post-guard-var_4) (for-loop_8 rest_8) null)))
                                        (cons elem_3 result_3))))))
                              null))))
           for-loop_8)
         lst_16)))))
 (define-values
  (lambda?)
  (lambda (v_16)
    (let-values (((v_17) v_16))
      (if (if (pair? v_17)
            (if (let-values (((a_7) (car v_17))) (equal? 'lambda a_7)) (let-values (((d_4) (cdr v_17))) #t) #f)
            #f)
        (let-values () #t)
        (if (if (pair? v_17)
              (if (let-values (((a_8) (car v_17))) (equal? 'case-lambda a_8)) (let-values (((d_5) (cdr v_17))) #t) #f)
              #f)
          (let-values () #t)
          (if (if (pair? v_17)
                (if (let-values (((a_9) (car v_17))) (equal? 'let-values a_9))
                  (let-values (((d_6) (cdr v_17)))
                    (if (pair? d_6)
                      (if (let-values (((a_10) (car d_6)))
                            (if (pair? a_10)
                              (if (let-values (((a_11) (car a_10)))
                                    (if (pair? a_11)
                                      (if (let-values (((a_12) (car a_11)))
                                            (if (pair? a_12)
                                              (if (let-values (((a_13) (car a_12))) #t)
                                                (let-values (((d_7) (cdr a_12))) (equal? '() d_7))
                                                #f)
                                              #f))
                                        (let-values (((d_8) (cdr a_11)))
                                          (if (pair? d_8)
                                            (if (let-values (((a_14) (car d_8))) #t)
                                              (let-values (((d_9) (cdr d_8))) (equal? '() d_9))
                                              #f)
                                            #f))
                                        #f)
                                      #f))
                                (let-values (((d_10) (cdr a_10))) (equal? '() d_10))
                                #f)
                              #f))
                        (let-values (((d_11) (cdr d_6)))
                          (if (pair? d_11)
                            (if (let-values (((a_15) (car d_11))) #t)
                              (let-values (((d_12) (cdr d_11))) (equal? '() d_12))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((id1_0 rhs_0 id2_0)
                          (let-values (((d_13) (cdr v_17)))
                            (let-values (((id1_1 rhs_1)
                                          (let-values (((a_16) (car d_13)))
                                            (let-values (((a_17) (car a_16)))
                                              (let-values (((id1_2)
                                                            (let-values (((a_18) (car a_17)))
                                                              (let-values (((a_19) (car a_18))) a_19)))
                                                           ((rhs_2)
                                                            (let-values (((d_14) (cdr a_17)))
                                                              (let-values (((a_20) (car d_14))) a_20))))
                                                (values id1_2 rhs_2)))))
                                         ((id2_1)
                                          (let-values (((d_15) (cdr d_13))) (let-values (((a_21) (car d_15))) a_21))))
                              (values id1_1 rhs_1 id2_1)))))
              (if (eq? id1_0 id2_0) (lambda? rhs_0) #f))
            (if (if (pair? v_17)
                  (if (let-values (((a_22) (car v_17))) (equal? 'letrec-values a_22))
                    (let-values (((d_16) (cdr v_17)))
                      (if (pair? d_16)
                        (if (let-values (((a_23) (car d_16)))
                              (if (pair? a_23)
                                (if (let-values (((a_24) (car a_23)))
                                      (if (pair? a_24)
                                        (if (let-values (((a_25) (car a_24)))
                                              (if (pair? a_25)
                                                (if (let-values (((a_26) (car a_25))) #t)
                                                  (let-values (((d_17) (cdr a_25))) (equal? '() d_17))
                                                  #f)
                                                #f))
                                          (let-values (((d_18) (cdr a_24)))
                                            (if (pair? d_18)
                                              (if (let-values (((a_27) (car d_18))) #t)
                                                (let-values (((d_19) (cdr d_18))) (equal? '() d_19))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                  (let-values (((d_20) (cdr a_23))) (equal? '() d_20))
                                  #f)
                                #f))
                          (let-values (((d_21) (cdr d_16)))
                            (if (pair? d_21)
                              (if (let-values (((a_28) (car d_21))) #t)
                                (let-values (((d_22) (cdr d_21))) (equal? '() d_22))
                                #f)
                              #f))
                          #f)
                        #f))
                    #f)
                  #f)
              (let-values (((id1_3 rhs_3 id2_2)
                            (let-values (((d_23) (cdr v_17)))
                              (let-values (((id1_4 rhs_4)
                                            (let-values (((a_29) (car d_23)))
                                              (let-values (((a_30) (car a_29)))
                                                (let-values (((id1_5)
                                                              (let-values (((a_31) (car a_30)))
                                                                (let-values (((a_32) (car a_31))) a_32)))
                                                             ((rhs_5)
                                                              (let-values (((d_24) (cdr a_30)))
                                                                (let-values (((a_33) (car d_24))) a_33))))
                                                  (values id1_5 rhs_5)))))
                                           ((id2_3)
                                            (let-values (((d_25) (cdr d_23))) (let-values (((a_34) (car d_25))) a_34))))
                                (values id1_4 rhs_4 id2_3)))))
                (if (eq? id1_3 id2_2) (lambda? rhs_3) #f))
              (if (if (pair? v_17)
                    (if (let-values (((a_35) (car v_17))) (equal? 'let-values a_35))
                      (let-values (((d_26) (cdr v_17)))
                        (if (pair? d_26)
                          (if (let-values (((a_36) (car d_26))) #t)
                            (let-values (((d_27) (cdr d_26)))
                              (if (pair? d_27)
                                (if (let-values (((a_37) (car d_27))) #t)
                                  (let-values (((d_28) (cdr d_27))) (equal? '() d_28))
                                  #f)
                                #f))
                            #f)
                          #f))
                      #f)
                    #f)
                (let-values (((body_0)
                              (let-values (((d_29) (cdr v_17)))
                                (let-values (((d_30) (cdr d_29))) (let-values (((a_38) (car d_30))) a_38)))))
                  (lambda? body_0))
                (if (if (pair? v_17)
                      (if (let-values (((a_39) (car v_17))) (equal? 'letrec-values a_39))
                        (let-values (((d_31) (cdr v_17)))
                          (if (pair? d_31)
                            (if (let-values (((a_40) (car d_31))) #t)
                              (let-values (((d_32) (cdr d_31)))
                                (if (pair? d_32)
                                  (if (let-values (((a_41) (car d_32))) #t)
                                    (let-values (((d_33) (cdr d_32))) (equal? '() d_33))
                                    #f)
                                  #f))
                              #f)
                            #f))
                        #f)
                      #f)
                  (let-values (((body_1)
                                (let-values (((d_34) (cdr v_17)))
                                  (let-values (((d_35) (cdr d_34))) (let-values (((a_42) (car d_35))) a_42)))))
                    (lambda? body_1))
                  (let-values () #f))))))))))
 (define-values
  (simple?)
  (lambda (e_0 prim-knowns_3 knowns_6 imports_11 mutated_1)
    ((letrec-values (((simple?_0)
                      (lambda (e_1)
                        (let-values (((v_18) e_1))
                          (if (if (pair? v_18)
                                (if (let-values (((a_43) (car v_18))) (equal? 'lambda a_43))
                                  (let-values (((d_36) (cdr v_18))) #t)
                                  #f)
                                #f)
                            (let-values () #t)
                            (if (if (pair? v_18)
                                  (if (let-values (((a_44) (car v_18))) (equal? 'case-lambda a_44))
                                    (let-values (((d_37) (cdr v_18))) #t)
                                    #f)
                                  #f)
                              (let-values () #t)
                              (if (if (pair? v_18)
                                    (if (let-values (((a_45) (car v_18))) (equal? 'quote a_45))
                                      (let-values (((d_38) (cdr v_18))) #t)
                                      #f)
                                    #f)
                                (let-values () #t)
                                (if (if (pair? v_18)
                                      (if (let-values (((a_46) (car v_18))) (equal? '#%variable-reference a_46))
                                        (let-values (((d_39) (cdr v_18))) #t)
                                        #f)
                                      #f)
                                  (let-values () #t)
                                  (if (if (pair? v_18)
                                        (if (let-values (((a_47) (car v_18))) (equal? 'let-values a_47))
                                          (let-values (((d_40) (cdr v_18)))
                                            (if (pair? d_40)
                                              (if (let-values (((a_48) (car d_40)))
                                                    (if (list? a_48)
                                                      (let-values (((lst_18) a_48))
                                                        (begin
                                                          (check-list lst_18)
                                                          ((letrec-values (((for-loop_9)
                                                                            (lambda (result_4 lst_19)
                                                                              (if (pair? lst_19)
                                                                                (let-values (((v_19)
                                                                                              (unsafe-car lst_19))
                                                                                             ((rest_9)
                                                                                              (unsafe-cdr lst_19)))
                                                                                  (let-values (((result_5)
                                                                                                (let-values ()
                                                                                                  (let-values (((result_6)
                                                                                                                (let-values ()
                                                                                                                  (let-values ()
                                                                                                                    (if (pair?
                                                                                                                         v_19)
                                                                                                                      (if (let-values (((a_49)
                                                                                                                                        (car
                                                                                                                                         v_19)))
                                                                                                                            #t)
                                                                                                                        (let-values (((d_41)
                                                                                                                                      (cdr
                                                                                                                                       v_19)))
                                                                                                                          (if (pair?
                                                                                                                               d_41)
                                                                                                                            (if (let-values (((a_50)
                                                                                                                                              (car
                                                                                                                                               d_41)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_42)
                                                                                                                                            (cdr
                                                                                                                                             d_41)))
                                                                                                                                (equal?
                                                                                                                                 '()
                                                                                                                                 d_42))
                                                                                                                              #f)
                                                                                                                            #f))
                                                                                                                        #f)
                                                                                                                      #f)))))
                                                                                                    (values
                                                                                                     result_6)))))
                                                                                    (if (if (not
                                                                                             ((lambda x_0
                                                                                                (not result_5))
                                                                                              v_19))
                                                                                          (not #f)
                                                                                          #f)
                                                                                      (for-loop_9 result_5 rest_9)
                                                                                      result_5)))
                                                                                result_4))))
                                                             for-loop_9)
                                                           #t
                                                           lst_18)))
                                                      #f))
                                                (let-values (((d_43) (cdr d_40)))
                                                  (if (pair? d_43)
                                                    (if (let-values (((a_51) (car d_43))) #t)
                                                      (let-values (((d_44) (cdr d_43))) (equal? '() d_44))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((rhss_0 body_2)
                                                  (let-values (((d_45) (cdr v_18)))
                                                    (let-values (((rhss_1)
                                                                  (let-values (((a_52) (car d_45)))
                                                                    (let-values (((rhss_2)
                                                                                  (let-values (((lst_20) a_52))
                                                                                    (begin
                                                                                      (check-list lst_20)
                                                                                      ((letrec-values (((for-loop_10)
                                                                                                        (lambda (rhss_3
                                                                                                                 lst_21)
                                                                                                          (if (pair?
                                                                                                               lst_21)
                                                                                                            (let-values (((v_20)
                                                                                                                          (unsafe-car
                                                                                                                           lst_21))
                                                                                                                         ((rest_10)
                                                                                                                          (unsafe-cdr
                                                                                                                           lst_21)))
                                                                                                              (let-values (((rhss_4)
                                                                                                                            (let-values (((rhss_5)
                                                                                                                                          rhss_3))
                                                                                                                              (let-values (((rhss_6)
                                                                                                                                            (let-values ()
                                                                                                                                              (let-values (((rhss6_0)
                                                                                                                                                            (let-values ()
                                                                                                                                                              (let-values (((d_46)
                                                                                                                                                                            (cdr
                                                                                                                                                                             v_20)))
                                                                                                                                                                (let-values (((a_53)
                                                                                                                                                                              (car
                                                                                                                                                                               d_46)))
                                                                                                                                                                  a_53)))))
                                                                                                                                                (cons
                                                                                                                                                 rhss6_0
                                                                                                                                                 rhss_5)))))
                                                                                                                                (values
                                                                                                                                 rhss_6)))))
                                                                                                                (if (not
                                                                                                                     #f)
                                                                                                                  (for-loop_10
                                                                                                                   rhss_4
                                                                                                                   rest_10)
                                                                                                                  rhss_4)))
                                                                                                            rhss_3))))
                                                                                         for-loop_10)
                                                                                       null
                                                                                       lst_20)))))
                                                                      (reverse$1 rhss_2))))
                                                                 ((body_3)
                                                                  (let-values (((d_47) (cdr d_45)))
                                                                    (let-values (((a_54) (car d_47))) a_54))))
                                                      (values rhss_1 body_3)))))
                                      (if (let-values (((lst_22) rhss_0))
                                            (begin
                                              (check-list lst_22)
                                              ((letrec-values (((for-loop_11)
                                                                (lambda (result_7 lst_23)
                                                                  (if (pair? lst_23)
                                                                    (let-values (((rhs_6) (unsafe-car lst_23))
                                                                                 ((rest_11) (unsafe-cdr lst_23)))
                                                                      (let-values (((result_8)
                                                                                    (let-values ()
                                                                                      (let-values (((result_9)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (simple?_0
                                                                                                         rhs_6)))))
                                                                                        (values result_9)))))
                                                                        (if (if (not
                                                                                 ((lambda x_1 (not result_8)) rhs_6))
                                                                              (not #f)
                                                                              #f)
                                                                          (for-loop_11 result_8 rest_11)
                                                                          result_8)))
                                                                    result_7))))
                                                 for-loop_11)
                                               #t
                                               lst_22)))
                                        (simple?_0 body_2)
                                        #f))
                                    (if (if (pair? v_18)
                                          (if (let-values (((a_55) (car v_18))) (equal? 'let a_55))
                                            (let-values (((d_48) (cdr v_18)))
                                              (if (pair? d_48)
                                                (if (let-values (((a_56) (car d_48)))
                                                      (if (list? a_56)
                                                        (let-values (((lst_24) a_56))
                                                          (begin
                                                            (check-list lst_24)
                                                            ((letrec-values (((for-loop_12)
                                                                              (lambda (result_10 lst_25)
                                                                                (if (pair? lst_25)
                                                                                  (let-values (((v_21)
                                                                                                (unsafe-car lst_25))
                                                                                               ((rest_12)
                                                                                                (unsafe-cdr lst_25)))
                                                                                    (let-values (((result_11)
                                                                                                  (let-values ()
                                                                                                    (let-values (((result_12)
                                                                                                                  (let-values ()
                                                                                                                    (let-values ()
                                                                                                                      (if (pair?
                                                                                                                           v_21)
                                                                                                                        (if (let-values (((a_57)
                                                                                                                                          (car
                                                                                                                                           v_21)))
                                                                                                                              #t)
                                                                                                                          (let-values (((d_49)
                                                                                                                                        (cdr
                                                                                                                                         v_21)))
                                                                                                                            (if (pair?
                                                                                                                                 d_49)
                                                                                                                              (if (let-values (((a_58)
                                                                                                                                                (car
                                                                                                                                                 d_49)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_50)
                                                                                                                                              (cdr
                                                                                                                                               d_49)))
                                                                                                                                  (equal?
                                                                                                                                   '()
                                                                                                                                   d_50))
                                                                                                                                #f)
                                                                                                                              #f))
                                                                                                                          #f)
                                                                                                                        #f)))))
                                                                                                      (values
                                                                                                       result_12)))))
                                                                                      (if (if (not
                                                                                               ((lambda x_2
                                                                                                  (not result_11))
                                                                                                v_21))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_12 result_11 rest_12)
                                                                                        result_11)))
                                                                                  result_10))))
                                                               for-loop_12)
                                                             #t
                                                             lst_24)))
                                                        #f))
                                                  (let-values (((d_51) (cdr d_48)))
                                                    (if (pair? d_51)
                                                      (if (let-values (((a_59) (car d_51))) #t)
                                                        (let-values (((d_52) (cdr d_51))) (equal? '() d_52))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((rhss_7 body_4)
                                                    (let-values (((d_53) (cdr v_18)))
                                                      (let-values (((rhss_8)
                                                                    (let-values (((a_60) (car d_53)))
                                                                      (let-values (((rhss_9)
                                                                                    (let-values (((lst_26) a_60))
                                                                                      (begin
                                                                                        (check-list lst_26)
                                                                                        ((letrec-values (((for-loop_13)
                                                                                                          (lambda (rhss_10
                                                                                                                   lst_27)
                                                                                                            (if (pair?
                                                                                                                 lst_27)
                                                                                                              (let-values (((v_22)
                                                                                                                            (unsafe-car
                                                                                                                             lst_27))
                                                                                                                           ((rest_13)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_27)))
                                                                                                                (let-values (((rhss_11)
                                                                                                                              (let-values (((rhss_12)
                                                                                                                                            rhss_10))
                                                                                                                                (let-values (((rhss_13)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((rhss7_0)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((d_54)
                                                                                                                                                                              (cdr
                                                                                                                                                                               v_22)))
                                                                                                                                                                  (let-values (((a_61)
                                                                                                                                                                                (car
                                                                                                                                                                                 d_54)))
                                                                                                                                                                    a_61)))))
                                                                                                                                                  (cons
                                                                                                                                                   rhss7_0
                                                                                                                                                   rhss_12)))))
                                                                                                                                  (values
                                                                                                                                   rhss_13)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_13
                                                                                                                     rhss_11
                                                                                                                     rest_13)
                                                                                                                    rhss_11)))
                                                                                                              rhss_10))))
                                                                                           for-loop_13)
                                                                                         null
                                                                                         lst_26)))))
                                                                        (reverse$1 rhss_9))))
                                                                   ((body_5)
                                                                    (let-values (((d_55) (cdr d_53)))
                                                                      (let-values (((a_62) (car d_55))) a_62))))
                                                        (values rhss_8 body_5)))))
                                        (if (let-values (((lst_28) rhss_7))
                                              (begin
                                                (check-list lst_28)
                                                ((letrec-values (((for-loop_14)
                                                                  (lambda (result_13 lst_29)
                                                                    (if (pair? lst_29)
                                                                      (let-values (((rhs_7) (unsafe-car lst_29))
                                                                                   ((rest_14) (unsafe-cdr lst_29)))
                                                                        (let-values (((result_14)
                                                                                      (let-values ()
                                                                                        (let-values (((result_15)
                                                                                                      (let-values ()
                                                                                                        (let-values ()
                                                                                                          (simple?_0
                                                                                                           rhs_7)))))
                                                                                          (values result_15)))))
                                                                          (if (if (not
                                                                                   ((lambda x_3 (not result_14)) rhs_7))
                                                                                (not #f)
                                                                                #f)
                                                                            (for-loop_14 result_14 rest_14)
                                                                            result_14)))
                                                                      result_13))))
                                                   for-loop_14)
                                                 #t
                                                 lst_28)))
                                          (simple?_0 body_4)
                                          #f))
                                      (if (if (pair? v_18)
                                            (if (let-values (((a_63) (car v_18))) (equal? 'letrec-values a_63))
                                              (let-values (((d_56) (cdr v_18)))
                                                (if (pair? d_56)
                                                  (if (let-values (((a_64) (car d_56)))
                                                        (if (list? a_64)
                                                          (let-values (((lst_30) a_64))
                                                            (begin
                                                              (check-list lst_30)
                                                              ((letrec-values (((for-loop_15)
                                                                                (lambda (result_16 lst_31)
                                                                                  (if (pair? lst_31)
                                                                                    (let-values (((v_23)
                                                                                                  (unsafe-car lst_31))
                                                                                                 ((rest_15)
                                                                                                  (unsafe-cdr lst_31)))
                                                                                      (let-values (((result_17)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_18)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (if (pair?
                                                                                                                             v_23)
                                                                                                                          (if (let-values (((a_65)
                                                                                                                                            (car
                                                                                                                                             v_23)))
                                                                                                                                (list?
                                                                                                                                 a_65))
                                                                                                                            (let-values (((d_57)
                                                                                                                                          (cdr
                                                                                                                                           v_23)))
                                                                                                                              (if (pair?
                                                                                                                                   d_57)
                                                                                                                                (if (let-values (((a_66)
                                                                                                                                                  (car
                                                                                                                                                   d_57)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_58)
                                                                                                                                                (cdr
                                                                                                                                                 d_57)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_58))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                            #f)
                                                                                                                          #f)))))
                                                                                                        (values
                                                                                                         result_18)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_4
                                                                                                    (not result_17))
                                                                                                  v_23))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_15
                                                                                           result_17
                                                                                           rest_15)
                                                                                          result_17)))
                                                                                    result_16))))
                                                                 for-loop_15)
                                                               #t
                                                               lst_30)))
                                                          #f))
                                                    (let-values (((d_59) (cdr d_56)))
                                                      (if (pair? d_59)
                                                        (if (let-values (((a_67) (car d_59))) #t)
                                                          (let-values (((d_60) (cdr d_59))) (equal? '() d_60))
                                                          #f)
                                                        #f))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((idss_0 rhss_14 body_6)
                                                      (let-values (((d_61) (cdr v_18)))
                                                        (let-values (((idss_1 rhss_15)
                                                                      (let-values (((a_68) (car d_61)))
                                                                        (let-values (((idss_2 rhss_16)
                                                                                      (let-values (((lst_32) a_68))
                                                                                        (begin
                                                                                          (check-list lst_32)
                                                                                          ((letrec-values (((for-loop_16)
                                                                                                            (lambda (idss_3
                                                                                                                     rhss_17
                                                                                                                     lst_33)
                                                                                                              (if (pair?
                                                                                                                   lst_33)
                                                                                                                (let-values (((v_24)
                                                                                                                              (unsafe-car
                                                                                                                               lst_33))
                                                                                                                             ((rest_16)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_33)))
                                                                                                                  (let-values (((idss_4
                                                                                                                                 rhss_18)
                                                                                                                                (let-values (((idss_5)
                                                                                                                                              idss_3)
                                                                                                                                             ((rhss_19)
                                                                                                                                              rhss_17))
                                                                                                                                  (let-values (((idss_6
                                                                                                                                                 rhss_20)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values (((idss8_0
                                                                                                                                                                 rhss9_0)
                                                                                                                                                                (let-values ()
                                                                                                                                                                  (let-values (((idss_7)
                                                                                                                                                                                (let-values (((a_69)
                                                                                                                                                                                              (car
                                                                                                                                                                                               v_24)))
                                                                                                                                                                                  a_69))
                                                                                                                                                                               ((rhss_21)
                                                                                                                                                                                (let-values (((d_62)
                                                                                                                                                                                              (cdr
                                                                                                                                                                                               v_24)))
                                                                                                                                                                                  (let-values (((a_70)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 d_62)))
                                                                                                                                                                                    a_70))))
                                                                                                                                                                    (values
                                                                                                                                                                     idss_7
                                                                                                                                                                     rhss_21)))))
                                                                                                                                                    (values
                                                                                                                                                     (cons
                                                                                                                                                      idss8_0
                                                                                                                                                      idss_5)
                                                                                                                                                     (cons
                                                                                                                                                      rhss9_0
                                                                                                                                                      rhss_19))))))
                                                                                                                                    (values
                                                                                                                                     idss_6
                                                                                                                                     rhss_20)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_16
                                                                                                                       idss_4
                                                                                                                       rhss_18
                                                                                                                       rest_16)
                                                                                                                      (values
                                                                                                                       idss_4
                                                                                                                       rhss_18))))
                                                                                                                (values
                                                                                                                 idss_3
                                                                                                                 rhss_17)))))
                                                                                             for-loop_16)
                                                                                           null
                                                                                           null
                                                                                           lst_32)))))
                                                                          (values
                                                                           (reverse$1 idss_2)
                                                                           (reverse$1 rhss_16)))))
                                                                     ((body_7)
                                                                      (let-values (((d_63) (cdr d_61)))
                                                                        (let-values (((a_71) (car d_63))) a_71))))
                                                          (values idss_1 rhss_15 body_7)))))
                                          (if (let-values (((lst_34) rhss_14))
                                                (begin
                                                  (check-list lst_34)
                                                  ((letrec-values (((for-loop_17)
                                                                    (lambda (result_19 lst_35)
                                                                      (if (pair? lst_35)
                                                                        (let-values (((rhs_8) (unsafe-car lst_35))
                                                                                     ((rest_17) (unsafe-cdr lst_35)))
                                                                          (let-values (((result_20)
                                                                                        (let-values ()
                                                                                          (let-values (((result_21)
                                                                                                        (let-values ()
                                                                                                          (let-values ()
                                                                                                            (simple?_0
                                                                                                             rhs_8)))))
                                                                                            (values result_21)))))
                                                                            (if (if (not
                                                                                     ((lambda x_5 (not result_20))
                                                                                      rhs_8))
                                                                                  (not #f)
                                                                                  #f)
                                                                              (for-loop_17 result_20 rest_17)
                                                                              result_20)))
                                                                        result_19))))
                                                     for-loop_17)
                                                   #t
                                                   lst_34)))
                                            (simple?_0 body_6)
                                            #f))
                                        (if (if (pair? v_18)
                                              (if (let-values (((a_72) (car v_18))) (equal? 'letrec* a_72))
                                                (let-values (((d_64) (cdr v_18)))
                                                  (if (pair? d_64)
                                                    (if (let-values (((a_73) (car d_64)))
                                                          (if (list? a_73)
                                                            (let-values (((lst_36) a_73))
                                                              (begin
                                                                (check-list lst_36)
                                                                ((letrec-values (((for-loop_18)
                                                                                  (lambda (result_22 lst_37)
                                                                                    (if (pair? lst_37)
                                                                                      (let-values (((v_25)
                                                                                                    (unsafe-car lst_37))
                                                                                                   ((rest_18)
                                                                                                    (unsafe-cdr
                                                                                                     lst_37)))
                                                                                        (let-values (((result_23)
                                                                                                      (let-values ()
                                                                                                        (let-values (((result_24)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (if (pair?
                                                                                                                               v_25)
                                                                                                                            (if (let-values (((a_74)
                                                                                                                                              (car
                                                                                                                                               v_25)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_65)
                                                                                                                                            (cdr
                                                                                                                                             v_25)))
                                                                                                                                (if (pair?
                                                                                                                                     d_65)
                                                                                                                                  (if (let-values (((a_75)
                                                                                                                                                    (car
                                                                                                                                                     d_65)))
                                                                                                                                        #t)
                                                                                                                                    (let-values (((d_66)
                                                                                                                                                  (cdr
                                                                                                                                                   d_65)))
                                                                                                                                      (equal?
                                                                                                                                       '()
                                                                                                                                       d_66))
                                                                                                                                    #f)
                                                                                                                                  #f))
                                                                                                                              #f)
                                                                                                                            #f)))))
                                                                                                          (values
                                                                                                           result_24)))))
                                                                                          (if (if (not
                                                                                                   ((lambda x_6
                                                                                                      (not result_23))
                                                                                                    v_25))
                                                                                                (not #f)
                                                                                                #f)
                                                                                            (for-loop_18
                                                                                             result_23
                                                                                             rest_18)
                                                                                            result_23)))
                                                                                      result_22))))
                                                                   for-loop_18)
                                                                 #t
                                                                 lst_36)))
                                                            #f))
                                                      (let-values (((d_67) (cdr d_64)))
                                                        (if (pair? d_67)
                                                          (if (let-values (((a_76) (car d_67))) #t)
                                                            (let-values (((d_68) (cdr d_67))) (equal? '() d_68))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((ids_2 rhss_22 body_8)
                                                        (let-values (((d_69) (cdr v_18)))
                                                          (let-values (((ids_3 rhss_23)
                                                                        (let-values (((a_77) (car d_69)))
                                                                          (let-values (((ids_4 rhss_24)
                                                                                        (let-values (((lst_38) a_77))
                                                                                          (begin
                                                                                            (check-list lst_38)
                                                                                            ((letrec-values (((for-loop_19)
                                                                                                              (lambda (ids_5
                                                                                                                       rhss_25
                                                                                                                       lst_39)
                                                                                                                (if (pair?
                                                                                                                     lst_39)
                                                                                                                  (let-values (((v_26)
                                                                                                                                (unsafe-car
                                                                                                                                 lst_39))
                                                                                                                               ((rest_19)
                                                                                                                                (unsafe-cdr
                                                                                                                                 lst_39)))
                                                                                                                    (let-values (((ids_6
                                                                                                                                   rhss_26)
                                                                                                                                  (let-values (((ids_7)
                                                                                                                                                ids_5)
                                                                                                                                               ((rhss_27)
                                                                                                                                                rhss_25))
                                                                                                                                    (let-values (((ids_8
                                                                                                                                                   rhss_28)
                                                                                                                                                  (let-values ()
                                                                                                                                                    (let-values (((ids10_0
                                                                                                                                                                   rhss11_0)
                                                                                                                                                                  (let-values ()
                                                                                                                                                                    (let-values (((ids_9)
                                                                                                                                                                                  (let-values (((a_78)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 v_26)))
                                                                                                                                                                                    a_78))
                                                                                                                                                                                 ((rhss_29)
                                                                                                                                                                                  (let-values (((d_70)
                                                                                                                                                                                                (cdr
                                                                                                                                                                                                 v_26)))
                                                                                                                                                                                    (let-values (((a_79)
                                                                                                                                                                                                  (car
                                                                                                                                                                                                   d_70)))
                                                                                                                                                                                      a_79))))
                                                                                                                                                                      (values
                                                                                                                                                                       ids_9
                                                                                                                                                                       rhss_29)))))
                                                                                                                                                      (values
                                                                                                                                                       (cons
                                                                                                                                                        ids10_0
                                                                                                                                                        ids_7)
                                                                                                                                                       (cons
                                                                                                                                                        rhss11_0
                                                                                                                                                        rhss_27))))))
                                                                                                                                      (values
                                                                                                                                       ids_8
                                                                                                                                       rhss_28)))))
                                                                                                                      (if (not
                                                                                                                           #f)
                                                                                                                        (for-loop_19
                                                                                                                         ids_6
                                                                                                                         rhss_26
                                                                                                                         rest_19)
                                                                                                                        (values
                                                                                                                         ids_6
                                                                                                                         rhss_26))))
                                                                                                                  (values
                                                                                                                   ids_5
                                                                                                                   rhss_25)))))
                                                                                               for-loop_19)
                                                                                             null
                                                                                             null
                                                                                             lst_38)))))
                                                                            (values
                                                                             (reverse$1 ids_4)
                                                                             (reverse$1 rhss_24)))))
                                                                       ((body_9)
                                                                        (let-values (((d_71) (cdr d_69)))
                                                                          (let-values (((a_80) (car d_71))) a_80))))
                                                            (values ids_3 rhss_23 body_9)))))
                                            (if (let-values (((lst_40) rhss_22))
                                                  (begin
                                                    (check-list lst_40)
                                                    ((letrec-values (((for-loop_20)
                                                                      (lambda (result_25 lst_41)
                                                                        (if (pair? lst_41)
                                                                          (let-values (((rhs_9) (unsafe-car lst_41))
                                                                                       ((rest_20) (unsafe-cdr lst_41)))
                                                                            (let-values (((result_26)
                                                                                          (let-values ()
                                                                                            (let-values (((result_27)
                                                                                                          (let-values ()
                                                                                                            (let-values ()
                                                                                                              (simple?_0
                                                                                                               rhs_9)))))
                                                                                              (values result_27)))))
                                                                              (if (if (not
                                                                                       ((lambda x_7 (not result_26))
                                                                                        rhs_9))
                                                                                    (not #f)
                                                                                    #f)
                                                                                (for-loop_20 result_26 rest_20)
                                                                                result_26)))
                                                                          result_25))))
                                                       for-loop_20)
                                                     #t
                                                     lst_40)))
                                              (simple?_0 body_8)
                                              #f))
                                          (if (if (pair? v_18)
                                                (if (let-values (((a_81) (car v_18))) #t)
                                                  (let-values (((d_72) (cdr v_18)))
                                                    (if (pair? d_72)
                                                      (if (let-values (((a_82) (car d_72))) #t)
                                                        (let-values (((d_73) (cdr d_72))) (equal? '() d_73))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((proc_0 arg_0)
                                                          (let-values (((proc_1)
                                                                        (let-values (((a_83) (car v_18))) a_83))
                                                                       ((arg_1)
                                                                        (let-values (((d_74) (cdr v_18)))
                                                                          (let-values (((a_84) (car d_74))) a_84))))
                                                            (values proc_1 arg_1))))
                                              (if (symbol? proc_0)
                                                (if (let-values (((v_27) (hash-ref-either knowns_6 imports_11 proc_0)))
                                                      (if v_27
                                                        (if (not (hash-ref mutated_1 proc_0 #f))
                                                          (let-values (((or-part_1) (known-predicate? v_27)))
                                                            (if or-part_1
                                                              or-part_1
                                                              (if (known-constructor? v_27)
                                                                (= 1 (known-constructor-field-count v_27))
                                                                #f)))
                                                          #f)
                                                        #f))
                                                  (simple?_0 arg_0)
                                                  #f)
                                                #f))
                                            (if (if (pair? v_18)
                                                  (if (let-values (((a_85) (car v_18))) #t)
                                                    (let-values (((d_75) (cdr v_18))) #t)
                                                    #f)
                                                  #f)
                                              (let-values (((proc_2 args_2)
                                                            (let-values (((proc_3)
                                                                          (let-values (((a_86) (car v_18))) a_86))
                                                                         ((args_3)
                                                                          (let-values (((d_76) (cdr v_18))) d_76)))
                                                              (values proc_3 args_3))))
                                                (if (symbol? proc_2)
                                                  (if (let-values (((v_28)
                                                                    (hash-ref-either knowns_6 imports_11 proc_2)))
                                                        (if (known-constructor? v_28)
                                                          (= (length args_2) (known-constructor-field-count v_28))
                                                          #f))
                                                    (if (not (hash-ref mutated_1 proc_2 #f))
                                                      (let-values (((lst_42) args_2))
                                                        (begin
                                                          (check-list lst_42)
                                                          ((letrec-values (((for-loop_21)
                                                                            (lambda (result_28 lst_43)
                                                                              (if (pair? lst_43)
                                                                                (let-values (((arg_2)
                                                                                              (unsafe-car lst_43))
                                                                                             ((rest_21)
                                                                                              (unsafe-cdr lst_43)))
                                                                                  (let-values (((result_29)
                                                                                                (let-values ()
                                                                                                  (let-values (((result_30)
                                                                                                                (let-values ()
                                                                                                                  (let-values ()
                                                                                                                    (simple?_0
                                                                                                                     arg_2)))))
                                                                                                    (values
                                                                                                     result_30)))))
                                                                                    (if (if (not
                                                                                             ((lambda x_8
                                                                                                (not result_29))
                                                                                              arg_2))
                                                                                          (not #f)
                                                                                          #f)
                                                                                      (for-loop_21 result_29 rest_21)
                                                                                      result_29)))
                                                                                result_28))))
                                                             for-loop_21)
                                                           #t
                                                           lst_42)))
                                                      #f)
                                                    #f)
                                                  #f))
                                              (let-values ()
                                                (let-values (((or-part_2)
                                                              (if (symbol? e_1)
                                                                (let-values (((v_29) (hash-ref mutated_1 e_1 #f)))
                                                                  (let-values (((or-part_3) (not v_29)))
                                                                    (if or-part_3 or-part_3 (delayed? v_29))))
                                                                #f)))
                                                  (if or-part_2
                                                    or-part_2
                                                    (let-values (((or-part_4) (integer? e_1)))
                                                      (if or-part_4
                                                        or-part_4
                                                        (let-values (((or-part_5) (boolean? e_1)))
                                                          (if or-part_5
                                                            or-part_5
                                                            (let-values (((or-part_6) (string? e_1)))
                                                              (if or-part_6
                                                                or-part_6
                                                                (let-values (((or-part_7) (bytes? e_1)))
                                                                  (if or-part_7
                                                                    or-part_7
                                                                    (regexp? e_1))))))))))))))))))))))))))
       simple?_0)
     e_0)))
 (define-values
  (struct:struct-type-info
   struct-type-info3.1
   struct-type-info?
   struct-type-info-name
   struct-type-info-parent
   struct-type-info-immediate-field-count
   struct-type-info-field-count
   struct-type-info-pure-constructor?
   struct-type-info-rest)
  (let-values (((struct:_9 make-_9 ?_9 -ref_9 -set!_9)
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
     struct:_9
     make-_9
     ?_9
     (make-struct-field-accessor -ref_9 0 'name)
     (make-struct-field-accessor -ref_9 1 'parent)
     (make-struct-field-accessor -ref_9 2 'immediate-field-count)
     (make-struct-field-accessor -ref_9 3 'field-count)
     (make-struct-field-accessor -ref_9 4 'pure-constructor?)
     (make-struct-field-accessor -ref_9 5 'rest))))
 (define-values
  (hash-ref-either)
  (lambda (knowns_7 imports_12 key_0)
    (let-values (((or-part_8) (hash-ref knowns_7 key_0 #f)))
      (if or-part_8
        or-part_8
        (let-values (((im_2) (hash-ref imports_12 key_0 #f)))
          (if im_2 (hash-ref (import-group-knowns (import-grp im_2)) (import-ext-id im_2) #f) #f))))))
 (define-values
  (make-struct-type-info)
  (lambda (v_30 knowns_8 imports_13 mutated_2)
    (let-values (((v_31) v_30))
      (if (if (pair? v_31)
            (if (let-values (((a_87) (car v_31))) (equal? 'make-struct-type a_87))
              (let-values (((d_77) (cdr v_31)))
                (if (pair? d_77)
                  (if (let-values (((a_88) (car d_77)))
                        (if (pair? a_88)
                          (if (let-values (((a_89) (car a_88))) (equal? 'quote a_89))
                            (let-values (((d_78) (cdr a_88)))
                              (if (pair? d_78)
                                (if (let-values (((a_90) (car d_78))) #t)
                                  (let-values (((d_79) (cdr d_78))) (equal? '() d_79))
                                  #f)
                                #f))
                            #f)
                          #f))
                    (let-values (((d_80) (cdr d_77)))
                      (if (pair? d_80)
                        (if (let-values (((a_91) (car d_80))) #t)
                          (let-values (((d_81) (cdr d_80)))
                            (if (pair? d_81)
                              (if (let-values (((a_92) (car d_81))) #t)
                                (let-values (((d_82) (cdr d_81)))
                                  (if (pair? d_82)
                                    (if (let-values (((a_93) (car d_82))) (equal? 0 a_93))
                                      (let-values (((d_83) (cdr d_82)))
                                        (if (pair? d_83)
                                          (if (let-values (((a_94) (car d_83))) (equal? #f a_94))
                                            (let-values (((d_84) (cdr d_83))) #t)
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
        (let-values (((name_1 parent_0 fields_0 rest_22)
                      (let-values (((d_85) (cdr v_31)))
                        (let-values (((name_2)
                                      (let-values (((a_95) (car d_85)))
                                        (let-values (((d_86) (cdr a_95))) (let-values (((a_96) (car d_86))) a_96))))
                                     ((parent_1 fields_1 rest_23)
                                      (let-values (((d_87) (cdr d_85)))
                                        (let-values (((parent_2) (let-values (((a_97) (car d_87))) a_97))
                                                     ((fields_2 rest_24)
                                                      (let-values (((d_88) (cdr d_87)))
                                                        (let-values (((fields_3)
                                                                      (let-values (((a_98) (car d_88))) a_98))
                                                                     ((rest_25)
                                                                      (let-values (((d_89) (cdr d_88)))
                                                                        (let-values (((d_90) (cdr d_89)))
                                                                          (let-values (((d_91) (cdr d_90))) d_91)))))
                                                          (values fields_3 rest_25)))))
                                          (values parent_2 fields_2 rest_24)))))
                          (values name_2 parent_1 fields_1 rest_23)))))
          (if (symbol? name_1)
            (if (let-values (((or-part_9) (not parent_0)))
                  (if or-part_9
                    or-part_9
                    (if (known-struct-type? (hash-ref-either knowns_8 imports_13 parent_0))
                      (not (hash-ref mutated_2 parent_0 #f))
                      #f)))
              (if (exact-nonnegative-integer? fields_0)
                (struct-type-info3.1
                 name_1
                 parent_0
                 fields_0
                 (+
                  fields_0
                  (if parent_0 (known-struct-type-field-count (hash-ref-either knowns_8 imports_13 parent_0)) 0))
                 (let-values (((or-part_10) (< (length rest_22) 4)))
                   (if or-part_10 or-part_10 (not (list-ref rest_22 3))))
                 rest_22)
                #f)
              #f)
            #f))
        (if (if (pair? v_31)
              (if (let-values (((a_99) (car v_31))) (equal? 'let-values a_99))
                (let-values (((d_92) (cdr v_31)))
                  (if (pair? d_92)
                    (if (let-values (((a_100) (car d_92))) (equal? '() a_100))
                      (let-values (((d_93) (cdr d_92)))
                        (if (pair? d_93)
                          (if (let-values (((a_101) (car d_93))) #t)
                            (let-values (((d_94) (cdr d_93))) (equal? '() d_94))
                            #f)
                          #f))
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((body_10)
                        (let-values (((d_95) (cdr v_31)))
                          (let-values (((d_96) (cdr d_95))) (let-values (((a_102) (car d_96))) a_102)))))
            (make-struct-type-info body_10 knowns_8 imports_13 mutated_2))
          (let-values () #f))))))
 (define-values
  (find-definitions)
  (lambda (v_32 prim-knowns_4 knowns_9 imports_14 mutated_3)
    (let-values (((v_33) v_32))
      (if (if (pair? v_33)
            (if (let-values (((a_103) (car v_33))) (equal? 'define-values a_103))
              (let-values (((d_97) (cdr v_33)))
                (if (pair? d_97)
                  (if (let-values (((a_104) (car d_97)))
                        (if (pair? a_104)
                          (if (let-values (((a_105) (car a_104))) #t)
                            (let-values (((d_98) (cdr a_104))) (equal? '() d_98))
                            #f)
                          #f))
                    (let-values (((d_99) (cdr d_97)))
                      (if (pair? d_99)
                        (if (let-values (((a_106) (car d_99))) #t)
                          (let-values (((d_100) (cdr d_99))) (equal? '() d_100))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((id_6 rhs_10)
                      (let-values (((d_101) (cdr v_33)))
                        (let-values (((id_7)
                                      (let-values (((a_107) (car d_101))) (let-values (((a_108) (car a_107))) a_108)))
                                     ((rhs_11)
                                      (let-values (((d_102) (cdr d_101))) (let-values (((a_109) (car d_102))) a_109))))
                          (values id_7 rhs_11)))))
          (if (lambda? rhs_10)
            (let-values () (hash-set knowns_9 id_6 a-known-procedure))
            (if (simple? rhs_10 prim-knowns_4 knowns_9 imports_14 mutated_3)
              (let-values () (hash-set knowns_9 id_6 a-known-unknown))
              (let-values () knowns_9))))
        (if (if (pair? v_33)
              (if (let-values (((a_110) (car v_33))) (equal? 'define-values a_110))
                (let-values (((d_103) (cdr v_33)))
                  (if (pair? d_103)
                    (if (let-values (((a_111) (car d_103)))
                          (if (pair? a_111)
                            (if (let-values (((a_112) (car a_111))) #t)
                              (let-values (((d_104) (cdr a_111)))
                                (if (pair? d_104)
                                  (if (let-values (((a_113) (car d_104))) #t)
                                    (let-values (((d_105) (cdr d_104)))
                                      (if (pair? d_105)
                                        (if (let-values (((a_114) (car d_105))) #t)
                                          (let-values (((d_106) (cdr d_105))) (list? d_106))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                              #f)
                            #f))
                      (let-values (((d_107) (cdr d_103)))
                        (if (pair? d_107)
                          (if (let-values (((a_115) (car d_107)))
                                (if (pair? a_115)
                                  (if (let-values (((a_116) (car a_115))) (equal? 'let-values a_116))
                                    (let-values (((d_108) (cdr a_115)))
                                      (if (pair? d_108)
                                        (if (let-values (((a_117) (car d_108)))
                                              (if (pair? a_117)
                                                (if (let-values (((a_118) (car a_117)))
                                                      (if (pair? a_118)
                                                        (if (let-values (((a_119) (car a_118)))
                                                              (if (pair? a_119)
                                                                (if (let-values (((a_120) (car a_119))) #t)
                                                                  (let-values (((d_109) (cdr a_119)))
                                                                    (if (pair? d_109)
                                                                      (if (let-values (((a_121) (car d_109))) #t)
                                                                        (let-values (((d_110) (cdr d_109)))
                                                                          (if (pair? d_110)
                                                                            (if (let-values (((a_122) (car d_110))) #t)
                                                                              (let-values (((d_111) (cdr d_110)))
                                                                                (if (pair? d_111)
                                                                                  (if (let-values (((a_123)
                                                                                                    (car d_111)))
                                                                                        #t)
                                                                                    (let-values (((d_112) (cdr d_111)))
                                                                                      (if (pair? d_112)
                                                                                        (if (let-values (((a_124)
                                                                                                          (car d_112)))
                                                                                              #t)
                                                                                          (let-values (((d_113)
                                                                                                        (cdr d_112)))
                                                                                            (equal? '() d_113))
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
                                                          (let-values (((d_114) (cdr a_118)))
                                                            (if (pair? d_114)
                                                              (if (let-values (((a_125) (car d_114))) #t)
                                                                (let-values (((d_115) (cdr d_114))) (equal? '() d_115))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f))
                                                  (let-values (((d_116) (cdr a_117))) (equal? '() d_116))
                                                  #f)
                                                #f))
                                          (let-values (((d_117) (cdr d_108)))
                                            (if (pair? d_117)
                                              (if (let-values (((a_126) (car d_117)))
                                                    (if (pair? a_126)
                                                      (if (let-values (((a_127) (car a_126))) (equal? 'values a_127))
                                                        (let-values (((d_118) (cdr a_126)))
                                                          (if (pair? d_118)
                                                            (if (let-values (((a_128) (car d_118))) #t)
                                                              (let-values (((d_119) (cdr d_118)))
                                                                (if (pair? d_119)
                                                                  (if (let-values (((a_129) (car d_119))) #t)
                                                                    (let-values (((d_120) (cdr d_119)))
                                                                      (if (pair? d_120)
                                                                        (if (let-values (((a_130) (car d_120))) #t)
                                                                          (let-values (((d_121) (cdr d_120)))
                                                                            (list? d_121))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                (let-values (((d_122) (cdr d_117))) (equal? '() d_122))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_123) (cdr d_107))) (equal? '() d_123))
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
                         struct:_10
                         make_0
                         ?_10
                         -ref_10
                         -set!_10
                         rhs_12
                         struct:2_0
                         make2_0
                         ?2_0
                         make-acc/muts_0)
                        (let-values (((d_124) (cdr v_33)))
                          (let-values (((struct:s_1 make-s_1 s?_1 acc/muts_1)
                                        (let-values (((a_131) (car d_124)))
                                          (let-values (((struct:s_2) (let-values (((a_132) (car a_131))) a_132))
                                                       ((make-s_2 s?_2 acc/muts_2)
                                                        (let-values (((d_125) (cdr a_131)))
                                                          (let-values (((make-s_3)
                                                                        (let-values (((a_133) (car d_125))) a_133))
                                                                       ((s?_3 acc/muts_3)
                                                                        (let-values (((d_126) (cdr d_125)))
                                                                          (let-values (((s?_4)
                                                                                        (let-values (((a_134)
                                                                                                      (car d_126)))
                                                                                          a_134))
                                                                                       ((acc/muts_4)
                                                                                        (let-values (((d_127)
                                                                                                      (cdr d_126)))
                                                                                          d_127)))
                                                                            (values s?_4 acc/muts_4)))))
                                                            (values make-s_3 s?_3 acc/muts_3)))))
                                            (values struct:s_2 make-s_2 s?_2 acc/muts_2))))
                                       ((struct:_11
                                         make_1
                                         ?_11
                                         -ref_11
                                         -set!_11
                                         rhs_13
                                         struct:2_1
                                         make2_1
                                         ?2_1
                                         make-acc/muts_1)
                                        (let-values (((d_128) (cdr d_124)))
                                          (let-values (((a_135) (car d_128)))
                                            (let-values (((d_129) (cdr a_135)))
                                              (let-values (((struct:_12 make_2 ?_12 -ref_12 -set!_12 rhs_14)
                                                            (let-values (((a_136) (car d_129)))
                                                              (let-values (((a_137) (car a_136)))
                                                                (let-values (((struct:_13 make_3 ?_13 -ref_13 -set!_13)
                                                                              (let-values (((a_138) (car a_137)))
                                                                                (let-values (((struct:_14)
                                                                                              (let-values (((a_139)
                                                                                                            (car
                                                                                                             a_138)))
                                                                                                a_139))
                                                                                             ((make_4
                                                                                               ?_14
                                                                                               -ref_14
                                                                                               -set!_14)
                                                                                              (let-values (((d_130)
                                                                                                            (cdr
                                                                                                             a_138)))
                                                                                                (let-values (((make_5)
                                                                                                              (let-values (((a_140)
                                                                                                                            (car
                                                                                                                             d_130)))
                                                                                                                a_140))
                                                                                                             ((?_15
                                                                                                               -ref_15
                                                                                                               -set!_15)
                                                                                                              (let-values (((d_131)
                                                                                                                            (cdr
                                                                                                                             d_130)))
                                                                                                                (let-values (((?_16)
                                                                                                                              (let-values (((a_141)
                                                                                                                                            (car
                                                                                                                                             d_131)))
                                                                                                                                a_141))
                                                                                                                             ((-ref_16
                                                                                                                               -set!_16)
                                                                                                                              (let-values (((d_132)
                                                                                                                                            (cdr
                                                                                                                                             d_131)))
                                                                                                                                (let-values (((-ref_17)
                                                                                                                                              (let-values (((a_142)
                                                                                                                                                            (car
                                                                                                                                                             d_132)))
                                                                                                                                                a_142))
                                                                                                                                             ((-set!_17)
                                                                                                                                              (let-values (((d_133)
                                                                                                                                                            (cdr
                                                                                                                                                             d_132)))
                                                                                                                                                (let-values (((a_143)
                                                                                                                                                              (car
                                                                                                                                                               d_133)))
                                                                                                                                                  a_143))))
                                                                                                                                  (values
                                                                                                                                   -ref_17
                                                                                                                                   -set!_17)))))
                                                                                                                  (values
                                                                                                                   ?_16
                                                                                                                   -ref_16
                                                                                                                   -set!_16)))))
                                                                                                  (values
                                                                                                   make_5
                                                                                                   ?_15
                                                                                                   -ref_15
                                                                                                   -set!_15)))))
                                                                                  (values
                                                                                   struct:_14
                                                                                   make_4
                                                                                   ?_14
                                                                                   -ref_14
                                                                                   -set!_14))))
                                                                             ((rhs_15)
                                                                              (let-values (((d_134) (cdr a_137)))
                                                                                (let-values (((a_144) (car d_134)))
                                                                                  a_144))))
                                                                  (values
                                                                   struct:_13
                                                                   make_3
                                                                   ?_13
                                                                   -ref_13
                                                                   -set!_13
                                                                   rhs_15)))))
                                                           ((struct:2_2 make2_2 ?2_2 make-acc/muts_2)
                                                            (let-values (((d_135) (cdr d_129)))
                                                              (let-values (((a_145) (car d_135)))
                                                                (let-values (((d_136) (cdr a_145)))
                                                                  (let-values (((struct:2_3)
                                                                                (let-values (((a_146) (car d_136)))
                                                                                  a_146))
                                                                               ((make2_3 ?2_3 make-acc/muts_3)
                                                                                (let-values (((d_137) (cdr d_136)))
                                                                                  (let-values (((make2_4)
                                                                                                (let-values (((a_147)
                                                                                                              (car
                                                                                                               d_137)))
                                                                                                  a_147))
                                                                                               ((?2_4 make-acc/muts_4)
                                                                                                (let-values (((d_138)
                                                                                                              (cdr
                                                                                                               d_137)))
                                                                                                  (let-values (((?2_5)
                                                                                                                (let-values (((a_148)
                                                                                                                              (car
                                                                                                                               d_138)))
                                                                                                                  a_148))
                                                                                                               ((make-acc/muts_5)
                                                                                                                (let-values (((d_139)
                                                                                                                              (cdr
                                                                                                                               d_138)))
                                                                                                                  d_139)))
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
                                                 struct:_12
                                                 make_2
                                                 ?_12
                                                 -ref_12
                                                 -set!_12
                                                 rhs_14
                                                 struct:2_2
                                                 make2_2
                                                 ?2_2
                                                 make-acc/muts_2)))))))
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
                             rhs_13
                             struct:2_1
                             make2_1
                             ?2_1
                             make-acc/muts_1)))))
            (let-values (((info_0)
                          (if (eq? struct:_10 struct:2_0)
                            (if (eq? make_0 make2_0)
                              (if (eq? ?_10 ?2_0) (make-struct-type-info rhs_12 knowns_9 imports_14 mutated_3) #f)
                              #f)
                            #f)))
              (if info_0
                (let-values ()
                  (let-values (((type_0) (gensym (symbol->string make-s_0))))
                    (let-values (((knowns_10)
                                  (hash-set
                                   knowns_9
                                   make-s_0
                                   (if (struct-type-info-pure-constructor? info_0)
                                     (known-constructor type_0 (struct-type-info-field-count info_0))
                                     a-known-procedure))))
                      (let-values (((knowns_11) (hash-set knowns_10 s?_0 (known-predicate type_0))))
                        (let-values (((knowns_12)
                                      (let-values (((lst_44) acc/muts_0) ((lst_45) make-acc/muts_0))
                                        (begin
                                          (check-list lst_44)
                                          (check-list lst_45)
                                          ((letrec-values (((for-loop_22)
                                                            (lambda (knowns_13 lst_46 lst_47)
                                                              (if (if (pair? lst_46) (pair? lst_47) #f)
                                                                (let-values (((id_8) (unsafe-car lst_46))
                                                                             ((rest_26) (unsafe-cdr lst_46))
                                                                             ((maker_0) (unsafe-car lst_47))
                                                                             ((rest_27) (unsafe-cdr lst_47)))
                                                                  (let-values (((knowns_14)
                                                                                (let-values (((knowns_15) knowns_13))
                                                                                  (let-values (((knowns_16)
                                                                                                (let-values ()
                                                                                                  (if (eq?
                                                                                                       (car maker_0)
                                                                                                       -ref_10)
                                                                                                    (let-values ()
                                                                                                      (hash-set
                                                                                                       knowns_15
                                                                                                       id_8
                                                                                                       (known-accessor
                                                                                                        type_0)))
                                                                                                    (let-values ()
                                                                                                      (hash-set
                                                                                                       knowns_15
                                                                                                       id_8
                                                                                                       (known-mutator
                                                                                                        type_0)))))))
                                                                                    (values knowns_16)))))
                                                                    (if (not #f)
                                                                      (for-loop_22 knowns_14 rest_26 rest_27)
                                                                      knowns_14)))
                                                                knowns_13))))
                                             for-loop_22)
                                           knowns_11
                                           lst_44
                                           lst_45)))))
                          (hash-set
                           knowns_12
                           struct:s_0
                           (known-struct-type type_0 (struct-type-info-field-count info_0))))))))
                (let-values () knowns_9))))
          (if (if (pair? v_33)
                (if (let-values (((a_149) (car v_33))) (equal? 'define-values a_149))
                  (let-values (((d_140) (cdr v_33)))
                    (if (pair? d_140)
                      (if (let-values (((a_150) (car d_140)))
                            (if (pair? a_150)
                              (if (let-values (((a_151) (car a_150))) #t)
                                (let-values (((d_141) (cdr a_150)))
                                  (if (pair? d_141)
                                    (if (let-values (((a_152) (car d_141))) #t)
                                      (let-values (((d_142) (cdr d_141)))
                                        (if (pair? d_142)
                                          (if (let-values (((a_153) (car d_142))) #t)
                                            (let-values (((d_143) (cdr d_142)))
                                              (if (pair? d_143)
                                                (if (let-values (((a_154) (car d_143))) #t)
                                                  (let-values (((d_144) (cdr d_143)))
                                                    (if (pair? d_144)
                                                      (if (let-values (((a_155) (car d_144))) #t)
                                                        (let-values (((d_145) (cdr d_144))) (equal? '() d_145))
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
                        (let-values (((d_146) (cdr d_140)))
                          (if (pair? d_146)
                            (if (let-values (((a_156) (car d_146))) #t)
                              (let-values (((d_147) (cdr d_146))) (equal? '() d_147))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((struct:s_3 make-s_4 s?_5 s-ref_0 s-set!_0 rhs_16)
                          (let-values (((d_148) (cdr v_33)))
                            (let-values (((struct:s_4 make-s_5 s?_6 s-ref_1 s-set!_1)
                                          (let-values (((a_157) (car d_148)))
                                            (let-values (((struct:s_5) (let-values (((a_158) (car a_157))) a_158))
                                                         ((make-s_6 s?_7 s-ref_2 s-set!_2)
                                                          (let-values (((d_149) (cdr a_157)))
                                                            (let-values (((make-s_7)
                                                                          (let-values (((a_159) (car d_149))) a_159))
                                                                         ((s?_8 s-ref_3 s-set!_3)
                                                                          (let-values (((d_150) (cdr d_149)))
                                                                            (let-values (((s?_9)
                                                                                          (let-values (((a_160)
                                                                                                        (car d_150)))
                                                                                            a_160))
                                                                                         ((s-ref_4 s-set!_4)
                                                                                          (let-values (((d_151)
                                                                                                        (cdr d_150)))
                                                                                            (let-values (((s-ref_5)
                                                                                                          (let-values (((a_161)
                                                                                                                        (car
                                                                                                                         d_151)))
                                                                                                            a_161))
                                                                                                         ((s-set!_5)
                                                                                                          (let-values (((d_152)
                                                                                                                        (cdr
                                                                                                                         d_151)))
                                                                                                            (let-values (((a_162)
                                                                                                                          (car
                                                                                                                           d_152)))
                                                                                                              a_162))))
                                                                                              (values
                                                                                               s-ref_5
                                                                                               s-set!_5)))))
                                                                              (values s?_9 s-ref_4 s-set!_4)))))
                                                              (values make-s_7 s?_8 s-ref_3 s-set!_3)))))
                                              (values struct:s_5 make-s_6 s?_7 s-ref_2 s-set!_2))))
                                         ((rhs_17)
                                          (let-values (((d_153) (cdr d_148)))
                                            (let-values (((a_163) (car d_153))) a_163))))
                              (values struct:s_4 make-s_5 s?_6 s-ref_1 s-set!_1 rhs_17)))))
              (let-values (((info_1) (make-struct-type-info rhs_16 knowns_9 imports_14 mutated_3)))
                (if info_1
                  (let-values ()
                    (let-values (((type_1) (gensym (symbol->string make-s_4))))
                      (let-values (((knowns_17)
                                    (hash-set
                                     knowns_9
                                     make-s_4
                                     (if (struct-type-info-pure-constructor? info_1)
                                       (known-constructor type_1 (struct-type-info-field-count info_1))
                                       a-known-procedure))))
                        (let-values (((knowns_18) (hash-set knowns_17 s?_5 (known-predicate type_1))))
                          (hash-set
                           knowns_18
                           struct:s_3
                           (known-struct-type type_1 (struct-type-info-field-count info_1)))))))
                  (let-values () knowns_9))))
            (let-values () knowns_9)))))))
 (define-values
  (left-to-right/let)
  (lambda (v_34 prim-knowns_5 knowns_19 imports_15 mutated_4)
    (let-values (((v_35) v_34))
      (if (if (pair? v_35)
            (if (let-values (((a_164) (car v_35))) (equal? 'let a_164))
              (let-values (((d_154) (cdr v_35)))
                (if (pair? d_154)
                  (if (let-values (((a_165) (car d_154)))
                        (if (pair? a_165)
                          (if (let-values (((a_166) (car a_165))) #t)
                            (let-values (((d_155) (cdr a_165))) (equal? '() d_155))
                            #f)
                          #f))
                    (let-values (((d_156) (cdr d_154))) #t)
                    #f)
                  #f))
              #f)
            #f)
        (let-values () v_34)
        (if (if (pair? v_35)
              (if (let-values (((a_167) (car v_35))) (equal? 'let a_167))
                (let-values (((d_157) (cdr v_35)))
                  (if (pair? d_157)
                    (if (let-values (((a_168) (car d_157)))
                          (if (list? a_168)
                            (let-values (((lst_48) a_168))
                              (begin
                                (check-list lst_48)
                                ((letrec-values (((for-loop_23)
                                                  (lambda (result_31 lst_49)
                                                    (if (pair? lst_49)
                                                      (let-values (((v_36) (unsafe-car lst_49))
                                                                   ((rest_28) (unsafe-cdr lst_49)))
                                                        (let-values (((result_32)
                                                                      (let-values ()
                                                                        (let-values (((result_33)
                                                                                      (let-values ()
                                                                                        (let-values ()
                                                                                          (if (pair? v_36)
                                                                                            (if (let-values (((a_169)
                                                                                                              (car
                                                                                                               v_36)))
                                                                                                  #t)
                                                                                              (let-values (((d_158)
                                                                                                            (cdr v_36)))
                                                                                                (if (pair? d_158)
                                                                                                  (if (let-values (((a_170)
                                                                                                                    (car
                                                                                                                     d_158)))
                                                                                                        #t)
                                                                                                    (let-values (((d_159)
                                                                                                                  (cdr
                                                                                                                   d_158)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_159))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f)))))
                                                                          (values result_33)))))
                                                          (if (if (not ((lambda x_9 (not result_32)) v_36)) (not #f) #f)
                                                            (for-loop_23 result_32 rest_28)
                                                            result_32)))
                                                      result_31))))
                                   for-loop_23)
                                 #t
                                 lst_48)))
                            #f))
                      (let-values (((d_160) (cdr d_157))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_10 rhss_30 bodys_0)
                        (let-values (((d_161) (cdr v_35)))
                          (let-values (((ids_11 rhss_31)
                                        (let-values (((a_171) (car d_161)))
                                          (let-values (((ids_12 rhss_32)
                                                        (let-values (((lst_50) a_171))
                                                          (begin
                                                            (check-list lst_50)
                                                            ((letrec-values (((for-loop_24)
                                                                              (lambda (ids_13 rhss_33 lst_51)
                                                                                (if (pair? lst_51)
                                                                                  (let-values (((v_37)
                                                                                                (unsafe-car lst_51))
                                                                                               ((rest_29)
                                                                                                (unsafe-cdr lst_51)))
                                                                                    (let-values (((ids_14 rhss_34)
                                                                                                  (let-values (((ids_15)
                                                                                                                ids_13)
                                                                                                               ((rhss_35)
                                                                                                                rhss_33))
                                                                                                    (let-values (((ids_16
                                                                                                                   rhss_36)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((ids13_0
                                                                                                                                   rhss14_0)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values (((ids_17)
                                                                                                                                                  (let-values (((a_172)
                                                                                                                                                                (car
                                                                                                                                                                 v_37)))
                                                                                                                                                    a_172))
                                                                                                                                                 ((rhss_37)
                                                                                                                                                  (let-values (((d_162)
                                                                                                                                                                (cdr
                                                                                                                                                                 v_37)))
                                                                                                                                                    (let-values (((a_173)
                                                                                                                                                                  (car
                                                                                                                                                                   d_162)))
                                                                                                                                                      a_173))))
                                                                                                                                      (values
                                                                                                                                       ids_17
                                                                                                                                       rhss_37)))))
                                                                                                                      (values
                                                                                                                       (cons
                                                                                                                        ids13_0
                                                                                                                        ids_15)
                                                                                                                       (cons
                                                                                                                        rhss14_0
                                                                                                                        rhss_35))))))
                                                                                                      (values
                                                                                                       ids_16
                                                                                                       rhss_36)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_24
                                                                                         ids_14
                                                                                         rhss_34
                                                                                         rest_29)
                                                                                        (values ids_14 rhss_34))))
                                                                                  (values ids_13 rhss_33)))))
                                                               for-loop_24)
                                                             null
                                                             null
                                                             lst_50)))))
                                            (values (reverse$1 ids_12) (reverse$1 rhss_32)))))
                                       ((bodys_1) (let-values (((d_163) (cdr d_161))) d_163)))
                            (values ids_11 rhss_31 bodys_1)))))
            ((letrec-values (((loop_6)
                              (lambda (ids_18 rhss_38 binds_0)
                                (if (null? (cdr rhss_38))
                                  (let-values ()
                                    (if (null? binds_0)
                                      (list* 'let (list (list (car ids_18) (car rhss_38))) bodys_0)
                                      (list
                                       'let
                                       (list (list (car ids_18) (car rhss_38)))
                                       (list* 'let binds_0 bodys_0))))
                                  (if (simple? (car rhss_38) prim-knowns_5 knowns_19 imports_15 mutated_4)
                                    (let-values ()
                                      (list
                                       'let
                                       (list (list (car ids_18) (car rhss_38)))
                                       (loop_6 (cdr ids_18) (cdr rhss_38) binds_0)))
                                    (let-values ()
                                      (let-values (((id_9) (car ids_18)))
                                        (list
                                         'let
                                         (list (list id_9 (car rhss_38)))
                                         (loop_6 (cdr ids_18) (cdr rhss_38) (cons (list id_9 id_9) binds_0))))))))))
               loop_6)
             ids_10
             rhss_30
             null))
          (error 'match "failed ~e" v_35))))))
 (define-values
  (left-to-right/let-values)
  (lambda (v_38 mutated_5)
    (let-values (((v_39) v_38))
      (if (if (pair? v_39)
            (if (let-values (((a_174) (car v_39))) (equal? 'let-values a_174))
              (let-values (((d_164) (cdr v_39)))
                (if (pair? d_164)
                  (if (let-values (((a_175) (car d_164)))
                        (if (pair? a_175)
                          (if (let-values (((a_176) (car a_175)))
                                (if (pair? a_176)
                                  (if (let-values (((a_177) (car a_176))) #t)
                                    (let-values (((d_165) (cdr a_176)))
                                      (if (pair? d_165)
                                        (if (let-values (((a_178) (car d_165))) #t)
                                          (let-values (((d_166) (cdr d_165))) (equal? '() d_166))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_167) (cdr a_175))) (equal? '() d_167))
                            #f)
                          #f))
                    (let-values (((d_168) (cdr d_164)))
                      (if (pair? d_168)
                        (if (let-values (((a_179) (car d_168))) #t)
                          (let-values (((d_169) (cdr d_168))) (equal? '() d_169))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((ids_19 rhs_18 body_11)
                      (let-values (((d_170) (cdr v_39)))
                        (let-values (((ids_20 rhs_19)
                                      (let-values (((a_180) (car d_170)))
                                        (let-values (((a_181) (car a_180)))
                                          (let-values (((ids_21) (let-values (((a_182) (car a_181))) a_182))
                                                       ((rhs_20)
                                                        (let-values (((d_171) (cdr a_181)))
                                                          (let-values (((a_183) (car d_171))) a_183))))
                                            (values ids_21 rhs_20)))))
                                     ((body_12)
                                      (let-values (((d_172) (cdr d_170))) (let-values (((a_184) (car d_172))) a_184))))
                          (values ids_20 rhs_19 body_12)))))
          (make-let-values ids_19 rhs_18 body_11))
        (if (if (pair? v_39)
              (if (let-values (((a_185) (car v_39))) (equal? 'let-values a_185))
                (let-values (((d_173) (cdr v_39)))
                  (if (pair? d_173)
                    (if (let-values (((a_186) (car d_173)))
                          (if (pair? a_186)
                            (if (let-values (((a_187) (car a_186)))
                                  (if (pair? a_187)
                                    (if (let-values (((a_188) (car a_187))) #t)
                                      (let-values (((d_174) (cdr a_187)))
                                        (if (pair? d_174)
                                          (if (let-values (((a_189) (car d_174))) #t)
                                            (let-values (((d_175) (cdr d_174))) (equal? '() d_175))
                                            #f)
                                          #f))
                                      #f)
                                    #f))
                              (let-values (((d_176) (cdr a_186))) (equal? '() d_176))
                              #f)
                            #f))
                      (let-values (((d_177) (cdr d_173))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_22 rhs_21 bodys_2)
                        (let-values (((d_178) (cdr v_39)))
                          (let-values (((ids_23 rhs_22)
                                        (let-values (((a_190) (car d_178)))
                                          (let-values (((a_191) (car a_190)))
                                            (let-values (((ids_24) (let-values (((a_192) (car a_191))) a_192))
                                                         ((rhs_23)
                                                          (let-values (((d_179) (cdr a_191)))
                                                            (let-values (((a_193) (car d_179))) a_193))))
                                              (values ids_24 rhs_23)))))
                                       ((bodys_3) (let-values (((d_180) (cdr d_178))) d_180)))
                            (values ids_23 rhs_22 bodys_3)))))
            (make-let-values ids_22 rhs_21 (list* 'begin bodys_2)))
          (if (if (pair? v_39)
                (if (let-values (((a_194) (car v_39))) (equal? 'let-values a_194))
                  (let-values (((d_181) (cdr v_39)))
                    (if (pair? d_181)
                      (if (let-values (((a_195) (car d_181)))
                            (if (list? a_195)
                              (let-values (((lst_52) a_195))
                                (begin
                                  (check-list lst_52)
                                  ((letrec-values (((for-loop_25)
                                                    (lambda (result_34 lst_53)
                                                      (if (pair? lst_53)
                                                        (let-values (((v_40) (unsafe-car lst_53))
                                                                     ((rest_30) (unsafe-cdr lst_53)))
                                                          (let-values (((result_35)
                                                                        (let-values ()
                                                                          (let-values (((result_36)
                                                                                        (let-values ()
                                                                                          (let-values ()
                                                                                            (if (pair? v_40)
                                                                                              (if (let-values (((a_196)
                                                                                                                (car
                                                                                                                 v_40)))
                                                                                                    (list? a_196))
                                                                                                (let-values (((d_182)
                                                                                                              (cdr
                                                                                                               v_40)))
                                                                                                  (if (pair? d_182)
                                                                                                    (if (let-values (((a_197)
                                                                                                                      (car
                                                                                                                       d_182)))
                                                                                                          #t)
                                                                                                      (let-values (((d_183)
                                                                                                                    (cdr
                                                                                                                     d_182)))
                                                                                                        (equal?
                                                                                                         '()
                                                                                                         d_183))
                                                                                                      #f)
                                                                                                    #f))
                                                                                                #f)
                                                                                              #f)))))
                                                                            (values result_36)))))
                                                            (if (if (not ((lambda x_10 (not result_35)) v_40))
                                                                  (not #f)
                                                                  #f)
                                                              (for-loop_25 result_35 rest_30)
                                                              result_35)))
                                                        result_34))))
                                     for-loop_25)
                                   #t
                                   lst_52)))
                              #f))
                        (let-values (((d_184) (cdr d_181))) #t)
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((idss_8 rhss_39 bodys_4)
                          (let-values (((d_185) (cdr v_39)))
                            (let-values (((idss_9 rhss_40)
                                          (let-values (((a_198) (car d_185)))
                                            (let-values (((idss_10 rhss_41)
                                                          (let-values (((lst_54) a_198))
                                                            (begin
                                                              (check-list lst_54)
                                                              ((letrec-values (((for-loop_26)
                                                                                (lambda (idss_11 rhss_42 lst_55)
                                                                                  (if (pair? lst_55)
                                                                                    (let-values (((v_41)
                                                                                                  (unsafe-car lst_55))
                                                                                                 ((rest_31)
                                                                                                  (unsafe-cdr lst_55)))
                                                                                      (let-values (((idss_12 rhss_43)
                                                                                                    (let-values (((idss_13)
                                                                                                                  idss_11)
                                                                                                                 ((rhss_44)
                                                                                                                  rhss_42))
                                                                                                      (let-values (((idss_14
                                                                                                                     rhss_45)
                                                                                                                    (let-values ()
                                                                                                                      (let-values (((idss15_0
                                                                                                                                     rhss16_0)
                                                                                                                                    (let-values ()
                                                                                                                                      (let-values (((idss_15)
                                                                                                                                                    (let-values (((a_199)
                                                                                                                                                                  (car
                                                                                                                                                                   v_41)))
                                                                                                                                                      a_199))
                                                                                                                                                   ((rhss_46)
                                                                                                                                                    (let-values (((d_186)
                                                                                                                                                                  (cdr
                                                                                                                                                                   v_41)))
                                                                                                                                                      (let-values (((a_200)
                                                                                                                                                                    (car
                                                                                                                                                                     d_186)))
                                                                                                                                                        a_200))))
                                                                                                                                        (values
                                                                                                                                         idss_15
                                                                                                                                         rhss_46)))))
                                                                                                                        (values
                                                                                                                         (cons
                                                                                                                          idss15_0
                                                                                                                          idss_13)
                                                                                                                         (cons
                                                                                                                          rhss16_0
                                                                                                                          rhss_44))))))
                                                                                                        (values
                                                                                                         idss_14
                                                                                                         rhss_45)))))
                                                                                        (if (not #f)
                                                                                          (for-loop_26
                                                                                           idss_12
                                                                                           rhss_43
                                                                                           rest_31)
                                                                                          (values idss_12 rhss_43))))
                                                                                    (values idss_11 rhss_42)))))
                                                                 for-loop_26)
                                                               null
                                                               null
                                                               lst_54)))))
                                              (values (reverse$1 idss_10) (reverse$1 rhss_41)))))
                                         ((bodys_5) (let-values (((d_187) (cdr d_185))) d_187)))
                              (values idss_9 rhss_40 bodys_5)))))
              ((letrec-values (((loop_7)
                                (lambda (idss_16 rhss_47 binds_1)
                                  (if (null? (cdr rhss_47))
                                    (let-values ()
                                      (make-let-values (car idss_16) (car rhss_47) (list* 'let binds_1 bodys_4)))
                                    (let-values ()
                                      (let-values (((ids_25) (car idss_16)))
                                        (make-let-values
                                         ids_25
                                         (car rhss_47)
                                         (loop_7
                                          (cdr idss_16)
                                          (cdr rhss_47)
                                          (append (map2 (lambda (id_10) (list id_10 id_10)) ids_25) binds_1)))))))))
                 loop_7)
               idss_8
               rhss_39
               null))
            (error 'match "failed ~e" v_39)))))))
 (define-values
  (make-let-values)
  (lambda (ids_26 rhs_24 body_13)
    (if (if (pair? ids_26) (null? (cdr ids_26)) #f)
      (let-values () (list 'let (list (list (car ids_26) rhs_24)) body_13))
      (let-values ()
        (let-values (((v_42) (if (null? ids_26) rhs_24 #f)))
          (if (if (pair? v_42)
                (if (let-values (((a_201) (car v_42))) (equal? 'begin a_201))
                  (let-values (((d_188) (cdr v_42)))
                    (if (pair? d_188)
                      (if (let-values (((a_202) (car d_188))) #t)
                        (let-values (((d_189) (cdr d_188)))
                          (if (pair? d_189)
                            (if (let-values (((a_203) (car d_189)))
                                  (if (pair? a_203)
                                    (if (let-values (((a_204) (car a_203))) (equal? 'values a_204))
                                      (let-values (((d_190) (cdr a_203))) (equal? '() d_190))
                                      #f)
                                    #f))
                              (let-values (((d_191) (cdr d_189))) (equal? '() d_191))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((rhs_25) (let-values (((d_192) (cdr v_42))) (let-values (((a_205) (car d_192))) a_205))))
              (list 'begin rhs_25 body_13))
            (let-values ()
              (list
               'call-with-values
               (list 'lambda '() rhs_24)
               (list
                'case-lambda
                (list ids_26 body_13)
                (list 'args (list* 'raise-result-arity-error (list 'quote ids_26) '(args))))))))))))
 (define-values
  (left-to-right/app)
  (lambda (v_43 prim-knowns_6 knowns_20 imports_16 mutated_6)
    ((letrec-values (((loop_8)
                      (lambda (l_12 accum_0)
                        (if (null? l_12)
                          (let-values () (reverse$1 accum_0))
                          (if (simple? (car l_12) prim-knowns_6 knowns_20 imports_16 mutated_6)
                            (let-values () (loop_8 (cdr l_12) (cons (car l_12) accum_0)))
                            (if (andmap2
                                 (lambda (v_44) (simple? v_44 prim-knowns_6 knowns_20 imports_16 mutated_6))
                                 (cdr l_12))
                              (let-values () (append (reverse$1 accum_0) l_12))
                              (let-values ()
                                (let-values (((g_0) (gensym "app_")))
                                  (list
                                   'let
                                   (list (list g_0 (car l_12)))
                                   (loop_8 (cdr l_12) (cons g_0 accum_0)))))))))))
       loop_8)
     v_43
     null)))
 (define-values
  (make-schemify)
  (lambda (prim-knowns_7 knowns_21 mutated_7 imports_17 exports_8)
    (lambda (v_45)
      ((letrec-values (((schemify_0)
                        (lambda (v_46)
                          (let-values (((v_47) v_46))
                            (if (if (pair? v_47)
                                  (if (let-values (((a_206) (car v_47))) (equal? 'lambda a_206))
                                    (let-values (((d_193) (cdr v_47)))
                                      (if (pair? d_193)
                                        (if (let-values (((a_207) (car d_193))) #t)
                                          (let-values (((d_194) (cdr d_193))) (list? d_194))
                                          #f)
                                        #f))
                                    #f)
                                  #f)
                              (let-values (((formals_0 body_14)
                                            (let-values (((d_195) (cdr v_47)))
                                              (let-values (((formals_1) (let-values (((a_208) (car d_195))) a_208))
                                                           ((body_15) (let-values (((d_196) (cdr d_195))) d_196)))
                                                (values formals_1 body_15)))))
                                (list* 'lambda formals_0 (map2 schemify_0 body_14)))
                              (if (if (pair? v_47)
                                    (if (let-values (((a_209) (car v_47))) (equal? 'case-lambda a_209))
                                      (let-values (((d_197) (cdr v_47)))
                                        (if (list? d_197)
                                          (let-values (((lst_56) d_197))
                                            (begin
                                              (check-list lst_56)
                                              ((letrec-values (((for-loop_27)
                                                                (lambda (result_37 lst_57)
                                                                  (if (pair? lst_57)
                                                                    (let-values (((v_48) (unsafe-car lst_57))
                                                                                 ((rest_32) (unsafe-cdr lst_57)))
                                                                      (let-values (((result_38)
                                                                                    (let-values ()
                                                                                      (let-values (((result_39)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (if (pair? v_48)
                                                                                                          (if (let-values (((a_210)
                                                                                                                            (car
                                                                                                                             v_48)))
                                                                                                                #t)
                                                                                                            (let-values (((d_198)
                                                                                                                          (cdr
                                                                                                                           v_48)))
                                                                                                              (list?
                                                                                                               d_198))
                                                                                                            #f)
                                                                                                          #f)))))
                                                                                        (values result_39)))))
                                                                        (if (if (not
                                                                                 ((lambda x_11 (not result_38)) v_48))
                                                                              (not #f)
                                                                              #f)
                                                                          (for-loop_27 result_38 rest_32)
                                                                          result_38)))
                                                                    result_37))))
                                                 for-loop_27)
                                               #t
                                               lst_56)))
                                          #f))
                                      #f)
                                    #f)
                                (let-values (((formalss_0 bodys_6)
                                              (let-values (((d_199) (cdr v_47)))
                                                (let-values (((formalss_1 bodys_7)
                                                              (let-values (((lst_58) d_199))
                                                                (begin
                                                                  (check-list lst_58)
                                                                  ((letrec-values (((for-loop_28)
                                                                                    (lambda (formalss_2 bodys_8 lst_59)
                                                                                      (if (pair? lst_59)
                                                                                        (let-values (((v_49)
                                                                                                      (unsafe-car
                                                                                                       lst_59))
                                                                                                     ((rest_33)
                                                                                                      (unsafe-cdr
                                                                                                       lst_59)))
                                                                                          (let-values (((formalss_3
                                                                                                         bodys_9)
                                                                                                        (let-values (((formalss_4)
                                                                                                                      formalss_2)
                                                                                                                     ((bodys_10)
                                                                                                                      bodys_8))
                                                                                                          (let-values (((formalss_5
                                                                                                                         bodys_11)
                                                                                                                        (let-values ()
                                                                                                                          (let-values (((formalss17_0
                                                                                                                                         bodys18_0)
                                                                                                                                        (let-values ()
                                                                                                                                          (let-values (((formalss_6)
                                                                                                                                                        (let-values (((a_211)
                                                                                                                                                                      (car
                                                                                                                                                                       v_49)))
                                                                                                                                                          a_211))
                                                                                                                                                       ((bodys_12)
                                                                                                                                                        (let-values (((d_200)
                                                                                                                                                                      (cdr
                                                                                                                                                                       v_49)))
                                                                                                                                                          d_200)))
                                                                                                                                            (values
                                                                                                                                             formalss_6
                                                                                                                                             bodys_12)))))
                                                                                                                            (values
                                                                                                                             (cons
                                                                                                                              formalss17_0
                                                                                                                              formalss_4)
                                                                                                                             (cons
                                                                                                                              bodys18_0
                                                                                                                              bodys_10))))))
                                                                                                            (values
                                                                                                             formalss_5
                                                                                                             bodys_11)))))
                                                                                            (if (not #f)
                                                                                              (for-loop_28
                                                                                               formalss_3
                                                                                               bodys_9
                                                                                               rest_33)
                                                                                              (values
                                                                                               formalss_3
                                                                                               bodys_9))))
                                                                                        (values formalss_2 bodys_8)))))
                                                                     for-loop_28)
                                                                   null
                                                                   null
                                                                   lst_58)))))
                                                  (values (reverse$1 formalss_1) (reverse$1 bodys_7))))))
                                  (list*
                                   'case-lambda
                                   (let-values (((lst_60) formalss_0) ((lst_61) bodys_6))
                                     (begin
                                       (check-list lst_60)
                                       (check-list lst_61)
                                       ((letrec-values (((for-loop_29)
                                                         (lambda (lst_62 lst_63)
                                                           (if (if (pair? lst_62) (pair? lst_63) #f)
                                                             (let-values (((formals_2) (unsafe-car lst_62))
                                                                          ((rest_34) (unsafe-cdr lst_62))
                                                                          ((body_16) (unsafe-car lst_63))
                                                                          ((rest_35) (unsafe-cdr lst_63)))
                                                               (let-values (((post-guard-var_5) (lambda () #t)))
                                                                 (let-values ()
                                                                   (let-values (((elem_4)
                                                                                 (let-values ()
                                                                                   (let-values ()
                                                                                     (list*
                                                                                      formals_2
                                                                                      (map2 schemify_0 body_16))))))
                                                                     (let-values (((result_40)
                                                                                   (if (post-guard-var_5)
                                                                                     (for-loop_29 rest_34 rest_35)
                                                                                     null)))
                                                                       (cons elem_4 result_40))))))
                                                             null))))
                                          for-loop_29)
                                        lst_60
                                        lst_61)))))
                                (if (if (pair? v_47)
                                      (if (let-values (((a_212) (car v_47))) (equal? 'define-values a_212))
                                        (let-values (((d_201) (cdr v_47)))
                                          (if (pair? d_201)
                                            (if (let-values (((a_213) (car d_201)))
                                                  (if (pair? a_213)
                                                    (if (let-values (((a_214) (car a_213))) #t)
                                                      (let-values (((d_202) (cdr a_213)))
                                                        (if (pair? d_202)
                                                          (if (let-values (((a_215) (car d_202))) #t)
                                                            (let-values (((d_203) (cdr d_202)))
                                                              (if (pair? d_203)
                                                                (if (let-values (((a_216) (car d_203))) #t)
                                                                  (let-values (((d_204) (cdr d_203))) (list? d_204))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                              (let-values (((d_205) (cdr d_201)))
                                                (if (pair? d_205)
                                                  (if (let-values (((a_217) (car d_205)))
                                                        (if (pair? a_217)
                                                          (if (let-values (((a_218) (car a_217)))
                                                                (equal? 'let-values a_218))
                                                            (let-values (((d_206) (cdr a_217)))
                                                              (if (pair? d_206)
                                                                (if (let-values (((a_219) (car d_206)))
                                                                      (if (pair? a_219)
                                                                        (if (let-values (((a_220) (car a_219)))
                                                                              (if (pair? a_220)
                                                                                (if (let-values (((a_221) (car a_220)))
                                                                                      (if (pair? a_221)
                                                                                        (if (let-values (((a_222)
                                                                                                          (car a_221)))
                                                                                              #t)
                                                                                          (let-values (((d_207)
                                                                                                        (cdr a_221)))
                                                                                            (if (pair? d_207)
                                                                                              (if (let-values (((a_223)
                                                                                                                (car
                                                                                                                 d_207)))
                                                                                                    #t)
                                                                                                (let-values (((d_208)
                                                                                                              (cdr
                                                                                                               d_207)))
                                                                                                  (if (pair? d_208)
                                                                                                    (if (let-values (((a_224)
                                                                                                                      (car
                                                                                                                       d_208)))
                                                                                                          #t)
                                                                                                      (let-values (((d_209)
                                                                                                                    (cdr
                                                                                                                     d_208)))
                                                                                                        (if (pair?
                                                                                                             d_209)
                                                                                                          (if (let-values (((a_225)
                                                                                                                            (car
                                                                                                                             d_209)))
                                                                                                                #t)
                                                                                                            (let-values (((d_210)
                                                                                                                          (cdr
                                                                                                                           d_209)))
                                                                                                              (if (pair?
                                                                                                                   d_210)
                                                                                                                (if (let-values (((a_226)
                                                                                                                                  (car
                                                                                                                                   d_210)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_211)
                                                                                                                                (cdr
                                                                                                                                 d_210)))
                                                                                                                    (equal?
                                                                                                                     '()
                                                                                                                     d_211))
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
                                                                                  (let-values (((d_212) (cdr a_220)))
                                                                                    (if (pair? d_212)
                                                                                      (if (let-values (((a_227)
                                                                                                        (car d_212)))
                                                                                            #t)
                                                                                        (let-values (((d_213)
                                                                                                      (cdr d_212)))
                                                                                          (equal? '() d_213))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f))
                                                                          (let-values (((d_214) (cdr a_219)))
                                                                            (equal? '() d_214))
                                                                          #f)
                                                                        #f))
                                                                  (let-values (((d_215) (cdr d_206)))
                                                                    (if (pair? d_215)
                                                                      (if (let-values (((a_228) (car d_215)))
                                                                            (if (pair? a_228)
                                                                              (if (let-values (((a_229) (car a_228)))
                                                                                    (equal? 'values a_229))
                                                                                (let-values (((d_216) (cdr a_228)))
                                                                                  (if (pair? d_216)
                                                                                    (if (let-values (((a_230)
                                                                                                      (car d_216)))
                                                                                          #t)
                                                                                      (let-values (((d_217)
                                                                                                    (cdr d_216)))
                                                                                        (if (pair? d_217)
                                                                                          (if (let-values (((a_231)
                                                                                                            (car
                                                                                                             d_217)))
                                                                                                #t)
                                                                                            (let-values (((d_218)
                                                                                                          (cdr d_217)))
                                                                                              (if (pair? d_218)
                                                                                                (if (let-values (((a_232)
                                                                                                                  (car
                                                                                                                   d_218)))
                                                                                                      #t)
                                                                                                  (let-values (((d_219)
                                                                                                                (cdr
                                                                                                                 d_218)))
                                                                                                    (list? d_219))
                                                                                                  #f)
                                                                                                #f))
                                                                                            #f)
                                                                                          #f))
                                                                                      #f)
                                                                                    #f))
                                                                                #f)
                                                                              #f))
                                                                        (let-values (((d_220) (cdr d_215)))
                                                                          (equal? '() d_220))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                    (let-values (((d_221) (cdr d_205))) (equal? '() d_221))
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
                                                (let-values (((d_222) (cdr v_47)))
                                                  (let-values (((struct:s_7 make-s_9 s?_11 acc/muts_6)
                                                                (let-values (((a_233) (car d_222)))
                                                                  (let-values (((struct:s_8)
                                                                                (let-values (((a_234) (car a_233)))
                                                                                  a_234))
                                                                               ((make-s_10 s?_12 acc/muts_7)
                                                                                (let-values (((d_223) (cdr a_233)))
                                                                                  (let-values (((make-s_11)
                                                                                                (let-values (((a_235)
                                                                                                              (car
                                                                                                               d_223)))
                                                                                                  a_235))
                                                                                               ((s?_13 acc/muts_8)
                                                                                                (let-values (((d_224)
                                                                                                              (cdr
                                                                                                               d_223)))
                                                                                                  (let-values (((s?_14)
                                                                                                                (let-values (((a_236)
                                                                                                                              (car
                                                                                                                               d_224)))
                                                                                                                  a_236))
                                                                                                               ((acc/muts_9)
                                                                                                                (let-values (((d_225)
                                                                                                                              (cdr
                                                                                                                               d_224)))
                                                                                                                  d_225)))
                                                                                                    (values
                                                                                                     s?_14
                                                                                                     acc/muts_9)))))
                                                                                    (values
                                                                                     make-s_11
                                                                                     s?_13
                                                                                     acc/muts_8)))))
                                                                    (values struct:s_8 make-s_10 s?_12 acc/muts_7))))
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
                                                                (let-values (((d_226) (cdr d_222)))
                                                                  (let-values (((a_237) (car d_226)))
                                                                    (let-values (((d_227) (cdr a_237)))
                                                                      (let-values (((struct:_17
                                                                                     make_8
                                                                                     ?1_2
                                                                                     -ref_20
                                                                                     -set!_20
                                                                                     mk_2)
                                                                                    (let-values (((a_238) (car d_227)))
                                                                                      (let-values (((a_239)
                                                                                                    (car a_238)))
                                                                                        (let-values (((struct:_18
                                                                                                       make_9
                                                                                                       ?1_3
                                                                                                       -ref_21
                                                                                                       -set!_21)
                                                                                                      (let-values (((a_240)
                                                                                                                    (car
                                                                                                                     a_239)))
                                                                                                        (let-values (((struct:_19)
                                                                                                                      (let-values (((a_241)
                                                                                                                                    (car
                                                                                                                                     a_240)))
                                                                                                                        a_241))
                                                                                                                     ((make_10
                                                                                                                       ?1_4
                                                                                                                       -ref_22
                                                                                                                       -set!_22)
                                                                                                                      (let-values (((d_228)
                                                                                                                                    (cdr
                                                                                                                                     a_240)))
                                                                                                                        (let-values (((make_11)
                                                                                                                                      (let-values (((a_242)
                                                                                                                                                    (car
                                                                                                                                                     d_228)))
                                                                                                                                        a_242))
                                                                                                                                     ((?1_5
                                                                                                                                       -ref_23
                                                                                                                                       -set!_23)
                                                                                                                                      (let-values (((d_229)
                                                                                                                                                    (cdr
                                                                                                                                                     d_228)))
                                                                                                                                        (let-values (((?1_6)
                                                                                                                                                      (let-values (((a_243)
                                                                                                                                                                    (car
                                                                                                                                                                     d_229)))
                                                                                                                                                        a_243))
                                                                                                                                                     ((-ref_24
                                                                                                                                                       -set!_24)
                                                                                                                                                      (let-values (((d_230)
                                                                                                                                                                    (cdr
                                                                                                                                                                     d_229)))
                                                                                                                                                        (let-values (((-ref_25)
                                                                                                                                                                      (let-values (((a_244)
                                                                                                                                                                                    (car
                                                                                                                                                                                     d_230)))
                                                                                                                                                                        a_244))
                                                                                                                                                                     ((-set!_25)
                                                                                                                                                                      (let-values (((d_231)
                                                                                                                                                                                    (cdr
                                                                                                                                                                                     d_230)))
                                                                                                                                                                        (let-values (((a_245)
                                                                                                                                                                                      (car
                                                                                                                                                                                       d_231)))
                                                                                                                                                                          a_245))))
                                                                                                                                                          (values
                                                                                                                                                           -ref_25
                                                                                                                                                           -set!_25)))))
                                                                                                                                          (values
                                                                                                                                           ?1_6
                                                                                                                                           -ref_24
                                                                                                                                           -set!_24)))))
                                                                                                                          (values
                                                                                                                           make_11
                                                                                                                           ?1_5
                                                                                                                           -ref_23
                                                                                                                           -set!_23)))))
                                                                                                          (values
                                                                                                           struct:_19
                                                                                                           make_10
                                                                                                           ?1_4
                                                                                                           -ref_22
                                                                                                           -set!_22))))
                                                                                                     ((mk_3)
                                                                                                      (let-values (((d_232)
                                                                                                                    (cdr
                                                                                                                     a_239)))
                                                                                                        (let-values (((a_246)
                                                                                                                      (car
                                                                                                                       d_232)))
                                                                                                          a_246))))
                                                                                          (values
                                                                                           struct:_18
                                                                                           make_9
                                                                                           ?1_3
                                                                                           -ref_21
                                                                                           -set!_21
                                                                                           mk_3)))))
                                                                                   ((struct:2_6
                                                                                     make2_7
                                                                                     ?2_8
                                                                                     make-acc/muts_8)
                                                                                    (let-values (((d_233) (cdr d_227)))
                                                                                      (let-values (((a_247)
                                                                                                    (car d_233)))
                                                                                        (let-values (((d_234)
                                                                                                      (cdr a_247)))
                                                                                          (let-values (((struct:2_7)
                                                                                                        (let-values (((a_248)
                                                                                                                      (car
                                                                                                                       d_234)))
                                                                                                          a_248))
                                                                                                       ((make2_8
                                                                                                         ?2_9
                                                                                                         make-acc/muts_9)
                                                                                                        (let-values (((d_235)
                                                                                                                      (cdr
                                                                                                                       d_234)))
                                                                                                          (let-values (((make2_9)
                                                                                                                        (let-values (((a_249)
                                                                                                                                      (car
                                                                                                                                       d_235)))
                                                                                                                          a_249))
                                                                                                                       ((?2_10
                                                                                                                         make-acc/muts_10)
                                                                                                                        (let-values (((d_236)
                                                                                                                                      (cdr
                                                                                                                                       d_235)))
                                                                                                                          (let-values (((?2_11)
                                                                                                                                        (let-values (((a_250)
                                                                                                                                                      (car
                                                                                                                                                       d_236)))
                                                                                                                                          a_250))
                                                                                                                                       ((make-acc/muts_11)
                                                                                                                                        (let-values (((d_237)
                                                                                                                                                      (cdr
                                                                                                                                                       d_236)))
                                                                                                                                          d_237)))
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
                                                                         struct:_17
                                                                         make_8
                                                                         ?1_2
                                                                         -ref_20
                                                                         -set!_20
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
                                                     struct:_16
                                                     make_7
                                                     ?1_1
                                                     -ref_19
                                                     -set!_19
                                                     mk_1
                                                     struct:2_5
                                                     make2_6
                                                     ?2_7
                                                     make-acc/muts_7)))))
                                    (let-values (((sti_0)
                                                  (if (eq? struct:_15 struct:2_4)
                                                    (if (eq? make_6 make2_5)
                                                      (if (eq? ?1_0 ?2_6)
                                                        (make-struct-type-info mk_0 knowns_21 imports_17 mutated_7)
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
                                             (struct-type-info-parent sti_0)
                                             #f
                                             #f
                                             #f
                                             (list
                                              'quote
                                              (let-values (((vec_2 i_1)
                                                            (let-values (((start_1) 0)
                                                                         ((end_0)
                                                                          (struct-type-info-immediate-field-count
                                                                           sti_0))
                                                                         ((inc_0) 1))
                                                              (begin
                                                                (check-range start_1 end_0 inc_0)
                                                                ((letrec-values (((for-loop_30)
                                                                                  (lambda (vec_3 i_2 pos_1)
                                                                                    (if (< pos_1 end_0)
                                                                                      (let-values (((i_3) pos_1))
                                                                                        (let-values (((vec_4 i_4)
                                                                                                      (let-values (((vec_5)
                                                                                                                    vec_3)
                                                                                                                   ((i_5)
                                                                                                                    i_2))
                                                                                                        (let-values (((vec_6
                                                                                                                       i_6)
                                                                                                                      (let-values ()
                                                                                                                        (let-values (((new-vec_2)
                                                                                                                                      (if (eq?
                                                                                                                                           i_5
                                                                                                                                           (unsafe-vector*-length
                                                                                                                                            vec_5))
                                                                                                                                        (grow-vector
                                                                                                                                         vec_5)
                                                                                                                                        vec_5)))
                                                                                                                          (begin
                                                                                                                            (unsafe-vector*-set!
                                                                                                                             new-vec_2
                                                                                                                             i_5
                                                                                                                             (let-values ()
                                                                                                                               (list
                                                                                                                                'mutable
                                                                                                                                (string->symbol
                                                                                                                                 (format
                                                                                                                                  "f~a"
                                                                                                                                  i_3)))))
                                                                                                                            (values
                                                                                                                             new-vec_2
                                                                                                                             (unsafe-fx+
                                                                                                                              i_5
                                                                                                                              1)))))))
                                                                                                          (values
                                                                                                           vec_6
                                                                                                           i_6)))))
                                                                                          (if (not #f)
                                                                                            (for-loop_30
                                                                                             vec_4
                                                                                             i_4
                                                                                             (+ pos_1 inc_0))
                                                                                            (values vec_4 i_4))))
                                                                                      (values vec_3 i_2)))))
                                                                   for-loop_30)
                                                                 (make-vector 16)
                                                                 0
                                                                 start_1)))))
                                                (shrink-vector vec_2 i_1)))))
                                           (list
                                            'define
                                            make-s_8
                                            (list
                                             'record-constructor
                                             (list* 'make-record-constructor-descriptor struct:s_6 '(#f #f))))
                                           (list 'define s?_10 (list 'record-predicate struct:s_6))
                                           (qq-append
                                            (let-values (((lst_64) acc/muts_5) ((lst_65) make-acc/muts_6))
                                              (begin
                                                (check-list lst_64)
                                                (check-list lst_65)
                                                ((letrec-values (((for-loop_31)
                                                                  (lambda (lst_66 lst_67)
                                                                    (if (if (pair? lst_66) (pair? lst_67) #f)
                                                                      (let-values (((acc/mut_0) (unsafe-car lst_66))
                                                                                   ((rest_36) (unsafe-cdr lst_66))
                                                                                   ((make-acc/mut_0)
                                                                                    (unsafe-car lst_67))
                                                                                   ((rest_37) (unsafe-cdr lst_67)))
                                                                        (let-values (((post-guard-var_6)
                                                                                      (lambda () #t)))
                                                                          (let-values ()
                                                                            (let-values (((elem_5)
                                                                                          (let-values ()
                                                                                            (let-values ()
                                                                                              (list
                                                                                               'define
                                                                                               acc/mut_0
                                                                                               (let-values (((v_50)
                                                                                                             make-acc/mut_0))
                                                                                                 (if (if (pair? v_50)
                                                                                                       (if (let-values (((a_251)
                                                                                                                         (car
                                                                                                                          v_50)))
                                                                                                             (equal?
                                                                                                              'make-struct-field-accessor
                                                                                                              a_251))
                                                                                                         (let-values (((d_238)
                                                                                                                       (cdr
                                                                                                                        v_50)))
                                                                                                           (if (pair?
                                                                                                                d_238)
                                                                                                             (if (let-values (((a_252)
                                                                                                                               (car
                                                                                                                                d_238)))
                                                                                                                   ((lambda (v_51)
                                                                                                                      (eq?
                                                                                                                       v_51
                                                                                                                       -ref_18))
                                                                                                                    a_252))
                                                                                                               (let-values (((d_239)
                                                                                                                             (cdr
                                                                                                                              d_238)))
                                                                                                                 (if (pair?
                                                                                                                      d_239)
                                                                                                                   (if (let-values (((a_253)
                                                                                                                                     (car
                                                                                                                                      d_239)))
                                                                                                                         #t)
                                                                                                                     (let-values (((d_240)
                                                                                                                                   (cdr
                                                                                                                                    d_239)))
                                                                                                                       (if (pair?
                                                                                                                            d_240)
                                                                                                                         (if (let-values (((a_254)
                                                                                                                                           (car
                                                                                                                                            d_240)))
                                                                                                                               #t)
                                                                                                                           (let-values (((d_241)
                                                                                                                                         (cdr
                                                                                                                                          d_240)))
                                                                                                                             (equal?
                                                                                                                              '()
                                                                                                                              d_241))
                                                                                                                           #f)
                                                                                                                         #f))
                                                                                                                     #f)
                                                                                                                   #f))
                                                                                                               #f)
                                                                                                             #f))
                                                                                                         #f)
                                                                                                       #f)
                                                                                                   (let-values (((pos_2)
                                                                                                                 (let-values (((d_242)
                                                                                                                               (cdr
                                                                                                                                v_50)))
                                                                                                                   (let-values (((d_243)
                                                                                                                                 (cdr
                                                                                                                                  d_242)))
                                                                                                                     (let-values (((a_255)
                                                                                                                                   (car
                                                                                                                                    d_243)))
                                                                                                                       a_255)))))
                                                                                                     (list
                                                                                                      'record-accessor
                                                                                                      struct:s_6
                                                                                                      pos_2))
                                                                                                   (if (if (pair? v_50)
                                                                                                         (if (let-values (((a_256)
                                                                                                                           (car
                                                                                                                            v_50)))
                                                                                                               (equal?
                                                                                                                'make-struct-field-mutator
                                                                                                                a_256))
                                                                                                           (let-values (((d_244)
                                                                                                                         (cdr
                                                                                                                          v_50)))
                                                                                                             (if (pair?
                                                                                                                  d_244)
                                                                                                               (if (let-values (((a_257)
                                                                                                                                 (car
                                                                                                                                  d_244)))
                                                                                                                     ((lambda (v_52)
                                                                                                                        (eq?
                                                                                                                         v_52
                                                                                                                         -set!_18))
                                                                                                                      a_257))
                                                                                                                 (let-values (((d_245)
                                                                                                                               (cdr
                                                                                                                                d_244)))
                                                                                                                   (if (pair?
                                                                                                                        d_245)
                                                                                                                     (if (let-values (((a_258)
                                                                                                                                       (car
                                                                                                                                        d_245)))
                                                                                                                           #t)
                                                                                                                       (let-values (((d_246)
                                                                                                                                     (cdr
                                                                                                                                      d_245)))
                                                                                                                         (if (pair?
                                                                                                                              d_246)
                                                                                                                           (if (let-values (((a_259)
                                                                                                                                             (car
                                                                                                                                              d_246)))
                                                                                                                                 #t)
                                                                                                                             (let-values (((d_247)
                                                                                                                                           (cdr
                                                                                                                                            d_246)))
                                                                                                                               (equal?
                                                                                                                                '()
                                                                                                                                d_247))
                                                                                                                             #f)
                                                                                                                           #f))
                                                                                                                       #f)
                                                                                                                     #f))
                                                                                                                 #f)
                                                                                                               #f))
                                                                                                           #f)
                                                                                                         #f)
                                                                                                     (let-values (((pos_3)
                                                                                                                   (let-values (((d_248)
                                                                                                                                 (cdr
                                                                                                                                  v_50)))
                                                                                                                     (let-values (((d_249)
                                                                                                                                   (cdr
                                                                                                                                    d_248)))
                                                                                                                       (let-values (((a_260)
                                                                                                                                     (car
                                                                                                                                      d_249)))
                                                                                                                         a_260)))))
                                                                                                       (list
                                                                                                        'record-mutator
                                                                                                        struct:s_6
                                                                                                        pos_3))
                                                                                                     (let-values ()
                                                                                                       (error
                                                                                                        "oops"))))))))))
                                                                              (let-values (((result_41)
                                                                                            (if (post-guard-var_6)
                                                                                              (for-loop_31
                                                                                               rest_36
                                                                                               rest_37)
                                                                                              null)))
                                                                                (cons elem_5 result_41))))))
                                                                      null))))
                                                   for-loop_31)
                                                 lst_64
                                                 lst_65)))
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
                                                 (struct-type-info-parent sti_0)
                                                 (map2 schemify_0 (struct-type-info-rest sti_0)))))))))
                                        (let-values () (list 'define-values (cadr v_46) (schemify_0 (caddr v_46)))))))
                                  (if (if (pair? v_47)
                                        (if (let-values (((a_261) (car v_47))) (equal? 'define-values a_261))
                                          (let-values (((d_250) (cdr v_47)))
                                            (if (pair? d_250)
                                              (if (let-values (((a_262) (car d_250)))
                                                    (if (pair? a_262)
                                                      (if (let-values (((a_263) (car a_262))) #t)
                                                        (let-values (((d_251) (cdr a_262))) (equal? '() d_251))
                                                        #f)
                                                      #f))
                                                (let-values (((d_252) (cdr d_250)))
                                                  (if (pair? d_252)
                                                    (if (let-values (((a_264) (car d_252))) #t)
                                                      (let-values (((d_253) (cdr d_252))) (equal? '() d_253))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((id_11 rhs_26)
                                                  (let-values (((d_254) (cdr v_47)))
                                                    (let-values (((id_12)
                                                                  (let-values (((a_265) (car d_254)))
                                                                    (let-values (((a_266) (car a_265))) a_266)))
                                                                 ((rhs_27)
                                                                  (let-values (((d_255) (cdr d_254)))
                                                                    (let-values (((a_267) (car d_255))) a_267))))
                                                      (values id_12 rhs_27)))))
                                      (list 'define id_11 (schemify_0 rhs_26)))
                                    (if (if (pair? v_47)
                                          (if (let-values (((a_268) (car v_47))) (equal? 'define-values a_268))
                                            (let-values (((d_256) (cdr v_47)))
                                              (if (pair? d_256)
                                                (if (let-values (((a_269) (car d_256))) #t)
                                                  (let-values (((d_257) (cdr d_256)))
                                                    (if (pair? d_257)
                                                      (if (let-values (((a_270) (car d_257))) #t)
                                                        (let-values (((d_258) (cdr d_257))) (equal? '() d_258))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((ids_27 rhs_28)
                                                    (let-values (((d_259) (cdr v_47)))
                                                      (let-values (((ids_28) (let-values (((a_271) (car d_259))) a_271))
                                                                   ((rhs_29)
                                                                    (let-values (((d_260) (cdr d_259)))
                                                                      (let-values (((a_272) (car d_260))) a_272))))
                                                        (values ids_28 rhs_29)))))
                                        (list 'define-values ids_27 (schemify_0 rhs_28)))
                                      (if (if (pair? v_47)
                                            (if (let-values (((a_273) (car v_47))) (equal? 'quote a_273))
                                              (let-values (((d_261) (cdr v_47)))
                                                (if (pair? d_261)
                                                  (if (let-values (((a_274) (car d_261))) #t)
                                                    (let-values (((d_262) (cdr d_261))) (equal? '() d_262))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values () v_46)
                                        (if (if (pair? v_47)
                                              (if (let-values (((a_275) (car v_47))) (equal? 'let-values a_275))
                                                (let-values (((d_263) (cdr v_47)))
                                                  (if (pair? d_263)
                                                    (if (let-values (((a_276) (car d_263))) (equal? '() a_276))
                                                      (let-values (((d_264) (cdr d_263)))
                                                        (if (pair? d_264)
                                                          (if (let-values (((a_277) (car d_264))) #t)
                                                            (let-values (((d_265) (cdr d_264))) (equal? '() d_265))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((body_17)
                                                        (let-values (((d_266) (cdr v_47)))
                                                          (let-values (((d_267) (cdr d_266)))
                                                            (let-values (((a_278) (car d_267))) a_278)))))
                                            (schemify_0 body_17))
                                          (if (if (pair? v_47)
                                                (if (let-values (((a_279) (car v_47))) (equal? 'let-values a_279))
                                                  (let-values (((d_268) (cdr v_47)))
                                                    (if (pair? d_268)
                                                      (if (let-values (((a_280) (car d_268))) (equal? '() a_280))
                                                        (let-values (((d_269) (cdr d_268))) (list? d_269))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((bodys_13)
                                                          (let-values (((d_270) (cdr v_47)))
                                                            (let-values (((d_271) (cdr d_270))) d_271))))
                                              (list* 'begin (map2 schemify_0 bodys_13)))
                                            (if (if (pair? v_47)
                                                  (if (let-values (((a_281) (car v_47))) (equal? 'let-values a_281))
                                                    (let-values (((d_272) (cdr v_47)))
                                                      (if (pair? d_272)
                                                        (if (let-values (((a_282) (car d_272)))
                                                              (if (list? a_282)
                                                                (let-values (((lst_68) a_282))
                                                                  (begin
                                                                    (check-list lst_68)
                                                                    ((letrec-values (((for-loop_32)
                                                                                      (lambda (result_42 lst_69)
                                                                                        (if (pair? lst_69)
                                                                                          (let-values (((v_53)
                                                                                                        (unsafe-car
                                                                                                         lst_69))
                                                                                                       ((rest_38)
                                                                                                        (unsafe-cdr
                                                                                                         lst_69)))
                                                                                            (let-values (((result_43)
                                                                                                          (let-values ()
                                                                                                            (let-values (((result_44)
                                                                                                                          (let-values ()
                                                                                                                            (let-values ()
                                                                                                                              (if (pair?
                                                                                                                                   v_53)
                                                                                                                                (if (let-values (((a_283)
                                                                                                                                                  (car
                                                                                                                                                   v_53)))
                                                                                                                                      (if (pair?
                                                                                                                                           a_283)
                                                                                                                                        (if (let-values (((a_284)
                                                                                                                                                          (car
                                                                                                                                                           a_283)))
                                                                                                                                              #t)
                                                                                                                                          (let-values (((d_273)
                                                                                                                                                        (cdr
                                                                                                                                                         a_283)))
                                                                                                                                            (equal?
                                                                                                                                             '()
                                                                                                                                             d_273))
                                                                                                                                          #f)
                                                                                                                                        #f))
                                                                                                                                  (let-values (((d_274)
                                                                                                                                                (cdr
                                                                                                                                                 v_53)))
                                                                                                                                    (if (pair?
                                                                                                                                         d_274)
                                                                                                                                      (if (let-values (((a_285)
                                                                                                                                                        (car
                                                                                                                                                         d_274)))
                                                                                                                                            #t)
                                                                                                                                        (let-values (((d_275)
                                                                                                                                                      (cdr
                                                                                                                                                       d_274)))
                                                                                                                                          (equal?
                                                                                                                                           '()
                                                                                                                                           d_275))
                                                                                                                                        #f)
                                                                                                                                      #f))
                                                                                                                                  #f)
                                                                                                                                #f)))))
                                                                                                              (values
                                                                                                               result_44)))))
                                                                                              (if (if (not
                                                                                                       ((lambda x_12
                                                                                                          (not
                                                                                                           result_43))
                                                                                                        v_53))
                                                                                                    (not #f)
                                                                                                    #f)
                                                                                                (for-loop_32
                                                                                                 result_43
                                                                                                 rest_38)
                                                                                                result_43)))
                                                                                          result_42))))
                                                                       for-loop_32)
                                                                     #t
                                                                     lst_68)))
                                                                #f))
                                                          (let-values (((d_276) (cdr d_272))) (list? d_276))
                                                          #f)
                                                        #f))
                                                    #f)
                                                  #f)
                                              (let-values (((ids_29 rhss_48 bodys_14)
                                                            (let-values (((d_277) (cdr v_47)))
                                                              (let-values (((ids_30 rhss_49)
                                                                            (let-values (((a_286) (car d_277)))
                                                                              (let-values (((ids_31 rhss_50)
                                                                                            (let-values (((lst_70)
                                                                                                          a_286))
                                                                                              (begin
                                                                                                (check-list lst_70)
                                                                                                ((letrec-values (((for-loop_33)
                                                                                                                  (lambda (ids_32
                                                                                                                           rhss_51
                                                                                                                           lst_71)
                                                                                                                    (if (pair?
                                                                                                                         lst_71)
                                                                                                                      (let-values (((v_54)
                                                                                                                                    (unsafe-car
                                                                                                                                     lst_71))
                                                                                                                                   ((rest_39)
                                                                                                                                    (unsafe-cdr
                                                                                                                                     lst_71)))
                                                                                                                        (let-values (((ids_33
                                                                                                                                       rhss_52)
                                                                                                                                      (let-values (((ids_34)
                                                                                                                                                    ids_32)
                                                                                                                                                   ((rhss_53)
                                                                                                                                                    rhss_51))
                                                                                                                                        (let-values (((ids_35
                                                                                                                                                       rhss_54)
                                                                                                                                                      (let-values ()
                                                                                                                                                        (let-values (((ids19_0
                                                                                                                                                                       rhss20_0)
                                                                                                                                                                      (let-values ()
                                                                                                                                                                        (let-values (((ids_36)
                                                                                                                                                                                      (let-values (((a_287)
                                                                                                                                                                                                    (car
                                                                                                                                                                                                     v_54)))
                                                                                                                                                                                        (let-values (((a_288)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       a_287)))
                                                                                                                                                                                          a_288)))
                                                                                                                                                                                     ((rhss_55)
                                                                                                                                                                                      (let-values (((d_278)
                                                                                                                                                                                                    (cdr
                                                                                                                                                                                                     v_54)))
                                                                                                                                                                                        (let-values (((a_289)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       d_278)))
                                                                                                                                                                                          a_289))))
                                                                                                                                                                          (values
                                                                                                                                                                           ids_36
                                                                                                                                                                           rhss_55)))))
                                                                                                                                                          (values
                                                                                                                                                           (cons
                                                                                                                                                            ids19_0
                                                                                                                                                            ids_34)
                                                                                                                                                           (cons
                                                                                                                                                            rhss20_0
                                                                                                                                                            rhss_53))))))
                                                                                                                                          (values
                                                                                                                                           ids_35
                                                                                                                                           rhss_54)))))
                                                                                                                          (if (not
                                                                                                                               #f)
                                                                                                                            (for-loop_33
                                                                                                                             ids_33
                                                                                                                             rhss_52
                                                                                                                             rest_39)
                                                                                                                            (values
                                                                                                                             ids_33
                                                                                                                             rhss_52))))
                                                                                                                      (values
                                                                                                                       ids_32
                                                                                                                       rhss_51)))))
                                                                                                   for-loop_33)
                                                                                                 null
                                                                                                 null
                                                                                                 lst_70)))))
                                                                                (values
                                                                                 (reverse$1 ids_31)
                                                                                 (reverse$1 rhss_50)))))
                                                                           ((bodys_15)
                                                                            (let-values (((d_279) (cdr d_277))) d_279)))
                                                                (values ids_30 rhss_49 bodys_15)))))
                                                (let-values (((new-knowns_1)
                                                              (let-values (((lst_72) ids_29) ((lst_73) rhss_48))
                                                                (begin
                                                                  (check-list lst_72)
                                                                  (check-list lst_73)
                                                                  ((letrec-values (((for-loop_34)
                                                                                    (lambda (knowns_22 lst_74 lst_75)
                                                                                      (if (if (pair? lst_74)
                                                                                            (pair? lst_75)
                                                                                            #f)
                                                                                        (let-values (((id_13)
                                                                                                      (unsafe-car
                                                                                                       lst_74))
                                                                                                     ((rest_40)
                                                                                                      (unsafe-cdr
                                                                                                       lst_74))
                                                                                                     ((rhs_30)
                                                                                                      (unsafe-car
                                                                                                       lst_75))
                                                                                                     ((rest_41)
                                                                                                      (unsafe-cdr
                                                                                                       lst_75)))
                                                                                          (let-values (((knowns_23)
                                                                                                        (let-values (((knowns_24)
                                                                                                                      knowns_22))
                                                                                                          (let-values (((knowns_25)
                                                                                                                        (let-values ()
                                                                                                                          (if (lambda?
                                                                                                                               rhs_30)
                                                                                                                            (hash-set
                                                                                                                             knowns_24
                                                                                                                             id_13
                                                                                                                             a-known-procedure)
                                                                                                                            knowns_24))))
                                                                                                            (values
                                                                                                             knowns_25)))))
                                                                                            (if (not #f)
                                                                                              (for-loop_34
                                                                                               knowns_23
                                                                                               rest_40
                                                                                               rest_41)
                                                                                              knowns_23)))
                                                                                        knowns_22))))
                                                                     for-loop_34)
                                                                   knowns_21
                                                                   lst_72
                                                                   lst_73)))))
                                                  (let-values (((body-schemify_0)
                                                                (make-schemify
                                                                 prim-knowns_7
                                                                 new-knowns_1
                                                                 mutated_7
                                                                 imports_17
                                                                 exports_8)))
                                                    (left-to-right/let
                                                     (list*
                                                      'let
                                                      (let-values (((lst_76) ids_29) ((lst_77) rhss_48))
                                                        (begin
                                                          (check-list lst_76)
                                                          (check-list lst_77)
                                                          ((letrec-values (((for-loop_35)
                                                                            (lambda (lst_78 lst_79)
                                                                              (if (if (pair? lst_78) (pair? lst_79) #f)
                                                                                (let-values (((id_14)
                                                                                              (unsafe-car lst_78))
                                                                                             ((rest_42)
                                                                                              (unsafe-cdr lst_78))
                                                                                             ((rhs_31)
                                                                                              (unsafe-car lst_79))
                                                                                             ((rest_43)
                                                                                              (unsafe-cdr lst_79)))
                                                                                  (let-values (((post-guard-var_7)
                                                                                                (lambda () #t)))
                                                                                    (let-values ()
                                                                                      (let-values (((elem_6)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (list
                                                                                                         id_14
                                                                                                         (schemify_0
                                                                                                          rhs_31))))))
                                                                                        (let-values (((result_45)
                                                                                                      (if (post-guard-var_7)
                                                                                                        (for-loop_35
                                                                                                         rest_42
                                                                                                         rest_43)
                                                                                                        null)))
                                                                                          (cons elem_6 result_45))))))
                                                                                null))))
                                                             for-loop_35)
                                                           lst_76
                                                           lst_77)))
                                                      (map2 body-schemify_0 bodys_14))
                                                     prim-knowns_7
                                                     knowns_21
                                                     imports_17
                                                     mutated_7))))
                                              (if (if (pair? v_47)
                                                    (if (let-values (((a_290) (car v_47))) (equal? 'let-values a_290))
                                                      (let-values (((d_280) (cdr v_47)))
                                                        (if (pair? d_280)
                                                          (if (let-values (((a_291) (car d_280)))
                                                                (if (pair? a_291)
                                                                  (if (let-values (((a_292) (car a_291)))
                                                                        (if (pair? a_292)
                                                                          (if (let-values (((a_293) (car a_292)))
                                                                                (equal? '() a_293))
                                                                            (let-values (((d_281) (cdr a_292)))
                                                                              (if (pair? d_281)
                                                                                (if (let-values (((a_294) (car d_281)))
                                                                                      (if (pair? a_294)
                                                                                        (if (let-values (((a_295)
                                                                                                          (car a_294)))
                                                                                              (equal? 'begin a_295))
                                                                                          (let-values (((d_282)
                                                                                                        (cdr a_294)))
                                                                                            (if (pair? d_282)
                                                                                              (if (let-values (((a_296)
                                                                                                                (car
                                                                                                                 d_282)))
                                                                                                    #t)
                                                                                                (let-values (((d_283)
                                                                                                              (cdr
                                                                                                               d_282)))
                                                                                                  (if (pair? d_283)
                                                                                                    (if (let-values (((a_297)
                                                                                                                      (car
                                                                                                                       d_283)))
                                                                                                          (equal?
                                                                                                           '...
                                                                                                           a_297))
                                                                                                      (let-values (((d_284)
                                                                                                                    (cdr
                                                                                                                     d_283)))
                                                                                                        (if (pair?
                                                                                                             d_284)
                                                                                                          (if (let-values (((a_298)
                                                                                                                            (car
                                                                                                                             d_284)))
                                                                                                                (if (pair?
                                                                                                                     a_298)
                                                                                                                  (if (let-values (((a_299)
                                                                                                                                    (car
                                                                                                                                     a_298)))
                                                                                                                        (equal?
                                                                                                                         'values
                                                                                                                         a_299))
                                                                                                                    (let-values (((d_285)
                                                                                                                                  (cdr
                                                                                                                                   a_298)))
                                                                                                                      (equal?
                                                                                                                       '()
                                                                                                                       d_285))
                                                                                                                    #f)
                                                                                                                  #f))
                                                                                                            (let-values (((d_286)
                                                                                                                          (cdr
                                                                                                                           d_284)))
                                                                                                              (equal?
                                                                                                               '()
                                                                                                               d_286))
                                                                                                            #f)
                                                                                                          #f))
                                                                                                      #f)
                                                                                                    #f))
                                                                                                #f)
                                                                                              #f))
                                                                                          #f)
                                                                                        #f))
                                                                                  (let-values (((d_287) (cdr d_281)))
                                                                                    (equal? '() d_287))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                    (let-values (((d_288) (cdr a_291)))
                                                                      (equal? '() d_288))
                                                                    #f)
                                                                  #f))
                                                            (let-values (((d_289) (cdr d_280))) (list? d_289))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f)
                                                (let-values (((rhss_56 bodys_16)
                                                              (let-values (((d_290) (cdr v_47)))
                                                                (let-values (((rhss_57)
                                                                              (let-values (((a_300) (car d_290)))
                                                                                (let-values (((a_301) (car a_300)))
                                                                                  (let-values (((d_291) (cdr a_301)))
                                                                                    (let-values (((a_302) (car d_291)))
                                                                                      (let-values (((d_292)
                                                                                                    (cdr a_302)))
                                                                                        (let-values (((a_303)
                                                                                                      (car d_292)))
                                                                                          a_303)))))))
                                                                             ((bodys_17)
                                                                              (let-values (((d_293) (cdr d_290)))
                                                                                d_293)))
                                                                  (values rhss_57 bodys_17)))))
                                                  (list*
                                                   'begin
                                                   (qq-append (map2 schemify_0 rhss_56) (map2 schemify_0 bodys_16))))
                                                (if (if (pair? v_47)
                                                      (if (let-values (((a_304) (car v_47))) (equal? 'let-values a_304))
                                                        (let-values (((d_294) (cdr v_47)))
                                                          (if (pair? d_294)
                                                            (if (let-values (((a_305) (car d_294)))
                                                                  (if (list? a_305)
                                                                    (let-values (((lst_80) a_305))
                                                                      (begin
                                                                        (check-list lst_80)
                                                                        ((letrec-values (((for-loop_36)
                                                                                          (lambda (result_46 lst_81)
                                                                                            (if (pair? lst_81)
                                                                                              (let-values (((v_55)
                                                                                                            (unsafe-car
                                                                                                             lst_81))
                                                                                                           ((rest_44)
                                                                                                            (unsafe-cdr
                                                                                                             lst_81)))
                                                                                                (let-values (((result_47)
                                                                                                              (let-values ()
                                                                                                                (let-values (((result_48)
                                                                                                                              (let-values ()
                                                                                                                                (let-values ()
                                                                                                                                  (if (pair?
                                                                                                                                       v_55)
                                                                                                                                    (if (let-values (((a_306)
                                                                                                                                                      (car
                                                                                                                                                       v_55)))
                                                                                                                                          (list?
                                                                                                                                           a_306))
                                                                                                                                      (let-values (((d_295)
                                                                                                                                                    (cdr
                                                                                                                                                     v_55)))
                                                                                                                                        (if (pair?
                                                                                                                                             d_295)
                                                                                                                                          (if (let-values (((a_307)
                                                                                                                                                            (car
                                                                                                                                                             d_295)))
                                                                                                                                                #t)
                                                                                                                                            (let-values (((d_296)
                                                                                                                                                          (cdr
                                                                                                                                                           d_295)))
                                                                                                                                              (equal?
                                                                                                                                               '()
                                                                                                                                               d_296))
                                                                                                                                            #f)
                                                                                                                                          #f))
                                                                                                                                      #f)
                                                                                                                                    #f)))))
                                                                                                                  (values
                                                                                                                   result_48)))))
                                                                                                  (if (if (not
                                                                                                           ((lambda x_13
                                                                                                              (not
                                                                                                               result_47))
                                                                                                            v_55))
                                                                                                        (not #f)
                                                                                                        #f)
                                                                                                    (for-loop_36
                                                                                                     result_47
                                                                                                     rest_44)
                                                                                                    result_47)))
                                                                                              result_46))))
                                                                           for-loop_36)
                                                                         #t
                                                                         lst_80)))
                                                                    #f))
                                                              (let-values (((d_297) (cdr d_294))) (list? d_297))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((idss_17 rhss_58 bodys_18)
                                                                (let-values (((d_298) (cdr v_47)))
                                                                  (let-values (((idss_18 rhss_59)
                                                                                (let-values (((a_308) (car d_298)))
                                                                                  (let-values (((idss_19 rhss_60)
                                                                                                (let-values (((lst_82)
                                                                                                              a_308))
                                                                                                  (begin
                                                                                                    (check-list lst_82)
                                                                                                    ((letrec-values (((for-loop_37)
                                                                                                                      (lambda (idss_20
                                                                                                                               rhss_61
                                                                                                                               lst_83)
                                                                                                                        (if (pair?
                                                                                                                             lst_83)
                                                                                                                          (let-values (((v_56)
                                                                                                                                        (unsafe-car
                                                                                                                                         lst_83))
                                                                                                                                       ((rest_45)
                                                                                                                                        (unsafe-cdr
                                                                                                                                         lst_83)))
                                                                                                                            (let-values (((idss_21
                                                                                                                                           rhss_62)
                                                                                                                                          (let-values (((idss_22)
                                                                                                                                                        idss_20)
                                                                                                                                                       ((rhss_63)
                                                                                                                                                        rhss_61))
                                                                                                                                            (let-values (((idss_23
                                                                                                                                                           rhss_64)
                                                                                                                                                          (let-values ()
                                                                                                                                                            (let-values (((idss21_0
                                                                                                                                                                           rhss22_0)
                                                                                                                                                                          (let-values ()
                                                                                                                                                                            (let-values (((idss_24)
                                                                                                                                                                                          (let-values (((a_309)
                                                                                                                                                                                                        (car
                                                                                                                                                                                                         v_56)))
                                                                                                                                                                                            a_309))
                                                                                                                                                                                         ((rhss_65)
                                                                                                                                                                                          (let-values (((d_299)
                                                                                                                                                                                                        (cdr
                                                                                                                                                                                                         v_56)))
                                                                                                                                                                                            (let-values (((a_310)
                                                                                                                                                                                                          (car
                                                                                                                                                                                                           d_299)))
                                                                                                                                                                                              a_310))))
                                                                                                                                                                              (values
                                                                                                                                                                               idss_24
                                                                                                                                                                               rhss_65)))))
                                                                                                                                                              (values
                                                                                                                                                               (cons
                                                                                                                                                                idss21_0
                                                                                                                                                                idss_22)
                                                                                                                                                               (cons
                                                                                                                                                                rhss22_0
                                                                                                                                                                rhss_63))))))
                                                                                                                                              (values
                                                                                                                                               idss_23
                                                                                                                                               rhss_64)))))
                                                                                                                              (if (not
                                                                                                                                   #f)
                                                                                                                                (for-loop_37
                                                                                                                                 idss_21
                                                                                                                                 rhss_62
                                                                                                                                 rest_45)
                                                                                                                                (values
                                                                                                                                 idss_21
                                                                                                                                 rhss_62))))
                                                                                                                          (values
                                                                                                                           idss_20
                                                                                                                           rhss_61)))))
                                                                                                       for-loop_37)
                                                                                                     null
                                                                                                     null
                                                                                                     lst_82)))))
                                                                                    (values
                                                                                     (reverse$1 idss_19)
                                                                                     (reverse$1 rhss_60)))))
                                                                               ((bodys_19)
                                                                                (let-values (((d_300) (cdr d_298)))
                                                                                  d_300)))
                                                                    (values idss_18 rhss_59 bodys_19)))))
                                                    (left-to-right/let-values
                                                     (list*
                                                      'let-values
                                                      (let-values (((lst_84) idss_17) ((lst_85) rhss_58))
                                                        (begin
                                                          (check-list lst_84)
                                                          (check-list lst_85)
                                                          ((letrec-values (((for-loop_38)
                                                                            (lambda (lst_86 lst_87)
                                                                              (if (if (pair? lst_86) (pair? lst_87) #f)
                                                                                (let-values (((ids_37)
                                                                                              (unsafe-car lst_86))
                                                                                             ((rest_46)
                                                                                              (unsafe-cdr lst_86))
                                                                                             ((rhs_32)
                                                                                              (unsafe-car lst_87))
                                                                                             ((rest_47)
                                                                                              (unsafe-cdr lst_87)))
                                                                                  (let-values (((post-guard-var_8)
                                                                                                (lambda () #t)))
                                                                                    (let-values ()
                                                                                      (let-values (((elem_7)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (list
                                                                                                         ids_37
                                                                                                         (schemify_0
                                                                                                          rhs_32))))))
                                                                                        (let-values (((result_49)
                                                                                                      (if (post-guard-var_8)
                                                                                                        (for-loop_38
                                                                                                         rest_46
                                                                                                         rest_47)
                                                                                                        null)))
                                                                                          (cons elem_7 result_49))))))
                                                                                null))))
                                                             for-loop_38)
                                                           lst_84
                                                           lst_85)))
                                                      (map2 schemify_0 bodys_18))
                                                     mutated_7))
                                                  (if (if (pair? v_47)
                                                        (if (let-values (((a_311) (car v_47)))
                                                              (equal? 'letrec-values a_311))
                                                          (let-values (((d_301) (cdr v_47)))
                                                            (if (pair? d_301)
                                                              (if (let-values (((a_312) (car d_301)))
                                                                    (if (list? a_312)
                                                                      (let-values (((lst_88) a_312))
                                                                        (begin
                                                                          (check-list lst_88)
                                                                          ((letrec-values (((for-loop_39)
                                                                                            (lambda (result_50 lst_89)
                                                                                              (if (pair? lst_89)
                                                                                                (let-values (((v_57)
                                                                                                              (unsafe-car
                                                                                                               lst_89))
                                                                                                             ((rest_48)
                                                                                                              (unsafe-cdr
                                                                                                               lst_89)))
                                                                                                  (let-values (((result_51)
                                                                                                                (let-values ()
                                                                                                                  (let-values (((result_52)
                                                                                                                                (let-values ()
                                                                                                                                  (let-values ()
                                                                                                                                    (if (pair?
                                                                                                                                         v_57)
                                                                                                                                      (if (let-values (((a_313)
                                                                                                                                                        (car
                                                                                                                                                         v_57)))
                                                                                                                                            (if (pair?
                                                                                                                                                 a_313)
                                                                                                                                              (if (let-values (((a_314)
                                                                                                                                                                (car
                                                                                                                                                                 a_313)))
                                                                                                                                                    #t)
                                                                                                                                                (let-values (((d_302)
                                                                                                                                                              (cdr
                                                                                                                                                               a_313)))
                                                                                                                                                  (equal?
                                                                                                                                                   '()
                                                                                                                                                   d_302))
                                                                                                                                                #f)
                                                                                                                                              #f))
                                                                                                                                        (let-values (((d_303)
                                                                                                                                                      (cdr
                                                                                                                                                       v_57)))
                                                                                                                                          (if (pair?
                                                                                                                                               d_303)
                                                                                                                                            (if (let-values (((a_315)
                                                                                                                                                              (car
                                                                                                                                                               d_303)))
                                                                                                                                                  #t)
                                                                                                                                              (let-values (((d_304)
                                                                                                                                                            (cdr
                                                                                                                                                             d_303)))
                                                                                                                                                (equal?
                                                                                                                                                 '()
                                                                                                                                                 d_304))
                                                                                                                                              #f)
                                                                                                                                            #f))
                                                                                                                                        #f)
                                                                                                                                      #f)))))
                                                                                                                    (values
                                                                                                                     result_52)))))
                                                                                                    (if (if (not
                                                                                                             ((lambda x_14
                                                                                                                (not
                                                                                                                 result_51))
                                                                                                              v_57))
                                                                                                          (not #f)
                                                                                                          #f)
                                                                                                      (for-loop_39
                                                                                                       result_51
                                                                                                       rest_48)
                                                                                                      result_51)))
                                                                                                result_50))))
                                                                             for-loop_39)
                                                                           #t
                                                                           lst_88)))
                                                                      #f))
                                                                (let-values (((d_305) (cdr d_301))) (list? d_305))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f)
                                                    (let-values (((ids_38 rhss_66 bodys_20)
                                                                  (let-values (((d_306) (cdr v_47)))
                                                                    (let-values (((ids_39 rhss_67)
                                                                                  (let-values (((a_316) (car d_306)))
                                                                                    (let-values (((ids_40 rhss_68)
                                                                                                  (let-values (((lst_90)
                                                                                                                a_316))
                                                                                                    (begin
                                                                                                      (check-list
                                                                                                       lst_90)
                                                                                                      ((letrec-values (((for-loop_40)
                                                                                                                        (lambda (ids_41
                                                                                                                                 rhss_69
                                                                                                                                 lst_91)
                                                                                                                          (if (pair?
                                                                                                                               lst_91)
                                                                                                                            (let-values (((v_58)
                                                                                                                                          (unsafe-car
                                                                                                                                           lst_91))
                                                                                                                                         ((rest_49)
                                                                                                                                          (unsafe-cdr
                                                                                                                                           lst_91)))
                                                                                                                              (let-values (((ids_42
                                                                                                                                             rhss_70)
                                                                                                                                            (let-values (((ids_43)
                                                                                                                                                          ids_41)
                                                                                                                                                         ((rhss_71)
                                                                                                                                                          rhss_69))
                                                                                                                                              (let-values (((ids_44
                                                                                                                                                             rhss_72)
                                                                                                                                                            (let-values ()
                                                                                                                                                              (let-values (((ids23_0
                                                                                                                                                                             rhss24_0)
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (let-values (((ids_45)
                                                                                                                                                                                            (let-values (((a_317)
                                                                                                                                                                                                          (car
                                                                                                                                                                                                           v_58)))
                                                                                                                                                                                              (let-values (((a_318)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             a_317)))
                                                                                                                                                                                                a_318)))
                                                                                                                                                                                           ((rhss_73)
                                                                                                                                                                                            (let-values (((d_307)
                                                                                                                                                                                                          (cdr
                                                                                                                                                                                                           v_58)))
                                                                                                                                                                                              (let-values (((a_319)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             d_307)))
                                                                                                                                                                                                a_319))))
                                                                                                                                                                                (values
                                                                                                                                                                                 ids_45
                                                                                                                                                                                 rhss_73)))))
                                                                                                                                                                (values
                                                                                                                                                                 (cons
                                                                                                                                                                  ids23_0
                                                                                                                                                                  ids_43)
                                                                                                                                                                 (cons
                                                                                                                                                                  rhss24_0
                                                                                                                                                                  rhss_71))))))
                                                                                                                                                (values
                                                                                                                                                 ids_44
                                                                                                                                                 rhss_72)))))
                                                                                                                                (if (not
                                                                                                                                     #f)
                                                                                                                                  (for-loop_40
                                                                                                                                   ids_42
                                                                                                                                   rhss_70
                                                                                                                                   rest_49)
                                                                                                                                  (values
                                                                                                                                   ids_42
                                                                                                                                   rhss_70))))
                                                                                                                            (values
                                                                                                                             ids_41
                                                                                                                             rhss_69)))))
                                                                                                         for-loop_40)
                                                                                                       null
                                                                                                       null
                                                                                                       lst_90)))))
                                                                                      (values
                                                                                       (reverse$1 ids_40)
                                                                                       (reverse$1 rhss_68)))))
                                                                                 ((bodys_21)
                                                                                  (let-values (((d_308) (cdr d_306)))
                                                                                    d_308)))
                                                                      (values ids_39 rhss_67 bodys_21)))))
                                                      (let-values (((new-knowns_2)
                                                                    (let-values (((lst_92) ids_38) ((lst_93) rhss_66))
                                                                      (begin
                                                                        (check-list lst_92)
                                                                        (check-list lst_93)
                                                                        ((letrec-values (((for-loop_41)
                                                                                          (lambda (knowns_26
                                                                                                   lst_94
                                                                                                   lst_95)
                                                                                            (if (if (pair? lst_94)
                                                                                                  (pair? lst_95)
                                                                                                  #f)
                                                                                              (let-values (((id_15)
                                                                                                            (unsafe-car
                                                                                                             lst_94))
                                                                                                           ((rest_50)
                                                                                                            (unsafe-cdr
                                                                                                             lst_94))
                                                                                                           ((rhs_33)
                                                                                                            (unsafe-car
                                                                                                             lst_95))
                                                                                                           ((rest_51)
                                                                                                            (unsafe-cdr
                                                                                                             lst_95)))
                                                                                                (let-values (((knowns_27)
                                                                                                              (let-values (((knowns_28)
                                                                                                                            knowns_26))
                                                                                                                (let-values (((knowns_29)
                                                                                                                              (let-values ()
                                                                                                                                (if (lambda?
                                                                                                                                     rhs_33)
                                                                                                                                  (hash-set
                                                                                                                                   knowns_28
                                                                                                                                   id_15
                                                                                                                                   a-known-procedure)
                                                                                                                                  knowns_28))))
                                                                                                                  (values
                                                                                                                   knowns_29)))))
                                                                                                  (if (not #f)
                                                                                                    (for-loop_41
                                                                                                     knowns_27
                                                                                                     rest_50
                                                                                                     rest_51)
                                                                                                    knowns_27)))
                                                                                              knowns_26))))
                                                                           for-loop_41)
                                                                         knowns_21
                                                                         lst_92
                                                                         lst_93)))))
                                                        (let-values (((schemify_1)
                                                                      (make-schemify
                                                                       prim-knowns_7
                                                                       new-knowns_2
                                                                       mutated_7
                                                                       imports_17
                                                                       exports_8)))
                                                          (list*
                                                           'letrec*
                                                           (let-values (((lst_96) ids_38) ((lst_97) rhss_66))
                                                             (begin
                                                               (check-list lst_96)
                                                               (check-list lst_97)
                                                               ((letrec-values (((for-loop_42)
                                                                                 (lambda (lst_98 lst_99)
                                                                                   (if (if (pair? lst_98)
                                                                                         (pair? lst_99)
                                                                                         #f)
                                                                                     (let-values (((id_16)
                                                                                                   (unsafe-car lst_98))
                                                                                                  ((rest_52)
                                                                                                   (unsafe-cdr lst_98))
                                                                                                  ((rhs_34)
                                                                                                   (unsafe-car lst_99))
                                                                                                  ((rest_53)
                                                                                                   (unsafe-cdr lst_99)))
                                                                                       (let-values (((post-guard-var_9)
                                                                                                     (lambda () #t)))
                                                                                         (let-values ()
                                                                                           (let-values (((elem_8)
                                                                                                         (let-values ()
                                                                                                           (let-values ()
                                                                                                             (list
                                                                                                              id_16
                                                                                                              (schemify_1
                                                                                                               rhs_34))))))
                                                                                             (let-values (((result_53)
                                                                                                           (if (post-guard-var_9)
                                                                                                             (for-loop_42
                                                                                                              rest_52
                                                                                                              rest_53)
                                                                                                             null)))
                                                                                               (cons
                                                                                                elem_8
                                                                                                result_53))))))
                                                                                     null))))
                                                                  for-loop_42)
                                                                lst_96
                                                                lst_97)))
                                                           (map2 schemify_1 bodys_20)))))
                                                    (if (if (pair? v_47)
                                                          (if (let-values (((a_320) (car v_47)))
                                                                (equal? 'letrec-values a_320))
                                                            (let-values (((d_309) (cdr v_47)))
                                                              (if (pair? d_309)
                                                                (if (let-values (((a_321) (car d_309)))
                                                                      (if (list? a_321)
                                                                        (let-values (((lst_100) a_321))
                                                                          (begin
                                                                            (check-list lst_100)
                                                                            ((letrec-values (((for-loop_43)
                                                                                              (lambda (result_54
                                                                                                       lst_101)
                                                                                                (if (pair? lst_101)
                                                                                                  (let-values (((v_59)
                                                                                                                (unsafe-car
                                                                                                                 lst_101))
                                                                                                               ((rest_54)
                                                                                                                (unsafe-cdr
                                                                                                                 lst_101)))
                                                                                                    (let-values (((result_55)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((result_56)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values ()
                                                                                                                                      (if (pair?
                                                                                                                                           v_59)
                                                                                                                                        (if (let-values (((a_322)
                                                                                                                                                          (car
                                                                                                                                                           v_59)))
                                                                                                                                              (list?
                                                                                                                                               a_322))
                                                                                                                                          (let-values (((d_310)
                                                                                                                                                        (cdr
                                                                                                                                                         v_59)))
                                                                                                                                            (if (pair?
                                                                                                                                                 d_310)
                                                                                                                                              (if (let-values (((a_323)
                                                                                                                                                                (car
                                                                                                                                                                 d_310)))
                                                                                                                                                    #t)
                                                                                                                                                (let-values (((d_311)
                                                                                                                                                              (cdr
                                                                                                                                                               d_310)))
                                                                                                                                                  (equal?
                                                                                                                                                   '()
                                                                                                                                                   d_311))
                                                                                                                                                #f)
                                                                                                                                              #f))
                                                                                                                                          #f)
                                                                                                                                        #f)))))
                                                                                                                      (values
                                                                                                                       result_56)))))
                                                                                                      (if (if (not
                                                                                                               ((lambda x_15
                                                                                                                  (not
                                                                                                                   result_55))
                                                                                                                v_59))
                                                                                                            (not #f)
                                                                                                            #f)
                                                                                                        (for-loop_43
                                                                                                         result_55
                                                                                                         rest_54)
                                                                                                        result_55)))
                                                                                                  result_54))))
                                                                               for-loop_43)
                                                                             #t
                                                                             lst_100)))
                                                                        #f))
                                                                  (let-values (((d_312) (cdr d_309))) (list? d_312))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f)
                                                      (let-values (((idss_25 rhss_74 bodys_22)
                                                                    (let-values (((d_313) (cdr v_47)))
                                                                      (let-values (((idss_26 rhss_75)
                                                                                    (let-values (((a_324) (car d_313)))
                                                                                      (let-values (((idss_27 rhss_76)
                                                                                                    (let-values (((lst_102)
                                                                                                                  a_324))
                                                                                                      (begin
                                                                                                        (check-list
                                                                                                         lst_102)
                                                                                                        ((letrec-values (((for-loop_44)
                                                                                                                          (lambda (idss_28
                                                                                                                                   rhss_77
                                                                                                                                   lst_103)
                                                                                                                            (if (pair?
                                                                                                                                 lst_103)
                                                                                                                              (let-values (((v_60)
                                                                                                                                            (unsafe-car
                                                                                                                                             lst_103))
                                                                                                                                           ((rest_55)
                                                                                                                                            (unsafe-cdr
                                                                                                                                             lst_103)))
                                                                                                                                (let-values (((idss_29
                                                                                                                                               rhss_78)
                                                                                                                                              (let-values (((idss_30)
                                                                                                                                                            idss_28)
                                                                                                                                                           ((rhss_79)
                                                                                                                                                            rhss_77))
                                                                                                                                                (let-values (((idss_31
                                                                                                                                                               rhss_80)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((idss25_0
                                                                                                                                                                               rhss26_0)
                                                                                                                                                                              (let-values ()
                                                                                                                                                                                (let-values (((idss_32)
                                                                                                                                                                                              (let-values (((a_325)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             v_60)))
                                                                                                                                                                                                a_325))
                                                                                                                                                                                             ((rhss_81)
                                                                                                                                                                                              (let-values (((d_314)
                                                                                                                                                                                                            (cdr
                                                                                                                                                                                                             v_60)))
                                                                                                                                                                                                (let-values (((a_326)
                                                                                                                                                                                                              (car
                                                                                                                                                                                                               d_314)))
                                                                                                                                                                                                  a_326))))
                                                                                                                                                                                  (values
                                                                                                                                                                                   idss_32
                                                                                                                                                                                   rhss_81)))))
                                                                                                                                                                  (values
                                                                                                                                                                   (cons
                                                                                                                                                                    idss25_0
                                                                                                                                                                    idss_30)
                                                                                                                                                                   (cons
                                                                                                                                                                    rhss26_0
                                                                                                                                                                    rhss_79))))))
                                                                                                                                                  (values
                                                                                                                                                   idss_31
                                                                                                                                                   rhss_80)))))
                                                                                                                                  (if (not
                                                                                                                                       #f)
                                                                                                                                    (for-loop_44
                                                                                                                                     idss_29
                                                                                                                                     rhss_78
                                                                                                                                     rest_55)
                                                                                                                                    (values
                                                                                                                                     idss_29
                                                                                                                                     rhss_78))))
                                                                                                                              (values
                                                                                                                               idss_28
                                                                                                                               rhss_77)))))
                                                                                                           for-loop_44)
                                                                                                         null
                                                                                                         null
                                                                                                         lst_102)))))
                                                                                        (values
                                                                                         (reverse$1 idss_27)
                                                                                         (reverse$1 rhss_76)))))
                                                                                   ((bodys_23)
                                                                                    (let-values (((d_315) (cdr d_313)))
                                                                                      d_315)))
                                                                        (values idss_26 rhss_75 bodys_23)))))
                                                        (list*
                                                         'letrec*
                                                         (apply
                                                          append
                                                          (let-values (((lst_104) idss_25) ((lst_105) rhss_74))
                                                            (begin
                                                              (check-list lst_104)
                                                              (check-list lst_105)
                                                              ((letrec-values (((for-loop_45)
                                                                                (lambda (lst_106 lst_107)
                                                                                  (if (if (pair? lst_106)
                                                                                        (pair? lst_107)
                                                                                        #f)
                                                                                    (let-values (((ids_46)
                                                                                                  (unsafe-car lst_106))
                                                                                                 ((rest_56)
                                                                                                  (unsafe-cdr lst_106))
                                                                                                 ((rhs_35)
                                                                                                  (unsafe-car lst_107))
                                                                                                 ((rest_57)
                                                                                                  (unsafe-cdr lst_107)))
                                                                                      (let-values (((post-guard-var_10)
                                                                                                    (lambda () #t)))
                                                                                        (let-values ()
                                                                                          (let-values (((elem_9)
                                                                                                        (let-values ()
                                                                                                          (let-values ()
                                                                                                            (let-values (((rhs_36)
                                                                                                                          (schemify_0
                                                                                                                           rhs_35)))
                                                                                                              (if (null?
                                                                                                                   ids_46)
                                                                                                                (let-values ()
                                                                                                                  (list
                                                                                                                   (list
                                                                                                                    (gensym
                                                                                                                     "lr")
                                                                                                                    (make-let-values
                                                                                                                     null
                                                                                                                     rhs_36
                                                                                                                     '(void)))))
                                                                                                                (if (if (pair?
                                                                                                                         ids_46)
                                                                                                                      (null?
                                                                                                                       (cdr
                                                                                                                        ids_46))
                                                                                                                      #f)
                                                                                                                  (let-values ()
                                                                                                                    (list
                                                                                                                     (list
                                                                                                                      ids_46
                                                                                                                      rhs_36)))
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((lr_0)
                                                                                                                                  (gensym
                                                                                                                                   "lr")))
                                                                                                                      (list*
                                                                                                                       (list
                                                                                                                        lr_0
                                                                                                                        (make-let-values
                                                                                                                         ids_46
                                                                                                                         rhs_36
                                                                                                                         (list*
                                                                                                                          'vector
                                                                                                                          ids_46)))
                                                                                                                       (let-values (((lst_108)
                                                                                                                                     ids_46)
                                                                                                                                    ((start_2)
                                                                                                                                     0))
                                                                                                                         (begin
                                                                                                                           (check-list
                                                                                                                            lst_108)
                                                                                                                           (check-naturals
                                                                                                                            start_2)
                                                                                                                           ((letrec-values (((for-loop_46)
                                                                                                                                             (lambda (lst_109
                                                                                                                                                      pos_4)
                                                                                                                                               (if (if (pair?
                                                                                                                                                        lst_109)
                                                                                                                                                     #t
                                                                                                                                                     #f)
                                                                                                                                                 (let-values (((id_17)
                                                                                                                                                               (unsafe-car
                                                                                                                                                                lst_109))
                                                                                                                                                              ((rest_58)
                                                                                                                                                               (unsafe-cdr
                                                                                                                                                                lst_109))
                                                                                                                                                              ((pos_5)
                                                                                                                                                               pos_4))
                                                                                                                                                   (let-values (((post-guard-var_11)
                                                                                                                                                                 (lambda ()
                                                                                                                                                                   #t)))
                                                                                                                                                     (let-values ()
                                                                                                                                                       (let-values (((elem_10)
                                                                                                                                                                     (let-values ()
                                                                                                                                                                       (let-values ()
                                                                                                                                                                         (list
                                                                                                                                                                          id_17
                                                                                                                                                                          (list
                                                                                                                                                                           'vector-ref
                                                                                                                                                                           lr_0
                                                                                                                                                                           pos_5))))))
                                                                                                                                                         (let-values (((result_57)
                                                                                                                                                                       (if (post-guard-var_11)
                                                                                                                                                                         (for-loop_46
                                                                                                                                                                          rest_58
                                                                                                                                                                          (+
                                                                                                                                                                           pos_4
                                                                                                                                                                           1))
                                                                                                                                                                         null)))
                                                                                                                                                           (cons
                                                                                                                                                            elem_10
                                                                                                                                                            result_57))))))
                                                                                                                                                 null))))
                                                                                                                              for-loop_46)
                                                                                                                            lst_108
                                                                                                                            start_2)))))))))))))
                                                                                            (let-values (((result_58)
                                                                                                          (if (post-guard-var_10)
                                                                                                            (for-loop_45
                                                                                                             rest_56
                                                                                                             rest_57)
                                                                                                            null)))
                                                                                              (cons
                                                                                               elem_9
                                                                                               result_58))))))
                                                                                    null))))
                                                                 for-loop_45)
                                                               lst_104
                                                               lst_105))))
                                                         (map2 schemify_0 bodys_22)))
                                                      (if (if (pair? v_47)
                                                            (if (let-values (((a_327) (car v_47))) (equal? 'if a_327))
                                                              (let-values (((d_316) (cdr v_47)))
                                                                (if (pair? d_316)
                                                                  (if (let-values (((a_328) (car d_316))) #t)
                                                                    (let-values (((d_317) (cdr d_316)))
                                                                      (if (pair? d_317)
                                                                        (if (let-values (((a_329) (car d_317))) #t)
                                                                          (let-values (((d_318) (cdr d_317)))
                                                                            (if (pair? d_318)
                                                                              (if (let-values (((a_330) (car d_318)))
                                                                                    #t)
                                                                                (let-values (((d_319) (cdr d_318)))
                                                                                  (equal? '() d_319))
                                                                                #f)
                                                                              #f))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f)
                                                        (let-values (((tst_0 thn_0 els_0)
                                                                      (let-values (((d_320) (cdr v_47)))
                                                                        (let-values (((tst_1)
                                                                                      (let-values (((a_331)
                                                                                                    (car d_320)))
                                                                                        a_331))
                                                                                     ((thn_1 els_1)
                                                                                      (let-values (((d_321)
                                                                                                    (cdr d_320)))
                                                                                        (let-values (((thn_2)
                                                                                                      (let-values (((a_332)
                                                                                                                    (car
                                                                                                                     d_321)))
                                                                                                        a_332))
                                                                                                     ((els_2)
                                                                                                      (let-values (((d_322)
                                                                                                                    (cdr
                                                                                                                     d_321)))
                                                                                                        (let-values (((a_333)
                                                                                                                      (car
                                                                                                                       d_322)))
                                                                                                          a_333))))
                                                                                          (values thn_2 els_2)))))
                                                                          (values tst_1 thn_1 els_1)))))
                                                          (list
                                                           'if
                                                           (schemify_0 tst_0)
                                                           (schemify_0 thn_0)
                                                           (schemify_0 els_0)))
                                                        (if (if (pair? v_47)
                                                              (if (let-values (((a_334) (car v_47)))
                                                                    (equal? 'with-continuation-mark a_334))
                                                                (let-values (((d_323) (cdr v_47)))
                                                                  (if (pair? d_323)
                                                                    (if (let-values (((a_335) (car d_323))) #t)
                                                                      (let-values (((d_324) (cdr d_323)))
                                                                        (if (pair? d_324)
                                                                          (if (let-values (((a_336) (car d_324))) #t)
                                                                            (let-values (((d_325) (cdr d_324)))
                                                                              (if (pair? d_325)
                                                                                (if (let-values (((a_337) (car d_325)))
                                                                                      #t)
                                                                                  (let-values (((d_326) (cdr d_325)))
                                                                                    (equal? '() d_326))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                      #f)
                                                                    #f))
                                                                #f)
                                                              #f)
                                                          (let-values (((key_1 val_0 body_18)
                                                                        (let-values (((d_327) (cdr v_47)))
                                                                          (let-values (((key_2)
                                                                                        (let-values (((a_338)
                                                                                                      (car d_327)))
                                                                                          a_338))
                                                                                       ((val_1 body_19)
                                                                                        (let-values (((d_328)
                                                                                                      (cdr d_327)))
                                                                                          (let-values (((val_2)
                                                                                                        (let-values (((a_339)
                                                                                                                      (car
                                                                                                                       d_328)))
                                                                                                          a_339))
                                                                                                       ((body_20)
                                                                                                        (let-values (((d_329)
                                                                                                                      (cdr
                                                                                                                       d_328)))
                                                                                                          (let-values (((a_340)
                                                                                                                        (car
                                                                                                                         d_329)))
                                                                                                            a_340))))
                                                                                            (values val_2 body_20)))))
                                                                            (values key_2 val_1 body_19)))))
                                                            (list
                                                             'with-continuation-mark
                                                             (schemify_0 key_1)
                                                             (schemify_0 val_0)
                                                             (schemify_0 body_18)))
                                                          (if (if (pair? v_47)
                                                                (if (let-values (((a_341) (car v_47)))
                                                                      (equal? 'begin a_341))
                                                                  (let-values (((d_330) (cdr v_47))) (list? d_330))
                                                                  #f)
                                                                #f)
                                                            (let-values (((exps_0)
                                                                          (let-values (((d_331) (cdr v_47))) d_331)))
                                                              (list* 'begin (map2 schemify_0 exps_0)))
                                                            (if (if (pair? v_47)
                                                                  (if (let-values (((a_342) (car v_47)))
                                                                        (equal? 'begin0 a_342))
                                                                    (let-values (((d_332) (cdr v_47))) (list? d_332))
                                                                    #f)
                                                                  #f)
                                                              (let-values (((exps_1)
                                                                            (let-values (((d_333) (cdr v_47))) d_333)))
                                                                (list* 'begin0 (map2 schemify_0 exps_1)))
                                                              (if (if (pair? v_47)
                                                                    (if (let-values (((a_343) (car v_47)))
                                                                          (equal? 'set! a_343))
                                                                      (let-values (((d_334) (cdr v_47)))
                                                                        (if (pair? d_334)
                                                                          (if (let-values (((a_344) (car d_334))) #t)
                                                                            (let-values (((d_335) (cdr d_334)))
                                                                              (if (pair? d_335)
                                                                                (if (let-values (((a_345) (car d_335)))
                                                                                      #t)
                                                                                  (let-values (((d_336) (cdr d_335)))
                                                                                    (equal? '() d_336))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                      #f)
                                                                    #f)
                                                                (let-values (((id_18 rhs_37)
                                                                              (let-values (((d_337) (cdr v_47)))
                                                                                (let-values (((id_19)
                                                                                              (let-values (((a_346)
                                                                                                            (car
                                                                                                             d_337)))
                                                                                                a_346))
                                                                                             ((rhs_38)
                                                                                              (let-values (((d_338)
                                                                                                            (cdr
                                                                                                             d_337)))
                                                                                                (let-values (((a_347)
                                                                                                              (car
                                                                                                               d_338)))
                                                                                                  a_347))))
                                                                                  (values id_19 rhs_38)))))
                                                                  (let-values (((ex-id_0)
                                                                                (hash-ref exports_8 id_18 #f)))
                                                                    (if ex-id_0
                                                                      (list 'variable-set! ex-id_0 (schemify_0 rhs_37))
                                                                      (list 'set! id_18 (schemify_0 rhs_37)))))
                                                                (if (if (pair? v_47)
                                                                      (if (let-values (((a_348) (car v_47)))
                                                                            (equal?
                                                                             'variable-reference-constant?
                                                                             a_348))
                                                                        (let-values (((d_339) (cdr v_47)))
                                                                          (if (pair? d_339)
                                                                            (if (let-values (((a_349) (car d_339)))
                                                                                  (if (pair? a_349)
                                                                                    (if (let-values (((a_350)
                                                                                                      (car a_349)))
                                                                                          (equal?
                                                                                           '#%variable-reference
                                                                                           a_350))
                                                                                      (let-values (((d_340)
                                                                                                    (cdr a_349)))
                                                                                        (if (pair? d_340)
                                                                                          (if (let-values (((a_351)
                                                                                                            (car
                                                                                                             d_340)))
                                                                                                #t)
                                                                                            (let-values (((d_341)
                                                                                                          (cdr d_340)))
                                                                                              (equal? '() d_341))
                                                                                            #f)
                                                                                          #f))
                                                                                      #f)
                                                                                    #f))
                                                                              (let-values (((d_342) (cdr d_339)))
                                                                                (equal? '() d_342))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f)
                                                                  (let-values (((id_20)
                                                                                (let-values (((d_343) (cdr v_47)))
                                                                                  (let-values (((a_352) (car d_343)))
                                                                                    (let-values (((d_344) (cdr a_352)))
                                                                                      (let-values (((a_353)
                                                                                                    (car d_344)))
                                                                                        a_353))))))
                                                                    (if (not (hash-ref mutated_7 id_20 #f))
                                                                      (let-values (((im_3)
                                                                                    (hash-ref imports_17 id_20 #f)))
                                                                        (let-values (((or-part_11) (not im_3)))
                                                                          (if or-part_11
                                                                            or-part_11
                                                                            (known-constant?
                                                                             (hash-ref
                                                                              (import-group-knowns (import-grp im_3))
                                                                              (import-ext-id im_3)
                                                                              #f)))))
                                                                      #f))
                                                                  (if (if (pair? v_47)
                                                                        (if (let-values (((a_354) (car v_47)))
                                                                              (equal? '#%variable-reference a_354))
                                                                          (let-values (((d_345) (cdr v_47)))
                                                                            (equal? '() d_345))
                                                                          #f)
                                                                        #f)
                                                                    (let-values () 'instance-variable-reference)
                                                                    (if (if (pair? v_47)
                                                                          (if (let-values (((a_355) (car v_47)))
                                                                                (equal? '#%variable-reference a_355))
                                                                            (let-values (((d_346) (cdr v_47)))
                                                                              (if (pair? d_346)
                                                                                (if (let-values (((a_356) (car d_346)))
                                                                                      #t)
                                                                                  (let-values (((d_347) (cdr d_346)))
                                                                                    (equal? '() d_347))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f)
                                                                      (let-values (((id_21)
                                                                                    (let-values (((d_348) (cdr v_47)))
                                                                                      (let-values (((a_357)
                                                                                                    (car d_348)))
                                                                                        a_357))))
                                                                        (let-values (((e_2)
                                                                                      (hash-ref exports_8 id_21 #f)))
                                                                          (if e_2
                                                                            (list
                                                                             'make-instance-variable-reference
                                                                             'instance-variable-reference
                                                                             e_2)
                                                                            (list
                                                                             'make-instance-variable-reference
                                                                             'instance-variable-reference
                                                                             (if (hash-ref mutated_7 v_46 #f)
                                                                               'mutable
                                                                               'immutable)))))
                                                                      (if (if (pair? v_47)
                                                                            (if (let-values (((a_358) (car v_47))) #t)
                                                                              (let-values (((d_349) (cdr v_47)))
                                                                                (list? d_349))
                                                                              #f)
                                                                            #f)
                                                                        (let-values (((rator_0 exps_2)
                                                                                      (let-values (((rator_1)
                                                                                                    (let-values (((a_359)
                                                                                                                  (car
                                                                                                                   v_47)))
                                                                                                      a_359))
                                                                                                   ((exps_3)
                                                                                                    (let-values (((d_350)
                                                                                                                  (cdr
                                                                                                                   v_47)))
                                                                                                      d_350)))
                                                                                        (values rator_1 exps_3))))
                                                                          (let-values (((args_4)
                                                                                        (map2 schemify_0 exps_2)))
                                                                            (left-to-right/app
                                                                             (if (let-values (((or-part_12)
                                                                                               (known-procedure?
                                                                                                (hash-ref-either
                                                                                                 knowns_21
                                                                                                 imports_17
                                                                                                 rator_0))))
                                                                                   (if or-part_12
                                                                                     or-part_12
                                                                                     (let-values (((or-part_13)
                                                                                                   (known-procedure?
                                                                                                    (hash-ref
                                                                                                     prim-knowns_7
                                                                                                     rator_0
                                                                                                     #f))))
                                                                                       (if or-part_13
                                                                                         or-part_13
                                                                                         (lambda? rator_0)))))
                                                                               (list* (schemify_0 rator_0) args_4)
                                                                               (list*
                                                                                '#%app
                                                                                (schemify_0 rator_0)
                                                                                args_4))
                                                                             prim-knowns_7
                                                                             knowns_21
                                                                             imports_17
                                                                             mutated_7)))
                                                                        (let-values ()
                                                                          (let-values (((c1_0)
                                                                                        (if (symbol? v_46)
                                                                                          (if (hash-ref
                                                                                               mutated_7
                                                                                               v_46
                                                                                               #f)
                                                                                            (hash-ref exports_8 v_46 #f)
                                                                                            #f)
                                                                                          #f)))
                                                                            (if c1_0
                                                                              ((lambda (ex-id_1)
                                                                                 (list 'variable-ref ex-id_1))
                                                                               c1_0)
                                                                              (let-values (((c2_0)
                                                                                            (if (symbol? v_46)
                                                                                              (hash-ref
                                                                                               imports_17
                                                                                               v_46
                                                                                               #f)
                                                                                              #f)))
                                                                                (if c2_0
                                                                                  ((lambda (im_4)
                                                                                     (list
                                                                                      'variable-ref
                                                                                      (import-id im_4)))
                                                                                   c2_0)
                                                                                  (let-values ()
                                                                                    v_46))))))))))))))))))))))))))))))))
         schemify_0)
       v_45))))
 (define-values
  (mutated-in-body)
  (lambda (l_13 exports_9 prim-knowns_8 knowns_30 imports_18)
    (let-values (((mutated_8) (make-hasheq)))
      (begin
        (let-values (((ht_2) exports_9))
          (begin
            (check-in-hash-keys ht_2)
            ((letrec-values (((for-loop_47)
                              (lambda (i_7)
                                (if i_7
                                  (let-values (((id_22) (hash-iterate-key ht_2 i_7)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (hash-set! mutated_8 id_22 'not-ready))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_47 (hash-iterate-next ht_2 i_7)) (values))))
                                  (values)))))
               for-loop_47)
             (hash-iterate-first ht_2))))
        (void)
        (let-values (((lst_110) l_13))
          (begin
            (check-list lst_110)
            ((letrec-values (((for-loop_48)
                              (lambda (lst_111)
                                (if (pair? lst_111)
                                  (let-values (((form_1) (unsafe-car lst_111)) ((rest_59) (unsafe-cdr lst_111)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (let-values (((v_61) form_1))
                                                                          (if (if (pair? v_61)
                                                                                (if (let-values (((a_360) (car v_61)))
                                                                                      (equal? 'define-values a_360))
                                                                                  (let-values (((d_351) (cdr v_61)))
                                                                                    (if (pair? d_351)
                                                                                      (if (let-values (((a_361)
                                                                                                        (car d_351)))
                                                                                            #t)
                                                                                        (let-values (((d_352)
                                                                                                      (cdr d_351)))
                                                                                          (if (pair? d_352)
                                                                                            (if (let-values (((a_362)
                                                                                                              (car
                                                                                                               d_352)))
                                                                                                  #t)
                                                                                              (let-values (((d_353)
                                                                                                            (cdr
                                                                                                             d_352)))
                                                                                                (equal? '() d_353))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_47 rhs_39)
                                                                                          (let-values (((d_354)
                                                                                                        (cdr v_61)))
                                                                                            (let-values (((ids_48)
                                                                                                          (let-values (((a_363)
                                                                                                                        (car
                                                                                                                         d_354)))
                                                                                                            a_363))
                                                                                                         ((rhs_40)
                                                                                                          (let-values (((d_355)
                                                                                                                        (cdr
                                                                                                                         d_354)))
                                                                                                            (let-values (((a_364)
                                                                                                                          (car
                                                                                                                           d_355)))
                                                                                                              a_364))))
                                                                                              (values ids_48 rhs_40)))))
                                                                              (begin
                                                                                (let-values (((lst_112) ids_47))
                                                                                  (begin
                                                                                    (check-list lst_112)
                                                                                    ((letrec-values (((for-loop_49)
                                                                                                      (lambda (lst_113)
                                                                                                        (if (pair?
                                                                                                             lst_113)
                                                                                                          (let-values (((id_23)
                                                                                                                        (unsafe-car
                                                                                                                         lst_113))
                                                                                                                       ((rest_60)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_113)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (hash-set!
                                                                                                                                                 mutated_8
                                                                                                                                                 id_23
                                                                                                                                                 'not-ready))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_49
                                                                                                                 rest_60)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_49)
                                                                                     lst_112)))
                                                                                (void)))
                                                                            (let-values () (void)))))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_48 rest_59) (values))))
                                  (values)))))
               for-loop_48)
             lst_110)))
        (void)
        (let-values (((lst_114) l_13))
          (begin
            (check-list lst_114)
            ((letrec-values (((for-loop_50)
                              (lambda (prev-knowns_0 lst_115)
                                (if (pair? lst_115)
                                  (let-values (((form_2) (unsafe-car lst_115)) ((rest_61) (unsafe-cdr lst_115)))
                                    (let-values (((prev-knowns_1)
                                                  (let-values (((prev-knowns_2) prev-knowns_0))
                                                    (let-values (((prev-knowns_3)
                                                                  (let-values ()
                                                                    (let-values (((knowns_31)
                                                                                  (find-definitions
                                                                                   form_2
                                                                                   prim-knowns_8
                                                                                   prev-knowns_2
                                                                                   imports_18
                                                                                   mutated_8)))
                                                                      (begin
                                                                        (let-values (((v_62) form_2))
                                                                          (if (if (pair? v_62)
                                                                                (if (let-values (((a_365) (car v_62)))
                                                                                      (equal? 'define-values a_365))
                                                                                  (let-values (((d_356) (cdr v_62)))
                                                                                    (if (pair? d_356)
                                                                                      (if (let-values (((a_366)
                                                                                                        (car d_356)))
                                                                                            #t)
                                                                                        (let-values (((d_357)
                                                                                                      (cdr d_356)))
                                                                                          (if (pair? d_357)
                                                                                            (if (let-values (((a_367)
                                                                                                              (car
                                                                                                               d_357)))
                                                                                                  #t)
                                                                                              (let-values (((d_358)
                                                                                                            (cdr
                                                                                                             d_357)))
                                                                                                (equal? '() d_358))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_49 rhs_41)
                                                                                          (let-values (((d_359)
                                                                                                        (cdr v_62)))
                                                                                            (let-values (((ids_50)
                                                                                                          (let-values (((a_368)
                                                                                                                        (car
                                                                                                                         d_359)))
                                                                                                            a_368))
                                                                                                         ((rhs_42)
                                                                                                          (let-values (((d_360)
                                                                                                                        (cdr
                                                                                                                         d_359)))
                                                                                                            (let-values (((a_369)
                                                                                                                          (car
                                                                                                                           d_360)))
                                                                                                              a_369))))
                                                                                              (values ids_50 rhs_42)))))
                                                                              (begin
                                                                                (find-mutated!
                                                                                 rhs_41
                                                                                 ids_49
                                                                                 prim-knowns_8
                                                                                 knowns_31
                                                                                 imports_18
                                                                                 mutated_8)
                                                                                (let-values (((lst_116) ids_49))
                                                                                  (begin
                                                                                    (check-list lst_116)
                                                                                    ((letrec-values (((for-loop_51)
                                                                                                      (lambda (lst_117)
                                                                                                        (if (pair?
                                                                                                             lst_117)
                                                                                                          (let-values (((id_24)
                                                                                                                        (unsafe-car
                                                                                                                         lst_117))
                                                                                                                       ((rest_62)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_117)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (if (eq?
                                                                                                                                                     'not-ready
                                                                                                                                                     (hash-ref
                                                                                                                                                      mutated_8
                                                                                                                                                      id_24
                                                                                                                                                      #f))
                                                                                                                                                  (let-values ()
                                                                                                                                                    (hash-remove!
                                                                                                                                                     mutated_8
                                                                                                                                                     id_24))
                                                                                                                                                  (void)))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_51
                                                                                                                 rest_62)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_51)
                                                                                     lst_116)))
                                                                                (void)))
                                                                            (let-values ()
                                                                              (find-mutated!
                                                                               form_2
                                                                               #f
                                                                               prim-knowns_8
                                                                               knowns_31
                                                                               imports_18
                                                                               mutated_8))))
                                                                        knowns_31)))))
                                                      (values prev-knowns_3)))))
                                      (if (not #f) (for-loop_50 prev-knowns_1 rest_61) prev-knowns_1)))
                                  prev-knowns_0))))
               for-loop_50)
             knowns_30
             lst_114)))
        (let-values (((lst_118) l_13))
          (begin
            (check-list lst_118)
            ((letrec-values (((for-loop_52)
                              (lambda (lst_119)
                                (if (pair? lst_119)
                                  (let-values (((form_3) (unsafe-car lst_119)) ((rest_63) (unsafe-cdr lst_119)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (let-values (((v_63) form_3))
                                                                          (if (if (pair? v_63)
                                                                                (if (let-values (((a_370) (car v_63)))
                                                                                      (equal? 'define-values a_370))
                                                                                  (let-values (((d_361) (cdr v_63)))
                                                                                    (if (pair? d_361)
                                                                                      (if (let-values (((a_371)
                                                                                                        (car d_361)))
                                                                                            #t)
                                                                                        (let-values (((d_362)
                                                                                                      (cdr d_361)))
                                                                                          (if (pair? d_362)
                                                                                            (if (let-values (((a_372)
                                                                                                              (car
                                                                                                               d_362)))
                                                                                                  #t)
                                                                                              (let-values (((d_363)
                                                                                                            (cdr
                                                                                                             d_362)))
                                                                                                (equal? '() d_363))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_51 rhs_43)
                                                                                          (let-values (((d_364)
                                                                                                        (cdr v_63)))
                                                                                            (let-values (((ids_52)
                                                                                                          (let-values (((a_373)
                                                                                                                        (car
                                                                                                                         d_364)))
                                                                                                            a_373))
                                                                                                         ((rhs_44)
                                                                                                          (let-values (((d_365)
                                                                                                                        (cdr
                                                                                                                         d_364)))
                                                                                                            (let-values (((a_374)
                                                                                                                          (car
                                                                                                                           d_365)))
                                                                                                              a_374))))
                                                                                              (values ids_52 rhs_44)))))
                                                                              (begin
                                                                                (let-values (((lst_120) ids_51))
                                                                                  (begin
                                                                                    (check-list lst_120)
                                                                                    ((letrec-values (((for-loop_53)
                                                                                                      (lambda (lst_121)
                                                                                                        (if (pair?
                                                                                                             lst_121)
                                                                                                          (let-values (((id_25)
                                                                                                                        (unsafe-car
                                                                                                                         lst_121))
                                                                                                                       ((rest_64)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_121)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((state_0)
                                                                                                                                                              (hash-ref
                                                                                                                                                               mutated_8
                                                                                                                                                               id_25
                                                                                                                                                               #f)))
                                                                                                                                                  (if (delayed?
                                                                                                                                                       state_0)
                                                                                                                                                    (let-values ()
                                                                                                                                                      (begin
                                                                                                                                                        (hash-remove!
                                                                                                                                                         mutated_8
                                                                                                                                                         id_25)
                                                                                                                                                        (state_0)))
                                                                                                                                                    (void))))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_53
                                                                                                                 rest_64)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_53)
                                                                                     lst_120)))
                                                                                (void)))
                                                                            (let-values () (void)))))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_52 rest_63) (values))))
                                  (values)))))
               for-loop_52)
             lst_118)))
        (void)
        mutated_8))))
 (define-values (delayed?) (lambda (v_64) (procedure? v_64)))
 (define-values
  (find-mutated!)
  (lambda (v_65 ids_53 prim-knowns_9 knowns_32 imports_19 mutated_9)
    (let-values (((delay!_0)
                  (lambda (ids_54 thunk_0)
                    (let-values (((done?_0) #f))
                      (begin
                        (let-values (((lst_122) ids_54))
                          (begin
                            (check-list lst_122)
                            ((letrec-values (((for-loop_54)
                                              (lambda (lst_123)
                                                (if (pair? lst_123)
                                                  (let-values (((id_26) (unsafe-car lst_123))
                                                               ((rest_65) (unsafe-cdr lst_123)))
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (let-values ((()
                                                                                  (let-values ()
                                                                                    (begin
                                                                                      (let-values ()
                                                                                        (if (eq?
                                                                                             'not-ready
                                                                                             (hash-ref
                                                                                              mutated_9
                                                                                              id_26
                                                                                              'not-ready))
                                                                                          (let-values ()
                                                                                            (hash-set!
                                                                                             mutated_9
                                                                                             id_26
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
                                                      (if (not #f) (for-loop_54 rest_65) (values))))
                                                  (values)))))
                               for-loop_54)
                             lst_122)))
                        (void))))))
      ((letrec-values (((find-mutated!_0)
                        (lambda (v_66 ids_55)
                          (let-values (((find-mutated!*_0)
                                        (lambda (l_14 ids_56)
                                          ((letrec-values (((loop_9)
                                                            (lambda (l_15)
                                                              (if (null? l_15)
                                                                (let-values () (void))
                                                                (if (null? (cdr l_15))
                                                                  (let-values () (find-mutated!_0 (car l_15) ids_56))
                                                                  (let-values ()
                                                                    (begin
                                                                      (find-mutated!_0 (car l_15) #f)
                                                                      (loop_9 (cdr l_15)))))))))
                                             loop_9)
                                           l_14))))
                            (let-values (((v_67) v_66))
                              (if (if (pair? v_67)
                                    (if (let-values (((a_375) (car v_67))) (equal? 'lambda a_375))
                                      (let-values (((d_366) (cdr v_67)))
                                        (if (pair? d_366)
                                          (if (let-values (((a_376) (car d_366))) #t)
                                            (let-values (((d_367) (cdr d_366))) (list? d_367))
                                            #f)
                                          #f))
                                      #f)
                                    #f)
                                (let-values (((formals_3 body_21)
                                              (let-values (((d_368) (cdr v_67)))
                                                (let-values (((formals_4) (let-values (((a_377) (car d_368))) a_377))
                                                             ((body_22) (let-values (((d_369) (cdr d_368))) d_369)))
                                                  (values formals_4 body_22)))))
                                  (if ids_55
                                    (delay!_0 ids_55 (lambda () (find-mutated!*_0 body_21 #f)))
                                    (find-mutated!*_0 body_21 #f)))
                                (if (if (pair? v_67)
                                      (if (let-values (((a_378) (car v_67))) (equal? 'case-lambda a_378))
                                        (let-values (((d_370) (cdr v_67)))
                                          (if (list? d_370)
                                            (let-values (((lst_124) d_370))
                                              (begin
                                                (check-list lst_124)
                                                ((letrec-values (((for-loop_55)
                                                                  (lambda (result_59 lst_125)
                                                                    (if (pair? lst_125)
                                                                      (let-values (((v_68) (unsafe-car lst_125))
                                                                                   ((rest_66) (unsafe-cdr lst_125)))
                                                                        (let-values (((result_60)
                                                                                      (let-values ()
                                                                                        (let-values (((result_61)
                                                                                                      (let-values ()
                                                                                                        (let-values ()
                                                                                                          (if (pair?
                                                                                                               v_68)
                                                                                                            (if (let-values (((a_379)
                                                                                                                              (car
                                                                                                                               v_68)))
                                                                                                                  #t)
                                                                                                              (let-values (((d_371)
                                                                                                                            (cdr
                                                                                                                             v_68)))
                                                                                                                (list?
                                                                                                                 d_371))
                                                                                                              #f)
                                                                                                            #f)))))
                                                                                          (values result_61)))))
                                                                          (if (if (not
                                                                                   ((lambda x_16 (not result_60)) v_68))
                                                                                (not #f)
                                                                                #f)
                                                                            (for-loop_55 result_60 rest_66)
                                                                            result_60)))
                                                                      result_59))))
                                                   for-loop_55)
                                                 #t
                                                 lst_124)))
                                            #f))
                                        #f)
                                      #f)
                                  (let-values (((formalss_7 bodys_24)
                                                (let-values (((d_372) (cdr v_67)))
                                                  (let-values (((formalss_8 bodys_25)
                                                                (let-values (((lst_126) d_372))
                                                                  (begin
                                                                    (check-list lst_126)
                                                                    ((letrec-values (((for-loop_56)
                                                                                      (lambda (formalss_9
                                                                                               bodys_26
                                                                                               lst_127)
                                                                                        (if (pair? lst_127)
                                                                                          (let-values (((v_69)
                                                                                                        (unsafe-car
                                                                                                         lst_127))
                                                                                                       ((rest_67)
                                                                                                        (unsafe-cdr
                                                                                                         lst_127)))
                                                                                            (let-values (((formalss_10
                                                                                                           bodys_27)
                                                                                                          (let-values (((formalss_11)
                                                                                                                        formalss_9)
                                                                                                                       ((bodys_28)
                                                                                                                        bodys_26))
                                                                                                            (let-values (((formalss_12
                                                                                                                           bodys_29)
                                                                                                                          (let-values ()
                                                                                                                            (let-values (((formalss27_0
                                                                                                                                           bodys28_0)
                                                                                                                                          (let-values ()
                                                                                                                                            (let-values (((formalss_13)
                                                                                                                                                          (let-values (((a_380)
                                                                                                                                                                        (car
                                                                                                                                                                         v_69)))
                                                                                                                                                            a_380))
                                                                                                                                                         ((bodys_30)
                                                                                                                                                          (let-values (((d_373)
                                                                                                                                                                        (cdr
                                                                                                                                                                         v_69)))
                                                                                                                                                            d_373)))
                                                                                                                                              (values
                                                                                                                                               formalss_13
                                                                                                                                               bodys_30)))))
                                                                                                                              (values
                                                                                                                               (cons
                                                                                                                                formalss27_0
                                                                                                                                formalss_11)
                                                                                                                               (cons
                                                                                                                                bodys28_0
                                                                                                                                bodys_28))))))
                                                                                                              (values
                                                                                                               formalss_12
                                                                                                               bodys_29)))))
                                                                                              (if (not #f)
                                                                                                (for-loop_56
                                                                                                 formalss_10
                                                                                                 bodys_27
                                                                                                 rest_67)
                                                                                                (values
                                                                                                 formalss_10
                                                                                                 bodys_27))))
                                                                                          (values
                                                                                           formalss_9
                                                                                           bodys_26)))))
                                                                       for-loop_56)
                                                                     null
                                                                     null
                                                                     lst_126)))))
                                                    (values (reverse$1 formalss_8) (reverse$1 bodys_25))))))
                                    (if ids_55
                                      (delay!_0
                                       ids_55
                                       (lambda ()
                                         (begin
                                           (let-values (((lst_128) bodys_24))
                                             (begin
                                               (check-list lst_128)
                                               ((letrec-values (((for-loop_57)
                                                                 (lambda (lst_129)
                                                                   (if (pair? lst_129)
                                                                     (let-values (((body_23) (unsafe-car lst_129))
                                                                                  ((rest_68) (unsafe-cdr lst_129)))
                                                                       (let-values ((()
                                                                                     (let-values ()
                                                                                       (let-values ((()
                                                                                                     (let-values ()
                                                                                                       (begin
                                                                                                         (let-values ()
                                                                                                           (find-mutated!*_0
                                                                                                            body_23
                                                                                                            #f))
                                                                                                         (values)))))
                                                                                         (values)))))
                                                                         (if (not #f) (for-loop_57 rest_68) (values))))
                                                                     (values)))))
                                                  for-loop_57)
                                                lst_128)))
                                           (void))))
                                      (begin
                                        (let-values (((lst_130) bodys_24))
                                          (begin
                                            (check-list lst_130)
                                            ((letrec-values (((for-loop_58)
                                                              (lambda (lst_131)
                                                                (if (pair? lst_131)
                                                                  (let-values (((body_24) (unsafe-car lst_131))
                                                                               ((rest_69) (unsafe-cdr lst_131)))
                                                                    (let-values ((()
                                                                                  (let-values ()
                                                                                    (let-values ((()
                                                                                                  (let-values ()
                                                                                                    (begin
                                                                                                      (let-values ()
                                                                                                        (find-mutated!*_0
                                                                                                         body_24
                                                                                                         #f))
                                                                                                      (values)))))
                                                                                      (values)))))
                                                                      (if (not #f) (for-loop_58 rest_69) (values))))
                                                                  (values)))))
                                               for-loop_58)
                                             lst_130)))
                                        (void))))
                                  (if (if (pair? v_67)
                                        (if (let-values (((a_381) (car v_67))) (equal? 'quote a_381))
                                          (let-values (((d_374) (cdr v_67)))
                                            (if (pair? d_374)
                                              (if (let-values (((a_382) (car d_374))) #t)
                                                (let-values (((d_375) (cdr d_374))) (equal? '() d_375))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values () (void))
                                    (if (if (pair? v_67)
                                          (if (let-values (((a_383) (car v_67))) (equal? 'let-values a_383))
                                            (let-values (((d_376) (cdr v_67)))
                                              (if (pair? d_376)
                                                (if (let-values (((a_384) (car d_376)))
                                                      (if (list? a_384)
                                                        (let-values (((lst_132) a_384))
                                                          (begin
                                                            (check-list lst_132)
                                                            ((letrec-values (((for-loop_59)
                                                                              (lambda (result_62 lst_133)
                                                                                (if (pair? lst_133)
                                                                                  (let-values (((v_70)
                                                                                                (unsafe-car lst_133))
                                                                                               ((rest_70)
                                                                                                (unsafe-cdr lst_133)))
                                                                                    (let-values (((result_63)
                                                                                                  (let-values ()
                                                                                                    (let-values (((result_64)
                                                                                                                  (let-values ()
                                                                                                                    (let-values ()
                                                                                                                      (if (pair?
                                                                                                                           v_70)
                                                                                                                        (if (let-values (((a_385)
                                                                                                                                          (car
                                                                                                                                           v_70)))
                                                                                                                              #t)
                                                                                                                          (let-values (((d_377)
                                                                                                                                        (cdr
                                                                                                                                         v_70)))
                                                                                                                            (if (pair?
                                                                                                                                 d_377)
                                                                                                                              (if (let-values (((a_386)
                                                                                                                                                (car
                                                                                                                                                 d_377)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_378)
                                                                                                                                              (cdr
                                                                                                                                               d_377)))
                                                                                                                                  (equal?
                                                                                                                                   '()
                                                                                                                                   d_378))
                                                                                                                                #f)
                                                                                                                              #f))
                                                                                                                          #f)
                                                                                                                        #f)))))
                                                                                                      (values
                                                                                                       result_64)))))
                                                                                      (if (if (not
                                                                                               ((lambda x_17
                                                                                                  (not result_63))
                                                                                                v_70))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_59 result_63 rest_70)
                                                                                        result_63)))
                                                                                  result_62))))
                                                               for-loop_59)
                                                             #t
                                                             lst_132)))
                                                        #f))
                                                  (let-values (((d_379) (cdr d_376))) (list? d_379))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((idss_33 rhss_82 bodys_31)
                                                    (let-values (((d_380) (cdr v_67)))
                                                      (let-values (((idss_34 rhss_83)
                                                                    (let-values (((a_387) (car d_380)))
                                                                      (let-values (((idss_35 rhss_84)
                                                                                    (let-values (((lst_134) a_387))
                                                                                      (begin
                                                                                        (check-list lst_134)
                                                                                        ((letrec-values (((for-loop_60)
                                                                                                          (lambda (idss_36
                                                                                                                   rhss_85
                                                                                                                   lst_135)
                                                                                                            (if (pair?
                                                                                                                 lst_135)
                                                                                                              (let-values (((v_71)
                                                                                                                            (unsafe-car
                                                                                                                             lst_135))
                                                                                                                           ((rest_71)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_135)))
                                                                                                                (let-values (((idss_37
                                                                                                                               rhss_86)
                                                                                                                              (let-values (((idss_38)
                                                                                                                                            idss_36)
                                                                                                                                           ((rhss_87)
                                                                                                                                            rhss_85))
                                                                                                                                (let-values (((idss_39
                                                                                                                                               rhss_88)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((idss29_0
                                                                                                                                                               rhss30_0)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((idss_40)
                                                                                                                                                                              (let-values (((a_388)
                                                                                                                                                                                            (car
                                                                                                                                                                                             v_71)))
                                                                                                                                                                                a_388))
                                                                                                                                                                             ((rhss_89)
                                                                                                                                                                              (let-values (((d_381)
                                                                                                                                                                                            (cdr
                                                                                                                                                                                             v_71)))
                                                                                                                                                                                (let-values (((a_389)
                                                                                                                                                                                              (car
                                                                                                                                                                                               d_381)))
                                                                                                                                                                                  a_389))))
                                                                                                                                                                  (values
                                                                                                                                                                   idss_40
                                                                                                                                                                   rhss_89)))))
                                                                                                                                                  (values
                                                                                                                                                   (cons
                                                                                                                                                    idss29_0
                                                                                                                                                    idss_38)
                                                                                                                                                   (cons
                                                                                                                                                    rhss30_0
                                                                                                                                                    rhss_87))))))
                                                                                                                                  (values
                                                                                                                                   idss_39
                                                                                                                                   rhss_88)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_60
                                                                                                                     idss_37
                                                                                                                     rhss_86
                                                                                                                     rest_71)
                                                                                                                    (values
                                                                                                                     idss_37
                                                                                                                     rhss_86))))
                                                                                                              (values
                                                                                                               idss_36
                                                                                                               rhss_85)))))
                                                                                           for-loop_60)
                                                                                         null
                                                                                         null
                                                                                         lst_134)))))
                                                                        (values
                                                                         (reverse$1 idss_35)
                                                                         (reverse$1 rhss_84)))))
                                                                   ((bodys_32)
                                                                    (let-values (((d_382) (cdr d_380))) d_382)))
                                                        (values idss_34 rhss_83 bodys_32)))))
                                        (begin
                                          (let-values (((lst_136) idss_33) ((lst_137) rhss_82))
                                            (begin
                                              (check-list lst_136)
                                              (check-list lst_137)
                                              ((letrec-values (((for-loop_61)
                                                                (lambda (lst_138 lst_139)
                                                                  (if (if (pair? lst_138) (pair? lst_139) #f)
                                                                    (let-values (((ids_57) (unsafe-car lst_138))
                                                                                 ((rest_72) (unsafe-cdr lst_138))
                                                                                 ((rhs_45) (unsafe-car lst_139))
                                                                                 ((rest_73) (unsafe-cdr lst_139)))
                                                                      (let-values ((()
                                                                                    (let-values ()
                                                                                      (let-values ((()
                                                                                                    (let-values ()
                                                                                                      (begin
                                                                                                        (let-values ()
                                                                                                          (find-mutated!_0
                                                                                                           rhs_45
                                                                                                           ids_57))
                                                                                                        (values)))))
                                                                                        (values)))))
                                                                        (if (not #f)
                                                                          (for-loop_61 rest_72 rest_73)
                                                                          (values))))
                                                                    (values)))))
                                                 for-loop_61)
                                               lst_136
                                               lst_137)))
                                          (void)
                                          (find-mutated!*_0 bodys_31 ids_55)))
                                      (if (if (pair? v_67)
                                            (if (let-values (((a_390) (car v_67))) (equal? 'letrec-values a_390))
                                              (let-values (((d_383) (cdr v_67)))
                                                (if (pair? d_383)
                                                  (if (let-values (((a_391) (car d_383)))
                                                        (if (list? a_391)
                                                          (let-values (((lst_140) a_391))
                                                            (begin
                                                              (check-list lst_140)
                                                              ((letrec-values (((for-loop_62)
                                                                                (lambda (result_65 lst_141)
                                                                                  (if (pair? lst_141)
                                                                                    (let-values (((v_72)
                                                                                                  (unsafe-car lst_141))
                                                                                                 ((rest_74)
                                                                                                  (unsafe-cdr lst_141)))
                                                                                      (let-values (((result_66)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_67)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (if (pair?
                                                                                                                             v_72)
                                                                                                                          (if (let-values (((a_392)
                                                                                                                                            (car
                                                                                                                                             v_72)))
                                                                                                                                #t)
                                                                                                                            (let-values (((d_384)
                                                                                                                                          (cdr
                                                                                                                                           v_72)))
                                                                                                                              (if (pair?
                                                                                                                                   d_384)
                                                                                                                                (if (let-values (((a_393)
                                                                                                                                                  (car
                                                                                                                                                   d_384)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_385)
                                                                                                                                                (cdr
                                                                                                                                                 d_384)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_385))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                            #f)
                                                                                                                          #f)))))
                                                                                                        (values
                                                                                                         result_67)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_18
                                                                                                    (not result_66))
                                                                                                  v_72))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_62
                                                                                           result_66
                                                                                           rest_74)
                                                                                          result_66)))
                                                                                    result_65))))
                                                                 for-loop_62)
                                                               #t
                                                               lst_140)))
                                                          #f))
                                                    (let-values (((d_386) (cdr d_383))) (list? d_386))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((idss_41 rhss_90 bodys_33)
                                                      (let-values (((d_387) (cdr v_67)))
                                                        (let-values (((idss_42 rhss_91)
                                                                      (let-values (((a_394) (car d_387)))
                                                                        (let-values (((idss_43 rhss_92)
                                                                                      (let-values (((lst_142) a_394))
                                                                                        (begin
                                                                                          (check-list lst_142)
                                                                                          ((letrec-values (((for-loop_63)
                                                                                                            (lambda (idss_44
                                                                                                                     rhss_93
                                                                                                                     lst_143)
                                                                                                              (if (pair?
                                                                                                                   lst_143)
                                                                                                                (let-values (((v_73)
                                                                                                                              (unsafe-car
                                                                                                                               lst_143))
                                                                                                                             ((rest_75)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_143)))
                                                                                                                  (let-values (((idss_45
                                                                                                                                 rhss_94)
                                                                                                                                (let-values (((idss_46)
                                                                                                                                              idss_44)
                                                                                                                                             ((rhss_95)
                                                                                                                                              rhss_93))
                                                                                                                                  (let-values (((idss_47
                                                                                                                                                 rhss_96)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values (((idss31_0
                                                                                                                                                                 rhss32_0)
                                                                                                                                                                (let-values ()
                                                                                                                                                                  (let-values (((idss_48)
                                                                                                                                                                                (let-values (((a_395)
                                                                                                                                                                                              (car
                                                                                                                                                                                               v_73)))
                                                                                                                                                                                  a_395))
                                                                                                                                                                               ((rhss_97)
                                                                                                                                                                                (let-values (((d_388)
                                                                                                                                                                                              (cdr
                                                                                                                                                                                               v_73)))
                                                                                                                                                                                  (let-values (((a_396)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 d_388)))
                                                                                                                                                                                    a_396))))
                                                                                                                                                                    (values
                                                                                                                                                                     idss_48
                                                                                                                                                                     rhss_97)))))
                                                                                                                                                    (values
                                                                                                                                                     (cons
                                                                                                                                                      idss31_0
                                                                                                                                                      idss_46)
                                                                                                                                                     (cons
                                                                                                                                                      rhss32_0
                                                                                                                                                      rhss_95))))))
                                                                                                                                    (values
                                                                                                                                     idss_47
                                                                                                                                     rhss_96)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_63
                                                                                                                       idss_45
                                                                                                                       rhss_94
                                                                                                                       rest_75)
                                                                                                                      (values
                                                                                                                       idss_45
                                                                                                                       rhss_94))))
                                                                                                                (values
                                                                                                                 idss_44
                                                                                                                 rhss_93)))))
                                                                                             for-loop_63)
                                                                                           null
                                                                                           null
                                                                                           lst_142)))))
                                                                          (values
                                                                           (reverse$1 idss_43)
                                                                           (reverse$1 rhss_92)))))
                                                                     ((bodys_34)
                                                                      (let-values (((d_389) (cdr d_387))) d_389)))
                                                          (values idss_42 rhss_91 bodys_34)))))
                                          (begin
                                            (let-values (((lst_144) idss_41))
                                              (begin
                                                (check-list lst_144)
                                                ((letrec-values (((for-loop_64)
                                                                  (lambda (lst_145)
                                                                    (if (pair? lst_145)
                                                                      (let-values (((ids_58) (unsafe-car lst_145))
                                                                                   ((rest_76) (unsafe-cdr lst_145)))
                                                                        (let-values ((()
                                                                                      (let-values (((lst_146) ids_58))
                                                                                        (begin
                                                                                          (check-list lst_146)
                                                                                          ((letrec-values (((for-loop_65)
                                                                                                            (lambda (lst_147)
                                                                                                              (if (pair?
                                                                                                                   lst_147)
                                                                                                                (let-values (((id_27)
                                                                                                                              (unsafe-car
                                                                                                                               lst_147))
                                                                                                                             ((rest_77)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_147)))
                                                                                                                  (let-values ((()
                                                                                                                                (let-values ()
                                                                                                                                  (let-values ((()
                                                                                                                                                (let-values ()
                                                                                                                                                  (begin
                                                                                                                                                    (let-values ()
                                                                                                                                                      (hash-set!
                                                                                                                                                       mutated_9
                                                                                                                                                       id_27
                                                                                                                                                       'not-ready))
                                                                                                                                                    (values)))))
                                                                                                                                    (values)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_65
                                                                                                                       rest_77)
                                                                                                                      (values))))
                                                                                                                (values)))))
                                                                                             for-loop_65)
                                                                                           lst_146)))))
                                                                          (if (not #f) (for-loop_64 rest_76) (values))))
                                                                      (values)))))
                                                   for-loop_64)
                                                 lst_144)))
                                            (void)
                                            (let-values (((lst_148) idss_41) ((lst_149) rhss_90))
                                              (begin
                                                (check-list lst_148)
                                                (check-list lst_149)
                                                ((letrec-values (((for-loop_66)
                                                                  (lambda (lst_150 lst_151)
                                                                    (if (if (pair? lst_150) (pair? lst_151) #f)
                                                                      (let-values (((ids_59) (unsafe-car lst_150))
                                                                                   ((rest_78) (unsafe-cdr lst_150))
                                                                                   ((rhs_46) (unsafe-car lst_151))
                                                                                   ((rest_79) (unsafe-cdr lst_151)))
                                                                        (let-values ((()
                                                                                      (let-values ()
                                                                                        (let-values ((()
                                                                                                      (let-values ()
                                                                                                        (begin
                                                                                                          (let-values ()
                                                                                                            (begin
                                                                                                              (find-mutated!_0
                                                                                                               rhs_46
                                                                                                               ids_59)
                                                                                                              (let-values (((lst_152)
                                                                                                                            ids_59))
                                                                                                                (begin
                                                                                                                  (check-list
                                                                                                                   lst_152)
                                                                                                                  ((letrec-values (((for-loop_67)
                                                                                                                                    (lambda (lst_153)
                                                                                                                                      (if (pair?
                                                                                                                                           lst_153)
                                                                                                                                        (let-values (((id_28)
                                                                                                                                                      (unsafe-car
                                                                                                                                                       lst_153))
                                                                                                                                                     ((rest_80)
                                                                                                                                                      (unsafe-cdr
                                                                                                                                                       lst_153)))
                                                                                                                                          (let-values ((()
                                                                                                                                                        (let-values ()
                                                                                                                                                          (let-values ((()
                                                                                                                                                                        (let-values ()
                                                                                                                                                                          (begin
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (if (eq?
                                                                                                                                                                                   'not-ready
                                                                                                                                                                                   (hash-ref
                                                                                                                                                                                    mutated_9
                                                                                                                                                                                    id_28))
                                                                                                                                                                                (let-values ()
                                                                                                                                                                                  (hash-remove!
                                                                                                                                                                                   mutated_9
                                                                                                                                                                                   id_28))
                                                                                                                                                                                (void)))
                                                                                                                                                                            (values)))))
                                                                                                                                                            (values)))))
                                                                                                                                            (if (not
                                                                                                                                                 #f)
                                                                                                                                              (for-loop_67
                                                                                                                                               rest_80)
                                                                                                                                              (values))))
                                                                                                                                        (values)))))
                                                                                                                     for-loop_67)
                                                                                                                   lst_152)))
                                                                                                              (void)))
                                                                                                          (values)))))
                                                                                          (values)))))
                                                                          (if (not #f)
                                                                            (for-loop_66 rest_78 rest_79)
                                                                            (values))))
                                                                      (values)))))
                                                   for-loop_66)
                                                 lst_148
                                                 lst_149)))
                                            (void)
                                            (find-mutated!*_0 bodys_33 ids_55)))
                                        (if (if (pair? v_67)
                                              (if (let-values (((a_397) (car v_67))) (equal? 'if a_397))
                                                (let-values (((d_390) (cdr v_67)))
                                                  (if (pair? d_390)
                                                    (if (let-values (((a_398) (car d_390))) #t)
                                                      (let-values (((d_391) (cdr d_390)))
                                                        (if (pair? d_391)
                                                          (if (let-values (((a_399) (car d_391))) #t)
                                                            (let-values (((d_392) (cdr d_391)))
                                                              (if (pair? d_392)
                                                                (if (let-values (((a_400) (car d_392))) #t)
                                                                  (let-values (((d_393) (cdr d_392)))
                                                                    (equal? '() d_393))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((tst_2 thn_3 els_3)
                                                        (let-values (((d_394) (cdr v_67)))
                                                          (let-values (((tst_3)
                                                                        (let-values (((a_401) (car d_394))) a_401))
                                                                       ((thn_4 els_4)
                                                                        (let-values (((d_395) (cdr d_394)))
                                                                          (let-values (((thn_5)
                                                                                        (let-values (((a_402)
                                                                                                      (car d_395)))
                                                                                          a_402))
                                                                                       ((els_5)
                                                                                        (let-values (((d_396)
                                                                                                      (cdr d_395)))
                                                                                          (let-values (((a_403)
                                                                                                        (car d_396)))
                                                                                            a_403))))
                                                                            (values thn_5 els_5)))))
                                                            (values tst_3 thn_4 els_4)))))
                                            (begin
                                              (find-mutated!_0 tst_2 #f)
                                              (find-mutated!_0 thn_3 #f)
                                              (find-mutated!_0 els_3 #f)))
                                          (if (if (pair? v_67)
                                                (if (let-values (((a_404) (car v_67)))
                                                      (equal? 'with-continuation-mark a_404))
                                                  (let-values (((d_397) (cdr v_67)))
                                                    (if (pair? d_397)
                                                      (if (let-values (((a_405) (car d_397))) #t)
                                                        (let-values (((d_398) (cdr d_397)))
                                                          (if (pair? d_398)
                                                            (if (let-values (((a_406) (car d_398))) #t)
                                                              (let-values (((d_399) (cdr d_398)))
                                                                (if (pair? d_399)
                                                                  (if (let-values (((a_407) (car d_399))) #t)
                                                                    (let-values (((d_400) (cdr d_399)))
                                                                      (equal? '() d_400))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((key_3 val_3 body_25)
                                                          (let-values (((d_401) (cdr v_67)))
                                                            (let-values (((key_4)
                                                                          (let-values (((a_408) (car d_401))) a_408))
                                                                         ((val_4 body_26)
                                                                          (let-values (((d_402) (cdr d_401)))
                                                                            (let-values (((val_5)
                                                                                          (let-values (((a_409)
                                                                                                        (car d_402)))
                                                                                            a_409))
                                                                                         ((body_27)
                                                                                          (let-values (((d_403)
                                                                                                        (cdr d_402)))
                                                                                            (let-values (((a_410)
                                                                                                          (car d_403)))
                                                                                              a_410))))
                                                                              (values val_5 body_27)))))
                                                              (values key_4 val_4 body_26)))))
                                              (begin
                                                (find-mutated!_0 key_3 #f)
                                                (find-mutated!_0 val_3 #f)
                                                (find-mutated!_0 body_25 ids_55)))
                                            (if (if (pair? v_67)
                                                  (if (let-values (((a_411) (car v_67))) (equal? 'begin a_411))
                                                    (let-values (((d_404) (cdr v_67))) (list? d_404))
                                                    #f)
                                                  #f)
                                              (let-values (((exps_4) (let-values (((d_405) (cdr v_67))) d_405)))
                                                (find-mutated!*_0 exps_4 ids_55))
                                              (if (if (pair? v_67)
                                                    (if (let-values (((a_412) (car v_67))) (equal? 'begin0 a_412))
                                                      (let-values (((d_406) (cdr v_67)))
                                                        (if (pair? d_406)
                                                          (if (let-values (((a_413) (car d_406))) #t)
                                                            (let-values (((d_407) (cdr d_406))) (list? d_407))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f)
                                                (let-values (((exp_0 exps_5)
                                                              (let-values (((d_408) (cdr v_67)))
                                                                (let-values (((exp_1)
                                                                              (let-values (((a_414) (car d_408)))
                                                                                a_414))
                                                                             ((exps_6)
                                                                              (let-values (((d_409) (cdr d_408)))
                                                                                d_409)))
                                                                  (values exp_1 exps_6)))))
                                                  (begin (find-mutated!_0 exp_0 ids_55) (find-mutated!*_0 exps_5 #f)))
                                                (if (if (pair? v_67)
                                                      (if (let-values (((a_415) (car v_67))) (equal? 'set! a_415))
                                                        (let-values (((d_410) (cdr v_67)))
                                                          (if (pair? d_410)
                                                            (if (let-values (((a_416) (car d_410))) #t)
                                                              (let-values (((d_411) (cdr d_410)))
                                                                (if (pair? d_411)
                                                                  (if (let-values (((a_417) (car d_411))) #t)
                                                                    (let-values (((d_412) (cdr d_411)))
                                                                      (equal? '() d_412))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((id_29 rhs_47)
                                                                (let-values (((d_413) (cdr v_67)))
                                                                  (let-values (((id_30)
                                                                                (let-values (((a_418) (car d_413)))
                                                                                  a_418))
                                                                               ((rhs_48)
                                                                                (let-values (((d_414) (cdr d_413)))
                                                                                  (let-values (((a_419) (car d_414)))
                                                                                    a_419))))
                                                                    (values id_30 rhs_48)))))
                                                    (begin
                                                      (hash-set! mutated_9 id_29 'set!ed)
                                                      (find-mutated!_0 rhs_47 #f)))
                                                  (if (if (pair? v_67)
                                                        (if (let-values (((a_420) (car v_67)))
                                                              (equal? '#%variable-reference a_420))
                                                          (let-values (((d_415) (cdr v_67))) #t)
                                                          #f)
                                                        #f)
                                                    (let-values () (void))
                                                    (if (if (pair? v_67)
                                                          (if (let-values (((a_421) (car v_67))) #t)
                                                            (let-values (((d_416) (cdr v_67))) (list? d_416))
                                                            #f)
                                                          #f)
                                                      (let-values (((rator_2 exps_7)
                                                                    (let-values (((rator_3)
                                                                                  (let-values (((a_422) (car v_67)))
                                                                                    a_422))
                                                                                 ((exps_8)
                                                                                  (let-values (((d_417) (cdr v_67)))
                                                                                    d_417)))
                                                                      (values rator_3 exps_8))))
                                                        (if (if ids_55
                                                              (if (symbol? rator_2)
                                                                (if (not (hash-ref mutated_9 rator_2 #f))
                                                                  (if (let-values (((v_74)
                                                                                    (hash-ref-either
                                                                                     knowns_32
                                                                                     imports_19
                                                                                     rator_2)))
                                                                        (if (known-constructor? v_74)
                                                                          (=
                                                                           (length exps_7)
                                                                           (known-constructor-field-count v_74))
                                                                          #f))
                                                                    (let-values (((lst_154) exps_7))
                                                                      (begin
                                                                        (check-list lst_154)
                                                                        ((letrec-values (((for-loop_68)
                                                                                          (lambda (result_68 lst_155)
                                                                                            (if (pair? lst_155)
                                                                                              (let-values (((exp_2)
                                                                                                            (unsafe-car
                                                                                                             lst_155))
                                                                                                           ((rest_81)
                                                                                                            (unsafe-cdr
                                                                                                             lst_155)))
                                                                                                (let-values (((result_69)
                                                                                                              (let-values ()
                                                                                                                (let-values (((result_70)
                                                                                                                              (let-values ()
                                                                                                                                (let-values ()
                                                                                                                                  (simple?
                                                                                                                                   exp_2
                                                                                                                                   prim-knowns_9
                                                                                                                                   knowns_32
                                                                                                                                   imports_19
                                                                                                                                   mutated_9)))))
                                                                                                                  (values
                                                                                                                   result_70)))))
                                                                                                  (if (if (not
                                                                                                           ((lambda x_19
                                                                                                              (not
                                                                                                               result_69))
                                                                                                            exp_2))
                                                                                                        (not #f)
                                                                                                        #f)
                                                                                                    (for-loop_68
                                                                                                     result_69
                                                                                                     rest_81)
                                                                                                    result_69)))
                                                                                              result_68))))
                                                                           for-loop_68)
                                                                         #t
                                                                         lst_154)))
                                                                    #f)
                                                                  #f)
                                                                #f)
                                                              #f)
                                                          (let-values ()
                                                            (delay!_0 ids_55 (lambda () (find-mutated!*_0 exps_7 #f))))
                                                          (let-values ()
                                                            (begin
                                                              (find-mutated!_0 rator_2 #f)
                                                              (find-mutated!*_0 exps_7 #f)))))
                                                      (let-values ()
                                                        (if (symbol? v_66)
                                                          (let-values ()
                                                            (let-values (((state_1) (hash-ref mutated_9 v_66 #f)))
                                                              (if (eq? state_1 'not-ready)
                                                                (let-values () (hash-set! mutated_9 v_66 'too-early))
                                                                (if (delayed? state_1)
                                                                  (let-values ()
                                                                    (if ids_55
                                                                      (let-values ()
                                                                        (delay!_0
                                                                         ids_55
                                                                         (lambda ()
                                                                           (begin
                                                                             (hash-remove! mutated_9 v_66)
                                                                             (state_1)))))
                                                                      (let-values ()
                                                                        (begin
                                                                          (hash-remove! mutated_9 v_66)
                                                                          (state_1)))))
                                                                  (void)))))
                                                          (void))))))))))))))))))))
         find-mutated!_0)
       v_65
       ids_53)))))
