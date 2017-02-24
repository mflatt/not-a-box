;; This is not the original source code. Instead, this is the code after
;; fully expanding and flattening into a single linklet.
(linklet
 ()
 ((schemify-body schemify-body) (schemify-linklet schemify-linklet))
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
  (schemify-linklet)
  (lambda (lk_0 init-procs_0)
    (let-values (((imports_0)
                  (let-values (((lst_0) (cadr lk_0)))
                    (begin
                      (check-list lst_0)
                      ((letrec-values (((for-loop_0)
                                        (lambda (imports_1 lst_1)
                                          (if (pair? lst_1)
                                            (let-values (((ims_0) (unsafe-car lst_1)) ((rest_0) (unsafe-cdr lst_1)))
                                              (let-values (((imports_2)
                                                            (let-values (((lst_2) ims_0))
                                                              (begin
                                                                (check-list lst_2)
                                                                ((letrec-values (((for-loop_1)
                                                                                  (lambda (imports_3 lst_3)
                                                                                    (if (pair? lst_3)
                                                                                      (let-values (((im_0)
                                                                                                    (unsafe-car lst_3))
                                                                                                   ((rest_1)
                                                                                                    (unsafe-cdr lst_3)))
                                                                                        (let-values (((imports_4)
                                                                                                      (let-values (((imports_5)
                                                                                                                    imports_3))
                                                                                                        (let-values (((imports_6)
                                                                                                                      (let-values ()
                                                                                                                        (let-values (((id_0)
                                                                                                                                      (if (pair?
                                                                                                                                           im_0)
                                                                                                                                        (cadr
                                                                                                                                         im_0)
                                                                                                                                        im_0)))
                                                                                                                          (hash-set
                                                                                                                           imports_5
                                                                                                                           id_0
                                                                                                                           (gensym
                                                                                                                            (symbol->string
                                                                                                                             id_0)))))))
                                                                                                          (values
                                                                                                           imports_6)))))
                                                                                          (if (not #f)
                                                                                            (for-loop_1
                                                                                             imports_4
                                                                                             rest_1)
                                                                                            imports_4)))
                                                                                      imports_3))))
                                                                   for-loop_1)
                                                                 imports_1
                                                                 lst_2)))))
                                                (if (not #f) (for-loop_0 imports_2 rest_0) imports_2)))
                                            imports_1))))
                         for-loop_0)
                       (hasheq)
                       lst_0)))))
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
        (list*
         'lambda
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
                                                                    (let-values (((post-guard-var_1) (lambda () #t)))
                                                                      (let-values ()
                                                                        (let-values (((elem_0)
                                                                                      (let-values ()
                                                                                        (let-values ()
                                                                                          (hash-ref
                                                                                           imports_0
                                                                                           (if (pair? im_1)
                                                                                             (cadr im_1)
                                                                                             im_1))))))
                                                                          (let-values (((result_0)
                                                                                        (if (post-guard-var_1)
                                                                                          (for-loop_4 rest_4)
                                                                                          (if (post-guard-var_0)
                                                                                            (for-loop_3 rest_3)
                                                                                            null))))
                                                                            (cons elem_0 result_0))))))
                                                                  (if (post-guard-var_0) (for-loop_3 rest_3) null)))))
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
                                                            (hash-ref exports_0 (if (pair? ex_1) (car ex_1) ex_1))))))
                                            (let-values (((result_1) (if (post-guard-var_2) (for-loop_5 rest_5) null)))
                                              (cons elem_1 result_1))))))
                                    null))))
                 for-loop_5)
               lst_10))))
         (schemify-body (cdddr lk_0) init-procs_0 imports_0 exports_0))))))
 (define-values
  (schemify-body)
  (lambda (l_9 init-procs_1 imports_7 exports_5)
    (let-values (((mutated_0) (mutated-in-body l_9 exports_5)))
      ((letrec-values (((loop_5)
                        (lambda (l_10 procs_0 structs_0 accum_0 need-expr?_0)
                          (if (null? l_10)
                            (let-values ()
                              (append
                               (map2
                                (make-schemify procs_0 structs_0 mutated_0 imports_7 exports_5)
                                (reverse$1 accum_0))
                               (make-set-variables accum_0 exports_5)
                               (if need-expr?_0 '((void)) null)))
                            (let-values ()
                              (let-values (((v_14 new-procs_0 new-structs_0 side-effects?_0 defn?_0)
                                            (find-definitions (car l_10) procs_0 structs_0 (null? (cdr l_10)))))
                                (if (not side-effects?_0)
                                  (let-values () (loop_5 (cdr l_10) new-procs_0 new-structs_0 (cons v_14 accum_0) #t))
                                  (let-values ()
                                    (let-values (((schemify_0)
                                                  (make-schemify
                                                   new-procs_0
                                                   new-structs_0
                                                   mutated_0
                                                   imports_7
                                                   exports_5)))
                                      (append
                                       (map2 schemify_0 (reverse$1 accum_0))
                                       (make-set-variables accum_0 exports_5)
                                       (list (schemify_0 v_14))
                                       (make-set-variables (list v_14) exports_5)
                                       (loop_5 (cdr l_10) new-procs_0 new-structs_0 null defn?_0)))))))))))
         loop_5)
       l_9
       init-procs_1
       (hasheq)
       null
       #f))))
 (define-values
  (lambda?)
  (lambda (v_15)
    (let-values (((v_16) v_15))
      (if (if (pair? v_16)
            (if (let-values (((a_3) (car v_16))) (equal? 'lambda a_3)) (let-values (((d_0) (cdr v_16))) #t) #f)
            #f)
        (let-values () #t)
        (if (if (pair? v_16)
              (if (let-values (((a_4) (car v_16))) (equal? 'case-lambda a_4)) (let-values (((d_1) (cdr v_16))) #t) #f)
              #f)
          (let-values () #t)
          (if (if (pair? v_16)
                (if (let-values (((a_5) (car v_16))) (equal? 'let-values a_5))
                  (let-values (((d_2) (cdr v_16)))
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
                          (let-values (((d_9) (cdr v_16)))
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
            (if (if (pair? v_16)
                  (if (let-values (((a_18) (car v_16))) (equal? 'letrec-values a_18))
                    (let-values (((d_12) (cdr v_16)))
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
                            (let-values (((d_19) (cdr v_16)))
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
              (if (if (pair? v_16)
                    (if (let-values (((a_31) (car v_16))) (equal? 'let-values a_31))
                      (let-values (((d_22) (cdr v_16)))
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
                              (let-values (((d_25) (cdr v_16)))
                                (let-values (((d_26) (cdr d_25))) (let-values (((a_34) (car d_26))) a_34)))))
                  (lambda? body_0))
                (if (if (pair? v_16)
                      (if (let-values (((a_35) (car v_16))) (equal? 'letrec-values a_35))
                        (let-values (((d_27) (cdr v_16)))
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
                                (let-values (((d_30) (cdr v_16)))
                                  (let-values (((d_31) (cdr d_30))) (let-values (((a_38) (car d_31))) a_38)))))
                    (lambda? body_1))
                  (let-values () #f))))))))))
 (define-values
  (simple?)
  (lambda (e_0 mutated_1)
    (let-values (((v_17) e_0))
      (if (if (pair? v_17)
            (if (let-values (((a_39) (car v_17))) (equal? 'lambda a_39)) (let-values (((d_32) (cdr v_17))) #t) #f)
            #f)
        (let-values () #t)
        (if (if (pair? v_17)
              (if (let-values (((a_40) (car v_17))) (equal? 'case-lambda a_40))
                (let-values (((d_33) (cdr v_17))) #t)
                #f)
              #f)
          (let-values () #t)
          (if (if (pair? v_17)
                (if (let-values (((a_41) (car v_17))) (equal? 'quote a_41)) (let-values (((d_34) (cdr v_17))) #t) #f)
                #f)
            (let-values () #t)
            (if (if (pair? v_17)
                  (if (let-values (((a_42) (car v_17))) (equal? '#%variable-reference a_42))
                    (let-values (((d_35) (cdr v_17))) #t)
                    #f)
                  #f)
              (let-values () #t)
              (if (if (pair? v_17)
                    (if (let-values (((a_43) (car v_17))) (equal? 'let-values a_43))
                      (let-values (((d_36) (cdr v_17)))
                        (if (pair? d_36)
                          (if (let-values (((a_44) (car d_36)))
                                (if (list? a_44)
                                  (let-values (((lst_12) a_44))
                                    (begin
                                      (check-list lst_12)
                                      ((letrec-values (((for-loop_6)
                                                        (lambda (result_2 lst_13)
                                                          (if (pair? lst_13)
                                                            (let-values (((v_18) (unsafe-car lst_13))
                                                                         ((rest_6) (unsafe-cdr lst_13)))
                                                              (let-values (((result_3)
                                                                            (let-values ()
                                                                              (let-values (((result_4)
                                                                                            (let-values ()
                                                                                              (let-values ()
                                                                                                (if (pair? v_18)
                                                                                                  (if (let-values (((a_45)
                                                                                                                    (car
                                                                                                                     v_18)))
                                                                                                        #t)
                                                                                                    (let-values (((d_37)
                                                                                                                  (cdr
                                                                                                                   v_18)))
                                                                                                      (if (pair? d_37)
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
                                                                                (values result_4)))))
                                                                (if (if (not ((lambda x_0 (not result_3)) v_18))
                                                                      (not #f)
                                                                      #f)
                                                                  (for-loop_6 result_3 rest_6)
                                                                  result_3)))
                                                            result_2))))
                                         for-loop_6)
                                       #t
                                       lst_12)))
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
                              (let-values (((d_41) (cdr v_17)))
                                (let-values (((rhss_1)
                                              (let-values (((a_48) (car d_41)))
                                                (let-values (((rhss_2)
                                                              (let-values (((lst_14) a_48))
                                                                (begin
                                                                  (check-list lst_14)
                                                                  ((letrec-values (((for-loop_7)
                                                                                    (lambda (rhss_3 lst_15)
                                                                                      (if (pair? lst_15)
                                                                                        (let-values (((v_19)
                                                                                                      (unsafe-car
                                                                                                       lst_15))
                                                                                                     ((rest_7)
                                                                                                      (unsafe-cdr
                                                                                                       lst_15)))
                                                                                          (let-values (((rhss_4)
                                                                                                        (let-values (((rhss_5)
                                                                                                                      rhss_3))
                                                                                                          (let-values (((rhss_6)
                                                                                                                        (let-values ()
                                                                                                                          (let-values (((rhss2_0)
                                                                                                                                        (let-values ()
                                                                                                                                          (let-values (((d_42)
                                                                                                                                                        (cdr
                                                                                                                                                         v_19)))
                                                                                                                                            (let-values (((a_49)
                                                                                                                                                          (car
                                                                                                                                                           d_42)))
                                                                                                                                              a_49)))))
                                                                                                                            (cons
                                                                                                                             rhss2_0
                                                                                                                             rhss_5)))))
                                                                                                            (values
                                                                                                             rhss_6)))))
                                                                                            (if (not #f)
                                                                                              (for-loop_7 rhss_4 rest_7)
                                                                                              rhss_4)))
                                                                                        rhss_3))))
                                                                     for-loop_7)
                                                                   null
                                                                   lst_14)))))
                                                  (reverse$1 rhss_2))))
                                             ((body_3)
                                              (let-values (((d_43) (cdr d_41)))
                                                (let-values (((a_50) (car d_43))) a_50))))
                                  (values rhss_1 body_3)))))
                  (if (let-values (((lst_16) rhss_0))
                        (begin
                          (check-list lst_16)
                          ((letrec-values (((for-loop_8)
                                            (lambda (result_5 lst_17)
                                              (if (pair? lst_17)
                                                (let-values (((rhs_6) (unsafe-car lst_17))
                                                             ((rest_8) (unsafe-cdr lst_17)))
                                                  (let-values (((result_6)
                                                                (let-values ()
                                                                  (let-values (((result_7)
                                                                                (let-values ()
                                                                                  (let-values ()
                                                                                    (simple? rhss_0 mutated_1)))))
                                                                    (values result_7)))))
                                                    (if (if (not ((lambda x_1 (not result_6)) rhs_6)) (not #f) #f)
                                                      (for-loop_8 result_6 rest_8)
                                                      result_6)))
                                                result_5))))
                             for-loop_8)
                           #t
                           lst_16)))
                    (simple? body_2 mutated_1)
                    #f))
                (if (if (pair? v_17)
                      (if (let-values (((a_51) (car v_17))) (equal? 'let a_51))
                        (let-values (((d_44) (cdr v_17)))
                          (if (pair? d_44)
                            (if (let-values (((a_52) (car d_44)))
                                  (if (list? a_52)
                                    (let-values (((lst_18) a_52))
                                      (begin
                                        (check-list lst_18)
                                        ((letrec-values (((for-loop_9)
                                                          (lambda (result_8 lst_19)
                                                            (if (pair? lst_19)
                                                              (let-values (((v_20) (unsafe-car lst_19))
                                                                           ((rest_9) (unsafe-cdr lst_19)))
                                                                (let-values (((result_9)
                                                                              (let-values ()
                                                                                (let-values (((result_10)
                                                                                              (let-values ()
                                                                                                (let-values ()
                                                                                                  (if (pair? v_20)
                                                                                                    (if (let-values (((a_53)
                                                                                                                      (car
                                                                                                                       v_20)))
                                                                                                          #t)
                                                                                                      (let-values (((d_45)
                                                                                                                    (cdr
                                                                                                                     v_20)))
                                                                                                        (if (pair? d_45)
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
                                                                                  (values result_10)))))
                                                                  (if (if (not ((lambda x_2 (not result_9)) v_20))
                                                                        (not #f)
                                                                        #f)
                                                                    (for-loop_9 result_9 rest_9)
                                                                    result_9)))
                                                              result_8))))
                                           for-loop_9)
                                         #t
                                         lst_18)))
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
                                (let-values (((d_49) (cdr v_17)))
                                  (let-values (((rhss_8)
                                                (let-values (((a_56) (car d_49)))
                                                  (let-values (((rhss_9)
                                                                (let-values (((lst_20) a_56))
                                                                  (begin
                                                                    (check-list lst_20)
                                                                    ((letrec-values (((for-loop_10)
                                                                                      (lambda (rhss_10 lst_21)
                                                                                        (if (pair? lst_21)
                                                                                          (let-values (((v_21)
                                                                                                        (unsafe-car
                                                                                                         lst_21))
                                                                                                       ((rest_10)
                                                                                                        (unsafe-cdr
                                                                                                         lst_21)))
                                                                                            (let-values (((rhss_11)
                                                                                                          (let-values (((rhss_12)
                                                                                                                        rhss_10))
                                                                                                            (let-values (((rhss_13)
                                                                                                                          (let-values ()
                                                                                                                            (let-values (((rhss3_0)
                                                                                                                                          (let-values ()
                                                                                                                                            (let-values (((d_50)
                                                                                                                                                          (cdr
                                                                                                                                                           v_21)))
                                                                                                                                              (let-values (((a_57)
                                                                                                                                                            (car
                                                                                                                                                             d_50)))
                                                                                                                                                a_57)))))
                                                                                                                              (cons
                                                                                                                               rhss3_0
                                                                                                                               rhss_12)))))
                                                                                                              (values
                                                                                                               rhss_13)))))
                                                                                              (if (not #f)
                                                                                                (for-loop_10
                                                                                                 rhss_11
                                                                                                 rest_10)
                                                                                                rhss_11)))
                                                                                          rhss_10))))
                                                                       for-loop_10)
                                                                     null
                                                                     lst_20)))))
                                                    (reverse$1 rhss_9))))
                                               ((body_5)
                                                (let-values (((d_51) (cdr d_49)))
                                                  (let-values (((a_58) (car d_51))) a_58))))
                                    (values rhss_8 body_5)))))
                    (if (let-values (((lst_22) rhss_7))
                          (begin
                            (check-list lst_22)
                            ((letrec-values (((for-loop_11)
                                              (lambda (result_11 lst_23)
                                                (if (pair? lst_23)
                                                  (let-values (((rhs_7) (unsafe-car lst_23))
                                                               ((rest_11) (unsafe-cdr lst_23)))
                                                    (let-values (((result_12)
                                                                  (let-values ()
                                                                    (let-values (((result_13)
                                                                                  (let-values ()
                                                                                    (let-values ()
                                                                                      (simple? rhss_7 mutated_1)))))
                                                                      (values result_13)))))
                                                      (if (if (not ((lambda x_3 (not result_12)) rhs_7)) (not #f) #f)
                                                        (for-loop_11 result_12 rest_11)
                                                        result_12)))
                                                  result_11))))
                               for-loop_11)
                             #t
                             lst_22)))
                      (simple? body_4 mutated_1)
                      #f))
                  (if (if (pair? v_17)
                        (if (let-values (((a_59) (car v_17))) (equal? 'letrec-values a_59))
                          (let-values (((d_52) (cdr v_17)))
                            (if (pair? d_52)
                              (if (let-values (((a_60) (car d_52)))
                                    (if (list? a_60)
                                      (let-values (((lst_24) a_60))
                                        (begin
                                          (check-list lst_24)
                                          ((letrec-values (((for-loop_12)
                                                            (lambda (result_14 lst_25)
                                                              (if (pair? lst_25)
                                                                (let-values (((v_22) (unsafe-car lst_25))
                                                                             ((rest_12) (unsafe-cdr lst_25)))
                                                                  (let-values (((result_15)
                                                                                (let-values ()
                                                                                  (let-values (((result_16)
                                                                                                (let-values ()
                                                                                                  (let-values ()
                                                                                                    (if (pair? v_22)
                                                                                                      (if (let-values (((a_61)
                                                                                                                        (car
                                                                                                                         v_22)))
                                                                                                            (list?
                                                                                                             a_61))
                                                                                                        (let-values (((d_53)
                                                                                                                      (cdr
                                                                                                                       v_22)))
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
                                                                                    (values result_16)))))
                                                                    (if (if (not ((lambda x_4 (not result_15)) v_22))
                                                                          (not #f)
                                                                          #f)
                                                                      (for-loop_12 result_15 rest_12)
                                                                      result_15)))
                                                                result_14))))
                                             for-loop_12)
                                           #t
                                           lst_24)))
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
                                  (let-values (((d_57) (cdr v_17)))
                                    (let-values (((idss_1 rhss_15)
                                                  (let-values (((a_64) (car d_57)))
                                                    (let-values (((idss_2 rhss_16)
                                                                  (let-values (((lst_26) a_64))
                                                                    (begin
                                                                      (check-list lst_26)
                                                                      ((letrec-values (((for-loop_13)
                                                                                        (lambda (idss_3 rhss_17 lst_27)
                                                                                          (if (pair? lst_27)
                                                                                            (let-values (((v_23)
                                                                                                          (unsafe-car
                                                                                                           lst_27))
                                                                                                         ((rest_13)
                                                                                                          (unsafe-cdr
                                                                                                           lst_27)))
                                                                                              (let-values (((idss_4
                                                                                                             rhss_18)
                                                                                                            (let-values (((idss_5)
                                                                                                                          idss_3)
                                                                                                                         ((rhss_19)
                                                                                                                          rhss_17))
                                                                                                              (let-values (((idss_6
                                                                                                                             rhss_20)
                                                                                                                            (let-values ()
                                                                                                                              (let-values (((idss4_0
                                                                                                                                             rhss5_0)
                                                                                                                                            (let-values ()
                                                                                                                                              (let-values (((idss_7)
                                                                                                                                                            (let-values (((a_65)
                                                                                                                                                                          (car
                                                                                                                                                                           v_23)))
                                                                                                                                                              a_65))
                                                                                                                                                           ((rhss_21)
                                                                                                                                                            (let-values (((d_58)
                                                                                                                                                                          (cdr
                                                                                                                                                                           v_23)))
                                                                                                                                                              (let-values (((a_66)
                                                                                                                                                                            (car
                                                                                                                                                                             d_58)))
                                                                                                                                                                a_66))))
                                                                                                                                                (values
                                                                                                                                                 idss_7
                                                                                                                                                 rhss_21)))))
                                                                                                                                (values
                                                                                                                                 (cons
                                                                                                                                  idss4_0
                                                                                                                                  idss_5)
                                                                                                                                 (cons
                                                                                                                                  rhss5_0
                                                                                                                                  rhss_19))))))
                                                                                                                (values
                                                                                                                 idss_6
                                                                                                                 rhss_20)))))
                                                                                                (if (not #f)
                                                                                                  (for-loop_13
                                                                                                   idss_4
                                                                                                   rhss_18
                                                                                                   rest_13)
                                                                                                  (values
                                                                                                   idss_4
                                                                                                   rhss_18))))
                                                                                            (values idss_3 rhss_17)))))
                                                                         for-loop_13)
                                                                       null
                                                                       null
                                                                       lst_26)))))
                                                      (values (reverse$1 idss_2) (reverse$1 rhss_16)))))
                                                 ((body_7)
                                                  (let-values (((d_59) (cdr d_57)))
                                                    (let-values (((a_67) (car d_59))) a_67))))
                                      (values idss_1 rhss_15 body_7)))))
                      (let-values (((mutated+idss_0)
                                    (let-values (((lst_28) idss_0))
                                      (begin
                                        (check-list lst_28)
                                        ((letrec-values (((for-loop_14)
                                                          (lambda (mutated_2 lst_29)
                                                            (if (pair? lst_29)
                                                              (let-values (((ids_0) (unsafe-car lst_29))
                                                                           ((rest_14) (unsafe-cdr lst_29)))
                                                                (let-values (((mutated_3)
                                                                              (let-values (((lst_30) ids_0))
                                                                                (begin
                                                                                  (check-list lst_30)
                                                                                  ((letrec-values (((for-loop_15)
                                                                                                    (lambda (mutated_4
                                                                                                             lst_31)
                                                                                                      (if (pair? lst_31)
                                                                                                        (let-values (((id_2)
                                                                                                                      (unsafe-car
                                                                                                                       lst_31))
                                                                                                                     ((rest_15)
                                                                                                                      (unsafe-cdr
                                                                                                                       lst_31)))
                                                                                                          (let-values (((mutated_5)
                                                                                                                        (let-values (((mutated_6)
                                                                                                                                      mutated_4))
                                                                                                                          (let-values (((mutated_7)
                                                                                                                                        (let-values ()
                                                                                                                                          (hash-set
                                                                                                                                           mutated_6
                                                                                                                                           id_2
                                                                                                                                           #t))))
                                                                                                                            (values
                                                                                                                             mutated_7)))))
                                                                                                            (if (not #f)
                                                                                                              (for-loop_15
                                                                                                               mutated_5
                                                                                                               rest_15)
                                                                                                              mutated_5)))
                                                                                                        mutated_4))))
                                                                                     for-loop_15)
                                                                                   mutated_2
                                                                                   lst_30)))))
                                                                  (if (not #f)
                                                                    (for-loop_14 mutated_3 rest_14)
                                                                    mutated_3)))
                                                              mutated_2))))
                                           for-loop_14)
                                         mutated_1
                                         lst_28)))))
                        (if (let-values (((lst_32) rhss_14))
                              (begin
                                (check-list lst_32)
                                ((letrec-values (((for-loop_16)
                                                  (lambda (result_17 lst_33)
                                                    (if (pair? lst_33)
                                                      (let-values (((rhs_8) (unsafe-car lst_33))
                                                                   ((rest_16) (unsafe-cdr lst_33)))
                                                        (let-values (((result_18)
                                                                      (let-values ()
                                                                        (let-values (((result_19)
                                                                                      (let-values ()
                                                                                        (let-values ()
                                                                                          (simple?
                                                                                           rhs_8
                                                                                           mutated+idss_0)))))
                                                                          (values result_19)))))
                                                          (if (if (not ((lambda x_5 (not result_18)) rhs_8))
                                                                (not #f)
                                                                #f)
                                                            (for-loop_16 result_18 rest_16)
                                                            result_18)))
                                                      result_17))))
                                   for-loop_16)
                                 #t
                                 lst_32)))
                          (simple? body_6 mutated_1)
                          #f)))
                    (if (if (pair? v_17)
                          (if (let-values (((a_68) (car v_17))) (equal? 'letrec* a_68))
                            (let-values (((d_60) (cdr v_17)))
                              (if (pair? d_60)
                                (if (let-values (((a_69) (car d_60)))
                                      (if (list? a_69)
                                        (let-values (((lst_34) a_69))
                                          (begin
                                            (check-list lst_34)
                                            ((letrec-values (((for-loop_17)
                                                              (lambda (result_20 lst_35)
                                                                (if (pair? lst_35)
                                                                  (let-values (((v_24) (unsafe-car lst_35))
                                                                               ((rest_17) (unsafe-cdr lst_35)))
                                                                    (let-values (((result_21)
                                                                                  (let-values ()
                                                                                    (let-values (((result_22)
                                                                                                  (let-values ()
                                                                                                    (let-values ()
                                                                                                      (if (pair? v_24)
                                                                                                        (if (let-values (((a_70)
                                                                                                                          (car
                                                                                                                           v_24)))
                                                                                                              #t)
                                                                                                          (let-values (((d_61)
                                                                                                                        (cdr
                                                                                                                         v_24)))
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
                                                                                      (values result_22)))))
                                                                      (if (if (not ((lambda x_6 (not result_21)) v_24))
                                                                            (not #f)
                                                                            #f)
                                                                        (for-loop_17 result_21 rest_17)
                                                                        result_21)))
                                                                  result_20))))
                                               for-loop_17)
                                             #t
                                             lst_34)))
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
                                    (let-values (((d_65) (cdr v_17)))
                                      (let-values (((ids_2 rhss_23)
                                                    (let-values (((a_73) (car d_65)))
                                                      (let-values (((ids_3 rhss_24)
                                                                    (let-values (((lst_36) a_73))
                                                                      (begin
                                                                        (check-list lst_36)
                                                                        ((letrec-values (((for-loop_18)
                                                                                          (lambda (ids_4 rhss_25 lst_37)
                                                                                            (if (pair? lst_37)
                                                                                              (let-values (((v_25)
                                                                                                            (unsafe-car
                                                                                                             lst_37))
                                                                                                           ((rest_18)
                                                                                                            (unsafe-cdr
                                                                                                             lst_37)))
                                                                                                (let-values (((ids_5
                                                                                                               rhss_26)
                                                                                                              (let-values (((ids_6)
                                                                                                                            ids_4)
                                                                                                                           ((rhss_27)
                                                                                                                            rhss_25))
                                                                                                                (let-values (((ids_7
                                                                                                                               rhss_28)
                                                                                                                              (let-values ()
                                                                                                                                (let-values (((ids6_0
                                                                                                                                               rhss7_0)
                                                                                                                                              (let-values ()
                                                                                                                                                (let-values (((ids_8)
                                                                                                                                                              (let-values (((a_74)
                                                                                                                                                                            (car
                                                                                                                                                                             v_25)))
                                                                                                                                                                a_74))
                                                                                                                                                             ((rhss_29)
                                                                                                                                                              (let-values (((d_66)
                                                                                                                                                                            (cdr
                                                                                                                                                                             v_25)))
                                                                                                                                                                (let-values (((a_75)
                                                                                                                                                                              (car
                                                                                                                                                                               d_66)))
                                                                                                                                                                  a_75))))
                                                                                                                                                  (values
                                                                                                                                                   ids_8
                                                                                                                                                   rhss_29)))))
                                                                                                                                  (values
                                                                                                                                   (cons
                                                                                                                                    ids6_0
                                                                                                                                    ids_6)
                                                                                                                                   (cons
                                                                                                                                    rhss7_0
                                                                                                                                    rhss_27))))))
                                                                                                                  (values
                                                                                                                   ids_7
                                                                                                                   rhss_28)))))
                                                                                                  (if (not #f)
                                                                                                    (for-loop_18
                                                                                                     ids_5
                                                                                                     rhss_26
                                                                                                     rest_18)
                                                                                                    (values
                                                                                                     ids_5
                                                                                                     rhss_26))))
                                                                                              (values ids_4 rhss_25)))))
                                                                           for-loop_18)
                                                                         null
                                                                         null
                                                                         lst_36)))))
                                                        (values (reverse$1 ids_3) (reverse$1 rhss_24)))))
                                                   ((body_9)
                                                    (let-values (((d_67) (cdr d_65)))
                                                      (let-values (((a_76) (car d_67))) a_76))))
                                        (values ids_2 rhss_23 body_9)))))
                        (let-values (((mutated+ids_0)
                                      (let-values (((lst_38) ids_1))
                                        (begin
                                          (check-list lst_38)
                                          ((letrec-values (((for-loop_19)
                                                            (lambda (mutated_8 lst_39)
                                                              (if (pair? lst_39)
                                                                (let-values (((id_3) (unsafe-car lst_39))
                                                                             ((rest_19) (unsafe-cdr lst_39)))
                                                                  (let-values (((mutated_9)
                                                                                (let-values (((mutated_10) mutated_8))
                                                                                  (let-values (((mutated_11)
                                                                                                (let-values ()
                                                                                                  (hash-set
                                                                                                   mutated_10
                                                                                                   id_3
                                                                                                   #t))))
                                                                                    (values mutated_11)))))
                                                                    (if (not #f)
                                                                      (for-loop_19 mutated_9 rest_19)
                                                                      mutated_9)))
                                                                mutated_8))))
                                             for-loop_19)
                                           mutated_1
                                           lst_38)))))
                          (if (let-values (((lst_40) rhss_22))
                                (begin
                                  (check-list lst_40)
                                  ((letrec-values (((for-loop_20)
                                                    (lambda (result_23 lst_41)
                                                      (if (pair? lst_41)
                                                        (let-values (((rhs_9) (unsafe-car lst_41))
                                                                     ((rest_20) (unsafe-cdr lst_41)))
                                                          (let-values (((result_24)
                                                                        (let-values ()
                                                                          (let-values (((result_25)
                                                                                        (let-values ()
                                                                                          (let-values ()
                                                                                            (simple?
                                                                                             rhs_9
                                                                                             mutated+ids_0)))))
                                                                            (values result_25)))))
                                                            (if (if (not ((lambda x_7 (not result_24)) rhs_9))
                                                                  (not #f)
                                                                  #f)
                                                              (for-loop_20 result_24 rest_20)
                                                              result_24)))
                                                        result_23))))
                                     for-loop_20)
                                   #t
                                   lst_40)))
                            (simple? body_8 mutated_1)
                            #f)))
                      (let-values ()
                        (let-values (((or-part_0) (if (symbol? e_0) (not (hash-ref mutated_1 e_0 #f)) #f)))
                          (if or-part_0
                            or-part_0
                            (let-values (((or-part_1) (integer? e_0)))
                              (if or-part_1
                                or-part_1
                                (let-values (((or-part_2) (boolean? e_0)))
                                  (if or-part_2
                                    or-part_2
                                    (let-values (((or-part_3) (string? e_0)))
                                      (if or-part_3
                                        or-part_3
                                        (let-values (((or-part_4) (bytes? e_0)))
                                          (if or-part_4 or-part_4 (regexp? e_0)))))))))))))))))))))))
 (define-values
  (struct:struct-type-info
   struct-type-info1.1
   struct-type-info?
   struct-type-info-name
   struct-type-info-parent
   struct-type-info-field-count
   struct-type-info-rest)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'struct-type-info
                     #f
                     4
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '(0 1 2 3)
                     #f
                     'struct-type-info)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'name)
     (make-struct-field-accessor -ref_0 1 'parent)
     (make-struct-field-accessor -ref_0 2 'field-count)
     (make-struct-field-accessor -ref_0 3 'rest))))
 (define-values
  (make-struct-type-info)
  (lambda (v_26 structs_1)
    (let-values (((v_27) v_26))
      (if (if (pair? v_27)
            (if (let-values (((a_77) (car v_27))) (equal? 'make-struct-type a_77))
              (let-values (((d_68) (cdr v_27)))
                (if (pair? d_68)
                  (if (let-values (((a_78) (car d_68)))
                        (if (pair? a_78)
                          (if (let-values (((a_79) (car a_78))) (equal? 'quote a_79))
                            (let-values (((d_69) (cdr a_78)))
                              (if (pair? d_69)
                                (if (let-values (((a_80) (car d_69))) #t)
                                  (let-values (((d_70) (cdr d_69))) (equal? '() d_70))
                                  #f)
                                #f))
                            #f)
                          #f))
                    (let-values (((d_71) (cdr d_68)))
                      (if (pair? d_71)
                        (if (let-values (((a_81) (car d_71))) #t)
                          (let-values (((d_72) (cdr d_71)))
                            (if (pair? d_72)
                              (if (let-values (((a_82) (car d_72))) #t)
                                (let-values (((d_73) (cdr d_72)))
                                  (if (pair? d_73)
                                    (if (let-values (((a_83) (car d_73))) (equal? 0 a_83))
                                      (let-values (((d_74) (cdr d_73)))
                                        (if (pair? d_74)
                                          (if (let-values (((a_84) (car d_74))) (equal? #f a_84))
                                            (let-values (((d_75) (cdr d_74))) #t)
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
        (let-values (((name_0 parent_0 fields_0 rest_21)
                      (let-values (((d_76) (cdr v_27)))
                        (let-values (((name_1)
                                      (let-values (((a_85) (car d_76)))
                                        (let-values (((d_77) (cdr a_85))) (let-values (((a_86) (car d_77))) a_86))))
                                     ((parent_1 fields_1 rest_22)
                                      (let-values (((d_78) (cdr d_76)))
                                        (let-values (((parent_2) (let-values (((a_87) (car d_78))) a_87))
                                                     ((fields_2 rest_23)
                                                      (let-values (((d_79) (cdr d_78)))
                                                        (let-values (((fields_3)
                                                                      (let-values (((a_88) (car d_79))) a_88))
                                                                     ((rest_24)
                                                                      (let-values (((d_80) (cdr d_79)))
                                                                        (let-values (((d_81) (cdr d_80)))
                                                                          (let-values (((d_82) (cdr d_81))) d_82)))))
                                                          (values fields_3 rest_24)))))
                                          (values parent_2 fields_2 rest_23)))))
                          (values name_1 parent_1 fields_1 rest_22)))))
          (if (symbol? name_0)
            (if (let-values (((or-part_5) (not parent_0))) (if or-part_5 or-part_5 (hash-ref structs_1 parent_0 #f)))
              (if (exact-nonnegative-integer? fields_0) (struct-type-info1.1 name_0 parent_0 fields_0 rest_21) #f)
              #f)
            #f))
        (if (if (pair? v_27)
              (if (let-values (((a_89) (car v_27))) (equal? 'let-values a_89))
                (let-values (((d_83) (cdr v_27)))
                  (if (pair? d_83)
                    (if (let-values (((a_90) (car d_83))) (equal? '() a_90))
                      (let-values (((d_84) (cdr d_83)))
                        (if (pair? d_84)
                          (if (let-values (((a_91) (car d_84))) #t)
                            (let-values (((d_85) (cdr d_84))) (equal? '() d_85))
                            #f)
                          #f))
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((body_10)
                        (let-values (((d_86) (cdr v_27)))
                          (let-values (((d_87) (cdr d_86))) (let-values (((a_92) (car d_87))) a_92)))))
            (make-struct-type-info body_10 structs_1))
          (let-values () #f))))))
 (define-values
  (find-definitions)
  (lambda (v_28 procs_1 structs_2 last?_0)
    (let-values (((v_29) v_28))
      (if (if (pair? v_29)
            (if (let-values (((a_93) (car v_29))) (equal? 'define-values a_93))
              (let-values (((d_88) (cdr v_29)))
                (if (pair? d_88)
                  (if (let-values (((a_94) (car d_88)))
                        (if (pair? a_94)
                          (if (let-values (((a_95) (car a_94))) #t)
                            (let-values (((d_89) (cdr a_94))) (equal? '() d_89))
                            #f)
                          #f))
                    (let-values (((d_90) (cdr d_88)))
                      (if (pair? d_90)
                        (if (let-values (((a_96) (car d_90))) #t)
                          (let-values (((d_91) (cdr d_90))) (equal? '() d_91))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((id_4 rhs_10)
                      (let-values (((d_92) (cdr v_29)))
                        (let-values (((id_5) (let-values (((a_97) (car d_92))) (let-values (((a_98) (car a_97))) a_98)))
                                     ((rhs_11)
                                      (let-values (((d_93) (cdr d_92))) (let-values (((a_99) (car d_93))) a_99))))
                          (values id_5 rhs_11)))))
          (if (lambda? rhs_10)
            (values v_28 (hash-set procs_1 id_4 #t) structs_2 #f #t)
            (values v_28 procs_1 structs_2 #t #t)))
        (if (if (pair? v_29)
              (if (let-values (((a_100) (car v_29))) (equal? 'define-values a_100))
                (let-values (((d_94) (cdr v_29)))
                  (if (pair? d_94)
                    (if (let-values (((a_101) (car d_94)))
                          (if (pair? a_101)
                            (if (let-values (((a_102) (car a_101))) #t)
                              (let-values (((d_95) (cdr a_101)))
                                (if (pair? d_95)
                                  (if (let-values (((a_103) (car d_95))) #t)
                                    (let-values (((d_96) (cdr d_95)))
                                      (if (pair? d_96)
                                        (if (let-values (((a_104) (car d_96))) #t)
                                          (let-values (((d_97) (cdr d_96))) (list? d_97))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                              #f)
                            #f))
                      (let-values (((d_98) (cdr d_94)))
                        (if (pair? d_98)
                          (if (let-values (((a_105) (car d_98)))
                                (if (pair? a_105)
                                  (if (let-values (((a_106) (car a_105))) (equal? 'let-values a_106))
                                    (let-values (((d_99) (cdr a_105)))
                                      (if (pair? d_99)
                                        (if (let-values (((a_107) (car d_99)))
                                              (if (pair? a_107)
                                                (if (let-values (((a_108) (car a_107)))
                                                      (if (pair? a_108)
                                                        (if (let-values (((a_109) (car a_108)))
                                                              (if (pair? a_109)
                                                                (if (let-values (((a_110) (car a_109))) #t)
                                                                  (let-values (((d_100) (cdr a_109)))
                                                                    (if (pair? d_100)
                                                                      (if (let-values (((a_111) (car d_100))) #t)
                                                                        (let-values (((d_101) (cdr d_100)))
                                                                          (if (pair? d_101)
                                                                            (if (let-values (((a_112) (car d_101))) #t)
                                                                              (let-values (((d_102) (cdr d_101)))
                                                                                (if (pair? d_102)
                                                                                  (if (let-values (((a_113)
                                                                                                    (car d_102)))
                                                                                        #t)
                                                                                    (let-values (((d_103) (cdr d_102)))
                                                                                      (if (pair? d_103)
                                                                                        (if (let-values (((a_114)
                                                                                                          (car d_103)))
                                                                                              #t)
                                                                                          (let-values (((d_104)
                                                                                                        (cdr d_103)))
                                                                                            (equal? '() d_104))
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
                                                          (let-values (((d_105) (cdr a_108)))
                                                            (if (pair? d_105)
                                                              (if (let-values (((a_115) (car d_105))) #t)
                                                                (let-values (((d_106) (cdr d_105))) (equal? '() d_106))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f))
                                                  (let-values (((d_107) (cdr a_107))) (equal? '() d_107))
                                                  #f)
                                                #f))
                                          (let-values (((d_108) (cdr d_99)))
                                            (if (pair? d_108)
                                              (if (let-values (((a_116) (car d_108)))
                                                    (if (pair? a_116)
                                                      (if (let-values (((a_117) (car a_116))) (equal? 'values a_117))
                                                        (let-values (((d_109) (cdr a_116)))
                                                          (if (pair? d_109)
                                                            (if (let-values (((a_118) (car d_109))) #t)
                                                              (let-values (((d_110) (cdr d_109)))
                                                                (if (pair? d_110)
                                                                  (if (let-values (((a_119) (car d_110))) #t)
                                                                    (let-values (((d_111) (cdr d_110)))
                                                                      (if (pair? d_111)
                                                                        (if (let-values (((a_120) (car d_111))) #t)
                                                                          (let-values (((d_112) (cdr d_111)))
                                                                            (list? d_112))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f))
                                                (let-values (((d_113) (cdr d_108))) (equal? '() d_113))
                                                #f)
                                              #f))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_114) (cdr d_98))) (equal? '() d_114))
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
                         struct:_1
                         make_0
                         ?_1
                         -ref_1
                         -set!_1
                         rhs_12
                         struct:2_0
                         make2_0
                         ?2_0
                         make-acc/muts_0)
                        (let-values (((d_115) (cdr v_29)))
                          (let-values (((struct:s_1 make-s_1 s?_1 acc/muts_1)
                                        (let-values (((a_121) (car d_115)))
                                          (let-values (((struct:s_2) (let-values (((a_122) (car a_121))) a_122))
                                                       ((make-s_2 s?_2 acc/muts_2)
                                                        (let-values (((d_116) (cdr a_121)))
                                                          (let-values (((make-s_3)
                                                                        (let-values (((a_123) (car d_116))) a_123))
                                                                       ((s?_3 acc/muts_3)
                                                                        (let-values (((d_117) (cdr d_116)))
                                                                          (let-values (((s?_4)
                                                                                        (let-values (((a_124)
                                                                                                      (car d_117)))
                                                                                          a_124))
                                                                                       ((acc/muts_4)
                                                                                        (let-values (((d_118)
                                                                                                      (cdr d_117)))
                                                                                          d_118)))
                                                                            (values s?_4 acc/muts_4)))))
                                                            (values make-s_3 s?_3 acc/muts_3)))))
                                            (values struct:s_2 make-s_2 s?_2 acc/muts_2))))
                                       ((struct:_2
                                         make_1
                                         ?_2
                                         -ref_2
                                         -set!_2
                                         rhs_13
                                         struct:2_1
                                         make2_1
                                         ?2_1
                                         make-acc/muts_1)
                                        (let-values (((d_119) (cdr d_115)))
                                          (let-values (((a_125) (car d_119)))
                                            (let-values (((d_120) (cdr a_125)))
                                              (let-values (((struct:_3 make_2 ?_3 -ref_3 -set!_3 rhs_14)
                                                            (let-values (((a_126) (car d_120)))
                                                              (let-values (((a_127) (car a_126)))
                                                                (let-values (((struct:_4 make_3 ?_4 -ref_4 -set!_4)
                                                                              (let-values (((a_128) (car a_127)))
                                                                                (let-values (((struct:_5)
                                                                                              (let-values (((a_129)
                                                                                                            (car
                                                                                                             a_128)))
                                                                                                a_129))
                                                                                             ((make_4
                                                                                               ?_5
                                                                                               -ref_5
                                                                                               -set!_5)
                                                                                              (let-values (((d_121)
                                                                                                            (cdr
                                                                                                             a_128)))
                                                                                                (let-values (((make_5)
                                                                                                              (let-values (((a_130)
                                                                                                                            (car
                                                                                                                             d_121)))
                                                                                                                a_130))
                                                                                                             ((?_6
                                                                                                               -ref_6
                                                                                                               -set!_6)
                                                                                                              (let-values (((d_122)
                                                                                                                            (cdr
                                                                                                                             d_121)))
                                                                                                                (let-values (((?_7)
                                                                                                                              (let-values (((a_131)
                                                                                                                                            (car
                                                                                                                                             d_122)))
                                                                                                                                a_131))
                                                                                                                             ((-ref_7
                                                                                                                               -set!_7)
                                                                                                                              (let-values (((d_123)
                                                                                                                                            (cdr
                                                                                                                                             d_122)))
                                                                                                                                (let-values (((-ref_8)
                                                                                                                                              (let-values (((a_132)
                                                                                                                                                            (car
                                                                                                                                                             d_123)))
                                                                                                                                                a_132))
                                                                                                                                             ((-set!_8)
                                                                                                                                              (let-values (((d_124)
                                                                                                                                                            (cdr
                                                                                                                                                             d_123)))
                                                                                                                                                (let-values (((a_133)
                                                                                                                                                              (car
                                                                                                                                                               d_124)))
                                                                                                                                                  a_133))))
                                                                                                                                  (values
                                                                                                                                   -ref_8
                                                                                                                                   -set!_8)))))
                                                                                                                  (values
                                                                                                                   ?_7
                                                                                                                   -ref_7
                                                                                                                   -set!_7)))))
                                                                                                  (values
                                                                                                   make_5
                                                                                                   ?_6
                                                                                                   -ref_6
                                                                                                   -set!_6)))))
                                                                                  (values
                                                                                   struct:_5
                                                                                   make_4
                                                                                   ?_5
                                                                                   -ref_5
                                                                                   -set!_5))))
                                                                             ((rhs_15)
                                                                              (let-values (((d_125) (cdr a_127)))
                                                                                (let-values (((a_134) (car d_125)))
                                                                                  a_134))))
                                                                  (values
                                                                   struct:_4
                                                                   make_3
                                                                   ?_4
                                                                   -ref_4
                                                                   -set!_4
                                                                   rhs_15)))))
                                                           ((struct:2_2 make2_2 ?2_2 make-acc/muts_2)
                                                            (let-values (((d_126) (cdr d_120)))
                                                              (let-values (((a_135) (car d_126)))
                                                                (let-values (((d_127) (cdr a_135)))
                                                                  (let-values (((struct:2_3)
                                                                                (let-values (((a_136) (car d_127)))
                                                                                  a_136))
                                                                               ((make2_3 ?2_3 make-acc/muts_3)
                                                                                (let-values (((d_128) (cdr d_127)))
                                                                                  (let-values (((make2_4)
                                                                                                (let-values (((a_137)
                                                                                                              (car
                                                                                                               d_128)))
                                                                                                  a_137))
                                                                                               ((?2_4 make-acc/muts_4)
                                                                                                (let-values (((d_129)
                                                                                                              (cdr
                                                                                                               d_128)))
                                                                                                  (let-values (((?2_5)
                                                                                                                (let-values (((a_138)
                                                                                                                              (car
                                                                                                                               d_129)))
                                                                                                                  a_138))
                                                                                                               ((make-acc/muts_5)
                                                                                                                (let-values (((d_130)
                                                                                                                              (cdr
                                                                                                                               d_129)))
                                                                                                                  d_130)))
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
                                                 struct:_3
                                                 make_2
                                                 ?_3
                                                 -ref_3
                                                 -set!_3
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
                             struct:_2
                             make_1
                             ?_2
                             -ref_2
                             -set!_2
                             rhs_13
                             struct:2_1
                             make2_1
                             ?2_1
                             make-acc/muts_1)))))
            (let-values (((info_0)
                          (if (eq? struct:_1 struct:2_0)
                            (if (eq? make_0 make2_0) (if (eq? ?_1 ?2_0) (make-struct-type-info rhs_12 structs_2) #f) #f)
                            #f)))
              (if info_0
                (let-values ()
                  (values
                   v_28
                   (let-values (((lst_42) (list* make-s_0 s?_0 acc/muts_0)))
                     (begin
                       (check-list lst_42)
                       ((letrec-values (((for-loop_21)
                                         (lambda (procs_2 lst_43)
                                           (if (pair? lst_43)
                                             (let-values (((id_6) (unsafe-car lst_43)) ((rest_25) (unsafe-cdr lst_43)))
                                               (let-values (((procs_3)
                                                             (let-values (((procs_4) procs_2))
                                                               (let-values (((procs_5)
                                                                             (let-values ()
                                                                               (hash-set procs_4 id_6 #t))))
                                                                 (values procs_5)))))
                                                 (if (not #f) (for-loop_21 procs_3 rest_25) procs_3)))
                                             procs_2))))
                          for-loop_21)
                        procs_1
                        lst_42)))
                   (hash-set structs_2 struct:s_0 #t)
                   #f
                   #t))
                (let-values () (values v_28 procs_1 structs_2 #t #t)))))
          (if (if (pair? v_29)
                (if (let-values (((a_139) (car v_29))) (equal? 'define-values a_139))
                  (let-values (((d_131) (cdr v_29))) #t)
                  #f)
                #f)
            (let-values () (values v_28 procs_1 structs_2 #t #t))
            (let-values ()
              (values
               (if last?_0 v_28 (list 'define-values (list (gensym)) (list* 'begin v_28 '((void)))))
               procs_1
               structs_2
               #t
               #f))))))))
 (define-values
  (left-to-right/let)
  (lambda (v_30 mutated_12)
    (let-values (((v_31) v_30))
      (if (if (pair? v_31)
            (if (let-values (((a_140) (car v_31))) (equal? 'let a_140))
              (let-values (((d_132) (cdr v_31)))
                (if (pair? d_132)
                  (if (let-values (((a_141) (car d_132)))
                        (if (pair? a_141)
                          (if (let-values (((a_142) (car a_141))) #t)
                            (let-values (((d_133) (cdr a_141))) (equal? '() d_133))
                            #f)
                          #f))
                    (let-values (((d_134) (cdr d_132))) #t)
                    #f)
                  #f))
              #f)
            #f)
        (let-values () v_30)
        (if (if (pair? v_31)
              (if (let-values (((a_143) (car v_31))) (equal? 'let a_143))
                (let-values (((d_135) (cdr v_31)))
                  (if (pair? d_135)
                    (if (let-values (((a_144) (car d_135)))
                          (if (list? a_144)
                            (let-values (((lst_44) a_144))
                              (begin
                                (check-list lst_44)
                                ((letrec-values (((for-loop_22)
                                                  (lambda (result_26 lst_45)
                                                    (if (pair? lst_45)
                                                      (let-values (((v_32) (unsafe-car lst_45))
                                                                   ((rest_26) (unsafe-cdr lst_45)))
                                                        (let-values (((result_27)
                                                                      (let-values ()
                                                                        (let-values (((result_28)
                                                                                      (let-values ()
                                                                                        (let-values ()
                                                                                          (if (pair? v_32)
                                                                                            (if (let-values (((a_145)
                                                                                                              (car
                                                                                                               v_32)))
                                                                                                  #t)
                                                                                              (let-values (((d_136)
                                                                                                            (cdr v_32)))
                                                                                                (if (pair? d_136)
                                                                                                  (if (let-values (((a_146)
                                                                                                                    (car
                                                                                                                     d_136)))
                                                                                                        #t)
                                                                                                    (let-values (((d_137)
                                                                                                                  (cdr
                                                                                                                   d_136)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_137))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f)))))
                                                                          (values result_28)))))
                                                          (if (if (not ((lambda x_8 (not result_27)) v_32)) (not #f) #f)
                                                            (for-loop_22 result_27 rest_26)
                                                            result_27)))
                                                      result_26))))
                                   for-loop_22)
                                 #t
                                 lst_44)))
                            #f))
                      (let-values (((d_138) (cdr d_135))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_9 rhss_30 bodys_0)
                        (let-values (((d_139) (cdr v_31)))
                          (let-values (((ids_10 rhss_31)
                                        (let-values (((a_147) (car d_139)))
                                          (let-values (((ids_11 rhss_32)
                                                        (let-values (((lst_46) a_147))
                                                          (begin
                                                            (check-list lst_46)
                                                            ((letrec-values (((for-loop_23)
                                                                              (lambda (ids_12 rhss_33 lst_47)
                                                                                (if (pair? lst_47)
                                                                                  (let-values (((v_33)
                                                                                                (unsafe-car lst_47))
                                                                                               ((rest_27)
                                                                                                (unsafe-cdr lst_47)))
                                                                                    (let-values (((ids_13 rhss_34)
                                                                                                  (let-values (((ids_14)
                                                                                                                ids_12)
                                                                                                               ((rhss_35)
                                                                                                                rhss_33))
                                                                                                    (let-values (((ids_15
                                                                                                                   rhss_36)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((ids9_0
                                                                                                                                   rhss10_0)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values (((ids_16)
                                                                                                                                                  (let-values (((a_148)
                                                                                                                                                                (car
                                                                                                                                                                 v_33)))
                                                                                                                                                    a_148))
                                                                                                                                                 ((rhss_37)
                                                                                                                                                  (let-values (((d_140)
                                                                                                                                                                (cdr
                                                                                                                                                                 v_33)))
                                                                                                                                                    (let-values (((a_149)
                                                                                                                                                                  (car
                                                                                                                                                                   d_140)))
                                                                                                                                                      a_149))))
                                                                                                                                      (values
                                                                                                                                       ids_16
                                                                                                                                       rhss_37)))))
                                                                                                                      (values
                                                                                                                       (cons
                                                                                                                        ids9_0
                                                                                                                        ids_14)
                                                                                                                       (cons
                                                                                                                        rhss10_0
                                                                                                                        rhss_35))))))
                                                                                                      (values
                                                                                                       ids_15
                                                                                                       rhss_36)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_23
                                                                                         ids_13
                                                                                         rhss_34
                                                                                         rest_27)
                                                                                        (values ids_13 rhss_34))))
                                                                                  (values ids_12 rhss_33)))))
                                                               for-loop_23)
                                                             null
                                                             null
                                                             lst_46)))))
                                            (values (reverse$1 ids_11) (reverse$1 rhss_32)))))
                                       ((bodys_1) (let-values (((d_141) (cdr d_139))) d_141)))
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
                                  (if (simple? (car rhss_38) mutated_12)
                                    (let-values ()
                                      (list
                                       'let
                                       (list (list (car ids_17) (car rhss_38)))
                                       (loop_6 (cdr ids_17) (cdr rhss_38) binds_0)))
                                    (let-values ()
                                      (let-values (((id_7) (car ids_17)))
                                        (list
                                         'let
                                         (list (list id_7 (car rhss_38)))
                                         (loop_6 (cdr ids_17) (cdr rhss_38) (cons (list id_7 id_7) binds_0))))))))))
               loop_6)
             ids_9
             rhss_30
             null))
          (error 'match "failed ~e" v_31))))))
 (define-values
  (left-to-right/let-values)
  (lambda (v_34 mutated_13)
    (let-values (((v_35) v_34))
      (if (if (pair? v_35)
            (if (let-values (((a_150) (car v_35))) (equal? 'let-values a_150))
              (let-values (((d_142) (cdr v_35)))
                (if (pair? d_142)
                  (if (let-values (((a_151) (car d_142)))
                        (if (pair? a_151)
                          (if (let-values (((a_152) (car a_151)))
                                (if (pair? a_152)
                                  (if (let-values (((a_153) (car a_152))) #t)
                                    (let-values (((d_143) (cdr a_152)))
                                      (if (pair? d_143)
                                        (if (let-values (((a_154) (car d_143))) #t)
                                          (let-values (((d_144) (cdr d_143))) (equal? '() d_144))
                                          #f)
                                        #f))
                                    #f)
                                  #f))
                            (let-values (((d_145) (cdr a_151))) (equal? '() d_145))
                            #f)
                          #f))
                    (let-values (((d_146) (cdr d_142)))
                      (if (pair? d_146)
                        (if (let-values (((a_155) (car d_146))) #t)
                          (let-values (((d_147) (cdr d_146))) (equal? '() d_147))
                          #f)
                        #f))
                    #f)
                  #f))
              #f)
            #f)
        (let-values (((ids_18 rhs_16 body_11)
                      (let-values (((d_148) (cdr v_35)))
                        (let-values (((ids_19 rhs_17)
                                      (let-values (((a_156) (car d_148)))
                                        (let-values (((a_157) (car a_156)))
                                          (let-values (((ids_20) (let-values (((a_158) (car a_157))) a_158))
                                                       ((rhs_18)
                                                        (let-values (((d_149) (cdr a_157)))
                                                          (let-values (((a_159) (car d_149))) a_159))))
                                            (values ids_20 rhs_18)))))
                                     ((body_12)
                                      (let-values (((d_150) (cdr d_148))) (let-values (((a_160) (car d_150))) a_160))))
                          (values ids_19 rhs_17 body_12)))))
          (make-let-values ids_18 rhs_16 body_11))
        (if (if (pair? v_35)
              (if (let-values (((a_161) (car v_35))) (equal? 'let-values a_161))
                (let-values (((d_151) (cdr v_35)))
                  (if (pair? d_151)
                    (if (let-values (((a_162) (car d_151)))
                          (if (pair? a_162)
                            (if (let-values (((a_163) (car a_162)))
                                  (if (pair? a_163)
                                    (if (let-values (((a_164) (car a_163))) #t)
                                      (let-values (((d_152) (cdr a_163)))
                                        (if (pair? d_152)
                                          (if (let-values (((a_165) (car d_152))) #t)
                                            (let-values (((d_153) (cdr d_152))) (equal? '() d_153))
                                            #f)
                                          #f))
                                      #f)
                                    #f))
                              (let-values (((d_154) (cdr a_162))) (equal? '() d_154))
                              #f)
                            #f))
                      (let-values (((d_155) (cdr d_151))) #t)
                      #f)
                    #f))
                #f)
              #f)
          (let-values (((ids_21 rhs_19 bodys_2)
                        (let-values (((d_156) (cdr v_35)))
                          (let-values (((ids_22 rhs_20)
                                        (let-values (((a_166) (car d_156)))
                                          (let-values (((a_167) (car a_166)))
                                            (let-values (((ids_23) (let-values (((a_168) (car a_167))) a_168))
                                                         ((rhs_21)
                                                          (let-values (((d_157) (cdr a_167)))
                                                            (let-values (((a_169) (car d_157))) a_169))))
                                              (values ids_23 rhs_21)))))
                                       ((bodys_3) (let-values (((d_158) (cdr d_156))) d_158)))
                            (values ids_22 rhs_20 bodys_3)))))
            (make-let-values ids_21 rhs_19 (list* 'begin bodys_2)))
          (if (if (pair? v_35)
                (if (let-values (((a_170) (car v_35))) (equal? 'let-values a_170))
                  (let-values (((d_159) (cdr v_35)))
                    (if (pair? d_159)
                      (if (let-values (((a_171) (car d_159)))
                            (if (list? a_171)
                              (let-values (((lst_48) a_171))
                                (begin
                                  (check-list lst_48)
                                  ((letrec-values (((for-loop_24)
                                                    (lambda (result_29 lst_49)
                                                      (if (pair? lst_49)
                                                        (let-values (((v_36) (unsafe-car lst_49))
                                                                     ((rest_28) (unsafe-cdr lst_49)))
                                                          (let-values (((result_30)
                                                                        (let-values ()
                                                                          (let-values (((result_31)
                                                                                        (let-values ()
                                                                                          (let-values ()
                                                                                            (if (pair? v_36)
                                                                                              (if (let-values (((a_172)
                                                                                                                (car
                                                                                                                 v_36)))
                                                                                                    (list? a_172))
                                                                                                (let-values (((d_160)
                                                                                                              (cdr
                                                                                                               v_36)))
                                                                                                  (if (pair? d_160)
                                                                                                    (if (let-values (((a_173)
                                                                                                                      (car
                                                                                                                       d_160)))
                                                                                                          #t)
                                                                                                      (let-values (((d_161)
                                                                                                                    (cdr
                                                                                                                     d_160)))
                                                                                                        (equal?
                                                                                                         '()
                                                                                                         d_161))
                                                                                                      #f)
                                                                                                    #f))
                                                                                                #f)
                                                                                              #f)))))
                                                                            (values result_31)))))
                                                            (if (if (not ((lambda x_9 (not result_30)) v_36))
                                                                  (not #f)
                                                                  #f)
                                                              (for-loop_24 result_30 rest_28)
                                                              result_30)))
                                                        result_29))))
                                     for-loop_24)
                                   #t
                                   lst_48)))
                              #f))
                        (let-values (((d_162) (cdr d_159))) #t)
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((idss_8 rhss_39 bodys_4)
                          (let-values (((d_163) (cdr v_35)))
                            (let-values (((idss_9 rhss_40)
                                          (let-values (((a_174) (car d_163)))
                                            (let-values (((idss_10 rhss_41)
                                                          (let-values (((lst_50) a_174))
                                                            (begin
                                                              (check-list lst_50)
                                                              ((letrec-values (((for-loop_25)
                                                                                (lambda (idss_11 rhss_42 lst_51)
                                                                                  (if (pair? lst_51)
                                                                                    (let-values (((v_37)
                                                                                                  (unsafe-car lst_51))
                                                                                                 ((rest_29)
                                                                                                  (unsafe-cdr lst_51)))
                                                                                      (let-values (((idss_12 rhss_43)
                                                                                                    (let-values (((idss_13)
                                                                                                                  idss_11)
                                                                                                                 ((rhss_44)
                                                                                                                  rhss_42))
                                                                                                      (let-values (((idss_14
                                                                                                                     rhss_45)
                                                                                                                    (let-values ()
                                                                                                                      (let-values (((idss11_0
                                                                                                                                     rhss12_0)
                                                                                                                                    (let-values ()
                                                                                                                                      (let-values (((idss_15)
                                                                                                                                                    (let-values (((a_175)
                                                                                                                                                                  (car
                                                                                                                                                                   v_37)))
                                                                                                                                                      a_175))
                                                                                                                                                   ((rhss_46)
                                                                                                                                                    (let-values (((d_164)
                                                                                                                                                                  (cdr
                                                                                                                                                                   v_37)))
                                                                                                                                                      (let-values (((a_176)
                                                                                                                                                                    (car
                                                                                                                                                                     d_164)))
                                                                                                                                                        a_176))))
                                                                                                                                        (values
                                                                                                                                         idss_15
                                                                                                                                         rhss_46)))))
                                                                                                                        (values
                                                                                                                         (cons
                                                                                                                          idss11_0
                                                                                                                          idss_13)
                                                                                                                         (cons
                                                                                                                          rhss12_0
                                                                                                                          rhss_44))))))
                                                                                                        (values
                                                                                                         idss_14
                                                                                                         rhss_45)))))
                                                                                        (if (not #f)
                                                                                          (for-loop_25
                                                                                           idss_12
                                                                                           rhss_43
                                                                                           rest_29)
                                                                                          (values idss_12 rhss_43))))
                                                                                    (values idss_11 rhss_42)))))
                                                                 for-loop_25)
                                                               null
                                                               null
                                                               lst_50)))))
                                              (values (reverse$1 idss_10) (reverse$1 rhss_41)))))
                                         ((bodys_5) (let-values (((d_165) (cdr d_163))) d_165)))
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
                                          (append (map2 (lambda (id_8) (list id_8 id_8)) ids_24) binds_1)))))))))
                 loop_7)
               idss_8
               rhss_39
               null))
            (error 'match "failed ~e" v_35)))))))
 (define-values
  (make-let-values)
  (lambda (ids_25 rhs_22 body_13)
    (if (if (pair? ids_25) (null? (cdr ids_25)) #f)
      (list 'let (list (list (car ids_25) rhs_22)) body_13)
      (list
       'call-with-values
       (list 'lambda '() rhs_22)
       (list
        'case-lambda
        (list ids_25 body_13)
        (list 'args (list* 'raise-result-arity-error (list 'quote ids_25) '(args))))))))
 (define-values
  (left-to-right/app)
  (lambda (v_38 mutated_14)
    ((letrec-values (((loop_8)
                      (lambda (l_11 accum_1)
                        (if (null? l_11)
                          (let-values () (reverse$1 accum_1))
                          (if (simple? (car l_11) mutated_14)
                            (let-values () (loop_8 (cdr l_11) (cons (car l_11) accum_1)))
                            (if (andmap2 (lambda (v_39) (simple? v_39 mutated_14)) (cdr l_11))
                              (let-values () (append (reverse$1 accum_1) l_11))
                              (let-values ()
                                (let-values (((g_0) (gensym "app_")))
                                  (list
                                   'let
                                   (list (list g_0 (car l_11)))
                                   (loop_8 (cdr l_11) (cons g_0 accum_1)))))))))))
       loop_8)
     v_38
     null)))
 (define-values
  (make-schemify)
  (lambda (procs_6 structs_3 mutated_15 imports_8 exports_6)
    (lambda (v_40)
      ((letrec-values (((schemify_1)
                        (lambda (v_41)
                          (let-values (((v_42) v_41))
                            (if (if (pair? v_42)
                                  (if (let-values (((a_177) (car v_42))) (equal? 'lambda a_177))
                                    (let-values (((d_166) (cdr v_42)))
                                      (if (pair? d_166)
                                        (if (let-values (((a_178) (car d_166))) #t)
                                          (let-values (((d_167) (cdr d_166))) (list? d_167))
                                          #f)
                                        #f))
                                    #f)
                                  #f)
                              (let-values (((formals_0 body_14)
                                            (let-values (((d_168) (cdr v_42)))
                                              (let-values (((formals_1) (let-values (((a_179) (car d_168))) a_179))
                                                           ((body_15) (let-values (((d_169) (cdr d_168))) d_169)))
                                                (values formals_1 body_15)))))
                                (list* 'lambda formals_0 (map2 schemify_1 body_14)))
                              (if (if (pair? v_42)
                                    (if (let-values (((a_180) (car v_42))) (equal? 'case-lambda a_180))
                                      (let-values (((d_170) (cdr v_42)))
                                        (if (list? d_170)
                                          (let-values (((lst_52) d_170))
                                            (begin
                                              (check-list lst_52)
                                              ((letrec-values (((for-loop_26)
                                                                (lambda (result_32 lst_53)
                                                                  (if (pair? lst_53)
                                                                    (let-values (((v_43) (unsafe-car lst_53))
                                                                                 ((rest_30) (unsafe-cdr lst_53)))
                                                                      (let-values (((result_33)
                                                                                    (let-values ()
                                                                                      (let-values (((result_34)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (if (pair? v_43)
                                                                                                          (if (let-values (((a_181)
                                                                                                                            (car
                                                                                                                             v_43)))
                                                                                                                #t)
                                                                                                            (let-values (((d_171)
                                                                                                                          (cdr
                                                                                                                           v_43)))
                                                                                                              (list?
                                                                                                               d_171))
                                                                                                            #f)
                                                                                                          #f)))))
                                                                                        (values result_34)))))
                                                                        (if (if (not
                                                                                 ((lambda x_10 (not result_33)) v_43))
                                                                              (not #f)
                                                                              #f)
                                                                          (for-loop_26 result_33 rest_30)
                                                                          result_33)))
                                                                    result_32))))
                                                 for-loop_26)
                                               #t
                                               lst_52)))
                                          #f))
                                      #f)
                                    #f)
                                (let-values (((formalss_0 bodys_6)
                                              (let-values (((d_172) (cdr v_42)))
                                                (let-values (((formalss_1 bodys_7)
                                                              (let-values (((lst_54) d_172))
                                                                (begin
                                                                  (check-list lst_54)
                                                                  ((letrec-values (((for-loop_27)
                                                                                    (lambda (formalss_2 bodys_8 lst_55)
                                                                                      (if (pair? lst_55)
                                                                                        (let-values (((v_44)
                                                                                                      (unsafe-car
                                                                                                       lst_55))
                                                                                                     ((rest_31)
                                                                                                      (unsafe-cdr
                                                                                                       lst_55)))
                                                                                          (let-values (((formalss_3
                                                                                                         bodys_9)
                                                                                                        (let-values (((formalss_4)
                                                                                                                      formalss_2)
                                                                                                                     ((bodys_10)
                                                                                                                      bodys_8))
                                                                                                          (let-values (((formalss_5
                                                                                                                         bodys_11)
                                                                                                                        (let-values ()
                                                                                                                          (let-values (((formalss13_0
                                                                                                                                         bodys14_0)
                                                                                                                                        (let-values ()
                                                                                                                                          (let-values (((formalss_6)
                                                                                                                                                        (let-values (((a_182)
                                                                                                                                                                      (car
                                                                                                                                                                       v_44)))
                                                                                                                                                          a_182))
                                                                                                                                                       ((bodys_12)
                                                                                                                                                        (let-values (((d_173)
                                                                                                                                                                      (cdr
                                                                                                                                                                       v_44)))
                                                                                                                                                          d_173)))
                                                                                                                                            (values
                                                                                                                                             formalss_6
                                                                                                                                             bodys_12)))))
                                                                                                                            (values
                                                                                                                             (cons
                                                                                                                              formalss13_0
                                                                                                                              formalss_4)
                                                                                                                             (cons
                                                                                                                              bodys14_0
                                                                                                                              bodys_10))))))
                                                                                                            (values
                                                                                                             formalss_5
                                                                                                             bodys_11)))))
                                                                                            (if (not #f)
                                                                                              (for-loop_27
                                                                                               formalss_3
                                                                                               bodys_9
                                                                                               rest_31)
                                                                                              (values
                                                                                               formalss_3
                                                                                               bodys_9))))
                                                                                        (values formalss_2 bodys_8)))))
                                                                     for-loop_27)
                                                                   null
                                                                   null
                                                                   lst_54)))))
                                                  (values (reverse$1 formalss_1) (reverse$1 bodys_7))))))
                                  (list*
                                   'case-lambda
                                   (let-values (((lst_56) formalss_0) ((lst_57) bodys_6))
                                     (begin
                                       (check-list lst_56)
                                       (check-list lst_57)
                                       ((letrec-values (((for-loop_28)
                                                         (lambda (lst_58 lst_59)
                                                           (if (if (pair? lst_58) (pair? lst_59) #f)
                                                             (let-values (((formals_2) (unsafe-car lst_58))
                                                                          ((rest_32) (unsafe-cdr lst_58))
                                                                          ((body_16) (unsafe-car lst_59))
                                                                          ((rest_33) (unsafe-cdr lst_59)))
                                                               (let-values (((post-guard-var_3) (lambda () #t)))
                                                                 (let-values ()
                                                                   (let-values (((elem_2)
                                                                                 (let-values ()
                                                                                   (let-values ()
                                                                                     (list*
                                                                                      formals_2
                                                                                      (map2 schemify_1 body_16))))))
                                                                     (let-values (((result_35)
                                                                                   (if (post-guard-var_3)
                                                                                     (for-loop_28 rest_32 rest_33)
                                                                                     null)))
                                                                       (cons elem_2 result_35))))))
                                                             null))))
                                          for-loop_28)
                                        lst_56
                                        lst_57)))))
                                (if (if (pair? v_42)
                                      (if (let-values (((a_183) (car v_42))) (equal? 'define-values a_183))
                                        (let-values (((d_174) (cdr v_42)))
                                          (if (pair? d_174)
                                            (if (let-values (((a_184) (car d_174)))
                                                  (if (pair? a_184)
                                                    (if (let-values (((a_185) (car a_184))) #t)
                                                      (let-values (((d_175) (cdr a_184)))
                                                        (if (pair? d_175)
                                                          (if (let-values (((a_186) (car d_175))) #t)
                                                            (let-values (((d_176) (cdr d_175)))
                                                              (if (pair? d_176)
                                                                (if (let-values (((a_187) (car d_176))) #t)
                                                                  (let-values (((d_177) (cdr d_176))) (list? d_177))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                              (let-values (((d_178) (cdr d_174)))
                                                (if (pair? d_178)
                                                  (if (let-values (((a_188) (car d_178)))
                                                        (if (pair? a_188)
                                                          (if (let-values (((a_189) (car a_188)))
                                                                (equal? 'let-values a_189))
                                                            (let-values (((d_179) (cdr a_188)))
                                                              (if (pair? d_179)
                                                                (if (let-values (((a_190) (car d_179)))
                                                                      (if (pair? a_190)
                                                                        (if (let-values (((a_191) (car a_190)))
                                                                              (if (pair? a_191)
                                                                                (if (let-values (((a_192) (car a_191)))
                                                                                      (if (pair? a_192)
                                                                                        (if (let-values (((a_193)
                                                                                                          (car a_192)))
                                                                                              #t)
                                                                                          (let-values (((d_180)
                                                                                                        (cdr a_192)))
                                                                                            (if (pair? d_180)
                                                                                              (if (let-values (((a_194)
                                                                                                                (car
                                                                                                                 d_180)))
                                                                                                    #t)
                                                                                                (let-values (((d_181)
                                                                                                              (cdr
                                                                                                               d_180)))
                                                                                                  (if (pair? d_181)
                                                                                                    (if (let-values (((a_195)
                                                                                                                      (car
                                                                                                                       d_181)))
                                                                                                          #t)
                                                                                                      (let-values (((d_182)
                                                                                                                    (cdr
                                                                                                                     d_181)))
                                                                                                        (if (pair?
                                                                                                             d_182)
                                                                                                          (if (let-values (((a_196)
                                                                                                                            (car
                                                                                                                             d_182)))
                                                                                                                #t)
                                                                                                            (let-values (((d_183)
                                                                                                                          (cdr
                                                                                                                           d_182)))
                                                                                                              (if (pair?
                                                                                                                   d_183)
                                                                                                                (if (let-values (((a_197)
                                                                                                                                  (car
                                                                                                                                   d_183)))
                                                                                                                      #t)
                                                                                                                  (let-values (((d_184)
                                                                                                                                (cdr
                                                                                                                                 d_183)))
                                                                                                                    (equal?
                                                                                                                     '()
                                                                                                                     d_184))
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
                                                                                  (let-values (((d_185) (cdr a_191)))
                                                                                    (if (pair? d_185)
                                                                                      (if (let-values (((a_198)
                                                                                                        (car d_185)))
                                                                                            #t)
                                                                                        (let-values (((d_186)
                                                                                                      (cdr d_185)))
                                                                                          (equal? '() d_186))
                                                                                        #f)
                                                                                      #f))
                                                                                  #f)
                                                                                #f))
                                                                          (let-values (((d_187) (cdr a_190)))
                                                                            (equal? '() d_187))
                                                                          #f)
                                                                        #f))
                                                                  (let-values (((d_188) (cdr d_179)))
                                                                    (if (pair? d_188)
                                                                      (if (let-values (((a_199) (car d_188)))
                                                                            (if (pair? a_199)
                                                                              (if (let-values (((a_200) (car a_199)))
                                                                                    (equal? 'values a_200))
                                                                                (let-values (((d_189) (cdr a_199)))
                                                                                  (if (pair? d_189)
                                                                                    (if (let-values (((a_201)
                                                                                                      (car d_189)))
                                                                                          #t)
                                                                                      (let-values (((d_190)
                                                                                                    (cdr d_189)))
                                                                                        (if (pair? d_190)
                                                                                          (if (let-values (((a_202)
                                                                                                            (car
                                                                                                             d_190)))
                                                                                                #t)
                                                                                            (let-values (((d_191)
                                                                                                          (cdr d_190)))
                                                                                              (if (pair? d_191)
                                                                                                (if (let-values (((a_203)
                                                                                                                  (car
                                                                                                                   d_191)))
                                                                                                      #t)
                                                                                                  (let-values (((d_192)
                                                                                                                (cdr
                                                                                                                 d_191)))
                                                                                                    (list? d_192))
                                                                                                  #f)
                                                                                                #f))
                                                                                            #f)
                                                                                          #f))
                                                                                      #f)
                                                                                    #f))
                                                                                #f)
                                                                              #f))
                                                                        (let-values (((d_193) (cdr d_188)))
                                                                          (equal? '() d_193))
                                                                        #f)
                                                                      #f))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f))
                                                    (let-values (((d_194) (cdr d_178))) (equal? '() d_194))
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
                                                 struct:_6
                                                 make_6
                                                 ?1_0
                                                 -ref_9
                                                 -set!_9
                                                 mk_0
                                                 struct:2_4
                                                 make2_5
                                                 ?2_6
                                                 make-acc/muts_6)
                                                (let-values (((d_195) (cdr v_42)))
                                                  (let-values (((struct:s_4 make-s_5 s?_6 acc/muts_6)
                                                                (let-values (((a_204) (car d_195)))
                                                                  (let-values (((struct:s_5)
                                                                                (let-values (((a_205) (car a_204)))
                                                                                  a_205))
                                                                               ((make-s_6 s?_7 acc/muts_7)
                                                                                (let-values (((d_196) (cdr a_204)))
                                                                                  (let-values (((make-s_7)
                                                                                                (let-values (((a_206)
                                                                                                              (car
                                                                                                               d_196)))
                                                                                                  a_206))
                                                                                               ((s?_8 acc/muts_8)
                                                                                                (let-values (((d_197)
                                                                                                              (cdr
                                                                                                               d_196)))
                                                                                                  (let-values (((s?_9)
                                                                                                                (let-values (((a_207)
                                                                                                                              (car
                                                                                                                               d_197)))
                                                                                                                  a_207))
                                                                                                               ((acc/muts_9)
                                                                                                                (let-values (((d_198)
                                                                                                                              (cdr
                                                                                                                               d_197)))
                                                                                                                  d_198)))
                                                                                                    (values
                                                                                                     s?_9
                                                                                                     acc/muts_9)))))
                                                                                    (values
                                                                                     make-s_7
                                                                                     s?_8
                                                                                     acc/muts_8)))))
                                                                    (values struct:s_5 make-s_6 s?_7 acc/muts_7))))
                                                               ((struct:_7
                                                                 make_7
                                                                 ?1_1
                                                                 -ref_10
                                                                 -set!_10
                                                                 mk_1
                                                                 struct:2_5
                                                                 make2_6
                                                                 ?2_7
                                                                 make-acc/muts_7)
                                                                (let-values (((d_199) (cdr d_195)))
                                                                  (let-values (((a_208) (car d_199)))
                                                                    (let-values (((d_200) (cdr a_208)))
                                                                      (let-values (((struct:_8
                                                                                     make_8
                                                                                     ?1_2
                                                                                     -ref_11
                                                                                     -set!_11
                                                                                     mk_2)
                                                                                    (let-values (((a_209) (car d_200)))
                                                                                      (let-values (((a_210)
                                                                                                    (car a_209)))
                                                                                        (let-values (((struct:_9
                                                                                                       make_9
                                                                                                       ?1_3
                                                                                                       -ref_12
                                                                                                       -set!_12)
                                                                                                      (let-values (((a_211)
                                                                                                                    (car
                                                                                                                     a_210)))
                                                                                                        (let-values (((struct:_10)
                                                                                                                      (let-values (((a_212)
                                                                                                                                    (car
                                                                                                                                     a_211)))
                                                                                                                        a_212))
                                                                                                                     ((make_10
                                                                                                                       ?1_4
                                                                                                                       -ref_13
                                                                                                                       -set!_13)
                                                                                                                      (let-values (((d_201)
                                                                                                                                    (cdr
                                                                                                                                     a_211)))
                                                                                                                        (let-values (((make_11)
                                                                                                                                      (let-values (((a_213)
                                                                                                                                                    (car
                                                                                                                                                     d_201)))
                                                                                                                                        a_213))
                                                                                                                                     ((?1_5
                                                                                                                                       -ref_14
                                                                                                                                       -set!_14)
                                                                                                                                      (let-values (((d_202)
                                                                                                                                                    (cdr
                                                                                                                                                     d_201)))
                                                                                                                                        (let-values (((?1_6)
                                                                                                                                                      (let-values (((a_214)
                                                                                                                                                                    (car
                                                                                                                                                                     d_202)))
                                                                                                                                                        a_214))
                                                                                                                                                     ((-ref_15
                                                                                                                                                       -set!_15)
                                                                                                                                                      (let-values (((d_203)
                                                                                                                                                                    (cdr
                                                                                                                                                                     d_202)))
                                                                                                                                                        (let-values (((-ref_16)
                                                                                                                                                                      (let-values (((a_215)
                                                                                                                                                                                    (car
                                                                                                                                                                                     d_203)))
                                                                                                                                                                        a_215))
                                                                                                                                                                     ((-set!_16)
                                                                                                                                                                      (let-values (((d_204)
                                                                                                                                                                                    (cdr
                                                                                                                                                                                     d_203)))
                                                                                                                                                                        (let-values (((a_216)
                                                                                                                                                                                      (car
                                                                                                                                                                                       d_204)))
                                                                                                                                                                          a_216))))
                                                                                                                                                          (values
                                                                                                                                                           -ref_16
                                                                                                                                                           -set!_16)))))
                                                                                                                                          (values
                                                                                                                                           ?1_6
                                                                                                                                           -ref_15
                                                                                                                                           -set!_15)))))
                                                                                                                          (values
                                                                                                                           make_11
                                                                                                                           ?1_5
                                                                                                                           -ref_14
                                                                                                                           -set!_14)))))
                                                                                                          (values
                                                                                                           struct:_10
                                                                                                           make_10
                                                                                                           ?1_4
                                                                                                           -ref_13
                                                                                                           -set!_13))))
                                                                                                     ((mk_3)
                                                                                                      (let-values (((d_205)
                                                                                                                    (cdr
                                                                                                                     a_210)))
                                                                                                        (let-values (((a_217)
                                                                                                                      (car
                                                                                                                       d_205)))
                                                                                                          a_217))))
                                                                                          (values
                                                                                           struct:_9
                                                                                           make_9
                                                                                           ?1_3
                                                                                           -ref_12
                                                                                           -set!_12
                                                                                           mk_3)))))
                                                                                   ((struct:2_6
                                                                                     make2_7
                                                                                     ?2_8
                                                                                     make-acc/muts_8)
                                                                                    (let-values (((d_206) (cdr d_200)))
                                                                                      (let-values (((a_218)
                                                                                                    (car d_206)))
                                                                                        (let-values (((d_207)
                                                                                                      (cdr a_218)))
                                                                                          (let-values (((struct:2_7)
                                                                                                        (let-values (((a_219)
                                                                                                                      (car
                                                                                                                       d_207)))
                                                                                                          a_219))
                                                                                                       ((make2_8
                                                                                                         ?2_9
                                                                                                         make-acc/muts_9)
                                                                                                        (let-values (((d_208)
                                                                                                                      (cdr
                                                                                                                       d_207)))
                                                                                                          (let-values (((make2_9)
                                                                                                                        (let-values (((a_220)
                                                                                                                                      (car
                                                                                                                                       d_208)))
                                                                                                                          a_220))
                                                                                                                       ((?2_10
                                                                                                                         make-acc/muts_10)
                                                                                                                        (let-values (((d_209)
                                                                                                                                      (cdr
                                                                                                                                       d_208)))
                                                                                                                          (let-values (((?2_11)
                                                                                                                                        (let-values (((a_221)
                                                                                                                                                      (car
                                                                                                                                                       d_209)))
                                                                                                                                          a_221))
                                                                                                                                       ((make-acc/muts_11)
                                                                                                                                        (let-values (((d_210)
                                                                                                                                                      (cdr
                                                                                                                                                       d_209)))
                                                                                                                                          d_210)))
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
                                                                         struct:_8
                                                                         make_8
                                                                         ?1_2
                                                                         -ref_11
                                                                         -set!_11
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
                                                     struct:_7
                                                     make_7
                                                     ?1_1
                                                     -ref_10
                                                     -set!_10
                                                     mk_1
                                                     struct:2_5
                                                     make2_6
                                                     ?2_7
                                                     make-acc/muts_7)))))
                                    (let-values (((sti_0)
                                                  (if (eq? struct:_6 struct:2_4)
                                                    (if (eq? make_6 make2_5)
                                                      (if (eq? ?1_0 ?2_6) (make-struct-type-info mk_0 structs_3) #f)
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
                                                            (let-values (((start_0) 0)
                                                                         ((end_0) (struct-type-info-field-count sti_0))
                                                                         ((inc_0) 1))
                                                              (begin
                                                                (check-range start_0 end_0 inc_0)
                                                                ((letrec-values (((for-loop_29)
                                                                                  (lambda (vec_3 i_2 pos_0)
                                                                                    (if (< pos_0 end_0)
                                                                                      (let-values (((i_3) pos_0))
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
                                                                                            (for-loop_29
                                                                                             vec_4
                                                                                             i_4
                                                                                             (+ pos_0 inc_0))
                                                                                            (values vec_4 i_4))))
                                                                                      (values vec_3 i_2)))))
                                                                   for-loop_29)
                                                                 (make-vector 16)
                                                                 0
                                                                 start_0)))))
                                                (shrink-vector vec_2 i_1)))))
                                           (list
                                            'define
                                            make-s_4
                                            (list
                                             'record-constructor
                                             (list* 'make-record-constructor-descriptor struct:s_3 '(#f #f))))
                                           (list 'define s?_5 (list 'record-predicate struct:s_3))
                                           (qq-append
                                            (let-values (((lst_60) acc/muts_5) ((lst_61) make-acc/muts_6))
                                              (begin
                                                (check-list lst_60)
                                                (check-list lst_61)
                                                ((letrec-values (((for-loop_30)
                                                                  (lambda (lst_62 lst_63)
                                                                    (if (if (pair? lst_62) (pair? lst_63) #f)
                                                                      (let-values (((acc/mut_0) (unsafe-car lst_62))
                                                                                   ((rest_34) (unsafe-cdr lst_62))
                                                                                   ((make-acc/mut_0)
                                                                                    (unsafe-car lst_63))
                                                                                   ((rest_35) (unsafe-cdr lst_63)))
                                                                        (let-values (((post-guard-var_4)
                                                                                      (lambda () #t)))
                                                                          (let-values ()
                                                                            (let-values (((elem_3)
                                                                                          (let-values ()
                                                                                            (let-values ()
                                                                                              (list
                                                                                               'define
                                                                                               acc/mut_0
                                                                                               (let-values (((v_45)
                                                                                                             make-acc/mut_0))
                                                                                                 (if (if (pair? v_45)
                                                                                                       (if (let-values (((a_222)
                                                                                                                         (car
                                                                                                                          v_45)))
                                                                                                             (equal?
                                                                                                              'make-struct-field-accessor
                                                                                                              a_222))
                                                                                                         (let-values (((d_211)
                                                                                                                       (cdr
                                                                                                                        v_45)))
                                                                                                           (if (pair?
                                                                                                                d_211)
                                                                                                             (if (let-values (((a_223)
                                                                                                                               (car
                                                                                                                                d_211)))
                                                                                                                   ((lambda (v_46)
                                                                                                                      (eq?
                                                                                                                       v_46
                                                                                                                       -ref_9))
                                                                                                                    a_223))
                                                                                                               (let-values (((d_212)
                                                                                                                             (cdr
                                                                                                                              d_211)))
                                                                                                                 (if (pair?
                                                                                                                      d_212)
                                                                                                                   (if (let-values (((a_224)
                                                                                                                                     (car
                                                                                                                                      d_212)))
                                                                                                                         #t)
                                                                                                                     (let-values (((d_213)
                                                                                                                                   (cdr
                                                                                                                                    d_212)))
                                                                                                                       (if (pair?
                                                                                                                            d_213)
                                                                                                                         (if (let-values (((a_225)
                                                                                                                                           (car
                                                                                                                                            d_213)))
                                                                                                                               #t)
                                                                                                                           (let-values (((d_214)
                                                                                                                                         (cdr
                                                                                                                                          d_213)))
                                                                                                                             (equal?
                                                                                                                              '()
                                                                                                                              d_214))
                                                                                                                           #f)
                                                                                                                         #f))
                                                                                                                     #f)
                                                                                                                   #f))
                                                                                                               #f)
                                                                                                             #f))
                                                                                                         #f)
                                                                                                       #f)
                                                                                                   (let-values (((pos_1)
                                                                                                                 (let-values (((d_215)
                                                                                                                               (cdr
                                                                                                                                v_45)))
                                                                                                                   (let-values (((d_216)
                                                                                                                                 (cdr
                                                                                                                                  d_215)))
                                                                                                                     (let-values (((a_226)
                                                                                                                                   (car
                                                                                                                                    d_216)))
                                                                                                                       a_226)))))
                                                                                                     (list
                                                                                                      'record-accessor
                                                                                                      struct:s_3
                                                                                                      pos_1))
                                                                                                   (if (if (pair? v_45)
                                                                                                         (if (let-values (((a_227)
                                                                                                                           (car
                                                                                                                            v_45)))
                                                                                                               (equal?
                                                                                                                'make-struct-field-mutator
                                                                                                                a_227))
                                                                                                           (let-values (((d_217)
                                                                                                                         (cdr
                                                                                                                          v_45)))
                                                                                                             (if (pair?
                                                                                                                  d_217)
                                                                                                               (if (let-values (((a_228)
                                                                                                                                 (car
                                                                                                                                  d_217)))
                                                                                                                     ((lambda (v_47)
                                                                                                                        (eq?
                                                                                                                         v_47
                                                                                                                         -set!_9))
                                                                                                                      a_228))
                                                                                                                 (let-values (((d_218)
                                                                                                                               (cdr
                                                                                                                                d_217)))
                                                                                                                   (if (pair?
                                                                                                                        d_218)
                                                                                                                     (if (let-values (((a_229)
                                                                                                                                       (car
                                                                                                                                        d_218)))
                                                                                                                           #t)
                                                                                                                       (let-values (((d_219)
                                                                                                                                     (cdr
                                                                                                                                      d_218)))
                                                                                                                         (if (pair?
                                                                                                                              d_219)
                                                                                                                           (if (let-values (((a_230)
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
                                                                                                                 #f)
                                                                                                               #f))
                                                                                                           #f)
                                                                                                         #f)
                                                                                                     (let-values (((pos_2)
                                                                                                                   (let-values (((d_221)
                                                                                                                                 (cdr
                                                                                                                                  v_45)))
                                                                                                                     (let-values (((d_222)
                                                                                                                                   (cdr
                                                                                                                                    d_221)))
                                                                                                                       (let-values (((a_231)
                                                                                                                                     (car
                                                                                                                                      d_222)))
                                                                                                                         a_231)))))
                                                                                                       (list
                                                                                                        'record-mutator
                                                                                                        struct:s_3
                                                                                                        pos_2))
                                                                                                     (let-values ()
                                                                                                       (error
                                                                                                        "oops"))))))))))
                                                                              (let-values (((result_36)
                                                                                            (if (post-guard-var_4)
                                                                                              (for-loop_30
                                                                                               rest_34
                                                                                               rest_35)
                                                                                              null)))
                                                                                (cons elem_3 result_36))))))
                                                                      null))))
                                                   for-loop_30)
                                                 lst_60
                                                 lst_61)))
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
                                                 (struct-type-info-field-count sti_0)
                                                 0
                                                 (struct-type-info-parent sti_0)
                                                 (map2 schemify_1 (struct-type-info-rest sti_0)))))))))
                                        (let-values () (list 'define-values (cadr v_41) (schemify_1 (caddr v_41)))))))
                                  (if (if (pair? v_42)
                                        (if (let-values (((a_232) (car v_42))) (equal? 'define-values a_232))
                                          (let-values (((d_223) (cdr v_42)))
                                            (if (pair? d_223)
                                              (if (let-values (((a_233) (car d_223)))
                                                    (if (pair? a_233)
                                                      (if (let-values (((a_234) (car a_233))) #t)
                                                        (let-values (((d_224) (cdr a_233))) (equal? '() d_224))
                                                        #f)
                                                      #f))
                                                (let-values (((d_225) (cdr d_223)))
                                                  (if (pair? d_225)
                                                    (if (let-values (((a_235) (car d_225))) #t)
                                                      (let-values (((d_226) (cdr d_225))) (equal? '() d_226))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((id_9 rhs_23)
                                                  (let-values (((d_227) (cdr v_42)))
                                                    (let-values (((id_10)
                                                                  (let-values (((a_236) (car d_227)))
                                                                    (let-values (((a_237) (car a_236))) a_237)))
                                                                 ((rhs_24)
                                                                  (let-values (((d_228) (cdr d_227)))
                                                                    (let-values (((a_238) (car d_228))) a_238))))
                                                      (values id_10 rhs_24)))))
                                      (list 'define id_9 (schemify_1 rhs_23)))
                                    (if (if (pair? v_42)
                                          (if (let-values (((a_239) (car v_42))) (equal? 'define-values a_239))
                                            (let-values (((d_229) (cdr v_42)))
                                              (if (pair? d_229)
                                                (if (let-values (((a_240) (car d_229))) #t)
                                                  (let-values (((d_230) (cdr d_229)))
                                                    (if (pair? d_230)
                                                      (if (let-values (((a_241) (car d_230))) #t)
                                                        (let-values (((d_231) (cdr d_230))) (equal? '() d_231))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f))
                                            #f)
                                          #f)
                                      (let-values (((ids_26 rhs_25)
                                                    (let-values (((d_232) (cdr v_42)))
                                                      (let-values (((ids_27) (let-values (((a_242) (car d_232))) a_242))
                                                                   ((rhs_26)
                                                                    (let-values (((d_233) (cdr d_232)))
                                                                      (let-values (((a_243) (car d_233))) a_243))))
                                                        (values ids_27 rhs_26)))))
                                        (list 'define-values ids_26 (schemify_1 rhs_25)))
                                      (if (if (pair? v_42)
                                            (if (let-values (((a_244) (car v_42))) (equal? 'quote a_244))
                                              (let-values (((d_234) (cdr v_42)))
                                                (if (pair? d_234)
                                                  (if (let-values (((a_245) (car d_234))) #t)
                                                    (let-values (((d_235) (cdr d_234))) (equal? '() d_235))
                                                    #f)
                                                  #f))
                                              #f)
                                            #f)
                                        (let-values () v_41)
                                        (if (if (pair? v_42)
                                              (if (let-values (((a_246) (car v_42))) (equal? 'let-values a_246))
                                                (let-values (((d_236) (cdr v_42)))
                                                  (if (pair? d_236)
                                                    (if (let-values (((a_247) (car d_236))) (equal? '() a_247))
                                                      (let-values (((d_237) (cdr d_236)))
                                                        (if (pair? d_237)
                                                          (if (let-values (((a_248) (car d_237))) #t)
                                                            (let-values (((d_238) (cdr d_237))) (equal? '() d_238))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f)
                                          (let-values (((body_17)
                                                        (let-values (((d_239) (cdr v_42)))
                                                          (let-values (((d_240) (cdr d_239)))
                                                            (let-values (((a_249) (car d_240))) a_249)))))
                                            (schemify_1 body_17))
                                          (if (if (pair? v_42)
                                                (if (let-values (((a_250) (car v_42))) (equal? 'let-values a_250))
                                                  (let-values (((d_241) (cdr v_42)))
                                                    (if (pair? d_241)
                                                      (if (let-values (((a_251) (car d_241))) (equal? '() a_251))
                                                        (let-values (((d_242) (cdr d_241))) (list? d_242))
                                                        #f)
                                                      #f))
                                                  #f)
                                                #f)
                                            (let-values (((bodys_13)
                                                          (let-values (((d_243) (cdr v_42)))
                                                            (let-values (((d_244) (cdr d_243))) d_244))))
                                              (list* 'begin (map2 schemify_1 bodys_13)))
                                            (if (if (pair? v_42)
                                                  (if (let-values (((a_252) (car v_42))) (equal? 'let-values a_252))
                                                    (let-values (((d_245) (cdr v_42)))
                                                      (if (pair? d_245)
                                                        (if (let-values (((a_253) (car d_245)))
                                                              (if (list? a_253)
                                                                (let-values (((lst_64) a_253))
                                                                  (begin
                                                                    (check-list lst_64)
                                                                    ((letrec-values (((for-loop_31)
                                                                                      (lambda (result_37 lst_65)
                                                                                        (if (pair? lst_65)
                                                                                          (let-values (((v_48)
                                                                                                        (unsafe-car
                                                                                                         lst_65))
                                                                                                       ((rest_36)
                                                                                                        (unsafe-cdr
                                                                                                         lst_65)))
                                                                                            (let-values (((result_38)
                                                                                                          (let-values ()
                                                                                                            (let-values (((result_39)
                                                                                                                          (let-values ()
                                                                                                                            (let-values ()
                                                                                                                              (if (pair?
                                                                                                                                   v_48)
                                                                                                                                (if (let-values (((a_254)
                                                                                                                                                  (car
                                                                                                                                                   v_48)))
                                                                                                                                      (if (pair?
                                                                                                                                           a_254)
                                                                                                                                        (if (let-values (((a_255)
                                                                                                                                                          (car
                                                                                                                                                           a_254)))
                                                                                                                                              #t)
                                                                                                                                          (let-values (((d_246)
                                                                                                                                                        (cdr
                                                                                                                                                         a_254)))
                                                                                                                                            (equal?
                                                                                                                                             '()
                                                                                                                                             d_246))
                                                                                                                                          #f)
                                                                                                                                        #f))
                                                                                                                                  (let-values (((d_247)
                                                                                                                                                (cdr
                                                                                                                                                 v_48)))
                                                                                                                                    (if (pair?
                                                                                                                                         d_247)
                                                                                                                                      (if (let-values (((a_256)
                                                                                                                                                        (car
                                                                                                                                                         d_247)))
                                                                                                                                            #t)
                                                                                                                                        (let-values (((d_248)
                                                                                                                                                      (cdr
                                                                                                                                                       d_247)))
                                                                                                                                          (equal?
                                                                                                                                           '()
                                                                                                                                           d_248))
                                                                                                                                        #f)
                                                                                                                                      #f))
                                                                                                                                  #f)
                                                                                                                                #f)))))
                                                                                                              (values
                                                                                                               result_39)))))
                                                                                              (if (if (not
                                                                                                       ((lambda x_11
                                                                                                          (not
                                                                                                           result_38))
                                                                                                        v_48))
                                                                                                    (not #f)
                                                                                                    #f)
                                                                                                (for-loop_31
                                                                                                 result_38
                                                                                                 rest_36)
                                                                                                result_38)))
                                                                                          result_37))))
                                                                       for-loop_31)
                                                                     #t
                                                                     lst_64)))
                                                                #f))
                                                          (let-values (((d_249) (cdr d_245))) (list? d_249))
                                                          #f)
                                                        #f))
                                                    #f)
                                                  #f)
                                              (let-values (((ids_28 rhss_48 bodys_14)
                                                            (let-values (((d_250) (cdr v_42)))
                                                              (let-values (((ids_29 rhss_49)
                                                                            (let-values (((a_257) (car d_250)))
                                                                              (let-values (((ids_30 rhss_50)
                                                                                            (let-values (((lst_66)
                                                                                                          a_257))
                                                                                              (begin
                                                                                                (check-list lst_66)
                                                                                                ((letrec-values (((for-loop_32)
                                                                                                                  (lambda (ids_31
                                                                                                                           rhss_51
                                                                                                                           lst_67)
                                                                                                                    (if (pair?
                                                                                                                         lst_67)
                                                                                                                      (let-values (((v_49)
                                                                                                                                    (unsafe-car
                                                                                                                                     lst_67))
                                                                                                                                   ((rest_37)
                                                                                                                                    (unsafe-cdr
                                                                                                                                     lst_67)))
                                                                                                                        (let-values (((ids_32
                                                                                                                                       rhss_52)
                                                                                                                                      (let-values (((ids_33)
                                                                                                                                                    ids_31)
                                                                                                                                                   ((rhss_53)
                                                                                                                                                    rhss_51))
                                                                                                                                        (let-values (((ids_34
                                                                                                                                                       rhss_54)
                                                                                                                                                      (let-values ()
                                                                                                                                                        (let-values (((ids15_0
                                                                                                                                                                       rhss16_0)
                                                                                                                                                                      (let-values ()
                                                                                                                                                                        (let-values (((ids_35)
                                                                                                                                                                                      (let-values (((a_258)
                                                                                                                                                                                                    (car
                                                                                                                                                                                                     v_49)))
                                                                                                                                                                                        (let-values (((a_259)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       a_258)))
                                                                                                                                                                                          a_259)))
                                                                                                                                                                                     ((rhss_55)
                                                                                                                                                                                      (let-values (((d_251)
                                                                                                                                                                                                    (cdr
                                                                                                                                                                                                     v_49)))
                                                                                                                                                                                        (let-values (((a_260)
                                                                                                                                                                                                      (car
                                                                                                                                                                                                       d_251)))
                                                                                                                                                                                          a_260))))
                                                                                                                                                                          (values
                                                                                                                                                                           ids_35
                                                                                                                                                                           rhss_55)))))
                                                                                                                                                          (values
                                                                                                                                                           (cons
                                                                                                                                                            ids15_0
                                                                                                                                                            ids_33)
                                                                                                                                                           (cons
                                                                                                                                                            rhss16_0
                                                                                                                                                            rhss_53))))))
                                                                                                                                          (values
                                                                                                                                           ids_34
                                                                                                                                           rhss_54)))))
                                                                                                                          (if (not
                                                                                                                               #f)
                                                                                                                            (for-loop_32
                                                                                                                             ids_32
                                                                                                                             rhss_52
                                                                                                                             rest_37)
                                                                                                                            (values
                                                                                                                             ids_32
                                                                                                                             rhss_52))))
                                                                                                                      (values
                                                                                                                       ids_31
                                                                                                                       rhss_51)))))
                                                                                                   for-loop_32)
                                                                                                 null
                                                                                                 null
                                                                                                 lst_66)))))
                                                                                (values
                                                                                 (reverse$1 ids_30)
                                                                                 (reverse$1 rhss_50)))))
                                                                           ((bodys_15)
                                                                            (let-values (((d_252) (cdr d_250))) d_252)))
                                                                (values ids_29 rhss_49 bodys_15)))))
                                                (let-values (((new-procs_1)
                                                              (let-values (((lst_68) ids_28) ((lst_69) rhss_48))
                                                                (begin
                                                                  (check-list lst_68)
                                                                  (check-list lst_69)
                                                                  ((letrec-values (((for-loop_33)
                                                                                    (lambda (proc_0 lst_70 lst_71)
                                                                                      (if (if (pair? lst_70)
                                                                                            (pair? lst_71)
                                                                                            #f)
                                                                                        (let-values (((id_11)
                                                                                                      (unsafe-car
                                                                                                       lst_70))
                                                                                                     ((rest_38)
                                                                                                      (unsafe-cdr
                                                                                                       lst_70))
                                                                                                     ((rhs_27)
                                                                                                      (unsafe-car
                                                                                                       lst_71))
                                                                                                     ((rest_39)
                                                                                                      (unsafe-cdr
                                                                                                       lst_71)))
                                                                                          (let-values (((proc_1)
                                                                                                        (let-values ()
                                                                                                          (let-values (((proc_2)
                                                                                                                        (let-values ()
                                                                                                                          (if (lambda?
                                                                                                                               rhs_27)
                                                                                                                            (hash-set
                                                                                                                             procs_6
                                                                                                                             id_11
                                                                                                                             #t)
                                                                                                                            procs_6))))
                                                                                                            (values
                                                                                                             proc_2)))))
                                                                                            (if (not #f)
                                                                                              (for-loop_33
                                                                                               proc_1
                                                                                               rest_38
                                                                                               rest_39)
                                                                                              proc_1)))
                                                                                        proc_0))))
                                                                     for-loop_33)
                                                                   procs_6
                                                                   lst_68
                                                                   lst_69)))))
                                                  (let-values (((body-schemify_0)
                                                                (make-schemify
                                                                 new-procs_1
                                                                 structs_3
                                                                 mutated_15
                                                                 imports_8
                                                                 exports_6)))
                                                    (left-to-right/let
                                                     (list*
                                                      'let
                                                      (let-values (((lst_72) ids_28) ((lst_73) rhss_48))
                                                        (begin
                                                          (check-list lst_72)
                                                          (check-list lst_73)
                                                          ((letrec-values (((for-loop_34)
                                                                            (lambda (lst_74 lst_75)
                                                                              (if (if (pair? lst_74) (pair? lst_75) #f)
                                                                                (let-values (((id_12)
                                                                                              (unsafe-car lst_74))
                                                                                             ((rest_40)
                                                                                              (unsafe-cdr lst_74))
                                                                                             ((rhs_28)
                                                                                              (unsafe-car lst_75))
                                                                                             ((rest_41)
                                                                                              (unsafe-cdr lst_75)))
                                                                                  (let-values (((post-guard-var_5)
                                                                                                (lambda () #t)))
                                                                                    (let-values ()
                                                                                      (let-values (((elem_4)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (list
                                                                                                         id_12
                                                                                                         (schemify_1
                                                                                                          rhs_28))))))
                                                                                        (let-values (((result_40)
                                                                                                      (if (post-guard-var_5)
                                                                                                        (for-loop_34
                                                                                                         rest_40
                                                                                                         rest_41)
                                                                                                        null)))
                                                                                          (cons elem_4 result_40))))))
                                                                                null))))
                                                             for-loop_34)
                                                           lst_72
                                                           lst_73)))
                                                      (map2 body-schemify_0 bodys_14))
                                                     mutated_15))))
                                              (if (if (pair? v_42)
                                                    (if (let-values (((a_261) (car v_42))) (equal? 'let-values a_261))
                                                      (let-values (((d_253) (cdr v_42)))
                                                        (if (pair? d_253)
                                                          (if (let-values (((a_262) (car d_253)))
                                                                (if (pair? a_262)
                                                                  (if (let-values (((a_263) (car a_262)))
                                                                        (if (pair? a_263)
                                                                          (if (let-values (((a_264) (car a_263)))
                                                                                (equal? '() a_264))
                                                                            (let-values (((d_254) (cdr a_263)))
                                                                              (if (pair? d_254)
                                                                                (if (let-values (((a_265) (car d_254)))
                                                                                      (if (pair? a_265)
                                                                                        (if (let-values (((a_266)
                                                                                                          (car a_265)))
                                                                                              (equal? 'begin a_266))
                                                                                          (let-values (((d_255)
                                                                                                        (cdr a_265)))
                                                                                            (if (pair? d_255)
                                                                                              (if (let-values (((a_267)
                                                                                                                (car
                                                                                                                 d_255)))
                                                                                                    #t)
                                                                                                (let-values (((d_256)
                                                                                                              (cdr
                                                                                                               d_255)))
                                                                                                  (if (pair? d_256)
                                                                                                    (if (let-values (((a_268)
                                                                                                                      (car
                                                                                                                       d_256)))
                                                                                                          (equal?
                                                                                                           '...
                                                                                                           a_268))
                                                                                                      (let-values (((d_257)
                                                                                                                    (cdr
                                                                                                                     d_256)))
                                                                                                        (if (pair?
                                                                                                             d_257)
                                                                                                          (if (let-values (((a_269)
                                                                                                                            (car
                                                                                                                             d_257)))
                                                                                                                (if (pair?
                                                                                                                     a_269)
                                                                                                                  (if (let-values (((a_270)
                                                                                                                                    (car
                                                                                                                                     a_269)))
                                                                                                                        (equal?
                                                                                                                         'values
                                                                                                                         a_270))
                                                                                                                    (let-values (((d_258)
                                                                                                                                  (cdr
                                                                                                                                   a_269)))
                                                                                                                      (equal?
                                                                                                                       '()
                                                                                                                       d_258))
                                                                                                                    #f)
                                                                                                                  #f))
                                                                                                            (let-values (((d_259)
                                                                                                                          (cdr
                                                                                                                           d_257)))
                                                                                                              (equal?
                                                                                                               '()
                                                                                                               d_259))
                                                                                                            #f)
                                                                                                          #f))
                                                                                                      #f)
                                                                                                    #f))
                                                                                                #f)
                                                                                              #f))
                                                                                          #f)
                                                                                        #f))
                                                                                  (let-values (((d_260) (cdr d_254)))
                                                                                    (equal? '() d_260))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                    (let-values (((d_261) (cdr a_262)))
                                                                      (equal? '() d_261))
                                                                    #f)
                                                                  #f))
                                                            (let-values (((d_262) (cdr d_253))) (list? d_262))
                                                            #f)
                                                          #f))
                                                      #f)
                                                    #f)
                                                (let-values (((rhss_56 bodys_16)
                                                              (let-values (((d_263) (cdr v_42)))
                                                                (let-values (((rhss_57)
                                                                              (let-values (((a_271) (car d_263)))
                                                                                (let-values (((a_272) (car a_271)))
                                                                                  (let-values (((d_264) (cdr a_272)))
                                                                                    (let-values (((a_273) (car d_264)))
                                                                                      (let-values (((d_265)
                                                                                                    (cdr a_273)))
                                                                                        (let-values (((a_274)
                                                                                                      (car d_265)))
                                                                                          a_274)))))))
                                                                             ((bodys_17)
                                                                              (let-values (((d_266) (cdr d_263)))
                                                                                d_266)))
                                                                  (values rhss_57 bodys_17)))))
                                                  (list*
                                                   'begin
                                                   (qq-append (map2 schemify_1 rhss_56) (map2 schemify_1 bodys_16))))
                                                (if (if (pair? v_42)
                                                      (if (let-values (((a_275) (car v_42))) (equal? 'let-values a_275))
                                                        (let-values (((d_267) (cdr v_42)))
                                                          (if (pair? d_267)
                                                            (if (let-values (((a_276) (car d_267)))
                                                                  (if (list? a_276)
                                                                    (let-values (((lst_76) a_276))
                                                                      (begin
                                                                        (check-list lst_76)
                                                                        ((letrec-values (((for-loop_35)
                                                                                          (lambda (result_41 lst_77)
                                                                                            (if (pair? lst_77)
                                                                                              (let-values (((v_50)
                                                                                                            (unsafe-car
                                                                                                             lst_77))
                                                                                                           ((rest_42)
                                                                                                            (unsafe-cdr
                                                                                                             lst_77)))
                                                                                                (let-values (((result_42)
                                                                                                              (let-values ()
                                                                                                                (let-values (((result_43)
                                                                                                                              (let-values ()
                                                                                                                                (let-values ()
                                                                                                                                  (if (pair?
                                                                                                                                       v_50)
                                                                                                                                    (if (let-values (((a_277)
                                                                                                                                                      (car
                                                                                                                                                       v_50)))
                                                                                                                                          (list?
                                                                                                                                           a_277))
                                                                                                                                      (let-values (((d_268)
                                                                                                                                                    (cdr
                                                                                                                                                     v_50)))
                                                                                                                                        (if (pair?
                                                                                                                                             d_268)
                                                                                                                                          (if (let-values (((a_278)
                                                                                                                                                            (car
                                                                                                                                                             d_268)))
                                                                                                                                                #t)
                                                                                                                                            (let-values (((d_269)
                                                                                                                                                          (cdr
                                                                                                                                                           d_268)))
                                                                                                                                              (equal?
                                                                                                                                               '()
                                                                                                                                               d_269))
                                                                                                                                            #f)
                                                                                                                                          #f))
                                                                                                                                      #f)
                                                                                                                                    #f)))))
                                                                                                                  (values
                                                                                                                   result_43)))))
                                                                                                  (if (if (not
                                                                                                           ((lambda x_12
                                                                                                              (not
                                                                                                               result_42))
                                                                                                            v_50))
                                                                                                        (not #f)
                                                                                                        #f)
                                                                                                    (for-loop_35
                                                                                                     result_42
                                                                                                     rest_42)
                                                                                                    result_42)))
                                                                                              result_41))))
                                                                           for-loop_35)
                                                                         #t
                                                                         lst_76)))
                                                                    #f))
                                                              (let-values (((d_270) (cdr d_267))) (list? d_270))
                                                              #f)
                                                            #f))
                                                        #f)
                                                      #f)
                                                  (let-values (((idss_17 rhss_58 bodys_18)
                                                                (let-values (((d_271) (cdr v_42)))
                                                                  (let-values (((idss_18 rhss_59)
                                                                                (let-values (((a_279) (car d_271)))
                                                                                  (let-values (((idss_19 rhss_60)
                                                                                                (let-values (((lst_78)
                                                                                                              a_279))
                                                                                                  (begin
                                                                                                    (check-list lst_78)
                                                                                                    ((letrec-values (((for-loop_36)
                                                                                                                      (lambda (idss_20
                                                                                                                               rhss_61
                                                                                                                               lst_79)
                                                                                                                        (if (pair?
                                                                                                                             lst_79)
                                                                                                                          (let-values (((v_51)
                                                                                                                                        (unsafe-car
                                                                                                                                         lst_79))
                                                                                                                                       ((rest_43)
                                                                                                                                        (unsafe-cdr
                                                                                                                                         lst_79)))
                                                                                                                            (let-values (((idss_21
                                                                                                                                           rhss_62)
                                                                                                                                          (let-values (((idss_22)
                                                                                                                                                        idss_20)
                                                                                                                                                       ((rhss_63)
                                                                                                                                                        rhss_61))
                                                                                                                                            (let-values (((idss_23
                                                                                                                                                           rhss_64)
                                                                                                                                                          (let-values ()
                                                                                                                                                            (let-values (((idss17_0
                                                                                                                                                                           rhss18_0)
                                                                                                                                                                          (let-values ()
                                                                                                                                                                            (let-values (((idss_24)
                                                                                                                                                                                          (let-values (((a_280)
                                                                                                                                                                                                        (car
                                                                                                                                                                                                         v_51)))
                                                                                                                                                                                            a_280))
                                                                                                                                                                                         ((rhss_65)
                                                                                                                                                                                          (let-values (((d_272)
                                                                                                                                                                                                        (cdr
                                                                                                                                                                                                         v_51)))
                                                                                                                                                                                            (let-values (((a_281)
                                                                                                                                                                                                          (car
                                                                                                                                                                                                           d_272)))
                                                                                                                                                                                              a_281))))
                                                                                                                                                                              (values
                                                                                                                                                                               idss_24
                                                                                                                                                                               rhss_65)))))
                                                                                                                                                              (values
                                                                                                                                                               (cons
                                                                                                                                                                idss17_0
                                                                                                                                                                idss_22)
                                                                                                                                                               (cons
                                                                                                                                                                rhss18_0
                                                                                                                                                                rhss_63))))))
                                                                                                                                              (values
                                                                                                                                               idss_23
                                                                                                                                               rhss_64)))))
                                                                                                                              (if (not
                                                                                                                                   #f)
                                                                                                                                (for-loop_36
                                                                                                                                 idss_21
                                                                                                                                 rhss_62
                                                                                                                                 rest_43)
                                                                                                                                (values
                                                                                                                                 idss_21
                                                                                                                                 rhss_62))))
                                                                                                                          (values
                                                                                                                           idss_20
                                                                                                                           rhss_61)))))
                                                                                                       for-loop_36)
                                                                                                     null
                                                                                                     null
                                                                                                     lst_78)))))
                                                                                    (values
                                                                                     (reverse$1 idss_19)
                                                                                     (reverse$1 rhss_60)))))
                                                                               ((bodys_19)
                                                                                (let-values (((d_273) (cdr d_271)))
                                                                                  d_273)))
                                                                    (values idss_18 rhss_59 bodys_19)))))
                                                    (left-to-right/let-values
                                                     (list*
                                                      'let-values
                                                      (let-values (((lst_80) idss_17) ((lst_81) rhss_58))
                                                        (begin
                                                          (check-list lst_80)
                                                          (check-list lst_81)
                                                          ((letrec-values (((for-loop_37)
                                                                            (lambda (lst_82 lst_83)
                                                                              (if (if (pair? lst_82) (pair? lst_83) #f)
                                                                                (let-values (((ids_36)
                                                                                              (unsafe-car lst_82))
                                                                                             ((rest_44)
                                                                                              (unsafe-cdr lst_82))
                                                                                             ((rhs_29)
                                                                                              (unsafe-car lst_83))
                                                                                             ((rest_45)
                                                                                              (unsafe-cdr lst_83)))
                                                                                  (let-values (((post-guard-var_6)
                                                                                                (lambda () #t)))
                                                                                    (let-values ()
                                                                                      (let-values (((elem_5)
                                                                                                    (let-values ()
                                                                                                      (let-values ()
                                                                                                        (list
                                                                                                         ids_36
                                                                                                         (schemify_1
                                                                                                          rhs_29))))))
                                                                                        (let-values (((result_44)
                                                                                                      (if (post-guard-var_6)
                                                                                                        (for-loop_37
                                                                                                         rest_44
                                                                                                         rest_45)
                                                                                                        null)))
                                                                                          (cons elem_5 result_44))))))
                                                                                null))))
                                                             for-loop_37)
                                                           lst_80
                                                           lst_81)))
                                                      (map2 schemify_1 bodys_18))
                                                     mutated_15))
                                                  (if (if (pair? v_42)
                                                        (if (let-values (((a_282) (car v_42)))
                                                              (equal? 'letrec-values a_282))
                                                          (let-values (((d_274) (cdr v_42)))
                                                            (if (pair? d_274)
                                                              (if (let-values (((a_283) (car d_274)))
                                                                    (if (list? a_283)
                                                                      (let-values (((lst_84) a_283))
                                                                        (begin
                                                                          (check-list lst_84)
                                                                          ((letrec-values (((for-loop_38)
                                                                                            (lambda (result_45 lst_85)
                                                                                              (if (pair? lst_85)
                                                                                                (let-values (((v_52)
                                                                                                              (unsafe-car
                                                                                                               lst_85))
                                                                                                             ((rest_46)
                                                                                                              (unsafe-cdr
                                                                                                               lst_85)))
                                                                                                  (let-values (((result_46)
                                                                                                                (let-values ()
                                                                                                                  (let-values (((result_47)
                                                                                                                                (let-values ()
                                                                                                                                  (let-values ()
                                                                                                                                    (if (pair?
                                                                                                                                         v_52)
                                                                                                                                      (if (let-values (((a_284)
                                                                                                                                                        (car
                                                                                                                                                         v_52)))
                                                                                                                                            (if (pair?
                                                                                                                                                 a_284)
                                                                                                                                              (if (let-values (((a_285)
                                                                                                                                                                (car
                                                                                                                                                                 a_284)))
                                                                                                                                                    #t)
                                                                                                                                                (let-values (((d_275)
                                                                                                                                                              (cdr
                                                                                                                                                               a_284)))
                                                                                                                                                  (equal?
                                                                                                                                                   '()
                                                                                                                                                   d_275))
                                                                                                                                                #f)
                                                                                                                                              #f))
                                                                                                                                        (let-values (((d_276)
                                                                                                                                                      (cdr
                                                                                                                                                       v_52)))
                                                                                                                                          (if (pair?
                                                                                                                                               d_276)
                                                                                                                                            (if (let-values (((a_286)
                                                                                                                                                              (car
                                                                                                                                                               d_276)))
                                                                                                                                                  #t)
                                                                                                                                              (let-values (((d_277)
                                                                                                                                                            (cdr
                                                                                                                                                             d_276)))
                                                                                                                                                (equal?
                                                                                                                                                 '()
                                                                                                                                                 d_277))
                                                                                                                                              #f)
                                                                                                                                            #f))
                                                                                                                                        #f)
                                                                                                                                      #f)))))
                                                                                                                    (values
                                                                                                                     result_47)))))
                                                                                                    (if (if (not
                                                                                                             ((lambda x_13
                                                                                                                (not
                                                                                                                 result_46))
                                                                                                              v_52))
                                                                                                          (not #f)
                                                                                                          #f)
                                                                                                      (for-loop_38
                                                                                                       result_46
                                                                                                       rest_46)
                                                                                                      result_46)))
                                                                                                result_45))))
                                                                             for-loop_38)
                                                                           #t
                                                                           lst_84)))
                                                                      #f))
                                                                (let-values (((d_278) (cdr d_274))) (list? d_278))
                                                                #f)
                                                              #f))
                                                          #f)
                                                        #f)
                                                    (let-values (((ids_37 rhss_66 bodys_20)
                                                                  (let-values (((d_279) (cdr v_42)))
                                                                    (let-values (((ids_38 rhss_67)
                                                                                  (let-values (((a_287) (car d_279)))
                                                                                    (let-values (((ids_39 rhss_68)
                                                                                                  (let-values (((lst_86)
                                                                                                                a_287))
                                                                                                    (begin
                                                                                                      (check-list
                                                                                                       lst_86)
                                                                                                      ((letrec-values (((for-loop_39)
                                                                                                                        (lambda (ids_40
                                                                                                                                 rhss_69
                                                                                                                                 lst_87)
                                                                                                                          (if (pair?
                                                                                                                               lst_87)
                                                                                                                            (let-values (((v_53)
                                                                                                                                          (unsafe-car
                                                                                                                                           lst_87))
                                                                                                                                         ((rest_47)
                                                                                                                                          (unsafe-cdr
                                                                                                                                           lst_87)))
                                                                                                                              (let-values (((ids_41
                                                                                                                                             rhss_70)
                                                                                                                                            (let-values (((ids_42)
                                                                                                                                                          ids_40)
                                                                                                                                                         ((rhss_71)
                                                                                                                                                          rhss_69))
                                                                                                                                              (let-values (((ids_43
                                                                                                                                                             rhss_72)
                                                                                                                                                            (let-values ()
                                                                                                                                                              (let-values (((ids19_0
                                                                                                                                                                             rhss20_0)
                                                                                                                                                                            (let-values ()
                                                                                                                                                                              (let-values (((ids_44)
                                                                                                                                                                                            (let-values (((a_288)
                                                                                                                                                                                                          (car
                                                                                                                                                                                                           v_53)))
                                                                                                                                                                                              (let-values (((a_289)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             a_288)))
                                                                                                                                                                                                a_289)))
                                                                                                                                                                                           ((rhss_73)
                                                                                                                                                                                            (let-values (((d_280)
                                                                                                                                                                                                          (cdr
                                                                                                                                                                                                           v_53)))
                                                                                                                                                                                              (let-values (((a_290)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             d_280)))
                                                                                                                                                                                                a_290))))
                                                                                                                                                                                (values
                                                                                                                                                                                 ids_44
                                                                                                                                                                                 rhss_73)))))
                                                                                                                                                                (values
                                                                                                                                                                 (cons
                                                                                                                                                                  ids19_0
                                                                                                                                                                  ids_42)
                                                                                                                                                                 (cons
                                                                                                                                                                  rhss20_0
                                                                                                                                                                  rhss_71))))))
                                                                                                                                                (values
                                                                                                                                                 ids_43
                                                                                                                                                 rhss_72)))))
                                                                                                                                (if (not
                                                                                                                                     #f)
                                                                                                                                  (for-loop_39
                                                                                                                                   ids_41
                                                                                                                                   rhss_70
                                                                                                                                   rest_47)
                                                                                                                                  (values
                                                                                                                                   ids_41
                                                                                                                                   rhss_70))))
                                                                                                                            (values
                                                                                                                             ids_40
                                                                                                                             rhss_69)))))
                                                                                                         for-loop_39)
                                                                                                       null
                                                                                                       null
                                                                                                       lst_86)))))
                                                                                      (values
                                                                                       (reverse$1 ids_39)
                                                                                       (reverse$1 rhss_68)))))
                                                                                 ((bodys_21)
                                                                                  (let-values (((d_281) (cdr d_279)))
                                                                                    d_281)))
                                                                      (values ids_38 rhss_67 bodys_21)))))
                                                      (let-values (((new-procs_2)
                                                                    (let-values (((lst_88) ids_37) ((lst_89) rhss_66))
                                                                      (begin
                                                                        (check-list lst_88)
                                                                        (check-list lst_89)
                                                                        ((letrec-values (((for-loop_40)
                                                                                          (lambda (proc_3 lst_90 lst_91)
                                                                                            (if (if (pair? lst_90)
                                                                                                  (pair? lst_91)
                                                                                                  #f)
                                                                                              (let-values (((id_13)
                                                                                                            (unsafe-car
                                                                                                             lst_90))
                                                                                                           ((rest_48)
                                                                                                            (unsafe-cdr
                                                                                                             lst_90))
                                                                                                           ((rhs_30)
                                                                                                            (unsafe-car
                                                                                                             lst_91))
                                                                                                           ((rest_49)
                                                                                                            (unsafe-cdr
                                                                                                             lst_91)))
                                                                                                (let-values (((proc_4)
                                                                                                              (let-values ()
                                                                                                                (let-values (((proc_5)
                                                                                                                              (let-values ()
                                                                                                                                (if (lambda?
                                                                                                                                     rhs_30)
                                                                                                                                  (hash-set
                                                                                                                                   procs_6
                                                                                                                                   id_13
                                                                                                                                   #t)
                                                                                                                                  procs_6))))
                                                                                                                  (values
                                                                                                                   proc_5)))))
                                                                                                  (if (not #f)
                                                                                                    (for-loop_40
                                                                                                     proc_4
                                                                                                     rest_48
                                                                                                     rest_49)
                                                                                                    proc_4)))
                                                                                              proc_3))))
                                                                           for-loop_40)
                                                                         procs_6
                                                                         lst_88
                                                                         lst_89)))))
                                                        (let-values (((schemify_2)
                                                                      (make-schemify
                                                                       new-procs_2
                                                                       structs_3
                                                                       mutated_15
                                                                       imports_8
                                                                       exports_6)))
                                                          (list*
                                                           'letrec*
                                                           (let-values (((lst_92) ids_37) ((lst_93) rhss_66))
                                                             (begin
                                                               (check-list lst_92)
                                                               (check-list lst_93)
                                                               ((letrec-values (((for-loop_41)
                                                                                 (lambda (lst_94 lst_95)
                                                                                   (if (if (pair? lst_94)
                                                                                         (pair? lst_95)
                                                                                         #f)
                                                                                     (let-values (((id_14)
                                                                                                   (unsafe-car lst_94))
                                                                                                  ((rest_50)
                                                                                                   (unsafe-cdr lst_94))
                                                                                                  ((rhs_31)
                                                                                                   (unsafe-car lst_95))
                                                                                                  ((rest_51)
                                                                                                   (unsafe-cdr lst_95)))
                                                                                       (let-values (((post-guard-var_7)
                                                                                                     (lambda () #t)))
                                                                                         (let-values ()
                                                                                           (let-values (((elem_6)
                                                                                                         (let-values ()
                                                                                                           (let-values ()
                                                                                                             (list
                                                                                                              id_14
                                                                                                              (schemify_2
                                                                                                               rhs_31))))))
                                                                                             (let-values (((result_48)
                                                                                                           (if (post-guard-var_7)
                                                                                                             (for-loop_41
                                                                                                              rest_50
                                                                                                              rest_51)
                                                                                                             null)))
                                                                                               (cons
                                                                                                elem_6
                                                                                                result_48))))))
                                                                                     null))))
                                                                  for-loop_41)
                                                                lst_92
                                                                lst_93)))
                                                           (map2 schemify_2 bodys_20)))))
                                                    (if (if (pair? v_42)
                                                          (if (let-values (((a_291) (car v_42)))
                                                                (equal? 'letrec-values a_291))
                                                            (let-values (((d_282) (cdr v_42)))
                                                              (if (pair? d_282)
                                                                (if (let-values (((a_292) (car d_282)))
                                                                      (if (list? a_292)
                                                                        (let-values (((lst_96) a_292))
                                                                          (begin
                                                                            (check-list lst_96)
                                                                            ((letrec-values (((for-loop_42)
                                                                                              (lambda (result_49 lst_97)
                                                                                                (if (pair? lst_97)
                                                                                                  (let-values (((v_54)
                                                                                                                (unsafe-car
                                                                                                                 lst_97))
                                                                                                               ((rest_52)
                                                                                                                (unsafe-cdr
                                                                                                                 lst_97)))
                                                                                                    (let-values (((result_50)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((result_51)
                                                                                                                                  (let-values ()
                                                                                                                                    (let-values ()
                                                                                                                                      (if (pair?
                                                                                                                                           v_54)
                                                                                                                                        (if (let-values (((a_293)
                                                                                                                                                          (car
                                                                                                                                                           v_54)))
                                                                                                                                              (list?
                                                                                                                                               a_293))
                                                                                                                                          (let-values (((d_283)
                                                                                                                                                        (cdr
                                                                                                                                                         v_54)))
                                                                                                                                            (if (pair?
                                                                                                                                                 d_283)
                                                                                                                                              (if (let-values (((a_294)
                                                                                                                                                                (car
                                                                                                                                                                 d_283)))
                                                                                                                                                    #t)
                                                                                                                                                (let-values (((d_284)
                                                                                                                                                              (cdr
                                                                                                                                                               d_283)))
                                                                                                                                                  (equal?
                                                                                                                                                   '()
                                                                                                                                                   d_284))
                                                                                                                                                #f)
                                                                                                                                              #f))
                                                                                                                                          #f)
                                                                                                                                        #f)))))
                                                                                                                      (values
                                                                                                                       result_51)))))
                                                                                                      (if (if (not
                                                                                                               ((lambda x_14
                                                                                                                  (not
                                                                                                                   result_50))
                                                                                                                v_54))
                                                                                                            (not #f)
                                                                                                            #f)
                                                                                                        (for-loop_42
                                                                                                         result_50
                                                                                                         rest_52)
                                                                                                        result_50)))
                                                                                                  result_49))))
                                                                               for-loop_42)
                                                                             #t
                                                                             lst_96)))
                                                                        #f))
                                                                  (let-values (((d_285) (cdr d_282))) (list? d_285))
                                                                  #f)
                                                                #f))
                                                            #f)
                                                          #f)
                                                      (let-values (((idss_25 rhss_74 bodys_22)
                                                                    (let-values (((d_286) (cdr v_42)))
                                                                      (let-values (((idss_26 rhss_75)
                                                                                    (let-values (((a_295) (car d_286)))
                                                                                      (let-values (((idss_27 rhss_76)
                                                                                                    (let-values (((lst_98)
                                                                                                                  a_295))
                                                                                                      (begin
                                                                                                        (check-list
                                                                                                         lst_98)
                                                                                                        ((letrec-values (((for-loop_43)
                                                                                                                          (lambda (idss_28
                                                                                                                                   rhss_77
                                                                                                                                   lst_99)
                                                                                                                            (if (pair?
                                                                                                                                 lst_99)
                                                                                                                              (let-values (((v_55)
                                                                                                                                            (unsafe-car
                                                                                                                                             lst_99))
                                                                                                                                           ((rest_53)
                                                                                                                                            (unsafe-cdr
                                                                                                                                             lst_99)))
                                                                                                                                (let-values (((idss_29
                                                                                                                                               rhss_78)
                                                                                                                                              (let-values (((idss_30)
                                                                                                                                                            idss_28)
                                                                                                                                                           ((rhss_79)
                                                                                                                                                            rhss_77))
                                                                                                                                                (let-values (((idss_31
                                                                                                                                                               rhss_80)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (let-values (((idss21_0
                                                                                                                                                                               rhss22_0)
                                                                                                                                                                              (let-values ()
                                                                                                                                                                                (let-values (((idss_32)
                                                                                                                                                                                              (let-values (((a_296)
                                                                                                                                                                                                            (car
                                                                                                                                                                                                             v_55)))
                                                                                                                                                                                                a_296))
                                                                                                                                                                                             ((rhss_81)
                                                                                                                                                                                              (let-values (((d_287)
                                                                                                                                                                                                            (cdr
                                                                                                                                                                                                             v_55)))
                                                                                                                                                                                                (let-values (((a_297)
                                                                                                                                                                                                              (car
                                                                                                                                                                                                               d_287)))
                                                                                                                                                                                                  a_297))))
                                                                                                                                                                                  (values
                                                                                                                                                                                   idss_32
                                                                                                                                                                                   rhss_81)))))
                                                                                                                                                                  (values
                                                                                                                                                                   (cons
                                                                                                                                                                    idss21_0
                                                                                                                                                                    idss_30)
                                                                                                                                                                   (cons
                                                                                                                                                                    rhss22_0
                                                                                                                                                                    rhss_79))))))
                                                                                                                                                  (values
                                                                                                                                                   idss_31
                                                                                                                                                   rhss_80)))))
                                                                                                                                  (if (not
                                                                                                                                       #f)
                                                                                                                                    (for-loop_43
                                                                                                                                     idss_29
                                                                                                                                     rhss_78
                                                                                                                                     rest_53)
                                                                                                                                    (values
                                                                                                                                     idss_29
                                                                                                                                     rhss_78))))
                                                                                                                              (values
                                                                                                                               idss_28
                                                                                                                               rhss_77)))))
                                                                                                           for-loop_43)
                                                                                                         null
                                                                                                         null
                                                                                                         lst_98)))))
                                                                                        (values
                                                                                         (reverse$1 idss_27)
                                                                                         (reverse$1 rhss_76)))))
                                                                                   ((bodys_23)
                                                                                    (let-values (((d_288) (cdr d_286)))
                                                                                      d_288)))
                                                                        (values idss_26 rhss_75 bodys_23)))))
                                                        (list*
                                                         'letrec*
                                                         (apply
                                                          append
                                                          (let-values (((lst_100) idss_25) ((lst_101) rhss_74))
                                                            (begin
                                                              (check-list lst_100)
                                                              (check-list lst_101)
                                                              ((letrec-values (((for-loop_44)
                                                                                (lambda (lst_102 lst_103)
                                                                                  (if (if (pair? lst_102)
                                                                                        (pair? lst_103)
                                                                                        #f)
                                                                                    (let-values (((ids_45)
                                                                                                  (unsafe-car lst_102))
                                                                                                 ((rest_54)
                                                                                                  (unsafe-cdr lst_102))
                                                                                                 ((rhs_32)
                                                                                                  (unsafe-car lst_103))
                                                                                                 ((rest_55)
                                                                                                  (unsafe-cdr lst_103)))
                                                                                      (let-values (((post-guard-var_8)
                                                                                                    (lambda () #t)))
                                                                                        (let-values ()
                                                                                          (let-values (((elem_7)
                                                                                                        (let-values ()
                                                                                                          (let-values ()
                                                                                                            (let-values (((rhs_33)
                                                                                                                          (schemify_1
                                                                                                                           rhs_32)))
                                                                                                              (if (null?
                                                                                                                   ids_45)
                                                                                                                (let-values ()
                                                                                                                  (list
                                                                                                                   (list
                                                                                                                    (gensym
                                                                                                                     "lr")
                                                                                                                    (make-let-values
                                                                                                                     null
                                                                                                                     rhs_33
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
                                                                                                                      rhs_33)))
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((lr_0)
                                                                                                                                  (gensym
                                                                                                                                   "lr")))
                                                                                                                      (list*
                                                                                                                       (list
                                                                                                                        lr_0
                                                                                                                        (make-let-values
                                                                                                                         ids_45
                                                                                                                         rhs_33
                                                                                                                         (list*
                                                                                                                          'vector
                                                                                                                          ids_45)))
                                                                                                                       (let-values (((lst_104)
                                                                                                                                     ids_45)
                                                                                                                                    ((start_1)
                                                                                                                                     0))
                                                                                                                         (begin
                                                                                                                           (check-list
                                                                                                                            lst_104)
                                                                                                                           (check-naturals
                                                                                                                            start_1)
                                                                                                                           ((letrec-values (((for-loop_45)
                                                                                                                                             (lambda (lst_105
                                                                                                                                                      pos_3)
                                                                                                                                               (if (if (pair?
                                                                                                                                                        lst_105)
                                                                                                                                                     #t
                                                                                                                                                     #f)
                                                                                                                                                 (let-values (((id_15)
                                                                                                                                                               (unsafe-car
                                                                                                                                                                lst_105))
                                                                                                                                                              ((rest_56)
                                                                                                                                                               (unsafe-cdr
                                                                                                                                                                lst_105))
                                                                                                                                                              ((pos_4)
                                                                                                                                                               pos_3))
                                                                                                                                                   (let-values (((post-guard-var_9)
                                                                                                                                                                 (lambda ()
                                                                                                                                                                   #t)))
                                                                                                                                                     (let-values ()
                                                                                                                                                       (let-values (((elem_8)
                                                                                                                                                                     (let-values ()
                                                                                                                                                                       (let-values ()
                                                                                                                                                                         (list
                                                                                                                                                                          id_15
                                                                                                                                                                          (list
                                                                                                                                                                           'vector-ref
                                                                                                                                                                           lr_0
                                                                                                                                                                           pos_4))))))
                                                                                                                                                         (let-values (((result_52)
                                                                                                                                                                       (if (post-guard-var_9)
                                                                                                                                                                         (for-loop_45
                                                                                                                                                                          rest_56
                                                                                                                                                                          (+
                                                                                                                                                                           pos_3
                                                                                                                                                                           1))
                                                                                                                                                                         null)))
                                                                                                                                                           (cons
                                                                                                                                                            elem_8
                                                                                                                                                            result_52))))))
                                                                                                                                                 null))))
                                                                                                                              for-loop_45)
                                                                                                                            lst_104
                                                                                                                            start_1)))))))))))))
                                                                                            (let-values (((result_53)
                                                                                                          (if (post-guard-var_8)
                                                                                                            (for-loop_44
                                                                                                             rest_54
                                                                                                             rest_55)
                                                                                                            null)))
                                                                                              (cons
                                                                                               elem_7
                                                                                               result_53))))))
                                                                                    null))))
                                                                 for-loop_44)
                                                               lst_100
                                                               lst_101))))
                                                         (map2 schemify_1 bodys_22)))
                                                      (if (if (pair? v_42)
                                                            (if (let-values (((a_298) (car v_42))) (equal? 'if a_298))
                                                              (let-values (((d_289) (cdr v_42)))
                                                                (if (pair? d_289)
                                                                  (if (let-values (((a_299) (car d_289))) #t)
                                                                    (let-values (((d_290) (cdr d_289)))
                                                                      (if (pair? d_290)
                                                                        (if (let-values (((a_300) (car d_290))) #t)
                                                                          (let-values (((d_291) (cdr d_290)))
                                                                            (if (pair? d_291)
                                                                              (if (let-values (((a_301) (car d_291)))
                                                                                    #t)
                                                                                (let-values (((d_292) (cdr d_291)))
                                                                                  (equal? '() d_292))
                                                                                #f)
                                                                              #f))
                                                                          #f)
                                                                        #f))
                                                                    #f)
                                                                  #f))
                                                              #f)
                                                            #f)
                                                        (let-values (((tst_0 thn_0 els_0)
                                                                      (let-values (((d_293) (cdr v_42)))
                                                                        (let-values (((tst_1)
                                                                                      (let-values (((a_302)
                                                                                                    (car d_293)))
                                                                                        a_302))
                                                                                     ((thn_1 els_1)
                                                                                      (let-values (((d_294)
                                                                                                    (cdr d_293)))
                                                                                        (let-values (((thn_2)
                                                                                                      (let-values (((a_303)
                                                                                                                    (car
                                                                                                                     d_294)))
                                                                                                        a_303))
                                                                                                     ((els_2)
                                                                                                      (let-values (((d_295)
                                                                                                                    (cdr
                                                                                                                     d_294)))
                                                                                                        (let-values (((a_304)
                                                                                                                      (car
                                                                                                                       d_295)))
                                                                                                          a_304))))
                                                                                          (values thn_2 els_2)))))
                                                                          (values tst_1 thn_1 els_1)))))
                                                          (list
                                                           'if
                                                           (schemify_1 tst_0)
                                                           (schemify_1 thn_0)
                                                           (schemify_1 els_0)))
                                                        (if (if (pair? v_42)
                                                              (if (let-values (((a_305) (car v_42)))
                                                                    (equal? 'with-continuation-mark a_305))
                                                                (let-values (((d_296) (cdr v_42)))
                                                                  (if (pair? d_296)
                                                                    (if (let-values (((a_306) (car d_296))) #t)
                                                                      (let-values (((d_297) (cdr d_296)))
                                                                        (if (pair? d_297)
                                                                          (if (let-values (((a_307) (car d_297))) #t)
                                                                            (let-values (((d_298) (cdr d_297)))
                                                                              (if (pair? d_298)
                                                                                (if (let-values (((a_308) (car d_298)))
                                                                                      #t)
                                                                                  (let-values (((d_299) (cdr d_298)))
                                                                                    (equal? '() d_299))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                      #f)
                                                                    #f))
                                                                #f)
                                                              #f)
                                                          (let-values (((key_0 val_0 body_18)
                                                                        (let-values (((d_300) (cdr v_42)))
                                                                          (let-values (((key_1)
                                                                                        (let-values (((a_309)
                                                                                                      (car d_300)))
                                                                                          a_309))
                                                                                       ((val_1 body_19)
                                                                                        (let-values (((d_301)
                                                                                                      (cdr d_300)))
                                                                                          (let-values (((val_2)
                                                                                                        (let-values (((a_310)
                                                                                                                      (car
                                                                                                                       d_301)))
                                                                                                          a_310))
                                                                                                       ((body_20)
                                                                                                        (let-values (((d_302)
                                                                                                                      (cdr
                                                                                                                       d_301)))
                                                                                                          (let-values (((a_311)
                                                                                                                        (car
                                                                                                                         d_302)))
                                                                                                            a_311))))
                                                                                            (values val_2 body_20)))))
                                                                            (values key_1 val_1 body_19)))))
                                                            (list
                                                             'with-continuation-mark
                                                             (schemify_1 key_0)
                                                             (schemify_1 val_0)
                                                             (schemify_1 body_18)))
                                                          (if (if (pair? v_42)
                                                                (if (let-values (((a_312) (car v_42)))
                                                                      (equal? 'begin a_312))
                                                                  (let-values (((d_303) (cdr v_42))) (list? d_303))
                                                                  #f)
                                                                #f)
                                                            (let-values (((exps_0)
                                                                          (let-values (((d_304) (cdr v_42))) d_304)))
                                                              (list* 'begin (map2 schemify_1 exps_0)))
                                                            (if (if (pair? v_42)
                                                                  (if (let-values (((a_313) (car v_42)))
                                                                        (equal? 'begin0 a_313))
                                                                    (let-values (((d_305) (cdr v_42))) (list? d_305))
                                                                    #f)
                                                                  #f)
                                                              (let-values (((exps_1)
                                                                            (let-values (((d_306) (cdr v_42))) d_306)))
                                                                (list* 'begin0 (map2 schemify_1 exps_1)))
                                                              (if (if (pair? v_42)
                                                                    (if (let-values (((a_314) (car v_42)))
                                                                          (equal? 'set! a_314))
                                                                      (let-values (((d_307) (cdr v_42)))
                                                                        (if (pair? d_307)
                                                                          (if (let-values (((a_315) (car d_307))) #t)
                                                                            (let-values (((d_308) (cdr d_307)))
                                                                              (if (pair? d_308)
                                                                                (if (let-values (((a_316) (car d_308)))
                                                                                      #t)
                                                                                  (let-values (((d_309) (cdr d_308)))
                                                                                    (equal? '() d_309))
                                                                                  #f)
                                                                                #f))
                                                                            #f)
                                                                          #f))
                                                                      #f)
                                                                    #f)
                                                                (let-values (((id_16 rhs_34)
                                                                              (let-values (((d_310) (cdr v_42)))
                                                                                (let-values (((id_17)
                                                                                              (let-values (((a_317)
                                                                                                            (car
                                                                                                             d_310)))
                                                                                                a_317))
                                                                                             ((rhs_35)
                                                                                              (let-values (((d_311)
                                                                                                            (cdr
                                                                                                             d_310)))
                                                                                                (let-values (((a_318)
                                                                                                              (car
                                                                                                               d_311)))
                                                                                                  a_318))))
                                                                                  (values id_17 rhs_35)))))
                                                                  (let-values (((ex-id_0)
                                                                                (hash-ref exports_6 id_16 #f)))
                                                                    (if ex-id_0
                                                                      (list 'variable-set! ex-id_0 (schemify_1 rhs_34))
                                                                      (list 'set! id_16 (schemify_1 rhs_34)))))
                                                                (if (if (pair? v_42)
                                                                      (if (let-values (((a_319) (car v_42)))
                                                                            (equal?
                                                                             'variable-reference-constant?
                                                                             a_319))
                                                                        (let-values (((d_312) (cdr v_42)))
                                                                          (if (pair? d_312)
                                                                            (if (let-values (((a_320) (car d_312)))
                                                                                  (if (pair? a_320)
                                                                                    (if (let-values (((a_321)
                                                                                                      (car a_320)))
                                                                                          (equal?
                                                                                           '#%variable-reference
                                                                                           a_321))
                                                                                      (let-values (((d_313)
                                                                                                    (cdr a_320)))
                                                                                        (if (pair? d_313)
                                                                                          (if (let-values (((a_322)
                                                                                                            (car
                                                                                                             d_313)))
                                                                                                #t)
                                                                                            (let-values (((d_314)
                                                                                                          (cdr d_313)))
                                                                                              (equal? '() d_314))
                                                                                            #f)
                                                                                          #f))
                                                                                      #f)
                                                                                    #f))
                                                                              (let-values (((d_315) (cdr d_312)))
                                                                                (equal? '() d_315))
                                                                              #f)
                                                                            #f))
                                                                        #f)
                                                                      #f)
                                                                  (let-values (((id_18)
                                                                                (let-values (((d_316) (cdr v_42)))
                                                                                  (let-values (((a_323) (car d_316)))
                                                                                    (let-values (((d_317) (cdr a_323)))
                                                                                      (let-values (((a_324)
                                                                                                    (car d_317)))
                                                                                        a_324))))))
                                                                    (not (hash-ref mutated_15 id_18 #f)))
                                                                  (if (if (pair? v_42)
                                                                        (if (let-values (((a_325) (car v_42)))
                                                                              (equal? '#%variable-reference a_325))
                                                                          (let-values (((d_318) (cdr v_42))) #t)
                                                                          #f)
                                                                        #f)
                                                                    (let-values () v_41)
                                                                    (if (if (pair? v_42)
                                                                          (if (let-values (((a_326) (car v_42))) #t)
                                                                            (let-values (((d_319) (cdr v_42)))
                                                                              (list? d_319))
                                                                            #f)
                                                                          #f)
                                                                      (let-values (((rator_0 exps_2)
                                                                                    (let-values (((rator_1)
                                                                                                  (let-values (((a_327)
                                                                                                                (car
                                                                                                                 v_42)))
                                                                                                    a_327))
                                                                                                 ((exps_3)
                                                                                                  (let-values (((d_320)
                                                                                                                (cdr
                                                                                                                 v_42)))
                                                                                                    d_320)))
                                                                                      (values rator_1 exps_3))))
                                                                        (let-values (((args_2)
                                                                                      (map2 schemify_1 exps_2)))
                                                                          (left-to-right/app
                                                                           (if (let-values (((or-part_6)
                                                                                             (hash-ref
                                                                                              procs_6
                                                                                              rator_0
                                                                                              #f)))
                                                                                 (if or-part_6
                                                                                   or-part_6
                                                                                   (lambda? rator_0)))
                                                                             (list* (schemify_1 rator_0) args_2)
                                                                             (list* '#%app (schemify_1 rator_0) args_2))
                                                                           mutated_15)))
                                                                      (let-values ()
                                                                        (let-values (((c1_0)
                                                                                      (if (symbol? v_41)
                                                                                        (if (hash-ref
                                                                                             mutated_15
                                                                                             v_41
                                                                                             #f)
                                                                                          (hash-ref exports_6 v_41 #f)
                                                                                          #f)
                                                                                        #f)))
                                                                          (if c1_0
                                                                            ((lambda (ex-id_1)
                                                                               (list 'variable-ref ex-id_1))
                                                                             c1_0)
                                                                            (let-values (((c2_0)
                                                                                          (if (symbol? v_41)
                                                                                            (hash-ref imports_8 v_41 #f)
                                                                                            #f)))
                                                                              (if c2_0
                                                                                ((lambda (im-id_0)
                                                                                   (list 'variable-ref im-id_0))
                                                                                 c2_0)
                                                                                (let-values ()
                                                                                  v_41)))))))))))))))))))))))))))))))
         schemify_1)
       v_40))))
 (define-values
  (mutated-in-body)
  (lambda (l_12 exports_7)
    (let-values (((pending_0)
                  (let-values (((lst_106) l_12))
                    (begin
                      (check-list lst_106)
                      ((letrec-values (((for-loop_46)
                                        (lambda (pending_1 lst_107)
                                          (if (pair? lst_107)
                                            (let-values (((v_56) (unsafe-car lst_107)) ((rest_57) (unsafe-cdr lst_107)))
                                              (let-values (((pending_2)
                                                            (let-values (((pending_3) pending_1))
                                                              (let-values (((pending_4)
                                                                            (let-values ()
                                                                              (let-values (((v_57) v_56))
                                                                                (if (if (pair? v_57)
                                                                                      (if (let-values (((a_328)
                                                                                                        (car v_57)))
                                                                                            (equal?
                                                                                             'define-values
                                                                                             a_328))
                                                                                        (let-values (((d_321)
                                                                                                      (cdr v_57)))
                                                                                          (if (pair? d_321)
                                                                                            (if (let-values (((a_329)
                                                                                                              (car
                                                                                                               d_321)))
                                                                                                  #t)
                                                                                              (let-values (((d_322)
                                                                                                            (cdr
                                                                                                             d_321)))
                                                                                                (if (pair? d_322)
                                                                                                  (if (let-values (((a_330)
                                                                                                                    (car
                                                                                                                     d_322)))
                                                                                                        #t)
                                                                                                    (let-values (((d_323)
                                                                                                                  (cdr
                                                                                                                   d_322)))
                                                                                                      (equal?
                                                                                                       '()
                                                                                                       d_323))
                                                                                                    #f)
                                                                                                  #f))
                                                                                              #f)
                                                                                            #f))
                                                                                        #f)
                                                                                      #f)
                                                                                  (let-values (((ids_46 rhs_36)
                                                                                                (let-values (((d_324)
                                                                                                              (cdr
                                                                                                               v_57)))
                                                                                                  (let-values (((ids_47)
                                                                                                                (let-values (((a_331)
                                                                                                                              (car
                                                                                                                               d_324)))
                                                                                                                  a_331))
                                                                                                               ((rhs_37)
                                                                                                                (let-values (((d_325)
                                                                                                                              (cdr
                                                                                                                               d_324)))
                                                                                                                  (let-values (((a_332)
                                                                                                                                (car
                                                                                                                                 d_325)))
                                                                                                                    a_332))))
                                                                                                    (values
                                                                                                     ids_47
                                                                                                     rhs_37)))))
                                                                                    (let-values (((lst_108) ids_46))
                                                                                      (begin
                                                                                        (check-list lst_108)
                                                                                        ((letrec-values (((for-loop_47)
                                                                                                          (lambda (pending_5
                                                                                                                   lst_109)
                                                                                                            (if (pair?
                                                                                                                 lst_109)
                                                                                                              (let-values (((id_19)
                                                                                                                            (unsafe-car
                                                                                                                             lst_109))
                                                                                                                           ((rest_58)
                                                                                                                            (unsafe-cdr
                                                                                                                             lst_109)))
                                                                                                                (let-values (((pending_6)
                                                                                                                              (let-values (((pending_7)
                                                                                                                                            pending_5))
                                                                                                                                (let-values (((pending_8)
                                                                                                                                              (let-values ()
                                                                                                                                                (if (hash-ref
                                                                                                                                                     exports_7
                                                                                                                                                     id_19
                                                                                                                                                     #f)
                                                                                                                                                  (hash-set
                                                                                                                                                   pending_7
                                                                                                                                                   id_19
                                                                                                                                                   #t)
                                                                                                                                                  pending_7))))
                                                                                                                                  (values
                                                                                                                                   pending_8)))))
                                                                                                                  (if (not
                                                                                                                       #f)
                                                                                                                    (for-loop_47
                                                                                                                     pending_6
                                                                                                                     rest_58)
                                                                                                                    pending_6)))
                                                                                                              pending_5))))
                                                                                           for-loop_47)
                                                                                         pending_3
                                                                                         lst_108))))
                                                                                  (let-values () pending_3))))))
                                                                (values pending_4)))))
                                                (if (not #f) (for-loop_46 pending_2 rest_57) pending_2)))
                                            pending_1))))
                         for-loop_46)
                       exports_7
                       lst_106)))))
      ((letrec-values (((loop_9)
                        (lambda (mutated_16 l_13 delay-l_0 pending_9)
                          (if (null? l_13)
                            (let-values ()
                              (let-values (((lst_110) delay-l_0))
                                (begin
                                  (check-list lst_110)
                                  ((letrec-values (((for-loop_48)
                                                    (lambda (mutated_17 lst_111)
                                                      (if (pair? lst_111)
                                                        (let-values (((v_58) (unsafe-car lst_111))
                                                                     ((rest_59) (unsafe-cdr lst_111)))
                                                          (let-values (((mutated_18)
                                                                        (let-values (((mutated_19) mutated_17))
                                                                          (let-values (((mutated_20)
                                                                                        (let-values ()
                                                                                          (find-mutated
                                                                                           v_58
                                                                                           mutated_19
                                                                                           pending_9))))
                                                                            (values mutated_20)))))
                                                            (if (not #f) (for-loop_48 mutated_18 rest_59) mutated_18)))
                                                        mutated_17))))
                                     for-loop_48)
                                   mutated_16
                                   lst_110))))
                            (let-values ()
                              (let-values (((form_0) (car l_13)))
                                (let-values (((v_59) form_0))
                                  (if (if (pair? v_59)
                                        (if (let-values (((a_333) (car v_59))) (equal? 'define-values a_333))
                                          (let-values (((d_326) (cdr v_59)))
                                            (if (pair? d_326)
                                              (if (let-values (((a_334) (car d_326))) #t)
                                                (let-values (((d_327) (cdr d_326)))
                                                  (if (pair? d_327)
                                                    (if (let-values (((a_335) (car d_327))) #t)
                                                      (let-values (((d_328) (cdr d_327))) (equal? '() d_328))
                                                      #f)
                                                    #f))
                                                #f)
                                              #f))
                                          #f)
                                        #f)
                                    (let-values (((ids_48 rhs_38)
                                                  (let-values (((d_329) (cdr v_59)))
                                                    (let-values (((ids_49) (let-values (((a_336) (car d_329))) a_336))
                                                                 ((rhs_39)
                                                                  (let-values (((d_330) (cdr d_329)))
                                                                    (let-values (((a_337) (car d_330))) a_337))))
                                                      (values ids_49 rhs_39)))))
                                      (let-values (((next-pending_0)
                                                    (let-values (((lst_112) ids_48))
                                                      (begin
                                                        (check-list lst_112)
                                                        ((letrec-values (((for-loop_49)
                                                                          (lambda (pending_10 lst_113)
                                                                            (if (pair? lst_113)
                                                                              (let-values (((id_20)
                                                                                            (unsafe-car lst_113))
                                                                                           ((rest_60)
                                                                                            (unsafe-cdr lst_113)))
                                                                                (let-values (((pending_11)
                                                                                              (let-values (((pending_12)
                                                                                                            pending_10))
                                                                                                (let-values (((pending_13)
                                                                                                              (let-values ()
                                                                                                                (hash-remove
                                                                                                                 pending_12
                                                                                                                 id_20))))
                                                                                                  (values
                                                                                                   pending_13)))))
                                                                                  (if (not #f)
                                                                                    (for-loop_49 pending_11 rest_60)
                                                                                    pending_11)))
                                                                              pending_10))))
                                                           for-loop_49)
                                                         pending_9
                                                         lst_112)))))
                                        (if (lambda? rhs_38)
                                          (loop_9 mutated_16 (cdr l_13) (cons rhs_38 delay-l_0) next-pending_0)
                                          (let-values (((mutated_21)
                                                        (let-values (((lst_114) delay-l_0))
                                                          (begin
                                                            (check-list lst_114)
                                                            ((letrec-values (((for-loop_50)
                                                                              (lambda (mutated_22 lst_115)
                                                                                (if (pair? lst_115)
                                                                                  (let-values (((v_60)
                                                                                                (unsafe-car lst_115))
                                                                                               ((rest_61)
                                                                                                (unsafe-cdr lst_115)))
                                                                                    (let-values (((mutated_23)
                                                                                                  (let-values (((mutated_24)
                                                                                                                mutated_22))
                                                                                                    (let-values (((mutated_25)
                                                                                                                  (let-values ()
                                                                                                                    (find-mutated
                                                                                                                     v_60
                                                                                                                     mutated_24
                                                                                                                     pending_9))))
                                                                                                      (values
                                                                                                       mutated_25)))))
                                                                                      (if (not #f)
                                                                                        (for-loop_50 mutated_23 rest_61)
                                                                                        mutated_23)))
                                                                                  mutated_22))))
                                                               for-loop_50)
                                                             mutated_16
                                                             lst_114)))))
                                            (loop_9
                                             (find-mutated rhs_38 mutated_21 pending_9)
                                             (cdr l_13)
                                             null
                                             next-pending_0)))))
                                    (let-values ()
                                      (let-values (((mutated_26)
                                                    (let-values (((lst_116) delay-l_0))
                                                      (begin
                                                        (check-list lst_116)
                                                        ((letrec-values (((for-loop_51)
                                                                          (lambda (mutated_27 lst_117)
                                                                            (if (pair? lst_117)
                                                                              (let-values (((v_61) (unsafe-car lst_117))
                                                                                           ((rest_62)
                                                                                            (unsafe-cdr lst_117)))
                                                                                (let-values (((mutated_28)
                                                                                              (let-values (((mutated_29)
                                                                                                            mutated_27))
                                                                                                (let-values (((mutated_30)
                                                                                                              (let-values ()
                                                                                                                (find-mutated
                                                                                                                 v_61
                                                                                                                 mutated_29
                                                                                                                 pending_9))))
                                                                                                  (values
                                                                                                   mutated_30)))))
                                                                                  (if (not #f)
                                                                                    (for-loop_51 mutated_28 rest_62)
                                                                                    mutated_28)))
                                                                              mutated_27))))
                                                           for-loop_51)
                                                         mutated_16
                                                         lst_116)))))
                                        (loop_9
                                         (find-mutated form_0 mutated_26 pending_9)
                                         (cdr l_13)
                                         null
                                         pending_9)))))))))))
         loop_9)
       (hasheq)
       l_12
       null
       pending_0))))
 (define-values
  (find-mutated)
  (lambda (v_62 mutated_31 pending_14)
    (let-values (((v_63) v_62))
      (if (if (pair? v_63)
            (if (let-values (((a_338) (car v_63))) (equal? 'lambda a_338))
              (let-values (((d_331) (cdr v_63)))
                (if (pair? d_331)
                  (if (let-values (((a_339) (car d_331))) #t) (let-values (((d_332) (cdr d_331))) (list? d_332)) #f)
                  #f))
              #f)
            #f)
        (let-values (((formals_3 body_21)
                      (let-values (((d_333) (cdr v_63)))
                        (let-values (((formals_4) (let-values (((a_340) (car d_333))) a_340))
                                     ((body_22) (let-values (((d_334) (cdr d_333))) d_334)))
                          (values formals_4 body_22)))))
          (find-mutated* body_21 mutated_31 pending_14))
        (if (if (pair? v_63)
              (if (let-values (((a_341) (car v_63))) (equal? 'case-lambda a_341))
                (let-values (((d_335) (cdr v_63)))
                  (if (list? d_335)
                    (let-values (((lst_118) d_335))
                      (begin
                        (check-list lst_118)
                        ((letrec-values (((for-loop_52)
                                          (lambda (result_54 lst_119)
                                            (if (pair? lst_119)
                                              (let-values (((v_64) (unsafe-car lst_119))
                                                           ((rest_63) (unsafe-cdr lst_119)))
                                                (let-values (((result_55)
                                                              (let-values ()
                                                                (let-values (((result_56)
                                                                              (let-values ()
                                                                                (let-values ()
                                                                                  (if (pair? v_64)
                                                                                    (if (let-values (((a_342)
                                                                                                      (car v_64)))
                                                                                          #t)
                                                                                      (let-values (((d_336) (cdr v_64)))
                                                                                        (list? d_336))
                                                                                      #f)
                                                                                    #f)))))
                                                                  (values result_56)))))
                                                  (if (if (not ((lambda x_15 (not result_55)) v_64)) (not #f) #f)
                                                    (for-loop_52 result_55 rest_63)
                                                    result_55)))
                                              result_54))))
                           for-loop_52)
                         #t
                         lst_118)))
                    #f))
                #f)
              #f)
          (let-values (((formalss_7 bodys_24)
                        (let-values (((d_337) (cdr v_63)))
                          (let-values (((formalss_8 bodys_25)
                                        (let-values (((lst_120) d_337))
                                          (begin
                                            (check-list lst_120)
                                            ((letrec-values (((for-loop_53)
                                                              (lambda (formalss_9 bodys_26 lst_121)
                                                                (if (pair? lst_121)
                                                                  (let-values (((v_65) (unsafe-car lst_121))
                                                                               ((rest_64) (unsafe-cdr lst_121)))
                                                                    (let-values (((formalss_10 bodys_27)
                                                                                  (let-values (((formalss_11)
                                                                                                formalss_9)
                                                                                               ((bodys_28) bodys_26))
                                                                                    (let-values (((formalss_12 bodys_29)
                                                                                                  (let-values ()
                                                                                                    (let-values (((formalss23_0
                                                                                                                   bodys24_0)
                                                                                                                  (let-values ()
                                                                                                                    (let-values (((formalss_13)
                                                                                                                                  (let-values (((a_343)
                                                                                                                                                (car
                                                                                                                                                 v_65)))
                                                                                                                                    a_343))
                                                                                                                                 ((bodys_30)
                                                                                                                                  (let-values (((d_338)
                                                                                                                                                (cdr
                                                                                                                                                 v_65)))
                                                                                                                                    d_338)))
                                                                                                                      (values
                                                                                                                       formalss_13
                                                                                                                       bodys_30)))))
                                                                                                      (values
                                                                                                       (cons
                                                                                                        formalss23_0
                                                                                                        formalss_11)
                                                                                                       (cons
                                                                                                        bodys24_0
                                                                                                        bodys_28))))))
                                                                                      (values formalss_12 bodys_29)))))
                                                                      (if (not #f)
                                                                        (for-loop_53 formalss_10 bodys_27 rest_64)
                                                                        (values formalss_10 bodys_27))))
                                                                  (values formalss_9 bodys_26)))))
                                               for-loop_53)
                                             null
                                             null
                                             lst_120)))))
                            (values (reverse$1 formalss_8) (reverse$1 bodys_25))))))
            (let-values (((lst_122) bodys_24))
              (begin
                (check-list lst_122)
                ((letrec-values (((for-loop_54)
                                  (lambda (mutated_32 lst_123)
                                    (if (pair? lst_123)
                                      (let-values (((body_23) (unsafe-car lst_123)) ((rest_65) (unsafe-cdr lst_123)))
                                        (let-values (((mutated_33)
                                                      (let-values (((mutated_34) mutated_32))
                                                        (let-values (((mutated_35)
                                                                      (let-values ()
                                                                        (find-mutated* body_23 mutated_34 pending_14))))
                                                          (values mutated_35)))))
                                          (if (not #f) (for-loop_54 mutated_33 rest_65) mutated_33)))
                                      mutated_32))))
                   for-loop_54)
                 mutated_31
                 lst_122))))
          (if (if (pair? v_63)
                (if (let-values (((a_344) (car v_63))) (equal? 'define-values a_344))
                  (let-values (((d_339) (cdr v_63)))
                    (if (pair? d_339)
                      (if (let-values (((a_345) (car d_339))) #t)
                        (let-values (((d_340) (cdr d_339)))
                          (if (pair? d_340)
                            (if (let-values (((a_346) (car d_340))) #t)
                              (let-values (((d_341) (cdr d_340))) (equal? '() d_341))
                              #f)
                            #f))
                        #f)
                      #f))
                  #f)
                #f)
            (let-values (((ids_50 rhs_40)
                          (let-values (((d_342) (cdr v_63)))
                            (let-values (((ids_51) (let-values (((a_347) (car d_342))) a_347))
                                         ((rhs_41)
                                          (let-values (((d_343) (cdr d_342)))
                                            (let-values (((a_348) (car d_343))) a_348))))
                              (values ids_51 rhs_41)))))
              (find-mutated rhs_40 mutated_31 pending_14))
            (if (if (pair? v_63)
                  (if (let-values (((a_349) (car v_63))) (equal? 'quote a_349))
                    (let-values (((d_344) (cdr v_63)))
                      (if (pair? d_344)
                        (if (let-values (((a_350) (car d_344))) #t)
                          (let-values (((d_345) (cdr d_344))) (equal? '() d_345))
                          #f)
                        #f))
                    #f)
                  #f)
              (let-values () mutated_31)
              (if (if (pair? v_63)
                    (if (let-values (((a_351) (car v_63))) (equal? 'let-values a_351))
                      (let-values (((d_346) (cdr v_63)))
                        (if (pair? d_346)
                          (if (let-values (((a_352) (car d_346)))
                                (if (list? a_352)
                                  (let-values (((lst_124) a_352))
                                    (begin
                                      (check-list lst_124)
                                      ((letrec-values (((for-loop_55)
                                                        (lambda (result_57 lst_125)
                                                          (if (pair? lst_125)
                                                            (let-values (((v_66) (unsafe-car lst_125))
                                                                         ((rest_66) (unsafe-cdr lst_125)))
                                                              (let-values (((result_58)
                                                                            (let-values ()
                                                                              (let-values (((result_59)
                                                                                            (let-values ()
                                                                                              (let-values ()
                                                                                                (if (pair? v_66)
                                                                                                  (if (let-values (((a_353)
                                                                                                                    (car
                                                                                                                     v_66)))
                                                                                                        (if (pair?
                                                                                                             a_353)
                                                                                                          (if (let-values (((a_354)
                                                                                                                            (car
                                                                                                                             a_353)))
                                                                                                                #t)
                                                                                                            (let-values (((d_347)
                                                                                                                          (cdr
                                                                                                                           a_353)))
                                                                                                              (equal?
                                                                                                               '()
                                                                                                               d_347))
                                                                                                            #f)
                                                                                                          #f))
                                                                                                    (let-values (((d_348)
                                                                                                                  (cdr
                                                                                                                   v_66)))
                                                                                                      (if (pair? d_348)
                                                                                                        (if (let-values (((a_355)
                                                                                                                          (car
                                                                                                                           d_348)))
                                                                                                              #t)
                                                                                                          (let-values (((d_349)
                                                                                                                        (cdr
                                                                                                                         d_348)))
                                                                                                            (equal?
                                                                                                             '()
                                                                                                             d_349))
                                                                                                          #f)
                                                                                                        #f))
                                                                                                    #f)
                                                                                                  #f)))))
                                                                                (values result_59)))))
                                                                (if (if (not ((lambda x_16 (not result_58)) v_66))
                                                                      (not #f)
                                                                      #f)
                                                                  (for-loop_55 result_58 rest_66)
                                                                  result_58)))
                                                            result_57))))
                                         for-loop_55)
                                       #t
                                       lst_124)))
                                  #f))
                            (let-values (((d_350) (cdr d_346))) (list? d_350))
                            #f)
                          #f))
                      #f)
                    #f)
                (let-values (((ids_52 rhss_82 bodys_31)
                              (let-values (((d_351) (cdr v_63)))
                                (let-values (((ids_53 rhss_83)
                                              (let-values (((a_356) (car d_351)))
                                                (let-values (((ids_54 rhss_84)
                                                              (let-values (((lst_126) a_356))
                                                                (begin
                                                                  (check-list lst_126)
                                                                  ((letrec-values (((for-loop_56)
                                                                                    (lambda (ids_55 rhss_85 lst_127)
                                                                                      (if (pair? lst_127)
                                                                                        (let-values (((v_67)
                                                                                                      (unsafe-car
                                                                                                       lst_127))
                                                                                                     ((rest_67)
                                                                                                      (unsafe-cdr
                                                                                                       lst_127)))
                                                                                          (let-values (((ids_56 rhss_86)
                                                                                                        (let-values (((ids_57)
                                                                                                                      ids_55)
                                                                                                                     ((rhss_87)
                                                                                                                      rhss_85))
                                                                                                          (let-values (((ids_58
                                                                                                                         rhss_88)
                                                                                                                        (let-values ()
                                                                                                                          (let-values (((ids25_0
                                                                                                                                         rhss26_0)
                                                                                                                                        (let-values ()
                                                                                                                                          (let-values (((ids_59)
                                                                                                                                                        (let-values (((a_357)
                                                                                                                                                                      (car
                                                                                                                                                                       v_67)))
                                                                                                                                                          (let-values (((a_358)
                                                                                                                                                                        (car
                                                                                                                                                                         a_357)))
                                                                                                                                                            a_358)))
                                                                                                                                                       ((rhss_89)
                                                                                                                                                        (let-values (((d_352)
                                                                                                                                                                      (cdr
                                                                                                                                                                       v_67)))
                                                                                                                                                          (let-values (((a_359)
                                                                                                                                                                        (car
                                                                                                                                                                         d_352)))
                                                                                                                                                            a_359))))
                                                                                                                                            (values
                                                                                                                                             ids_59
                                                                                                                                             rhss_89)))))
                                                                                                                            (values
                                                                                                                             (cons
                                                                                                                              ids25_0
                                                                                                                              ids_57)
                                                                                                                             (cons
                                                                                                                              rhss26_0
                                                                                                                              rhss_87))))))
                                                                                                            (values
                                                                                                             ids_58
                                                                                                             rhss_88)))))
                                                                                            (if (not #f)
                                                                                              (for-loop_56
                                                                                               ids_56
                                                                                               rhss_86
                                                                                               rest_67)
                                                                                              (values ids_56 rhss_86))))
                                                                                        (values ids_55 rhss_85)))))
                                                                     for-loop_56)
                                                                   null
                                                                   null
                                                                   lst_126)))))
                                                  (values (reverse$1 ids_54) (reverse$1 rhss_84)))))
                                             ((bodys_32) (let-values (((d_353) (cdr d_351))) d_353)))
                                  (values ids_53 rhss_83 bodys_32)))))
                  (find-mutated* bodys_31 (find-mutated* rhss_82 mutated_31 pending_14) pending_14))
                (if (if (pair? v_63)
                      (if (let-values (((a_360) (car v_63))) (equal? 'letrec-values a_360))
                        (let-values (((d_354) (cdr v_63)))
                          (if (pair? d_354)
                            (if (let-values (((a_361) (car d_354)))
                                  (if (list? a_361)
                                    (let-values (((lst_128) a_361))
                                      (begin
                                        (check-list lst_128)
                                        ((letrec-values (((for-loop_57)
                                                          (lambda (result_60 lst_129)
                                                            (if (pair? lst_129)
                                                              (let-values (((v_68) (unsafe-car lst_129))
                                                                           ((rest_68) (unsafe-cdr lst_129)))
                                                                (let-values (((result_61)
                                                                              (let-values ()
                                                                                (let-values (((result_62)
                                                                                              (let-values ()
                                                                                                (let-values ()
                                                                                                  (if (pair? v_68)
                                                                                                    (if (let-values (((a_362)
                                                                                                                      (car
                                                                                                                       v_68)))
                                                                                                          (list? a_362))
                                                                                                      (let-values (((d_355)
                                                                                                                    (cdr
                                                                                                                     v_68)))
                                                                                                        (if (pair?
                                                                                                             d_355)
                                                                                                          (if (let-values (((a_363)
                                                                                                                            (car
                                                                                                                             d_355)))
                                                                                                                #t)
                                                                                                            (let-values (((d_356)
                                                                                                                          (cdr
                                                                                                                           d_355)))
                                                                                                              (equal?
                                                                                                               '()
                                                                                                               d_356))
                                                                                                            #f)
                                                                                                          #f))
                                                                                                      #f)
                                                                                                    #f)))))
                                                                                  (values result_62)))))
                                                                  (if (if (not ((lambda x_17 (not result_61)) v_68))
                                                                        (not #f)
                                                                        #f)
                                                                    (for-loop_57 result_61 rest_68)
                                                                    result_61)))
                                                              result_60))))
                                           for-loop_57)
                                         #t
                                         lst_128)))
                                    #f))
                              (let-values (((d_357) (cdr d_354))) (list? d_357))
                              #f)
                            #f))
                        #f)
                      #f)
                  (let-values (((idss_33 rhss_90 bodys_33)
                                (let-values (((d_358) (cdr v_63)))
                                  (let-values (((idss_34 rhss_91)
                                                (let-values (((a_364) (car d_358)))
                                                  (let-values (((idss_35 rhss_92)
                                                                (let-values (((lst_130) a_364))
                                                                  (begin
                                                                    (check-list lst_130)
                                                                    ((letrec-values (((for-loop_58)
                                                                                      (lambda (idss_36 rhss_93 lst_131)
                                                                                        (if (pair? lst_131)
                                                                                          (let-values (((v_69)
                                                                                                        (unsafe-car
                                                                                                         lst_131))
                                                                                                       ((rest_69)
                                                                                                        (unsafe-cdr
                                                                                                         lst_131)))
                                                                                            (let-values (((idss_37
                                                                                                           rhss_94)
                                                                                                          (let-values (((idss_38)
                                                                                                                        idss_36)
                                                                                                                       ((rhss_95)
                                                                                                                        rhss_93))
                                                                                                            (let-values (((idss_39
                                                                                                                           rhss_96)
                                                                                                                          (let-values ()
                                                                                                                            (let-values (((idss27_0
                                                                                                                                           rhss28_0)
                                                                                                                                          (let-values ()
                                                                                                                                            (let-values (((idss_40)
                                                                                                                                                          (let-values (((a_365)
                                                                                                                                                                        (car
                                                                                                                                                                         v_69)))
                                                                                                                                                            a_365))
                                                                                                                                                         ((rhss_97)
                                                                                                                                                          (let-values (((d_359)
                                                                                                                                                                        (cdr
                                                                                                                                                                         v_69)))
                                                                                                                                                            (let-values (((a_366)
                                                                                                                                                                          (car
                                                                                                                                                                           d_359)))
                                                                                                                                                              a_366))))
                                                                                                                                              (values
                                                                                                                                               idss_40
                                                                                                                                               rhss_97)))))
                                                                                                                              (values
                                                                                                                               (cons
                                                                                                                                idss27_0
                                                                                                                                idss_38)
                                                                                                                               (cons
                                                                                                                                rhss28_0
                                                                                                                                rhss_95))))))
                                                                                                              (values
                                                                                                               idss_39
                                                                                                               rhss_96)))))
                                                                                              (if (not #f)
                                                                                                (for-loop_58
                                                                                                 idss_37
                                                                                                 rhss_94
                                                                                                 rest_69)
                                                                                                (values
                                                                                                 idss_37
                                                                                                 rhss_94))))
                                                                                          (values idss_36 rhss_93)))))
                                                                       for-loop_58)
                                                                     null
                                                                     null
                                                                     lst_130)))))
                                                    (values (reverse$1 idss_35) (reverse$1 rhss_92)))))
                                               ((bodys_34) (let-values (((d_360) (cdr d_358))) d_360)))
                                    (values idss_34 rhss_91 bodys_34)))))
                    (let-values (((new-mutated_0 simple-so-far?_0)
                                  (let-values (((lst_132) idss_33) ((lst_133) rhss_90))
                                    (begin
                                      (check-list lst_132)
                                      (check-list lst_133)
                                      ((letrec-values (((for-loop_59)
                                                        (lambda (mutated_36 simple-so-far?_1 lst_134 lst_135)
                                                          (if (if (pair? lst_134) (pair? lst_135) #f)
                                                            (let-values (((ids_60) (unsafe-car lst_134))
                                                                         ((rest_70) (unsafe-cdr lst_134))
                                                                         ((rhs_42) (unsafe-car lst_135))
                                                                         ((rest_71) (unsafe-cdr lst_135)))
                                                              (let-values (((mutated_37 simple-so-far?_2)
                                                                            (let-values (((mutated_38) mutated_36)
                                                                                         ((simple-so-far?_3)
                                                                                          simple-so-far?_1))
                                                                              (let-values (((mutated_39
                                                                                             simple-so-far?_4)
                                                                                            (let-values ()
                                                                                              (let-values (((still-simple?_0)
                                                                                                            (if simple-so-far?_3
                                                                                                              (simple?
                                                                                                               rhs_42
                                                                                                               mutated_38)
                                                                                                              #f)))
                                                                                                (if still-simple?_0
                                                                                                  (values
                                                                                                   (find-mutated
                                                                                                    rhs_42
                                                                                                    mutated_38
                                                                                                    pending_14)
                                                                                                   #t)
                                                                                                  (values
                                                                                                   (find-mutated
                                                                                                    rhs_42
                                                                                                    (let-values (((lst_136)
                                                                                                                  ids_60))
                                                                                                      (begin
                                                                                                        (check-list
                                                                                                         lst_136)
                                                                                                        ((letrec-values (((for-loop_60)
                                                                                                                          (lambda (mutated_40
                                                                                                                                   lst_137)
                                                                                                                            (if (pair?
                                                                                                                                 lst_137)
                                                                                                                              (let-values (((id_21)
                                                                                                                                            (unsafe-car
                                                                                                                                             lst_137))
                                                                                                                                           ((rest_72)
                                                                                                                                            (unsafe-cdr
                                                                                                                                             lst_137)))
                                                                                                                                (let-values (((mutated_41)
                                                                                                                                              (let-values (((mutated_42)
                                                                                                                                                            mutated_40))
                                                                                                                                                (let-values (((mutated_43)
                                                                                                                                                              (let-values ()
                                                                                                                                                                (hash-set
                                                                                                                                                                 mutated_42
                                                                                                                                                                 id_21
                                                                                                                                                                 #t))))
                                                                                                                                                  (values
                                                                                                                                                   mutated_43)))))
                                                                                                                                  (if (not
                                                                                                                                       #f)
                                                                                                                                    (for-loop_60
                                                                                                                                     mutated_41
                                                                                                                                     rest_72)
                                                                                                                                    mutated_41)))
                                                                                                                              mutated_40))))
                                                                                                           for-loop_60)
                                                                                                         mutated_38
                                                                                                         lst_136)))
                                                                                                    pending_14)
                                                                                                   #f))))))
                                                                                (values mutated_39 simple-so-far?_4)))))
                                                                (if (not #f)
                                                                  (for-loop_59
                                                                   mutated_37
                                                                   simple-so-far?_2
                                                                   rest_70
                                                                   rest_71)
                                                                  (values mutated_37 simple-so-far?_2))))
                                                            (values mutated_36 simple-so-far?_1)))))
                                         for-loop_59)
                                       mutated_31
                                       #t
                                       lst_132
                                       lst_133)))))
                      (find-mutated* bodys_33 new-mutated_0 pending_14)))
                  (if (if (pair? v_63)
                        (if (let-values (((a_367) (car v_63))) (equal? 'if a_367))
                          (let-values (((d_361) (cdr v_63)))
                            (if (pair? d_361)
                              (if (let-values (((a_368) (car d_361))) #t)
                                (let-values (((d_362) (cdr d_361)))
                                  (if (pair? d_362)
                                    (if (let-values (((a_369) (car d_362))) #t)
                                      (let-values (((d_363) (cdr d_362)))
                                        (if (pair? d_363)
                                          (if (let-values (((a_370) (car d_363))) #t)
                                            (let-values (((d_364) (cdr d_363))) (equal? '() d_364))
                                            #f)
                                          #f))
                                      #f)
                                    #f))
                                #f)
                              #f))
                          #f)
                        #f)
                    (let-values (((tst_2 thn_3 els_3)
                                  (let-values (((d_365) (cdr v_63)))
                                    (let-values (((tst_3) (let-values (((a_371) (car d_365))) a_371))
                                                 ((thn_4 els_4)
                                                  (let-values (((d_366) (cdr d_365)))
                                                    (let-values (((thn_5) (let-values (((a_372) (car d_366))) a_372))
                                                                 ((els_5)
                                                                  (let-values (((d_367) (cdr d_366)))
                                                                    (let-values (((a_373) (car d_367))) a_373))))
                                                      (values thn_5 els_5)))))
                                      (values tst_3 thn_4 els_4)))))
                      (find-mutated
                       els_3
                       (find-mutated thn_3 (find-mutated tst_2 mutated_31 pending_14) pending_14)
                       pending_14))
                    (if (if (pair? v_63)
                          (if (let-values (((a_374) (car v_63))) (equal? 'with-continuation-mark a_374))
                            (let-values (((d_368) (cdr v_63)))
                              (if (pair? d_368)
                                (if (let-values (((a_375) (car d_368))) #t)
                                  (let-values (((d_369) (cdr d_368)))
                                    (if (pair? d_369)
                                      (if (let-values (((a_376) (car d_369))) #t)
                                        (let-values (((d_370) (cdr d_369)))
                                          (if (pair? d_370)
                                            (if (let-values (((a_377) (car d_370))) #t)
                                              (let-values (((d_371) (cdr d_370))) (equal? '() d_371))
                                              #f)
                                            #f))
                                        #f)
                                      #f))
                                  #f)
                                #f))
                            #f)
                          #f)
                      (let-values (((key_2 val_3 body_24)
                                    (let-values (((d_372) (cdr v_63)))
                                      (let-values (((key_3) (let-values (((a_378) (car d_372))) a_378))
                                                   ((val_4 body_25)
                                                    (let-values (((d_373) (cdr d_372)))
                                                      (let-values (((val_5) (let-values (((a_379) (car d_373))) a_379))
                                                                   ((body_26)
                                                                    (let-values (((d_374) (cdr d_373)))
                                                                      (let-values (((a_380) (car d_374))) a_380))))
                                                        (values val_5 body_26)))))
                                        (values key_3 val_4 body_25)))))
                        (find-mutated
                         body_24
                         (find-mutated val_3 (find-mutated key_2 mutated_31 pending_14) pending_14)
                         pending_14))
                      (if (if (pair? v_63)
                            (if (let-values (((a_381) (car v_63))) (equal? 'begin a_381))
                              (let-values (((d_375) (cdr v_63))) (list? d_375))
                              #f)
                            #f)
                        (let-values (((exps_4) (let-values (((d_376) (cdr v_63))) d_376)))
                          (find-mutated* exps_4 mutated_31 pending_14))
                        (if (if (pair? v_63)
                              (if (let-values (((a_382) (car v_63))) (equal? 'begin0 a_382))
                                (let-values (((d_377) (cdr v_63))) (list? d_377))
                                #f)
                              #f)
                          (let-values (((exps_5) (let-values (((d_378) (cdr v_63))) d_378)))
                            (find-mutated* exps_5 mutated_31 pending_14))
                          (if (if (pair? v_63)
                                (if (let-values (((a_383) (car v_63))) (equal? 'set! a_383))
                                  (let-values (((d_379) (cdr v_63)))
                                    (if (pair? d_379)
                                      (if (let-values (((a_384) (car d_379))) #t)
                                        (let-values (((d_380) (cdr d_379)))
                                          (if (pair? d_380)
                                            (if (let-values (((a_385) (car d_380))) #t)
                                              (let-values (((d_381) (cdr d_380))) (equal? '() d_381))
                                              #f)
                                            #f))
                                        #f)
                                      #f))
                                  #f)
                                #f)
                            (let-values (((id_22 rhs_43)
                                          (let-values (((d_382) (cdr v_63)))
                                            (let-values (((id_23) (let-values (((a_386) (car d_382))) a_386))
                                                         ((rhs_44)
                                                          (let-values (((d_383) (cdr d_382)))
                                                            (let-values (((a_387) (car d_383))) a_387))))
                                              (values id_23 rhs_44)))))
                              (find-mutated rhs_43 (hash-set mutated_31 id_22 #t) pending_14))
                            (if (if (pair? v_63)
                                  (if (let-values (((a_388) (car v_63))) (equal? '#%variable-reference a_388))
                                    (let-values (((d_384) (cdr v_63))) #t)
                                    #f)
                                  #f)
                              (let-values () mutated_31)
                              (if (if (pair? v_63)
                                    (if (let-values (((a_389) (car v_63))) #t)
                                      (let-values (((d_385) (cdr v_63))) (list? d_385))
                                      #f)
                                    #f)
                                (let-values (((rator_2 exps_6)
                                              (let-values (((rator_3) (let-values (((a_390) (car v_63))) a_390))
                                                           ((exps_7) (let-values (((d_386) (cdr v_63))) d_386)))
                                                (values rator_3 exps_7))))
                                  (find-mutated* exps_6 (find-mutated rator_2 mutated_31 pending_14) pending_14))
                                (let-values ()
                                  (if (if (symbol? v_62) (hash-ref pending_14 v_62 #f) #f)
                                    (hash-set mutated_31 v_62 #t)
                                    mutated_31))))))))))))))))))
 (define-values
  (find-mutated*)
  (lambda (l_14 mutated_44 pending_15)
    (let-values (((lst_138) l_14))
      (begin
        (check-list lst_138)
        ((letrec-values (((for-loop_61)
                          (lambda (mutated_45 lst_139)
                            (if (pair? lst_139)
                              (let-values (((v_70) (unsafe-car lst_139)) ((rest_73) (unsafe-cdr lst_139)))
                                (let-values (((mutated_46)
                                              (let-values (((mutated_47) mutated_45))
                                                (let-values (((mutated_48)
                                                              (let-values ()
                                                                (find-mutated v_70 mutated_47 pending_15))))
                                                  (values mutated_48)))))
                                  (if (not #f) (for-loop_61 mutated_46 rest_73) mutated_46)))
                              mutated_45))))
           for-loop_61)
         mutated_44
         lst_138)))))
 (define-values
  (make-set-variables)
  (lambda (accum_2 exports_8)
    (let-values (((lst_140) accum_2))
      (begin
        (check-list lst_140)
        ((letrec-values (((for-loop_62)
                          (lambda (assigns_0 lst_141)
                            (if (pair? lst_141)
                              (let-values (((v_71) (unsafe-car lst_141)) ((rest_74) (unsafe-cdr lst_141)))
                                (let-values (((assigns_1)
                                              (let-values (((assigns_2) assigns_0))
                                                (let-values (((assigns_3)
                                                              (let-values ()
                                                                (let-values (((v_72) v_71))
                                                                  (if (if (pair? v_72)
                                                                        (if (let-values (((a_391) (car v_72)))
                                                                              (equal? 'define-values a_391))
                                                                          (let-values (((d_387) (cdr v_72)))
                                                                            (if (pair? d_387)
                                                                              (if (let-values (((a_392) (car d_387)))
                                                                                    (list? a_392))
                                                                                (let-values (((d_388) (cdr d_387)))
                                                                                  (if (pair? d_388)
                                                                                    (if (let-values (((a_393)
                                                                                                      (car d_388)))
                                                                                          #t)
                                                                                      (let-values (((d_389)
                                                                                                    (cdr d_388)))
                                                                                        (equal? '() d_389))
                                                                                      #f)
                                                                                    #f))
                                                                                #f)
                                                                              #f))
                                                                          #f)
                                                                        #f)
                                                                    (let-values (((ids_61)
                                                                                  (let-values (((d_390) (cdr v_72)))
                                                                                    (let-values (((a_394) (car d_390)))
                                                                                      a_394))))
                                                                      (let-values (((lst_142) ids_61))
                                                                        (begin
                                                                          (check-list lst_142)
                                                                          ((letrec-values (((for-loop_63)
                                                                                            (lambda (assigns_4 lst_143)
                                                                                              (if (pair? lst_143)
                                                                                                (let-values (((id_24)
                                                                                                              (unsafe-car
                                                                                                               lst_143))
                                                                                                             ((rest_75)
                                                                                                              (unsafe-cdr
                                                                                                               lst_143)))
                                                                                                  (let-values (((assigns_5)
                                                                                                                (let-values (((assigns_6)
                                                                                                                              assigns_4))
                                                                                                                  (let-values (((assigns_7)
                                                                                                                                (let-values ()
                                                                                                                                  (let-values (((ex-var_0)
                                                                                                                                                (hash-ref
                                                                                                                                                 exports_8
                                                                                                                                                 id_24
                                                                                                                                                 #f)))
                                                                                                                                    (if ex-var_0
                                                                                                                                      (cons
                                                                                                                                       (list
                                                                                                                                        'define
                                                                                                                                        (gensym)
                                                                                                                                        (list
                                                                                                                                         'variable-set!
                                                                                                                                         ex-var_0
                                                                                                                                         id_24))
                                                                                                                                       assigns_6)
                                                                                                                                      assigns_6)))))
                                                                                                                    (values
                                                                                                                     assigns_7)))))
                                                                                                    (if (not #f)
                                                                                                      (for-loop_63
                                                                                                       assigns_5
                                                                                                       rest_75)
                                                                                                      assigns_5)))
                                                                                                assigns_4))))
                                                                             for-loop_63)
                                                                           assigns_2
                                                                           lst_142))))
                                                                    (let-values () assigns_2))))))
                                                  (values assigns_3)))))
                                  (if (not #f) (for-loop_62 assigns_1 rest_74) assigns_1)))
                              assigns_0))))
           for-loop_62)
         null
         lst_140))))))
