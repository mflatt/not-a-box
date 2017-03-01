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
 (define-values (delayed-mutated-state?) (lambda (v_14) (procedure? v_14)))
 (define-values
  (simple-mutated-state?)
  (lambda (v_15) (let-values (((or-part_2) (not v_15))) (if or-part_2 or-part_2 (delayed-mutated-state? v_15)))))
 (define-values (not-ready-mutated-state?) (lambda (v_16) (eq? v_16 'not-ready)))
 (define-values
  (via-variable-mutated-state?)
  (lambda (v_17) (let-values (((or-part_3) (eq? v_17 'set!ed))) (if or-part_3 or-part_3 (eq? v_17 'undefined)))))
 (define-values (set!ed-mutated-state?) (lambda (v_18) (eq? v_18 'set!ed)))
 (define-values
  (simple?)
  (lambda (e_0 prim-knowns_0 knowns_2 imports_1 mutated_0)
    ((letrec-values (((simple?_0)
                      (lambda (e_1)
                        (let-values (((v_19) e_1))
                          (if (if (pair? v_19)
                                (if (let-values (((a_3) (car v_19))) (equal? 'lambda a_3))
                                  (let-values (((d_0) (cdr v_19))) #t)
                                  #f)
                                #f)
                            (let-values () #t)
                            (if (if (pair? v_19)
                                  (if (let-values (((a_4) (car v_19))) (equal? 'case-lambda a_4))
                                    (let-values (((d_1) (cdr v_19))) #t)
                                    #f)
                                  #f)
                              (let-values () #t)
                              (if (if (pair? v_19)
                                    (if (let-values (((a_5) (car v_19))) (equal? 'quote a_5))
                                      (let-values (((d_2) (cdr v_19))) #t)
                                      #f)
                                    #f)
                                (let-values () #t)
                                (if (if (pair? v_19)
                                      (if (let-values (((a_6) (car v_19))) (equal? '#%variable-reference a_6))
                                        (let-values (((d_3) (cdr v_19))) #t)
                                        #f)
                                      #f)
                                  (let-values () #t)
                                  (if (if (pair? v_19)
                                        (if (let-values (((a_7) (car v_19))) (equal? 'let-values a_7))
                                          (let-values (((d_4) (cdr v_19)))
                                            (if (pair? d_4)
                                              (if (let-values (((a_8) (car d_4)))
                                                    (if (list? a_8)
                                                      (let-values (((lst_0) a_8))
                                                        (begin
                                                          (check-list lst_0)
                                                          ((letrec-values (((for-loop_0)
                                                                            (lambda (result_0 lst_1)
                                                                              (if (pair? lst_1)
                                                                                (let-values (((v_20) (unsafe-car lst_1))
                                                                                             ((rest_0)
                                                                                              (unsafe-cdr lst_1)))
                                                                                  (let-values (((result_1)
                                                                                                (let-values ()
                                                                                                  (let-values (((result_2)
                                                                                                                (let-values ()
                                                                                                                  (let-values ()
                                                                                                                    (if (pair?
                                                                                                                         v_20)
                                                                                                                      (if (let-values (((a_9)
                                                                                                                                        (car
                                                                                                                                         v_20)))
                                                                                                                            #t)
                                                                                                                        (let-values (((d_5)
                                                                                                                                      (cdr
                                                                                                                                       v_20)))
                                                                                                                          (if (pair?
                                                                                                                               d_5)
                                                                                                                            (if (let-values (((a_10)
                                                                                                                                              (car
                                                                                                                                               d_5)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_6)
                                                                                                                                            (cdr
                                                                                                                                             d_5)))
                                                                                                                                (equal?
                                                                                                                                 '()
                                                                                                                                 d_6))
                                                                                                                              #f)
                                                                                                                            #f))
                                                                                                                        #f)
                                                                                                                      #f)))))
                                                                                                    (values
                                                                                                     result_2)))))
                                                                                    (if (if (not
                                                                                             ((lambda x_0
                                                                                                (not result_1))
                                                                                              v_20))
                                                                                          (not #f)
                                                                                          #f)
                                                                                      (for-loop_0 result_1 rest_0)
                                                                                      result_1)))
                                                                                result_0))))
                                                             for-loop_0)
                                                           #t
                                                           lst_0)))
                                                      #f))
                                                (let-values (((d_7) (cdr d_4)))
                                                  (if (pair? d_7)
                                                    (if (let-values (((a_11) (car d_7))) #t)
                                                      (let-values (((d_8) (cdr d_7))) (equal? '() d_8))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((rhss_0 body_0)
                                                  (let-values (((d_9) (cdr v_19)))
                                                    (let-values (((rhss_1)
                                                                  (let-values (((a_12) (car d_9)))
                                                                    (let-values (((rhss_2)
                                                                                  (let-values (((lst_2) a_12))
                                                                                    (begin
                                                                                      (check-list lst_2)
                                                                                      ((letrec-values (((for-loop_1)
                                                                                                        (lambda (rhss_3
                                                                                                                 lst_3)
                                                                                                          (if (pair?
                                                                                                               lst_3)
                                                                                                            (let-values (((v_21)
                                                                                                                          (unsafe-car
                                                                                                                           lst_3))
                                                                                                                         ((rest_1)
                                                                                                                          (unsafe-cdr
                                                                                                                           lst_3)))
                                                                                                              (let-values (((rhss_4)
                                                                                                                            (let-values (((rhss_5)
                                                                                                                                          rhss_3))
                                                                                                                              (let-values (((rhss_6)
                                                                                                                                            (let-values ()
                                                                                                                                              (let-values (((rhss1_0)
                                                                                                                                                            (let-values ()
                                                                                                                                                              (let-values (((d_10)
                                                                                                                                                                            (cdr
                                                                                                                                                                             v_21)))
                                                                                                                                                                (let-values (((a_13)
                                                                                                                                                                              (car
                                                                                                                                                                               d_10)))
                                                                                                                                                                  a_13)))))
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
                                                                  (let-values (((d_11) (cdr d_9)))
                                                                    (let-values (((a_14) (car d_11))) a_14))))
                                                      (values rhss_1 body_1)))))
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
                                                                                 ((lambda x_1 (not result_4)) rhs_0))
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
                                    (if (if (pair? v_19)
                                          (if (let-values (((a_15) (car v_19))) (equal? 'let a_15))
                                            (let-values (((d_12) (cdr v_19)))
                                              (if (pair? d_12)
                                                (if (let-values (((a_16) (car d_12)))
                                                      (if (list? a_16)
                                                        (let-values (((lst_6) a_16))
                                                          (begin
                                                            (check-list lst_6)
                                                            ((letrec-values (((for-loop_3)
                                                                              (lambda (result_6 lst_7)
                                                                                (if (pair? lst_7)
                                                                                  (let-values (((v_22)
                                                                                                (unsafe-car lst_7))
                                                                                               ((rest_3)
                                                                                                (unsafe-cdr lst_7)))
                                                                                    (let-values (((result_7)
                                                                                                  (let-values ()
                                                                                                    (let-values (((result_8)
                                                                                                                  (let-values ()
                                                                                                                    (let-values ()
                                                                                                                      (if (pair?
                                                                                                                           v_22)
                                                                                                                        (if (let-values (((a_17)
                                                                                                                                          (car
                                                                                                                                           v_22)))
                                                                                                                              #t)
                                                                                                                          (let-values (((d_13)
                                                                                                                                        (cdr
                                                                                                                                         v_22)))
                                                                                                                            (if (pair?
                                                                                                                                 d_13)
                                                                                                                              (if (let-values (((a_18)
                                                                                                                                                (car
                                                                                                                                                 d_13)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_14)
                                                                                                                                              (cdr
                                                                                                                                               d_13)))
                                                                                                                                  (equal?
                                                                                                                                   '()
                                                                                                                                   d_14))
                                                                                                                                #f)
                                                                                                                              #f))
                                                                                                                          #f)
                                                                                                                        #f)))))
                                                                                                      (values
                                                                                                       result_8)))))
                                                                                      (if (if (not
                                                                                               ((lambda x_2
                                                                                                  (not result_7))
                                                                                                v_22))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_3 result_7 rest_3)
                                                                                        result_7)))
                                                                                  result_6))))
                                                               for-loop_3)
                                                             #t
                                                             lst_6)))
                                                        #f))
                                                  (let-values (((d_15) (cdr d_12)))
                                                    (if (pair? d_15)
                                                      (if (let-values (((a_19) (car d_15))) #t)
                                                        (let-values (((d_16) (cdr d_15))) (equal? '() d_16))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((rhss_7 body_2)
                                                    (let-values (((d_17) (cdr v_19)))
                                                      (let-values (((rhss_8)
                                                                    (let-values (((a_20) (car d_17)))
                                                                      (let-values (((rhss_9)
                                                                                    (let-values (((lst_8) a_20))
                                                                                      (begin
                                                                                        (check-list lst_8)
                                                                                        ((letrec-values (((for-loop_4)
                                                                                                          (lambda (rhss_10
                                                                                                                   lst_9)
                                                                                                            (if (pair?
                                                                                                                 lst_9)
                                                                                                              (let-values (((v_23)
                                                                                                                            (unsafe-car
                                                                                                                             lst_9))
                                                                                                                           ((rest_4)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_9)))
                                                                                                                (let-values (((rhss_11)
                                                                                                                              (let-values (((rhss_12)
                                                                                                                                            rhss_10))
                                                                                                                                (let-values (((rhss_13)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((rhss2_0)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((d_18)
                                                                                                                                                                              (cdr
                                                                                                                                                                               v_23)))
                                                                                                                                                                  (let-values (((a_0)
                                                                                                                                                                                (car
                                                                                                                                                                                 d_18)))
                                                                                                                                                                    a_0)))))
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
                                                                    (let-values (((d_19) (cdr d_17)))
                                                                      (let-values (((a_21) (car d_19))) a_21))))
                                                        (values rhss_8 body_3)))))
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
                                                                                   ((lambda x_3 (not result_10)) rhs_1))
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
                                      (if (if (pair? v_19)
                                            (if (let-values (((a_22) (car v_19))) (equal? 'letrec-values a_22))
                                              (let-values (((d_20) (cdr v_19)))
                                                (if (pair? d_20)
                                                  (if (let-values (((a_23) (car d_20)))
                                                        (if (list? a_23)
                                                          (let-values (((lst_12) a_23))
                                                            (begin
                                                              (check-list lst_12)
                                                              ((letrec-values (((for-loop_6)
                                                                                (lambda (result_12 lst_13)
                                                                                  (if (pair? lst_13)
                                                                                    (let-values (((v_24)
                                                                                                  (unsafe-car lst_13))
                                                                                                 ((rest_6)
                                                                                                  (unsafe-cdr lst_13)))
                                                                                      (let-values (((result_13)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_14)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (if (pair?
                                                                                                                             v_24)
                                                                                                                          (if (let-values (((a_24)
                                                                                                                                            (car
                                                                                                                                             v_24)))
                                                                                                                                (list?
                                                                                                                                 a_24))
                                                                                                                            (let-values (((d_21)
                                                                                                                                          (cdr
                                                                                                                                           v_24)))
                                                                                                                              (if (pair?
                                                                                                                                   d_21)
                                                                                                                                (if (let-values (((a_25)
                                                                                                                                                  (car
                                                                                                                                                   d_21)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_22)
                                                                                                                                                (cdr
                                                                                                                                                 d_21)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_22))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                            #f)
                                                                                                                          #f)))))
                                                                                                        (values
                                                                                                         result_14)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_4
                                                                                                    (not result_13))
                                                                                                  v_24))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_6 result_13 rest_6)
                                                                                          result_13)))
                                                                                    result_12))))
                                                                 for-loop_6)
                                                               #t
                                                               lst_12)))
                                                          #f))
                                                    (let-values (((d_23) (cdr d_20)))
                                                      (if (pair? d_23)
                                                        (if (let-values (((a_26) (car d_23))) #t)
                                                          (let-values (((d_24) (cdr d_23))) (equal? '() d_24))
                                                          #f)
                                                        #f))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((idss_0 rhss_14 body_4)
                                                      (let-values (((d_25) (cdr v_19)))
                                                        (let-values (((idss_1 rhss_15)
                                                                      (let-values (((a_27) (car d_25)))
                                                                        (let-values (((idss_2 rhss_16)
                                                                                      (let-values (((lst_14) a_27))
                                                                                        (begin
                                                                                          (check-list lst_14)
                                                                                          ((letrec-values (((for-loop_7)
                                                                                                            (lambda (idss_3
                                                                                                                     rhss_17
                                                                                                                     lst_15)
                                                                                                              (if (pair?
                                                                                                                   lst_15)
                                                                                                                (let-values (((v_25)
                                                                                                                              (unsafe-car
                                                                                                                               lst_15))
                                                                                                                             ((rest_7)
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
                                                                                                                                                                                (let-values (((a_28)
                                                                                                                                                                                              (car
                                                                                                                                                                                               v_25)))
                                                                                                                                                                                  a_28))
                                                                                                                                                                               ((rhss_21)
                                                                                                                                                                                (let-values (((d_26)
                                                                                                                                                                                              (cdr
                                                                                                                                                                                               v_25)))
                                                                                                                                                                                  (let-values (((a_29)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 d_26)))
                                                                                                                                                                                    a_29))))
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
                                                                      (let-values (((d_27) (cdr d_25)))
                                                                        (let-values (((a_30) (car d_27))) a_30))))
                                                          (values idss_1 rhss_15 body_5)))))
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
                                                                                     ((lambda x_5 (not result_16))
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
                                        (if (if (pair? v_19)
                                              (if (let-values (((a_31) (car v_19))) (equal? 'letrec* a_31))
                                                (let-values (((d_28) (cdr v_19)))
                                                  (if (pair? d_28)
                                                    (if (let-values (((a_32) (car d_28)))
                                                          (if (list? a_32)
                                                            (let-values (((lst_18) a_32))
                                                              (begin
                                                                (check-list lst_18)
                                                                ((letrec-values (((for-loop_9)
                                                                                  (lambda (result_18 lst_19)
                                                                                    (if (pair? lst_19)
                                                                                      (let-values (((v_26)
                                                                                                    (unsafe-car lst_19))
                                                                                                   ((rest_9)
                                                                                                    (unsafe-cdr
                                                                                                     lst_19)))
                                                                                        (let-values (((result_19)
                                                                                                      (let-values ()
                                                                                                        (let-values (((result_20)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (if (pair?
                                                                                                                               v_26)
                                                                                                                            (if (let-values (((a_33)
                                                                                                                                              (car
                                                                                                                                               v_26)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_29)
                                                                                                                                            (cdr
                                                                                                                                             v_26)))
                                                                                                                                (if (pair?
                                                                                                                                     d_29)
                                                                                                                                  (if (let-values (((a_34)
                                                                                                                                                    (car
                                                                                                                                                     d_29)))
                                                                                                                                        #t)
                                                                                                                                    (let-values (((d_30)
                                                                                                                                                  (cdr
                                                                                                                                                   d_29)))
                                                                                                                                      (equal?
                                                                                                                                       '()
                                                                                                                                       d_30))
                                                                                                                                    #f)
                                                                                                                                  #f))
                                                                                                                              #f)
                                                                                                                            #f)))))
                                                                                                          (values
                                                                                                           result_20)))))
                                                                                          (if (if (not
                                                                                                   ((lambda x_6
                                                                                                      (not result_19))
                                                                                                    v_26))
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
                                                      (let-values (((d_31) (cdr d_28)))
                                                        (if (pair? d_31)
                                                          (if (let-values (((a_35) (car d_31))) #t)
                                                            (let-values (((d_32) (cdr d_31))) (equal? '() d_32))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((ids_0 rhss_22 body_6)
                                                        (let-values (((d_33) (cdr v_19)))
                                                          (let-values (((ids_1 rhss_23)
                                                                        (let-values (((a_36) (car d_33)))
                                                                          (let-values (((ids_2 rhss_24)
                                                                                        (let-values (((lst_20) a_36))
                                                                                          (begin
                                                                                            (check-list lst_20)
                                                                                            ((letrec-values (((for-loop_10)
                                                                                                              (lambda (ids_3
                                                                                                                       rhss_25
                                                                                                                       lst_21)
                                                                                                                (if (pair?
                                                                                                                     lst_21)
                                                                                                                  (let-values (((v_27)
                                                                                                                                (unsafe-car
                                                                                                                                 lst_21))
                                                                                                                               ((rest_10)
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
                                                                                                                                                                                  (let-values (((a_37)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 v_27)))
                                                                                                                                                                                    a_37))
                                                                                                                                                                                 ((rhss_29)
                                                                                                                                                                                  (let-values (((d_34)
                                                                                                                                                                                                (cdr
                                                                                                                                                                                                 v_27)))
                                                                                                                                                                                    (let-values (((a_38)
                                                                                                                                                                                                  (car
                                                                                                                                                                                                   d_34)))
                                                                                                                                                                                      a_38))))
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
                                                                        (let-values (((d_35) (cdr d_33)))
                                                                          (let-values (((a_39) (car d_35))) a_39))))
                                                            (values ids_1 rhss_23 body_7)))))
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
                                                                                       ((lambda x_7 (not result_22))
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
                                          (if (if (pair? v_19)
                                                (if (let-values (((a_40) (car v_19))) #t)
                                                  (let-values (((d_36) (cdr v_19)))
                                                    (if (pair? d_36)
                                                      (if (let-values (((a_41) (car d_36))) #t)
                                                        (let-values (((d_37) (cdr d_36))) (equal? '() d_37))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((proc_0 arg_0)
                                                          (let-values (((proc_1)
                                                                        (let-values (((a_42) (car v_19))) a_42))
                                                                       ((arg_1)
                                                                        (let-values (((d_38) (cdr v_19)))
                                                                          (let-values (((a_43) (car d_38))) a_43))))
                                                            (values proc_1 arg_1))))
                                              (if (symbol? proc_0)
                                                (if (let-values (((v_28)
                                                                  (let-values (((or-part_4)
                                                                                (hash-ref-either
                                                                                 knowns_2
                                                                                 imports_1
                                                                                 proc_0)))
                                                                    (if or-part_4
                                                                      or-part_4
                                                                      (hash-ref prim-knowns_0 proc_0 #f)))))
                                                      (if v_28
                                                        (if (not (hash-ref mutated_0 proc_0 #f))
                                                          (let-values (((or-part_5) (known-predicate? v_28)))
                                                            (if or-part_5
                                                              or-part_5
                                                              (if (known-constructor? v_28)
                                                                (let-values (((c_0)
                                                                              (known-constructor-field-count v_28)))
                                                                  (let-values (((or-part_6) (eq? c_0 'any)))
                                                                    (if or-part_6 or-part_6 (= 1 c_0))))
                                                                #f)))
                                                          #f)
                                                        #f))
                                                  (simple?_0 arg_0)
                                                  #f)
                                                #f))
                                            (if (if (pair? v_19)
                                                  (if (let-values (((a_44) (car v_19))) #t)
                                                    (let-values (((d_39) (cdr v_19))) #t)
                                                    #f)
                                                  #f)
                                              (let-values (((proc_2 args_2)
                                                            (let-values (((proc_3)
                                                                          (let-values (((a_45) (car v_19))) a_45))
                                                                         ((args_3)
                                                                          (let-values (((d_40) (cdr v_19))) d_40)))
                                                              (values proc_3 args_3))))
                                                (if (symbol? proc_2)
                                                  (if (let-values (((v_29)
                                                                    (let-values (((or-part_7)
                                                                                  (hash-ref-either
                                                                                   knowns_2
                                                                                   imports_1
                                                                                   proc_2)))
                                                                      (if or-part_7
                                                                        or-part_7
                                                                        (hash-ref prim-knowns_0 proc_2 #f)))))
                                                        (if (known-constructor? v_29)
                                                          (let-values (((c_1) (known-constructor-field-count v_29)))
                                                            (let-values (((or-part_8) (eq? c_1 'any)))
                                                              (if or-part_8 or-part_8 (= (length args_2) c_1))))
                                                          #f))
                                                    (if (simple-mutated-state? (hash-ref mutated_0 proc_2 #f))
                                                      (let-values (((lst_24) args_2))
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
                                                                                             ((lambda x_8
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
                                                  #f))
                                              (let-values ()
                                                (let-values (((or-part_9)
                                                              (if (symbol? e_1)
                                                                (simple-mutated-state? (hash-ref mutated_0 e_1 #f))
                                                                #f)))
                                                  (if or-part_9
                                                    or-part_9
                                                    (let-values (((or-part_10) (integer? e_1)))
                                                      (if or-part_10
                                                        or-part_10
                                                        (let-values (((or-part_11) (boolean? e_1)))
                                                          (if or-part_11
                                                            or-part_11
                                                            (let-values (((or-part_12) (string? e_1)))
                                                              (if or-part_12
                                                                or-part_12
                                                                (let-values (((or-part_13) (bytes? e_1)))
                                                                  (if or-part_13
                                                                    or-part_13
                                                                    (regexp? e_1))))))))))))))))))))))))))
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
  (lambda (v_30 prim-knowns_1 knowns_3 imports_2 mutated_1)
    (let-values (((v_31) v_30))
      (if (if (pair? v_31)
            (if (let-values (((a_46) (car v_31))) (equal? 'make-struct-type a_46))
              (let-values (((d_41) (cdr v_31)))
                (if (pair? d_41)
                  (if (let-values (((a_47) (car d_41)))
                        (if (pair? a_47)
                          (if (let-values (((a_13) (car a_47))) (equal? 'quote a_13))
                            (let-values (((d_11) (cdr a_47)))
                              (if (pair? d_11)
                                (if (let-values (((a_14) (car d_11))) #t)
                                  (let-values (((d_42) (cdr d_11))) (equal? '() d_42))
                                  #f)
                                #f))
                            #f)
                          #f))
                    (let-values (((d_43) (cdr d_41)))
                      (if (pair? d_43)
                        (if (let-values (((a_48) (car d_43))) #t)
                          (let-values (((d_44) (cdr d_43)))
                            (if (pair? d_44)
                              (if (let-values (((a_49) (car d_44))) #t)
                                (let-values (((d_45) (cdr d_44)))
                                  (if (pair? d_45)
                                    (if (let-values (((a_50) (car d_45))) (equal? 0 a_50))
                                      (let-values (((d_46) (cdr d_45)))
                                        (if (pair? d_46)
                                          (if (let-values (((a_51) (car d_46))) (equal? #f a_51))
                                            (let-values (((d_47) (cdr d_46))) #t)
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
        (let-values (((name_1 parent_0 fields_0 rest_13)
                      (let-values (((d_48) (cdr v_31)))
                        (let-values (((name_2)
                                      (let-values (((a_52) (car d_48)))
                                        (let-values (((d_49) (cdr a_52))) (let-values (((a_53) (car d_49))) a_53))))
                                     ((parent_1 fields_1 rest_3)
                                      (let-values (((d_50) (cdr d_48)))
                                        (let-values (((parent_2) (let-values (((a_54) (car d_50))) a_54))
                                                     ((fields_2 rest_14)
                                                      (let-values (((d_15) (cdr d_50)))
                                                        (let-values (((fields_3)
                                                                      (let-values (((a_55) (car d_15))) a_55))
                                                                     ((rest_15)
                                                                      (let-values (((d_51) (cdr d_15)))
                                                                        (let-values (((d_17) (cdr d_51)))
                                                                          (let-values (((d_52) (cdr d_17))) d_52)))))
                                                          (values fields_3 rest_15)))))
                                          (values parent_2 fields_2 rest_14)))))
                          (values name_2 parent_1 fields_1 rest_3)))))
          (if (symbol? name_1)
            (if (let-values (((or-part_14) (not parent_0)))
                  (if or-part_14
                    or-part_14
                    (let-values (((or-part_15) (known-struct-type? (hash-ref prim-knowns_1 parent_0 #f))))
                      (if or-part_15
                        or-part_15
                        (if (known-struct-type? (hash-ref-either knowns_3 imports_2 parent_0))
                          (simple-mutated-state? (hash-ref mutated_1 parent_0 #f))
                          #f)))))
              (if (exact-nonnegative-integer? fields_0)
                (struct-type-info1.1
                 name_1
                 parent_0
                 fields_0
                 (+
                  fields_0
                  (if parent_0 (known-struct-type-field-count (hash-ref-either knowns_3 imports_2 parent_0)) 0))
                 (let-values (((or-part_16) (< (length rest_13) 4)))
                   (if or-part_16 or-part_16 (not (list-ref rest_13 3))))
                 rest_13)
                #f)
              #f)
            #f))
        (if (if (pair? v_31)
              (if (let-values (((a_56) (car v_31))) (equal? 'let-values a_56))
                (let-values (((d_53) (cdr v_31)))
                  (if (pair? d_53)
                    (if (let-values (((a_57) (car d_53))) (equal? '() a_57))
                      (let-values (((d_54) (cdr d_53)))
                        (if (pair? d_54)
                          (if (let-values (((a_58) (car d_54))) #t)
                            (let-values (((d_55) (cdr d_54))) (equal? '() d_55))
                            #f)
                          #f))
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((body_8)
                        (let-values (((d_56) (cdr v_31)))
                          (let-values (((d_57) (cdr d_56))) (let-values (((a_59) (car d_57))) a_59)))))
            (make-struct-type-info body_8 prim-knowns_1 knowns_3 imports_2 mutated_1))
          (let-values () #f))))))
 (define-values
  (pure-properties-list?)
  (lambda (e_2 prim-knowns_2 knowns_4 imports_3 mutated_2)
    (let-values (((v_32) e_2))
      (if (if (pair? v_32)
            (if (let-values (((a_60) (car v_32))) (equal? 'list a_60))
              (let-values (((d_58) (cdr v_32)))
                (if (list? d_58)
                  (let-values (((lst_26) d_58))
                    (begin
                      (check-list lst_26)
                      ((letrec-values (((for-loop_13)
                                        (lambda (result_10 lst_27)
                                          (if (pair? lst_27)
                                            (let-values (((v_33) (unsafe-car lst_27)) ((rest_16) (unsafe-cdr lst_27)))
                                              (let-values (((result_27)
                                                            (let-values ()
                                                              (let-values (((result_28)
                                                                            (let-values ()
                                                                              (let-values ()
                                                                                (if (pair? v_33)
                                                                                  (if (let-values (((a_61) (car v_33)))
                                                                                        (equal? 'cons a_61))
                                                                                    (let-values (((d_59) (cdr v_33)))
                                                                                      (if (pair? d_59)
                                                                                        (if (let-values (((a_62)
                                                                                                          (car d_59)))
                                                                                              #t)
                                                                                          (let-values (((d_60)
                                                                                                        (cdr d_59)))
                                                                                            (if (pair? d_60)
                                                                                              (if (let-values (((a_63)
                                                                                                                (car
                                                                                                                 d_60)))
                                                                                                    #t)
                                                                                                (let-values (((d_61)
                                                                                                              (cdr
                                                                                                               d_60)))
                                                                                                  (equal? '() d_61))
                                                                                                #f)
                                                                                              #f))
                                                                                          #f)
                                                                                        #f))
                                                                                    #f)
                                                                                  #f)))))
                                                                (values result_28)))))
                                                (if (if (not ((lambda x_9 (not result_27)) v_33)) (not #f) #f)
                                                  (for-loop_13 result_27 rest_16)
                                                  result_27)))
                                            result_10))))
                         for-loop_13)
                       #t
                       lst_26)))
                  #f))
              #f)
            #f)
        (let-values (((props_0 vals_0)
                      (let-values (((d_62) (cdr v_32)))
                        (let-values (((props_1 vals_1)
                                      (let-values (((lst_28) d_62))
                                        (begin
                                          (check-list lst_28)
                                          ((letrec-values (((for-loop_14)
                                                            (lambda (props_2 vals_2 lst_29)
                                                              (if (pair? lst_29)
                                                                (let-values (((v_34) (unsafe-car lst_29))
                                                                             ((rest_17) (unsafe-cdr lst_29)))
                                                                  (let-values (((props_3 vals_3)
                                                                                (let-values (((props_4) props_2)
                                                                                             ((vals_4) vals_2))
                                                                                  (let-values (((props_5 vals_5)
                                                                                                (let-values ()
                                                                                                  (let-values (((props3_0
                                                                                                                 vals4_0)
                                                                                                                (let-values ()
                                                                                                                  (let-values (((d_63)
                                                                                                                                (cdr
                                                                                                                                 v_34)))
                                                                                                                    (let-values (((props_6)
                                                                                                                                  (let-values (((a_64)
                                                                                                                                                (car
                                                                                                                                                 d_63)))
                                                                                                                                    a_64))
                                                                                                                                 ((vals_6)
                                                                                                                                  (let-values (((d_64)
                                                                                                                                                (cdr
                                                                                                                                                 d_63)))
                                                                                                                                    (let-values (((a_65)
                                                                                                                                                  (car
                                                                                                                                                   d_64)))
                                                                                                                                      a_65))))
                                                                                                                      (values
                                                                                                                       props_6
                                                                                                                       vals_6))))))
                                                                                                    (values
                                                                                                     (cons
                                                                                                      props3_0
                                                                                                      props_4)
                                                                                                     (cons
                                                                                                      vals4_0
                                                                                                      vals_4))))))
                                                                                    (values props_5 vals_5)))))
                                                                    (if (not #f)
                                                                      (for-loop_14 props_3 vals_3 rest_17)
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
                                (lambda (result_29 lst_32 lst_33)
                                  (if (if (pair? lst_32) (pair? lst_33) #f)
                                    (let-values (((prop_0) (unsafe-car lst_32))
                                                 ((rest_18) (unsafe-cdr lst_32))
                                                 ((val_0) (unsafe-car lst_33))
                                                 ((rest_19) (unsafe-cdr lst_33)))
                                      (let-values (((result_30)
                                                    (let-values ()
                                                      (let-values (((result_31)
                                                                    (let-values ()
                                                                      (let-values ()
                                                                        (if (symbol? prop_0)
                                                                          (if (let-values (((or-part_17)
                                                                                            (known-struct-type-property/immediate-guard?
                                                                                             (hash-ref
                                                                                              prim-knowns_2
                                                                                              prop_0
                                                                                              #f))))
                                                                                (if or-part_17
                                                                                  or-part_17
                                                                                  (known-struct-type-property/immediate-guard?
                                                                                   (hash-ref-either
                                                                                    knowns_4
                                                                                    imports_3
                                                                                    prop_0))))
                                                                            (simple?
                                                                             val_0
                                                                             prim-knowns_2
                                                                             knowns_4
                                                                             imports_3
                                                                             mutated_2)
                                                                            #f)
                                                                          #f)))))
                                                        (values result_31)))))
                                        (if (if (not ((lambda x_10 (not result_30)) prop_0))
                                              (if (not ((lambda x_11 (not result_30)) val_0)) (not #f) #f)
                                              #f)
                                          (for-loop_15 result_30 rest_18 rest_19)
                                          result_30)))
                                    result_29))))
                 for-loop_15)
               #t
               lst_30
               lst_31))))
        (if (equal? 'null v_32)
          (let-values () #t)
          (if (if (pair? v_32)
                (if (let-values (((a_66) (car v_32))) (equal? 'quote a_66))
                  (let-values (((d_65) (cdr v_32)))
                    (if (pair? d_65)
                      (if (let-values (((a_67) (car d_65))) (equal? '() a_67))
                        (let-values (((d_66) (cdr d_65))) (equal? '() d_66))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values () #t)
            (let-values () #f)))))))
 (define-values
  (find-definitions)
  (lambda (v_14 prim-knowns_0 knowns_2 imports_1 mutated_0)
    (let-values (((v_35) v_14))
      (if (if (pair? v_35)
            (if (let-values (((a_68) (car v_35))) (equal? 'define-values a_68))
              (let-values (((d_67) (cdr v_35)))
                (if (pair? d_67)
                  (if (let-values (((a_3) (car d_67)))
                        (if (pair? a_3)
                          (if (let-values (((a_69) (car a_3))) #t)
                            (let-values (((d_68) (cdr a_3))) (equal? '() d_68))
                            #f)
                          #f))
                    (let-values (((d_1) (cdr d_67)))
                      (if (pair? d_1)
                        (if (let-values (((a_5) (car d_1))) #t) (let-values (((d_2) (cdr d_1))) (equal? '() d_2)) #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((id_0 rhs_4)
                      (let-values (((d_69) (cdr v_35)))
                        (let-values (((id_1) (let-values (((a_70) (car d_69))) (let-values (((a_71) (car a_70))) a_71)))
                                     ((rhs_5)
                                      (let-values (((d_70) (cdr d_69))) (let-values (((a_72) (car d_70))) a_72))))
                          (values id_1 rhs_5)))))
          (values
           (if (lambda? rhs_4)
             (let-values () (hash-set knowns_2 id_0 a-known-procedure))
             (if (simple? rhs_4 prim-knowns_0 knowns_2 imports_1 mutated_0)
               (let-values () (hash-set knowns_2 id_0 a-known-unknown))
               (let-values () knowns_2)))
           #f))
        (if (if (pair? v_35)
              (if (let-values (((a_73) (car v_35))) (equal? 'define-values a_73))
                (let-values (((d_71) (cdr v_35)))
                  (if (pair? d_71)
                    (if (let-values (((a_74) (car d_71)))
                          (if (pair? a_74)
                            (if (let-values (((a_75) (car a_74))) #t)
                              (let-values (((d_72) (cdr a_74)))
                                (if (pair? d_72)
                                  (if (let-values (((a_9) (car d_72))) #t)
                                    (let-values (((d_5) (cdr d_72)))
                                      (if (pair? d_5)
                                        (if (let-values (((a_10) (car d_5))) #t)
                                          (let-values (((d_6) (cdr d_5))) (list? d_6))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                              #f)
                            #f))
                      (let-values (((d_73) (cdr d_71)))
                        (if (pair? d_73)
                          (if (let-values (((a_76) (car d_73)))
                                (if (pair? a_76)
                                  (if (let-values (((a_11) (car a_76))) (equal? 'let-values a_11))
                                    (let-values (((d_8) (cdr a_76)))
                                      (if (pair? d_8)
                                        (if (let-values (((a_77) (car d_8)))
                                              (if (pair? a_77)
                                                (if (let-values (((a_78) (car a_77)))
                                                      (if (pair? a_78)
                                                        (if (let-values (((a_79) (car a_78)))
                                                              (if (pair? a_79)
                                                                (if (let-values (((a_80) (car a_79))) #t)
                                                                  (let-values (((d_74) (cdr a_79)))
                                                                    (if (pair? d_74)
                                                                      (if (let-values (((a_12) (car d_74))) #t)
                                                                        (let-values (((d_75) (cdr d_74)))
                                                                          (if (pair? d_75)
                                                                            (if (let-values (((a_81) (car d_75))) #t)
                                                                              (let-values (((d_76) (cdr d_75)))
                                                                                (if (pair? d_76)
                                                                                  (if (let-values (((a_82) (car d_76)))
                                                                                        #t)
                                                                                    (let-values (((d_77) (cdr d_76)))
                                                                                      (if (pair? d_77)
                                                                                        (if (let-values (((a_83)
                                                                                                          (car d_77)))
                                                                                              #t)
                                                                                          (let-values (((d_78)
                                                                                                        (cdr d_77)))
                                                                                            (equal? '() d_78))
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
                                                          (let-values (((d_79) (cdr a_78)))
                                                            (if (pair? d_79)
                                                              (if (let-values (((a_84) (car d_79))) #t)
                                                                (let-values (((d_80) (cdr d_79))) (equal? '() d_80))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f))
                                                  (let-values (((d_41) (cdr a_77))) (equal? '() d_41))
                                                  #f)
                                                #f))
                                          (let-values (((d_10) (cdr d_8)))
                                            (if (pair? d_10)
                                              (if (let-values (((a_13) (car d_10)))
                                                    (if (pair? a_13)
                                                      (if (let-values (((a_85) (car a_13))) (equal? 'values a_85))
                                                        (let-values (((d_81) (cdr a_13)))
                                                          (if (pair? d_81)
                                                            (if (let-values (((a_86) (car d_81))) #t)
                                                              (let-values (((d_43) (cdr d_81)))
                                                                (if (pair? d_43)
                                                                  (if (let-values (((a_48) (car d_43))) #t)
                                                                    (let-values (((d_44) (cdr d_43)))
                                                                      (if (pair? d_44)
                                                                        (if (let-values (((a_49) (car d_44))) #t)
                                                                          (let-values (((d_45) (cdr d_44)))
                                                                            (list? d_45))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                (let-values (((d_82) (cdr d_10))) (equal? '() d_82))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_46) (cdr d_73))) (equal? '() d_46))
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
                         rhs_6
                         struct:2_0
                         make2_0
                         ?2_0
                         make-acc/muts_0)
                        (let-values (((d_50) (cdr v_35)))
                          (let-values (((struct:s_1 make-s_1 s?_1 acc/muts_1)
                                        (let-values (((a_56) (car d_50)))
                                          (let-values (((struct:s_2) (let-values (((a_87) (car a_56))) a_87))
                                                       ((make-s_2 s?_2 acc/muts_2)
                                                        (let-values (((d_83) (cdr a_56)))
                                                          (let-values (((make-s_3)
                                                                        (let-values (((a_88) (car d_83))) a_88))
                                                                       ((s?_3 acc/muts_3)
                                                                        (let-values (((d_84) (cdr d_83)))
                                                                          (let-values (((s?_4)
                                                                                        (let-values (((a_89)
                                                                                                      (car d_84)))
                                                                                          a_89))
                                                                                       ((acc/muts_4)
                                                                                        (let-values (((d_85)
                                                                                                      (cdr d_84)))
                                                                                          d_85)))
                                                                            (values s?_4 acc/muts_4)))))
                                                            (values make-s_3 s?_3 acc/muts_3)))))
                                            (values struct:s_2 make-s_2 s?_2 acc/muts_2))))
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
                                        (let-values (((d_86) (cdr d_50)))
                                          (let-values (((a_90) (car d_86)))
                                            (let-values (((d_87) (cdr a_90)))
                                              (let-values (((struct:_12 make_2 ?_12 -ref_12 -set!_12 rhs_8)
                                                            (let-values (((a_62) (car d_87)))
                                                              (let-values (((a_91) (car a_62)))
                                                                (let-values (((struct:_13 make_3 ?_13 -ref_13 -set!_13)
                                                                              (let-values (((a_92) (car a_91)))
                                                                                (let-values (((struct:_14)
                                                                                              (let-values (((a_93)
                                                                                                            (car a_92)))
                                                                                                a_93))
                                                                                             ((make_4
                                                                                               ?_14
                                                                                               -ref_14
                                                                                               -set!_14)
                                                                                              (let-values (((d_88)
                                                                                                            (cdr a_92)))
                                                                                                (let-values (((make_5)
                                                                                                              (let-values (((a_94)
                                                                                                                            (car
                                                                                                                             d_88)))
                                                                                                                a_94))
                                                                                                             ((?_15
                                                                                                               -ref_15
                                                                                                               -set!_15)
                                                                                                              (let-values (((d_89)
                                                                                                                            (cdr
                                                                                                                             d_88)))
                                                                                                                (let-values (((?_16)
                                                                                                                              (let-values (((a_95)
                                                                                                                                            (car
                                                                                                                                             d_89)))
                                                                                                                                a_95))
                                                                                                                             ((-ref_16
                                                                                                                               -set!_16)
                                                                                                                              (let-values (((d_90)
                                                                                                                                            (cdr
                                                                                                                                             d_89)))
                                                                                                                                (let-values (((-ref_17)
                                                                                                                                              (let-values (((a_96)
                                                                                                                                                            (car
                                                                                                                                                             d_90)))
                                                                                                                                                a_96))
                                                                                                                                             ((-set!_17)
                                                                                                                                              (let-values (((d_91)
                                                                                                                                                            (cdr
                                                                                                                                                             d_90)))
                                                                                                                                                (let-values (((a_97)
                                                                                                                                                              (car
                                                                                                                                                               d_91)))
                                                                                                                                                  a_97))))
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
                                                                             ((rhs_9)
                                                                              (let-values (((d_92) (cdr a_91)))
                                                                                (let-values (((a_98) (car d_92)))
                                                                                  a_98))))
                                                                  (values
                                                                   struct:_13
                                                                   make_3
                                                                   ?_13
                                                                   -ref_13
                                                                   -set!_13
                                                                   rhs_9)))))
                                                           ((struct:2_2 make2_2 ?2_2 make-acc/muts_2)
                                                            (let-values (((d_93) (cdr d_87)))
                                                              (let-values (((a_99) (car d_93)))
                                                                (let-values (((d_94) (cdr a_99)))
                                                                  (let-values (((struct:2_3)
                                                                                (let-values (((a_100) (car d_94)))
                                                                                  a_100))
                                                                               ((make2_3 ?2_3 make-acc/muts_3)
                                                                                (let-values (((d_95) (cdr d_94)))
                                                                                  (let-values (((make2_4)
                                                                                                (let-values (((a_30)
                                                                                                              (car
                                                                                                               d_95)))
                                                                                                  a_30))
                                                                                               ((?2_4 make-acc/muts_4)
                                                                                                (let-values (((d_96)
                                                                                                              (cdr
                                                                                                               d_95)))
                                                                                                  (let-values (((?2_5)
                                                                                                                (let-values (((a_101)
                                                                                                                              (car
                                                                                                                               d_96)))
                                                                                                                  a_101))
                                                                                                               ((make-acc/muts_5)
                                                                                                                (let-values (((d_97)
                                                                                                                              (cdr
                                                                                                                               d_96)))
                                                                                                                  d_97)))
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
                             struct:_11
                             make_1
                             ?_11
                             -ref_11
                             -set!_11
                             rhs_7
                             struct:2_1
                             make2_1
                             ?2_1
                             make-acc/muts_1)))))
            (let-values (((info_0)
                          (if (eq? struct:_10 struct:2_0)
                            (if (eq? make_0 make2_0)
                              (if (eq? ?_10 ?2_0)
                                (make-struct-type-info rhs_6 prim-knowns_0 knowns_2 imports_1 mutated_0)
                                #f)
                              #f)
                            #f)))
              (if info_0
                (let-values ()
                  (let-values (((type_0) (gensym (symbol->string make-s_0))))
                    (let-values (((knowns_5)
                                  (hash-set
                                   knowns_2
                                   make-s_0
                                   (if (struct-type-info-pure-constructor? info_0)
                                     (known-constructor type_0 (struct-type-info-field-count info_0))
                                     a-known-procedure))))
                      (let-values (((knowns_6) (hash-set knowns_5 s?_0 (known-predicate type_0))))
                        (let-values (((knowns_7)
                                      (let-values (((lst_34) acc/muts_0) ((lst_35) make-acc/muts_0))
                                        (begin
                                          (check-list lst_34)
                                          (check-list lst_35)
                                          ((letrec-values (((for-loop_16)
                                                            (lambda (knowns_8 lst_36 lst_37)
                                                              (if (if (pair? lst_36) (pair? lst_37) #f)
                                                                (let-values (((id_2) (unsafe-car lst_36))
                                                                             ((rest_20) (unsafe-cdr lst_36))
                                                                             ((maker_0) (unsafe-car lst_37))
                                                                             ((rest_21) (unsafe-cdr lst_37)))
                                                                  (let-values (((knowns_9)
                                                                                (let-values (((knowns_10) knowns_8))
                                                                                  (let-values (((knowns_11)
                                                                                                (let-values ()
                                                                                                  (if (eq?
                                                                                                       (car maker_0)
                                                                                                       -ref_10)
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
                                                                      (for-loop_16 knowns_9 rest_20 rest_21)
                                                                      knowns_9)))
                                                                knowns_8))))
                                             for-loop_16)
                                           knowns_6
                                           lst_34
                                           lst_35)))))
                          (values
                           (hash-set
                            knowns_7
                            struct:s_0
                            (known-struct-type type_0 (struct-type-info-field-count info_0)))
                           info_0))))))
                (let-values () (values knowns_2 #f)))))
          (if (if (pair? v_35)
                (if (let-values (((a_102) (car v_35))) (equal? 'define-values a_102))
                  (let-values (((d_98) (cdr v_35)))
                    (if (pair? d_98)
                      (if (let-values (((a_103) (car d_98)))
                            (if (pair? a_103)
                              (if (let-values (((a_104) (car a_103))) #t)
                                (let-values (((d_31) (cdr a_103)))
                                  (if (pair? d_31)
                                    (if (let-values (((a_35) (car d_31))) #t)
                                      (let-values (((d_32) (cdr d_31)))
                                        (if (pair? d_32)
                                          (if (let-values (((a_105) (car d_32))) #t)
                                            (let-values (((d_99) (cdr d_32)))
                                              (if (pair? d_99)
                                                (if (let-values (((a_106) (car d_99))) #t)
                                                  (let-values (((d_33) (cdr d_99)))
                                                    (if (pair? d_33)
                                                      (if (let-values (((a_107) (car d_33))) #t)
                                                        (let-values (((d_100) (cdr d_33))) (equal? '() d_100))
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
                        (let-values (((d_101) (cdr d_98)))
                          (if (pair? d_101)
                            (if (let-values (((a_36) (car d_101))) #t)
                              (let-values (((d_102) (cdr d_101))) (equal? '() d_102))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((struct:s_3 make-s_4 s?_5 s-ref_0 s-set!_0 rhs_10)
                          (let-values (((d_103) (cdr v_35)))
                            (let-values (((struct:s_4 make-s_5 s?_6 s-ref_1 s-set!_1)
                                          (let-values (((a_108) (car d_103)))
                                            (let-values (((struct:s_5) (let-values (((a_109) (car a_108))) a_109))
                                                         ((make-s_6 s?_7 s-ref_2 s-set!_2)
                                                          (let-values (((d_104) (cdr a_108)))
                                                            (let-values (((make-s_7)
                                                                          (let-values (((a_110) (car d_104))) a_110))
                                                                         ((s?_8 s-ref_3 s-set!_3)
                                                                          (let-values (((d_105) (cdr d_104)))
                                                                            (let-values (((s?_9)
                                                                                          (let-values (((a_111)
                                                                                                        (car d_105)))
                                                                                            a_111))
                                                                                         ((s-ref_4 s-set!_4)
                                                                                          (let-values (((d_106)
                                                                                                        (cdr d_105)))
                                                                                            (let-values (((s-ref_5)
                                                                                                          (let-values (((a_112)
                                                                                                                        (car
                                                                                                                         d_106)))
                                                                                                            a_112))
                                                                                                         ((s-set!_5)
                                                                                                          (let-values (((d_107)
                                                                                                                        (cdr
                                                                                                                         d_106)))
                                                                                                            (let-values (((a_113)
                                                                                                                          (car
                                                                                                                           d_107)))
                                                                                                              a_113))))
                                                                                              (values
                                                                                               s-ref_5
                                                                                               s-set!_5)))))
                                                                              (values s?_9 s-ref_4 s-set!_4)))))
                                                              (values make-s_7 s?_8 s-ref_3 s-set!_3)))))
                                              (values struct:s_5 make-s_6 s?_7 s-ref_2 s-set!_2))))
                                         ((rhs_11)
                                          (let-values (((d_108) (cdr d_103)))
                                            (let-values (((a_114) (car d_108))) a_114))))
                              (values struct:s_4 make-s_5 s?_6 s-ref_1 s-set!_1 rhs_11)))))
              (let-values (((info_1) (make-struct-type-info rhs_10 prim-knowns_0 knowns_2 imports_1 mutated_0)))
                (if info_1
                  (let-values ()
                    (let-values (((type_1) (gensym (symbol->string make-s_4))))
                      (values
                       (let-values (((knowns_12)
                                     (hash-set
                                      knowns_2
                                      make-s_4
                                      (if (struct-type-info-pure-constructor? info_1)
                                        (known-constructor type_1 (struct-type-info-field-count info_1))
                                        a-known-procedure))))
                         (let-values (((knowns_13) (hash-set knowns_12 s?_5 (known-predicate type_1))))
                           (hash-set
                            knowns_13
                            struct:s_3
                            (known-struct-type type_1 (struct-type-info-field-count info_1)))))
                       info_1)))
                  (let-values () (values knowns_2 #f)))))
            (if (if (pair? v_35)
                  (if (let-values (((a_43) (car v_35))) (equal? 'define-values a_43))
                    (let-values (((d_109) (cdr v_35)))
                      (if (pair? d_109)
                        (if (let-values (((a_115) (car d_109)))
                              (if (pair? a_115)
                                (if (let-values (((a_116) (car a_115))) #t)
                                  (let-values (((d_110) (cdr a_115)))
                                    (if (pair? d_110)
                                      (if (let-values (((a_117) (car d_110))) #t)
                                        (let-values (((d_111) (cdr d_110)))
                                          (if (pair? d_111)
                                            (if (let-values (((a_118) (car d_111))) #t)
                                              (let-values (((d_112) (cdr d_111))) (equal? '() d_112))
                                              #f)
                                            #f))
                                        #f)
                                      #f))
                                  #f)
                                #f))
                          (let-values (((d_113) (cdr d_109)))
                            (if (pair? d_113)
                              (if (let-values (((a_119) (car d_113)))
                                    (if (pair? a_119)
                                      (if (let-values (((a_120) (car a_119))) (equal? 'make-struct-type-property a_120))
                                        (let-values (((d_114) (cdr a_119)))
                                          (if (pair? d_114)
                                            (if (let-values (((a_121) (car d_114))) #t)
                                              (let-values (((d_115) (cdr d_114))) #t)
                                              #f)
                                            #f))
                                        #f)
                                      #f))
                                (let-values (((d_116) (cdr d_113))) (equal? '() d_116))
                                #f)
                              #f))
                          #f)
                        #f))
                    #f)
                  #f)
              (let-values (((prop:s_0 s?_10 s-ref_6 rest_22)
                            (let-values (((d_117) (cdr v_35)))
                              (let-values (((prop:s_1 s?_11 s-ref_7)
                                            (let-values (((a_122) (car d_117)))
                                              (let-values (((prop:s_2) (let-values (((a_123) (car a_122))) a_123))
                                                           ((s?_12 s-ref_8)
                                                            (let-values (((d_118) (cdr a_122)))
                                                              (let-values (((s?_13)
                                                                            (let-values (((a_124) (car d_118))) a_124))
                                                                           ((s-ref_9)
                                                                            (let-values (((d_119) (cdr d_118)))
                                                                              (let-values (((a_125) (car d_119)))
                                                                                a_125))))
                                                                (values s?_13 s-ref_9)))))
                                                (values prop:s_2 s?_12 s-ref_8))))
                                           ((rest_23)
                                            (let-values (((d_120) (cdr d_117)))
                                              (let-values (((a_126) (car d_120)))
                                                (let-values (((d_121) (cdr a_126)))
                                                  (let-values (((d_122) (cdr d_121))) d_122))))))
                                (values prop:s_1 s?_11 s-ref_7 rest_23)))))
                (let-values (((type_2) (gensym (symbol->string prop:s_0))))
                  (values
                   (let-values (((knowns_14) (hash-set knowns_2 s-ref_6 (known-accessor type_2))))
                     (let-values (((knowns_15) (hash-set knowns_14 s?_10 (known-predicate type_2))))
                       (if (let-values (((or-part_18) (null? rest_22)))
                             (if or-part_18 or-part_18 (if (not (car rest_22)) (null? (cdr rest_22)) #f)))
                         (let-values () (hash-set knowns_15 prop:s_0 a-known-struct-type-property/immediate-guard))
                         (let-values () knowns_15))))
                   #f)))
              (let-values () (values knowns_2 #f)))))))))
 (define-values
  (lambda?)
  (lambda (v_36)
    (let-values (((v_37) v_36))
      (if (if (pair? v_37)
            (if (let-values (((a_127) (car v_37))) (equal? 'lambda a_127)) (let-values (((d_123) (cdr v_37))) #t) #f)
            #f)
        (let-values () #t)
        (if (if (pair? v_37)
              (if (let-values (((a_128) (car v_37))) (equal? 'case-lambda a_128))
                (let-values (((d_124) (cdr v_37))) #t)
                #f)
              #f)
          (let-values () #t)
          (if (if (pair? v_37)
                (if (let-values (((a_129) (car v_37))) (equal? 'let-values a_129))
                  (let-values (((d_125) (cdr v_37)))
                    (if (pair? d_125)
                      (if (let-values (((a_130) (car d_125)))
                            (if (pair? a_130)
                              (if (let-values (((a_131) (car a_130)))
                                    (if (pair? a_131)
                                      (if (let-values (((a_132) (car a_131)))
                                            (if (pair? a_132)
                                              (if (let-values (((a_133) (car a_132))) #t)
                                                (let-values (((d_126) (cdr a_132))) (equal? '() d_126))
                                                #f)
                                              #f))
                                        (let-values (((d_127) (cdr a_131)))
                                          (if (pair? d_127)
                                            (if (let-values (((a_134) (car d_127))) #t)
                                              (let-values (((d_128) (cdr d_127))) (equal? '() d_128))
                                              #f)
                                            #f))
                                        #f)
                                      #f))
                                (let-values (((d_129) (cdr a_130))) (equal? '() d_129))
                                #f)
                              #f))
                        (let-values (((d_130) (cdr d_125)))
                          (if (pair? d_130)
                            (if (let-values (((a_135) (car d_130))) #t)
                              (let-values (((d_131) (cdr d_130))) (equal? '() d_131))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((id_3 rhs_12 body_9)
                          (let-values (((d_132) (cdr v_37)))
                            (let-values (((id_4 rhs_13)
                                          (let-values (((a_136) (car d_132)))
                                            (let-values (((a_137) (car a_136)))
                                              (let-values (((id_5)
                                                            (let-values (((a_138) (car a_137)))
                                                              (let-values (((a_139) (car a_138))) a_139)))
                                                           ((rhs_14)
                                                            (let-values (((d_133) (cdr a_137)))
                                                              (let-values (((a_140) (car d_133))) a_140))))
                                                (values id_5 rhs_14)))))
                                         ((body_10)
                                          (let-values (((d_134) (cdr d_132)))
                                            (let-values (((a_141) (car d_134))) a_141))))
                              (values id_4 rhs_13 body_10)))))
              (let-values (((or-part_19) (if (eq? id_3 body_9) (lambda? rhs_12) #f)))
                (if or-part_19 or-part_19 (lambda? body_9))))
            (if (if (pair? v_37)
                  (if (let-values (((a_142) (car v_37))) (equal? 'letrec-values a_142))
                    (let-values (((d_135) (cdr v_37)))
                      (if (pair? d_135)
                        (if (let-values (((a_143) (car d_135)))
                              (if (pair? a_143)
                                (if (let-values (((a_144) (car a_143)))
                                      (if (pair? a_144)
                                        (if (let-values (((a_145) (car a_144)))
                                              (if (pair? a_145)
                                                (if (let-values (((a_146) (car a_145))) #t)
                                                  (let-values (((d_136) (cdr a_145))) (equal? '() d_136))
                                                  #f)
                                                #f))
                                          (let-values (((d_137) (cdr a_144)))
                                            (if (pair? d_137)
                                              (if (let-values (((a_147) (car d_137))) #t)
                                                (let-values (((d_138) (cdr d_137))) (equal? '() d_138))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                  (let-values (((d_139) (cdr a_143))) (equal? '() d_139))
                                  #f)
                                #f))
                          (let-values (((d_140) (cdr d_135)))
                            (if (pair? d_140)
                              (if (let-values (((a_148) (car d_140))) #t)
                                (let-values (((d_141) (cdr d_140))) (equal? '() d_141))
                                #f)
                              #f))
                          #f)
                        #f))
                    #f)
                  #f)
              (let-values (((id_6 rhs_15 body_11)
                            (let-values (((d_142) (cdr v_37)))
                              (let-values (((id_7 rhs_16)
                                            (let-values (((a_149) (car d_142)))
                                              (let-values (((a_150) (car a_149)))
                                                (let-values (((id_8)
                                                              (let-values (((a_151) (car a_150)))
                                                                (let-values (((a_152) (car a_151))) a_152)))
                                                             ((rhs_17)
                                                              (let-values (((d_143) (cdr a_150)))
                                                                (let-values (((a_153) (car d_143))) a_153))))
                                                  (values id_8 rhs_17)))))
                                           ((body_12)
                                            (let-values (((d_144) (cdr d_142)))
                                              (let-values (((a_154) (car d_144))) a_154))))
                                (values id_7 rhs_16 body_12)))))
                (let-values (((or-part_20) (if (eq? id_6 body_11) (lambda? rhs_15) #f)))
                  (if or-part_20 or-part_20 (lambda? body_11))))
              (if (if (pair? v_37)
                    (if (let-values (((a_155) (car v_37))) (equal? 'let-values a_155))
                      (let-values (((d_145) (cdr v_37)))
                        (if (pair? d_145)
                          (if (let-values (((a_156) (car d_145))) #t)
                            (let-values (((d_146) (cdr d_145)))
                              (if (pair? d_146)
                                (if (let-values (((a_157) (car d_146))) #t)
                                  (let-values (((d_147) (cdr d_146))) (equal? '() d_147))
                                  #f)
                                #f))
                            #f)
                          #f))
                      #f)
                    #f)
                (let-values (((body_13)
                              (let-values (((d_148) (cdr v_37)))
                                (let-values (((d_149) (cdr d_148))) (let-values (((a_158) (car d_149))) a_158)))))
                  (lambda? body_13))
                (if (if (pair? v_37)
                      (if (let-values (((a_159) (car v_37))) (equal? 'letrec-values a_159))
                        (let-values (((d_150) (cdr v_37)))
                          (if (pair? d_150)
                            (if (let-values (((a_160) (car d_150))) #t)
                              (let-values (((d_151) (cdr d_150)))
                                (if (pair? d_151)
                                  (if (let-values (((a_161) (car d_151))) #t)
                                    (let-values (((d_152) (cdr d_151))) (equal? '() d_152))
                                    #f)
                                  #f))
                              #f)
                            #f))
                        #f)
                      #f)
                  (let-values (((body_14)
                                (let-values (((d_153) (cdr v_37)))
                                  (let-values (((d_154) (cdr d_153))) (let-values (((a_162) (car d_154))) a_162)))))
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
                                  (let-values (((form_0) (unsafe-car lst_39)) ((rest_24) (unsafe-cdr lst_39)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (let-values (((v_38) form_0))
                                                                          (if (if (pair? v_38)
                                                                                (if (let-values (((a_7) (car v_38)))
                                                                                      (equal? 'define-values a_7))
                                                                                  (let-values (((d_4) (cdr v_38)))
                                                                                    (if (pair? d_4)
                                                                                      (if (let-values (((a_8)
                                                                                                        (car d_4)))
                                                                                            #t)
                                                                                        (let-values (((d_155)
                                                                                                      (cdr d_4)))
                                                                                          (if (pair? d_155)
                                                                                            (if (let-values (((a_71)
                                                                                                              (car
                                                                                                               d_155)))
                                                                                                  #t)
                                                                                              (let-values (((d_70)
                                                                                                            (cdr
                                                                                                             d_155)))
                                                                                                (equal? '() d_70))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_8 rhs_18)
                                                                                          (let-values (((d_71)
                                                                                                        (cdr v_38)))
                                                                                            (let-values (((ids_9)
                                                                                                          (let-values (((a_163)
                                                                                                                        (car
                                                                                                                         d_71)))
                                                                                                            a_163))
                                                                                                         ((rhs_19)
                                                                                                          (let-values (((d_156)
                                                                                                                        (cdr
                                                                                                                         d_71)))
                                                                                                            (let-values (((a_164)
                                                                                                                          (car
                                                                                                                           d_156)))
                                                                                                              a_164))))
                                                                                              (values ids_9 rhs_19)))))
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
                                                                                                                       ((rest_25)
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
                                                                                                                                                 id_10
                                                                                                                                                 'not-ready))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_19
                                                                                                                 rest_25)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_19)
                                                                                     lst_40)))
                                                                                (void)))
                                                                            (let-values () (void)))))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_18 rest_24) (values))))
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
                                  (let-values (((form_1) (unsafe-car lst_43)) ((rest_26) (unsafe-cdr lst_43)))
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
                                                                        (let-values (((v_39) form_1))
                                                                          (if (if (pair? v_39)
                                                                                (if (let-values (((a_83) (car v_39)))
                                                                                      (equal? 'define-values a_83))
                                                                                  (let-values (((d_78) (cdr v_39)))
                                                                                    (if (pair? d_78)
                                                                                      (if (let-values (((a_165)
                                                                                                        (car d_78)))
                                                                                            #t)
                                                                                        (let-values (((d_157)
                                                                                                      (cdr d_78)))
                                                                                          (if (pair? d_157)
                                                                                            (if (let-values (((a_46)
                                                                                                              (car
                                                                                                               d_157)))
                                                                                                  #t)
                                                                                              (let-values (((d_41)
                                                                                                            (cdr
                                                                                                             d_157)))
                                                                                                (equal? '() d_41))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_10 rhs_20)
                                                                                          (let-values (((d_11)
                                                                                                        (cdr v_39)))
                                                                                            (let-values (((ids_11)
                                                                                                          (let-values (((a_166)
                                                                                                                        (car
                                                                                                                         d_11)))
                                                                                                            a_166))
                                                                                                         ((rhs_21)
                                                                                                          (let-values (((d_158)
                                                                                                                        (cdr
                                                                                                                         d_11)))
                                                                                                            (let-values (((a_167)
                                                                                                                          (car
                                                                                                                           d_158)))
                                                                                                              a_167))))
                                                                                              (values ids_11 rhs_21)))))
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
                                                                                                                (let-values (((e_3)
                                                                                                                              (unsafe-car
                                                                                                                               lst_45))
                                                                                                                             ((rest_27)
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
                                                                                                                                                             e_3
                                                                                                                                                             prim-knowns_3
                                                                                                                                                             knowns_17
                                                                                                                                                             imports_4
                                                                                                                                                             mutated_3)
                                                                                                                                                            #f)
                                                                                                                                                        (void)
                                                                                                                                                        (let-values ()
                                                                                                                                                          (find-mutated!
                                                                                                                                                           e_3
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
                                                                                                                       rest_27
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
                                                                                                                       ((rest_28)
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
                                                                                                                                                      id_11
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
                                                                                                                 rest_28)
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
                                      (if (not #f) (for-loop_20 prev-knowns_1 rest_26) prev-knowns_1)))
                                  prev-knowns_0))))
               for-loop_20)
             knowns_16
             lst_42)))
        (let-values (((lst_48) l_0))
          (begin
            (check-list lst_48)
            ((letrec-values (((for-loop_23)
                              (lambda (lst_49)
                                (if (pair? lst_49)
                                  (let-values (((form_2) (unsafe-car lst_49)) ((rest_29) (unsafe-cdr lst_49)))
                                    (let-values ((()
                                                  (let-values ()
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (begin
                                                                      (let-values ()
                                                                        (let-values (((v_40) form_2))
                                                                          (if (if (pair? v_40)
                                                                                (if (let-values (((a_168) (car v_40)))
                                                                                      (equal? 'define-values a_168))
                                                                                  (let-values (((d_159) (cdr v_40)))
                                                                                    (if (pair? d_159)
                                                                                      (if (let-values (((a_169)
                                                                                                        (car d_159)))
                                                                                            #t)
                                                                                        (let-values (((d_160)
                                                                                                      (cdr d_159)))
                                                                                          (if (pair? d_160)
                                                                                            (if (let-values (((a_170)
                                                                                                              (car
                                                                                                               d_160)))
                                                                                                  #t)
                                                                                              (let-values (((d_161)
                                                                                                            (cdr
                                                                                                             d_160)))
                                                                                                (equal? '() d_161))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((ids_12 rhs_22)
                                                                                          (let-values (((d_51)
                                                                                                        (cdr v_40)))
                                                                                            (let-values (((ids_13)
                                                                                                          (let-values (((a_171)
                                                                                                                        (car
                                                                                                                         d_51)))
                                                                                                            a_171))
                                                                                                         ((rhs_23)
                                                                                                          (let-values (((d_162)
                                                                                                                        (cdr
                                                                                                                         d_51)))
                                                                                                            (let-values (((a_172)
                                                                                                                          (car
                                                                                                                           d_162)))
                                                                                                              a_172))))
                                                                                              (values ids_13 rhs_23)))))
                                                                              (begin
                                                                                (let-values (((lst_8) ids_12))
                                                                                  (begin
                                                                                    (check-list lst_8)
                                                                                    ((letrec-values (((for-loop_4)
                                                                                                      (lambda (lst_50)
                                                                                                        (if (pair?
                                                                                                             lst_50)
                                                                                                          (let-values (((id_12)
                                                                                                                        (unsafe-car
                                                                                                                         lst_50))
                                                                                                                       ((rest_30)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_50)))
                                                                                                            (let-values ((()
                                                                                                                          (let-values ()
                                                                                                                            (let-values ((()
                                                                                                                                          (let-values ()
                                                                                                                                            (begin
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((state_0)
                                                                                                                                                              (hash-ref
                                                                                                                                                               mutated_3
                                                                                                                                                               id_12
                                                                                                                                                               #f)))
                                                                                                                                                  (if (delayed-mutated-state?
                                                                                                                                                       state_0)
                                                                                                                                                    (let-values ()
                                                                                                                                                      (begin
                                                                                                                                                        (hash-remove!
                                                                                                                                                         mutated_3
                                                                                                                                                         id_12)
                                                                                                                                                        (state_0)))
                                                                                                                                                    (void))))
                                                                                                                                              (values)))))
                                                                                                                              (values)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_4
                                                                                                                 rest_30)
                                                                                                                (values))))
                                                                                                          (values)))))
                                                                                       for-loop_4)
                                                                                     lst_8)))
                                                                                (void)))
                                                                            (let-values () (void)))))
                                                                      (values)))))
                                                      (values)))))
                                      (if (not #f) (for-loop_23 rest_29) (values))))
                                  (values)))))
               for-loop_23)
             lst_48)))
        (void)
        mutated_3))))
 (define-values
  (find-mutated!)
  (lambda (v_41 ids_14 prim-knowns_4 knowns_18 imports_5 mutated_4)
    (let-values (((delay!_0)
                  (lambda (ids_15 thunk_0)
                    (let-values (((done?_0) #f))
                      (begin
                        (let-values (((lst_51) ids_15))
                          (begin
                            (check-list lst_51)
                            ((letrec-values (((for-loop_24)
                                              (lambda (lst_26)
                                                (if (pair? lst_26)
                                                  (let-values (((id_13) (unsafe-car lst_26))
                                                               ((rest_31) (unsafe-cdr lst_26)))
                                                    (let-values ((()
                                                                  (let-values ()
                                                                    (let-values ((()
                                                                                  (let-values ()
                                                                                    (begin
                                                                                      (let-values ()
                                                                                        (if (eq?
                                                                                             'not-ready
                                                                                             (hash-ref
                                                                                              mutated_4
                                                                                              id_13
                                                                                              'not-ready))
                                                                                          (let-values ()
                                                                                            (hash-set!
                                                                                             mutated_4
                                                                                             id_13
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
                                                      (if (not #f) (for-loop_24 rest_31) (values))))
                                                  (values)))))
                               for-loop_24)
                             lst_51)))
                        (void))))))
      ((letrec-values (((find-mutated!_0)
                        (lambda (v_33 ids_16)
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
                            (let-values (((v_42) v_33))
                              (if (if (pair? v_42)
                                    (if (let-values (((a_91) (car v_42))) (equal? 'lambda a_91))
                                      (let-values (((d_163) (cdr v_42)))
                                        (if (pair? d_163)
                                          (if (let-values (((a_173) (car d_163))) #t)
                                            (let-values (((d_164) (cdr d_163))) (list? d_164))
                                            #f)
                                          #f))
                                      #f)
                                    #f)
                                (let-values (((formals_0 body_15)
                                              (let-values (((d_62) (cdr v_42)))
                                                (let-values (((formals_1) (let-values (((a_174) (car d_62))) a_174))
                                                             ((body_16) (let-values (((d_165) (cdr d_62))) d_165)))
                                                  (values formals_1 body_16)))))
                                  (if ids_16
                                    (delay!_0 ids_16 (lambda () (find-mutated!*_0 body_15 #f)))
                                    (find-mutated!*_0 body_15 #f)))
                                (if (if (pair? v_42)
                                      (if (let-values (((a_175) (car v_42))) (equal? 'case-lambda a_175))
                                        (let-values (((d_166) (cdr v_42)))
                                          (if (list? d_166)
                                            (let-values (((lst_29) d_166))
                                              (begin
                                                (check-list lst_29)
                                                ((letrec-values (((for-loop_25)
                                                                  (lambda (result_32 lst_52)
                                                                    (if (pair? lst_52)
                                                                      (let-values (((v_43) (unsafe-car lst_52))
                                                                                   ((rest_32) (unsafe-cdr lst_52)))
                                                                        (let-values (((result_33)
                                                                                      (let-values ()
                                                                                        (let-values (((result_34)
                                                                                                      (let-values ()
                                                                                                        (let-values ()
                                                                                                          (if (pair?
                                                                                                               v_43)
                                                                                                            (if (let-values (((a_176)
                                                                                                                              (car
                                                                                                                               v_43)))
                                                                                                                  #t)
                                                                                                              (let-values (((d_167)
                                                                                                                            (cdr
                                                                                                                             v_43)))
                                                                                                                (list?
                                                                                                                 d_167))
                                                                                                              #f)
                                                                                                            #f)))))
                                                                                          (values result_34)))))
                                                                          (if (if (not
                                                                                   ((lambda x_12 (not result_33)) v_43))
                                                                                (not #f)
                                                                                #f)
                                                                            (for-loop_25 result_33 rest_32)
                                                                            result_33)))
                                                                      result_32))))
                                                   for-loop_25)
                                                 #t
                                                 lst_29)))
                                            #f))
                                        #f)
                                      #f)
                                  (let-values (((formalss_0 bodys_0)
                                                (let-values (((d_168) (cdr v_42)))
                                                  (let-values (((formalss_1 bodys_1)
                                                                (let-values (((lst_30) d_168))
                                                                  (begin
                                                                    (check-list lst_30)
                                                                    ((letrec-values (((for-loop_26)
                                                                                      (lambda (formalss_2
                                                                                               bodys_2
                                                                                               lst_32)
                                                                                        (if (pair? lst_32)
                                                                                          (let-values (((v_44)
                                                                                                        (unsafe-car
                                                                                                         lst_32))
                                                                                                       ((rest_33)
                                                                                                        (unsafe-cdr
                                                                                                         lst_32)))
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
                                                                                                                                                          (let-values (((a_177)
                                                                                                                                                                        (car
                                                                                                                                                                         v_44)))
                                                                                                                                                            a_177))
                                                                                                                                                         ((bodys_6)
                                                                                                                                                          (let-values (((d_169)
                                                                                                                                                                        (cdr
                                                                                                                                                                         v_44)))
                                                                                                                                                            d_169)))
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
                                                                                                (for-loop_26
                                                                                                 formalss_3
                                                                                                 bodys_3
                                                                                                 rest_33)
                                                                                                (values
                                                                                                 formalss_3
                                                                                                 bodys_3))))
                                                                                          (values
                                                                                           formalss_2
                                                                                           bodys_2)))))
                                                                       for-loop_26)
                                                                     null
                                                                     null
                                                                     lst_30)))))
                                                    (values (reverse$1 formalss_1) (reverse$1 bodys_1))))))
                                    (if ids_16
                                      (delay!_0
                                       ids_16
                                       (lambda ()
                                         (begin
                                           (let-values (((lst_17) bodys_0))
                                             (begin
                                               (check-list lst_17)
                                               ((letrec-values (((for-loop_27)
                                                                 (lambda (lst_53)
                                                                   (if (pair? lst_53)
                                                                     (let-values (((body_17) (unsafe-car lst_53))
                                                                                  ((rest_34) (unsafe-cdr lst_53)))
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
                                                                         (if (not #f) (for-loop_27 rest_34) (values))))
                                                                     (values)))))
                                                  for-loop_27)
                                                lst_17)))
                                           (void))))
                                      (begin
                                        (let-values (((lst_54) bodys_0))
                                          (begin
                                            (check-list lst_54)
                                            ((letrec-values (((for-loop_28)
                                                              (lambda (lst_34)
                                                                (if (pair? lst_34)
                                                                  (let-values (((body_18) (unsafe-car lst_34))
                                                                               ((rest_35) (unsafe-cdr lst_34)))
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
                                                                      (if (not #f) (for-loop_28 rest_35) (values))))
                                                                  (values)))))
                                               for-loop_28)
                                             lst_54)))
                                        (void))))
                                  (if (if (pair? v_42)
                                        (if (let-values (((a_178) (car v_42))) (equal? 'quote a_178))
                                          (let-values (((d_170) (cdr v_42)))
                                            (if (pair? d_170)
                                              (if (let-values (((a_179) (car d_170))) #t)
                                                (let-values (((d_171) (cdr d_170))) (equal? '() d_171))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values () (void))
                                    (if (if (pair? v_42)
                                          (if (let-values (((a_180) (car v_42))) (equal? 'let-values a_180))
                                            (let-values (((d_172) (cdr v_42)))
                                              (if (pair? d_172)
                                                (if (let-values (((a_181) (car d_172)))
                                                      (if (list? a_181)
                                                        (let-values (((lst_55) a_181))
                                                          (begin
                                                            (check-list lst_55)
                                                            ((letrec-values (((for-loop_29)
                                                                              (lambda (result_35 lst_56)
                                                                                (if (pair? lst_56)
                                                                                  (let-values (((v_45)
                                                                                                (unsafe-car lst_56))
                                                                                               ((rest_36)
                                                                                                (unsafe-cdr lst_56)))
                                                                                    (let-values (((result_36)
                                                                                                  (let-values ()
                                                                                                    (let-values (((result_37)
                                                                                                                  (let-values ()
                                                                                                                    (let-values ()
                                                                                                                      (if (pair?
                                                                                                                           v_45)
                                                                                                                        (if (let-values (((a_182)
                                                                                                                                          (car
                                                                                                                                           v_45)))
                                                                                                                              #t)
                                                                                                                          (let-values (((d_173)
                                                                                                                                        (cdr
                                                                                                                                         v_45)))
                                                                                                                            (if (pair?
                                                                                                                                 d_173)
                                                                                                                              (if (let-values (((a_183)
                                                                                                                                                (car
                                                                                                                                                 d_173)))
                                                                                                                                    #t)
                                                                                                                                (let-values (((d_174)
                                                                                                                                              (cdr
                                                                                                                                               d_173)))
                                                                                                                                  (equal?
                                                                                                                                   '()
                                                                                                                                   d_174))
                                                                                                                                #f)
                                                                                                                              #f))
                                                                                                                          #f)
                                                                                                                        #f)))))
                                                                                                      (values
                                                                                                       result_37)))))
                                                                                      (if (if (not
                                                                                               ((lambda x_13
                                                                                                  (not result_36))
                                                                                                v_45))
                                                                                            (not #f)
                                                                                            #f)
                                                                                        (for-loop_29 result_36 rest_36)
                                                                                        result_36)))
                                                                                  result_35))))
                                                               for-loop_29)
                                                             #t
                                                             lst_55)))
                                                        #f))
                                                  (let-values (((d_175) (cdr d_172))) (list? d_175))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((idss_8 rhss_30 bodys_7)
                                                    (let-values (((d_102) (cdr v_42)))
                                                      (let-values (((idss_9 rhss_31)
                                                                    (let-values (((a_184) (car d_102)))
                                                                      (let-values (((idss_10 rhss_32)
                                                                                    (let-values (((lst_57) a_184))
                                                                                      (begin
                                                                                        (check-list lst_57)
                                                                                        ((letrec-values (((for-loop_30)
                                                                                                          (lambda (idss_11
                                                                                                                   rhss_26
                                                                                                                   lst_58)
                                                                                                            (if (pair?
                                                                                                                 lst_58)
                                                                                                              (let-values (((v_46)
                                                                                                                            (unsafe-car
                                                                                                                             lst_58))
                                                                                                                           ((rest_37)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_58)))
                                                                                                                (let-values (((idss_12
                                                                                                                               rhss_33)
                                                                                                                              (let-values (((idss_13)
                                                                                                                                            idss_11)
                                                                                                                                           ((rhss_34)
                                                                                                                                            rhss_26))
                                                                                                                                (let-values (((idss_14
                                                                                                                                               rhss_35)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((idss3_1
                                                                                                                                                               rhss4_1)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((idss_15)
                                                                                                                                                                              (let-values (((a_185)
                                                                                                                                                                                            (car
                                                                                                                                                                                             v_46)))
                                                                                                                                                                                a_185))
                                                                                                                                                                             ((rhss_36)
                                                                                                                                                                              (let-values (((d_176)
                                                                                                                                                                                            (cdr
                                                                                                                                                                                             v_46)))
                                                                                                                                                                                (let-values (((a_110)
                                                                                                                                                                                              (car
                                                                                                                                                                                               d_176)))
                                                                                                                                                                                  a_110))))
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
                                                                                                                    (for-loop_30
                                                                                                                     idss_12
                                                                                                                     rhss_33
                                                                                                                     rest_37)
                                                                                                                    (values
                                                                                                                     idss_12
                                                                                                                     rhss_33))))
                                                                                                              (values
                                                                                                               idss_11
                                                                                                               rhss_26)))))
                                                                                           for-loop_30)
                                                                                         null
                                                                                         null
                                                                                         lst_57)))))
                                                                        (values
                                                                         (reverse$1 idss_10)
                                                                         (reverse$1 rhss_32)))))
                                                                   ((bodys_8)
                                                                    (let-values (((d_105) (cdr d_102))) d_105)))
                                                        (values idss_9 rhss_31 bodys_8)))))
                                        (begin
                                          (let-values (((lst_59) idss_8) ((lst_60) rhss_30))
                                            (begin
                                              (check-list lst_59)
                                              (check-list lst_60)
                                              ((letrec-values (((for-loop_31)
                                                                (lambda (lst_61 lst_62)
                                                                  (if (if (pair? lst_61) (pair? lst_62) #f)
                                                                    (let-values (((ids_18) (unsafe-car lst_61))
                                                                                 ((rest_38) (unsafe-cdr lst_61))
                                                                                 ((rhs_24) (unsafe-car lst_62))
                                                                                 ((rest_39) (unsafe-cdr lst_62)))
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
                                                                          (for-loop_31 rest_38 rest_39)
                                                                          (values))))
                                                                    (values)))))
                                                 for-loop_31)
                                               lst_59
                                               lst_60)))
                                          (void)
                                          (find-mutated!*_0 bodys_7 ids_16)))
                                      (if (if (pair? v_42)
                                            (if (let-values (((a_113) (car v_42))) (equal? 'letrec-values a_113))
                                              (let-values (((d_108) (cdr v_42)))
                                                (if (pair? d_108)
                                                  (if (let-values (((a_114) (car d_108)))
                                                        (if (list? a_114)
                                                          (let-values (((lst_63) a_114))
                                                            (begin
                                                              (check-list lst_63)
                                                              ((letrec-values (((for-loop_32)
                                                                                (lambda (result_38 lst_64)
                                                                                  (if (pair? lst_64)
                                                                                    (let-values (((v_47)
                                                                                                  (unsafe-car lst_64))
                                                                                                 ((rest_40)
                                                                                                  (unsafe-cdr lst_64)))
                                                                                      (let-values (((result_39)
                                                                                                    (let-values ()
                                                                                                      (let-values (((result_40)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (if (pair?
                                                                                                                             v_47)
                                                                                                                          (if (let-values (((a_117)
                                                                                                                                            (car
                                                                                                                                             v_47)))
                                                                                                                                #t)
                                                                                                                            (let-values (((d_111)
                                                                                                                                          (cdr
                                                                                                                                           v_47)))
                                                                                                                              (if (pair?
                                                                                                                                   d_111)
                                                                                                                                (if (let-values (((a_118)
                                                                                                                                                  (car
                                                                                                                                                   d_111)))
                                                                                                                                      #t)
                                                                                                                                  (let-values (((d_112)
                                                                                                                                                (cdr
                                                                                                                                                 d_111)))
                                                                                                                                    (equal?
                                                                                                                                     '()
                                                                                                                                     d_112))
                                                                                                                                  #f)
                                                                                                                                #f))
                                                                                                                            #f)
                                                                                                                          #f)))))
                                                                                                        (values
                                                                                                         result_40)))))
                                                                                        (if (if (not
                                                                                                 ((lambda x_14
                                                                                                    (not result_39))
                                                                                                  v_47))
                                                                                              (not #f)
                                                                                              #f)
                                                                                          (for-loop_32
                                                                                           result_39
                                                                                           rest_40)
                                                                                          result_39)))
                                                                                    result_38))))
                                                                 for-loop_32)
                                                               #t
                                                               lst_63)))
                                                          #f))
                                                    (let-values (((d_177) (cdr d_108))) (list? d_177))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values (((idss_16 rhss_37 bodys_9)
                                                      (let-values (((d_115) (cdr v_42)))
                                                        (let-values (((idss_17 rhss_38)
                                                                      (let-values (((a_186) (car d_115)))
                                                                        (let-values (((idss_18 rhss_39)
                                                                                      (let-values (((lst_25) a_186))
                                                                                        (begin
                                                                                          (check-list lst_25)
                                                                                          ((letrec-values (((for-loop_33)
                                                                                                            (lambda (idss_19
                                                                                                                     rhss_40
                                                                                                                     lst_65)
                                                                                                              (if (pair?
                                                                                                                   lst_65)
                                                                                                                (let-values (((v_48)
                                                                                                                              (unsafe-car
                                                                                                                               lst_65))
                                                                                                                             ((rest_41)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_65)))
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
                                                                                                                                                                                (let-values (((a_187)
                                                                                                                                                                                              (car
                                                                                                                                                                                               v_48)))
                                                                                                                                                                                  a_187))
                                                                                                                                                                               ((rhss_44)
                                                                                                                                                                                (let-values (((d_122)
                                                                                                                                                                                              (cdr
                                                                                                                                                                                               v_48)))
                                                                                                                                                                                  (let-values (((a_188)
                                                                                                                                                                                                (car
                                                                                                                                                                                                 d_122)))
                                                                                                                                                                                    a_188))))
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
                                                                                                                      (for-loop_33
                                                                                                                       idss_20
                                                                                                                       rhss_41
                                                                                                                       rest_41)
                                                                                                                      (values
                                                                                                                       idss_20
                                                                                                                       rhss_41))))
                                                                                                                (values
                                                                                                                 idss_19
                                                                                                                 rhss_40)))))
                                                                                             for-loop_33)
                                                                                           null
                                                                                           null
                                                                                           lst_25)))))
                                                                          (values
                                                                           (reverse$1 idss_18)
                                                                           (reverse$1 rhss_39)))))
                                                                     ((bodys_10)
                                                                      (let-values (((d_178) (cdr d_115))) d_178)))
                                                          (values idss_17 rhss_38 bodys_10)))))
                                          (begin
                                            (let-values (((lst_66) idss_16))
                                              (begin
                                                (check-list lst_66)
                                                ((letrec-values (((for-loop_34)
                                                                  (lambda (lst_67)
                                                                    (if (pair? lst_67)
                                                                      (let-values (((ids_19) (unsafe-car lst_67))
                                                                                   ((rest_42) (unsafe-cdr lst_67)))
                                                                        (let-values ((()
                                                                                      (let-values (((lst_68) ids_19))
                                                                                        (begin
                                                                                          (check-list lst_68)
                                                                                          ((letrec-values (((for-loop_35)
                                                                                                            (lambda (lst_69)
                                                                                                              (if (pair?
                                                                                                                   lst_69)
                                                                                                                (let-values (((id_14)
                                                                                                                              (unsafe-car
                                                                                                                               lst_69))
                                                                                                                             ((rest_43)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_69)))
                                                                                                                  (let-values ((()
                                                                                                                                (let-values ()
                                                                                                                                  (let-values ((()
                                                                                                                                                (let-values ()
                                                                                                                                                  (begin
                                                                                                                                                    (let-values ()
                                                                                                                                                      (hash-set!
                                                                                                                                                       mutated_4
                                                                                                                                                       id_14
                                                                                                                                                       'not-ready))
                                                                                                                                                    (values)))))
                                                                                                                                    (values)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_35
                                                                                                                       rest_43)
                                                                                                                      (values))))
                                                                                                                (values)))))
                                                                                             for-loop_35)
                                                                                           lst_68)))))
                                                                          (if (not #f) (for-loop_34 rest_42) (values))))
                                                                      (values)))))
                                                   for-loop_34)
                                                 lst_66)))
                                            (void)
                                            (let-values (((lst_70) idss_16) ((lst_71) rhss_37))
                                              (begin
                                                (check-list lst_70)
                                                (check-list lst_71)
                                                ((letrec-values (((for-loop_36)
                                                                  (lambda (lst_72 lst_73)
                                                                    (if (if (pair? lst_72) (pair? lst_73) #f)
                                                                      (let-values (((ids_20) (unsafe-car lst_72))
                                                                                   ((rest_44) (unsafe-cdr lst_72))
                                                                                   ((rhs_25) (unsafe-car lst_73))
                                                                                   ((rest_45) (unsafe-cdr lst_73)))
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
                                                                                                              (let-values (((lst_74)
                                                                                                                            ids_20))
                                                                                                                (begin
                                                                                                                  (check-list
                                                                                                                   lst_74)
                                                                                                                  ((letrec-values (((for-loop_37)
                                                                                                                                    (lambda (lst_75)
                                                                                                                                      (if (pair?
                                                                                                                                           lst_75)
                                                                                                                                        (let-values (((id_3)
                                                                                                                                                      (unsafe-car
                                                                                                                                                       lst_75))
                                                                                                                                                     ((rest_46)
                                                                                                                                                      (unsafe-cdr
                                                                                                                                                       lst_75)))
                                                                                                                                          (let-values ((()
                                                                                                                                                        (let-values ()
                                                                                                                                                          (let-values ((()
                                                                                                                                                                        (let-values ()
                                                                                                                                                                          (begin
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (if (eq?
                                                                                                                                                                                   'not-ready
                                                                                                                                                                                   (hash-ref
                                                                                                                                                                                    mutated_4
                                                                                                                                                                                    id_3))
                                                                                                                                                                                (let-values ()
                                                                                                                                                                                  (hash-remove!
                                                                                                                                                                                   mutated_4
                                                                                                                                                                                   id_3))
                                                                                                                                                                                (void)))
                                                                                                                                                                            (values)))))
                                                                                                                                                            (values)))))
                                                                                                                                            (if (not
                                                                                                                                                 #f)
                                                                                                                                              (for-loop_37
                                                                                                                                               rest_46)
                                                                                                                                              (values))))
                                                                                                                                        (values)))))
                                                                                                                     for-loop_37)
                                                                                                                   lst_74)))
                                                                                                              (void)))
                                                                                                          (values)))))
                                                                                          (values)))))
                                                                          (if (not #f)
                                                                            (for-loop_36 rest_44 rest_45)
                                                                            (values))))
                                                                      (values)))))
                                                   for-loop_36)
                                                 lst_70
                                                 lst_71)))
                                            (void)
                                            (find-mutated!*_0 bodys_9 ids_16)))
                                        (if (if (pair? v_42)
                                              (if (let-values (((a_189) (car v_42))) (equal? 'if a_189))
                                                (let-values (((d_132) (cdr v_42)))
                                                  (if (pair? d_132)
                                                    (if (let-values (((a_190) (car d_132))) #t)
                                                      (let-values (((d_179) (cdr d_132)))
                                                        (if (pair? d_179)
                                                          (if (let-values (((a_191) (car d_179))) #t)
                                                            (let-values (((d_180) (cdr d_179)))
                                                              (if (pair? d_180)
                                                                (if (let-values (((a_137) (car d_180))) #t)
                                                                  (let-values (((d_181) (cdr d_180)))
                                                                    (equal? '() d_181))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((tst_0 thn_0 els_0)
                                                        (let-values (((d_133) (cdr v_42)))
                                                          (let-values (((tst_1)
                                                                        (let-values (((a_192) (car d_133))) a_192))
                                                                       ((thn_1 els_1)
                                                                        (let-values (((d_182) (cdr d_133)))
                                                                          (let-values (((thn_2)
                                                                                        (let-values (((a_144)
                                                                                                      (car d_182)))
                                                                                          a_144))
                                                                                       ((els_2)
                                                                                        (let-values (((d_183)
                                                                                                      (cdr d_182)))
                                                                                          (let-values (((a_146)
                                                                                                        (car d_183)))
                                                                                            a_146))))
                                                                            (values thn_2 els_2)))))
                                                            (values tst_1 thn_1 els_1)))))
                                            (begin
                                              (find-mutated!_0 tst_0 #f)
                                              (find-mutated!_0 thn_0 #f)
                                              (find-mutated!_0 els_0 #f)))
                                          (if (if (pair? v_42)
                                                (if (let-values (((a_193) (car v_42)))
                                                      (equal? 'with-continuation-mark a_193))
                                                  (let-values (((d_137) (cdr v_42)))
                                                    (if (pair? d_137)
                                                      (if (let-values (((a_147) (car d_137))) #t)
                                                        (let-values (((d_138) (cdr d_137)))
                                                          (if (pair? d_138)
                                                            (if (let-values (((a_194) (car d_138))) #t)
                                                              (let-values (((d_140) (cdr d_138)))
                                                                (if (pair? d_140)
                                                                  (if (let-values (((a_148) (car d_140))) #t)
                                                                    (let-values (((d_141) (cdr d_140)))
                                                                      (equal? '() d_141))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((key_1 val_1 body_11)
                                                          (let-values (((d_142) (cdr v_42)))
                                                            (let-values (((key_2)
                                                                          (let-values (((a_149) (car d_142))) a_149))
                                                                         ((val_2 body_12)
                                                                          (let-values (((d_184) (cdr d_142)))
                                                                            (let-values (((val_3)
                                                                                          (let-values (((a_151)
                                                                                                        (car d_184)))
                                                                                            a_151))
                                                                                         ((body_19)
                                                                                          (let-values (((d_185)
                                                                                                        (cdr d_184)))
                                                                                            (let-values (((a_195)
                                                                                                          (car d_185)))
                                                                                              a_195))))
                                                                              (values val_3 body_19)))))
                                                              (values key_2 val_2 body_12)))))
                                              (begin
                                                (find-mutated!_0 key_1 #f)
                                                (find-mutated!_0 val_1 #f)
                                                (find-mutated!_0 body_11 ids_16)))
                                            (if (if (pair? v_42)
                                                  (if (let-values (((a_153) (car v_42))) (equal? 'begin a_153))
                                                    (let-values (((d_144) (cdr v_42))) (list? d_144))
                                                    #f)
                                                  #f)
                                              (let-values (((exps_0) (let-values (((d_186) (cdr v_42))) d_186)))
                                                (find-mutated!*_0 exps_0 ids_16))
                                              (if (if (pair? v_42)
                                                    (if (let-values (((a_155) (car v_42))) (equal? 'begin0 a_155))
                                                      (let-values (((d_145) (cdr v_42)))
                                                        (if (pair? d_145)
                                                          (if (let-values (((a_156) (car d_145))) #t)
                                                            (let-values (((d_146) (cdr d_145))) (list? d_146))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f)
                                                (let-values (((exp_0 exps_1)
                                                              (let-values (((d_187) (cdr v_42)))
                                                                (let-values (((exp_1)
                                                                              (let-values (((a_158) (car d_187)))
                                                                                a_158))
                                                                             ((exps_2)
                                                                              (let-values (((d_188) (cdr d_187)))
                                                                                d_188)))
                                                                  (values exp_1 exps_2)))))
                                                  (begin (find-mutated!_0 exp_0 ids_16) (find-mutated!*_0 exps_1 #f)))
                                                (if (if (pair? v_42)
                                                      (if (let-values (((a_196) (car v_42))) (equal? 'set! a_196))
                                                        (let-values (((d_189) (cdr v_42)))
                                                          (if (pair? d_189)
                                                            (if (let-values (((a_197) (car d_189))) #t)
                                                              (let-values (((d_190) (cdr d_189)))
                                                                (if (pair? d_190)
                                                                  (if (let-values (((a_198) (car d_190))) #t)
                                                                    (let-values (((d_191) (cdr d_190)))
                                                                      (equal? '() d_191))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((id_15 rhs_26)
                                                                (let-values (((d_192) (cdr v_42)))
                                                                  (let-values (((id_16)
                                                                                (let-values (((a_199) (car d_192)))
                                                                                  a_199))
                                                                               ((rhs_27)
                                                                                (let-values (((d_193) (cdr d_192)))
                                                                                  (let-values (((a_200) (car d_193)))
                                                                                    a_200))))
                                                                    (values id_16 rhs_27)))))
                                                    (begin
                                                      (hash-set! mutated_4 id_15 'set!ed)
                                                      (find-mutated!_0 rhs_26 #f)))
                                                  (if (if (pair? v_42)
                                                        (if (let-values (((a_201) (car v_42)))
                                                              (equal? '#%variable-reference a_201))
                                                          (let-values (((d_194) (cdr v_42))) #t)
                                                          #f)
                                                        #f)
                                                    (let-values () (void))
                                                    (if (if (pair? v_42)
                                                          (if (let-values (((a_202) (car v_42))) #t)
                                                            (let-values (((d_195) (cdr v_42))) (list? d_195))
                                                            #f)
                                                          #f)
                                                      (let-values (((rator_0 exps_3)
                                                                    (let-values (((rator_1)
                                                                                  (let-values (((a_203) (car v_42)))
                                                                                    a_203))
                                                                                 ((exps_4)
                                                                                  (let-values (((d_196) (cdr v_42)))
                                                                                    d_196)))
                                                                      (values rator_1 exps_4))))
                                                        (if (if ids_16
                                                              (if (symbol? rator_0)
                                                                (if (not (hash-ref mutated_4 rator_0 #f))
                                                                  (if (let-values (((v_49)
                                                                                    (hash-ref-either
                                                                                     knowns_18
                                                                                     imports_5
                                                                                     rator_0)))
                                                                        (if (known-constructor? v_49)
                                                                          (=
                                                                           (length exps_3)
                                                                           (known-constructor-field-count v_49))
                                                                          #f))
                                                                    (let-values (((lst_76) exps_3))
                                                                      (begin
                                                                        (check-list lst_76)
                                                                        ((letrec-values (((for-loop_38)
                                                                                          (lambda (result_41 lst_77)
                                                                                            (if (pair? lst_77)
                                                                                              (let-values (((exp_2)
                                                                                                            (unsafe-car
                                                                                                             lst_77))
                                                                                                           ((rest_47)
                                                                                                            (unsafe-cdr
                                                                                                             lst_77)))
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
                                                                                                           ((lambda x_15
                                                                                                              (not
                                                                                                               result_42))
                                                                                                            exp_2))
                                                                                                        (not #f)
                                                                                                        #f)
                                                                                                    (for-loop_38
                                                                                                     result_42
                                                                                                     rest_47)
                                                                                                    result_42)))
                                                                                              result_41))))
                                                                           for-loop_38)
                                                                         #t
                                                                         lst_76)))
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
                                                        (if (symbol? v_33)
                                                          (let-values ()
                                                            (let-values (((state_1) (hash-ref mutated_4 v_33 #f)))
                                                              (if (not-ready-mutated-state? state_1)
                                                                (let-values () (hash-set! mutated_4 v_33 'too-early))
                                                                (if (delayed-mutated-state? state_1)
                                                                  (let-values ()
                                                                    (if ids_16
                                                                      (let-values ()
                                                                        (delay!_0
                                                                         ids_16
                                                                         (lambda ()
                                                                           (begin
                                                                             (hash-remove! mutated_4 v_33)
                                                                             (state_1)))))
                                                                      (let-values ()
                                                                        (begin
                                                                          (hash-remove! mutated_4 v_33)
                                                                          (state_1)))))
                                                                  (void)))))
                                                          (void))))))))))))))))))))
         find-mutated!_0)
       v_41
       ids_14))))
 (define-values
  (left-to-right/let)
  (lambda (v_14 prim-knowns_0 knowns_2 imports_1 mutated_0)
    (let-values (((v_35) v_14))
      (if (if (pair? v_35)
            (if (let-values (((a_68) (car v_35))) (equal? 'let a_68))
              (let-values (((d_67) (cdr v_35)))
                (if (pair? d_67)
                  (if (let-values (((a_3) (car d_67)))
                        (if (pair? a_3)
                          (if (let-values (((a_69) (car a_3))) #t)
                            (let-values (((d_68) (cdr a_3))) (equal? '() d_68))
                            #f)
                          #f))
                    (let-values (((d_1) (cdr d_67))) #t)
                    #f)
                  #f))
              #f)
            #f)
        (let-values () v_14)
        (if (if (pair? v_35)
              (if (let-values (((a_5) (car v_35))) (equal? 'let a_5))
                (let-values (((d_2) (cdr v_35)))
                  (if (pair? d_2)
                    (if (let-values (((a_6) (car d_2)))
                          (if (list? a_6)
                            (let-values (((lst_78) a_6))
                              (begin
                                (check-list lst_78)
                                ((letrec-values (((for-loop_39)
                                                  (lambda (result_44 lst_79)
                                                    (if (pair? lst_79)
                                                      (let-values (((v_50) (unsafe-car lst_79))
                                                                   ((rest_48) (unsafe-cdr lst_79)))
                                                        (let-values (((result_0)
                                                                      (let-values ()
                                                                        (let-values (((result_45)
                                                                                      (let-values ()
                                                                                        (let-values ()
                                                                                          (if (pair? v_50)
                                                                                            (if (let-values (((a_204)
                                                                                                              (car
                                                                                                               v_50)))
                                                                                                  #t)
                                                                                              (let-values (((d_197)
                                                                                                            (cdr v_50)))
                                                                                                (if (pair? d_197)
                                                                                                  (if (let-values (((a_75)
                                                                                                                    (car
                                                                                                                     d_197)))
                                                                                                        #t)
                                                                                                    (let-values (((d_72)
                                                                                                                  (cdr
                                                                                                                   d_197)))
                                                                                                      (equal? '() d_72))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f)))))
                                                                          (values result_45)))))
                                                          (if (if (not ((lambda x_16 (not result_0)) v_50)) (not #f) #f)
                                                            (for-loop_39 result_0 rest_48)
                                                            result_0)))
                                                      result_44))))
                                   for-loop_39)
                                 #t
                                 lst_78)))
                            #f))
                      (let-values (((d_5) (cdr d_2))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_21 rhss_45 bodys_11)
                        (let-values (((d_7) (cdr v_35)))
                          (let-values (((ids_22 rhss_46)
                                        (let-values (((a_78) (car d_7)))
                                          (let-values (((ids_23 rhss_1)
                                                        (let-values (((lst_80) a_78))
                                                          (begin
                                                            (check-list lst_80)
                                                            ((letrec-values (((for-loop_40)
                                                                              (lambda (ids_24 rhss_47 lst_81)
                                                                                (if (pair? lst_81)
                                                                                  (let-values (((v_30)
                                                                                                (unsafe-car lst_81))
                                                                                               ((rest_49)
                                                                                                (unsafe-cdr lst_81)))
                                                                                    (let-values (((ids_25 rhss_48)
                                                                                                  (let-values (((ids_26)
                                                                                                                ids_24)
                                                                                                               ((rhss_5)
                                                                                                                rhss_47))
                                                                                                    (let-values (((ids_27
                                                                                                                   rhss_49)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((ids1_0
                                                                                                                                   rhss2_1)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values (((ids_28)
                                                                                                                                                  (let-values (((a_86)
                                                                                                                                                                (car
                                                                                                                                                                 v_30)))
                                                                                                                                                    a_86))
                                                                                                                                                 ((rhss_50)
                                                                                                                                                  (let-values (((d_43)
                                                                                                                                                                (cdr
                                                                                                                                                                 v_30)))
                                                                                                                                                    (let-values (((a_48)
                                                                                                                                                                  (car
                                                                                                                                                                   d_43)))
                                                                                                                                                      a_48))))
                                                                                                                                      (values
                                                                                                                                       ids_28
                                                                                                                                       rhss_50)))))
                                                                                                                      (values
                                                                                                                       (cons
                                                                                                                        ids1_0
                                                                                                                        ids_26)
                                                                                                                       (cons
                                                                                                                        rhss2_1
                                                                                                                        rhss_5))))))
                                                                                                      (values
                                                                                                       ids_27
                                                                                                       rhss_49)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_40
                                                                                         ids_25
                                                                                         rhss_48
                                                                                         rest_49)
                                                                                        (values ids_25 rhss_48))))
                                                                                  (values ids_24 rhss_47)))))
                                                               for-loop_40)
                                                             null
                                                             null
                                                             lst_80)))))
                                            (values (reverse$1 ids_23) (reverse$1 rhss_1)))))
                                       ((bodys_12) (let-values (((d_44) (cdr d_7))) d_44)))
                            (values ids_22 rhss_46 bodys_12)))))
            ((letrec-values (((loop_6)
                              (lambda (ids_29 rhss_51 binds_0)
                                (if (null? (cdr rhss_51))
                                  (let-values ()
                                    (if (null? binds_0)
                                      (list* 'let (list (list (car ids_29) (car rhss_51))) bodys_11)
                                      (list
                                       'let
                                       (list (list (car ids_29) (car rhss_51)))
                                       (list* 'let binds_0 bodys_11))))
                                  (if (simple? (car rhss_51) prim-knowns_0 knowns_2 imports_1 mutated_0)
                                    (let-values ()
                                      (list
                                       'let
                                       (list (list (car ids_29) (car rhss_51)))
                                       (loop_6 (cdr ids_29) (cdr rhss_51) binds_0)))
                                    (let-values ()
                                      (let-values (((id_17) (car ids_29)))
                                        (list
                                         'let
                                         (list (list id_17 (car rhss_51)))
                                         (loop_6 (cdr ids_29) (cdr rhss_51) (cons (list id_17 id_17) binds_0))))))))))
               loop_6)
             ids_21
             rhss_45
             null))
          (error 'match "failed ~e" v_35))))))
 (define-values
  (left-to-right/let-values)
  (lambda (v_51 mutated_5)
    (let-values (((v_52) v_51))
      (if (if (pair? v_52)
            (if (let-values (((a_16) (car v_52))) (equal? 'let-values a_16))
              (let-values (((d_198) (cdr v_52)))
                (if (pair? d_198)
                  (if (let-values (((a_205) (car d_198)))
                        (if (pair? a_205)
                          (if (let-values (((a_206) (car a_205)))
                                (if (pair? a_206)
                                  (if (let-values (((a_207) (car a_206))) #t)
                                    (let-values (((d_199) (cdr a_206)))
                                      (if (pair? d_199)
                                        (if (let-values (((a_208) (car d_199))) #t)
                                          (let-values (((d_200) (cdr d_199))) (equal? '() d_200))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_49) (cdr a_205))) (equal? '() d_49))
                            #f)
                          #f))
                    (let-values (((d_201) (cdr d_198)))
                      (if (pair? d_201)
                        (if (let-values (((a_17) (car d_201))) #t)
                          (let-values (((d_13) (cdr d_201))) (equal? '() d_13))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((ids_30 rhs_28 body_20)
                      (let-values (((d_15) (cdr v_52)))
                        (let-values (((ids_31 rhs_29)
                                      (let-values (((a_209) (car d_15)))
                                        (let-values (((a_210) (car a_209)))
                                          (let-values (((ids_32) (let-values (((a_20) (car a_210))) a_20))
                                                       ((rhs_30)
                                                        (let-values (((d_202) (cdr a_210)))
                                                          (let-values (((a_56) (car d_202))) a_56))))
                                            (values ids_32 rhs_30)))))
                                     ((body_21)
                                      (let-values (((d_53) (cdr d_15))) (let-values (((a_57) (car d_53))) a_57))))
                          (values ids_31 rhs_29 body_21)))))
          (make-let-values ids_30 rhs_28 body_20))
        (if (if (pair? v_52)
              (if (let-values (((a_211) (car v_52))) (equal? 'let-values a_211))
                (let-values (((d_203) (cdr v_52)))
                  (if (pair? d_203)
                    (if (let-values (((a_87) (car d_203)))
                          (if (pair? a_87)
                            (if (let-values (((a_212) (car a_87)))
                                  (if (pair? a_212)
                                    (if (let-values (((a_213) (car a_212))) #t)
                                      (let-values (((d_57) (cdr a_212)))
                                        (if (pair? d_57)
                                          (if (let-values (((a_59) (car d_57))) #t)
                                            (let-values (((d_18) (cdr d_57))) (equal? '() d_18))
                                            #f)
                                          #f))
                                      #f)
                                    #f))
                              (let-values (((d_84) (cdr a_87))) (equal? '() d_84))
                              #f)
                            #f))
                      (let-values (((d_19) (cdr d_203))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_15 rhs_31 bodys_13)
                        (let-values (((d_86) (cdr v_52)))
                          (let-values (((ids_33 rhs_1)
                                        (let-values (((a_214) (car d_86)))
                                          (let-values (((a_215) (car a_214)))
                                            (let-values (((ids_34) (let-values (((a_22) (car a_215))) a_22))
                                                         ((rhs_32)
                                                          (let-values (((d_20) (cdr a_215)))
                                                            (let-values (((a_23) (car d_20))) a_23))))
                                              (values ids_34 rhs_32)))))
                                       ((bodys_14) (let-values (((d_204) (cdr d_86))) d_204)))
                            (values ids_33 rhs_1 bodys_14)))))
            (make-let-values ids_15 rhs_31 (list* 'begin bodys_13)))
          (if (if (pair? v_52)
                (if (let-values (((a_216) (car v_52))) (equal? 'let-values a_216))
                  (let-values (((d_205) (cdr v_52)))
                    (if (pair? d_205)
                      (if (let-values (((a_91) (car d_205)))
                            (if (list? a_91)
                              (let-values (((lst_82) a_91))
                                (begin
                                  (check-list lst_82)
                                  ((letrec-values (((for-loop_41)
                                                    (lambda (result_13 lst_83)
                                                      (if (pair? lst_83)
                                                        (let-values (((v_53) (unsafe-car lst_83))
                                                                     ((rest_50) (unsafe-cdr lst_83)))
                                                          (let-values (((result_46)
                                                                        (let-values ()
                                                                          (let-values (((result_47)
                                                                                        (let-values ()
                                                                                          (let-values ()
                                                                                            (if (pair? v_53)
                                                                                              (if (let-values (((a_217)
                                                                                                                (car
                                                                                                                 v_53)))
                                                                                                    (list? a_217))
                                                                                                (let-values (((d_23)
                                                                                                              (cdr
                                                                                                               v_53)))
                                                                                                  (if (pair? d_23)
                                                                                                    (if (let-values (((a_26)
                                                                                                                      (car
                                                                                                                       d_23)))
                                                                                                          #t)
                                                                                                      (let-values (((d_24)
                                                                                                                    (cdr
                                                                                                                     d_23)))
                                                                                                        (equal?
                                                                                                         '()
                                                                                                         d_24))
                                                                                                      #f)
                                                                                                    #f))
                                                                                                #f)
                                                                                              #f)))))
                                                                            (values result_47)))))
                                                            (if (if (not ((lambda x_17 (not result_46)) v_53))
                                                                  (not #f)
                                                                  #f)
                                                              (for-loop_41 result_46 rest_50)
                                                              result_46)))
                                                        result_13))))
                                     for-loop_41)
                                   #t
                                   lst_82)))
                              #f))
                        (let-values (((d_206) (cdr d_205))) #t)
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((idss_24 rhss_52 bodys_15)
                          (let-values (((d_207) (cdr v_52)))
                            (let-values (((idss_25 rhss_53)
                                          (let-values (((a_218) (car d_207)))
                                            (let-values (((idss_26 rhss_54)
                                                          (let-values (((lst_84) a_218))
                                                            (begin
                                                              (check-list lst_84)
                                                              ((letrec-values (((for-loop_42)
                                                                                (lambda (idss_27 rhss_55 lst_30)
                                                                                  (if (pair? lst_30)
                                                                                    (let-values (((v_54)
                                                                                                  (unsafe-car lst_30))
                                                                                                 ((rest_51)
                                                                                                  (unsafe-cdr lst_30)))
                                                                                      (let-values (((idss_5 rhss_19)
                                                                                                    (let-values (((idss_6)
                                                                                                                  idss_27)
                                                                                                                 ((rhss_20)
                                                                                                                  rhss_55))
                                                                                                      (let-values (((idss_28
                                                                                                                     rhss_56)
                                                                                                                    (let-values ()
                                                                                                                      (let-values (((idss3_2
                                                                                                                                     rhss4_2)
                                                                                                                                    (let-values ()
                                                                                                                                      (let-values (((idss_29)
                                                                                                                                                    (let-values (((a_29)
                                                                                                                                                                  (car
                                                                                                                                                                   v_54)))
                                                                                                                                                      a_29))
                                                                                                                                                   ((rhss_57)
                                                                                                                                                    (let-values (((d_27)
                                                                                                                                                                  (cdr
                                                                                                                                                                   v_54)))
                                                                                                                                                      (let-values (((a_30)
                                                                                                                                                                    (car
                                                                                                                                                                     d_27)))
                                                                                                                                                        a_30))))
                                                                                                                                        (values
                                                                                                                                         idss_29
                                                                                                                                         rhss_57)))))
                                                                                                                        (values
                                                                                                                         (cons
                                                                                                                          idss3_2
                                                                                                                          idss_6)
                                                                                                                         (cons
                                                                                                                          rhss4_2
                                                                                                                          rhss_20))))))
                                                                                                        (values
                                                                                                         idss_28
                                                                                                         rhss_56)))))
                                                                                        (if (not #f)
                                                                                          (for-loop_42
                                                                                           idss_5
                                                                                           rhss_19
                                                                                           rest_51)
                                                                                          (values idss_5 rhss_19))))
                                                                                    (values idss_27 rhss_55)))))
                                                                 for-loop_42)
                                                               null
                                                               null
                                                               lst_84)))))
                                              (values (reverse$1 idss_26) (reverse$1 rhss_54)))))
                                         ((bodys_16) (let-values (((d_96) (cdr d_207))) d_96)))
                              (values idss_25 rhss_53 bodys_16)))))
              ((letrec-values (((loop_7)
                                (lambda (idss_30 rhss_58 binds_1)
                                  (if (null? (cdr rhss_58))
                                    (let-values ()
                                      (make-let-values (car idss_30) (car rhss_58) (list* 'let binds_1 bodys_15)))
                                    (let-values ()
                                      (let-values (((ids_35) (car idss_30)))
                                        (make-let-values
                                         ids_35
                                         (car rhss_58)
                                         (loop_7
                                          (cdr idss_30)
                                          (cdr rhss_58)
                                          (append (map2 (lambda (id_18) (list id_18 id_18)) ids_35) binds_1)))))))))
                 loop_7)
               idss_24
               rhss_52
               null))
            (error 'match "failed ~e" v_52)))))))
 (define-values
  (left-to-right/app)
  (lambda (v_55 prim-knowns_5 knowns_7 imports_6 mutated_6)
    ((letrec-values (((loop_8)
                      (lambda (l_11 accum_0)
                        (if (null? l_11)
                          (let-values () (reverse$1 accum_0))
                          (if (simple? (car l_11) prim-knowns_5 knowns_7 imports_6 mutated_6)
                            (let-values () (loop_8 (cdr l_11) (cons (car l_11) accum_0)))
                            (if (andmap2
                                 (lambda (v_56) (simple? v_56 prim-knowns_5 knowns_7 imports_6 mutated_6))
                                 (cdr l_11))
                              (let-values () (append (reverse$1 accum_0) l_11))
                              (let-values ()
                                (let-values (((g_0) (gensym "app_")))
                                  (list
                                   'let
                                   (list (list g_0 (car l_11)))
                                   (loop_8 (cdr l_11) (cons g_0 accum_0)))))))))))
       loop_8)
     v_55
     null)))
 (define-values
  (make-let-values)
  (lambda (ids_36 rhs_33 body_22)
    (if (if (pair? ids_36) (null? (cdr ids_36)) #f)
      (let-values () (list 'let (list (list (car ids_36) rhs_33)) body_22))
      (let-values ()
        (let-values (((v_57) (if (null? ids_36) rhs_33 #f)))
          (if (if (pair? v_57)
                (if (let-values (((a_219) (car v_57))) (equal? 'begin a_219))
                  (let-values (((d_208) (cdr v_57)))
                    (if (pair? d_208)
                      (if (let-values (((a_102) (car d_208))) #t)
                        (let-values (((d_98) (cdr d_208)))
                          (if (pair? d_98)
                            (if (let-values (((a_103) (car d_98)))
                                  (if (pair? a_103)
                                    (if (let-values (((a_104) (car a_103))) (equal? 'values a_104))
                                      (let-values (((d_31) (cdr a_103))) (equal? '() d_31))
                                      #f)
                                    #f))
                              (let-values (((d_209) (cdr d_98))) (equal? '() d_209))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((rhs_34) (let-values (((d_173) (cdr v_57))) (let-values (((a_183) (car d_173))) a_183))))
              (list 'begin rhs_34 body_22))
            (let-values ()
              (list
               'call-with-values
               (list 'lambda '() rhs_33)
               (list
                'case-lambda
                (list ids_36 body_22)
                (list 'args (list* 'raise-result-arity-error (list 'quote ids_36) '(args))))))))))))
 (define-values
  (schemify-linklet)
  (lambda (lk_0 prim-knowns_0 get-import-knowns_0)
    (let-values (((im-int-id_0) (lambda (id_19) (if (pair? id_19) (cadr id_19) id_19))))
      (let-values (((im-ext-id_0) (lambda (id_20) (if (pair? id_20) (car id_20) id_20))))
        (let-values (((ex-int-id_0) (lambda (id_0) (if (pair? id_0) (car id_0) id_0))))
          (let-values (((ex-ext-id_0) (lambda (id_21) (if (pair? id_21) (cadr id_21) id_21))))
            (let-values (((imports_7)
                          (let-values (((lst_85) (cadr lk_0)) ((start_1) 0))
                            (begin
                              (check-list lst_85)
                              (check-naturals start_1)
                              ((letrec-values (((for-loop_43)
                                                (lambda (imports_8 lst_86 pos_2)
                                                  (if (if (pair? lst_86) #t #f)
                                                    (let-values (((im-ids_0) (unsafe-car lst_86))
                                                                 ((rest_52) (unsafe-cdr lst_86))
                                                                 ((index_0) pos_2))
                                                      (let-values (((imports_9)
                                                                    (let-values (((imports_10) imports_8))
                                                                      (let-values (((imports_11)
                                                                                    (let-values ()
                                                                                      (let-values (((grp_1)
                                                                                                    (import-group2.1
                                                                                                     (lambda ()
                                                                                                       (get-import-knowns_0
                                                                                                        index_0)))))
                                                                                        (let-values (((lst_87)
                                                                                                      im-ids_0))
                                                                                          (begin
                                                                                            (check-list lst_87)
                                                                                            ((letrec-values (((for-loop_44)
                                                                                                              (lambda (imports_12
                                                                                                                       lst_41)
                                                                                                                (if (pair?
                                                                                                                     lst_41)
                                                                                                                  (let-values (((im-id_0)
                                                                                                                                (unsafe-car
                                                                                                                                 lst_41))
                                                                                                                               ((rest_25)
                                                                                                                                (unsafe-cdr
                                                                                                                                 lst_41)))
                                                                                                                    (let-values (((imports_13)
                                                                                                                                  (let-values (((imports_14)
                                                                                                                                                imports_12))
                                                                                                                                    (let-values (((imports_15)
                                                                                                                                                  (let-values ()
                                                                                                                                                    (let-values (((id_22)
                                                                                                                                                                  (im-int-id_0
                                                                                                                                                                   im-id_0)))
                                                                                                                                                      (let-values (((ext-id_0)
                                                                                                                                                                    (im-ext-id_0
                                                                                                                                                                     im-id_0)))
                                                                                                                                                        (hash-set
                                                                                                                                                         imports_14
                                                                                                                                                         id_22
                                                                                                                                                         (import1.1
                                                                                                                                                          grp_1
                                                                                                                                                          (gensym
                                                                                                                                                           (symbol->string
                                                                                                                                                            id_22))
                                                                                                                                                          ext-id_0)))))))
                                                                                                                                      (values
                                                                                                                                       imports_15)))))
                                                                                                                      (if (not
                                                                                                                           #f)
                                                                                                                        (for-loop_44
                                                                                                                         imports_13
                                                                                                                         rest_25)
                                                                                                                        imports_13)))
                                                                                                                  imports_12))))
                                                                                               for-loop_44)
                                                                                             imports_10
                                                                                             lst_87)))))))
                                                                        (values imports_11)))))
                                                        (if (not #f)
                                                          (for-loop_43 imports_9 rest_52 (+ pos_2 1))
                                                          imports_9)))
                                                    imports_8))))
                                 for-loop_43)
                               (hasheq)
                               lst_85
                               start_1)))))
              (let-values (((exports_1)
                            (let-values (((lst_80) (caddr lk_0)))
                              (begin
                                (check-list lst_80)
                                ((letrec-values (((for-loop_40)
                                                  (lambda (exports_2 lst_2)
                                                    (if (pair? lst_2)
                                                      (let-values (((ex_0) (unsafe-car lst_2))
                                                                   ((rest_53) (unsafe-cdr lst_2)))
                                                        (let-values (((exports_3)
                                                                      (let-values (((exports_4) exports_2))
                                                                        (let-values (((exports_5)
                                                                                      (let-values ()
                                                                                        (let-values (((id_23)
                                                                                                      (if (pair? ex_0)
                                                                                                        (car ex_0)
                                                                                                        ex_0)))
                                                                                          (hash-set
                                                                                           exports_4
                                                                                           id_23
                                                                                           (gensym
                                                                                            (symbol->string id_23)))))))
                                                                          (values exports_5)))))
                                                          (if (not #f) (for-loop_40 exports_3 rest_53) exports_3)))
                                                      exports_2))))
                                   for-loop_40)
                                 (hasheq)
                                 lst_80)))))
                (let-values (((new-body_0 defn-info_0 mutated_7)
                              (schemify-body* (cdddr lk_0) prim-knowns_0 imports_7 exports_1)))
                  (values
                   (list*
                    'lambda
                    (list*
                     'instance-variable-reference
                     (qq-append
                      (let-values (((lst_88) (cadr lk_0)))
                        (begin
                          (check-list lst_88)
                          ((letrec-values (((for-loop_45)
                                            (lambda (lst_89)
                                              (if (pair? lst_89)
                                                (let-values (((ims_0) (unsafe-car lst_89))
                                                             ((rest_54) (unsafe-cdr lst_89)))
                                                  (let-values (((post-guard-var_0) (lambda () #t)))
                                                    (let-values (((lst_90) ims_0))
                                                      (begin
                                                        (check-list lst_90)
                                                        ((letrec-values (((for-loop_46)
                                                                          (lambda (lst_91)
                                                                            (if (pair? lst_91)
                                                                              (let-values (((im_1) (unsafe-car lst_91))
                                                                                           ((rest_55)
                                                                                            (unsafe-cdr lst_91)))
                                                                                (let-values (((post-guard-var_1)
                                                                                              (lambda () #t)))
                                                                                  (let-values ()
                                                                                    (let-values (((elem_0)
                                                                                                  (let-values ()
                                                                                                    (let-values ()
                                                                                                      (import-id
                                                                                                       (hash-ref
                                                                                                        imports_7
                                                                                                        (im-int-id_0
                                                                                                         im_1)))))))
                                                                                      (let-values (((result_4)
                                                                                                    (if (post-guard-var_1)
                                                                                                      (for-loop_46
                                                                                                       rest_55)
                                                                                                      (if (post-guard-var_0)
                                                                                                        (for-loop_45
                                                                                                         rest_54)
                                                                                                        null))))
                                                                                        (cons elem_0 result_4))))))
                                                                              (if (post-guard-var_0)
                                                                                (for-loop_45 rest_54)
                                                                                null)))))
                                                           for-loop_46)
                                                         lst_90)))))
                                                null))))
                             for-loop_45)
                           lst_88)))
                      (let-values (((lst_45) (caddr lk_0)))
                        (begin
                          (check-list lst_45)
                          ((letrec-values (((for-loop_47)
                                            (lambda (lst_92)
                                              (if (pair? lst_92)
                                                (let-values (((ex_1) (unsafe-car lst_92))
                                                             ((rest_56) (unsafe-cdr lst_92)))
                                                  (let-values (((post-guard-var_2) (lambda () #t)))
                                                    (let-values ()
                                                      (let-values (((elem_1)
                                                                    (let-values ()
                                                                      (let-values ()
                                                                        (hash-ref exports_1 (ex-int-id_0 ex_1))))))
                                                        (let-values (((result_48)
                                                                      (if (post-guard-var_2)
                                                                        (for-loop_47 rest_56)
                                                                        null)))
                                                          (cons elem_1 result_48))))))
                                                null))))
                             for-loop_47)
                           lst_45)))))
                    new-body_0)
                   (let-values (((lst_93) (cadr lk_0)))
                     (begin
                       (check-list lst_93)
                       ((letrec-values (((for-loop_48)
                                         (lambda (lst_48)
                                           (if (pair? lst_48)
                                             (let-values (((ims_1) (unsafe-car lst_48)) ((rest_57) (unsafe-cdr lst_48)))
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
                                                                                                      imports_7
                                                                                                      (im-int-id_0
                                                                                                       (car ims_1)))))))
                                                                                       (if (procedure? k/t_0) #f k/t_0))
                                                                                     #f)))
                                                                       (let-values (((lst_94) ims_1))
                                                                         (begin
                                                                           (check-list lst_94)
                                                                           ((letrec-values (((for-loop_49)
                                                                                             (lambda (lst_95)
                                                                                               (if (pair? lst_95)
                                                                                                 (let-values (((im_2)
                                                                                                               (unsafe-car
                                                                                                                lst_95))
                                                                                                              ((rest_58)
                                                                                                               (unsafe-cdr
                                                                                                                lst_95)))
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
                                                                                                                              im_2)
                                                                                                                             #f))
                                                                                                                           #f)))))
                                                                                                         (let-values (((result_49)
                                                                                                                       (if (post-guard-var_4)
                                                                                                                         (for-loop_49
                                                                                                                          rest_58)
                                                                                                                         null)))
                                                                                                           (cons
                                                                                                            elem_3
                                                                                                            result_49))))))
                                                                                                 null))))
                                                                              for-loop_49)
                                                                            lst_94))))))))
                                                     (let-values (((result_50)
                                                                   (if (post-guard-var_3) (for-loop_48 rest_57) null)))
                                                       (cons elem_2 result_50))))))
                                             null))))
                          for-loop_48)
                        lst_93)))
                   (let-values (((lst_96) (caddr lk_0)))
                     (begin
                       (check-list lst_96)
                       ((letrec-values (((for-loop_50)
                                         (lambda (knowns_19 lst_97)
                                           (if (pair? lst_97)
                                             (let-values (((ex_2) (unsafe-car lst_97)) ((rest_59) (unsafe-cdr lst_97)))
                                               (let-values (((knowns_20)
                                                             (let-values (((knowns_21) knowns_19))
                                                               (let-values (((knowns_22)
                                                                             (let-values ()
                                                                               (let-values (((id_24)
                                                                                             (ex-int-id_0 ex_2)))
                                                                                 (let-values (((v_41)
                                                                                               (hash-ref
                                                                                                defn-info_0
                                                                                                id_24
                                                                                                #f)))
                                                                                   (if (if v_41
                                                                                         (not
                                                                                          (set!ed-mutated-state?
                                                                                           (hash-ref
                                                                                            mutated_7
                                                                                            id_24
                                                                                            #f)))
                                                                                         #f)
                                                                                     (let-values ()
                                                                                       (let-values (((ext-id_1)
                                                                                                     (ex-ext-id_0
                                                                                                      id_24)))
                                                                                         (hash-set
                                                                                          knowns_21
                                                                                          ext-id_1
                                                                                          v_41)))
                                                                                     (let-values () knowns_21)))))))
                                                                 (values knowns_22)))))
                                                 (if (not #f) (for-loop_50 knowns_20 rest_59) knowns_20)))
                                             knowns_19))))
                          for-loop_50)
                        (hasheq)
                        lst_96)))))))))))))
 (define-values
  (schemify-body)
  (lambda (l_12 prim-knowns_6 imports_5 exports_6)
    (let-values (((new-body_1 defn-info_1 mutated_2) (schemify-body* l_12 prim-knowns_6 imports_5 exports_6)))
      new-body_1)))
 (define-values
  (schemify-body*)
  (lambda (l_13 prim-knowns_7 imports_16 exports_7)
    (let-values (((mutated_8) (mutated-in-body l_13 exports_7 prim-knowns_7 (hasheq) imports_16)))
      (let-values (((knowns_23)
                    (let-values (((lst_98) l_13))
                      (begin
                        (check-list lst_98)
                        ((letrec-values (((for-loop_51)
                                          (lambda (knowns_24 lst_99)
                                            (if (pair? lst_99)
                                              (let-values (((form_3) (unsafe-car lst_99))
                                                           ((rest_60) (unsafe-cdr lst_99)))
                                                (let-values (((knowns_25)
                                                              (let-values (((knowns_26) knowns_24))
                                                                (let-values (((knowns_27)
                                                                              (let-values ()
                                                                                (let-values (((new-knowns_0 info_3)
                                                                                              (find-definitions
                                                                                               form_3
                                                                                               prim-knowns_7
                                                                                               knowns_26
                                                                                               imports_16
                                                                                               mutated_8)))
                                                                                  new-knowns_0))))
                                                                  (values knowns_27)))))
                                                  (if (not #f) (for-loop_51 knowns_25 rest_60) knowns_25)))
                                              knowns_24))))
                           for-loop_51)
                         (hasheq)
                         lst_98)))))
        (let-values (((schemified_0)
                      ((letrec-values (((loop_9)
                                        (lambda (l_14 accum-exprs_0 accum-ids_0)
                                          (if (null? l_14)
                                            (let-values ()
                                              (let-values (((set-vars_0)
                                                            (let-values (((lst_100) accum-ids_0))
                                                              (begin
                                                                (check-list lst_100)
                                                                ((letrec-values (((for-loop_52)
                                                                                  (lambda (lst_101)
                                                                                    (if (pair? lst_101)
                                                                                      (let-values (((id_25)
                                                                                                    (unsafe-car
                                                                                                     lst_101))
                                                                                                   ((rest_61)
                                                                                                    (unsafe-cdr
                                                                                                     lst_101)))
                                                                                        (let-values (((post-guard-var_5)
                                                                                                      (lambda () #t)))
                                                                                          (let-values ()
                                                                                            (if (hash-ref
                                                                                                 exports_7
                                                                                                 id_25
                                                                                                 #f)
                                                                                              (let-values ()
                                                                                                (let-values (((elem_4)
                                                                                                              (let-values ()
                                                                                                                (let-values ()
                                                                                                                  (make-set-variable
                                                                                                                   id_25
                                                                                                                   exports_7)))))
                                                                                                  (let-values (((result_32)
                                                                                                                (if (post-guard-var_5)
                                                                                                                  (for-loop_52
                                                                                                                   rest_61)
                                                                                                                  null)))
                                                                                                    (cons
                                                                                                     elem_4
                                                                                                     result_32))))
                                                                                              (if (post-guard-var_5)
                                                                                                (for-loop_52 rest_61)
                                                                                                null)))))
                                                                                      null))))
                                                                   for-loop_52)
                                                                 lst_100)))))
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
                                                               prim-knowns_7
                                                               knowns_23
                                                               mutated_8
                                                               imports_16
                                                               exports_7
                                                               form_4)))
                                                  (let-values (((v_58) form_4))
                                                    (if (if (pair? v_58)
                                                          (if (let-values (((a_94) (car v_58)))
                                                                (equal? 'define-values a_94))
                                                            (let-values (((d_89) (cdr v_58)))
                                                              (if (pair? d_89)
                                                                (if (let-values (((a_27) (car d_89))) #t)
                                                                  (let-values (((d_210) (cdr d_89)))
                                                                    (if (pair? d_210)
                                                                      (if (let-values (((a_218) (car d_210))) #t)
                                                                        (let-values (((d_63) (cdr d_210)))
                                                                          (equal? '() d_63))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f)
                                                      (let-values (((ids_37)
                                                                    (let-values (((d_211) (cdr v_58)))
                                                                      (let-values (((a_64) (car d_211))) a_64))))
                                                        (append
                                                         (make-expr-defns accum-exprs_0)
                                                         (cons
                                                          schemified_1
                                                          ((letrec-values (((id-loop_0)
                                                                            (lambda (ids_38 accum-exprs_1 accum-ids_1)
                                                                              (if (null? ids_38)
                                                                                (let-values ()
                                                                                  (loop_9
                                                                                   (cdr l_14)
                                                                                   accum-exprs_1
                                                                                   accum-ids_1))
                                                                                (if (via-variable-mutated-state?
                                                                                     (hash-ref
                                                                                      mutated_8
                                                                                      (car ids_38)
                                                                                      #f))
                                                                                  (let-values ()
                                                                                    (let-values (((id_26) (car ids_38)))
                                                                                      (if (hash-ref exports_7 id_26 #f)
                                                                                        (let-values ()
                                                                                          (id-loop_0
                                                                                           (cdr ids_38)
                                                                                           (cons
                                                                                            (make-set-variable
                                                                                             id_26
                                                                                             exports_7)
                                                                                            accum-exprs_1)
                                                                                           accum-ids_1))
                                                                                        (let-values ()
                                                                                          (id-loop_0
                                                                                           (cdr ids_38)
                                                                                           accum-exprs_1
                                                                                           accum-ids_1)))))
                                                                                  (let-values ()
                                                                                    (id-loop_0
                                                                                     (cdr ids_38)
                                                                                     accum-exprs_1
                                                                                     (cons
                                                                                      (car ids_38)
                                                                                      accum-ids_1))))))))
                                                             id-loop_0)
                                                           ids_37
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
          (values schemified_0 knowns_23 mutated_8))))))
 (define-values
  (make-set-variable)
  (lambda (id_27 exports_8)
    (let-values (((ex-var_0) (hash-ref exports_8 id_27))) (list 'variable-set! ex-var_0 id_27))))
 (define-values
  (make-expr-defns)
  (lambda (accum-exprs_2)
    (let-values (((lst_102) (reverse$1 accum-exprs_2)))
      (begin
        (check-list lst_102)
        ((letrec-values (((for-loop_53)
                          (lambda (lst_103)
                            (if (pair? lst_103)
                              (let-values (((expr_0) (unsafe-car lst_103)) ((rest_62) (unsafe-cdr lst_103)))
                                (let-values (((post-guard-var_6) (lambda () #t)))
                                  (let-values ()
                                    (let-values (((elem_5)
                                                  (let-values () (let-values () (list 'define (gensym) expr_0)))))
                                      (let-values (((result_51) (if (post-guard-var_6) (for-loop_53 rest_62) null)))
                                        (cons elem_5 result_51))))))
                              null))))
           for-loop_53)
         lst_102)))))
 (define-values
  (schemify)
  (lambda (prim-knowns_8 knowns_28 mutated_9 imports_17 exports_9 v_59)
    ((letrec-values (((schemify/knowns_0)
                      (lambda (knowns_29 v_55)
                        ((letrec-values (((schemify_0)
                                          (lambda (v_60)
                                            (let-values (((v_61) v_60))
                                              (if (if (pair? v_61)
                                                    (if (let-values (((a_220) (car v_61))) (equal? 'lambda a_220))
                                                      (let-values (((d_212) (cdr v_61)))
                                                        (if (pair? d_212)
                                                          (if (let-values (((a_178) (car d_212))) #t)
                                                            (let-values (((d_170) (cdr d_212))) (list? d_170))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f)
                                                (let-values (((formals_2 body_23)
                                                              (let-values (((d_213) (cdr v_61)))
                                                                (let-values (((formals_3)
                                                                              (let-values (((a_221) (car d_213)))
                                                                                a_221))
                                                                             ((body_22)
                                                                              (let-values (((d_214) (cdr d_213)))
                                                                                d_214)))
                                                                  (values formals_3 body_22)))))
                                                  (list* 'lambda formals_2 (map2 schemify_0 body_23)))
                                                (if (if (pair? v_61)
                                                      (if (let-values (((a_33) (car v_61))) (equal? 'case-lambda a_33))
                                                        (let-values (((d_29) (cdr v_61)))
                                                          (if (list? d_29)
                                                            (let-values (((lst_104) d_29))
                                                              (begin
                                                                (check-list lst_104)
                                                                ((letrec-values (((for-loop_54)
                                                                                  (lambda (result_36 lst_105)
                                                                                    (if (pair? lst_105)
                                                                                      (let-values (((v_62)
                                                                                                    (unsafe-car
                                                                                                     lst_105))
                                                                                                   ((rest_63)
                                                                                                    (unsafe-cdr
                                                                                                     lst_105)))
                                                                                        (let-values (((result_52)
                                                                                                      (let-values ()
                                                                                                        (let-values (((result_53)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (if (pair?
                                                                                                                               v_62)
                                                                                                                            (if (let-values (((a_222)
                                                                                                                                              (car
                                                                                                                                               v_62)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_175)
                                                                                                                                            (cdr
                                                                                                                                             v_62)))
                                                                                                                                (list?
                                                                                                                                 d_175))
                                                                                                                              #f)
                                                                                                                            #f)))))
                                                                                                          (values
                                                                                                           result_53)))))
                                                                                          (if (if (not
                                                                                                   ((lambda x_18
                                                                                                      (not result_52))
                                                                                                    v_62))
                                                                                                (not #f)
                                                                                                #f)
                                                                                            (for-loop_54
                                                                                             result_52
                                                                                             rest_63)
                                                                                            result_52)))
                                                                                      result_36))))
                                                                   for-loop_54)
                                                                 #t
                                                                 lst_104)))
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((formalss_7 bodys_7)
                                                                (let-values (((d_102) (cdr v_61)))
                                                                  (let-values (((formalss_8 bodys_17)
                                                                                (let-values (((lst_106) d_102))
                                                                                  (begin
                                                                                    (check-list lst_106)
                                                                                    ((letrec-values (((for-loop_55)
                                                                                                      (lambda (formalss_9
                                                                                                               bodys_18
                                                                                                               lst_57)
                                                                                                        (if (pair?
                                                                                                             lst_57)
                                                                                                          (let-values (((v_63)
                                                                                                                        (unsafe-car
                                                                                                                         lst_57))
                                                                                                                       ((rest_64)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_57)))
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
                                                                                                                                                            (let-values (((formalss_13)
                                                                                                                                                                          (let-values (((a_109)
                                                                                                                                                                                        (car
                                                                                                                                                                                         v_63)))
                                                                                                                                                                            a_109))
                                                                                                                                                                         ((bodys_22)
                                                                                                                                                                          (let-values (((d_104)
                                                                                                                                                                                        (cdr
                                                                                                                                                                                         v_63)))
                                                                                                                                                                            d_104)))
                                                                                                                                                              (values
                                                                                                                                                               formalss_13
                                                                                                                                                               bodys_22)))))
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
                                                                                                                (for-loop_55
                                                                                                                 formalss_10
                                                                                                                 bodys_19
                                                                                                                 rest_64)
                                                                                                                (values
                                                                                                                 formalss_10
                                                                                                                 bodys_19))))
                                                                                                          (values
                                                                                                           formalss_9
                                                                                                           bodys_18)))))
                                                                                       for-loop_55)
                                                                                     null
                                                                                     null
                                                                                     lst_106)))))
                                                                    (values
                                                                     (reverse$1 formalss_8)
                                                                     (reverse$1 bodys_17))))))
                                                    (list*
                                                     'case-lambda
                                                     (let-values (((lst_107) formalss_7) ((lst_108) bodys_7))
                                                       (begin
                                                         (check-list lst_107)
                                                         (check-list lst_108)
                                                         ((letrec-values (((for-loop_56)
                                                                           (lambda (lst_109 lst_110)
                                                                             (if (if (pair? lst_109) (pair? lst_110) #f)
                                                                               (let-values (((formals_4)
                                                                                             (unsafe-car lst_109))
                                                                                            ((rest_65)
                                                                                             (unsafe-cdr lst_109))
                                                                                            ((body_24)
                                                                                             (unsafe-car lst_110))
                                                                                            ((rest_66)
                                                                                             (unsafe-cdr lst_110)))
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
                                                                                                         body_24))))))
                                                                                       (let-values (((result_54)
                                                                                                     (if (post-guard-var_7)
                                                                                                       (for-loop_56
                                                                                                        rest_65
                                                                                                        rest_66)
                                                                                                       null)))
                                                                                         (cons elem_6 result_54))))))
                                                                               null))))
                                                            for-loop_56)
                                                          lst_107
                                                          lst_108)))))
                                                  (if (if (pair? v_61)
                                                        (if (let-values (((a_40) (car v_61)))
                                                              (equal? 'define-values a_40))
                                                          (let-values (((d_36) (cdr v_61)))
                                                            (if (pair? d_36)
                                                              (if (let-values (((a_41) (car d_36)))
                                                                    (if (pair? a_41)
                                                                      (if (let-values (((a_113) (car a_41))) #t)
                                                                        (let-values (((d_108) (cdr a_41)))
                                                                          (if (pair? d_108)
                                                                            (if (let-values (((a_114) (car d_108))) #t)
                                                                              (let-values (((d_215) (cdr d_108)))
                                                                                (if (pair? d_215)
                                                                                  (if (let-values (((a_223)
                                                                                                    (car d_215)))
                                                                                        #t)
                                                                                    (let-values (((d_216) (cdr d_215)))
                                                                                      (list? d_216))
                                                                                    #f)
                                                                                  #f))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f))
                                                                (let-values (((d_38) (cdr d_36)))
                                                                  (if (pair? d_38)
                                                                    (if (let-values (((a_43) (car d_38)))
                                                                          (if (pair? a_43)
                                                                            (if (let-values (((a_224) (car a_43)))
                                                                                  (equal? 'let-values a_224))
                                                                              (let-values (((d_217) (cdr a_43)))
                                                                                (if (pair? d_217)
                                                                                  (if (let-values (((a_116)
                                                                                                    (car d_217)))
                                                                                        (if (pair? a_116)
                                                                                          (if (let-values (((a_225)
                                                                                                            (car
                                                                                                             a_116)))
                                                                                                (if (pair? a_225)
                                                                                                  (if (let-values (((a_117)
                                                                                                                    (car
                                                                                                                     a_225)))
                                                                                                        (if (pair?
                                                                                                             a_117)
                                                                                                          (if (let-values (((a_44)
                                                                                                                            (car
                                                                                                                             a_117)))
                                                                                                                #t)
                                                                                                            (let-values (((d_39)
                                                                                                                          (cdr
                                                                                                                           a_117)))
                                                                                                              (if (pair?
                                                                                                                   d_39)
                                                                                                                (if (let-values (((a_226)
                                                                                                                                  (car
                                                                                                                                   d_39)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_113)
                                                                                                                                (cdr
                                                                                                                                 d_39)))
                                                                                                                    (if (pair?
                                                                                                                         d_113)
                                                                                                                      (if (let-values (((a_119)
                                                                                                                                        (car
                                                                                                                                         d_113)))
                                                                                                                            #t)
                                                                                                                        (let-values (((d_218)
                                                                                                                                      (cdr
                                                                                                                                       d_113)))
                                                                                                                          (if (pair?
                                                                                                                               d_218)
                                                                                                                            (if (let-values (((a_45)
                                                                                                                                              (car
                                                                                                                                               d_218)))
                                                                                                                                  #t)
                                                                                                                              (let-values (((d_40)
                                                                                                                                            (cdr
                                                                                                                                             d_218)))
                                                                                                                                (if (pair?
                                                                                                                                     d_40)
                                                                                                                                  (if (let-values (((a_227)
                                                                                                                                                    (car
                                                                                                                                                     d_40)))
                                                                                                                                        #t)
                                                                                                                                    (let-values (((d_116)
                                                                                                                                                  (cdr
                                                                                                                                                   d_40)))
                                                                                                                                      (equal?
                                                                                                                                       '()
                                                                                                                                       d_116))
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
                                                                                                    (let-values (((d_219)
                                                                                                                  (cdr
                                                                                                                   a_225)))
                                                                                                      (if (pair? d_219)
                                                                                                        (if (let-values (((a_228)
                                                                                                                          (car
                                                                                                                           d_219)))
                                                                                                              #t)
                                                                                                          (let-values (((d_220)
                                                                                                                        (cdr
                                                                                                                         d_219)))
                                                                                                            (equal?
                                                                                                             '()
                                                                                                             d_220))
                                                                                                          #f)
                                                                                                        #f))
                                                                                                    #f)
                                                                                                  #f))
                                                                                            (let-values (((d_221)
                                                                                                          (cdr a_116)))
                                                                                              (equal? '() d_221))
                                                                                            #f)
                                                                                          #f))
                                                                                    (let-values (((d_117) (cdr d_217)))
                                                                                      (if (pair? d_117)
                                                                                        (if (let-values (((a_229)
                                                                                                          (car d_117)))
                                                                                              (if (pair? a_229)
                                                                                                (if (let-values (((a_230)
                                                                                                                  (car
                                                                                                                   a_229)))
                                                                                                      (equal?
                                                                                                       'values
                                                                                                       a_230))
                                                                                                  (let-values (((d_222)
                                                                                                                (cdr
                                                                                                                 a_229)))
                                                                                                    (if (pair? d_222)
                                                                                                      (if (let-values (((a_231)
                                                                                                                        (car
                                                                                                                         d_222)))
                                                                                                            #t)
                                                                                                        (let-values (((d_223)
                                                                                                                      (cdr
                                                                                                                       d_222)))
                                                                                                          (if (pair?
                                                                                                               d_223)
                                                                                                            (if (let-values (((a_232)
                                                                                                                              (car
                                                                                                                               d_223)))
                                                                                                                  #t)
                                                                                                              (let-values (((d_224)
                                                                                                                            (cdr
                                                                                                                             d_223)))
                                                                                                                (if (pair?
                                                                                                                     d_224)
                                                                                                                  (if (let-values (((a_233)
                                                                                                                                    (car
                                                                                                                                     d_224)))
                                                                                                                        #t)
                                                                                                                    (let-values (((d_225)
                                                                                                                                  (cdr
                                                                                                                                   d_224)))
                                                                                                                      (list?
                                                                                                                       d_225))
                                                                                                                    #f)
                                                                                                                  #f))
                                                                                                              #f)
                                                                                                            #f))
                                                                                                        #f)
                                                                                                      #f))
                                                                                                  #f)
                                                                                                #f))
                                                                                          (let-values (((d_118)
                                                                                                        (cdr d_117)))
                                                                                            (equal? '() d_118))
                                                                                          #f)
                                                                                        #f))
                                                                                    #f)
                                                                                  #f))
                                                                              #f)
                                                                            #f))
                                                                      (let-values (((d_226) (cdr d_38)))
                                                                        (equal? '() d_226))
                                                                      #f)
                                                                    #f))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f)
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
                                                                  (let-values (((d_227) (cdr v_61)))
                                                                    (let-values (((struct:s_7 make-s_9 s?_15 acc/muts_6)
                                                                                  (let-values (((a_234) (car d_227)))
                                                                                    (let-values (((struct:s_8)
                                                                                                  (let-values (((a_189)
                                                                                                                (car
                                                                                                                 a_234)))
                                                                                                    a_189))
                                                                                                 ((make-s_10
                                                                                                   s?_16
                                                                                                   acc/muts_7)
                                                                                                  (let-values (((d_132)
                                                                                                                (cdr
                                                                                                                 a_234)))
                                                                                                    (let-values (((make-s_11)
                                                                                                                  (let-values (((a_136)
                                                                                                                                (car
                                                                                                                                 d_132)))
                                                                                                                    a_136))
                                                                                                                 ((s?_17
                                                                                                                   acc/muts_8)
                                                                                                                  (let-values (((d_228)
                                                                                                                                (cdr
                                                                                                                                 d_132)))
                                                                                                                    (let-values (((s?_18)
                                                                                                                                  (let-values (((a_138)
                                                                                                                                                (car
                                                                                                                                                 d_228)))
                                                                                                                                    a_138))
                                                                                                                                 ((acc/muts_9)
                                                                                                                                  (let-values (((d_229)
                                                                                                                                                (cdr
                                                                                                                                                 d_228)))
                                                                                                                                    d_229)))
                                                                                                                      (values
                                                                                                                       s?_18
                                                                                                                       acc/muts_9)))))
                                                                                                      (values
                                                                                                       make-s_11
                                                                                                       s?_17
                                                                                                       acc/muts_8)))))
                                                                                      (values
                                                                                       struct:s_8
                                                                                       make-s_10
                                                                                       s?_16
                                                                                       acc/muts_7))))
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
                                                                                  (let-values (((d_133) (cdr d_227)))
                                                                                    (let-values (((a_140) (car d_133)))
                                                                                      (let-values (((d_134)
                                                                                                    (cdr a_140)))
                                                                                        (let-values (((struct:_17
                                                                                                       make_8
                                                                                                       ?1_2
                                                                                                       -ref_20
                                                                                                       -set!_20
                                                                                                       mk_2)
                                                                                                      (let-values (((a_147)
                                                                                                                    (car
                                                                                                                     d_134)))
                                                                                                        (let-values (((a_235)
                                                                                                                      (car
                                                                                                                       a_147)))
                                                                                                          (let-values (((struct:_18
                                                                                                                         make_9
                                                                                                                         ?1_3
                                                                                                                         -ref_21
                                                                                                                         -set!_21)
                                                                                                                        (let-values (((a_236)
                                                                                                                                      (car
                                                                                                                                       a_235)))
                                                                                                                          (let-values (((struct:_19)
                                                                                                                                        (let-values (((a_150)
                                                                                                                                                      (car
                                                                                                                                                       a_236)))
                                                                                                                                          a_150))
                                                                                                                                       ((make_10
                                                                                                                                         ?1_4
                                                                                                                                         -ref_22
                                                                                                                                         -set!_22)
                                                                                                                                        (let-values (((d_230)
                                                                                                                                                      (cdr
                                                                                                                                                       a_236)))
                                                                                                                                          (let-values (((make_11)
                                                                                                                                                        (let-values (((a_153)
                                                                                                                                                                      (car
                                                                                                                                                                       d_230)))
                                                                                                                                                          a_153))
                                                                                                                                                       ((?1_5
                                                                                                                                                         -ref_23
                                                                                                                                                         -set!_23)
                                                                                                                                                        (let-values (((d_144)
                                                                                                                                                                      (cdr
                                                                                                                                                                       d_230)))
                                                                                                                                                          (let-values (((?1_6)
                                                                                                                                                                        (let-values (((a_237)
                                                                                                                                                                                      (car
                                                                                                                                                                                       d_144)))
                                                                                                                                                                          a_237))
                                                                                                                                                                       ((-ref_24
                                                                                                                                                                         -set!_24)
                                                                                                                                                                        (let-values (((d_231)
                                                                                                                                                                                      (cdr
                                                                                                                                                                                       d_144)))
                                                                                                                                                                          (let-values (((-ref_25)
                                                                                                                                                                                        (let-values (((a_238)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       d_231)))
                                                                                                                                                                                          a_238))
                                                                                                                                                                                       ((-set!_25)
                                                                                                                                                                                        (let-values (((d_187)
                                                                                                                                                                                                      (cdr
                                                                                                                                                                                                       d_231)))
                                                                                                                                                                                          (let-values (((a_239)
                                                                                                                                                                                                        (car
                                                                                                                                                                                                         d_187)))
                                                                                                                                                                                            a_239))))
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
                                                                                                                        (let-values (((d_149)
                                                                                                                                      (cdr
                                                                                                                                       a_235)))
                                                                                                                          (let-values (((a_158)
                                                                                                                                        (car
                                                                                                                                         d_149)))
                                                                                                                            a_158))))
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
                                                                                                      (let-values (((d_188)
                                                                                                                    (cdr
                                                                                                                     d_134)))
                                                                                                        (let-values (((a_196)
                                                                                                                      (car
                                                                                                                       d_188)))
                                                                                                          (let-values (((d_189)
                                                                                                                        (cdr
                                                                                                                         a_196)))
                                                                                                            (let-values (((struct:2_7)
                                                                                                                          (let-values (((a_240)
                                                                                                                                        (car
                                                                                                                                         d_189)))
                                                                                                                            a_240))
                                                                                                                         ((make2_8
                                                                                                                           ?2_9
                                                                                                                           make-acc/muts_9)
                                                                                                                          (let-values (((d_154)
                                                                                                                                        (cdr
                                                                                                                                         d_189)))
                                                                                                                            (let-values (((make2_9)
                                                                                                                                          (let-values (((a_199)
                                                                                                                                                        (car
                                                                                                                                                         d_154)))
                                                                                                                                            a_199))
                                                                                                                                         ((?2_10
                                                                                                                                           make-acc/muts_10)
                                                                                                                                          (let-values (((d_193)
                                                                                                                                                        (cdr
                                                                                                                                                         d_154)))
                                                                                                                                            (let-values (((?2_11)
                                                                                                                                                          (let-values (((a_241)
                                                                                                                                                                        (car
                                                                                                                                                                         d_193)))
                                                                                                                                                            a_241))
                                                                                                                                                         ((make-acc/muts_11)
                                                                                                                                                          (let-values (((d_232)
                                                                                                                                                                        (cdr
                                                                                                                                                                         d_193)))
                                                                                                                                                            d_232)))
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
                                                                       make-acc/muts_7)))))
                                                      (let-values (((sti_0)
                                                                    (if (eq? struct:_15 struct:2_4)
                                                                      (if (eq? make_6 make2_5)
                                                                        (if (eq? ?1_0 ?2_6)
                                                                          (make-struct-type-info
                                                                           mk_0
                                                                           prim-knowns_8
                                                                           knowns_29
                                                                           imports_17
                                                                           mutated_9)
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
                                                                              (let-values (((start_2) 0)
                                                                                           ((end_0)
                                                                                            (struct-type-info-immediate-field-count
                                                                                             sti_0))
                                                                                           ((inc_0) 1))
                                                                                (begin
                                                                                  (check-range start_2 end_0 inc_0)
                                                                                  ((letrec-values (((for-loop_57)
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
                                                                                                            (if (not #f)
                                                                                                              (for-loop_57
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
                                                                                     for-loop_57)
                                                                                   (make-vector 16)
                                                                                   0
                                                                                   start_2)))))
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
                                                             (list 'define s?_14 (list 'record-predicate struct:s_6))
                                                             (qq-append
                                                              (let-values (((lst_111) acc/muts_5)
                                                                           ((lst_112) make-acc/muts_6))
                                                                (begin
                                                                  (check-list lst_111)
                                                                  (check-list lst_112)
                                                                  ((letrec-values (((for-loop_58)
                                                                                    (lambda (lst_113 lst_114)
                                                                                      (if (if (pair? lst_113)
                                                                                            (pair? lst_114)
                                                                                            #f)
                                                                                        (let-values (((acc/mut_0)
                                                                                                      (unsafe-car
                                                                                                       lst_113))
                                                                                                     ((rest_67)
                                                                                                      (unsafe-cdr
                                                                                                       lst_113))
                                                                                                     ((make-acc/mut_0)
                                                                                                      (unsafe-car
                                                                                                       lst_114))
                                                                                                     ((rest_68)
                                                                                                      (unsafe-cdr
                                                                                                       lst_114)))
                                                                                          (let-values (((post-guard-var_8)
                                                                                                        (lambda () #t)))
                                                                                            (let-values ()
                                                                                              (let-values (((elem_7)
                                                                                                            (let-values ()
                                                                                                              (let-values ()
                                                                                                                (list
                                                                                                                 'define
                                                                                                                 acc/mut_0
                                                                                                                 (let-values (((v_64)
                                                                                                                               make-acc/mut_0))
                                                                                                                   (if (if (pair?
                                                                                                                            v_64)
                                                                                                                         (if (let-values (((a_242)
                                                                                                                                           (car
                                                                                                                                            v_64)))
                                                                                                                               (equal?
                                                                                                                                'make-struct-field-accessor
                                                                                                                                a_242))
                                                                                                                           (let-values (((d_233)
                                                                                                                                         (cdr
                                                                                                                                          v_64)))
                                                                                                                             (if (pair?
                                                                                                                                  d_233)
                                                                                                                               (if (let-values (((a_243)
                                                                                                                                                 (car
                                                                                                                                                  d_233)))
                                                                                                                                     ((lambda (v_65)
                                                                                                                                        (eq?
                                                                                                                                         v_65
                                                                                                                                         -ref_18))
                                                                                                                                      a_243))
                                                                                                                                 (let-values (((d_234)
                                                                                                                                               (cdr
                                                                                                                                                d_233)))
                                                                                                                                   (if (pair?
                                                                                                                                        d_234)
                                                                                                                                     (if (let-values (((a_244)
                                                                                                                                                       (car
                                                                                                                                                        d_234)))
                                                                                                                                           #t)
                                                                                                                                       (let-values (((d_235)
                                                                                                                                                     (cdr
                                                                                                                                                      d_234)))
                                                                                                                                         (if (pair?
                                                                                                                                              d_235)
                                                                                                                                           (if (let-values (((a_245)
                                                                                                                                                             (car
                                                                                                                                                              d_235)))
                                                                                                                                                 #t)
                                                                                                                                             (let-values (((d_236)
                                                                                                                                                           (cdr
                                                                                                                                                            d_235)))
                                                                                                                                               (equal?
                                                                                                                                                '()
                                                                                                                                                d_236))
                                                                                                                                             #f)
                                                                                                                                           #f))
                                                                                                                                       #f)
                                                                                                                                     #f))
                                                                                                                                 #f)
                                                                                                                               #f))
                                                                                                                           #f)
                                                                                                                         #f)
                                                                                                                     (let-values (((pos_4)
                                                                                                                                   (let-values (((d_237)
                                                                                                                                                 (cdr
                                                                                                                                                  v_64)))
                                                                                                                                     (let-values (((d_238)
                                                                                                                                                   (cdr
                                                                                                                                                    d_237)))
                                                                                                                                       (let-values (((a_246)
                                                                                                                                                     (car
                                                                                                                                                      d_238)))
                                                                                                                                         a_246)))))
                                                                                                                       (list
                                                                                                                        'record-accessor
                                                                                                                        struct:s_6
                                                                                                                        pos_4))
                                                                                                                     (if (if (pair?
                                                                                                                              v_64)
                                                                                                                           (if (let-values (((a_247)
                                                                                                                                             (car
                                                                                                                                              v_64)))
                                                                                                                                 (equal?
                                                                                                                                  'make-struct-field-mutator
                                                                                                                                  a_247))
                                                                                                                             (let-values (((d_239)
                                                                                                                                           (cdr
                                                                                                                                            v_64)))
                                                                                                                               (if (pair?
                                                                                                                                    d_239)
                                                                                                                                 (if (let-values (((a_248)
                                                                                                                                                   (car
                                                                                                                                                    d_239)))
                                                                                                                                       ((lambda (v_66)
                                                                                                                                          (eq?
                                                                                                                                           v_66
                                                                                                                                           -set!_18))
                                                                                                                                        a_248))
                                                                                                                                   (let-values (((d_240)
                                                                                                                                                 (cdr
                                                                                                                                                  d_239)))
                                                                                                                                     (if (pair?
                                                                                                                                          d_240)
                                                                                                                                       (if (let-values (((a_249)
                                                                                                                                                         (car
                                                                                                                                                          d_240)))
                                                                                                                                             #t)
                                                                                                                                         (let-values (((d_241)
                                                                                                                                                       (cdr
                                                                                                                                                        d_240)))
                                                                                                                                           (if (pair?
                                                                                                                                                d_241)
                                                                                                                                             (if (let-values (((a_250)
                                                                                                                                                               (car
                                                                                                                                                                d_241)))
                                                                                                                                                   #t)
                                                                                                                                               (let-values (((d_242)
                                                                                                                                                             (cdr
                                                                                                                                                              d_241)))
                                                                                                                                                 (equal?
                                                                                                                                                  '()
                                                                                                                                                  d_242))
                                                                                                                                               #f)
                                                                                                                                             #f))
                                                                                                                                         #f)
                                                                                                                                       #f))
                                                                                                                                   #f)
                                                                                                                                 #f))
                                                                                                                             #f)
                                                                                                                           #f)
                                                                                                                       (let-values (((pos_5)
                                                                                                                                     (let-values (((d_243)
                                                                                                                                                   (cdr
                                                                                                                                                    v_64)))
                                                                                                                                       (let-values (((d_244)
                                                                                                                                                     (cdr
                                                                                                                                                      d_243)))
                                                                                                                                         (let-values (((a_251)
                                                                                                                                                       (car
                                                                                                                                                        d_244)))
                                                                                                                                           a_251)))))
                                                                                                                         (list
                                                                                                                          'record-mutator
                                                                                                                          struct:s_6
                                                                                                                          pos_5))
                                                                                                                       (let-values ()
                                                                                                                         (error
                                                                                                                          "oops"))))))))))
                                                                                                (let-values (((result_55)
                                                                                                              (if (post-guard-var_8)
                                                                                                                (for-loop_58
                                                                                                                 rest_67
                                                                                                                 rest_68)
                                                                                                                null)))
                                                                                                  (cons
                                                                                                   elem_7
                                                                                                   result_55))))))
                                                                                        null))))
                                                                     for-loop_58)
                                                                   lst_111
                                                                   lst_112)))
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
                                                             (cadr v_60)
                                                             (schemify_0 (caddr v_60)))))))
                                                    (if (if (pair? v_61)
                                                          (if (let-values (((a_252) (car v_61)))
                                                                (equal? 'define-values a_252))
                                                            (let-values (((d_245) (cdr v_61)))
                                                              (if (pair? d_245)
                                                                (if (let-values (((a_253) (car d_245)))
                                                                      (if (pair? a_253)
                                                                        (if (let-values (((a_254) (car a_253))) #t)
                                                                          (let-values (((d_246) (cdr a_253)))
                                                                            (equal? '() d_246))
                                                                          #f)
                                                                        #f))
                                                                  (let-values (((d_247) (cdr d_245)))
                                                                    (if (pair? d_247)
                                                                      (if (let-values (((a_255) (car d_247))) #t)
                                                                        (let-values (((d_248) (cdr d_247)))
                                                                          (equal? '() d_248))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f)
                                                      (let-values (((id_28 rhs_35)
                                                                    (let-values (((d_249) (cdr v_61)))
                                                                      (let-values (((id_29)
                                                                                    (let-values (((a_256) (car d_249)))
                                                                                      (let-values (((a_257)
                                                                                                    (car a_256)))
                                                                                        a_257)))
                                                                                   ((rhs_36)
                                                                                    (let-values (((d_250) (cdr d_249)))
                                                                                      (let-values (((a_258)
                                                                                                    (car d_250)))
                                                                                        a_258))))
                                                                        (values id_29 rhs_36)))))
                                                        (list 'define id_28 (schemify_0 rhs_35)))
                                                      (if (if (pair? v_61)
                                                            (if (let-values (((a_259) (car v_61)))
                                                                  (equal? 'define-values a_259))
                                                              (let-values (((d_251) (cdr v_61)))
                                                                (if (pair? d_251)
                                                                  (if (let-values (((a_260) (car d_251))) #t)
                                                                    (let-values (((d_252) (cdr d_251)))
                                                                      (if (pair? d_252)
                                                                        (if (let-values (((a_261) (car d_252))) #t)
                                                                          (let-values (((d_253) (cdr d_252)))
                                                                            (equal? '() d_253))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f)
                                                        (let-values (((ids_39 rhs_37)
                                                                      (let-values (((d_254) (cdr v_61)))
                                                                        (let-values (((ids_40)
                                                                                      (let-values (((a_262)
                                                                                                    (car d_254)))
                                                                                        a_262))
                                                                                     ((rhs_38)
                                                                                      (let-values (((d_255)
                                                                                                    (cdr d_254)))
                                                                                        (let-values (((a_263)
                                                                                                      (car d_255)))
                                                                                          a_263))))
                                                                          (values ids_40 rhs_38)))))
                                                          (list 'define-values ids_39 (schemify_0 rhs_37)))
                                                        (if (if (pair? v_61)
                                                              (if (let-values (((a_264) (car v_61)))
                                                                    (equal? 'quote a_264))
                                                                (let-values (((d_256) (cdr v_61)))
                                                                  (if (pair? d_256)
                                                                    (if (let-values (((a_265) (car d_256))) #t)
                                                                      (let-values (((d_257) (cdr d_256)))
                                                                        (equal? '() d_257))
                                                                      #f)
                                                                    #f))
                                                                #f)
                                                              #f)
                                                          (let-values () v_60)
                                                          (if (if (pair? v_61)
                                                                (if (let-values (((a_266) (car v_61)))
                                                                      (equal? 'let-values a_266))
                                                                  (let-values (((d_258) (cdr v_61)))
                                                                    (if (pair? d_258)
                                                                      (if (let-values (((a_267) (car d_258)))
                                                                            (equal? '() a_267))
                                                                        (let-values (((d_259) (cdr d_258)))
                                                                          (if (pair? d_259)
                                                                            (if (let-values (((a_268) (car d_259))) #t)
                                                                              (let-values (((d_260) (cdr d_259)))
                                                                                (equal? '() d_260))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f)
                                                            (let-values (((body_25)
                                                                          (let-values (((d_261) (cdr v_61)))
                                                                            (let-values (((d_262) (cdr d_261)))
                                                                              (let-values (((a_269) (car d_262)))
                                                                                a_269)))))
                                                              (schemify_0 body_25))
                                                            (if (if (pair? v_61)
                                                                  (if (let-values (((a_270) (car v_61)))
                                                                        (equal? 'let-values a_270))
                                                                    (let-values (((d_263) (cdr v_61)))
                                                                      (if (pair? d_263)
                                                                        (if (let-values (((a_271) (car d_263)))
                                                                              (equal? '() a_271))
                                                                          (let-values (((d_264) (cdr d_263)))
                                                                            (list? d_264))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f)
                                                              (let-values (((bodys_23)
                                                                            (let-values (((d_265) (cdr v_61)))
                                                                              (let-values (((d_266) (cdr d_265)))
                                                                                d_266))))
                                                                (list* 'begin (map2 schemify_0 bodys_23)))
                                                              (if (if (pair? v_61)
                                                                    (if (let-values (((a_272) (car v_61)))
                                                                          (equal? 'let-values a_272))
                                                                      (let-values (((d_267) (cdr v_61)))
                                                                        (if (pair? d_267)
                                                                          (if (let-values (((a_273) (car d_267)))
                                                                                (if (list? a_273)
                                                                                  (let-values (((lst_115) a_273))
                                                                                    (begin
                                                                                      (check-list lst_115)
                                                                                      ((letrec-values (((for-loop_59)
                                                                                                        (lambda (result_56
                                                                                                                 lst_116)
                                                                                                          (if (pair?
                                                                                                               lst_116)
                                                                                                            (let-values (((v_67)
                                                                                                                          (unsafe-car
                                                                                                                           lst_116))
                                                                                                                         ((rest_69)
                                                                                                                          (unsafe-cdr
                                                                                                                           lst_116)))
                                                                                                              (let-values (((result_57)
                                                                                                                            (let-values ()
                                                                                                                              (let-values (((result_58)
                                                                                                                                            (let-values ()
                                                                                                                                              (let-values ()
                                                                                                                                                (if (pair?
                                                                                                                                                     v_67)
                                                                                                                                                  (if (let-values (((a_274)
                                                                                                                                                                    (car
                                                                                                                                                                     v_67)))
                                                                                                                                                        (if (pair?
                                                                                                                                                             a_274)
                                                                                                                                                          (if (let-values (((a_275)
                                                                                                                                                                            (car
                                                                                                                                                                             a_274)))
                                                                                                                                                                #t)
                                                                                                                                                            (let-values (((d_268)
                                                                                                                                                                          (cdr
                                                                                                                                                                           a_274)))
                                                                                                                                                              (equal?
                                                                                                                                                               '()
                                                                                                                                                               d_268))
                                                                                                                                                            #f)
                                                                                                                                                          #f))
                                                                                                                                                    (let-values (((d_269)
                                                                                                                                                                  (cdr
                                                                                                                                                                   v_67)))
                                                                                                                                                      (if (pair?
                                                                                                                                                           d_269)
                                                                                                                                                        (if (let-values (((a_276)
                                                                                                                                                                          (car
                                                                                                                                                                           d_269)))
                                                                                                                                                              #t)
                                                                                                                                                          (let-values (((d_270)
                                                                                                                                                                        (cdr
                                                                                                                                                                         d_269)))
                                                                                                                                                            (equal?
                                                                                                                                                             '()
                                                                                                                                                             d_270))
                                                                                                                                                          #f)
                                                                                                                                                        #f))
                                                                                                                                                    #f)
                                                                                                                                                  #f)))))
                                                                                                                                (values
                                                                                                                                 result_58)))))
                                                                                                                (if (if (not
                                                                                                                         ((lambda x_19
                                                                                                                            (not
                                                                                                                             result_57))
                                                                                                                          v_67))
                                                                                                                      (not
                                                                                                                       #f)
                                                                                                                      #f)
                                                                                                                  (for-loop_59
                                                                                                                   result_57
                                                                                                                   rest_69)
                                                                                                                  result_57)))
                                                                                                            result_56))))
                                                                                         for-loop_59)
                                                                                       #t
                                                                                       lst_115)))
                                                                                  #f))
                                                                            (let-values (((d_271) (cdr d_267)))
                                                                              (list? d_271))
                                                                            #f)
                                                                          #f))
                                                                      #f)
                                                                    #f)
                                                                (let-values (((ids_41 rhss_59 bodys_24)
                                                                              (let-values (((d_272) (cdr v_61)))
                                                                                (let-values (((ids_42 rhss_60)
                                                                                              (let-values (((a_277)
                                                                                                            (car
                                                                                                             d_272)))
                                                                                                (let-values (((ids_43
                                                                                                               rhss_61)
                                                                                                              (let-values (((lst_117)
                                                                                                                            a_277))
                                                                                                                (begin
                                                                                                                  (check-list
                                                                                                                   lst_117)
                                                                                                                  ((letrec-values (((for-loop_60)
                                                                                                                                    (lambda (ids_44
                                                                                                                                             rhss_62
                                                                                                                                             lst_118)
                                                                                                                                      (if (pair?
                                                                                                                                           lst_118)
                                                                                                                                        (let-values (((v_68)
                                                                                                                                                      (unsafe-car
                                                                                                                                                       lst_118))
                                                                                                                                                     ((rest_70)
                                                                                                                                                      (unsafe-cdr
                                                                                                                                                       lst_118)))
                                                                                                                                          (let-values (((ids_45
                                                                                                                                                         rhss_63)
                                                                                                                                                        (let-values (((ids_46)
                                                                                                                                                                      ids_44)
                                                                                                                                                                     ((rhss_64)
                                                                                                                                                                      rhss_62))
                                                                                                                                                          (let-values (((ids_47
                                                                                                                                                                         rhss_65)
                                                                                                                                                                        (let-values ()
                                                                                                                                                                          (let-values (((ids3_0
                                                                                                                                                                                         rhss4_3)
                                                                                                                                                                                        (let-values ()
                                                                                                                                                                                          (let-values (((ids_48)
                                                                                                                                                                                                        (let-values (((a_278)
                                                                                                                                                                                                                      (car
                                                                                                                                                                                                                       v_68)))
                                                                                                                                                                                                          (let-values (((a_279)
                                                                                                                                                                                                                        (car
                                                                                                                                                                                                                         a_278)))
                                                                                                                                                                                                            a_279)))
                                                                                                                                                                                                       ((rhss_66)
                                                                                                                                                                                                        (let-values (((d_273)
                                                                                                                                                                                                                      (cdr
                                                                                                                                                                                                                       v_68)))
                                                                                                                                                                                                          (let-values (((a_280)
                                                                                                                                                                                                                        (car
                                                                                                                                                                                                                         d_273)))
                                                                                                                                                                                                            a_280))))
                                                                                                                                                                                            (values
                                                                                                                                                                                             ids_48
                                                                                                                                                                                             rhss_66)))))
                                                                                                                                                                            (values
                                                                                                                                                                             (cons
                                                                                                                                                                              ids3_0
                                                                                                                                                                              ids_46)
                                                                                                                                                                             (cons
                                                                                                                                                                              rhss4_3
                                                                                                                                                                              rhss_64))))))
                                                                                                                                                            (values
                                                                                                                                                             ids_47
                                                                                                                                                             rhss_65)))))
                                                                                                                                            (if (not
                                                                                                                                                 #f)
                                                                                                                                              (for-loop_60
                                                                                                                                               ids_45
                                                                                                                                               rhss_63
                                                                                                                                               rest_70)
                                                                                                                                              (values
                                                                                                                                               ids_45
                                                                                                                                               rhss_63))))
                                                                                                                                        (values
                                                                                                                                         ids_44
                                                                                                                                         rhss_62)))))
                                                                                                                     for-loop_60)
                                                                                                                   null
                                                                                                                   null
                                                                                                                   lst_117)))))
                                                                                                  (values
                                                                                                   (reverse$1 ids_43)
                                                                                                   (reverse$1
                                                                                                    rhss_61)))))
                                                                                             ((bodys_25)
                                                                                              (let-values (((d_274)
                                                                                                            (cdr
                                                                                                             d_272)))
                                                                                                d_274)))
                                                                                  (values ids_42 rhss_60 bodys_25)))))
                                                                  (let-values (((new-knowns_1)
                                                                                (let-values (((lst_119) ids_41)
                                                                                             ((lst_120) rhss_59))
                                                                                  (begin
                                                                                    (check-list lst_119)
                                                                                    (check-list lst_120)
                                                                                    ((letrec-values (((for-loop_61)
                                                                                                      (lambda (knowns_30
                                                                                                               lst_121
                                                                                                               lst_122)
                                                                                                        (if (if (pair?
                                                                                                                 lst_121)
                                                                                                              (pair?
                                                                                                               lst_122)
                                                                                                              #f)
                                                                                                          (let-values (((id_30)
                                                                                                                        (unsafe-car
                                                                                                                         lst_121))
                                                                                                                       ((rest_71)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_121))
                                                                                                                       ((rhs_39)
                                                                                                                        (unsafe-car
                                                                                                                         lst_122))
                                                                                                                       ((rest_72)
                                                                                                                        (unsafe-cdr
                                                                                                                         lst_122)))
                                                                                                            (let-values (((knowns_31)
                                                                                                                          (let-values (((knowns_32)
                                                                                                                                        knowns_30))
                                                                                                                            (let-values (((knowns_33)
                                                                                                                                          (let-values ()
                                                                                                                                            (if (lambda?
                                                                                                                                                 rhs_39)
                                                                                                                                              (hash-set
                                                                                                                                               knowns_32
                                                                                                                                               id_30
                                                                                                                                               a-known-procedure)
                                                                                                                                              knowns_32))))
                                                                                                                              (values
                                                                                                                               knowns_33)))))
                                                                                                              (if (not
                                                                                                                   #f)
                                                                                                                (for-loop_61
                                                                                                                 knowns_31
                                                                                                                 rest_71
                                                                                                                 rest_72)
                                                                                                                knowns_31)))
                                                                                                          knowns_30))))
                                                                                       for-loop_61)
                                                                                     knowns_29
                                                                                     lst_119
                                                                                     lst_120)))))
                                                                    (left-to-right/let
                                                                     (list*
                                                                      'let
                                                                      (let-values (((lst_123) ids_41)
                                                                                   ((lst_124) rhss_59))
                                                                        (begin
                                                                          (check-list lst_123)
                                                                          (check-list lst_124)
                                                                          ((letrec-values (((for-loop_62)
                                                                                            (lambda (lst_125 lst_126)
                                                                                              (if (if (pair? lst_125)
                                                                                                    (pair? lst_126)
                                                                                                    #f)
                                                                                                (let-values (((id_31)
                                                                                                              (unsafe-car
                                                                                                               lst_125))
                                                                                                             ((rest_73)
                                                                                                              (unsafe-cdr
                                                                                                               lst_125))
                                                                                                             ((rhs_40)
                                                                                                              (unsafe-car
                                                                                                               lst_126))
                                                                                                             ((rest_74)
                                                                                                              (unsafe-cdr
                                                                                                               lst_126)))
                                                                                                  (let-values (((post-guard-var_9)
                                                                                                                (lambda ()
                                                                                                                  #t)))
                                                                                                    (let-values ()
                                                                                                      (let-values (((elem_8)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (list
                                                                                                                         id_31
                                                                                                                         (schemify_0
                                                                                                                          rhs_40))))))
                                                                                                        (let-values (((result_59)
                                                                                                                      (if (post-guard-var_9)
                                                                                                                        (for-loop_62
                                                                                                                         rest_73
                                                                                                                         rest_74)
                                                                                                                        null)))
                                                                                                          (cons
                                                                                                           elem_8
                                                                                                           result_59))))))
                                                                                                null))))
                                                                             for-loop_62)
                                                                           lst_123
                                                                           lst_124)))
                                                                      (let-values (((lst_127) bodys_24))
                                                                        (begin
                                                                          (check-list lst_127)
                                                                          ((letrec-values (((for-loop_63)
                                                                                            (lambda (lst_128)
                                                                                              (if (pair? lst_128)
                                                                                                (let-values (((body_26)
                                                                                                              (unsafe-car
                                                                                                               lst_128))
                                                                                                             ((rest_75)
                                                                                                              (unsafe-cdr
                                                                                                               lst_128)))
                                                                                                  (let-values (((post-guard-var_10)
                                                                                                                (lambda ()
                                                                                                                  #t)))
                                                                                                    (let-values ()
                                                                                                      (let-values (((elem_9)
                                                                                                                    (let-values ()
                                                                                                                      (let-values ()
                                                                                                                        (schemify/knowns_0
                                                                                                                         new-knowns_1
                                                                                                                         body_26)))))
                                                                                                        (let-values (((result_60)
                                                                                                                      (if (post-guard-var_10)
                                                                                                                        (for-loop_63
                                                                                                                         rest_75)
                                                                                                                        null)))
                                                                                                          (cons
                                                                                                           elem_9
                                                                                                           result_60))))))
                                                                                                null))))
                                                                             for-loop_63)
                                                                           lst_127))))
                                                                     prim-knowns_8
                                                                     knowns_29
                                                                     imports_17
                                                                     mutated_9)))
                                                                (if (if (pair? v_61)
                                                                      (if (let-values (((a_281) (car v_61)))
                                                                            (equal? 'let-values a_281))
                                                                        (let-values (((d_275) (cdr v_61)))
                                                                          (if (pair? d_275)
                                                                            (if (let-values (((a_282) (car d_275)))
                                                                                  (if (pair? a_282)
                                                                                    (if (let-values (((a_283)
                                                                                                      (car a_282)))
                                                                                          (if (pair? a_283)
                                                                                            (if (let-values (((a_284)
                                                                                                              (car
                                                                                                               a_283)))
                                                                                                  (equal? '() a_284))
                                                                                              (let-values (((d_276)
                                                                                                            (cdr
                                                                                                             a_283)))
                                                                                                (if (pair? d_276)
                                                                                                  (if (let-values (((a_285)
                                                                                                                    (car
                                                                                                                     d_276)))
                                                                                                        (if (pair?
                                                                                                             a_285)
                                                                                                          (if (let-values (((a_286)
                                                                                                                            (car
                                                                                                                             a_285)))
                                                                                                                (equal?
                                                                                                                 'begin
                                                                                                                 a_286))
                                                                                                            (let-values (((d_277)
                                                                                                                          (cdr
                                                                                                                           a_285)))
                                                                                                              (if (pair?
                                                                                                                   d_277)
                                                                                                                (if (let-values (((a_287)
                                                                                                                                  (car
                                                                                                                                   d_277)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_278)
                                                                                                                                (cdr
                                                                                                                                 d_277)))
                                                                                                                    (if (pair?
                                                                                                                         d_278)
                                                                                                                      (if (let-values (((a_288)
                                                                                                                                        (car
                                                                                                                                         d_278)))
                                                                                                                            (equal?
                                                                                                                             '...
                                                                                                                             a_288))
                                                                                                                        (let-values (((d_279)
                                                                                                                                      (cdr
                                                                                                                                       d_278)))
                                                                                                                          (if (pair?
                                                                                                                               d_279)
                                                                                                                            (if (let-values (((a_289)
                                                                                                                                              (car
                                                                                                                                               d_279)))
                                                                                                                                  (if (pair?
                                                                                                                                       a_289)
                                                                                                                                    (if (let-values (((a_290)
                                                                                                                                                      (car
                                                                                                                                                       a_289)))
                                                                                                                                          (equal?
                                                                                                                                           'values
                                                                                                                                           a_290))
                                                                                                                                      (let-values (((d_280)
                                                                                                                                                    (cdr
                                                                                                                                                     a_289)))
                                                                                                                                        (equal?
                                                                                                                                         '()
                                                                                                                                         d_280))
                                                                                                                                      #f)
                                                                                                                                    #f))
                                                                                                                              (let-values (((d_281)
                                                                                                                                            (cdr
                                                                                                                                             d_279)))
                                                                                                                                (equal?
                                                                                                                                 '()
                                                                                                                                 d_281))
                                                                                                                              #f)
                                                                                                                            #f))
                                                                                                                        #f)
                                                                                                                      #f))
                                                                                                                  #f)
                                                                                                                #f))
                                                                                                            #f)
                                                                                                          #f))
                                                                                                    (let-values (((d_282)
                                                                                                                  (cdr
                                                                                                                   d_276)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_282))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f))
                                                                                      (let-values (((d_283)
                                                                                                    (cdr a_282)))
                                                                                        (equal? '() d_283))
                                                                                      #f)
                                                                                    #f))
                                                                              (let-values (((d_284) (cdr d_275)))
                                                                                (list? d_284))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f)
                                                                  (let-values (((rhss_67 bodys_26)
                                                                                (let-values (((d_285) (cdr v_61)))
                                                                                  (let-values (((rhss_68)
                                                                                                (let-values (((a_291)
                                                                                                              (car
                                                                                                               d_285)))
                                                                                                  (let-values (((a_292)
                                                                                                                (car
                                                                                                                 a_291)))
                                                                                                    (let-values (((d_286)
                                                                                                                  (cdr
                                                                                                                   a_292)))
                                                                                                      (let-values (((a_293)
                                                                                                                    (car
                                                                                                                     d_286)))
                                                                                                        (let-values (((d_287)
                                                                                                                      (cdr
                                                                                                                       a_293)))
                                                                                                          (let-values (((a_294)
                                                                                                                        (car
                                                                                                                         d_287)))
                                                                                                            a_294)))))))
                                                                                               ((bodys_27)
                                                                                                (let-values (((d_288)
                                                                                                              (cdr
                                                                                                               d_285)))
                                                                                                  d_288)))
                                                                                    (values rhss_68 bodys_27)))))
                                                                    (list*
                                                                     'begin
                                                                     (qq-append
                                                                      (map2 schemify_0 rhss_67)
                                                                      (map2 schemify_0 bodys_26))))
                                                                  (if (if (pair? v_61)
                                                                        (if (let-values (((a_295) (car v_61)))
                                                                              (equal? 'let-values a_295))
                                                                          (let-values (((d_289) (cdr v_61)))
                                                                            (if (pair? d_289)
                                                                              (if (let-values (((a_296) (car d_289)))
                                                                                    (if (list? a_296)
                                                                                      (let-values (((lst_129) a_296))
                                                                                        (begin
                                                                                          (check-list lst_129)
                                                                                          ((letrec-values (((for-loop_64)
                                                                                                            (lambda (result_61
                                                                                                                     lst_130)
                                                                                                              (if (pair?
                                                                                                                   lst_130)
                                                                                                                (let-values (((v_69)
                                                                                                                              (unsafe-car
                                                                                                                               lst_130))
                                                                                                                             ((rest_76)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_130)))
                                                                                                                  (let-values (((result_62)
                                                                                                                                (let-values ()
                                                                                                                                  (let-values (((result_63)
                                                                                                                                                (let-values ()
                                                                                                                                                  (let-values ()
                                                                                                                                                    (if (pair?
                                                                                                                                                         v_69)
                                                                                                                                                      (if (let-values (((a_297)
                                                                                                                                                                        (car
                                                                                                                                                                         v_69)))
                                                                                                                                                            (list?
                                                                                                                                                             a_297))
                                                                                                                                                        (let-values (((d_290)
                                                                                                                                                                      (cdr
                                                                                                                                                                       v_69)))
                                                                                                                                                          (if (pair?
                                                                                                                                                               d_290)
                                                                                                                                                            (if (let-values (((a_298)
                                                                                                                                                                              (car
                                                                                                                                                                               d_290)))
                                                                                                                                                                  #t)
                                                                                                                                                              (let-values (((d_291)
                                                                                                                                                                            (cdr
                                                                                                                                                                             d_290)))
                                                                                                                                                                (equal?
                                                                                                                                                                 '()
                                                                                                                                                                 d_291))
                                                                                                                                                              #f)
                                                                                                                                                            #f))
                                                                                                                                                        #f)
                                                                                                                                                      #f)))))
                                                                                                                                    (values
                                                                                                                                     result_63)))))
                                                                                                                    (if (if (not
                                                                                                                             ((lambda x_20
                                                                                                                                (not
                                                                                                                                 result_62))
                                                                                                                              v_69))
                                                                                                                          (not
                                                                                                                           #f)
                                                                                                                          #f)
                                                                                                                      (for-loop_64
                                                                                                                       result_62
                                                                                                                       rest_76)
                                                                                                                      result_62)))
                                                                                                                result_61))))
                                                                                             for-loop_64)
                                                                                           #t
                                                                                           lst_129)))
                                                                                      #f))
                                                                                (let-values (((d_292) (cdr d_289)))
                                                                                  (list? d_292))
                                                                                #f)
                                                                              #f))
                                                                          #f)
                                                                        #f)
                                                                    (let-values (((idss_31 rhss_69 bodys_28)
                                                                                  (let-values (((d_293) (cdr v_61)))
                                                                                    (let-values (((idss_32 rhss_70)
                                                                                                  (let-values (((a_299)
                                                                                                                (car
                                                                                                                 d_293)))
                                                                                                    (let-values (((idss_33
                                                                                                                   rhss_71)
                                                                                                                  (let-values (((lst_131)
                                                                                                                                a_299))
                                                                                                                    (begin
                                                                                                                      (check-list
                                                                                                                       lst_131)
                                                                                                                      ((letrec-values (((for-loop_65)
                                                                                                                                        (lambda (idss_34
                                                                                                                                                 rhss_72
                                                                                                                                                 lst_132)
                                                                                                                                          (if (pair?
                                                                                                                                               lst_132)
                                                                                                                                            (let-values (((v_70)
                                                                                                                                                          (unsafe-car
                                                                                                                                                           lst_132))
                                                                                                                                                         ((rest_77)
                                                                                                                                                          (unsafe-cdr
                                                                                                                                                           lst_132)))
                                                                                                                                              (let-values (((idss_35
                                                                                                                                                             rhss_73)
                                                                                                                                                            (let-values (((idss_36)
                                                                                                                                                                          idss_34)
                                                                                                                                                                         ((rhss_74)
                                                                                                                                                                          rhss_72))
                                                                                                                                                              (let-values (((idss_37
                                                                                                                                                                             rhss_75)
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (let-values (((idss5_1
                                                                                                                                                                                             rhss6_2)
                                                                                                                                                                                            (let-values ()
                                                                                                                                                                                              (let-values (((idss_38)
                                                                                                                                                                                                            (let-values (((a_300)
                                                                                                                                                                                                                          (car
                                                                                                                                                                                                                           v_70)))
                                                                                                                                                                                                              a_300))
                                                                                                                                                                                                           ((rhss_76)
                                                                                                                                                                                                            (let-values (((d_294)
                                                                                                                                                                                                                          (cdr
                                                                                                                                                                                                                           v_70)))
                                                                                                                                                                                                              (let-values (((a_301)
                                                                                                                                                                                                                            (car
                                                                                                                                                                                                                             d_294)))
                                                                                                                                                                                                                a_301))))
                                                                                                                                                                                                (values
                                                                                                                                                                                                 idss_38
                                                                                                                                                                                                 rhss_76)))))
                                                                                                                                                                                (values
                                                                                                                                                                                 (cons
                                                                                                                                                                                  idss5_1
                                                                                                                                                                                  idss_36)
                                                                                                                                                                                 (cons
                                                                                                                                                                                  rhss6_2
                                                                                                                                                                                  rhss_74))))))
                                                                                                                                                                (values
                                                                                                                                                                 idss_37
                                                                                                                                                                 rhss_75)))))
                                                                                                                                                (if (not
                                                                                                                                                     #f)
                                                                                                                                                  (for-loop_65
                                                                                                                                                   idss_35
                                                                                                                                                   rhss_73
                                                                                                                                                   rest_77)
                                                                                                                                                  (values
                                                                                                                                                   idss_35
                                                                                                                                                   rhss_73))))
                                                                                                                                            (values
                                                                                                                                             idss_34
                                                                                                                                             rhss_72)))))
                                                                                                                         for-loop_65)
                                                                                                                       null
                                                                                                                       null
                                                                                                                       lst_131)))))
                                                                                                      (values
                                                                                                       (reverse$1
                                                                                                        idss_33)
                                                                                                       (reverse$1
                                                                                                        rhss_71)))))
                                                                                                 ((bodys_29)
                                                                                                  (let-values (((d_295)
                                                                                                                (cdr
                                                                                                                 d_293)))
                                                                                                    d_295)))
                                                                                      (values
                                                                                       idss_32
                                                                                       rhss_70
                                                                                       bodys_29)))))
                                                                      (left-to-right/let-values
                                                                       (list*
                                                                        'let-values
                                                                        (let-values (((lst_133) idss_31)
                                                                                     ((lst_134) rhss_69))
                                                                          (begin
                                                                            (check-list lst_133)
                                                                            (check-list lst_134)
                                                                            ((letrec-values (((for-loop_66)
                                                                                              (lambda (lst_135 lst_136)
                                                                                                (if (if (pair? lst_135)
                                                                                                      (pair? lst_136)
                                                                                                      #f)
                                                                                                  (let-values (((ids_49)
                                                                                                                (unsafe-car
                                                                                                                 lst_135))
                                                                                                               ((rest_78)
                                                                                                                (unsafe-cdr
                                                                                                                 lst_135))
                                                                                                               ((rhs_41)
                                                                                                                (unsafe-car
                                                                                                                 lst_136))
                                                                                                               ((rest_79)
                                                                                                                (unsafe-cdr
                                                                                                                 lst_136)))
                                                                                                    (let-values (((post-guard-var_11)
                                                                                                                  (lambda ()
                                                                                                                    #t)))
                                                                                                      (let-values ()
                                                                                                        (let-values (((elem_10)
                                                                                                                      (let-values ()
                                                                                                                        (let-values ()
                                                                                                                          (list
                                                                                                                           ids_49
                                                                                                                           (schemify_0
                                                                                                                            rhs_41))))))
                                                                                                          (let-values (((result_64)
                                                                                                                        (if (post-guard-var_11)
                                                                                                                          (for-loop_66
                                                                                                                           rest_78
                                                                                                                           rest_79)
                                                                                                                          null)))
                                                                                                            (cons
                                                                                                             elem_10
                                                                                                             result_64))))))
                                                                                                  null))))
                                                                               for-loop_66)
                                                                             lst_133
                                                                             lst_134)))
                                                                        (map2 schemify_0 bodys_28))
                                                                       mutated_9))
                                                                    (if (if (pair? v_61)
                                                                          (if (let-values (((a_302) (car v_61)))
                                                                                (equal? 'letrec-values a_302))
                                                                            (let-values (((d_296) (cdr v_61)))
                                                                              (if (pair? d_296)
                                                                                (if (let-values (((a_303) (car d_296)))
                                                                                      (if (list? a_303)
                                                                                        (let-values (((lst_137) a_303))
                                                                                          (begin
                                                                                            (check-list lst_137)
                                                                                            ((letrec-values (((for-loop_67)
                                                                                                              (lambda (result_65
                                                                                                                       lst_138)
                                                                                                                (if (pair?
                                                                                                                     lst_138)
                                                                                                                  (let-values (((v_71)
                                                                                                                                (unsafe-car
                                                                                                                                 lst_138))
                                                                                                                               ((rest_80)
                                                                                                                                (unsafe-cdr
                                                                                                                                 lst_138)))
                                                                                                                    (let-values (((result_66)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values (((result_67)
                                                                                                                                                  (let-values ()
                                                                                                                                                    (let-values ()
                                                                                                                                                      (if (pair?
                                                                                                                                                           v_71)
                                                                                                                                                        (if (let-values (((a_304)
                                                                                                                                                                          (car
                                                                                                                                                                           v_71)))
                                                                                                                                                              (if (pair?
                                                                                                                                                                   a_304)
                                                                                                                                                                (if (let-values (((a_305)
                                                                                                                                                                                  (car
                                                                                                                                                                                   a_304)))
                                                                                                                                                                      #t)
                                                                                                                                                                  (let-values (((d_297)
                                                                                                                                                                                (cdr
                                                                                                                                                                                 a_304)))
                                                                                                                                                                    (equal?
                                                                                                                                                                     '()
                                                                                                                                                                     d_297))
                                                                                                                                                                  #f)
                                                                                                                                                                #f))
                                                                                                                                                          (let-values (((d_298)
                                                                                                                                                                        (cdr
                                                                                                                                                                         v_71)))
                                                                                                                                                            (if (pair?
                                                                                                                                                                 d_298)
                                                                                                                                                              (if (let-values (((a_306)
                                                                                                                                                                                (car
                                                                                                                                                                                 d_298)))
                                                                                                                                                                    #t)
                                                                                                                                                                (let-values (((d_299)
                                                                                                                                                                              (cdr
                                                                                                                                                                               d_298)))
                                                                                                                                                                  (equal?
                                                                                                                                                                   '()
                                                                                                                                                                   d_299))
                                                                                                                                                                #f)
                                                                                                                                                              #f))
                                                                                                                                                          #f)
                                                                                                                                                        #f)))))
                                                                                                                                      (values
                                                                                                                                       result_67)))))
                                                                                                                      (if (if (not
                                                                                                                               ((lambda x_21
                                                                                                                                  (not
                                                                                                                                   result_66))
                                                                                                                                v_71))
                                                                                                                            (not
                                                                                                                             #f)
                                                                                                                            #f)
                                                                                                                        (for-loop_67
                                                                                                                         result_66
                                                                                                                         rest_80)
                                                                                                                        result_66)))
                                                                                                                  result_65))))
                                                                                               for-loop_67)
                                                                                             #t
                                                                                             lst_137)))
                                                                                        #f))
                                                                                  (let-values (((d_300) (cdr d_296)))
                                                                                    (list? d_300))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f)
                                                                      (let-values (((ids_50 rhss_77 bodys_30)
                                                                                    (let-values (((d_301) (cdr v_61)))
                                                                                      (let-values (((ids_51 rhss_78)
                                                                                                    (let-values (((a_307)
                                                                                                                  (car
                                                                                                                   d_301)))
                                                                                                      (let-values (((ids_52
                                                                                                                     rhss_79)
                                                                                                                    (let-values (((lst_139)
                                                                                                                                  a_307))
                                                                                                                      (begin
                                                                                                                        (check-list
                                                                                                                         lst_139)
                                                                                                                        ((letrec-values (((for-loop_68)
                                                                                                                                          (lambda (ids_53
                                                                                                                                                   rhss_80
                                                                                                                                                   lst_140)
                                                                                                                                            (if (pair?
                                                                                                                                                 lst_140)
                                                                                                                                              (let-values (((v_72)
                                                                                                                                                            (unsafe-car
                                                                                                                                                             lst_140))
                                                                                                                                                           ((rest_81)
                                                                                                                                                            (unsafe-cdr
                                                                                                                                                             lst_140)))
                                                                                                                                                (let-values (((ids_54
                                                                                                                                                               rhss_81)
                                                                                                                                                              (let-values (((ids_55)
                                                                                                                                                                            ids_53)
                                                                                                                                                                           ((rhss_82)
                                                                                                                                                                            rhss_80))
                                                                                                                                                                (let-values (((ids_56
                                                                                                                                                                               rhss_83)
                                                                                                                                                                              (let-values ()
                                                                                                                                                                                (let-values (((ids7_0
                                                                                                                                                                                               rhss8_0)
                                                                                                                                                                                              (let-values ()
                                                                                                                                                                                                (let-values (((ids_57)
                                                                                                                                                                                                              (let-values (((a_308)
                                                                                                                                                                                                                            (car
                                                                                                                                                                                                                             v_72)))
                                                                                                                                                                                                                (let-values (((a_309)
                                                                                                                                                                                                                              (car
                                                                                                                                                                                                                               a_308)))
                                                                                                                                                                                                                  a_309)))
                                                                                                                                                                                                             ((rhss_84)
                                                                                                                                                                                                              (let-values (((d_302)
                                                                                                                                                                                                                            (cdr
                                                                                                                                                                                                                             v_72)))
                                                                                                                                                                                                                (let-values (((a_310)
                                                                                                                                                                                                                              (car
                                                                                                                                                                                                                               d_302)))
                                                                                                                                                                                                                  a_310))))
                                                                                                                                                                                                  (values
                                                                                                                                                                                                   ids_57
                                                                                                                                                                                                   rhss_84)))))
                                                                                                                                                                                  (values
                                                                                                                                                                                   (cons
                                                                                                                                                                                    ids7_0
                                                                                                                                                                                    ids_55)
                                                                                                                                                                                   (cons
                                                                                                                                                                                    rhss8_0
                                                                                                                                                                                    rhss_82))))))
                                                                                                                                                                  (values
                                                                                                                                                                   ids_56
                                                                                                                                                                   rhss_83)))))
                                                                                                                                                  (if (not
                                                                                                                                                       #f)
                                                                                                                                                    (for-loop_68
                                                                                                                                                     ids_54
                                                                                                                                                     rhss_81
                                                                                                                                                     rest_81)
                                                                                                                                                    (values
                                                                                                                                                     ids_54
                                                                                                                                                     rhss_81))))
                                                                                                                                              (values
                                                                                                                                               ids_53
                                                                                                                                               rhss_80)))))
                                                                                                                           for-loop_68)
                                                                                                                         null
                                                                                                                         null
                                                                                                                         lst_139)))))
                                                                                                        (values
                                                                                                         (reverse$1
                                                                                                          ids_52)
                                                                                                         (reverse$1
                                                                                                          rhss_79)))))
                                                                                                   ((bodys_31)
                                                                                                    (let-values (((d_303)
                                                                                                                  (cdr
                                                                                                                   d_301)))
                                                                                                      d_303)))
                                                                                        (values
                                                                                         ids_51
                                                                                         rhss_78
                                                                                         bodys_31)))))
                                                                        (let-values (((new-knowns_2)
                                                                                      (let-values (((lst_141) ids_50)
                                                                                                   ((lst_142) rhss_77))
                                                                                        (begin
                                                                                          (check-list lst_141)
                                                                                          (check-list lst_142)
                                                                                          ((letrec-values (((for-loop_69)
                                                                                                            (lambda (knowns_34
                                                                                                                     lst_143
                                                                                                                     lst_144)
                                                                                                              (if (if (pair?
                                                                                                                       lst_143)
                                                                                                                    (pair?
                                                                                                                     lst_144)
                                                                                                                    #f)
                                                                                                                (let-values (((id_32)
                                                                                                                              (unsafe-car
                                                                                                                               lst_143))
                                                                                                                             ((rest_82)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_143))
                                                                                                                             ((rhs_42)
                                                                                                                              (unsafe-car
                                                                                                                               lst_144))
                                                                                                                             ((rest_83)
                                                                                                                              (unsafe-cdr
                                                                                                                               lst_144)))
                                                                                                                  (let-values (((knowns_35)
                                                                                                                                (let-values (((knowns_36)
                                                                                                                                              knowns_34))
                                                                                                                                  (let-values (((knowns_37)
                                                                                                                                                (let-values ()
                                                                                                                                                  (if (lambda?
                                                                                                                                                       rhs_42)
                                                                                                                                                    (hash-set
                                                                                                                                                     knowns_36
                                                                                                                                                     id_32
                                                                                                                                                     a-known-procedure)
                                                                                                                                                    knowns_36))))
                                                                                                                                    (values
                                                                                                                                     knowns_37)))))
                                                                                                                    (if (not
                                                                                                                         #f)
                                                                                                                      (for-loop_69
                                                                                                                       knowns_35
                                                                                                                       rest_82
                                                                                                                       rest_83)
                                                                                                                      knowns_35)))
                                                                                                                knowns_34))))
                                                                                             for-loop_69)
                                                                                           knowns_29
                                                                                           lst_141
                                                                                           lst_142)))))
                                                                          (list*
                                                                           'letrec*
                                                                           (let-values (((lst_145) ids_50)
                                                                                        ((lst_146) rhss_77))
                                                                             (begin
                                                                               (check-list lst_145)
                                                                               (check-list lst_146)
                                                                               ((letrec-values (((for-loop_70)
                                                                                                 (lambda (lst_147
                                                                                                          lst_148)
                                                                                                   (if (if (pair?
                                                                                                            lst_147)
                                                                                                         (pair? lst_148)
                                                                                                         #f)
                                                                                                     (let-values (((id_33)
                                                                                                                   (unsafe-car
                                                                                                                    lst_147))
                                                                                                                  ((rest_84)
                                                                                                                   (unsafe-cdr
                                                                                                                    lst_147))
                                                                                                                  ((rhs_43)
                                                                                                                   (unsafe-car
                                                                                                                    lst_148))
                                                                                                                  ((rest_85)
                                                                                                                   (unsafe-cdr
                                                                                                                    lst_148)))
                                                                                                       (let-values (((post-guard-var_12)
                                                                                                                     (lambda ()
                                                                                                                       #t)))
                                                                                                         (let-values ()
                                                                                                           (let-values (((elem_11)
                                                                                                                         (let-values ()
                                                                                                                           (let-values ()
                                                                                                                             (list
                                                                                                                              id_33
                                                                                                                              (schemify/knowns_0
                                                                                                                               new-knowns_2
                                                                                                                               rhs_43))))))
                                                                                                             (let-values (((result_68)
                                                                                                                           (if (post-guard-var_12)
                                                                                                                             (for-loop_70
                                                                                                                              rest_84
                                                                                                                              rest_85)
                                                                                                                             null)))
                                                                                                               (cons
                                                                                                                elem_11
                                                                                                                result_68))))))
                                                                                                     null))))
                                                                                  for-loop_70)
                                                                                lst_145
                                                                                lst_146)))
                                                                           (let-values (((lst_149) bodys_30))
                                                                             (begin
                                                                               (check-list lst_149)
                                                                               ((letrec-values (((for-loop_71)
                                                                                                 (lambda (lst_150)
                                                                                                   (if (pair? lst_150)
                                                                                                     (let-values (((body_27)
                                                                                                                   (unsafe-car
                                                                                                                    lst_150))
                                                                                                                  ((rest_86)
                                                                                                                   (unsafe-cdr
                                                                                                                    lst_150)))
                                                                                                       (let-values (((post-guard-var_13)
                                                                                                                     (lambda ()
                                                                                                                       #t)))
                                                                                                         (let-values ()
                                                                                                           (let-values (((elem_12)
                                                                                                                         (let-values ()
                                                                                                                           (let-values ()
                                                                                                                             (schemify/knowns_0
                                                                                                                              new-knowns_2
                                                                                                                              body_27)))))
                                                                                                             (let-values (((result_69)
                                                                                                                           (if (post-guard-var_13)
                                                                                                                             (for-loop_71
                                                                                                                              rest_86)
                                                                                                                             null)))
                                                                                                               (cons
                                                                                                                elem_12
                                                                                                                result_69))))))
                                                                                                     null))))
                                                                                  for-loop_71)
                                                                                lst_149))))))
                                                                      (if (if (pair? v_61)
                                                                            (if (let-values (((a_311) (car v_61)))
                                                                                  (equal? 'letrec-values a_311))
                                                                              (let-values (((d_304) (cdr v_61)))
                                                                                (if (pair? d_304)
                                                                                  (if (let-values (((a_312)
                                                                                                    (car d_304)))
                                                                                        (if (list? a_312)
                                                                                          (let-values (((lst_151)
                                                                                                        a_312))
                                                                                            (begin
                                                                                              (check-list lst_151)
                                                                                              ((letrec-values (((for-loop_72)
                                                                                                                (lambda (result_70
                                                                                                                         lst_152)
                                                                                                                  (if (pair?
                                                                                                                       lst_152)
                                                                                                                    (let-values (((v_73)
                                                                                                                                  (unsafe-car
                                                                                                                                   lst_152))
                                                                                                                                 ((rest_87)
                                                                                                                                  (unsafe-cdr
                                                                                                                                   lst_152)))
                                                                                                                      (let-values (((result_71)
                                                                                                                                    (let-values ()
                                                                                                                                      (let-values (((result_72)
                                                                                                                                                    (let-values ()
                                                                                                                                                      (let-values ()
                                                                                                                                                        (if (pair?
                                                                                                                                                             v_73)
                                                                                                                                                          (if (let-values (((a_313)
                                                                                                                                                                            (car
                                                                                                                                                                             v_73)))
                                                                                                                                                                (list?
                                                                                                                                                                 a_313))
                                                                                                                                                            (let-values (((d_305)
                                                                                                                                                                          (cdr
                                                                                                                                                                           v_73)))
                                                                                                                                                              (if (pair?
                                                                                                                                                                   d_305)
                                                                                                                                                                (if (let-values (((a_314)
                                                                                                                                                                                  (car
                                                                                                                                                                                   d_305)))
                                                                                                                                                                      #t)
                                                                                                                                                                  (let-values (((d_306)
                                                                                                                                                                                (cdr
                                                                                                                                                                                 d_305)))
                                                                                                                                                                    (equal?
                                                                                                                                                                     '()
                                                                                                                                                                     d_306))
                                                                                                                                                                  #f)
                                                                                                                                                                #f))
                                                                                                                                                            #f)
                                                                                                                                                          #f)))))
                                                                                                                                        (values
                                                                                                                                         result_72)))))
                                                                                                                        (if (if (not
                                                                                                                                 ((lambda x_22
                                                                                                                                    (not
                                                                                                                                     result_71))
                                                                                                                                  v_73))
                                                                                                                              (not
                                                                                                                               #f)
                                                                                                                              #f)
                                                                                                                          (for-loop_72
                                                                                                                           result_71
                                                                                                                           rest_87)
                                                                                                                          result_71)))
                                                                                                                    result_70))))
                                                                                                 for-loop_72)
                                                                                               #t
                                                                                               lst_151)))
                                                                                          #f))
                                                                                    (let-values (((d_307) (cdr d_304)))
                                                                                      (list? d_307))
                                                                                    #f)
                                                                                  #f))
                                                                              #f)
                                                                            #f)
                                                                        (let-values (((idss_39 rhss_85 bodys_32)
                                                                                      (let-values (((d_308) (cdr v_61)))
                                                                                        (let-values (((idss_40 rhss_86)
                                                                                                      (let-values (((a_315)
                                                                                                                    (car
                                                                                                                     d_308)))
                                                                                                        (let-values (((idss_41
                                                                                                                       rhss_87)
                                                                                                                      (let-values (((lst_153)
                                                                                                                                    a_315))
                                                                                                                        (begin
                                                                                                                          (check-list
                                                                                                                           lst_153)
                                                                                                                          ((letrec-values (((for-loop_73)
                                                                                                                                            (lambda (idss_42
                                                                                                                                                     rhss_88
                                                                                                                                                     lst_154)
                                                                                                                                              (if (pair?
                                                                                                                                                   lst_154)
                                                                                                                                                (let-values (((v_74)
                                                                                                                                                              (unsafe-car
                                                                                                                                                               lst_154))
                                                                                                                                                             ((rest_88)
                                                                                                                                                              (unsafe-cdr
                                                                                                                                                               lst_154)))
                                                                                                                                                  (let-values (((idss_43
                                                                                                                                                                 rhss_89)
                                                                                                                                                                (let-values (((idss_44)
                                                                                                                                                                              idss_42)
                                                                                                                                                                             ((rhss_90)
                                                                                                                                                                              rhss_88))
                                                                                                                                                                  (let-values (((idss_45
                                                                                                                                                                                 rhss_91)
                                                                                                                                                                                (let-values ()
                                                                                                                                                                                  (let-values (((idss9_0
                                                                                                                                                                                                 rhss10_0)
                                                                                                                                                                                                (let-values ()
                                                                                                                                                                                                  (let-values (((idss_46)
                                                                                                                                                                                                                (let-values (((a_316)
                                                                                                                                                                                                                              (car
                                                                                                                                                                                                                               v_74)))
                                                                                                                                                                                                                  a_316))
                                                                                                                                                                                                               ((rhss_92)
                                                                                                                                                                                                                (let-values (((d_309)
                                                                                                                                                                                                                              (cdr
                                                                                                                                                                                                                               v_74)))
                                                                                                                                                                                                                  (let-values (((a_317)
                                                                                                                                                                                                                                (car
                                                                                                                                                                                                                                 d_309)))
                                                                                                                                                                                                                    a_317))))
                                                                                                                                                                                                    (values
                                                                                                                                                                                                     idss_46
                                                                                                                                                                                                     rhss_92)))))
                                                                                                                                                                                    (values
                                                                                                                                                                                     (cons
                                                                                                                                                                                      idss9_0
                                                                                                                                                                                      idss_44)
                                                                                                                                                                                     (cons
                                                                                                                                                                                      rhss10_0
                                                                                                                                                                                      rhss_90))))))
                                                                                                                                                                    (values
                                                                                                                                                                     idss_45
                                                                                                                                                                     rhss_91)))))
                                                                                                                                                    (if (not
                                                                                                                                                         #f)
                                                                                                                                                      (for-loop_73
                                                                                                                                                       idss_43
                                                                                                                                                       rhss_89
                                                                                                                                                       rest_88)
                                                                                                                                                      (values
                                                                                                                                                       idss_43
                                                                                                                                                       rhss_89))))
                                                                                                                                                (values
                                                                                                                                                 idss_42
                                                                                                                                                 rhss_88)))))
                                                                                                                             for-loop_73)
                                                                                                                           null
                                                                                                                           null
                                                                                                                           lst_153)))))
                                                                                                          (values
                                                                                                           (reverse$1
                                                                                                            idss_41)
                                                                                                           (reverse$1
                                                                                                            rhss_87)))))
                                                                                                     ((bodys_33)
                                                                                                      (let-values (((d_310)
                                                                                                                    (cdr
                                                                                                                     d_308)))
                                                                                                        d_310)))
                                                                                          (values
                                                                                           idss_40
                                                                                           rhss_86
                                                                                           bodys_33)))))
                                                                          (list*
                                                                           'letrec*
                                                                           (apply
                                                                            append
                                                                            (let-values (((lst_155) idss_39)
                                                                                         ((lst_156) rhss_85))
                                                                              (begin
                                                                                (check-list lst_155)
                                                                                (check-list lst_156)
                                                                                ((letrec-values (((for-loop_74)
                                                                                                  (lambda (lst_157
                                                                                                           lst_158)
                                                                                                    (if (if (pair?
                                                                                                             lst_157)
                                                                                                          (pair?
                                                                                                           lst_158)
                                                                                                          #f)
                                                                                                      (let-values (((ids_58)
                                                                                                                    (unsafe-car
                                                                                                                     lst_157))
                                                                                                                   ((rest_89)
                                                                                                                    (unsafe-cdr
                                                                                                                     lst_157))
                                                                                                                   ((rhs_44)
                                                                                                                    (unsafe-car
                                                                                                                     lst_158))
                                                                                                                   ((rest_90)
                                                                                                                    (unsafe-cdr
                                                                                                                     lst_158)))
                                                                                                        (let-values (((post-guard-var_14)
                                                                                                                      (lambda ()
                                                                                                                        #t)))
                                                                                                          (let-values ()
                                                                                                            (let-values (((elem_13)
                                                                                                                          (let-values ()
                                                                                                                            (let-values ()
                                                                                                                              (let-values (((rhs_45)
                                                                                                                                            (schemify_0
                                                                                                                                             rhs_44)))
                                                                                                                                (if (null?
                                                                                                                                     ids_58)
                                                                                                                                  (let-values ()
                                                                                                                                    (list
                                                                                                                                     (list
                                                                                                                                      (gensym
                                                                                                                                       "lr")
                                                                                                                                      (make-let-values
                                                                                                                                       null
                                                                                                                                       rhs_45
                                                                                                                                       '(void)))))
                                                                                                                                  (if (if (pair?
                                                                                                                                           ids_58)
                                                                                                                                        (null?
                                                                                                                                         (cdr
                                                                                                                                          ids_58))
                                                                                                                                        #f)
                                                                                                                                    (let-values ()
                                                                                                                                      (list
                                                                                                                                       (list
                                                                                                                                        (car
                                                                                                                                         ids_58)
                                                                                                                                        rhs_45)))
                                                                                                                                    (let-values ()
                                                                                                                                      (let-values (((lr_0)
                                                                                                                                                    (gensym
                                                                                                                                                     "lr")))
                                                                                                                                        (list*
                                                                                                                                         (list
                                                                                                                                          lr_0
                                                                                                                                          (make-let-values
                                                                                                                                           ids_58
                                                                                                                                           rhs_45
                                                                                                                                           (list*
                                                                                                                                            'vector
                                                                                                                                            ids_58)))
                                                                                                                                         (let-values (((lst_159)
                                                                                                                                                       ids_58)
                                                                                                                                                      ((start_3)
                                                                                                                                                       0))
                                                                                                                                           (begin
                                                                                                                                             (check-list
                                                                                                                                              lst_159)
                                                                                                                                             (check-naturals
                                                                                                                                              start_3)
                                                                                                                                             ((letrec-values (((for-loop_75)
                                                                                                                                                               (lambda (lst_160
                                                                                                                                                                        pos_6)
                                                                                                                                                                 (if (if (pair?
                                                                                                                                                                          lst_160)
                                                                                                                                                                       #t
                                                                                                                                                                       #f)
                                                                                                                                                                   (let-values (((id_34)
                                                                                                                                                                                 (unsafe-car
                                                                                                                                                                                  lst_160))
                                                                                                                                                                                ((rest_91)
                                                                                                                                                                                 (unsafe-cdr
                                                                                                                                                                                  lst_160))
                                                                                                                                                                                ((pos_7)
                                                                                                                                                                                 pos_6))
                                                                                                                                                                     (let-values (((post-guard-var_15)
                                                                                                                                                                                   (lambda ()
                                                                                                                                                                                     #t)))
                                                                                                                                                                       (let-values ()
                                                                                                                                                                         (let-values (((elem_14)
                                                                                                                                                                                       (let-values ()
                                                                                                                                                                                         (let-values ()
                                                                                                                                                                                           (list
                                                                                                                                                                                            id_34
                                                                                                                                                                                            (list
                                                                                                                                                                                             'vector-ref
                                                                                                                                                                                             lr_0
                                                                                                                                                                                             pos_7))))))
                                                                                                                                                                           (let-values (((result_73)
                                                                                                                                                                                         (if (post-guard-var_15)
                                                                                                                                                                                           (for-loop_75
                                                                                                                                                                                            rest_91
                                                                                                                                                                                            (+
                                                                                                                                                                                             pos_6
                                                                                                                                                                                             1))
                                                                                                                                                                                           null)))
                                                                                                                                                                             (cons
                                                                                                                                                                              elem_14
                                                                                                                                                                              result_73))))))
                                                                                                                                                                   null))))
                                                                                                                                                for-loop_75)
                                                                                                                                              lst_159
                                                                                                                                              start_3)))))))))))))
                                                                                                              (let-values (((result_74)
                                                                                                                            (if (post-guard-var_14)
                                                                                                                              (for-loop_74
                                                                                                                               rest_89
                                                                                                                               rest_90)
                                                                                                                              null)))
                                                                                                                (cons
                                                                                                                 elem_13
                                                                                                                 result_74))))))
                                                                                                      null))))
                                                                                   for-loop_74)
                                                                                 lst_155
                                                                                 lst_156))))
                                                                           (map2 schemify_0 bodys_32)))
                                                                        (if (if (pair? v_61)
                                                                              (if (let-values (((a_318) (car v_61)))
                                                                                    (equal? 'if a_318))
                                                                                (let-values (((d_311) (cdr v_61)))
                                                                                  (if (pair? d_311)
                                                                                    (if (let-values (((a_319)
                                                                                                      (car d_311)))
                                                                                          #t)
                                                                                      (let-values (((d_312)
                                                                                                    (cdr d_311)))
                                                                                        (if (pair? d_312)
                                                                                          (if (let-values (((a_320)
                                                                                                            (car
                                                                                                             d_312)))
                                                                                                #t)
                                                                                            (let-values (((d_313)
                                                                                                          (cdr d_312)))
                                                                                              (if (pair? d_313)
                                                                                                (if (let-values (((a_321)
                                                                                                                  (car
                                                                                                                   d_313)))
                                                                                                      #t)
                                                                                                  (let-values (((d_314)
                                                                                                                (cdr
                                                                                                                 d_313)))
                                                                                                    (equal? '() d_314))
                                                                                                  #f)
                                                                                                #f))
                                                                                            #f)
                                                                                          #f))
                                                                                      #f)
                                                                                    #f))
                                                                                #f)
                                                                              #f)
                                                                          (let-values (((tst_2 thn_3 els_3)
                                                                                        (let-values (((d_315)
                                                                                                      (cdr v_61)))
                                                                                          (let-values (((tst_3)
                                                                                                        (let-values (((a_322)
                                                                                                                      (car
                                                                                                                       d_315)))
                                                                                                          a_322))
                                                                                                       ((thn_4 els_4)
                                                                                                        (let-values (((d_316)
                                                                                                                      (cdr
                                                                                                                       d_315)))
                                                                                                          (let-values (((thn_5)
                                                                                                                        (let-values (((a_323)
                                                                                                                                      (car
                                                                                                                                       d_316)))
                                                                                                                          a_323))
                                                                                                                       ((els_5)
                                                                                                                        (let-values (((d_317)
                                                                                                                                      (cdr
                                                                                                                                       d_316)))
                                                                                                                          (let-values (((a_324)
                                                                                                                                        (car
                                                                                                                                         d_317)))
                                                                                                                            a_324))))
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
                                                                          (if (if (pair? v_61)
                                                                                (if (let-values (((a_325) (car v_61)))
                                                                                      (equal?
                                                                                       'with-continuation-mark
                                                                                       a_325))
                                                                                  (let-values (((d_318) (cdr v_61)))
                                                                                    (if (pair? d_318)
                                                                                      (if (let-values (((a_326)
                                                                                                        (car d_318)))
                                                                                            #t)
                                                                                        (let-values (((d_319)
                                                                                                      (cdr d_318)))
                                                                                          (if (pair? d_319)
                                                                                            (if (let-values (((a_327)
                                                                                                              (car
                                                                                                               d_319)))
                                                                                                  #t)
                                                                                              (let-values (((d_320)
                                                                                                            (cdr
                                                                                                             d_319)))
                                                                                                (if (pair? d_320)
                                                                                                  (if (let-values (((a_328)
                                                                                                                    (car
                                                                                                                     d_320)))
                                                                                                        #t)
                                                                                                    (let-values (((d_321)
                                                                                                                  (cdr
                                                                                                                   d_320)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_321))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f)
                                                                            (let-values (((key_3 val_4 body_28)
                                                                                          (let-values (((d_322)
                                                                                                        (cdr v_61)))
                                                                                            (let-values (((key_4)
                                                                                                          (let-values (((a_329)
                                                                                                                        (car
                                                                                                                         d_322)))
                                                                                                            a_329))
                                                                                                         ((val_5
                                                                                                           body_29)
                                                                                                          (let-values (((d_323)
                                                                                                                        (cdr
                                                                                                                         d_322)))
                                                                                                            (let-values (((val_6)
                                                                                                                          (let-values (((a_330)
                                                                                                                                        (car
                                                                                                                                         d_323)))
                                                                                                                            a_330))
                                                                                                                         ((body_30)
                                                                                                                          (let-values (((d_324)
                                                                                                                                        (cdr
                                                                                                                                         d_323)))
                                                                                                                            (let-values (((a_331)
                                                                                                                                          (car
                                                                                                                                           d_324)))
                                                                                                                              a_331))))
                                                                                                              (values
                                                                                                               val_6
                                                                                                               body_30)))))
                                                                                              (values
                                                                                               key_4
                                                                                               val_5
                                                                                               body_29)))))
                                                                              (list
                                                                               'with-continuation-mark
                                                                               (schemify_0 key_3)
                                                                               (schemify_0 val_4)
                                                                               (schemify_0 body_28)))
                                                                            (if (if (pair? v_61)
                                                                                  (if (let-values (((a_332) (car v_61)))
                                                                                        (equal? 'begin a_332))
                                                                                    (let-values (((d_325) (cdr v_61)))
                                                                                      (list? d_325))
                                                                                    #f)
                                                                                  #f)
                                                                              (let-values (((exps_5)
                                                                                            (let-values (((d_326)
                                                                                                          (cdr v_61)))
                                                                                              d_326)))
                                                                                (list* 'begin (map2 schemify_0 exps_5)))
                                                                              (if (if (pair? v_61)
                                                                                    (if (let-values (((a_333)
                                                                                                      (car v_61)))
                                                                                          (equal? 'begin0 a_333))
                                                                                      (let-values (((d_327) (cdr v_61)))
                                                                                        (list? d_327))
                                                                                      #f)
                                                                                    #f)
                                                                                (let-values (((exps_6)
                                                                                              (let-values (((d_328)
                                                                                                            (cdr v_61)))
                                                                                                d_328)))
                                                                                  (list*
                                                                                   'begin0
                                                                                   (map2 schemify_0 exps_6)))
                                                                                (if (if (pair? v_61)
                                                                                      (if (let-values (((a_334)
                                                                                                        (car v_61)))
                                                                                            (equal? 'set! a_334))
                                                                                        (let-values (((d_329)
                                                                                                      (cdr v_61)))
                                                                                          (if (pair? d_329)
                                                                                            (if (let-values (((a_335)
                                                                                                              (car
                                                                                                               d_329)))
                                                                                                  #t)
                                                                                              (let-values (((d_330)
                                                                                                            (cdr
                                                                                                             d_329)))
                                                                                                (if (pair? d_330)
                                                                                                  (if (let-values (((a_336)
                                                                                                                    (car
                                                                                                                     d_330)))
                                                                                                        #t)
                                                                                                    (let-values (((d_331)
                                                                                                                  (cdr
                                                                                                                   d_330)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_331))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f)
                                                                                  (let-values (((id_35 rhs_46)
                                                                                                (let-values (((d_332)
                                                                                                              (cdr
                                                                                                               v_61)))
                                                                                                  (let-values (((id_36)
                                                                                                                (let-values (((a_337)
                                                                                                                              (car
                                                                                                                               d_332)))
                                                                                                                  a_337))
                                                                                                               ((rhs_47)
                                                                                                                (let-values (((d_333)
                                                                                                                              (cdr
                                                                                                                               d_332)))
                                                                                                                  (let-values (((a_338)
                                                                                                                                (car
                                                                                                                                 d_333)))
                                                                                                                    a_338))))
                                                                                                    (values
                                                                                                     id_36
                                                                                                     rhs_47)))))
                                                                                    (let-values (((ex-id_0)
                                                                                                  (hash-ref
                                                                                                   exports_9
                                                                                                   id_35
                                                                                                   #f)))
                                                                                      (if ex-id_0
                                                                                        (list
                                                                                         'variable-set!
                                                                                         ex-id_0
                                                                                         (schemify_0 rhs_46))
                                                                                        (list
                                                                                         'set!
                                                                                         id_35
                                                                                         (schemify_0 rhs_46)))))
                                                                                  (if (if (pair? v_61)
                                                                                        (if (let-values (((a_339)
                                                                                                          (car v_61)))
                                                                                              (equal?
                                                                                               'variable-reference-constant?
                                                                                               a_339))
                                                                                          (let-values (((d_334)
                                                                                                        (cdr v_61)))
                                                                                            (if (pair? d_334)
                                                                                              (if (let-values (((a_340)
                                                                                                                (car
                                                                                                                 d_334)))
                                                                                                    (if (pair? a_340)
                                                                                                      (if (let-values (((a_341)
                                                                                                                        (car
                                                                                                                         a_340)))
                                                                                                            (equal?
                                                                                                             '#%variable-reference
                                                                                                             a_341))
                                                                                                        (let-values (((d_335)
                                                                                                                      (cdr
                                                                                                                       a_340)))
                                                                                                          (if (pair?
                                                                                                               d_335)
                                                                                                            (if (let-values (((a_342)
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
                                                                                                (let-values (((d_337)
                                                                                                              (cdr
                                                                                                               d_334)))
                                                                                                  (equal? '() d_337))
                                                                                                #f)
                                                                                              #f))
                                                                                          #f)
                                                                                        #f)
                                                                                    (let-values (((id_37)
                                                                                                  (let-values (((d_338)
                                                                                                                (cdr
                                                                                                                 v_61)))
                                                                                                    (let-values (((a_343)
                                                                                                                  (car
                                                                                                                   d_338)))
                                                                                                      (let-values (((d_339)
                                                                                                                    (cdr
                                                                                                                     a_343)))
                                                                                                        (let-values (((a_344)
                                                                                                                      (car
                                                                                                                       d_339)))
                                                                                                          a_344))))))
                                                                                      (if (not
                                                                                           (hash-ref
                                                                                            mutated_9
                                                                                            id_37
                                                                                            #f))
                                                                                        (let-values (((im_3)
                                                                                                      (hash-ref
                                                                                                       imports_17
                                                                                                       id_37
                                                                                                       #f)))
                                                                                          (let-values (((or-part_21)
                                                                                                        (not im_3)))
                                                                                            (if or-part_21
                                                                                              or-part_21
                                                                                              (known-constant?
                                                                                               (import-lookup im_3)))))
                                                                                        #f))
                                                                                    (if (if (pair? v_61)
                                                                                          (if (let-values (((a_345)
                                                                                                            (car v_61)))
                                                                                                (equal?
                                                                                                 '#%variable-reference
                                                                                                 a_345))
                                                                                            (let-values (((d_340)
                                                                                                          (cdr v_61)))
                                                                                              (equal? '() d_340))
                                                                                            #f)
                                                                                          #f)
                                                                                      (let-values ()
                                                                                        'instance-variable-reference)
                                                                                      (if (if (pair? v_61)
                                                                                            (if (let-values (((a_346)
                                                                                                              (car
                                                                                                               v_61)))
                                                                                                  (equal?
                                                                                                   '#%variable-reference
                                                                                                   a_346))
                                                                                              (let-values (((d_341)
                                                                                                            (cdr v_61)))
                                                                                                (if (pair? d_341)
                                                                                                  (if (let-values (((a_347)
                                                                                                                    (car
                                                                                                                     d_341)))
                                                                                                        #t)
                                                                                                    (let-values (((d_342)
                                                                                                                  (cdr
                                                                                                                   d_341)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_342))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f)
                                                                                        (let-values (((id_38)
                                                                                                      (let-values (((d_343)
                                                                                                                    (cdr
                                                                                                                     v_61)))
                                                                                                        (let-values (((a_348)
                                                                                                                      (car
                                                                                                                       d_343)))
                                                                                                          a_348))))
                                                                                          (let-values (((e_4)
                                                                                                        (hash-ref
                                                                                                         exports_9
                                                                                                         id_38
                                                                                                         #f)))
                                                                                            (if e_4
                                                                                              (list
                                                                                               'make-instance-variable-reference
                                                                                               'instance-variable-reference
                                                                                               e_4)
                                                                                              (list
                                                                                               'make-instance-variable-reference
                                                                                               'instance-variable-reference
                                                                                               (if (hash-ref
                                                                                                    mutated_9
                                                                                                    v_60
                                                                                                    #f)
                                                                                                 'mutable
                                                                                                 'immutable)))))
                                                                                        (if (if (pair? v_61)
                                                                                              (if (let-values (((a_349)
                                                                                                                (car
                                                                                                                 v_61)))
                                                                                                    #t)
                                                                                                (let-values (((d_344)
                                                                                                              (cdr
                                                                                                               v_61)))
                                                                                                  (list? d_344))
                                                                                                #f)
                                                                                              #f)
                                                                                          (let-values (((rator_2 exps_7)
                                                                                                        (let-values (((rator_3)
                                                                                                                      (let-values (((a_350)
                                                                                                                                    (car
                                                                                                                                     v_61)))
                                                                                                                        a_350))
                                                                                                                     ((exps_8)
                                                                                                                      (let-values (((d_345)
                                                                                                                                    (cdr
                                                                                                                                     v_61)))
                                                                                                                        d_345)))
                                                                                                          (values
                                                                                                           rator_3
                                                                                                           exps_8))))
                                                                                            (let-values (((args_4)
                                                                                                          (map2
                                                                                                           schemify_0
                                                                                                           exps_7)))
                                                                                              (left-to-right/app
                                                                                               (if (let-values (((or-part_22)
                                                                                                                 (if (known-procedure?
                                                                                                                      (hash-ref-either
                                                                                                                       knowns_29
                                                                                                                       imports_17
                                                                                                                       rator_2))
                                                                                                                   (not
                                                                                                                    (hash-ref
                                                                                                                     mutated_9
                                                                                                                     rator_2
                                                                                                                     #f))
                                                                                                                   #f)))
                                                                                                     (if or-part_22
                                                                                                       or-part_22
                                                                                                       (let-values (((or-part_23)
                                                                                                                     (known-procedure?
                                                                                                                      (hash-ref
                                                                                                                       prim-knowns_8
                                                                                                                       rator_2
                                                                                                                       #f))))
                                                                                                         (if or-part_23
                                                                                                           or-part_23
                                                                                                           (lambda?
                                                                                                            rator_2)))))
                                                                                                 (list*
                                                                                                  (schemify_0 rator_2)
                                                                                                  args_4)
                                                                                                 (list*
                                                                                                  '#%app
                                                                                                  (schemify_0 rator_2)
                                                                                                  args_4))
                                                                                               prim-knowns_8
                                                                                               knowns_29
                                                                                               imports_17
                                                                                               mutated_9)))
                                                                                          (let-values ()
                                                                                            (let-values (((c1_0)
                                                                                                          (if (symbol?
                                                                                                               v_60)
                                                                                                            (if (via-variable-mutated-state?
                                                                                                                 (hash-ref
                                                                                                                  mutated_9
                                                                                                                  v_60
                                                                                                                  #f))
                                                                                                              (hash-ref
                                                                                                               exports_9
                                                                                                               v_60
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
                                                                                                                   v_60)
                                                                                                                (hash-ref
                                                                                                                 imports_17
                                                                                                                 v_60
                                                                                                                 #f)
                                                                                                                #f)))
                                                                                                  (if c2_0
                                                                                                    ((lambda (im_4)
                                                                                                       (if (known-constant?
                                                                                                            (import-lookup
                                                                                                             im_4))
                                                                                                         (import-id
                                                                                                          im_4)
                                                                                                         (list
                                                                                                          'variable-ref/no-check
                                                                                                          (import-id
                                                                                                           im_4))))
                                                                                                     c2_0)
                                                                                                    (let-values ()
                                                                                                      v_60))))))))))))))))))))))))))))))))
                           schemify_0)
                         v_55))))
       schemify/knowns_0)
     knowns_28
     v_59))))
