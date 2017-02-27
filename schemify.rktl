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
                  (let-values () (make-struct-type 'known-unknown #f 0 0 #f null 'prefab #f '() #f 'known-unknown)))))
    (values struct:_1 make-_1 ?_1)))
 (define-values
  (struct:known-procedure known-procedure known-procedure?)
  (let-values (((struct:_2 make-_2 ?_2 -ref_2 -set!_2)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-procedure
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
                     (let-values (((the-super_1) struct:known-procedure))
                       (if (struct-type? the-super_1) the-super_1 (check-struct-type 'struct the-super_1)))
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
                     (let-values (((the-super_2) struct:known-procedure))
                       (if (struct-type? the-super_2) the-super_2 (check-struct-type 'struct the-super_2)))
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
                     'known-accessor)))))
    (values struct:_6 make-_6 ?_6 (make-struct-field-accessor -ref_6 0 'type))))
 (define-values
  (struct:known-mutator known-mutator known-mutator? known-mutator-type)
  (let-values (((struct:_7 make-_7 ?_7 -ref_7 -set!_7)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'known-mutator
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
  (let-values (((struct:_2 make-_2 ?_2 -ref_2 -set!_2)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'import-group #f 1 0 #f null (current-inspector) #f '() #f 'import-group)))))
    (values
     struct:_2
     make-_2
     ?_2
     (make-struct-field-accessor -ref_2 0 'knowns/thunk)
     (make-struct-field-mutator -set!_2 0 'knowns/thunk))))
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
                        (lambda (l_11 knowns_5 accum_0 need-expr?_0)
                          (if (null? l_11)
                            (let-values ()
                              (values
                               (append
                                (map2
                                 (make-schemify prim-knowns_2 knowns_5 mutated_0 imports_10 exports_6)
                                 (reverse$1 accum_0))
                                (make-set-variables accum_0 exports_6)
                                (if need-expr?_0 '((void)) null))
                               knowns_5))
                            (let-values ()
                              (let-values (((v_15 new-knowns_0 side-effects?_0 defn?_0)
                                            (find-definitions
                                             (car l_11)
                                             prim-knowns_2
                                             knowns_5
                                             imports_10
                                             mutated_0
                                             (null? (cdr l_11)))))
                                (if (not side-effects?_0)
                                  (let-values () (loop_5 (cdr l_11) new-knowns_0 (cons v_15 accum_0) #t))
                                  (let-values ()
                                    (let-values (((schemify_0)
                                                  (make-schemify
                                                   prim-knowns_2
                                                   new-knowns_0
                                                   mutated_0
                                                   imports_10
                                                   exports_6)))
                                      (let-values (((schemified-accum_0) (map2 schemify_0 (reverse$1 accum_0))))
                                        (let-values (((schemified-v_0) (list (schemify_0 v_15))))
                                          (let-values (((schemified-rest_0 defn-info_2)
                                                        (loop_5 (cdr l_11) new-knowns_0 null defn?_0)))
                                            (values
                                             (append
                                              schemified-accum_0
                                              (make-set-variables accum_0 exports_6)
                                              schemified-v_0
                                              (make-set-variables (list v_15) exports_6)
                                              schemified-rest_0)
                                             defn-info_2)))))))))))))
         loop_5)
       l_10
       (hasheq)
       null
       #f))))
 (define-values
  (lambda?)
  (lambda (v_16)
    (let-values (((v_17) v_16))
      (if (if (pair? v_17)
            (if (let-values (((a_3) (car v_17))) (equal? 'lambda a_3)) (let-values (((d_0) (cdr v_17))) #t) #f)
            #f)
        (let-values () #t)
        (if (if (pair? v_17)
              (if (let-values (((a_4) (car v_17))) (equal? 'case-lambda a_4)) (let-values (((d_1) (cdr v_17))) #t) #f)
              #f)
          (let-values () #t)
          (if (if (pair? v_17)
                (if (let-values (((a_5) (car v_17))) (equal? 'let-values a_5))
                  (let-values (((d_2) (cdr v_17)))
                    (if (pair? d_2)
                      (if (let-values (((a_6) (car d_2)))
                            (if (pair? a_6)
                              (if (let-values (((a_7) (car a_6)))
                                    (if (pair? a_7)
                                      (if (let-values (((a_8) (car a_7)))
                                            (if (pair? a_8)
                                              (if (let-values (((a_9) (car a_8))) #t)
                                                (let-values (((d_3) (cdr a_8))) (equal? '() d_3))
                                                #f)
                                              #f))
                                        (let-values (((d_4) (cdr a_7)))
                                          (if (pair? d_4)
                                            (if (let-values (((a_10) (car d_4))) #t)
                                              (let-values (((d_5) (cdr d_4))) (equal? '() d_5))
                                              #f)
                                            #f))
                                        #f)
                                      #f))
                                (let-values (((d_6) (cdr a_6))) (equal? '() d_6))
                                #f)
                              #f))
                        (let-values (((d_7) (cdr d_2)))
                          (if (pair? d_7)
                            (if (let-values (((a_11) (car d_7))) #t)
                              (let-values (((d_8) (cdr d_7))) (equal? '() d_8))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((id1_0 rhs_0 id2_0)
                          (let-values (((d_9) (cdr v_17)))
                            (let-values (((id1_1 rhs_1)
                                          (let-values (((a_12) (car d_9)))
                                            (let-values (((a_13) (car a_12)))
                                              (let-values (((id1_2)
                                                            (let-values (((a_14) (car a_13)))
                                                              (let-values (((a_15) (car a_14))) a_15)))
                                                           ((rhs_2)
                                                            (let-values (((d_10) (cdr a_13)))
                                                              (let-values (((a_16) (car d_10))) a_16))))
                                                (values id1_2 rhs_2)))))
                                         ((id2_1)
                                          (let-values (((d_11) (cdr d_9))) (let-values (((a_17) (car d_11))) a_17))))
                              (values id1_1 rhs_1 id2_1)))))
              (if (eq? id1_0 id2_0) (lambda? rhs_0) #f))
            (if (if (pair? v_17)
                  (if (let-values (((a_18) (car v_17))) (equal? 'letrec-values a_18))
                    (let-values (((d_12) (cdr v_17)))
                      (if (pair? d_12)
                        (if (let-values (((a_19) (car d_12)))
                              (if (pair? a_19)
                                (if (let-values (((a_20) (car a_19)))
                                      (if (pair? a_20)
                                        (if (let-values (((a_21) (car a_20)))
                                              (if (pair? a_21)
                                                (if (let-values (((a_22) (car a_21))) #t)
                                                  (let-values (((d_13) (cdr a_21))) (equal? '() d_13))
                                                  #f)
                                                #f))
                                          (let-values (((d_14) (cdr a_20)))
                                            (if (pair? d_14)
                                              (if (let-values (((a_23) (car d_14))) #t)
                                                (let-values (((d_15) (cdr d_14))) (equal? '() d_15))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                  (let-values (((d_16) (cdr a_19))) (equal? '() d_16))
                                  #f)
                                #f))
                          (let-values (((d_17) (cdr d_12)))
                            (if (pair? d_17)
                              (if (let-values (((a_24) (car d_17))) #t)
                                (let-values (((d_18) (cdr d_17))) (equal? '() d_18))
                                #f)
                              #f))
                          #f)
                        #f))
                    #f)
                  #f)
              (let-values (((id1_3 rhs_3 id2_2)
                            (let-values (((d_19) (cdr v_17)))
                              (let-values (((id1_4 rhs_4)
                                            (let-values (((a_25) (car d_19)))
                                              (let-values (((a_26) (car a_25)))
                                                (let-values (((id1_5)
                                                              (let-values (((a_27) (car a_26)))
                                                                (let-values (((a_28) (car a_27))) a_28)))
                                                             ((rhs_5)
                                                              (let-values (((d_20) (cdr a_26)))
                                                                (let-values (((a_29) (car d_20))) a_29))))
                                                  (values id1_5 rhs_5)))))
                                           ((id2_3)
                                            (let-values (((d_21) (cdr d_19))) (let-values (((a_30) (car d_21))) a_30))))
                                (values id1_4 rhs_4 id2_3)))))
                (if (eq? id1_3 id2_2) (lambda? rhs_3) #f))
              (if (if (pair? v_17)
                    (if (let-values (((a_31) (car v_17))) (equal? 'let-values a_31))
                      (let-values (((d_22) (cdr v_17)))
                        (if (pair? d_22)
                          (if (let-values (((a_32) (car d_22))) #t)
                            (let-values (((d_23) (cdr d_22)))
                              (if (pair? d_23)
                                (if (let-values (((a_33) (car d_23))) #t)
                                  (let-values (((d_24) (cdr d_23))) (equal? '() d_24))
                                  #f)
                                #f))
                            #f)
                          #f))
                      #f)
                    #f)
                (let-values (((body_0)
                              (let-values (((d_25) (cdr v_17)))
                                (let-values (((d_26) (cdr d_25))) (let-values (((a_34) (car d_26))) a_34)))))
                  (lambda? body_0))
                (if (if (pair? v_17)
                      (if (let-values (((a_35) (car v_17))) (equal? 'letrec-values a_35))
                        (let-values (((d_27) (cdr v_17)))
                          (if (pair? d_27)
                            (if (let-values (((a_36) (car d_27))) #t)
                              (let-values (((d_28) (cdr d_27)))
                                (if (pair? d_28)
                                  (if (let-values (((a_37) (car d_28))) #t)
                                    (let-values (((d_29) (cdr d_28))) (equal? '() d_29))
                                    #f)
                                  #f))
                              #f)
                            #f))
                        #f)
                      #f)
                  (let-values (((body_1)
                                (let-values (((d_30) (cdr v_17)))
                                  (let-values (((d_31) (cdr d_30))) (let-values (((a_38) (car d_31))) a_38)))))
                    (lambda? body_1))
                  (let-values () #f))))))))))
 (define-values
  (simple?)
  (lambda (e_0 prim-knowns_3 knowns_6 imports_11 mutated_1)
    ((letrec-values (((simple?_0)
                      (lambda (e_1 mutated_2)
                        (let-values (((v_18) e_1))
                          (if (if (pair? v_18)
                                (if (let-values (((a_39) (car v_18))) (equal? 'lambda a_39))
                                  (let-values (((d_32) (cdr v_18))) #t)
                                  #f)
                                #f)
                            (let-values () #t)
                            (if (if (pair? v_18)
                                  (if (let-values (((a_40) (car v_18))) (equal? 'case-lambda a_40))
                                    (let-values (((d_33) (cdr v_18))) #t)
                                    #f)
                                  #f)
                              (let-values () #t)
                              (if (if (pair? v_18)
                                    (if (let-values (((a_41) (car v_18))) (equal? 'quote a_41))
                                      (let-values (((d_34) (cdr v_18))) #t)
                                      #f)
                                    #f)
                                (let-values () #t)
                                (if (if (pair? v_18)
                                      (if (let-values (((a_42) (car v_18))) (equal? '#%variable-reference a_42))
                                        (let-values (((d_35) (cdr v_18))) #t)
                                        #f)
                                      #f)
                                  (let-values () #t)
                                  (if (if (pair? v_18)
                                        (if (let-values (((a_43) (car v_18))) (equal? 'let-values a_43))
                                          (let-values (((d_36) (cdr v_18)))
                                            (if (pair? d_36)
                                              (if (let-values (((a_44) (car d_36)))
                                                    (if (list? a_44)
                                                      (let-values (((lst_14) a_44))
                                                        (begin
                                                          (check-list lst_14)
                                                          ((letrec-values (((for-loop_7)
                                                                            (lambda (result_2 lst_15)
                                                                              (if (pair? lst_15)
                                                                                (let-values (((v_19)
                                                                                              (unsafe-car lst_15))
                                                                                             ((rest_7)
                                                                                              (unsafe-cdr lst_15)))
                                                                                  (let-values (((result_3)
                                                                                                (let-values ()
                                                                                                  (let-values (((result_4)
                                                                                                                (let-values ()
                                                                                                                  (let-values ()
                                                                                                                    (if (pair?
                                                                                                                         v_19)
                                                                                                                      (if (let-values (((a_45)
                                                                                                                                        (car
                                                                                                                                         v_19)))
                                                                                                                            #t)
                                                                                                                        (let-values (((d_37)
                                                                                                                                      (cdr
                                                                                                                                       v_19)))
                                                                                                                          (if (pair?
                                                                                                                               d_37)
                                                                                                                            (if (let-values (((a_46)
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
                                                                                                     result_4)))))
                                                                                    (if (if (not
                                                                                             ((lambda x_0
                                                                                                (not result_3))
                                                                                              v_19))
                                                                                          (not #f)
                                                                                          #f)
                                                                                      (for-loop_7 result_3 rest_7)
                                                                                      result_3)))
                                                                                result_2))))
                                                             for-loop_7)
                                                           #t
                                                           lst_14)))
                                                      #f))
                                                (let-values (((d_39) (cdr d_36)))
                                                  (if (pair? d_39)
                                                    (if (let-values (((a_47) (car d_39))) #t)
                                                      (let-values (((d_40) (cdr d_39))) (equal? '() d_40))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((rhss_0 body_2)
                                                  (let-values (((d_41) (cdr v_18)))
                                                    (let-values (((rhss_1)
                                                                  (let-values (((a_48) (car d_41)))
                                                                    (let-values (((rhss_2)
                                                                                  (let-values (((lst_16) a_48))
                                                                                    (begin
                                                                                      (check-list lst_16)
                                                                                      ((letrec-values (((for-loop_8)
                                                                                                        (lambda (rhss_3
                                                                                                                 lst_17)
                                                                                                          (if (pair?
                                                                                                               lst_17)
                                                                                                            (let-values (((v_20)
                                                                                                                          (unsafe-car
                                                                                                                           lst_17))
                                                                                                                         ((rest_8)
                                                                                                                          (unsafe-cdr
                                                                                                                           lst_17)))
                                                                                                              (let-values (((rhss_4)
                                                                                                                            (let-values (((rhss_5)
                                                                                                                                          rhss_3))
                                                                                                                              (let-values (((rhss_6)
                                                                                                                                            (let-values ()
                                                                                                                                              (let-values (((rhss6_0)
                                                                                                                                                            (let-values ()
                                                                                                                                                              (let-values (((d_42)
                                                                                                                                                                            (cdr
                                                                                                                                                                             v_20)))
                                                                                                                                                                (let-values (((a_49)
                                                                                                                                                                              (car
                                                                                                                                                                               d_42)))
                                                                                                                                                                  a_49)))))
                                                                                                                                                (cons
                                                                                                                                                 rhss6_0
                                                                                                                                                 rhss_5)))))
                                                                                                                                (values
                                                                                                                                 rhss_6)))))
                                                                                                                (if (not
                                                                                                                     #f)
                                                                                                                  (for-loop_8
                                                                                                                   rhss_4
                                                                                                                   rest_8)
                                                                                                                  rhss_4)))
                                                                                                            rhss_3))))
                                                                                         for-loop_8)
                                                                                       null
                                                                                       lst_16)))))
                                                                      (reverse$1 rhss_2))))
                                                                 ((body_3)
                                                                  (let-values (((d_43) (cdr d_41)))
                                                                    (let-values (((a_50) (car d_43))) a_50))))
                                                      (values rhss_1 body_3)))))
                                      (if (let-values (((lst_18) rhss_0))
                                            (begin
                                              (check-list lst_18)
                                              ((letrec-values (((for-loop_9)
                                                                (lambda (result_5 lst_19)
                                                                  (if (pair? lst_19)
                                                                    (let-values (((rhs_6) (unsafe-car lst_19))
                                                                                 ((rest_9) (unsafe-cdr lst_19)))
                                                                      (let-values (((result_6)
                                                                                    (let-values ()
                                                                                      (let-values (((result_7)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (simple?_0
                                                                                                         rhss_0
                                                                                                         mutated_2)))))
                                                                                        (values result_7)))))
                                                                        (if (if (not
                                                                                 ((lambda x_1 (not result_6)) rhs_6))
                                                                              (not #f)
                                                                              #f)
                                                                          (for-loop_9 result_6 rest_9)
                                                                          result_6)))
                                                                    result_5))))
                                                 for-loop_9)
                                               #t
                                               lst_18)))
                                        (simple?_0 body_2 mutated_2)
                                        #f))
                                    (if (if (pair? v_18)
                                          (if (let-values (((a_51) (car v_18))) (equal? 'let a_51))
                                            (let-values (((d_44) (cdr v_18)))
                                              (if (pair? d_44)
                                                (if (let-values (((a_52) (car d_44)))
                                                      (if (list? a_52)
                                                        (let-values (((lst_20) a_52))
                                                          (begin
                                                            (check-list lst_20)
                                                            ((letrec-values (((for-loop_10)
                                                                              (lambda (result_8 lst_21)
                                                                                (if (pair? lst_21)
                                                                                  (let-values (((v_21)
                                                                                                (unsafe-car lst_21))
                                                                                               ((rest_10)
                                                                                                (unsafe-cdr lst_21)))
                                                                                    (let-values (((result_9)
                                                                                                  (let-values ()
                                                                                                    (let-values (((result_10)
                                                                                                                  (let-values ()
                                                                                                                    (let-values ()
                                                                                                                      (if (pair?
                                                                                                                           v_21)
                                                                                                                        (if (let-values (((a_53)
                                                                                                                                          (car
                                                                                                                                           v_21)))
                                                                                                                              #t)
                                                                                                                          (let-values (((d_45)
                                                                                                                                        (cdr
                                                                                                                                         v_21)))
                                                                                                                            (if (pair?
                                                                                                                                 d_45)
                                                                                                                              (if (let-values (((a_54)
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
                                                                                                       result_10)))))
                                                                                      (if (if (not
                                                                                               ((lambda x_2
                                                                                                  (not result_9))
                                                                                                v_21))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_10 result_9 rest_10)
                                                                                        result_9)))
                                                                                  result_8))))
                                                               for-loop_10)
                                                             #t
                                                             lst_20)))
                                                        #f))
                                                  (let-values (((d_47) (cdr d_44)))
                                                    (if (pair? d_47)
                                                      (if (let-values (((a_55) (car d_47))) #t)
                                                        (let-values (((d_48) (cdr d_47))) (equal? '() d_48))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((rhss_7 body_4)
                                                    (let-values (((d_49) (cdr v_18)))
                                                      (let-values (((rhss_8)
                                                                    (let-values (((a_56) (car d_49)))
                                                                      (let-values (((rhss_9)
                                                                                    (let-values (((lst_22) a_56))
                                                                                      (begin
                                                                                        (check-list lst_22)
                                                                                        ((letrec-values (((for-loop_11)
                                                                                                          (lambda (rhss_10
                                                                                                                   lst_23)
                                                                                                            (if (pair?
                                                                                                                 lst_23)
                                                                                                              (let-values (((v_22)
                                                                                                                            (unsafe-car
                                                                                                                             lst_23))
                                                                                                                           ((rest_11)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_23)))
                                                                                                                (let-values (((rhss_11)
                                                                                                                              (let-values (((rhss_12)
                                                                                                                                            rhss_10))
                                                                                                                                (let-values (((rhss_13)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((rhss7_0)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((d_50)
                                                                                                                                                                              (cdr
                                                                                                                                                                               v_22)))
                                                                                                                                                                  (let-values (((a_57)
                                                                                                                                                                                (car
                                                                                                                                                                                 d_50)))
                                                                                                                                                                    a_57)))))
                                                                                                                                                  (cons
                                                                                                                                                   rhss7_0
                                                                                                                                                   rhss_12)))))
                                                                                                                                  (values
                                                                                                                                   rhss_13)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_11
                                                                                                                     rhss_11
                                                                                                                     rest_11)
                                                                                                                    rhss_11)))
                                                                                                              rhss_10))))
                                                                                           for-loop_11)
                                                                                         null
                                                                                         lst_22)))))
                                                                        (reverse$1 rhss_9))))
                                                                   ((body_5)
                                                                    (let-values (((d_51) (cdr d_49)))
                                                                      (let-values (((a_58) (car d_51))) a_58))))
                                                        (values rhss_8 body_5)))))
                                        (if (let-values (((lst_24) rhss_7))
                                              (begin
                                                (check-list lst_24)
                                                ((letrec-values (((for-loop_12)
                                                                  (lambda (result_11 lst_25)
                                                                    (if (pair? lst_25)
                                                                      (let-values (((rhs_7) (unsafe-car lst_25))
                                                                                   ((rest_12) (unsafe-cdr lst_25)))
                                                                        (let-values (((result_12)
                                                                                      (let-values ()
                                                                                        (let-values (((result_13)
                                                                                                      (let-values ()
                                                                                                        (let-values ()
                                                                                                          (simple?_0
                                                                                                           rhss_7
                                                                                                           mutated_2)))))
                                                                                          (values result_13)))))
                                                                          (if (if (not
                                                                                   ((lambda x_3 (not result_12)) rhs_7))
                                                                                (not #f)
                                                                                #f)
                                                                            (for-loop_12 result_12 rest_12)
                                                                            result_12)))
                                                                      result_11))))
                                                   for-loop_12)
                                                 #t
                                                 lst_24)))
                                          (simple?_0 body_4 mutated_2)
                                          #f))
                                      (if (if (pair? v_18)
                                            (if (let-values (((a_59) (car v_18))) (equal? 'letrec-values a_59))
                                              (let-values (((d_52) (cdr v_18)))
                                                (if (pair? d_52)
                                                  (if (let-values (((a_60) (car d_52)))
                                                        (if (list? a_60)
                                                          (let-values (((lst_26) a_60))
                                                            (begin
                                                              (check-list lst_26)
                                                              ((letrec-values (((for-loop_13)
                                                                                (lambda (result_14 lst_27)
                                                                                  (if (pair? lst_27)
                                                                                    (let-values (((v_23)
                                                                                                  (unsafe-car lst_27))
                                                                                                 ((rest_13)
                                                                                                  (unsafe-cdr lst_27)))
                                                                                      (let-values (((result_15)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_16)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (if (pair?
                                                                                                                             v_23)
                                                                                                                          (if (let-values (((a_61)
                                                                                                                                            (car
                                                                                                                                             v_23)))
                                                                                                                                (list?
                                                                                                                                 a_61))
                                                                                                                            (let-values (((d_53)
                                                                                                                                          (cdr
                                                                                                                                           v_23)))
                                                                                                                              (if (pair?
                                                                                                                                   d_53)
                                                                                                                                (if (let-values (((a_62)
                                                                                                                                                  (car
                                                                                                                                                   d_53)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_54)
                                                                                                                                                (cdr
                                                                                                                                                 d_53)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_54))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                            #f)
                                                                                                                          #f)))))
                                                                                                        (values
                                                                                                         result_16)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_4
                                                                                                    (not result_15))
                                                                                                  v_23))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_13
                                                                                           result_15
                                                                                           rest_13)
                                                                                          result_15)))
                                                                                    result_14))))
                                                                 for-loop_13)
                                                               #t
                                                               lst_26)))
                                                          #f))
                                                    (let-values (((d_55) (cdr d_52)))
                                                      (if (pair? d_55)
                                                        (if (let-values (((a_63) (car d_55))) #t)
                                                          (let-values (((d_56) (cdr d_55))) (equal? '() d_56))
                                                          #f)
                                                        #f))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((idss_0 rhss_14 body_6)
                                                      (let-values (((d_57) (cdr v_18)))
                                                        (let-values (((idss_1 rhss_15)
                                                                      (let-values (((a_64) (car d_57)))
                                                                        (let-values (((idss_2 rhss_16)
                                                                                      (let-values (((lst_28) a_64))
                                                                                        (begin
                                                                                          (check-list lst_28)
                                                                                          ((letrec-values (((for-loop_14)
                                                                                                            (lambda (idss_3
                                                                                                                     rhss_17
                                                                                                                     lst_29)
                                                                                                              (if (pair?
                                                                                                                   lst_29)
                                                                                                                (let-values (((v_24)
                                                                                                                              (unsafe-car
                                                                                                                               lst_29))
                                                                                                                             ((rest_14)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_29)))
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
                                                                                                                                                                                (let-values (((a_65)
                                                                                                                                                                                              (car
                                                                                                                                                                                               v_24)))
                                                                                                                                                                                  a_65))
                                                                                                                                                                               ((rhss_21)
                                                                                                                                                                                (let-values (((d_58)
                                                                                                                                                                                              (cdr
                                                                                                                                                                                               v_24)))
                                                                                                                                                                                  (let-values (((a_66)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 d_58)))
                                                                                                                                                                                    a_66))))
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
                                                                                                                      (for-loop_14
                                                                                                                       idss_4
                                                                                                                       rhss_18
                                                                                                                       rest_14)
                                                                                                                      (values
                                                                                                                       idss_4
                                                                                                                       rhss_18))))
                                                                                                                (values
                                                                                                                 idss_3
                                                                                                                 rhss_17)))))
                                                                                             for-loop_14)
                                                                                           null
                                                                                           null
                                                                                           lst_28)))))
                                                                          (values
                                                                           (reverse$1 idss_2)
                                                                           (reverse$1 rhss_16)))))
                                                                     ((body_7)
                                                                      (let-values (((d_59) (cdr d_57)))
                                                                        (let-values (((a_67) (car d_59))) a_67))))
                                                          (values idss_1 rhss_15 body_7)))))
                                          (let-values (((mutated+idss_0)
                                                        (let-values (((lst_30) idss_0))
                                                          (begin
                                                            (check-list lst_30)
                                                            ((letrec-values (((for-loop_15)
                                                                              (lambda (mutated_3 lst_31)
                                                                                (if (pair? lst_31)
                                                                                  (let-values (((ids_0)
                                                                                                (unsafe-car lst_31))
                                                                                               ((rest_15)
                                                                                                (unsafe-cdr lst_31)))
                                                                                    (let-values (((mutated_4)
                                                                                                  (let-values (((lst_32)
                                                                                                                ids_0))
                                                                                                    (begin
                                                                                                      (check-list
                                                                                                       lst_32)
                                                                                                      ((letrec-values (((for-loop_16)
                                                                                                                        (lambda (mutated_5
                                                                                                                                 lst_33)
                                                                                                                          (if (pair?
                                                                                                                               lst_33)
                                                                                                                            (let-values (((id_3)
                                                                                                                                          (unsafe-car
                                                                                                                                           lst_33))
                                                                                                                                         ((rest_16)
                                                                                                                                          (unsafe-cdr
                                                                                                                                           lst_33)))
                                                                                                                              (let-values (((mutated_6)
                                                                                                                                            (let-values (((mutated_7)
                                                                                                                                                          mutated_5))
                                                                                                                                              (let-values (((mutated_8)
                                                                                                                                                            (let-values ()
                                                                                                                                                              (hash-set
                                                                                                                                                               mutated_7
                                                                                                                                                               id_3
                                                                                                                                                               #t))))
                                                                                                                                                (values
                                                                                                                                                 mutated_8)))))
                                                                                                                                (if (not
                                                                                                                                     #f)
                                                                                                                                  (for-loop_16
                                                                                                                                   mutated_6
                                                                                                                                   rest_16)
                                                                                                                                  mutated_6)))
                                                                                                                            mutated_5))))
                                                                                                         for-loop_16)
                                                                                                       mutated_3
                                                                                                       lst_32)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_15 mutated_4 rest_15)
                                                                                        mutated_4)))
                                                                                  mutated_3))))
                                                               for-loop_15)
                                                             mutated_2
                                                             lst_30)))))
                                            (if (let-values (((lst_34) rhss_14))
                                                  (begin
                                                    (check-list lst_34)
                                                    ((letrec-values (((for-loop_17)
                                                                      (lambda (result_17 lst_35)
                                                                        (if (pair? lst_35)
                                                                          (let-values (((rhs_8) (unsafe-car lst_35))
                                                                                       ((rest_17) (unsafe-cdr lst_35)))
                                                                            (let-values (((result_18)
                                                                                          (let-values ()
                                                                                            (let-values (((result_19)
                                                                                                          (let-values ()
                                                                                                            (let-values ()
                                                                                                              (simple?_0
                                                                                                               rhs_8
                                                                                                               mutated+idss_0)))))
                                                                                              (values result_19)))))
                                                                              (if (if (not
                                                                                       ((lambda x_5 (not result_18))
                                                                                        rhs_8))
                                                                                    (not #f)
                                                                                    #f)
                                                                                (for-loop_17 result_18 rest_17)
                                                                                result_18)))
                                                                          result_17))))
                                                       for-loop_17)
                                                     #t
                                                     lst_34)))
                                              (simple?_0 body_6 mutated_2)
                                              #f)))
                                        (if (if (pair? v_18)
                                              (if (let-values (((a_68) (car v_18))) (equal? 'letrec* a_68))
                                                (let-values (((d_60) (cdr v_18)))
                                                  (if (pair? d_60)
                                                    (if (let-values (((a_69) (car d_60)))
                                                          (if (list? a_69)
                                                            (let-values (((lst_36) a_69))
                                                              (begin
                                                                (check-list lst_36)
                                                                ((letrec-values (((for-loop_18)
                                                                                  (lambda (result_20 lst_37)
                                                                                    (if (pair? lst_37)
                                                                                      (let-values (((v_25)
                                                                                                    (unsafe-car lst_37))
                                                                                                   ((rest_18)
                                                                                                    (unsafe-cdr
                                                                                                     lst_37)))
                                                                                        (let-values (((result_21)
                                                                                                      (let-values ()
                                                                                                        (let-values (((result_22)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (if (pair?
                                                                                                                               v_25)
                                                                                                                            (if (let-values (((a_70)
                                                                                                                                              (car
                                                                                                                                               v_25)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_61)
                                                                                                                                            (cdr
                                                                                                                                             v_25)))
                                                                                                                                (if (pair?
                                                                                                                                     d_61)
                                                                                                                                  (if (let-values (((a_71)
                                                                                                                                                    (car
                                                                                                                                                     d_61)))
                                                                                                                                        #t)
                                                                                                                                    (let-values (((d_62)
                                                                                                                                                  (cdr
                                                                                                                                                   d_61)))
                                                                                                                                      (equal?
                                                                                                                                       '()
                                                                                                                                       d_62))
                                                                                                                                    #f)
                                                                                                                                  #f))
                                                                                                                              #f)
                                                                                                                            #f)))))
                                                                                                          (values
                                                                                                           result_22)))))
                                                                                          (if (if (not
                                                                                                   ((lambda x_6
                                                                                                      (not result_21))
                                                                                                    v_25))
                                                                                                (not #f)
                                                                                                #f)
                                                                                            (for-loop_18
                                                                                             result_21
                                                                                             rest_18)
                                                                                            result_21)))
                                                                                      result_20))))
                                                                   for-loop_18)
                                                                 #t
                                                                 lst_36)))
                                                            #f))
                                                      (let-values (((d_63) (cdr d_60)))
                                                        (if (pair? d_63)
                                                          (if (let-values (((a_72) (car d_63))) #t)
                                                            (let-values (((d_64) (cdr d_63))) (equal? '() d_64))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((ids_1 rhss_22 body_8)
                                                        (let-values (((d_65) (cdr v_18)))
                                                          (let-values (((ids_2 rhss_23)
                                                                        (let-values (((a_73) (car d_65)))
                                                                          (let-values (((ids_3 rhss_24)
                                                                                        (let-values (((lst_38) a_73))
                                                                                          (begin
                                                                                            (check-list lst_38)
                                                                                            ((letrec-values (((for-loop_19)
                                                                                                              (lambda (ids_4
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
                                                                                                                    (let-values (((ids_5
                                                                                                                                   rhss_26)
                                                                                                                                  (let-values (((ids_6)
                                                                                                                                                ids_4)
                                                                                                                                               ((rhss_27)
                                                                                                                                                rhss_25))
                                                                                                                                    (let-values (((ids_7
                                                                                                                                                   rhss_28)
                                                                                                                                                  (let-values ()
                                                                                                                                                    (let-values (((ids10_0
                                                                                                                                                                   rhss11_0)
                                                                                                                                                                  (let-values ()
                                                                                                                                                                    (let-values (((ids_8)
                                                                                                                                                                                  (let-values (((a_74)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 v_26)))
                                                                                                                                                                                    a_74))
                                                                                                                                                                                 ((rhss_29)
                                                                                                                                                                                  (let-values (((d_66)
                                                                                                                                                                                                (cdr
                                                                                                                                                                                                 v_26)))
                                                                                                                                                                                    (let-values (((a_75)
                                                                                                                                                                                                  (car
                                                                                                                                                                                                   d_66)))
                                                                                                                                                                                      a_75))))
                                                                                                                                                                      (values
                                                                                                                                                                       ids_8
                                                                                                                                                                       rhss_29)))))
                                                                                                                                                      (values
                                                                                                                                                       (cons
                                                                                                                                                        ids10_0
                                                                                                                                                        ids_6)
                                                                                                                                                       (cons
                                                                                                                                                        rhss11_0
                                                                                                                                                        rhss_27))))))
                                                                                                                                      (values
                                                                                                                                       ids_7
                                                                                                                                       rhss_28)))))
                                                                                                                      (if (not
                                                                                                                           #f)
                                                                                                                        (for-loop_19
                                                                                                                         ids_5
                                                                                                                         rhss_26
                                                                                                                         rest_19)
                                                                                                                        (values
                                                                                                                         ids_5
                                                                                                                         rhss_26))))
                                                                                                                  (values
                                                                                                                   ids_4
                                                                                                                   rhss_25)))))
                                                                                               for-loop_19)
                                                                                             null
                                                                                             null
                                                                                             lst_38)))))
                                                                            (values
                                                                             (reverse$1 ids_3)
                                                                             (reverse$1 rhss_24)))))
                                                                       ((body_9)
                                                                        (let-values (((d_67) (cdr d_65)))
                                                                          (let-values (((a_76) (car d_67))) a_76))))
                                                            (values ids_2 rhss_23 body_9)))))
                                            (let-values (((mutated+ids_0)
                                                          (let-values (((lst_40) ids_1))
                                                            (begin
                                                              (check-list lst_40)
                                                              ((letrec-values (((for-loop_20)
                                                                                (lambda (mutated_9 lst_41)
                                                                                  (if (pair? lst_41)
                                                                                    (let-values (((id_4)
                                                                                                  (unsafe-car lst_41))
                                                                                                 ((rest_20)
                                                                                                  (unsafe-cdr lst_41)))
                                                                                      (let-values (((mutated_10)
                                                                                                    (let-values (((mutated_11)
                                                                                                                  mutated_9))
                                                                                                      (let-values (((mutated_12)
                                                                                                                    (let-values ()
                                                                                                                      (hash-set
                                                                                                                       mutated_11
                                                                                                                       id_4
                                                                                                                       #t))))
                                                                                                        (values
                                                                                                         mutated_12)))))
                                                                                        (if (not #f)
                                                                                          (for-loop_20
                                                                                           mutated_10
                                                                                           rest_20)
                                                                                          mutated_10)))
                                                                                    mutated_9))))
                                                                 for-loop_20)
                                                               mutated_2
                                                               lst_40)))))
                                              (if (let-values (((lst_42) rhss_22))
                                                    (begin
                                                      (check-list lst_42)
                                                      ((letrec-values (((for-loop_21)
                                                                        (lambda (result_23 lst_43)
                                                                          (if (pair? lst_43)
                                                                            (let-values (((rhs_9) (unsafe-car lst_43))
                                                                                         ((rest_21)
                                                                                          (unsafe-cdr lst_43)))
                                                                              (let-values (((result_24)
                                                                                            (let-values ()
                                                                                              (let-values (((result_25)
                                                                                                            (let-values ()
                                                                                                              (let-values ()
                                                                                                                (simple?_0
                                                                                                                 rhs_9
                                                                                                                 mutated+ids_0)))))
                                                                                                (values result_25)))))
                                                                                (if (if (not
                                                                                         ((lambda x_7 (not result_24))
                                                                                          rhs_9))
                                                                                      (not #f)
                                                                                      #f)
                                                                                  (for-loop_21 result_24 rest_21)
                                                                                  result_24)))
                                                                            result_23))))
                                                         for-loop_21)
                                                       #t
                                                       lst_42)))
                                                (simple?_0 body_8 mutated_2)
                                                #f)))
                                          (if (if (pair? v_18)
                                                (if (let-values (((a_77) (car v_18))) #t)
                                                  (let-values (((d_68) (cdr v_18)))
                                                    (if (pair? d_68)
                                                      (if (let-values (((a_78) (car d_68))) #t)
                                                        (let-values (((d_69) (cdr d_68))) (equal? '() d_69))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((proc_0 arg_0)
                                                          (let-values (((proc_1)
                                                                        (let-values (((a_79) (car v_18))) a_79))
                                                                       ((arg_1)
                                                                        (let-values (((d_70) (cdr v_18)))
                                                                          (let-values (((a_80) (car d_70))) a_80))))
                                                            (values proc_1 arg_1))))
                                              (if (symbol? proc_0)
                                                (if (let-values (((v_27) (hash-ref-either knowns_6 imports_11 proc_0)))
                                                      (if v_27
                                                        (let-values (((or-part_1) (known-predicate? v_27)))
                                                          (if or-part_1
                                                            or-part_1
                                                            (if (known-constructor? v_27)
                                                              (= 1 (known-constructor-field-count v_27))
                                                              #f)))
                                                        #f))
                                                  (simple?_0 arg_0 mutated_2)
                                                  #f)
                                                #f))
                                            (if (if (pair? v_18)
                                                  (if (let-values (((a_81) (car v_18))) #t)
                                                    (let-values (((d_71) (cdr v_18))) #t)
                                                    #f)
                                                  #f)
                                              (let-values (((proc_2 args_2)
                                                            (let-values (((proc_3)
                                                                          (let-values (((a_82) (car v_18))) a_82))
                                                                         ((args_3)
                                                                          (let-values (((d_72) (cdr v_18))) d_72)))
                                                              (values proc_3 args_3))))
                                                (if (symbol? proc_2)
                                                  (if (let-values (((v_28)
                                                                    (hash-ref-either knowns_6 imports_11 proc_2)))
                                                        (if (known-constructor? v_28)
                                                          (= (length args_2) (known-constructor-field-count v_28))
                                                          #f))
                                                    (let-values (((lst_44) args_2))
                                                      (begin
                                                        (check-list lst_44)
                                                        ((letrec-values (((for-loop_22)
                                                                          (lambda (result_26 lst_45)
                                                                            (if (pair? lst_45)
                                                                              (let-values (((arg_2) (unsafe-car lst_45))
                                                                                           ((rest_22)
                                                                                            (unsafe-cdr lst_45)))
                                                                                (let-values (((result_27)
                                                                                              (let-values ()
                                                                                                (let-values (((result_28)
                                                                                                              (let-values ()
                                                                                                                (let-values ()
                                                                                                                  (simple?_0
                                                                                                                   arg_2
                                                                                                                   mutated_2)))))
                                                                                                  (values result_28)))))
                                                                                  (if (if (not
                                                                                           ((lambda x_8 (not result_27))
                                                                                            arg_2))
                                                                                        (not #f)
                                                                                        #f)
                                                                                    (for-loop_22 result_27 rest_22)
                                                                                    result_27)))
                                                                              result_26))))
                                                           for-loop_22)
                                                         #t
                                                         lst_44)))
                                                    #f)
                                                  #f))
                                              (let-values ()
                                                (let-values (((or-part_2)
                                                              (if (symbol? e_1) (not (hash-ref mutated_2 e_1 #f)) #f)))
                                                  (if or-part_2
                                                    or-part_2
                                                    (let-values (((or-part_3) (integer? e_1)))
                                                      (if or-part_3
                                                        or-part_3
                                                        (let-values (((or-part_4) (boolean? e_1)))
                                                          (if or-part_4
                                                            or-part_4
                                                            (let-values (((or-part_5) (string? e_1)))
                                                              (if or-part_5
                                                                or-part_5
                                                                (let-values (((or-part_6) (bytes? e_1)))
                                                                  (if or-part_6
                                                                    or-part_6
                                                                    (regexp? e_1))))))))))))))))))))))))))
       simple?_0)
     e_0
     mutated_1)))
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
  (let-values (((struct:_8 make-_8 ?_8 -ref_8 -set!_8)
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
     struct:_8
     make-_8
     ?_8
     (make-struct-field-accessor -ref_8 0 'name)
     (make-struct-field-accessor -ref_8 1 'parent)
     (make-struct-field-accessor -ref_8 2 'immediate-field-count)
     (make-struct-field-accessor -ref_8 3 'field-count)
     (make-struct-field-accessor -ref_8 4 'pure-constructor?)
     (make-struct-field-accessor -ref_8 5 'rest))))
 (define-values
  (hash-ref-either)
  (lambda (knowns_7 imports_12 key_0)
    (let-values (((or-part_7) (hash-ref knowns_7 key_0 #f)))
      (if or-part_7
        or-part_7
        (let-values (((im_2) (hash-ref imports_12 key_0 #f)))
          (if im_2 (hash-ref (import-group-knowns (import-grp im_2)) (import-ext-id im_2) #f) #f))))))
 (define-values
  (make-struct-type-info)
  (lambda (v_29 knowns_8 imports_13)
    (let-values (((v_30) v_29))
      (if (if (pair? v_30)
            (if (let-values (((a_83) (car v_30))) (equal? 'make-struct-type a_83))
              (let-values (((d_73) (cdr v_30)))
                (if (pair? d_73)
                  (if (let-values (((a_84) (car d_73)))
                        (if (pair? a_84)
                          (if (let-values (((a_85) (car a_84))) (equal? 'quote a_85))
                            (let-values (((d_74) (cdr a_84)))
                              (if (pair? d_74)
                                (if (let-values (((a_86) (car d_74))) #t)
                                  (let-values (((d_75) (cdr d_74))) (equal? '() d_75))
                                  #f)
                                #f))
                            #f)
                          #f))
                    (let-values (((d_76) (cdr d_73)))
                      (if (pair? d_76)
                        (if (let-values (((a_87) (car d_76))) #t)
                          (let-values (((d_77) (cdr d_76)))
                            (if (pair? d_77)
                              (if (let-values (((a_88) (car d_77))) #t)
                                (let-values (((d_78) (cdr d_77)))
                                  (if (pair? d_78)
                                    (if (let-values (((a_89) (car d_78))) (equal? 0 a_89))
                                      (let-values (((d_79) (cdr d_78)))
                                        (if (pair? d_79)
                                          (if (let-values (((a_90) (car d_79))) (equal? #f a_90))
                                            (let-values (((d_80) (cdr d_79))) #t)
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
        (let-values (((name_1 parent_0 fields_0 rest_23)
                      (let-values (((d_81) (cdr v_30)))
                        (let-values (((name_2)
                                      (let-values (((a_91) (car d_81)))
                                        (let-values (((d_82) (cdr a_91))) (let-values (((a_92) (car d_82))) a_92))))
                                     ((parent_1 fields_1 rest_24)
                                      (let-values (((d_83) (cdr d_81)))
                                        (let-values (((parent_2) (let-values (((a_93) (car d_83))) a_93))
                                                     ((fields_2 rest_25)
                                                      (let-values (((d_84) (cdr d_83)))
                                                        (let-values (((fields_3)
                                                                      (let-values (((a_94) (car d_84))) a_94))
                                                                     ((rest_26)
                                                                      (let-values (((d_85) (cdr d_84)))
                                                                        (let-values (((d_86) (cdr d_85)))
                                                                          (let-values (((d_87) (cdr d_86))) d_87)))))
                                                          (values fields_3 rest_26)))))
                                          (values parent_2 fields_2 rest_25)))))
                          (values name_2 parent_1 fields_1 rest_24)))))
          (if (symbol? name_1)
            (if (let-values (((or-part_8) (not parent_0)))
                  (if or-part_8 or-part_8 (known-struct-type? (hash-ref-either knowns_8 imports_13 parent_0))))
              (if (exact-nonnegative-integer? fields_0)
                (struct-type-info3.1
                 name_1
                 parent_0
                 fields_0
                 (+
                  fields_0
                  (if parent_0 (known-struct-type-field-count (hash-ref-either knowns_8 imports_13 parent_0)) 0))
                 (let-values (((or-part_9) (< (length rest_23) 4))) (if or-part_9 or-part_9 (not (list-ref rest_23 3))))
                 rest_23)
                #f)
              #f)
            #f))
        (if (if (pair? v_30)
              (if (let-values (((a_95) (car v_30))) (equal? 'let-values a_95))
                (let-values (((d_88) (cdr v_30)))
                  (if (pair? d_88)
                    (if (let-values (((a_96) (car d_88))) (equal? '() a_96))
                      (let-values (((d_89) (cdr d_88)))
                        (if (pair? d_89)
                          (if (let-values (((a_97) (car d_89))) #t)
                            (let-values (((d_90) (cdr d_89))) (equal? '() d_90))
                            #f)
                          #f))
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((body_10)
                        (let-values (((d_91) (cdr v_30)))
                          (let-values (((d_92) (cdr d_91))) (let-values (((a_98) (car d_92))) a_98)))))
            (make-struct-type-info body_10 knowns_8 imports_13))
          (let-values () #f))))))
 (define-values
  (find-definitions)
  (lambda (v_31 prim-knowns_4 knowns_9 imports_14 mutated_13 last?_0)
    (let-values (((v_32) v_31))
      (if (if (pair? v_32)
            (if (let-values (((a_99) (car v_32))) (equal? 'define-values a_99))
              (let-values (((d_93) (cdr v_32)))
                (if (pair? d_93)
                  (if (let-values (((a_100) (car d_93)))
                        (if (pair? a_100)
                          (if (let-values (((a_101) (car a_100))) #t)
                            (let-values (((d_94) (cdr a_100))) (equal? '() d_94))
                            #f)
                          #f))
                    (let-values (((d_95) (cdr d_93)))
                      (if (pair? d_95)
                        (if (let-values (((a_102) (car d_95))) #t)
                          (let-values (((d_96) (cdr d_95))) (equal? '() d_96))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((id_5 rhs_10)
                      (let-values (((d_97) (cdr v_32)))
                        (let-values (((id_6)
                                      (let-values (((a_103) (car d_97))) (let-values (((a_104) (car a_103))) a_104)))
                                     ((rhs_11)
                                      (let-values (((d_98) (cdr d_97))) (let-values (((a_105) (car d_98))) a_105))))
                          (values id_6 rhs_11)))))
          (if (lambda? rhs_10)
            (let-values () (values v_31 (hash-set knowns_9 id_5 a-known-procedure) #f #t))
            (if (simple? rhs_10 prim-knowns_4 knowns_9 imports_14 mutated_13)
              (let-values () (values v_31 (hash-set knowns_9 id_5 a-known-unknown) #f #t))
              (let-values () (values v_31 knowns_9 #t #t)))))
        (if (if (pair? v_32)
              (if (let-values (((a_106) (car v_32))) (equal? 'define-values a_106))
                (let-values (((d_99) (cdr v_32)))
                  (if (pair? d_99)
                    (if (let-values (((a_107) (car d_99)))
                          (if (pair? a_107)
                            (if (let-values (((a_108) (car a_107))) #t)
                              (let-values (((d_100) (cdr a_107)))
                                (if (pair? d_100)
                                  (if (let-values (((a_109) (car d_100))) #t)
                                    (let-values (((d_101) (cdr d_100)))
                                      (if (pair? d_101)
                                        (if (let-values (((a_110) (car d_101))) #t)
                                          (let-values (((d_102) (cdr d_101))) (list? d_102))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                              #f)
                            #f))
                      (let-values (((d_103) (cdr d_99)))
                        (if (pair? d_103)
                          (if (let-values (((a_111) (car d_103)))
                                (if (pair? a_111)
                                  (if (let-values (((a_112) (car a_111))) (equal? 'let-values a_112))
                                    (let-values (((d_104) (cdr a_111)))
                                      (if (pair? d_104)
                                        (if (let-values (((a_113) (car d_104)))
                                              (if (pair? a_113)
                                                (if (let-values (((a_114) (car a_113)))
                                                      (if (pair? a_114)
                                                        (if (let-values (((a_115) (car a_114)))
                                                              (if (pair? a_115)
                                                                (if (let-values (((a_116) (car a_115))) #t)
                                                                  (let-values (((d_105) (cdr a_115)))
                                                                    (if (pair? d_105)
                                                                      (if (let-values (((a_117) (car d_105))) #t)
                                                                        (let-values (((d_106) (cdr d_105)))
                                                                          (if (pair? d_106)
                                                                            (if (let-values (((a_118) (car d_106))) #t)
                                                                              (let-values (((d_107) (cdr d_106)))
                                                                                (if (pair? d_107)
                                                                                  (if (let-values (((a_119)
                                                                                                    (car d_107)))
                                                                                        #t)
                                                                                    (let-values (((d_108) (cdr d_107)))
                                                                                      (if (pair? d_108)
                                                                                        (if (let-values (((a_120)
                                                                                                          (car d_108)))
                                                                                              #t)
                                                                                          (let-values (((d_109)
                                                                                                        (cdr d_108)))
                                                                                            (equal? '() d_109))
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
                                                          (let-values (((d_110) (cdr a_114)))
                                                            (if (pair? d_110)
                                                              (if (let-values (((a_121) (car d_110))) #t)
                                                                (let-values (((d_111) (cdr d_110))) (equal? '() d_111))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f))
                                                  (let-values (((d_112) (cdr a_113))) (equal? '() d_112))
                                                  #f)
                                                #f))
                                          (let-values (((d_113) (cdr d_104)))
                                            (if (pair? d_113)
                                              (if (let-values (((a_122) (car d_113)))
                                                    (if (pair? a_122)
                                                      (if (let-values (((a_123) (car a_122))) (equal? 'values a_123))
                                                        (let-values (((d_114) (cdr a_122)))
                                                          (if (pair? d_114)
                                                            (if (let-values (((a_124) (car d_114))) #t)
                                                              (let-values (((d_115) (cdr d_114)))
                                                                (if (pair? d_115)
                                                                  (if (let-values (((a_125) (car d_115))) #t)
                                                                    (let-values (((d_116) (cdr d_115)))
                                                                      (if (pair? d_116)
                                                                        (if (let-values (((a_126) (car d_116))) #t)
                                                                          (let-values (((d_117) (cdr d_116)))
                                                                            (list? d_117))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                (let-values (((d_118) (cdr d_113))) (equal? '() d_118))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_119) (cdr d_103))) (equal? '() d_119))
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
                         rhs_12
                         struct:2_0
                         make2_0
                         ?2_0
                         make-acc/muts_0)
                        (let-values (((d_120) (cdr v_32)))
                          (let-values (((struct:s_1 make-s_1 s?_1 acc/muts_1)
                                        (let-values (((a_127) (car d_120)))
                                          (let-values (((struct:s_2) (let-values (((a_128) (car a_127))) a_128))
                                                       ((make-s_2 s?_2 acc/muts_2)
                                                        (let-values (((d_121) (cdr a_127)))
                                                          (let-values (((make-s_3)
                                                                        (let-values (((a_129) (car d_121))) a_129))
                                                                       ((s?_3 acc/muts_3)
                                                                        (let-values (((d_122) (cdr d_121)))
                                                                          (let-values (((s?_4)
                                                                                        (let-values (((a_130)
                                                                                                      (car d_122)))
                                                                                          a_130))
                                                                                       ((acc/muts_4)
                                                                                        (let-values (((d_123)
                                                                                                      (cdr d_122)))
                                                                                          d_123)))
                                                                            (values s?_4 acc/muts_4)))))
                                                            (values make-s_3 s?_3 acc/muts_3)))))
                                            (values struct:s_2 make-s_2 s?_2 acc/muts_2))))
                                       ((struct:_10
                                         make_1
                                         ?_10
                                         -ref_10
                                         -set!_10
                                         rhs_13
                                         struct:2_1
                                         make2_1
                                         ?2_1
                                         make-acc/muts_1)
                                        (let-values (((d_124) (cdr d_120)))
                                          (let-values (((a_131) (car d_124)))
                                            (let-values (((d_125) (cdr a_131)))
                                              (let-values (((struct:_11 make_2 ?_11 -ref_11 -set!_11 rhs_14)
                                                            (let-values (((a_132) (car d_125)))
                                                              (let-values (((a_133) (car a_132)))
                                                                (let-values (((struct:_12 make_3 ?_12 -ref_12 -set!_12)
                                                                              (let-values (((a_134) (car a_133)))
                                                                                (let-values (((struct:_13)
                                                                                              (let-values (((a_135)
                                                                                                            (car
                                                                                                             a_134)))
                                                                                                a_135))
                                                                                             ((make_4
                                                                                               ?_13
                                                                                               -ref_13
                                                                                               -set!_13)
                                                                                              (let-values (((d_126)
                                                                                                            (cdr
                                                                                                             a_134)))
                                                                                                (let-values (((make_5)
                                                                                                              (let-values (((a_136)
                                                                                                                            (car
                                                                                                                             d_126)))
                                                                                                                a_136))
                                                                                                             ((?_14
                                                                                                               -ref_14
                                                                                                               -set!_14)
                                                                                                              (let-values (((d_127)
                                                                                                                            (cdr
                                                                                                                             d_126)))
                                                                                                                (let-values (((?_15)
                                                                                                                              (let-values (((a_137)
                                                                                                                                            (car
                                                                                                                                             d_127)))
                                                                                                                                a_137))
                                                                                                                             ((-ref_15
                                                                                                                               -set!_15)
                                                                                                                              (let-values (((d_128)
                                                                                                                                            (cdr
                                                                                                                                             d_127)))
                                                                                                                                (let-values (((-ref_16)
                                                                                                                                              (let-values (((a_138)
                                                                                                                                                            (car
                                                                                                                                                             d_128)))
                                                                                                                                                a_138))
                                                                                                                                             ((-set!_16)
                                                                                                                                              (let-values (((d_129)
                                                                                                                                                            (cdr
                                                                                                                                                             d_128)))
                                                                                                                                                (let-values (((a_139)
                                                                                                                                                              (car
                                                                                                                                                               d_129)))
                                                                                                                                                  a_139))))
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
                                                                             ((rhs_15)
                                                                              (let-values (((d_130) (cdr a_133)))
                                                                                (let-values (((a_140) (car d_130)))
                                                                                  a_140))))
                                                                  (values
                                                                   struct:_12
                                                                   make_3
                                                                   ?_12
                                                                   -ref_12
                                                                   -set!_12
                                                                   rhs_15)))))
                                                           ((struct:2_2 make2_2 ?2_2 make-acc/muts_2)
                                                            (let-values (((d_131) (cdr d_125)))
                                                              (let-values (((a_141) (car d_131)))
                                                                (let-values (((d_132) (cdr a_141)))
                                                                  (let-values (((struct:2_3)
                                                                                (let-values (((a_142) (car d_132)))
                                                                                  a_142))
                                                                               ((make2_3 ?2_3 make-acc/muts_3)
                                                                                (let-values (((d_133) (cdr d_132)))
                                                                                  (let-values (((make2_4)
                                                                                                (let-values (((a_143)
                                                                                                              (car
                                                                                                               d_133)))
                                                                                                  a_143))
                                                                                               ((?2_4 make-acc/muts_4)
                                                                                                (let-values (((d_134)
                                                                                                              (cdr
                                                                                                               d_133)))
                                                                                                  (let-values (((?2_5)
                                                                                                                (let-values (((a_144)
                                                                                                                              (car
                                                                                                                               d_134)))
                                                                                                                  a_144))
                                                                                                               ((make-acc/muts_5)
                                                                                                                (let-values (((d_135)
                                                                                                                              (cdr
                                                                                                                               d_134)))
                                                                                                                  d_135)))
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
                             struct:_10
                             make_1
                             ?_10
                             -ref_10
                             -set!_10
                             rhs_13
                             struct:2_1
                             make2_1
                             ?2_1
                             make-acc/muts_1)))))
            (let-values (((info_0)
                          (if (eq? struct:_9 struct:2_0)
                            (if (eq? make_0 make2_0)
                              (if (eq? ?_9 ?2_0) (make-struct-type-info rhs_12 knowns_9 imports_14) #f)
                              #f)
                            #f)))
              (if info_0
                (let-values ()
                  (let-values (((type_0) (gensym (symbol->string make-s_0))))
                    (values
                     v_31
                     (let-values (((knowns_10)
                                   (hash-set
                                    knowns_9
                                    make-s_0
                                    (if (struct-type-info-pure-constructor? info_0)
                                      (known-constructor type_0 (struct-type-info-field-count info_0))
                                      a-known-procedure))))
                       (let-values (((knowns_11) (hash-set knowns_10 s?_0 (known-predicate type_0))))
                         (let-values (((knowns_12)
                                       (let-values (((lst_46) acc/muts_0) ((lst_47) make-acc/muts_0))
                                         (begin
                                           (check-list lst_46)
                                           (check-list lst_47)
                                           ((letrec-values (((for-loop_23)
                                                             (lambda (knowns_13 lst_48 lst_49)
                                                               (if (if (pair? lst_48) (pair? lst_49) #f)
                                                                 (let-values (((id_7) (unsafe-car lst_48))
                                                                              ((rest_27) (unsafe-cdr lst_48))
                                                                              ((maker_0) (unsafe-car lst_49))
                                                                              ((rest_28) (unsafe-cdr lst_49)))
                                                                   (let-values (((knowns_14)
                                                                                 (let-values (((knowns_15) knowns_13))
                                                                                   (let-values (((knowns_16)
                                                                                                 (let-values ()
                                                                                                   (if (eq?
                                                                                                        (car maker_0)
                                                                                                        -ref_9)
                                                                                                     (let-values ()
                                                                                                       (hash-set
                                                                                                        knowns_15
                                                                                                        id_7
                                                                                                        (known-accessor
                                                                                                         type_0)))
                                                                                                     (let-values ()
                                                                                                       (hash-set
                                                                                                        knowns_15
                                                                                                        id_7
                                                                                                        (known-mutator
                                                                                                         type_0)))))))
                                                                                     (values knowns_16)))))
                                                                     (if (not #f)
                                                                       (for-loop_23 knowns_14 rest_27 rest_28)
                                                                       knowns_14)))
                                                                 knowns_13))))
                                              for-loop_23)
                                            knowns_11
                                            lst_46
                                            lst_47)))))
                           (hash-set
                            knowns_12
                            struct:s_0
                            (known-struct-type type_0 (struct-type-info-field-count info_0))))))
                     #f
                     #t)))
                (let-values () (values v_31 knowns_9 #t #t)))))
          (if (if (pair? v_32)
                (if (let-values (((a_145) (car v_32))) (equal? 'define-values a_145))
                  (let-values (((d_136) (cdr v_32))) #t)
                  #f)
                #f)
            (let-values () (values v_31 knowns_9 #t #t))
            (let-values ()
              (values
               (if last?_0 v_31 (list 'define-values (list (gensym)) (list* 'begin v_31 '((void)))))
               knowns_9
               #t
               #f))))))))
 (define-values
  (left-to-right/let)
  (lambda (v_33 prim-knowns_5 knowns_17 imports_15 mutated_14)
    (let-values (((v_34) v_33))
      (if (if (pair? v_34)
            (if (let-values (((a_146) (car v_34))) (equal? 'let a_146))
              (let-values (((d_137) (cdr v_34)))
                (if (pair? d_137)
                  (if (let-values (((a_147) (car d_137)))
                        (if (pair? a_147)
                          (if (let-values (((a_148) (car a_147))) #t)
                            (let-values (((d_138) (cdr a_147))) (equal? '() d_138))
                            #f)
                          #f))
                    (let-values (((d_139) (cdr d_137))) #t)
                    #f)
                  #f))
              #f)
            #f)
        (let-values () v_33)
        (if (if (pair? v_34)
              (if (let-values (((a_149) (car v_34))) (equal? 'let a_149))
                (let-values (((d_140) (cdr v_34)))
                  (if (pair? d_140)
                    (if (let-values (((a_150) (car d_140)))
                          (if (list? a_150)
                            (let-values (((lst_50) a_150))
                              (begin
                                (check-list lst_50)
                                ((letrec-values (((for-loop_24)
                                                  (lambda (result_29 lst_51)
                                                    (if (pair? lst_51)
                                                      (let-values (((v_35) (unsafe-car lst_51))
                                                                   ((rest_29) (unsafe-cdr lst_51)))
                                                        (let-values (((result_30)
                                                                      (let-values ()
                                                                        (let-values (((result_31)
                                                                                      (let-values ()
                                                                                        (let-values ()
                                                                                          (if (pair? v_35)
                                                                                            (if (let-values (((a_151)
                                                                                                              (car
                                                                                                               v_35)))
                                                                                                  #t)
                                                                                              (let-values (((d_141)
                                                                                                            (cdr v_35)))
                                                                                                (if (pair? d_141)
                                                                                                  (if (let-values (((a_152)
                                                                                                                    (car
                                                                                                                     d_141)))
                                                                                                        #t)
                                                                                                    (let-values (((d_142)
                                                                                                                  (cdr
                                                                                                                   d_141)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_142))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f)))))
                                                                          (values result_31)))))
                                                          (if (if (not ((lambda x_9 (not result_30)) v_35)) (not #f) #f)
                                                            (for-loop_24 result_30 rest_29)
                                                            result_30)))
                                                      result_29))))
                                   for-loop_24)
                                 #t
                                 lst_50)))
                            #f))
                      (let-values (((d_143) (cdr d_140))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_9 rhss_30 bodys_0)
                        (let-values (((d_144) (cdr v_34)))
                          (let-values (((ids_10 rhss_31)
                                        (let-values (((a_153) (car d_144)))
                                          (let-values (((ids_11 rhss_32)
                                                        (let-values (((lst_52) a_153))
                                                          (begin
                                                            (check-list lst_52)
                                                            ((letrec-values (((for-loop_25)
                                                                              (lambda (ids_12 rhss_33 lst_53)
                                                                                (if (pair? lst_53)
                                                                                  (let-values (((v_36)
                                                                                                (unsafe-car lst_53))
                                                                                               ((rest_30)
                                                                                                (unsafe-cdr lst_53)))
                                                                                    (let-values (((ids_13 rhss_34)
                                                                                                  (let-values (((ids_14)
                                                                                                                ids_12)
                                                                                                               ((rhss_35)
                                                                                                                rhss_33))
                                                                                                    (let-values (((ids_15
                                                                                                                   rhss_36)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((ids13_0
                                                                                                                                   rhss14_0)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values (((ids_16)
                                                                                                                                                  (let-values (((a_154)
                                                                                                                                                                (car
                                                                                                                                                                 v_36)))
                                                                                                                                                    a_154))
                                                                                                                                                 ((rhss_37)
                                                                                                                                                  (let-values (((d_145)
                                                                                                                                                                (cdr
                                                                                                                                                                 v_36)))
                                                                                                                                                    (let-values (((a_155)
                                                                                                                                                                  (car
                                                                                                                                                                   d_145)))
                                                                                                                                                      a_155))))
                                                                                                                                      (values
                                                                                                                                       ids_16
                                                                                                                                       rhss_37)))))
                                                                                                                      (values
                                                                                                                       (cons
                                                                                                                        ids13_0
                                                                                                                        ids_14)
                                                                                                                       (cons
                                                                                                                        rhss14_0
                                                                                                                        rhss_35))))))
                                                                                                      (values
                                                                                                       ids_15
                                                                                                       rhss_36)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_25
                                                                                         ids_13
                                                                                         rhss_34
                                                                                         rest_30)
                                                                                        (values ids_13 rhss_34))))
                                                                                  (values ids_12 rhss_33)))))
                                                               for-loop_25)
                                                             null
                                                             null
                                                             lst_52)))))
                                            (values (reverse$1 ids_11) (reverse$1 rhss_32)))))
                                       ((bodys_1) (let-values (((d_146) (cdr d_144))) d_146)))
                            (values ids_10 rhss_31 bodys_1)))))
            ((letrec-values (((loop_6)
                              (lambda (ids_17 rhss_38 binds_0)
                                (if (null? (cdr rhss_38))
                                  (let-values ()
                                    (if (null? binds_0)
                                      (list* 'let (list (list (car ids_17) (car rhss_38))) bodys_0)
                                      (list
                                       'let
                                       (list (list (car ids_17) (car rhss_38)))
                                       (list* 'let binds_0 bodys_0))))
                                  (if (simple? (car rhss_38) prim-knowns_5 knowns_17 imports_15 mutated_14)
                                    (let-values ()
                                      (list
                                       'let
                                       (list (list (car ids_17) (car rhss_38)))
                                       (loop_6 (cdr ids_17) (cdr rhss_38) binds_0)))
                                    (let-values ()
                                      (let-values (((id_8) (car ids_17)))
                                        (list
                                         'let
                                         (list (list id_8 (car rhss_38)))
                                         (loop_6 (cdr ids_17) (cdr rhss_38) (cons (list id_8 id_8) binds_0))))))))))
               loop_6)
             ids_9
             rhss_30
             null))
          (error 'match "failed ~e" v_34))))))
 (define-values
  (left-to-right/let-values)
  (lambda (v_37 mutated_15)
    (let-values (((v_38) v_37))
      (if (if (pair? v_38)
            (if (let-values (((a_156) (car v_38))) (equal? 'let-values a_156))
              (let-values (((d_147) (cdr v_38)))
                (if (pair? d_147)
                  (if (let-values (((a_157) (car d_147)))
                        (if (pair? a_157)
                          (if (let-values (((a_158) (car a_157)))
                                (if (pair? a_158)
                                  (if (let-values (((a_159) (car a_158))) #t)
                                    (let-values (((d_148) (cdr a_158)))
                                      (if (pair? d_148)
                                        (if (let-values (((a_160) (car d_148))) #t)
                                          (let-values (((d_149) (cdr d_148))) (equal? '() d_149))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_150) (cdr a_157))) (equal? '() d_150))
                            #f)
                          #f))
                    (let-values (((d_151) (cdr d_147)))
                      (if (pair? d_151)
                        (if (let-values (((a_161) (car d_151))) #t)
                          (let-values (((d_152) (cdr d_151))) (equal? '() d_152))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((ids_18 rhs_16 body_11)
                      (let-values (((d_153) (cdr v_38)))
                        (let-values (((ids_19 rhs_17)
                                      (let-values (((a_162) (car d_153)))
                                        (let-values (((a_163) (car a_162)))
                                          (let-values (((ids_20) (let-values (((a_164) (car a_163))) a_164))
                                                       ((rhs_18)
                                                        (let-values (((d_154) (cdr a_163)))
                                                          (let-values (((a_165) (car d_154))) a_165))))
                                            (values ids_20 rhs_18)))))
                                     ((body_12)
                                      (let-values (((d_155) (cdr d_153))) (let-values (((a_166) (car d_155))) a_166))))
                          (values ids_19 rhs_17 body_12)))))
          (make-let-values ids_18 rhs_16 body_11))
        (if (if (pair? v_38)
              (if (let-values (((a_167) (car v_38))) (equal? 'let-values a_167))
                (let-values (((d_156) (cdr v_38)))
                  (if (pair? d_156)
                    (if (let-values (((a_168) (car d_156)))
                          (if (pair? a_168)
                            (if (let-values (((a_169) (car a_168)))
                                  (if (pair? a_169)
                                    (if (let-values (((a_170) (car a_169))) #t)
                                      (let-values (((d_157) (cdr a_169)))
                                        (if (pair? d_157)
                                          (if (let-values (((a_171) (car d_157))) #t)
                                            (let-values (((d_158) (cdr d_157))) (equal? '() d_158))
                                            #f)
                                          #f))
                                      #f)
                                    #f))
                              (let-values (((d_159) (cdr a_168))) (equal? '() d_159))
                              #f)
                            #f))
                      (let-values (((d_160) (cdr d_156))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_21 rhs_19 bodys_2)
                        (let-values (((d_161) (cdr v_38)))
                          (let-values (((ids_22 rhs_20)
                                        (let-values (((a_172) (car d_161)))
                                          (let-values (((a_173) (car a_172)))
                                            (let-values (((ids_23) (let-values (((a_174) (car a_173))) a_174))
                                                         ((rhs_21)
                                                          (let-values (((d_162) (cdr a_173)))
                                                            (let-values (((a_175) (car d_162))) a_175))))
                                              (values ids_23 rhs_21)))))
                                       ((bodys_3) (let-values (((d_163) (cdr d_161))) d_163)))
                            (values ids_22 rhs_20 bodys_3)))))
            (make-let-values ids_21 rhs_19 (list* 'begin bodys_2)))
          (if (if (pair? v_38)
                (if (let-values (((a_176) (car v_38))) (equal? 'let-values a_176))
                  (let-values (((d_164) (cdr v_38)))
                    (if (pair? d_164)
                      (if (let-values (((a_177) (car d_164)))
                            (if (list? a_177)
                              (let-values (((lst_54) a_177))
                                (begin
                                  (check-list lst_54)
                                  ((letrec-values (((for-loop_26)
                                                    (lambda (result_32 lst_55)
                                                      (if (pair? lst_55)
                                                        (let-values (((v_39) (unsafe-car lst_55))
                                                                     ((rest_31) (unsafe-cdr lst_55)))
                                                          (let-values (((result_33)
                                                                        (let-values ()
                                                                          (let-values (((result_34)
                                                                                        (let-values ()
                                                                                          (let-values ()
                                                                                            (if (pair? v_39)
                                                                                              (if (let-values (((a_178)
                                                                                                                (car
                                                                                                                 v_39)))
                                                                                                    (list? a_178))
                                                                                                (let-values (((d_165)
                                                                                                              (cdr
                                                                                                               v_39)))
                                                                                                  (if (pair? d_165)
                                                                                                    (if (let-values (((a_179)
                                                                                                                      (car
                                                                                                                       d_165)))
                                                                                                          #t)
                                                                                                      (let-values (((d_166)
                                                                                                                    (cdr
                                                                                                                     d_165)))
                                                                                                        (equal?
                                                                                                         '()
                                                                                                         d_166))
                                                                                                      #f)
                                                                                                    #f))
                                                                                                #f)
                                                                                              #f)))))
                                                                            (values result_34)))))
                                                            (if (if (not ((lambda x_10 (not result_33)) v_39))
                                                                  (not #f)
                                                                  #f)
                                                              (for-loop_26 result_33 rest_31)
                                                              result_33)))
                                                        result_32))))
                                     for-loop_26)
                                   #t
                                   lst_54)))
                              #f))
                        (let-values (((d_167) (cdr d_164))) #t)
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((idss_8 rhss_39 bodys_4)
                          (let-values (((d_168) (cdr v_38)))
                            (let-values (((idss_9 rhss_40)
                                          (let-values (((a_180) (car d_168)))
                                            (let-values (((idss_10 rhss_41)
                                                          (let-values (((lst_56) a_180))
                                                            (begin
                                                              (check-list lst_56)
                                                              ((letrec-values (((for-loop_27)
                                                                                (lambda (idss_11 rhss_42 lst_57)
                                                                                  (if (pair? lst_57)
                                                                                    (let-values (((v_40)
                                                                                                  (unsafe-car lst_57))
                                                                                                 ((rest_32)
                                                                                                  (unsafe-cdr lst_57)))
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
                                                                                                                                                    (let-values (((a_181)
                                                                                                                                                                  (car
                                                                                                                                                                   v_40)))
                                                                                                                                                      a_181))
                                                                                                                                                   ((rhss_46)
                                                                                                                                                    (let-values (((d_169)
                                                                                                                                                                  (cdr
                                                                                                                                                                   v_40)))
                                                                                                                                                      (let-values (((a_182)
                                                                                                                                                                    (car
                                                                                                                                                                     d_169)))
                                                                                                                                                        a_182))))
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
                                                                                          (for-loop_27
                                                                                           idss_12
                                                                                           rhss_43
                                                                                           rest_32)
                                                                                          (values idss_12 rhss_43))))
                                                                                    (values idss_11 rhss_42)))))
                                                                 for-loop_27)
                                                               null
                                                               null
                                                               lst_56)))))
                                              (values (reverse$1 idss_10) (reverse$1 rhss_41)))))
                                         ((bodys_5) (let-values (((d_170) (cdr d_168))) d_170)))
                              (values idss_9 rhss_40 bodys_5)))))
              ((letrec-values (((loop_7)
                                (lambda (idss_16 rhss_47 binds_1)
                                  (if (null? (cdr rhss_47))
                                    (let-values ()
                                      (make-let-values (car idss_16) (car rhss_47) (list* 'let binds_1 bodys_4)))
                                    (let-values ()
                                      (let-values (((ids_24) (car idss_16)))
                                        (make-let-values
                                         ids_24
                                         (car rhss_47)
                                         (loop_7
                                          (cdr idss_16)
                                          (cdr rhss_47)
                                          (append (map2 (lambda (id_9) (list id_9 id_9)) ids_24) binds_1)))))))))
                 loop_7)
               idss_8
               rhss_39
               null))
            (error 'match "failed ~e" v_38)))))))
 (define-values
  (make-let-values)
  (lambda (ids_25 rhs_22 body_13)
    (if (if (pair? ids_25) (null? (cdr ids_25)) #f)
      (let-values () (list 'let (list (list (car ids_25) rhs_22)) body_13))
      (let-values ()
        (let-values (((v_41) (if (null? ids_25) rhs_22 #f)))
          (if (if (pair? v_41)
                (if (let-values (((a_183) (car v_41))) (equal? 'begin a_183))
                  (let-values (((d_171) (cdr v_41)))
                    (if (pair? d_171)
                      (if (let-values (((a_184) (car d_171))) #t)
                        (let-values (((d_172) (cdr d_171)))
                          (if (pair? d_172)
                            (if (let-values (((a_185) (car d_172)))
                                  (if (pair? a_185)
                                    (if (let-values (((a_186) (car a_185))) (equal? 'values a_186))
                                      (let-values (((d_173) (cdr a_185))) (equal? '() d_173))
                                      #f)
                                    #f))
                              (let-values (((d_174) (cdr d_172))) (equal? '() d_174))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((rhs_23) (let-values (((d_175) (cdr v_41))) (let-values (((a_187) (car d_175))) a_187))))
              (list 'begin rhs_23 body_13))
            (let-values ()
              (list
               'call-with-values
               (list 'lambda '() rhs_22)
               (list
                'case-lambda
                (list ids_25 body_13)
                (list 'args (list* 'raise-result-arity-error (list 'quote ids_25) '(args))))))))))))
 (define-values
  (left-to-right/app)
  (lambda (v_42 prim-knowns_6 knowns_18 imports_16 mutated_16)
    ((letrec-values (((loop_8)
                      (lambda (l_12 accum_1)
                        (if (null? l_12)
                          (let-values () (reverse$1 accum_1))
                          (if (simple? (car l_12) prim-knowns_6 knowns_18 imports_16 mutated_16)
                            (let-values () (loop_8 (cdr l_12) (cons (car l_12) accum_1)))
                            (if (andmap2
                                 (lambda (v_43) (simple? v_43 prim-knowns_6 knowns_18 imports_16 mutated_16))
                                 (cdr l_12))
                              (let-values () (append (reverse$1 accum_1) l_12))
                              (let-values ()
                                (let-values (((g_0) (gensym "app_")))
                                  (list
                                   'let
                                   (list (list g_0 (car l_12)))
                                   (loop_8 (cdr l_12) (cons g_0 accum_1)))))))))))
       loop_8)
     v_42
     null)))
 (define-values
  (make-schemify)
  (lambda (prim-knowns_7 knowns_19 mutated_17 imports_17 exports_7)
    (lambda (v_44)
      ((letrec-values (((schemify_1)
                        (lambda (v_45)
                          (let-values (((v_46) v_45))
                            (if (if (pair? v_46)
                                  (if (let-values (((a_188) (car v_46))) (equal? 'lambda a_188))
                                    (let-values (((d_176) (cdr v_46)))
                                      (if (pair? d_176)
                                        (if (let-values (((a_189) (car d_176))) #t)
                                          (let-values (((d_177) (cdr d_176))) (list? d_177))
                                          #f)
                                        #f))
                                    #f)
                                  #f)
                              (let-values (((formals_0 body_14)
                                            (let-values (((d_178) (cdr v_46)))
                                              (let-values (((formals_1) (let-values (((a_190) (car d_178))) a_190))
                                                           ((body_15) (let-values (((d_179) (cdr d_178))) d_179)))
                                                (values formals_1 body_15)))))
                                (list* 'lambda formals_0 (map2 schemify_1 body_14)))
                              (if (if (pair? v_46)
                                    (if (let-values (((a_191) (car v_46))) (equal? 'case-lambda a_191))
                                      (let-values (((d_180) (cdr v_46)))
                                        (if (list? d_180)
                                          (let-values (((lst_58) d_180))
                                            (begin
                                              (check-list lst_58)
                                              ((letrec-values (((for-loop_28)
                                                                (lambda (result_35 lst_59)
                                                                  (if (pair? lst_59)
                                                                    (let-values (((v_47) (unsafe-car lst_59))
                                                                                 ((rest_33) (unsafe-cdr lst_59)))
                                                                      (let-values (((result_36)
                                                                                    (let-values ()
                                                                                      (let-values (((result_37)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (if (pair? v_47)
                                                                                                          (if (let-values (((a_192)
                                                                                                                            (car
                                                                                                                             v_47)))
                                                                                                                #t)
                                                                                                            (let-values (((d_181)
                                                                                                                          (cdr
                                                                                                                           v_47)))
                                                                                                              (list?
                                                                                                               d_181))
                                                                                                            #f)
                                                                                                          #f)))))
                                                                                        (values result_37)))))
                                                                        (if (if (not
                                                                                 ((lambda x_11 (not result_36)) v_47))
                                                                              (not #f)
                                                                              #f)
                                                                          (for-loop_28 result_36 rest_33)
                                                                          result_36)))
                                                                    result_35))))
                                                 for-loop_28)
                                               #t
                                               lst_58)))
                                          #f))
                                      #f)
                                    #f)
                                (let-values (((formalss_0 bodys_6)
                                              (let-values (((d_182) (cdr v_46)))
                                                (let-values (((formalss_1 bodys_7)
                                                              (let-values (((lst_60) d_182))
                                                                (begin
                                                                  (check-list lst_60)
                                                                  ((letrec-values (((for-loop_29)
                                                                                    (lambda (formalss_2 bodys_8 lst_61)
                                                                                      (if (pair? lst_61)
                                                                                        (let-values (((v_48)
                                                                                                      (unsafe-car
                                                                                                       lst_61))
                                                                                                     ((rest_34)
                                                                                                      (unsafe-cdr
                                                                                                       lst_61)))
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
                                                                                                                                                        (let-values (((a_193)
                                                                                                                                                                      (car
                                                                                                                                                                       v_48)))
                                                                                                                                                          a_193))
                                                                                                                                                       ((bodys_12)
                                                                                                                                                        (let-values (((d_183)
                                                                                                                                                                      (cdr
                                                                                                                                                                       v_48)))
                                                                                                                                                          d_183)))
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
                                                                                              (for-loop_29
                                                                                               formalss_3
                                                                                               bodys_9
                                                                                               rest_34)
                                                                                              (values
                                                                                               formalss_3
                                                                                               bodys_9))))
                                                                                        (values formalss_2 bodys_8)))))
                                                                     for-loop_29)
                                                                   null
                                                                   null
                                                                   lst_60)))))
                                                  (values (reverse$1 formalss_1) (reverse$1 bodys_7))))))
                                  (list*
                                   'case-lambda
                                   (let-values (((lst_62) formalss_0) ((lst_63) bodys_6))
                                     (begin
                                       (check-list lst_62)
                                       (check-list lst_63)
                                       ((letrec-values (((for-loop_30)
                                                         (lambda (lst_64 lst_65)
                                                           (if (if (pair? lst_64) (pair? lst_65) #f)
                                                             (let-values (((formals_2) (unsafe-car lst_64))
                                                                          ((rest_35) (unsafe-cdr lst_64))
                                                                          ((body_16) (unsafe-car lst_65))
                                                                          ((rest_36) (unsafe-cdr lst_65)))
                                                               (let-values (((post-guard-var_3) (lambda () #t)))
                                                                 (let-values ()
                                                                   (let-values (((elem_2)
                                                                                 (let-values ()
                                                                                   (let-values ()
                                                                                     (list*
                                                                                      formals_2
                                                                                      (map2 schemify_1 body_16))))))
                                                                     (let-values (((result_38)
                                                                                   (if (post-guard-var_3)
                                                                                     (for-loop_30 rest_35 rest_36)
                                                                                     null)))
                                                                       (cons elem_2 result_38))))))
                                                             null))))
                                          for-loop_30)
                                        lst_62
                                        lst_63)))))
                                (if (if (pair? v_46)
                                      (if (let-values (((a_194) (car v_46))) (equal? 'define-values a_194))
                                        (let-values (((d_184) (cdr v_46)))
                                          (if (pair? d_184)
                                            (if (let-values (((a_195) (car d_184)))
                                                  (if (pair? a_195)
                                                    (if (let-values (((a_196) (car a_195))) #t)
                                                      (let-values (((d_185) (cdr a_195)))
                                                        (if (pair? d_185)
                                                          (if (let-values (((a_197) (car d_185))) #t)
                                                            (let-values (((d_186) (cdr d_185)))
                                                              (if (pair? d_186)
                                                                (if (let-values (((a_198) (car d_186))) #t)
                                                                  (let-values (((d_187) (cdr d_186))) (list? d_187))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                              (let-values (((d_188) (cdr d_184)))
                                                (if (pair? d_188)
                                                  (if (let-values (((a_199) (car d_188)))
                                                        (if (pair? a_199)
                                                          (if (let-values (((a_200) (car a_199)))
                                                                (equal? 'let-values a_200))
                                                            (let-values (((d_189) (cdr a_199)))
                                                              (if (pair? d_189)
                                                                (if (let-values (((a_201) (car d_189)))
                                                                      (if (pair? a_201)
                                                                        (if (let-values (((a_202) (car a_201)))
                                                                              (if (pair? a_202)
                                                                                (if (let-values (((a_203) (car a_202)))
                                                                                      (if (pair? a_203)
                                                                                        (if (let-values (((a_204)
                                                                                                          (car a_203)))
                                                                                              #t)
                                                                                          (let-values (((d_190)
                                                                                                        (cdr a_203)))
                                                                                            (if (pair? d_190)
                                                                                              (if (let-values (((a_205)
                                                                                                                (car
                                                                                                                 d_190)))
                                                                                                    #t)
                                                                                                (let-values (((d_191)
                                                                                                              (cdr
                                                                                                               d_190)))
                                                                                                  (if (pair? d_191)
                                                                                                    (if (let-values (((a_206)
                                                                                                                      (car
                                                                                                                       d_191)))
                                                                                                          #t)
                                                                                                      (let-values (((d_192)
                                                                                                                    (cdr
                                                                                                                     d_191)))
                                                                                                        (if (pair?
                                                                                                             d_192)
                                                                                                          (if (let-values (((a_207)
                                                                                                                            (car
                                                                                                                             d_192)))
                                                                                                                #t)
                                                                                                            (let-values (((d_193)
                                                                                                                          (cdr
                                                                                                                           d_192)))
                                                                                                              (if (pair?
                                                                                                                   d_193)
                                                                                                                (if (let-values (((a_208)
                                                                                                                                  (car
                                                                                                                                   d_193)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_194)
                                                                                                                                (cdr
                                                                                                                                 d_193)))
                                                                                                                    (equal?
                                                                                                                     '()
                                                                                                                     d_194))
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
                                                                                  (let-values (((d_195) (cdr a_202)))
                                                                                    (if (pair? d_195)
                                                                                      (if (let-values (((a_209)
                                                                                                        (car d_195)))
                                                                                            #t)
                                                                                        (let-values (((d_196)
                                                                                                      (cdr d_195)))
                                                                                          (equal? '() d_196))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f))
                                                                          (let-values (((d_197) (cdr a_201)))
                                                                            (equal? '() d_197))
                                                                          #f)
                                                                        #f))
                                                                  (let-values (((d_198) (cdr d_189)))
                                                                    (if (pair? d_198)
                                                                      (if (let-values (((a_210) (car d_198)))
                                                                            (if (pair? a_210)
                                                                              (if (let-values (((a_211) (car a_210)))
                                                                                    (equal? 'values a_211))
                                                                                (let-values (((d_199) (cdr a_210)))
                                                                                  (if (pair? d_199)
                                                                                    (if (let-values (((a_212)
                                                                                                      (car d_199)))
                                                                                          #t)
                                                                                      (let-values (((d_200)
                                                                                                    (cdr d_199)))
                                                                                        (if (pair? d_200)
                                                                                          (if (let-values (((a_213)
                                                                                                            (car
                                                                                                             d_200)))
                                                                                                #t)
                                                                                            (let-values (((d_201)
                                                                                                          (cdr d_200)))
                                                                                              (if (pair? d_201)
                                                                                                (if (let-values (((a_214)
                                                                                                                  (car
                                                                                                                   d_201)))
                                                                                                      #t)
                                                                                                  (let-values (((d_202)
                                                                                                                (cdr
                                                                                                                 d_201)))
                                                                                                    (list? d_202))
                                                                                                  #f)
                                                                                                #f))
                                                                                            #f)
                                                                                          #f))
                                                                                      #f)
                                                                                    #f))
                                                                                #f)
                                                                              #f))
                                                                        (let-values (((d_203) (cdr d_198)))
                                                                          (equal? '() d_203))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                    (let-values (((d_204) (cdr d_188))) (equal? '() d_204))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f))
                                        #f)
                                      #f)
                                  (let-values (((struct:s_3
                                                 make-s_4
                                                 s?_5
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
                                                (let-values (((d_205) (cdr v_46)))
                                                  (let-values (((struct:s_4 make-s_5 s?_6 acc/muts_6)
                                                                (let-values (((a_215) (car d_205)))
                                                                  (let-values (((struct:s_5)
                                                                                (let-values (((a_216) (car a_215)))
                                                                                  a_216))
                                                                               ((make-s_6 s?_7 acc/muts_7)
                                                                                (let-values (((d_206) (cdr a_215)))
                                                                                  (let-values (((make-s_7)
                                                                                                (let-values (((a_217)
                                                                                                              (car
                                                                                                               d_206)))
                                                                                                  a_217))
                                                                                               ((s?_8 acc/muts_8)
                                                                                                (let-values (((d_207)
                                                                                                              (cdr
                                                                                                               d_206)))
                                                                                                  (let-values (((s?_9)
                                                                                                                (let-values (((a_218)
                                                                                                                              (car
                                                                                                                               d_207)))
                                                                                                                  a_218))
                                                                                                               ((acc/muts_9)
                                                                                                                (let-values (((d_208)
                                                                                                                              (cdr
                                                                                                                               d_207)))
                                                                                                                  d_208)))
                                                                                                    (values
                                                                                                     s?_9
                                                                                                     acc/muts_9)))))
                                                                                    (values
                                                                                     make-s_7
                                                                                     s?_8
                                                                                     acc/muts_8)))))
                                                                    (values struct:s_5 make-s_6 s?_7 acc/muts_7))))
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
                                                                (let-values (((d_209) (cdr d_205)))
                                                                  (let-values (((a_219) (car d_209)))
                                                                    (let-values (((d_210) (cdr a_219)))
                                                                      (let-values (((struct:_16
                                                                                     make_8
                                                                                     ?1_2
                                                                                     -ref_19
                                                                                     -set!_19
                                                                                     mk_2)
                                                                                    (let-values (((a_220) (car d_210)))
                                                                                      (let-values (((a_221)
                                                                                                    (car a_220)))
                                                                                        (let-values (((struct:_17
                                                                                                       make_9
                                                                                                       ?1_3
                                                                                                       -ref_20
                                                                                                       -set!_20)
                                                                                                      (let-values (((a_222)
                                                                                                                    (car
                                                                                                                     a_221)))
                                                                                                        (let-values (((struct:_18)
                                                                                                                      (let-values (((a_223)
                                                                                                                                    (car
                                                                                                                                     a_222)))
                                                                                                                        a_223))
                                                                                                                     ((make_10
                                                                                                                       ?1_4
                                                                                                                       -ref_21
                                                                                                                       -set!_21)
                                                                                                                      (let-values (((d_211)
                                                                                                                                    (cdr
                                                                                                                                     a_222)))
                                                                                                                        (let-values (((make_11)
                                                                                                                                      (let-values (((a_224)
                                                                                                                                                    (car
                                                                                                                                                     d_211)))
                                                                                                                                        a_224))
                                                                                                                                     ((?1_5
                                                                                                                                       -ref_22
                                                                                                                                       -set!_22)
                                                                                                                                      (let-values (((d_212)
                                                                                                                                                    (cdr
                                                                                                                                                     d_211)))
                                                                                                                                        (let-values (((?1_6)
                                                                                                                                                      (let-values (((a_225)
                                                                                                                                                                    (car
                                                                                                                                                                     d_212)))
                                                                                                                                                        a_225))
                                                                                                                                                     ((-ref_23
                                                                                                                                                       -set!_23)
                                                                                                                                                      (let-values (((d_213)
                                                                                                                                                                    (cdr
                                                                                                                                                                     d_212)))
                                                                                                                                                        (let-values (((-ref_24)
                                                                                                                                                                      (let-values (((a_226)
                                                                                                                                                                                    (car
                                                                                                                                                                                     d_213)))
                                                                                                                                                                        a_226))
                                                                                                                                                                     ((-set!_24)
                                                                                                                                                                      (let-values (((d_214)
                                                                                                                                                                                    (cdr
                                                                                                                                                                                     d_213)))
                                                                                                                                                                        (let-values (((a_227)
                                                                                                                                                                                      (car
                                                                                                                                                                                       d_214)))
                                                                                                                                                                          a_227))))
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
                                                                                                      (let-values (((d_215)
                                                                                                                    (cdr
                                                                                                                     a_221)))
                                                                                                        (let-values (((a_228)
                                                                                                                      (car
                                                                                                                       d_215)))
                                                                                                          a_228))))
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
                                                                                    (let-values (((d_216) (cdr d_210)))
                                                                                      (let-values (((a_229)
                                                                                                    (car d_216)))
                                                                                        (let-values (((d_217)
                                                                                                      (cdr a_229)))
                                                                                          (let-values (((struct:2_7)
                                                                                                        (let-values (((a_230)
                                                                                                                      (car
                                                                                                                       d_217)))
                                                                                                          a_230))
                                                                                                       ((make2_8
                                                                                                         ?2_9
                                                                                                         make-acc/muts_9)
                                                                                                        (let-values (((d_218)
                                                                                                                      (cdr
                                                                                                                       d_217)))
                                                                                                          (let-values (((make2_9)
                                                                                                                        (let-values (((a_231)
                                                                                                                                      (car
                                                                                                                                       d_218)))
                                                                                                                          a_231))
                                                                                                                       ((?2_10
                                                                                                                         make-acc/muts_10)
                                                                                                                        (let-values (((d_219)
                                                                                                                                      (cdr
                                                                                                                                       d_218)))
                                                                                                                          (let-values (((?2_11)
                                                                                                                                        (let-values (((a_232)
                                                                                                                                                      (car
                                                                                                                                                       d_219)))
                                                                                                                                          a_232))
                                                                                                                                       ((make-acc/muts_11)
                                                                                                                                        (let-values (((d_220)
                                                                                                                                                      (cdr
                                                                                                                                                       d_219)))
                                                                                                                                          d_220)))
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
                                                     struct:s_4
                                                     make-s_5
                                                     s?_6
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
                                                        (make-struct-type-info mk_0 knowns_19 imports_17)
                                                        #f)
                                                      #f)
                                                    #f)))
                                      (if sti_0
                                        (let-values ()
                                          (list*
                                           'begin
                                           (list
                                            'define
                                            struct:s_3
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
                                                                ((letrec-values (((for-loop_31)
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
                                                                                            (for-loop_31
                                                                                             vec_4
                                                                                             i_4
                                                                                             (+ pos_1 inc_0))
                                                                                            (values vec_4 i_4))))
                                                                                      (values vec_3 i_2)))))
                                                                   for-loop_31)
                                                                 (make-vector 16)
                                                                 0
                                                                 start_1)))))
                                                (shrink-vector vec_2 i_1)))))
                                           (list
                                            'define
                                            make-s_4
                                            (list
                                             'record-constructor
                                             (list* 'make-record-constructor-descriptor struct:s_3 '(#f #f))))
                                           (list 'define s?_5 (list 'record-predicate struct:s_3))
                                           (qq-append
                                            (let-values (((lst_66) acc/muts_5) ((lst_67) make-acc/muts_6))
                                              (begin
                                                (check-list lst_66)
                                                (check-list lst_67)
                                                ((letrec-values (((for-loop_32)
                                                                  (lambda (lst_68 lst_69)
                                                                    (if (if (pair? lst_68) (pair? lst_69) #f)
                                                                      (let-values (((acc/mut_0) (unsafe-car lst_68))
                                                                                   ((rest_37) (unsafe-cdr lst_68))
                                                                                   ((make-acc/mut_0)
                                                                                    (unsafe-car lst_69))
                                                                                   ((rest_38) (unsafe-cdr lst_69)))
                                                                        (let-values (((post-guard-var_4)
                                                                                      (lambda () #t)))
                                                                          (let-values ()
                                                                            (let-values (((elem_3)
                                                                                          (let-values ()
                                                                                            (let-values ()
                                                                                              (list
                                                                                               'define
                                                                                               acc/mut_0
                                                                                               (let-values (((v_49)
                                                                                                             make-acc/mut_0))
                                                                                                 (if (if (pair? v_49)
                                                                                                       (if (let-values (((a_233)
                                                                                                                         (car
                                                                                                                          v_49)))
                                                                                                             (equal?
                                                                                                              'make-struct-field-accessor
                                                                                                              a_233))
                                                                                                         (let-values (((d_221)
                                                                                                                       (cdr
                                                                                                                        v_49)))
                                                                                                           (if (pair?
                                                                                                                d_221)
                                                                                                             (if (let-values (((a_234)
                                                                                                                               (car
                                                                                                                                d_221)))
                                                                                                                   ((lambda (v_50)
                                                                                                                      (eq?
                                                                                                                       v_50
                                                                                                                       -ref_17))
                                                                                                                    a_234))
                                                                                                               (let-values (((d_222)
                                                                                                                             (cdr
                                                                                                                              d_221)))
                                                                                                                 (if (pair?
                                                                                                                      d_222)
                                                                                                                   (if (let-values (((a_235)
                                                                                                                                     (car
                                                                                                                                      d_222)))
                                                                                                                         #t)
                                                                                                                     (let-values (((d_223)
                                                                                                                                   (cdr
                                                                                                                                    d_222)))
                                                                                                                       (if (pair?
                                                                                                                            d_223)
                                                                                                                         (if (let-values (((a_236)
                                                                                                                                           (car
                                                                                                                                            d_223)))
                                                                                                                               #t)
                                                                                                                           (let-values (((d_224)
                                                                                                                                         (cdr
                                                                                                                                          d_223)))
                                                                                                                             (equal?
                                                                                                                              '()
                                                                                                                              d_224))
                                                                                                                           #f)
                                                                                                                         #f))
                                                                                                                     #f)
                                                                                                                   #f))
                                                                                                               #f)
                                                                                                             #f))
                                                                                                         #f)
                                                                                                       #f)
                                                                                                   (let-values (((pos_2)
                                                                                                                 (let-values (((d_225)
                                                                                                                               (cdr
                                                                                                                                v_49)))
                                                                                                                   (let-values (((d_226)
                                                                                                                                 (cdr
                                                                                                                                  d_225)))
                                                                                                                     (let-values (((a_237)
                                                                                                                                   (car
                                                                                                                                    d_226)))
                                                                                                                       a_237)))))
                                                                                                     (list
                                                                                                      'record-accessor
                                                                                                      struct:s_3
                                                                                                      pos_2))
                                                                                                   (if (if (pair? v_49)
                                                                                                         (if (let-values (((a_238)
                                                                                                                           (car
                                                                                                                            v_49)))
                                                                                                               (equal?
                                                                                                                'make-struct-field-mutator
                                                                                                                a_238))
                                                                                                           (let-values (((d_227)
                                                                                                                         (cdr
                                                                                                                          v_49)))
                                                                                                             (if (pair?
                                                                                                                  d_227)
                                                                                                               (if (let-values (((a_239)
                                                                                                                                 (car
                                                                                                                                  d_227)))
                                                                                                                     ((lambda (v_51)
                                                                                                                        (eq?
                                                                                                                         v_51
                                                                                                                         -set!_17))
                                                                                                                      a_239))
                                                                                                                 (let-values (((d_228)
                                                                                                                               (cdr
                                                                                                                                d_227)))
                                                                                                                   (if (pair?
                                                                                                                        d_228)
                                                                                                                     (if (let-values (((a_240)
                                                                                                                                       (car
                                                                                                                                        d_228)))
                                                                                                                           #t)
                                                                                                                       (let-values (((d_229)
                                                                                                                                     (cdr
                                                                                                                                      d_228)))
                                                                                                                         (if (pair?
                                                                                                                              d_229)
                                                                                                                           (if (let-values (((a_241)
                                                                                                                                             (car
                                                                                                                                              d_229)))
                                                                                                                                 #t)
                                                                                                                             (let-values (((d_230)
                                                                                                                                           (cdr
                                                                                                                                            d_229)))
                                                                                                                               (equal?
                                                                                                                                '()
                                                                                                                                d_230))
                                                                                                                             #f)
                                                                                                                           #f))
                                                                                                                       #f)
                                                                                                                     #f))
                                                                                                                 #f)
                                                                                                               #f))
                                                                                                           #f)
                                                                                                         #f)
                                                                                                     (let-values (((pos_3)
                                                                                                                   (let-values (((d_231)
                                                                                                                                 (cdr
                                                                                                                                  v_49)))
                                                                                                                     (let-values (((d_232)
                                                                                                                                   (cdr
                                                                                                                                    d_231)))
                                                                                                                       (let-values (((a_242)
                                                                                                                                     (car
                                                                                                                                      d_232)))
                                                                                                                         a_242)))))
                                                                                                       (list
                                                                                                        'record-mutator
                                                                                                        struct:s_3
                                                                                                        pos_3))
                                                                                                     (let-values ()
                                                                                                       (error
                                                                                                        "oops"))))))))))
                                                                              (let-values (((result_39)
                                                                                            (if (post-guard-var_4)
                                                                                              (for-loop_32
                                                                                               rest_37
                                                                                               rest_38)
                                                                                              null)))
                                                                                (cons elem_3 result_39))))))
                                                                      null))))
                                                   for-loop_32)
                                                 lst_66
                                                 lst_67)))
                                            (if (null? (struct-type-info-rest sti_0))
                                              null
                                              (list
                                               (list
                                                'define
                                                (gensym)
                                                (list*
                                                 'struct-type-install-properties!
                                                 struct:s_3
                                                 (list 'quote (struct-type-info-name sti_0))
                                                 (struct-type-info-immediate-field-count sti_0)
                                                 0
                                                 (struct-type-info-parent sti_0)
                                                 (map2 schemify_1 (struct-type-info-rest sti_0)))))))))
                                        (let-values () (list 'define-values (cadr v_45) (schemify_1 (caddr v_45)))))))
                                  (if (if (pair? v_46)
                                        (if (let-values (((a_243) (car v_46))) (equal? 'define-values a_243))
                                          (let-values (((d_233) (cdr v_46)))
                                            (if (pair? d_233)
                                              (if (let-values (((a_244) (car d_233)))
                                                    (if (pair? a_244)
                                                      (if (let-values (((a_245) (car a_244))) #t)
                                                        (let-values (((d_234) (cdr a_244))) (equal? '() d_234))
                                                        #f)
                                                      #f))
                                                (let-values (((d_235) (cdr d_233)))
                                                  (if (pair? d_235)
                                                    (if (let-values (((a_246) (car d_235))) #t)
                                                      (let-values (((d_236) (cdr d_235))) (equal? '() d_236))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((id_10 rhs_24)
                                                  (let-values (((d_237) (cdr v_46)))
                                                    (let-values (((id_11)
                                                                  (let-values (((a_247) (car d_237)))
                                                                    (let-values (((a_248) (car a_247))) a_248)))
                                                                 ((rhs_25)
                                                                  (let-values (((d_238) (cdr d_237)))
                                                                    (let-values (((a_249) (car d_238))) a_249))))
                                                      (values id_11 rhs_25)))))
                                      (list 'define id_10 (schemify_1 rhs_24)))
                                    (if (if (pair? v_46)
                                          (if (let-values (((a_250) (car v_46))) (equal? 'define-values a_250))
                                            (let-values (((d_239) (cdr v_46)))
                                              (if (pair? d_239)
                                                (if (let-values (((a_251) (car d_239))) #t)
                                                  (let-values (((d_240) (cdr d_239)))
                                                    (if (pair? d_240)
                                                      (if (let-values (((a_252) (car d_240))) #t)
                                                        (let-values (((d_241) (cdr d_240))) (equal? '() d_241))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((ids_26 rhs_26)
                                                    (let-values (((d_242) (cdr v_46)))
                                                      (let-values (((ids_27) (let-values (((a_253) (car d_242))) a_253))
                                                                   ((rhs_27)
                                                                    (let-values (((d_243) (cdr d_242)))
                                                                      (let-values (((a_254) (car d_243))) a_254))))
                                                        (values ids_27 rhs_27)))))
                                        (list 'define-values ids_26 (schemify_1 rhs_26)))
                                      (if (if (pair? v_46)
                                            (if (let-values (((a_255) (car v_46))) (equal? 'quote a_255))
                                              (let-values (((d_244) (cdr v_46)))
                                                (if (pair? d_244)
                                                  (if (let-values (((a_256) (car d_244))) #t)
                                                    (let-values (((d_245) (cdr d_244))) (equal? '() d_245))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values () v_45)
                                        (if (if (pair? v_46)
                                              (if (let-values (((a_257) (car v_46))) (equal? 'let-values a_257))
                                                (let-values (((d_246) (cdr v_46)))
                                                  (if (pair? d_246)
                                                    (if (let-values (((a_258) (car d_246))) (equal? '() a_258))
                                                      (let-values (((d_247) (cdr d_246)))
                                                        (if (pair? d_247)
                                                          (if (let-values (((a_259) (car d_247))) #t)
                                                            (let-values (((d_248) (cdr d_247))) (equal? '() d_248))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((body_17)
                                                        (let-values (((d_249) (cdr v_46)))
                                                          (let-values (((d_250) (cdr d_249)))
                                                            (let-values (((a_260) (car d_250))) a_260)))))
                                            (schemify_1 body_17))
                                          (if (if (pair? v_46)
                                                (if (let-values (((a_261) (car v_46))) (equal? 'let-values a_261))
                                                  (let-values (((d_251) (cdr v_46)))
                                                    (if (pair? d_251)
                                                      (if (let-values (((a_262) (car d_251))) (equal? '() a_262))
                                                        (let-values (((d_252) (cdr d_251))) (list? d_252))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((bodys_13)
                                                          (let-values (((d_253) (cdr v_46)))
                                                            (let-values (((d_254) (cdr d_253))) d_254))))
                                              (list* 'begin (map2 schemify_1 bodys_13)))
                                            (if (if (pair? v_46)
                                                  (if (let-values (((a_263) (car v_46))) (equal? 'let-values a_263))
                                                    (let-values (((d_255) (cdr v_46)))
                                                      (if (pair? d_255)
                                                        (if (let-values (((a_264) (car d_255)))
                                                              (if (list? a_264)
                                                                (let-values (((lst_70) a_264))
                                                                  (begin
                                                                    (check-list lst_70)
                                                                    ((letrec-values (((for-loop_33)
                                                                                      (lambda (result_40 lst_71)
                                                                                        (if (pair? lst_71)
                                                                                          (let-values (((v_52)
                                                                                                        (unsafe-car
                                                                                                         lst_71))
                                                                                                       ((rest_39)
                                                                                                        (unsafe-cdr
                                                                                                         lst_71)))
                                                                                            (let-values (((result_41)
                                                                                                          (let-values ()
                                                                                                            (let-values (((result_42)
                                                                                                                          (let-values ()
                                                                                                                            (let-values ()
                                                                                                                              (if (pair?
                                                                                                                                   v_52)
                                                                                                                                (if (let-values (((a_265)
                                                                                                                                                  (car
                                                                                                                                                   v_52)))
                                                                                                                                      (if (pair?
                                                                                                                                           a_265)
                                                                                                                                        (if (let-values (((a_266)
                                                                                                                                                          (car
                                                                                                                                                           a_265)))
                                                                                                                                              #t)
                                                                                                                                          (let-values (((d_256)
                                                                                                                                                        (cdr
                                                                                                                                                         a_265)))
                                                                                                                                            (equal?
                                                                                                                                             '()
                                                                                                                                             d_256))
                                                                                                                                          #f)
                                                                                                                                        #f))
                                                                                                                                  (let-values (((d_257)
                                                                                                                                                (cdr
                                                                                                                                                 v_52)))
                                                                                                                                    (if (pair?
                                                                                                                                         d_257)
                                                                                                                                      (if (let-values (((a_267)
                                                                                                                                                        (car
                                                                                                                                                         d_257)))
                                                                                                                                            #t)
                                                                                                                                        (let-values (((d_258)
                                                                                                                                                      (cdr
                                                                                                                                                       d_257)))
                                                                                                                                          (equal?
                                                                                                                                           '()
                                                                                                                                           d_258))
                                                                                                                                        #f)
                                                                                                                                      #f))
                                                                                                                                  #f)
                                                                                                                                #f)))))
                                                                                                              (values
                                                                                                               result_42)))))
                                                                                              (if (if (not
                                                                                                       ((lambda x_12
                                                                                                          (not
                                                                                                           result_41))
                                                                                                        v_52))
                                                                                                    (not #f)
                                                                                                    #f)
                                                                                                (for-loop_33
                                                                                                 result_41
                                                                                                 rest_39)
                                                                                                result_41)))
                                                                                          result_40))))
                                                                       for-loop_33)
                                                                     #t
                                                                     lst_70)))
                                                                #f))
                                                          (let-values (((d_259) (cdr d_255))) (list? d_259))
                                                          #f)
                                                        #f))
                                                    #f)
                                                  #f)
                                              (let-values (((ids_28 rhss_48 bodys_14)
                                                            (let-values (((d_260) (cdr v_46)))
                                                              (let-values (((ids_29 rhss_49)
                                                                            (let-values (((a_268) (car d_260)))
                                                                              (let-values (((ids_30 rhss_50)
                                                                                            (let-values (((lst_72)
                                                                                                          a_268))
                                                                                              (begin
                                                                                                (check-list lst_72)
                                                                                                ((letrec-values (((for-loop_34)
                                                                                                                  (lambda (ids_31
                                                                                                                           rhss_51
                                                                                                                           lst_73)
                                                                                                                    (if (pair?
                                                                                                                         lst_73)
                                                                                                                      (let-values (((v_53)
                                                                                                                                    (unsafe-car
                                                                                                                                     lst_73))
                                                                                                                                   ((rest_40)
                                                                                                                                    (unsafe-cdr
                                                                                                                                     lst_73)))
                                                                                                                        (let-values (((ids_32
                                                                                                                                       rhss_52)
                                                                                                                                      (let-values (((ids_33)
                                                                                                                                                    ids_31)
                                                                                                                                                   ((rhss_53)
                                                                                                                                                    rhss_51))
                                                                                                                                        (let-values (((ids_34
                                                                                                                                                       rhss_54)
                                                                                                                                                      (let-values ()
                                                                                                                                                        (let-values (((ids19_0
                                                                                                                                                                       rhss20_0)
                                                                                                                                                                      (let-values ()
                                                                                                                                                                        (let-values (((ids_35)
                                                                                                                                                                                      (let-values (((a_269)
                                                                                                                                                                                                    (car
                                                                                                                                                                                                     v_53)))
                                                                                                                                                                                        (let-values (((a_270)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       a_269)))
                                                                                                                                                                                          a_270)))
                                                                                                                                                                                     ((rhss_55)
                                                                                                                                                                                      (let-values (((d_261)
                                                                                                                                                                                                    (cdr
                                                                                                                                                                                                     v_53)))
                                                                                                                                                                                        (let-values (((a_271)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       d_261)))
                                                                                                                                                                                          a_271))))
                                                                                                                                                                          (values
                                                                                                                                                                           ids_35
                                                                                                                                                                           rhss_55)))))
                                                                                                                                                          (values
                                                                                                                                                           (cons
                                                                                                                                                            ids19_0
                                                                                                                                                            ids_33)
                                                                                                                                                           (cons
                                                                                                                                                            rhss20_0
                                                                                                                                                            rhss_53))))))
                                                                                                                                          (values
                                                                                                                                           ids_34
                                                                                                                                           rhss_54)))))
                                                                                                                          (if (not
                                                                                                                               #f)
                                                                                                                            (for-loop_34
                                                                                                                             ids_32
                                                                                                                             rhss_52
                                                                                                                             rest_40)
                                                                                                                            (values
                                                                                                                             ids_32
                                                                                                                             rhss_52))))
                                                                                                                      (values
                                                                                                                       ids_31
                                                                                                                       rhss_51)))))
                                                                                                   for-loop_34)
                                                                                                 null
                                                                                                 null
                                                                                                 lst_72)))))
                                                                                (values
                                                                                 (reverse$1 ids_30)
                                                                                 (reverse$1 rhss_50)))))
                                                                           ((bodys_15)
                                                                            (let-values (((d_262) (cdr d_260))) d_262)))
                                                                (values ids_29 rhss_49 bodys_15)))))
                                                (let-values (((new-knowns_1)
                                                              (let-values (((lst_74) ids_28) ((lst_75) rhss_48))
                                                                (begin
                                                                  (check-list lst_74)
                                                                  (check-list lst_75)
                                                                  ((letrec-values (((for-loop_35)
                                                                                    (lambda (knowns_20 lst_76 lst_77)
                                                                                      (if (if (pair? lst_76)
                                                                                            (pair? lst_77)
                                                                                            #f)
                                                                                        (let-values (((id_12)
                                                                                                      (unsafe-car
                                                                                                       lst_76))
                                                                                                     ((rest_41)
                                                                                                      (unsafe-cdr
                                                                                                       lst_76))
                                                                                                     ((rhs_28)
                                                                                                      (unsafe-car
                                                                                                       lst_77))
                                                                                                     ((rest_42)
                                                                                                      (unsafe-cdr
                                                                                                       lst_77)))
                                                                                          (let-values (((knowns_21)
                                                                                                        (let-values (((knowns_22)
                                                                                                                      knowns_20))
                                                                                                          (let-values (((knowns_23)
                                                                                                                        (let-values ()
                                                                                                                          (if (lambda?
                                                                                                                               rhs_28)
                                                                                                                            (hash-set
                                                                                                                             knowns_22
                                                                                                                             id_12
                                                                                                                             a-known-procedure)
                                                                                                                            knowns_22))))
                                                                                                            (values
                                                                                                             knowns_23)))))
                                                                                            (if (not #f)
                                                                                              (for-loop_35
                                                                                               knowns_21
                                                                                               rest_41
                                                                                               rest_42)
                                                                                              knowns_21)))
                                                                                        knowns_20))))
                                                                     for-loop_35)
                                                                   knowns_19
                                                                   lst_74
                                                                   lst_75)))))
                                                  (let-values (((body-schemify_0)
                                                                (make-schemify
                                                                 prim-knowns_7
                                                                 new-knowns_1
                                                                 mutated_17
                                                                 imports_17
                                                                 exports_7)))
                                                    (left-to-right/let
                                                     (list*
                                                      'let
                                                      (let-values (((lst_78) ids_28) ((lst_79) rhss_48))
                                                        (begin
                                                          (check-list lst_78)
                                                          (check-list lst_79)
                                                          ((letrec-values (((for-loop_36)
                                                                            (lambda (lst_80 lst_81)
                                                                              (if (if (pair? lst_80) (pair? lst_81) #f)
                                                                                (let-values (((id_13)
                                                                                              (unsafe-car lst_80))
                                                                                             ((rest_43)
                                                                                              (unsafe-cdr lst_80))
                                                                                             ((rhs_29)
                                                                                              (unsafe-car lst_81))
                                                                                             ((rest_44)
                                                                                              (unsafe-cdr lst_81)))
                                                                                  (let-values (((post-guard-var_5)
                                                                                                (lambda () #t)))
                                                                                    (let-values ()
                                                                                      (let-values (((elem_4)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (list
                                                                                                         id_13
                                                                                                         (schemify_1
                                                                                                          rhs_29))))))
                                                                                        (let-values (((result_43)
                                                                                                      (if (post-guard-var_5)
                                                                                                        (for-loop_36
                                                                                                         rest_43
                                                                                                         rest_44)
                                                                                                        null)))
                                                                                          (cons elem_4 result_43))))))
                                                                                null))))
                                                             for-loop_36)
                                                           lst_78
                                                           lst_79)))
                                                      (map2 body-schemify_0 bodys_14))
                                                     prim-knowns_7
                                                     knowns_19
                                                     imports_17
                                                     mutated_17))))
                                              (if (if (pair? v_46)
                                                    (if (let-values (((a_272) (car v_46))) (equal? 'let-values a_272))
                                                      (let-values (((d_263) (cdr v_46)))
                                                        (if (pair? d_263)
                                                          (if (let-values (((a_273) (car d_263)))
                                                                (if (pair? a_273)
                                                                  (if (let-values (((a_274) (car a_273)))
                                                                        (if (pair? a_274)
                                                                          (if (let-values (((a_275) (car a_274)))
                                                                                (equal? '() a_275))
                                                                            (let-values (((d_264) (cdr a_274)))
                                                                              (if (pair? d_264)
                                                                                (if (let-values (((a_276) (car d_264)))
                                                                                      (if (pair? a_276)
                                                                                        (if (let-values (((a_277)
                                                                                                          (car a_276)))
                                                                                              (equal? 'begin a_277))
                                                                                          (let-values (((d_265)
                                                                                                        (cdr a_276)))
                                                                                            (if (pair? d_265)
                                                                                              (if (let-values (((a_278)
                                                                                                                (car
                                                                                                                 d_265)))
                                                                                                    #t)
                                                                                                (let-values (((d_266)
                                                                                                              (cdr
                                                                                                               d_265)))
                                                                                                  (if (pair? d_266)
                                                                                                    (if (let-values (((a_279)
                                                                                                                      (car
                                                                                                                       d_266)))
                                                                                                          (equal?
                                                                                                           '...
                                                                                                           a_279))
                                                                                                      (let-values (((d_267)
                                                                                                                    (cdr
                                                                                                                     d_266)))
                                                                                                        (if (pair?
                                                                                                             d_267)
                                                                                                          (if (let-values (((a_280)
                                                                                                                            (car
                                                                                                                             d_267)))
                                                                                                                (if (pair?
                                                                                                                     a_280)
                                                                                                                  (if (let-values (((a_281)
                                                                                                                                    (car
                                                                                                                                     a_280)))
                                                                                                                        (equal?
                                                                                                                         'values
                                                                                                                         a_281))
                                                                                                                    (let-values (((d_268)
                                                                                                                                  (cdr
                                                                                                                                   a_280)))
                                                                                                                      (equal?
                                                                                                                       '()
                                                                                                                       d_268))
                                                                                                                    #f)
                                                                                                                  #f))
                                                                                                            (let-values (((d_269)
                                                                                                                          (cdr
                                                                                                                           d_267)))
                                                                                                              (equal?
                                                                                                               '()
                                                                                                               d_269))
                                                                                                            #f)
                                                                                                          #f))
                                                                                                      #f)
                                                                                                    #f))
                                                                                                #f)
                                                                                              #f))
                                                                                          #f)
                                                                                        #f))
                                                                                  (let-values (((d_270) (cdr d_264)))
                                                                                    (equal? '() d_270))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                    (let-values (((d_271) (cdr a_273)))
                                                                      (equal? '() d_271))
                                                                    #f)
                                                                  #f))
                                                            (let-values (((d_272) (cdr d_263))) (list? d_272))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f)
                                                (let-values (((rhss_56 bodys_16)
                                                              (let-values (((d_273) (cdr v_46)))
                                                                (let-values (((rhss_57)
                                                                              (let-values (((a_282) (car d_273)))
                                                                                (let-values (((a_283) (car a_282)))
                                                                                  (let-values (((d_274) (cdr a_283)))
                                                                                    (let-values (((a_284) (car d_274)))
                                                                                      (let-values (((d_275)
                                                                                                    (cdr a_284)))
                                                                                        (let-values (((a_285)
                                                                                                      (car d_275)))
                                                                                          a_285)))))))
                                                                             ((bodys_17)
                                                                              (let-values (((d_276) (cdr d_273)))
                                                                                d_276)))
                                                                  (values rhss_57 bodys_17)))))
                                                  (list*
                                                   'begin
                                                   (qq-append (map2 schemify_1 rhss_56) (map2 schemify_1 bodys_16))))
                                                (if (if (pair? v_46)
                                                      (if (let-values (((a_286) (car v_46))) (equal? 'let-values a_286))
                                                        (let-values (((d_277) (cdr v_46)))
                                                          (if (pair? d_277)
                                                            (if (let-values (((a_287) (car d_277)))
                                                                  (if (list? a_287)
                                                                    (let-values (((lst_82) a_287))
                                                                      (begin
                                                                        (check-list lst_82)
                                                                        ((letrec-values (((for-loop_37)
                                                                                          (lambda (result_44 lst_83)
                                                                                            (if (pair? lst_83)
                                                                                              (let-values (((v_54)
                                                                                                            (unsafe-car
                                                                                                             lst_83))
                                                                                                           ((rest_45)
                                                                                                            (unsafe-cdr
                                                                                                             lst_83)))
                                                                                                (let-values (((result_45)
                                                                                                              (let-values ()
                                                                                                                (let-values (((result_46)
                                                                                                                              (let-values ()
                                                                                                                                (let-values ()
                                                                                                                                  (if (pair?
                                                                                                                                       v_54)
                                                                                                                                    (if (let-values (((a_288)
                                                                                                                                                      (car
                                                                                                                                                       v_54)))
                                                                                                                                          (list?
                                                                                                                                           a_288))
                                                                                                                                      (let-values (((d_278)
                                                                                                                                                    (cdr
                                                                                                                                                     v_54)))
                                                                                                                                        (if (pair?
                                                                                                                                             d_278)
                                                                                                                                          (if (let-values (((a_289)
                                                                                                                                                            (car
                                                                                                                                                             d_278)))
                                                                                                                                                #t)
                                                                                                                                            (let-values (((d_279)
                                                                                                                                                          (cdr
                                                                                                                                                           d_278)))
                                                                                                                                              (equal?
                                                                                                                                               '()
                                                                                                                                               d_279))
                                                                                                                                            #f)
                                                                                                                                          #f))
                                                                                                                                      #f)
                                                                                                                                    #f)))))
                                                                                                                  (values
                                                                                                                   result_46)))))
                                                                                                  (if (if (not
                                                                                                           ((lambda x_13
                                                                                                              (not
                                                                                                               result_45))
                                                                                                            v_54))
                                                                                                        (not #f)
                                                                                                        #f)
                                                                                                    (for-loop_37
                                                                                                     result_45
                                                                                                     rest_45)
                                                                                                    result_45)))
                                                                                              result_44))))
                                                                           for-loop_37)
                                                                         #t
                                                                         lst_82)))
                                                                    #f))
                                                              (let-values (((d_280) (cdr d_277))) (list? d_280))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((idss_17 rhss_58 bodys_18)
                                                                (let-values (((d_281) (cdr v_46)))
                                                                  (let-values (((idss_18 rhss_59)
                                                                                (let-values (((a_290) (car d_281)))
                                                                                  (let-values (((idss_19 rhss_60)
                                                                                                (let-values (((lst_84)
                                                                                                              a_290))
                                                                                                  (begin
                                                                                                    (check-list lst_84)
                                                                                                    ((letrec-values (((for-loop_38)
                                                                                                                      (lambda (idss_20
                                                                                                                               rhss_61
                                                                                                                               lst_85)
                                                                                                                        (if (pair?
                                                                                                                             lst_85)
                                                                                                                          (let-values (((v_55)
                                                                                                                                        (unsafe-car
                                                                                                                                         lst_85))
                                                                                                                                       ((rest_46)
                                                                                                                                        (unsafe-cdr
                                                                                                                                         lst_85)))
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
                                                                                                                                                                                          (let-values (((a_291)
                                                                                                                                                                                                        (car
                                                                                                                                                                                                         v_55)))
                                                                                                                                                                                            a_291))
                                                                                                                                                                                         ((rhss_65)
                                                                                                                                                                                          (let-values (((d_282)
                                                                                                                                                                                                        (cdr
                                                                                                                                                                                                         v_55)))
                                                                                                                                                                                            (let-values (((a_292)
                                                                                                                                                                                                          (car
                                                                                                                                                                                                           d_282)))
                                                                                                                                                                                              a_292))))
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
                                                                                                                                (for-loop_38
                                                                                                                                 idss_21
                                                                                                                                 rhss_62
                                                                                                                                 rest_46)
                                                                                                                                (values
                                                                                                                                 idss_21
                                                                                                                                 rhss_62))))
                                                                                                                          (values
                                                                                                                           idss_20
                                                                                                                           rhss_61)))))
                                                                                                       for-loop_38)
                                                                                                     null
                                                                                                     null
                                                                                                     lst_84)))))
                                                                                    (values
                                                                                     (reverse$1 idss_19)
                                                                                     (reverse$1 rhss_60)))))
                                                                               ((bodys_19)
                                                                                (let-values (((d_283) (cdr d_281)))
                                                                                  d_283)))
                                                                    (values idss_18 rhss_59 bodys_19)))))
                                                    (left-to-right/let-values
                                                     (list*
                                                      'let-values
                                                      (let-values (((lst_86) idss_17) ((lst_87) rhss_58))
                                                        (begin
                                                          (check-list lst_86)
                                                          (check-list lst_87)
                                                          ((letrec-values (((for-loop_39)
                                                                            (lambda (lst_88 lst_89)
                                                                              (if (if (pair? lst_88) (pair? lst_89) #f)
                                                                                (let-values (((ids_36)
                                                                                              (unsafe-car lst_88))
                                                                                             ((rest_47)
                                                                                              (unsafe-cdr lst_88))
                                                                                             ((rhs_30)
                                                                                              (unsafe-car lst_89))
                                                                                             ((rest_48)
                                                                                              (unsafe-cdr lst_89)))
                                                                                  (let-values (((post-guard-var_6)
                                                                                                (lambda () #t)))
                                                                                    (let-values ()
                                                                                      (let-values (((elem_5)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (list
                                                                                                         ids_36
                                                                                                         (schemify_1
                                                                                                          rhs_30))))))
                                                                                        (let-values (((result_47)
                                                                                                      (if (post-guard-var_6)
                                                                                                        (for-loop_39
                                                                                                         rest_47
                                                                                                         rest_48)
                                                                                                        null)))
                                                                                          (cons elem_5 result_47))))))
                                                                                null))))
                                                             for-loop_39)
                                                           lst_86
                                                           lst_87)))
                                                      (map2 schemify_1 bodys_18))
                                                     mutated_17))
                                                  (if (if (pair? v_46)
                                                        (if (let-values (((a_293) (car v_46)))
                                                              (equal? 'letrec-values a_293))
                                                          (let-values (((d_284) (cdr v_46)))
                                                            (if (pair? d_284)
                                                              (if (let-values (((a_294) (car d_284)))
                                                                    (if (list? a_294)
                                                                      (let-values (((lst_90) a_294))
                                                                        (begin
                                                                          (check-list lst_90)
                                                                          ((letrec-values (((for-loop_40)
                                                                                            (lambda (result_48 lst_91)
                                                                                              (if (pair? lst_91)
                                                                                                (let-values (((v_56)
                                                                                                              (unsafe-car
                                                                                                               lst_91))
                                                                                                             ((rest_49)
                                                                                                              (unsafe-cdr
                                                                                                               lst_91)))
                                                                                                  (let-values (((result_49)
                                                                                                                (let-values ()
                                                                                                                  (let-values (((result_50)
                                                                                                                                (let-values ()
                                                                                                                                  (let-values ()
                                                                                                                                    (if (pair?
                                                                                                                                         v_56)
                                                                                                                                      (if (let-values (((a_295)
                                                                                                                                                        (car
                                                                                                                                                         v_56)))
                                                                                                                                            (if (pair?
                                                                                                                                                 a_295)
                                                                                                                                              (if (let-values (((a_296)
                                                                                                                                                                (car
                                                                                                                                                                 a_295)))
                                                                                                                                                    #t)
                                                                                                                                                (let-values (((d_285)
                                                                                                                                                              (cdr
                                                                                                                                                               a_295)))
                                                                                                                                                  (equal?
                                                                                                                                                   '()
                                                                                                                                                   d_285))
                                                                                                                                                #f)
                                                                                                                                              #f))
                                                                                                                                        (let-values (((d_286)
                                                                                                                                                      (cdr
                                                                                                                                                       v_56)))
                                                                                                                                          (if (pair?
                                                                                                                                               d_286)
                                                                                                                                            (if (let-values (((a_297)
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
                                                                                                                     result_50)))))
                                                                                                    (if (if (not
                                                                                                             ((lambda x_14
                                                                                                                (not
                                                                                                                 result_49))
                                                                                                              v_56))
                                                                                                          (not #f)
                                                                                                          #f)
                                                                                                      (for-loop_40
                                                                                                       result_49
                                                                                                       rest_49)
                                                                                                      result_49)))
                                                                                                result_48))))
                                                                             for-loop_40)
                                                                           #t
                                                                           lst_90)))
                                                                      #f))
                                                                (let-values (((d_288) (cdr d_284))) (list? d_288))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f)
                                                    (let-values (((ids_37 rhss_66 bodys_20)
                                                                  (let-values (((d_289) (cdr v_46)))
                                                                    (let-values (((ids_38 rhss_67)
                                                                                  (let-values (((a_298) (car d_289)))
                                                                                    (let-values (((ids_39 rhss_68)
                                                                                                  (let-values (((lst_92)
                                                                                                                a_298))
                                                                                                    (begin
                                                                                                      (check-list
                                                                                                       lst_92)
                                                                                                      ((letrec-values (((for-loop_41)
                                                                                                                        (lambda (ids_40
                                                                                                                                 rhss_69
                                                                                                                                 lst_93)
                                                                                                                          (if (pair?
                                                                                                                               lst_93)
                                                                                                                            (let-values (((v_57)
                                                                                                                                          (unsafe-car
                                                                                                                                           lst_93))
                                                                                                                                         ((rest_50)
                                                                                                                                          (unsafe-cdr
                                                                                                                                           lst_93)))
                                                                                                                              (let-values (((ids_41
                                                                                                                                             rhss_70)
                                                                                                                                            (let-values (((ids_42)
                                                                                                                                                          ids_40)
                                                                                                                                                         ((rhss_71)
                                                                                                                                                          rhss_69))
                                                                                                                                              (let-values (((ids_43
                                                                                                                                                             rhss_72)
                                                                                                                                                            (let-values ()
                                                                                                                                                              (let-values (((ids23_0
                                                                                                                                                                             rhss24_0)
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (let-values (((ids_44)
                                                                                                                                                                                            (let-values (((a_299)
                                                                                                                                                                                                          (car
                                                                                                                                                                                                           v_57)))
                                                                                                                                                                                              (let-values (((a_300)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             a_299)))
                                                                                                                                                                                                a_300)))
                                                                                                                                                                                           ((rhss_73)
                                                                                                                                                                                            (let-values (((d_290)
                                                                                                                                                                                                          (cdr
                                                                                                                                                                                                           v_57)))
                                                                                                                                                                                              (let-values (((a_301)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             d_290)))
                                                                                                                                                                                                a_301))))
                                                                                                                                                                                (values
                                                                                                                                                                                 ids_44
                                                                                                                                                                                 rhss_73)))))
                                                                                                                                                                (values
                                                                                                                                                                 (cons
                                                                                                                                                                  ids23_0
                                                                                                                                                                  ids_42)
                                                                                                                                                                 (cons
                                                                                                                                                                  rhss24_0
                                                                                                                                                                  rhss_71))))))
                                                                                                                                                (values
                                                                                                                                                 ids_43
                                                                                                                                                 rhss_72)))))
                                                                                                                                (if (not
                                                                                                                                     #f)
                                                                                                                                  (for-loop_41
                                                                                                                                   ids_41
                                                                                                                                   rhss_70
                                                                                                                                   rest_50)
                                                                                                                                  (values
                                                                                                                                   ids_41
                                                                                                                                   rhss_70))))
                                                                                                                            (values
                                                                                                                             ids_40
                                                                                                                             rhss_69)))))
                                                                                                         for-loop_41)
                                                                                                       null
                                                                                                       null
                                                                                                       lst_92)))))
                                                                                      (values
                                                                                       (reverse$1 ids_39)
                                                                                       (reverse$1 rhss_68)))))
                                                                                 ((bodys_21)
                                                                                  (let-values (((d_291) (cdr d_289)))
                                                                                    d_291)))
                                                                      (values ids_38 rhss_67 bodys_21)))))
                                                      (let-values (((new-knowns_2)
                                                                    (let-values (((lst_94) ids_37) ((lst_95) rhss_66))
                                                                      (begin
                                                                        (check-list lst_94)
                                                                        (check-list lst_95)
                                                                        ((letrec-values (((for-loop_42)
                                                                                          (lambda (knowns_24
                                                                                                   lst_96
                                                                                                   lst_97)
                                                                                            (if (if (pair? lst_96)
                                                                                                  (pair? lst_97)
                                                                                                  #f)
                                                                                              (let-values (((id_14)
                                                                                                            (unsafe-car
                                                                                                             lst_96))
                                                                                                           ((rest_51)
                                                                                                            (unsafe-cdr
                                                                                                             lst_96))
                                                                                                           ((rhs_31)
                                                                                                            (unsafe-car
                                                                                                             lst_97))
                                                                                                           ((rest_52)
                                                                                                            (unsafe-cdr
                                                                                                             lst_97)))
                                                                                                (let-values (((knowns_25)
                                                                                                              (let-values (((knowns_26)
                                                                                                                            knowns_24))
                                                                                                                (let-values (((knowns_27)
                                                                                                                              (let-values ()
                                                                                                                                (if (lambda?
                                                                                                                                     rhs_31)
                                                                                                                                  (hash-set
                                                                                                                                   knowns_26
                                                                                                                                   id_14
                                                                                                                                   a-known-procedure)
                                                                                                                                  knowns_26))))
                                                                                                                  (values
                                                                                                                   knowns_27)))))
                                                                                                  (if (not #f)
                                                                                                    (for-loop_42
                                                                                                     knowns_25
                                                                                                     rest_51
                                                                                                     rest_52)
                                                                                                    knowns_25)))
                                                                                              knowns_24))))
                                                                           for-loop_42)
                                                                         knowns_19
                                                                         lst_94
                                                                         lst_95)))))
                                                        (let-values (((schemify_2)
                                                                      (make-schemify
                                                                       prim-knowns_7
                                                                       new-knowns_2
                                                                       mutated_17
                                                                       imports_17
                                                                       exports_7)))
                                                          (list*
                                                           'letrec*
                                                           (let-values (((lst_98) ids_37) ((lst_99) rhss_66))
                                                             (begin
                                                               (check-list lst_98)
                                                               (check-list lst_99)
                                                               ((letrec-values (((for-loop_43)
                                                                                 (lambda (lst_100 lst_101)
                                                                                   (if (if (pair? lst_100)
                                                                                         (pair? lst_101)
                                                                                         #f)
                                                                                     (let-values (((id_15)
                                                                                                   (unsafe-car lst_100))
                                                                                                  ((rest_53)
                                                                                                   (unsafe-cdr lst_100))
                                                                                                  ((rhs_32)
                                                                                                   (unsafe-car lst_101))
                                                                                                  ((rest_54)
                                                                                                   (unsafe-cdr
                                                                                                    lst_101)))
                                                                                       (let-values (((post-guard-var_7)
                                                                                                     (lambda () #t)))
                                                                                         (let-values ()
                                                                                           (let-values (((elem_6)
                                                                                                         (let-values ()
                                                                                                           (let-values ()
                                                                                                             (list
                                                                                                              id_15
                                                                                                              (schemify_2
                                                                                                               rhs_32))))))
                                                                                             (let-values (((result_51)
                                                                                                           (if (post-guard-var_7)
                                                                                                             (for-loop_43
                                                                                                              rest_53
                                                                                                              rest_54)
                                                                                                             null)))
                                                                                               (cons
                                                                                                elem_6
                                                                                                result_51))))))
                                                                                     null))))
                                                                  for-loop_43)
                                                                lst_98
                                                                lst_99)))
                                                           (map2 schemify_2 bodys_20)))))
                                                    (if (if (pair? v_46)
                                                          (if (let-values (((a_302) (car v_46)))
                                                                (equal? 'letrec-values a_302))
                                                            (let-values (((d_292) (cdr v_46)))
                                                              (if (pair? d_292)
                                                                (if (let-values (((a_303) (car d_292)))
                                                                      (if (list? a_303)
                                                                        (let-values (((lst_102) a_303))
                                                                          (begin
                                                                            (check-list lst_102)
                                                                            ((letrec-values (((for-loop_44)
                                                                                              (lambda (result_52
                                                                                                       lst_103)
                                                                                                (if (pair? lst_103)
                                                                                                  (let-values (((v_58)
                                                                                                                (unsafe-car
                                                                                                                 lst_103))
                                                                                                               ((rest_55)
                                                                                                                (unsafe-cdr
                                                                                                                 lst_103)))
                                                                                                    (let-values (((result_53)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((result_54)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values ()
                                                                                                                                      (if (pair?
                                                                                                                                           v_58)
                                                                                                                                        (if (let-values (((a_304)
                                                                                                                                                          (car
                                                                                                                                                           v_58)))
                                                                                                                                              (list?
                                                                                                                                               a_304))
                                                                                                                                          (let-values (((d_293)
                                                                                                                                                        (cdr
                                                                                                                                                         v_58)))
                                                                                                                                            (if (pair?
                                                                                                                                                 d_293)
                                                                                                                                              (if (let-values (((a_305)
                                                                                                                                                                (car
                                                                                                                                                                 d_293)))
                                                                                                                                                    #t)
                                                                                                                                                (let-values (((d_294)
                                                                                                                                                              (cdr
                                                                                                                                                               d_293)))
                                                                                                                                                  (equal?
                                                                                                                                                   '()
                                                                                                                                                   d_294))
                                                                                                                                                #f)
                                                                                                                                              #f))
                                                                                                                                          #f)
                                                                                                                                        #f)))))
                                                                                                                      (values
                                                                                                                       result_54)))))
                                                                                                      (if (if (not
                                                                                                               ((lambda x_15
                                                                                                                  (not
                                                                                                                   result_53))
                                                                                                                v_58))
                                                                                                            (not #f)
                                                                                                            #f)
                                                                                                        (for-loop_44
                                                                                                         result_53
                                                                                                         rest_55)
                                                                                                        result_53)))
                                                                                                  result_52))))
                                                                               for-loop_44)
                                                                             #t
                                                                             lst_102)))
                                                                        #f))
                                                                  (let-values (((d_295) (cdr d_292))) (list? d_295))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f)
                                                      (let-values (((idss_25 rhss_74 bodys_22)
                                                                    (let-values (((d_296) (cdr v_46)))
                                                                      (let-values (((idss_26 rhss_75)
                                                                                    (let-values (((a_306) (car d_296)))
                                                                                      (let-values (((idss_27 rhss_76)
                                                                                                    (let-values (((lst_104)
                                                                                                                  a_306))
                                                                                                      (begin
                                                                                                        (check-list
                                                                                                         lst_104)
                                                                                                        ((letrec-values (((for-loop_45)
                                                                                                                          (lambda (idss_28
                                                                                                                                   rhss_77
                                                                                                                                   lst_105)
                                                                                                                            (if (pair?
                                                                                                                                 lst_105)
                                                                                                                              (let-values (((v_59)
                                                                                                                                            (unsafe-car
                                                                                                                                             lst_105))
                                                                                                                                           ((rest_56)
                                                                                                                                            (unsafe-cdr
                                                                                                                                             lst_105)))
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
                                                                                                                                                                                              (let-values (((a_307)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             v_59)))
                                                                                                                                                                                                a_307))
                                                                                                                                                                                             ((rhss_81)
                                                                                                                                                                                              (let-values (((d_297)
                                                                                                                                                                                                            (cdr
                                                                                                                                                                                                             v_59)))
                                                                                                                                                                                                (let-values (((a_308)
                                                                                                                                                                                                              (car
                                                                                                                                                                                                               d_297)))
                                                                                                                                                                                                  a_308))))
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
                                                                                                                                    (for-loop_45
                                                                                                                                     idss_29
                                                                                                                                     rhss_78
                                                                                                                                     rest_56)
                                                                                                                                    (values
                                                                                                                                     idss_29
                                                                                                                                     rhss_78))))
                                                                                                                              (values
                                                                                                                               idss_28
                                                                                                                               rhss_77)))))
                                                                                                           for-loop_45)
                                                                                                         null
                                                                                                         null
                                                                                                         lst_104)))))
                                                                                        (values
                                                                                         (reverse$1 idss_27)
                                                                                         (reverse$1 rhss_76)))))
                                                                                   ((bodys_23)
                                                                                    (let-values (((d_298) (cdr d_296)))
                                                                                      d_298)))
                                                                        (values idss_26 rhss_75 bodys_23)))))
                                                        (list*
                                                         'letrec*
                                                         (apply
                                                          append
                                                          (let-values (((lst_106) idss_25) ((lst_107) rhss_74))
                                                            (begin
                                                              (check-list lst_106)
                                                              (check-list lst_107)
                                                              ((letrec-values (((for-loop_46)
                                                                                (lambda (lst_108 lst_109)
                                                                                  (if (if (pair? lst_108)
                                                                                        (pair? lst_109)
                                                                                        #f)
                                                                                    (let-values (((ids_45)
                                                                                                  (unsafe-car lst_108))
                                                                                                 ((rest_57)
                                                                                                  (unsafe-cdr lst_108))
                                                                                                 ((rhs_33)
                                                                                                  (unsafe-car lst_109))
                                                                                                 ((rest_58)
                                                                                                  (unsafe-cdr lst_109)))
                                                                                      (let-values (((post-guard-var_8)
                                                                                                    (lambda () #t)))
                                                                                        (let-values ()
                                                                                          (let-values (((elem_7)
                                                                                                        (let-values ()
                                                                                                          (let-values ()
                                                                                                            (let-values (((rhs_34)
                                                                                                                          (schemify_1
                                                                                                                           rhs_33)))
                                                                                                              (if (null?
                                                                                                                   ids_45)
                                                                                                                (let-values ()
                                                                                                                  (list
                                                                                                                   (list
                                                                                                                    (gensym
                                                                                                                     "lr")
                                                                                                                    (make-let-values
                                                                                                                     null
                                                                                                                     rhs_34
                                                                                                                     '(void)))))
                                                                                                                (if (if (pair?
                                                                                                                         ids_45)
                                                                                                                      (null?
                                                                                                                       (cdr
                                                                                                                        ids_45))
                                                                                                                      #f)
                                                                                                                  (let-values ()
                                                                                                                    (list
                                                                                                                     (list
                                                                                                                      ids_45
                                                                                                                      rhs_34)))
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((lr_0)
                                                                                                                                  (gensym
                                                                                                                                   "lr")))
                                                                                                                      (list*
                                                                                                                       (list
                                                                                                                        lr_0
                                                                                                                        (make-let-values
                                                                                                                         ids_45
                                                                                                                         rhs_34
                                                                                                                         (list*
                                                                                                                          'vector
                                                                                                                          ids_45)))
                                                                                                                       (let-values (((lst_110)
                                                                                                                                     ids_45)
                                                                                                                                    ((start_2)
                                                                                                                                     0))
                                                                                                                         (begin
                                                                                                                           (check-list
                                                                                                                            lst_110)
                                                                                                                           (check-naturals
                                                                                                                            start_2)
                                                                                                                           ((letrec-values (((for-loop_47)
                                                                                                                                             (lambda (lst_111
                                                                                                                                                      pos_4)
                                                                                                                                               (if (if (pair?
                                                                                                                                                        lst_111)
                                                                                                                                                     #t
                                                                                                                                                     #f)
                                                                                                                                                 (let-values (((id_16)
                                                                                                                                                               (unsafe-car
                                                                                                                                                                lst_111))
                                                                                                                                                              ((rest_59)
                                                                                                                                                               (unsafe-cdr
                                                                                                                                                                lst_111))
                                                                                                                                                              ((pos_5)
                                                                                                                                                               pos_4))
                                                                                                                                                   (let-values (((post-guard-var_9)
                                                                                                                                                                 (lambda ()
                                                                                                                                                                   #t)))
                                                                                                                                                     (let-values ()
                                                                                                                                                       (let-values (((elem_8)
                                                                                                                                                                     (let-values ()
                                                                                                                                                                       (let-values ()
                                                                                                                                                                         (list
                                                                                                                                                                          id_16
                                                                                                                                                                          (list
                                                                                                                                                                           'vector-ref
                                                                                                                                                                           lr_0
                                                                                                                                                                           pos_5))))))
                                                                                                                                                         (let-values (((result_55)
                                                                                                                                                                       (if (post-guard-var_9)
                                                                                                                                                                         (for-loop_47
                                                                                                                                                                          rest_59
                                                                                                                                                                          (+
                                                                                                                                                                           pos_4
                                                                                                                                                                           1))
                                                                                                                                                                         null)))
                                                                                                                                                           (cons
                                                                                                                                                            elem_8
                                                                                                                                                            result_55))))))
                                                                                                                                                 null))))
                                                                                                                              for-loop_47)
                                                                                                                            lst_110
                                                                                                                            start_2)))))))))))))
                                                                                            (let-values (((result_56)
                                                                                                          (if (post-guard-var_8)
                                                                                                            (for-loop_46
                                                                                                             rest_57
                                                                                                             rest_58)
                                                                                                            null)))
                                                                                              (cons
                                                                                               elem_7
                                                                                               result_56))))))
                                                                                    null))))
                                                                 for-loop_46)
                                                               lst_106
                                                               lst_107))))
                                                         (map2 schemify_1 bodys_22)))
                                                      (if (if (pair? v_46)
                                                            (if (let-values (((a_309) (car v_46))) (equal? 'if a_309))
                                                              (let-values (((d_299) (cdr v_46)))
                                                                (if (pair? d_299)
                                                                  (if (let-values (((a_310) (car d_299))) #t)
                                                                    (let-values (((d_300) (cdr d_299)))
                                                                      (if (pair? d_300)
                                                                        (if (let-values (((a_311) (car d_300))) #t)
                                                                          (let-values (((d_301) (cdr d_300)))
                                                                            (if (pair? d_301)
                                                                              (if (let-values (((a_312) (car d_301)))
                                                                                    #t)
                                                                                (let-values (((d_302) (cdr d_301)))
                                                                                  (equal? '() d_302))
                                                                                #f)
                                                                              #f))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f)
                                                        (let-values (((tst_0 thn_0 els_0)
                                                                      (let-values (((d_303) (cdr v_46)))
                                                                        (let-values (((tst_1)
                                                                                      (let-values (((a_313)
                                                                                                    (car d_303)))
                                                                                        a_313))
                                                                                     ((thn_1 els_1)
                                                                                      (let-values (((d_304)
                                                                                                    (cdr d_303)))
                                                                                        (let-values (((thn_2)
                                                                                                      (let-values (((a_314)
                                                                                                                    (car
                                                                                                                     d_304)))
                                                                                                        a_314))
                                                                                                     ((els_2)
                                                                                                      (let-values (((d_305)
                                                                                                                    (cdr
                                                                                                                     d_304)))
                                                                                                        (let-values (((a_315)
                                                                                                                      (car
                                                                                                                       d_305)))
                                                                                                          a_315))))
                                                                                          (values thn_2 els_2)))))
                                                                          (values tst_1 thn_1 els_1)))))
                                                          (list
                                                           'if
                                                           (schemify_1 tst_0)
                                                           (schemify_1 thn_0)
                                                           (schemify_1 els_0)))
                                                        (if (if (pair? v_46)
                                                              (if (let-values (((a_316) (car v_46)))
                                                                    (equal? 'with-continuation-mark a_316))
                                                                (let-values (((d_306) (cdr v_46)))
                                                                  (if (pair? d_306)
                                                                    (if (let-values (((a_317) (car d_306))) #t)
                                                                      (let-values (((d_307) (cdr d_306)))
                                                                        (if (pair? d_307)
                                                                          (if (let-values (((a_318) (car d_307))) #t)
                                                                            (let-values (((d_308) (cdr d_307)))
                                                                              (if (pair? d_308)
                                                                                (if (let-values (((a_319) (car d_308)))
                                                                                      #t)
                                                                                  (let-values (((d_309) (cdr d_308)))
                                                                                    (equal? '() d_309))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                      #f)
                                                                    #f))
                                                                #f)
                                                              #f)
                                                          (let-values (((key_1 val_0 body_18)
                                                                        (let-values (((d_310) (cdr v_46)))
                                                                          (let-values (((key_2)
                                                                                        (let-values (((a_320)
                                                                                                      (car d_310)))
                                                                                          a_320))
                                                                                       ((val_1 body_19)
                                                                                        (let-values (((d_311)
                                                                                                      (cdr d_310)))
                                                                                          (let-values (((val_2)
                                                                                                        (let-values (((a_321)
                                                                                                                      (car
                                                                                                                       d_311)))
                                                                                                          a_321))
                                                                                                       ((body_20)
                                                                                                        (let-values (((d_312)
                                                                                                                      (cdr
                                                                                                                       d_311)))
                                                                                                          (let-values (((a_322)
                                                                                                                        (car
                                                                                                                         d_312)))
                                                                                                            a_322))))
                                                                                            (values val_2 body_20)))))
                                                                            (values key_2 val_1 body_19)))))
                                                            (list
                                                             'with-continuation-mark
                                                             (schemify_1 key_1)
                                                             (schemify_1 val_0)
                                                             (schemify_1 body_18)))
                                                          (if (if (pair? v_46)
                                                                (if (let-values (((a_323) (car v_46)))
                                                                      (equal? 'begin a_323))
                                                                  (let-values (((d_313) (cdr v_46))) (list? d_313))
                                                                  #f)
                                                                #f)
                                                            (let-values (((exps_0)
                                                                          (let-values (((d_314) (cdr v_46))) d_314)))
                                                              (list* 'begin (map2 schemify_1 exps_0)))
                                                            (if (if (pair? v_46)
                                                                  (if (let-values (((a_324) (car v_46)))
                                                                        (equal? 'begin0 a_324))
                                                                    (let-values (((d_315) (cdr v_46))) (list? d_315))
                                                                    #f)
                                                                  #f)
                                                              (let-values (((exps_1)
                                                                            (let-values (((d_316) (cdr v_46))) d_316)))
                                                                (list* 'begin0 (map2 schemify_1 exps_1)))
                                                              (if (if (pair? v_46)
                                                                    (if (let-values (((a_325) (car v_46)))
                                                                          (equal? 'set! a_325))
                                                                      (let-values (((d_317) (cdr v_46)))
                                                                        (if (pair? d_317)
                                                                          (if (let-values (((a_326) (car d_317))) #t)
                                                                            (let-values (((d_318) (cdr d_317)))
                                                                              (if (pair? d_318)
                                                                                (if (let-values (((a_327) (car d_318)))
                                                                                      #t)
                                                                                  (let-values (((d_319) (cdr d_318)))
                                                                                    (equal? '() d_319))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                      #f)
                                                                    #f)
                                                                (let-values (((id_17 rhs_35)
                                                                              (let-values (((d_320) (cdr v_46)))
                                                                                (let-values (((id_18)
                                                                                              (let-values (((a_328)
                                                                                                            (car
                                                                                                             d_320)))
                                                                                                a_328))
                                                                                             ((rhs_36)
                                                                                              (let-values (((d_321)
                                                                                                            (cdr
                                                                                                             d_320)))
                                                                                                (let-values (((a_329)
                                                                                                              (car
                                                                                                               d_321)))
                                                                                                  a_329))))
                                                                                  (values id_18 rhs_36)))))
                                                                  (let-values (((ex-id_0)
                                                                                (hash-ref exports_7 id_17 #f)))
                                                                    (if ex-id_0
                                                                      (list 'variable-set! ex-id_0 (schemify_1 rhs_35))
                                                                      (list 'set! id_17 (schemify_1 rhs_35)))))
                                                                (if (if (pair? v_46)
                                                                      (if (let-values (((a_330) (car v_46)))
                                                                            (equal?
                                                                             'variable-reference-constant?
                                                                             a_330))
                                                                        (let-values (((d_322) (cdr v_46)))
                                                                          (if (pair? d_322)
                                                                            (if (let-values (((a_331) (car d_322)))
                                                                                  (if (pair? a_331)
                                                                                    (if (let-values (((a_332)
                                                                                                      (car a_331)))
                                                                                          (equal?
                                                                                           '#%variable-reference
                                                                                           a_332))
                                                                                      (let-values (((d_323)
                                                                                                    (cdr a_331)))
                                                                                        (if (pair? d_323)
                                                                                          (if (let-values (((a_333)
                                                                                                            (car
                                                                                                             d_323)))
                                                                                                #t)
                                                                                            (let-values (((d_324)
                                                                                                          (cdr d_323)))
                                                                                              (equal? '() d_324))
                                                                                            #f)
                                                                                          #f))
                                                                                      #f)
                                                                                    #f))
                                                                              (let-values (((d_325) (cdr d_322)))
                                                                                (equal? '() d_325))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f)
                                                                  (let-values (((id_19)
                                                                                (let-values (((d_326) (cdr v_46)))
                                                                                  (let-values (((a_334) (car d_326)))
                                                                                    (let-values (((d_327) (cdr a_334)))
                                                                                      (let-values (((a_335)
                                                                                                    (car d_327)))
                                                                                        a_335))))))
                                                                    (if (not (hash-ref mutated_17 id_19 #f))
                                                                      (let-values (((im_3)
                                                                                    (hash-ref imports_17 id_19 #f)))
                                                                        (let-values (((or-part_10) (not im_3)))
                                                                          (if or-part_10
                                                                            or-part_10
                                                                            (known-constant?
                                                                             (hash-ref
                                                                              (import-group-knowns (import-grp im_3))
                                                                              (import-ext-id im_3)
                                                                              #f)))))
                                                                      #f))
                                                                  (if (if (pair? v_46)
                                                                        (if (let-values (((a_336) (car v_46)))
                                                                              (equal? '#%variable-reference a_336))
                                                                          (let-values (((d_328) (cdr v_46)))
                                                                            (equal? '() d_328))
                                                                          #f)
                                                                        #f)
                                                                    (let-values () 'instance-variable-reference)
                                                                    (if (if (pair? v_46)
                                                                          (if (let-values (((a_337) (car v_46)))
                                                                                (equal? '#%variable-reference a_337))
                                                                            (let-values (((d_329) (cdr v_46)))
                                                                              (if (pair? d_329)
                                                                                (if (let-values (((a_338) (car d_329)))
                                                                                      #t)
                                                                                  (let-values (((d_330) (cdr d_329)))
                                                                                    (equal? '() d_330))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f)
                                                                      (let-values (((id_20)
                                                                                    (let-values (((d_331) (cdr v_46)))
                                                                                      (let-values (((a_339)
                                                                                                    (car d_331)))
                                                                                        a_339))))
                                                                        (let-values (((e_2)
                                                                                      (hash-ref exports_7 id_20 #f)))
                                                                          (if e_2
                                                                            (list
                                                                             'make-instance-variable-reference
                                                                             'instance-variable-reference
                                                                             e_2)
                                                                            (list
                                                                             'make-instance-variable-reference
                                                                             'instance-variable-reference
                                                                             (if (hash-ref mutated_17 v_45 #f)
                                                                               'mutable
                                                                               'immutable)))))
                                                                      (if (if (pair? v_46)
                                                                            (if (let-values (((a_340) (car v_46))) #t)
                                                                              (let-values (((d_332) (cdr v_46)))
                                                                                (list? d_332))
                                                                              #f)
                                                                            #f)
                                                                        (let-values (((rator_0 exps_2)
                                                                                      (let-values (((rator_1)
                                                                                                    (let-values (((a_341)
                                                                                                                  (car
                                                                                                                   v_46)))
                                                                                                      a_341))
                                                                                                   ((exps_3)
                                                                                                    (let-values (((d_333)
                                                                                                                  (cdr
                                                                                                                   v_46)))
                                                                                                      d_333)))
                                                                                        (values rator_1 exps_3))))
                                                                          (let-values (((args_4)
                                                                                        (map2 schemify_1 exps_2)))
                                                                            (left-to-right/app
                                                                             (if (let-values (((or-part_11)
                                                                                               (known-procedure?
                                                                                                (hash-ref-either
                                                                                                 knowns_19
                                                                                                 imports_17
                                                                                                 rator_0))))
                                                                                   (if or-part_11
                                                                                     or-part_11
                                                                                     (let-values (((or-part_12)
                                                                                                   (known-procedure?
                                                                                                    (hash-ref
                                                                                                     prim-knowns_7
                                                                                                     rator_0
                                                                                                     #f))))
                                                                                       (if or-part_12
                                                                                         or-part_12
                                                                                         (lambda? rator_0)))))
                                                                               (list* (schemify_1 rator_0) args_4)
                                                                               (list*
                                                                                '#%app
                                                                                (schemify_1 rator_0)
                                                                                args_4))
                                                                             prim-knowns_7
                                                                             knowns_19
                                                                             imports_17
                                                                             mutated_17)))
                                                                        (let-values ()
                                                                          (let-values (((c1_0)
                                                                                        (if (symbol? v_45)
                                                                                          (if (hash-ref
                                                                                               mutated_17
                                                                                               v_45
                                                                                               #f)
                                                                                            (hash-ref exports_7 v_45 #f)
                                                                                            #f)
                                                                                          #f)))
                                                                            (if c1_0
                                                                              ((lambda (ex-id_1)
                                                                                 (list 'variable-ref ex-id_1))
                                                                               c1_0)
                                                                              (let-values (((c2_0)
                                                                                            (if (symbol? v_45)
                                                                                              (hash-ref
                                                                                               imports_17
                                                                                               v_45
                                                                                               #f)
                                                                                              #f)))
                                                                                (if c2_0
                                                                                  ((lambda (im_4)
                                                                                     (list
                                                                                      'variable-ref
                                                                                      (import-id im_4)))
                                                                                   c2_0)
                                                                                  (let-values ()
                                                                                    v_45))))))))))))))))))))))))))))))))
         schemify_1)
       v_44))))
 (define-values
  (mutated-in-body)
  (lambda (l_13 exports_8 prim-knowns_8 knowns_28 imports_18)
    (let-values (((pending_0)
                  (let-values (((lst_112) l_13))
                    (begin
                      (check-list lst_112)
                      ((letrec-values (((for-loop_48)
                                        (lambda (pending_1 lst_113)
                                          (if (pair? lst_113)
                                            (let-values (((v_60) (unsafe-car lst_113)) ((rest_60) (unsafe-cdr lst_113)))
                                              (let-values (((pending_2)
                                                            (let-values (((pending_3) pending_1))
                                                              (let-values (((pending_4)
                                                                            (let-values ()
                                                                              (let-values (((v_61) v_60))
                                                                                (if (if (pair? v_61)
                                                                                      (if (let-values (((a_342)
                                                                                                        (car v_61)))
                                                                                            (equal?
                                                                                             'define-values
                                                                                             a_342))
                                                                                        (let-values (((d_334)
                                                                                                      (cdr v_61)))
                                                                                          (if (pair? d_334)
                                                                                            (if (let-values (((a_343)
                                                                                                              (car
                                                                                                               d_334)))
                                                                                                  #t)
                                                                                              (let-values (((d_335)
                                                                                                            (cdr
                                                                                                             d_334)))
                                                                                                (if (pair? d_335)
                                                                                                  (if (let-values (((a_344)
                                                                                                                    (car
                                                                                                                     d_335)))
                                                                                                        #t)
                                                                                                    (let-values (((d_336)
                                                                                                                  (cdr
                                                                                                                   d_335)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_336))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f)
                                                                                  (let-values (((ids_46 rhs_37)
                                                                                                (let-values (((d_337)
                                                                                                              (cdr
                                                                                                               v_61)))
                                                                                                  (let-values (((ids_47)
                                                                                                                (let-values (((a_345)
                                                                                                                              (car
                                                                                                                               d_337)))
                                                                                                                  a_345))
                                                                                                               ((rhs_38)
                                                                                                                (let-values (((d_338)
                                                                                                                              (cdr
                                                                                                                               d_337)))
                                                                                                                  (let-values (((a_346)
                                                                                                                                (car
                                                                                                                                 d_338)))
                                                                                                                    a_346))))
                                                                                                    (values
                                                                                                     ids_47
                                                                                                     rhs_38)))))
                                                                                    (let-values (((lst_114) ids_46))
                                                                                      (begin
                                                                                        (check-list lst_114)
                                                                                        ((letrec-values (((for-loop_49)
                                                                                                          (lambda (pending_5
                                                                                                                   lst_115)
                                                                                                            (if (pair?
                                                                                                                 lst_115)
                                                                                                              (let-values (((id_21)
                                                                                                                            (unsafe-car
                                                                                                                             lst_115))
                                                                                                                           ((rest_61)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_115)))
                                                                                                                (let-values (((pending_6)
                                                                                                                              (let-values (((pending_7)
                                                                                                                                            pending_5))
                                                                                                                                (let-values (((pending_8)
                                                                                                                                              (let-values ()
                                                                                                                                                (if (hash-ref
                                                                                                                                                     exports_8
                                                                                                                                                     id_21
                                                                                                                                                     #f)
                                                                                                                                                  (hash-set
                                                                                                                                                   pending_7
                                                                                                                                                   id_21
                                                                                                                                                   #t)
                                                                                                                                                  pending_7))))
                                                                                                                                  (values
                                                                                                                                   pending_8)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_49
                                                                                                                     pending_6
                                                                                                                     rest_61)
                                                                                                                    pending_6)))
                                                                                                              pending_5))))
                                                                                           for-loop_49)
                                                                                         pending_3
                                                                                         lst_114))))
                                                                                  (let-values () pending_3))))))
                                                                (values pending_4)))))
                                                (if (not #f) (for-loop_48 pending_2 rest_60) pending_2)))
                                            pending_1))))
                         for-loop_48)
                       exports_8
                       lst_112)))))
      ((letrec-values (((loop_9)
                        (lambda (mutated_18 l_14 delay-l_0 pending_9)
                          (if (null? l_14)
                            (let-values ()
                              (let-values (((lst_116) delay-l_0))
                                (begin
                                  (check-list lst_116)
                                  ((letrec-values (((for-loop_50)
                                                    (lambda (mutated_19 lst_117)
                                                      (if (pair? lst_117)
                                                        (let-values (((v_62) (unsafe-car lst_117))
                                                                     ((rest_62) (unsafe-cdr lst_117)))
                                                          (let-values (((mutated_20)
                                                                        (let-values (((mutated_21) mutated_19))
                                                                          (let-values (((mutated_22)
                                                                                        (let-values ()
                                                                                          (find-mutated
                                                                                           v_62
                                                                                           prim-knowns_8
                                                                                           knowns_28
                                                                                           imports_18
                                                                                           mutated_21
                                                                                           pending_9))))
                                                                            (values mutated_22)))))
                                                            (if (not #f) (for-loop_50 mutated_20 rest_62) mutated_20)))
                                                        mutated_19))))
                                     for-loop_50)
                                   mutated_18
                                   lst_116))))
                            (let-values ()
                              (let-values (((form_0) (car l_14)))
                                (let-values (((v_63) form_0))
                                  (if (if (pair? v_63)
                                        (if (let-values (((a_347) (car v_63))) (equal? 'define-values a_347))
                                          (let-values (((d_339) (cdr v_63)))
                                            (if (pair? d_339)
                                              (if (let-values (((a_348) (car d_339))) #t)
                                                (let-values (((d_340) (cdr d_339)))
                                                  (if (pair? d_340)
                                                    (if (let-values (((a_349) (car d_340))) #t)
                                                      (let-values (((d_341) (cdr d_340))) (equal? '() d_341))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((ids_48 rhs_39)
                                                  (let-values (((d_342) (cdr v_63)))
                                                    (let-values (((ids_49) (let-values (((a_350) (car d_342))) a_350))
                                                                 ((rhs_40)
                                                                  (let-values (((d_343) (cdr d_342)))
                                                                    (let-values (((a_351) (car d_343))) a_351))))
                                                      (values ids_49 rhs_40)))))
                                      (let-values (((next-pending_0)
                                                    (let-values (((lst_118) ids_48))
                                                      (begin
                                                        (check-list lst_118)
                                                        ((letrec-values (((for-loop_51)
                                                                          (lambda (pending_10 lst_119)
                                                                            (if (pair? lst_119)
                                                                              (let-values (((id_22)
                                                                                            (unsafe-car lst_119))
                                                                                           ((rest_63)
                                                                                            (unsafe-cdr lst_119)))
                                                                                (let-values (((pending_11)
                                                                                              (let-values (((pending_12)
                                                                                                            pending_10))
                                                                                                (let-values (((pending_13)
                                                                                                              (let-values ()
                                                                                                                (hash-remove
                                                                                                                 pending_12
                                                                                                                 id_22))))
                                                                                                  (values
                                                                                                   pending_13)))))
                                                                                  (if (not #f)
                                                                                    (for-loop_51 pending_11 rest_63)
                                                                                    pending_11)))
                                                                              pending_10))))
                                                           for-loop_51)
                                                         pending_9
                                                         lst_118)))))
                                        (if (lambda? rhs_39)
                                          (loop_9 mutated_18 (cdr l_14) (cons rhs_39 delay-l_0) next-pending_0)
                                          (let-values (((mutated_23)
                                                        (let-values (((lst_120) delay-l_0))
                                                          (begin
                                                            (check-list lst_120)
                                                            ((letrec-values (((for-loop_52)
                                                                              (lambda (mutated_24 lst_121)
                                                                                (if (pair? lst_121)
                                                                                  (let-values (((v_64)
                                                                                                (unsafe-car lst_121))
                                                                                               ((rest_64)
                                                                                                (unsafe-cdr lst_121)))
                                                                                    (let-values (((mutated_25)
                                                                                                  (let-values (((mutated_26)
                                                                                                                mutated_24))
                                                                                                    (let-values (((mutated_27)
                                                                                                                  (let-values ()
                                                                                                                    (find-mutated
                                                                                                                     v_64
                                                                                                                     prim-knowns_8
                                                                                                                     knowns_28
                                                                                                                     imports_18
                                                                                                                     mutated_26
                                                                                                                     pending_9))))
                                                                                                      (values
                                                                                                       mutated_27)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_52 mutated_25 rest_64)
                                                                                        mutated_25)))
                                                                                  mutated_24))))
                                                               for-loop_52)
                                                             mutated_18
                                                             lst_120)))))
                                            (loop_9
                                             (find-mutated
                                              rhs_39
                                              prim-knowns_8
                                              knowns_28
                                              imports_18
                                              mutated_23
                                              pending_9)
                                             (cdr l_14)
                                             null
                                             next-pending_0)))))
                                    (let-values ()
                                      (let-values (((mutated_28)
                                                    (let-values (((lst_122) delay-l_0))
                                                      (begin
                                                        (check-list lst_122)
                                                        ((letrec-values (((for-loop_53)
                                                                          (lambda (mutated_29 lst_123)
                                                                            (if (pair? lst_123)
                                                                              (let-values (((v_65) (unsafe-car lst_123))
                                                                                           ((rest_65)
                                                                                            (unsafe-cdr lst_123)))
                                                                                (let-values (((mutated_30)
                                                                                              (let-values (((mutated_31)
                                                                                                            mutated_29))
                                                                                                (let-values (((mutated_32)
                                                                                                              (let-values ()
                                                                                                                (find-mutated
                                                                                                                 v_65
                                                                                                                 prim-knowns_8
                                                                                                                 knowns_28
                                                                                                                 imports_18
                                                                                                                 mutated_31
                                                                                                                 pending_9))))
                                                                                                  (values
                                                                                                   mutated_32)))))
                                                                                  (if (not #f)
                                                                                    (for-loop_53 mutated_30 rest_65)
                                                                                    mutated_30)))
                                                                              mutated_29))))
                                                           for-loop_53)
                                                         mutated_18
                                                         lst_122)))))
                                        (loop_9
                                         (find-mutated form_0 prim-knowns_8 knowns_28 imports_18 mutated_28 pending_9)
                                         (cdr l_14)
                                         null
                                         pending_9)))))))))))
         loop_9)
       (hasheq)
       l_13
       null
       pending_0))))
 (define-values
  (find-mutated)
  (lambda (v_66 prim-knowns_9 knowns_29 imports_19 mutated_33 pending_14)
    ((letrec-values (((find-mutated_0)
                      (lambda (v_67 mutated_34 pending_15)
                        (let-values (((find-mutated*_0)
                                      (lambda (l_15 mutated_35 pending_16)
                                        (let-values (((lst_124) l_15))
                                          (begin
                                            (check-list lst_124)
                                            ((letrec-values (((for-loop_54)
                                                              (lambda (mutated_36 lst_125)
                                                                (if (pair? lst_125)
                                                                  (let-values (((v_68) (unsafe-car lst_125))
                                                                               ((rest_66) (unsafe-cdr lst_125)))
                                                                    (let-values (((mutated_37)
                                                                                  (let-values (((mutated_38)
                                                                                                mutated_36))
                                                                                    (let-values (((mutated_39)
                                                                                                  (let-values ()
                                                                                                    (find-mutated_0
                                                                                                     v_68
                                                                                                     mutated_38
                                                                                                     pending_16))))
                                                                                      (values mutated_39)))))
                                                                      (if (not #f)
                                                                        (for-loop_54 mutated_37 rest_66)
                                                                        mutated_37)))
                                                                  mutated_36))))
                                               for-loop_54)
                                             mutated_35
                                             lst_124))))))
                          (let-values (((v_69) v_67))
                            (if (if (pair? v_69)
                                  (if (let-values (((a_352) (car v_69))) (equal? 'lambda a_352))
                                    (let-values (((d_344) (cdr v_69)))
                                      (if (pair? d_344)
                                        (if (let-values (((a_353) (car d_344))) #t)
                                          (let-values (((d_345) (cdr d_344))) (list? d_345))
                                          #f)
                                        #f))
                                    #f)
                                  #f)
                              (let-values (((formals_3 body_21)
                                            (let-values (((d_346) (cdr v_69)))
                                              (let-values (((formals_4) (let-values (((a_354) (car d_346))) a_354))
                                                           ((body_22) (let-values (((d_347) (cdr d_346))) d_347)))
                                                (values formals_4 body_22)))))
                                (find-mutated*_0 body_21 mutated_34 pending_15))
                              (if (if (pair? v_69)
                                    (if (let-values (((a_355) (car v_69))) (equal? 'case-lambda a_355))
                                      (let-values (((d_348) (cdr v_69)))
                                        (if (list? d_348)
                                          (let-values (((lst_126) d_348))
                                            (begin
                                              (check-list lst_126)
                                              ((letrec-values (((for-loop_55)
                                                                (lambda (result_57 lst_127)
                                                                  (if (pair? lst_127)
                                                                    (let-values (((v_70) (unsafe-car lst_127))
                                                                                 ((rest_67) (unsafe-cdr lst_127)))
                                                                      (let-values (((result_58)
                                                                                    (let-values ()
                                                                                      (let-values (((result_59)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (if (pair? v_70)
                                                                                                          (if (let-values (((a_356)
                                                                                                                            (car
                                                                                                                             v_70)))
                                                                                                                #t)
                                                                                                            (let-values (((d_349)
                                                                                                                          (cdr
                                                                                                                           v_70)))
                                                                                                              (list?
                                                                                                               d_349))
                                                                                                            #f)
                                                                                                          #f)))))
                                                                                        (values result_59)))))
                                                                        (if (if (not
                                                                                 ((lambda x_16 (not result_58)) v_70))
                                                                              (not #f)
                                                                              #f)
                                                                          (for-loop_55 result_58 rest_67)
                                                                          result_58)))
                                                                    result_57))))
                                                 for-loop_55)
                                               #t
                                               lst_126)))
                                          #f))
                                      #f)
                                    #f)
                                (let-values (((formalss_7 bodys_24)
                                              (let-values (((d_350) (cdr v_69)))
                                                (let-values (((formalss_8 bodys_25)
                                                              (let-values (((lst_128) d_350))
                                                                (begin
                                                                  (check-list lst_128)
                                                                  ((letrec-values (((for-loop_56)
                                                                                    (lambda (formalss_9
                                                                                             bodys_26
                                                                                             lst_129)
                                                                                      (if (pair? lst_129)
                                                                                        (let-values (((v_71)
                                                                                                      (unsafe-car
                                                                                                       lst_129))
                                                                                                     ((rest_68)
                                                                                                      (unsafe-cdr
                                                                                                       lst_129)))
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
                                                                                                                                                        (let-values (((a_357)
                                                                                                                                                                      (car
                                                                                                                                                                       v_71)))
                                                                                                                                                          a_357))
                                                                                                                                                       ((bodys_30)
                                                                                                                                                        (let-values (((d_351)
                                                                                                                                                                      (cdr
                                                                                                                                                                       v_71)))
                                                                                                                                                          d_351)))
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
                                                                                               rest_68)
                                                                                              (values
                                                                                               formalss_10
                                                                                               bodys_27))))
                                                                                        (values formalss_9 bodys_26)))))
                                                                     for-loop_56)
                                                                   null
                                                                   null
                                                                   lst_128)))))
                                                  (values (reverse$1 formalss_8) (reverse$1 bodys_25))))))
                                  (let-values (((lst_130) bodys_24))
                                    (begin
                                      (check-list lst_130)
                                      ((letrec-values (((for-loop_57)
                                                        (lambda (mutated_40 lst_131)
                                                          (if (pair? lst_131)
                                                            (let-values (((body_23) (unsafe-car lst_131))
                                                                         ((rest_69) (unsafe-cdr lst_131)))
                                                              (let-values (((mutated_41)
                                                                            (let-values (((mutated_42) mutated_40))
                                                                              (let-values (((mutated_43)
                                                                                            (let-values ()
                                                                                              (find-mutated*_0
                                                                                               body_23
                                                                                               mutated_42
                                                                                               pending_15))))
                                                                                (values mutated_43)))))
                                                                (if (not #f)
                                                                  (for-loop_57 mutated_41 rest_69)
                                                                  mutated_41)))
                                                            mutated_40))))
                                         for-loop_57)
                                       mutated_34
                                       lst_130))))
                                (if (if (pair? v_69)
                                      (if (let-values (((a_358) (car v_69))) (equal? 'define-values a_358))
                                        (let-values (((d_352) (cdr v_69)))
                                          (if (pair? d_352)
                                            (if (let-values (((a_359) (car d_352))) #t)
                                              (let-values (((d_353) (cdr d_352)))
                                                (if (pair? d_353)
                                                  (if (let-values (((a_360) (car d_353))) #t)
                                                    (let-values (((d_354) (cdr d_353))) (equal? '() d_354))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f))
                                        #f)
                                      #f)
                                  (let-values (((ids_50 rhs_41)
                                                (let-values (((d_355) (cdr v_69)))
                                                  (let-values (((ids_51) (let-values (((a_361) (car d_355))) a_361))
                                                               ((rhs_42)
                                                                (let-values (((d_356) (cdr d_355)))
                                                                  (let-values (((a_362) (car d_356))) a_362))))
                                                    (values ids_51 rhs_42)))))
                                    (find-mutated_0 rhs_41 mutated_34 pending_15))
                                  (if (if (pair? v_69)
                                        (if (let-values (((a_363) (car v_69))) (equal? 'quote a_363))
                                          (let-values (((d_357) (cdr v_69)))
                                            (if (pair? d_357)
                                              (if (let-values (((a_364) (car d_357))) #t)
                                                (let-values (((d_358) (cdr d_357))) (equal? '() d_358))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values () mutated_34)
                                    (if (if (pair? v_69)
                                          (if (let-values (((a_365) (car v_69))) (equal? 'let-values a_365))
                                            (let-values (((d_359) (cdr v_69)))
                                              (if (pair? d_359)
                                                (if (let-values (((a_366) (car d_359)))
                                                      (if (list? a_366)
                                                        (let-values (((lst_132) a_366))
                                                          (begin
                                                            (check-list lst_132)
                                                            ((letrec-values (((for-loop_58)
                                                                              (lambda (result_60 lst_133)
                                                                                (if (pair? lst_133)
                                                                                  (let-values (((v_72)
                                                                                                (unsafe-car lst_133))
                                                                                               ((rest_70)
                                                                                                (unsafe-cdr lst_133)))
                                                                                    (let-values (((result_61)
                                                                                                  (let-values ()
                                                                                                    (let-values (((result_62)
                                                                                                                  (let-values ()
                                                                                                                    (let-values ()
                                                                                                                      (if (pair?
                                                                                                                           v_72)
                                                                                                                        (if (let-values (((a_367)
                                                                                                                                          (car
                                                                                                                                           v_72)))
                                                                                                                              (if (pair?
                                                                                                                                   a_367)
                                                                                                                                (if (let-values (((a_368)
                                                                                                                                                  (car
                                                                                                                                                   a_367)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_360)
                                                                                                                                                (cdr
                                                                                                                                                 a_367)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_360))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                          (let-values (((d_361)
                                                                                                                                        (cdr
                                                                                                                                         v_72)))
                                                                                                                            (if (pair?
                                                                                                                                 d_361)
                                                                                                                              (if (let-values (((a_369)
                                                                                                                                                (car
                                                                                                                                                 d_361)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_362)
                                                                                                                                              (cdr
                                                                                                                                               d_361)))
                                                                                                                                  (equal?
                                                                                                                                   '()
                                                                                                                                   d_362))
                                                                                                                                #f)
                                                                                                                              #f))
                                                                                                                          #f)
                                                                                                                        #f)))))
                                                                                                      (values
                                                                                                       result_62)))))
                                                                                      (if (if (not
                                                                                               ((lambda x_17
                                                                                                  (not result_61))
                                                                                                v_72))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_58 result_61 rest_70)
                                                                                        result_61)))
                                                                                  result_60))))
                                                               for-loop_58)
                                                             #t
                                                             lst_132)))
                                                        #f))
                                                  (let-values (((d_363) (cdr d_359))) (list? d_363))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((ids_52 rhss_82 bodys_31)
                                                    (let-values (((d_364) (cdr v_69)))
                                                      (let-values (((ids_53 rhss_83)
                                                                    (let-values (((a_370) (car d_364)))
                                                                      (let-values (((ids_54 rhss_84)
                                                                                    (let-values (((lst_134) a_370))
                                                                                      (begin
                                                                                        (check-list lst_134)
                                                                                        ((letrec-values (((for-loop_59)
                                                                                                          (lambda (ids_55
                                                                                                                   rhss_85
                                                                                                                   lst_135)
                                                                                                            (if (pair?
                                                                                                                 lst_135)
                                                                                                              (let-values (((v_73)
                                                                                                                            (unsafe-car
                                                                                                                             lst_135))
                                                                                                                           ((rest_71)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_135)))
                                                                                                                (let-values (((ids_56
                                                                                                                               rhss_86)
                                                                                                                              (let-values (((ids_57)
                                                                                                                                            ids_55)
                                                                                                                                           ((rhss_87)
                                                                                                                                            rhss_85))
                                                                                                                                (let-values (((ids_58
                                                                                                                                               rhss_88)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((ids29_0
                                                                                                                                                               rhss30_0)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((ids_59)
                                                                                                                                                                              (let-values (((a_371)
                                                                                                                                                                                            (car
                                                                                                                                                                                             v_73)))
                                                                                                                                                                                (let-values (((a_372)
                                                                                                                                                                                              (car
                                                                                                                                                                                               a_371)))
                                                                                                                                                                                  a_372)))
                                                                                                                                                                             ((rhss_89)
                                                                                                                                                                              (let-values (((d_365)
                                                                                                                                                                                            (cdr
                                                                                                                                                                                             v_73)))
                                                                                                                                                                                (let-values (((a_373)
                                                                                                                                                                                              (car
                                                                                                                                                                                               d_365)))
                                                                                                                                                                                  a_373))))
                                                                                                                                                                  (values
                                                                                                                                                                   ids_59
                                                                                                                                                                   rhss_89)))))
                                                                                                                                                  (values
                                                                                                                                                   (cons
                                                                                                                                                    ids29_0
                                                                                                                                                    ids_57)
                                                                                                                                                   (cons
                                                                                                                                                    rhss30_0
                                                                                                                                                    rhss_87))))))
                                                                                                                                  (values
                                                                                                                                   ids_58
                                                                                                                                   rhss_88)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_59
                                                                                                                     ids_56
                                                                                                                     rhss_86
                                                                                                                     rest_71)
                                                                                                                    (values
                                                                                                                     ids_56
                                                                                                                     rhss_86))))
                                                                                                              (values
                                                                                                               ids_55
                                                                                                               rhss_85)))))
                                                                                           for-loop_59)
                                                                                         null
                                                                                         null
                                                                                         lst_134)))))
                                                                        (values
                                                                         (reverse$1 ids_54)
                                                                         (reverse$1 rhss_84)))))
                                                                   ((bodys_32)
                                                                    (let-values (((d_366) (cdr d_364))) d_366)))
                                                        (values ids_53 rhss_83 bodys_32)))))
                                        (find-mutated*_0
                                         bodys_31
                                         (find-mutated*_0 rhss_82 mutated_34 pending_15)
                                         pending_15))
                                      (if (if (pair? v_69)
                                            (if (let-values (((a_374) (car v_69))) (equal? 'letrec-values a_374))
                                              (let-values (((d_367) (cdr v_69)))
                                                (if (pair? d_367)
                                                  (if (let-values (((a_375) (car d_367)))
                                                        (if (list? a_375)
                                                          (let-values (((lst_136) a_375))
                                                            (begin
                                                              (check-list lst_136)
                                                              ((letrec-values (((for-loop_60)
                                                                                (lambda (result_63 lst_137)
                                                                                  (if (pair? lst_137)
                                                                                    (let-values (((v_74)
                                                                                                  (unsafe-car lst_137))
                                                                                                 ((rest_72)
                                                                                                  (unsafe-cdr lst_137)))
                                                                                      (let-values (((result_64)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_65)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (if (pair?
                                                                                                                             v_74)
                                                                                                                          (if (let-values (((a_376)
                                                                                                                                            (car
                                                                                                                                             v_74)))
                                                                                                                                (list?
                                                                                                                                 a_376))
                                                                                                                            (let-values (((d_368)
                                                                                                                                          (cdr
                                                                                                                                           v_74)))
                                                                                                                              (if (pair?
                                                                                                                                   d_368)
                                                                                                                                (if (let-values (((a_377)
                                                                                                                                                  (car
                                                                                                                                                   d_368)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_369)
                                                                                                                                                (cdr
                                                                                                                                                 d_368)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_369))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                            #f)
                                                                                                                          #f)))))
                                                                                                        (values
                                                                                                         result_65)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_18
                                                                                                    (not result_64))
                                                                                                  v_74))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_60
                                                                                           result_64
                                                                                           rest_72)
                                                                                          result_64)))
                                                                                    result_63))))
                                                                 for-loop_60)
                                                               #t
                                                               lst_136)))
                                                          #f))
                                                    (let-values (((d_370) (cdr d_367))) (list? d_370))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((idss_33 rhss_90 bodys_33)
                                                      (let-values (((d_371) (cdr v_69)))
                                                        (let-values (((idss_34 rhss_91)
                                                                      (let-values (((a_378) (car d_371)))
                                                                        (let-values (((idss_35 rhss_92)
                                                                                      (let-values (((lst_138) a_378))
                                                                                        (begin
                                                                                          (check-list lst_138)
                                                                                          ((letrec-values (((for-loop_61)
                                                                                                            (lambda (idss_36
                                                                                                                     rhss_93
                                                                                                                     lst_139)
                                                                                                              (if (pair?
                                                                                                                   lst_139)
                                                                                                                (let-values (((v_75)
                                                                                                                              (unsafe-car
                                                                                                                               lst_139))
                                                                                                                             ((rest_73)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_139)))
                                                                                                                  (let-values (((idss_37
                                                                                                                                 rhss_94)
                                                                                                                                (let-values (((idss_38)
                                                                                                                                              idss_36)
                                                                                                                                             ((rhss_95)
                                                                                                                                              rhss_93))
                                                                                                                                  (let-values (((idss_39
                                                                                                                                                 rhss_96)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values (((idss31_0
                                                                                                                                                                 rhss32_0)
                                                                                                                                                                (let-values ()
                                                                                                                                                                  (let-values (((idss_40)
                                                                                                                                                                                (let-values (((a_379)
                                                                                                                                                                                              (car
                                                                                                                                                                                               v_75)))
                                                                                                                                                                                  a_379))
                                                                                                                                                                               ((rhss_97)
                                                                                                                                                                                (let-values (((d_372)
                                                                                                                                                                                              (cdr
                                                                                                                                                                                               v_75)))
                                                                                                                                                                                  (let-values (((a_380)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 d_372)))
                                                                                                                                                                                    a_380))))
                                                                                                                                                                    (values
                                                                                                                                                                     idss_40
                                                                                                                                                                     rhss_97)))))
                                                                                                                                                    (values
                                                                                                                                                     (cons
                                                                                                                                                      idss31_0
                                                                                                                                                      idss_38)
                                                                                                                                                     (cons
                                                                                                                                                      rhss32_0
                                                                                                                                                      rhss_95))))))
                                                                                                                                    (values
                                                                                                                                     idss_39
                                                                                                                                     rhss_96)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_61
                                                                                                                       idss_37
                                                                                                                       rhss_94
                                                                                                                       rest_73)
                                                                                                                      (values
                                                                                                                       idss_37
                                                                                                                       rhss_94))))
                                                                                                                (values
                                                                                                                 idss_36
                                                                                                                 rhss_93)))))
                                                                                             for-loop_61)
                                                                                           null
                                                                                           null
                                                                                           lst_138)))))
                                                                          (values
                                                                           (reverse$1 idss_35)
                                                                           (reverse$1 rhss_92)))))
                                                                     ((bodys_34)
                                                                      (let-values (((d_373) (cdr d_371))) d_373)))
                                                          (values idss_34 rhss_91 bodys_34)))))
                                          (let-values (((new-mutated_0 simple-so-far?_0)
                                                        (let-values (((lst_140) idss_33) ((lst_141) rhss_90))
                                                          (begin
                                                            (check-list lst_140)
                                                            (check-list lst_141)
                                                            ((letrec-values (((for-loop_62)
                                                                              (lambda (mutated_44
                                                                                       simple-so-far?_1
                                                                                       lst_142
                                                                                       lst_143)
                                                                                (if (if (pair? lst_142)
                                                                                      (pair? lst_143)
                                                                                      #f)
                                                                                  (let-values (((ids_60)
                                                                                                (unsafe-car lst_142))
                                                                                               ((rest_74)
                                                                                                (unsafe-cdr lst_142))
                                                                                               ((rhs_43)
                                                                                                (unsafe-car lst_143))
                                                                                               ((rest_75)
                                                                                                (unsafe-cdr lst_143)))
                                                                                    (let-values (((mutated_45
                                                                                                   simple-so-far?_2)
                                                                                                  (let-values (((mutated_46)
                                                                                                                mutated_44)
                                                                                                               ((simple-so-far?_3)
                                                                                                                simple-so-far?_1))
                                                                                                    (let-values (((mutated_47
                                                                                                                   simple-so-far?_4)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((still-simple?_0)
                                                                                                                                  (if simple-so-far?_3
                                                                                                                                    (simple?
                                                                                                                                     rhs_43
                                                                                                                                     prim-knowns_9
                                                                                                                                     knowns_29
                                                                                                                                     imports_19
                                                                                                                                     mutated_46)
                                                                                                                                    #f)))
                                                                                                                      (if still-simple?_0
                                                                                                                        (values
                                                                                                                         (find-mutated_0
                                                                                                                          rhs_43
                                                                                                                          mutated_46
                                                                                                                          pending_15)
                                                                                                                         #t)
                                                                                                                        (values
                                                                                                                         (find-mutated_0
                                                                                                                          rhs_43
                                                                                                                          (let-values (((lst_144)
                                                                                                                                        ids_60))
                                                                                                                            (begin
                                                                                                                              (check-list
                                                                                                                               lst_144)
                                                                                                                              ((letrec-values (((for-loop_63)
                                                                                                                                                (lambda (mutated_48
                                                                                                                                                         lst_145)
                                                                                                                                                  (if (pair?
                                                                                                                                                       lst_145)
                                                                                                                                                    (let-values (((id_23)
                                                                                                                                                                  (unsafe-car
                                                                                                                                                                   lst_145))
                                                                                                                                                                 ((rest_76)
                                                                                                                                                                  (unsafe-cdr
                                                                                                                                                                   lst_145)))
                                                                                                                                                      (let-values (((mutated_49)
                                                                                                                                                                    (let-values (((mutated_50)
                                                                                                                                                                                  mutated_48))
                                                                                                                                                                      (let-values (((mutated_51)
                                                                                                                                                                                    (let-values ()
                                                                                                                                                                                      (hash-set
                                                                                                                                                                                       mutated_50
                                                                                                                                                                                       id_23
                                                                                                                                                                                       #t))))
                                                                                                                                                                        (values
                                                                                                                                                                         mutated_51)))))
                                                                                                                                                        (if (not
                                                                                                                                                             #f)
                                                                                                                                                          (for-loop_63
                                                                                                                                                           mutated_49
                                                                                                                                                           rest_76)
                                                                                                                                                          mutated_49)))
                                                                                                                                                    mutated_48))))
                                                                                                                                 for-loop_63)
                                                                                                                               mutated_46
                                                                                                                               lst_144)))
                                                                                                                          pending_15)
                                                                                                                         #f))))))
                                                                                                      (values
                                                                                                       mutated_47
                                                                                                       simple-so-far?_4)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_62
                                                                                         mutated_45
                                                                                         simple-so-far?_2
                                                                                         rest_74
                                                                                         rest_75)
                                                                                        (values
                                                                                         mutated_45
                                                                                         simple-so-far?_2))))
                                                                                  (values
                                                                                   mutated_44
                                                                                   simple-so-far?_1)))))
                                                               for-loop_62)
                                                             mutated_34
                                                             #t
                                                             lst_140
                                                             lst_141)))))
                                            (find-mutated*_0 bodys_33 new-mutated_0 pending_15)))
                                        (if (if (pair? v_69)
                                              (if (let-values (((a_381) (car v_69))) (equal? 'if a_381))
                                                (let-values (((d_374) (cdr v_69)))
                                                  (if (pair? d_374)
                                                    (if (let-values (((a_382) (car d_374))) #t)
                                                      (let-values (((d_375) (cdr d_374)))
                                                        (if (pair? d_375)
                                                          (if (let-values (((a_383) (car d_375))) #t)
                                                            (let-values (((d_376) (cdr d_375)))
                                                              (if (pair? d_376)
                                                                (if (let-values (((a_384) (car d_376))) #t)
                                                                  (let-values (((d_377) (cdr d_376)))
                                                                    (equal? '() d_377))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((tst_2 thn_3 els_3)
                                                        (let-values (((d_378) (cdr v_69)))
                                                          (let-values (((tst_3)
                                                                        (let-values (((a_385) (car d_378))) a_385))
                                                                       ((thn_4 els_4)
                                                                        (let-values (((d_379) (cdr d_378)))
                                                                          (let-values (((thn_5)
                                                                                        (let-values (((a_386)
                                                                                                      (car d_379)))
                                                                                          a_386))
                                                                                       ((els_5)
                                                                                        (let-values (((d_380)
                                                                                                      (cdr d_379)))
                                                                                          (let-values (((a_387)
                                                                                                        (car d_380)))
                                                                                            a_387))))
                                                                            (values thn_5 els_5)))))
                                                            (values tst_3 thn_4 els_4)))))
                                            (find-mutated_0
                                             els_3
                                             (find-mutated_0
                                              thn_3
                                              (find-mutated_0 tst_2 mutated_34 pending_15)
                                              pending_15)
                                             pending_15))
                                          (if (if (pair? v_69)
                                                (if (let-values (((a_388) (car v_69)))
                                                      (equal? 'with-continuation-mark a_388))
                                                  (let-values (((d_381) (cdr v_69)))
                                                    (if (pair? d_381)
                                                      (if (let-values (((a_389) (car d_381))) #t)
                                                        (let-values (((d_382) (cdr d_381)))
                                                          (if (pair? d_382)
                                                            (if (let-values (((a_390) (car d_382))) #t)
                                                              (let-values (((d_383) (cdr d_382)))
                                                                (if (pair? d_383)
                                                                  (if (let-values (((a_391) (car d_383))) #t)
                                                                    (let-values (((d_384) (cdr d_383)))
                                                                      (equal? '() d_384))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((key_3 val_3 body_24)
                                                          (let-values (((d_385) (cdr v_69)))
                                                            (let-values (((key_4)
                                                                          (let-values (((a_392) (car d_385))) a_392))
                                                                         ((val_4 body_25)
                                                                          (let-values (((d_386) (cdr d_385)))
                                                                            (let-values (((val_5)
                                                                                          (let-values (((a_393)
                                                                                                        (car d_386)))
                                                                                            a_393))
                                                                                         ((body_26)
                                                                                          (let-values (((d_387)
                                                                                                        (cdr d_386)))
                                                                                            (let-values (((a_394)
                                                                                                          (car d_387)))
                                                                                              a_394))))
                                                                              (values val_5 body_26)))))
                                                              (values key_4 val_4 body_25)))))
                                              (find-mutated_0
                                               body_24
                                               (find-mutated_0
                                                val_3
                                                (find-mutated_0 key_3 mutated_34 pending_15)
                                                pending_15)
                                               pending_15))
                                            (if (if (pair? v_69)
                                                  (if (let-values (((a_395) (car v_69))) (equal? 'begin a_395))
                                                    (let-values (((d_388) (cdr v_69))) (list? d_388))
                                                    #f)
                                                  #f)
                                              (let-values (((exps_4) (let-values (((d_389) (cdr v_69))) d_389)))
                                                (find-mutated*_0 exps_4 mutated_34 pending_15))
                                              (if (if (pair? v_69)
                                                    (if (let-values (((a_396) (car v_69))) (equal? 'begin0 a_396))
                                                      (let-values (((d_390) (cdr v_69))) (list? d_390))
                                                      #f)
                                                    #f)
                                                (let-values (((exps_5) (let-values (((d_391) (cdr v_69))) d_391)))
                                                  (find-mutated*_0 exps_5 mutated_34 pending_15))
                                                (if (if (pair? v_69)
                                                      (if (let-values (((a_397) (car v_69))) (equal? 'set! a_397))
                                                        (let-values (((d_392) (cdr v_69)))
                                                          (if (pair? d_392)
                                                            (if (let-values (((a_398) (car d_392))) #t)
                                                              (let-values (((d_393) (cdr d_392)))
                                                                (if (pair? d_393)
                                                                  (if (let-values (((a_399) (car d_393))) #t)
                                                                    (let-values (((d_394) (cdr d_393)))
                                                                      (equal? '() d_394))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((id_24 rhs_44)
                                                                (let-values (((d_395) (cdr v_69)))
                                                                  (let-values (((id_25)
                                                                                (let-values (((a_400) (car d_395)))
                                                                                  a_400))
                                                                               ((rhs_45)
                                                                                (let-values (((d_396) (cdr d_395)))
                                                                                  (let-values (((a_401) (car d_396)))
                                                                                    a_401))))
                                                                    (values id_25 rhs_45)))))
                                                    (find-mutated_0 rhs_44 (hash-set mutated_34 id_24 #t) pending_15))
                                                  (if (if (pair? v_69)
                                                        (if (let-values (((a_402) (car v_69)))
                                                              (equal? '#%variable-reference a_402))
                                                          (let-values (((d_397) (cdr v_69))) #t)
                                                          #f)
                                                        #f)
                                                    (let-values () mutated_34)
                                                    (if (if (pair? v_69)
                                                          (if (let-values (((a_403) (car v_69))) #t)
                                                            (let-values (((d_398) (cdr v_69))) (list? d_398))
                                                            #f)
                                                          #f)
                                                      (let-values (((rator_2 exps_6)
                                                                    (let-values (((rator_3)
                                                                                  (let-values (((a_404) (car v_69)))
                                                                                    a_404))
                                                                                 ((exps_7)
                                                                                  (let-values (((d_399) (cdr v_69)))
                                                                                    d_399)))
                                                                      (values rator_3 exps_7))))
                                                        (find-mutated*_0
                                                         exps_6
                                                         (find-mutated_0 rator_2 mutated_34 pending_15)
                                                         pending_15))
                                                      (let-values ()
                                                        (if (if (symbol? v_67) (hash-ref pending_15 v_67 #f) #f)
                                                          (hash-set mutated_34 v_67 #t)
                                                          mutated_34))))))))))))))))))))
       find-mutated_0)
     v_66
     mutated_33
     pending_14)))
 (define-values
  (make-set-variables)
  (lambda (accum_2 exports_9)
    (let-values (((lst_146) accum_2))
      (begin
        (check-list lst_146)
        ((letrec-values (((for-loop_64)
                          (lambda (assigns_0 lst_147)
                            (if (pair? lst_147)
                              (let-values (((v_76) (unsafe-car lst_147)) ((rest_77) (unsafe-cdr lst_147)))
                                (let-values (((assigns_1)
                                              (let-values (((assigns_2) assigns_0))
                                                (let-values (((assigns_3)
                                                              (let-values ()
                                                                (let-values (((v_77) v_76))
                                                                  (if (if (pair? v_77)
                                                                        (if (let-values (((a_405) (car v_77)))
                                                                              (equal? 'define-values a_405))
                                                                          (let-values (((d_400) (cdr v_77)))
                                                                            (if (pair? d_400)
                                                                              (if (let-values (((a_406) (car d_400)))
                                                                                    (list? a_406))
                                                                                (let-values (((d_401) (cdr d_400)))
                                                                                  (if (pair? d_401)
                                                                                    (if (let-values (((a_407)
                                                                                                      (car d_401)))
                                                                                          #t)
                                                                                      (let-values (((d_402)
                                                                                                    (cdr d_401)))
                                                                                        (equal? '() d_402))
                                                                                      #f)
                                                                                    #f))
                                                                                #f)
                                                                              #f))
                                                                          #f)
                                                                        #f)
                                                                    (let-values (((ids_61)
                                                                                  (let-values (((d_403) (cdr v_77)))
                                                                                    (let-values (((a_408) (car d_403)))
                                                                                      a_408))))
                                                                      (let-values (((lst_148) ids_61))
                                                                        (begin
                                                                          (check-list lst_148)
                                                                          ((letrec-values (((for-loop_65)
                                                                                            (lambda (assigns_4 lst_149)
                                                                                              (if (pair? lst_149)
                                                                                                (let-values (((id_26)
                                                                                                              (unsafe-car
                                                                                                               lst_149))
                                                                                                             ((rest_78)
                                                                                                              (unsafe-cdr
                                                                                                               lst_149)))
                                                                                                  (let-values (((assigns_5)
                                                                                                                (let-values (((assigns_6)
                                                                                                                              assigns_4))
                                                                                                                  (let-values (((assigns_7)
                                                                                                                                (let-values ()
                                                                                                                                  (let-values (((ex-var_0)
                                                                                                                                                (hash-ref
                                                                                                                                                 exports_9
                                                                                                                                                 id_26
                                                                                                                                                 #f)))
                                                                                                                                    (if ex-var_0
                                                                                                                                      (cons
                                                                                                                                       (list
                                                                                                                                        'define
                                                                                                                                        (gensym)
                                                                                                                                        (list
                                                                                                                                         'variable-set!
                                                                                                                                         ex-var_0
                                                                                                                                         id_26))
                                                                                                                                       assigns_6)
                                                                                                                                      assigns_6)))))
                                                                                                                    (values
                                                                                                                     assigns_7)))))
                                                                                                    (if (not #f)
                                                                                                      (for-loop_65
                                                                                                       assigns_5
                                                                                                       rest_78)
                                                                                                      assigns_5)))
                                                                                                assigns_4))))
                                                                             for-loop_65)
                                                                           assigns_2
                                                                           lst_148))))
                                                                    (let-values () assigns_2))))))
                                                  (values assigns_3)))))
                                  (if (not #f) (for-loop_64 assigns_1 rest_77) assigns_1)))
                              assigns_0))))
           for-loop_64)
         null
         lst_146))))))
