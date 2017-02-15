(define hash661 (hasheqv))
(define hash656
  (hash
   '#vu8(112 114 105 110 116)
   '10
   '#vu8(97 115 99 105 105)
   '12
   '#vu8(98 108 97 110 107)
   '8
   '#vu8(103 114 97 112 104)
   '10
   '#vu8(100 105 103 105 116)
   '4
   '#vu8(97 108 112 104 97)
   '1
   '#vu8(99 110 116 114 108)
   '11
   '#vu8(115 112 97 99 101)
   '9
   '#vu8(117 112 112 101 114)
   '2
   '#vu8(108 111 119 101 114)
   '3
   '#vu8(119 111 114 100)
   '7
   '#vu8(97 108 110 117 109)
   '6))
(define hash657
  (hash
   '#vu8(78)
   '11
   '#vu8(77 110)
   '20
   '#vu8(76 38)
   '5
   '#vu8(76)
   '7
   '#vu8(80)
   '19
   '#vu8(67)
   '38
   '#vu8(46)
   '39
   '#vu8(76 111)
   '6
   '#vu8(80 111)
   '18
   '#vu8(76 109)
   '4
   '#vu8(67 111)
   '37
   '#vu8(90 108)
   '29
   '#vu8(80 105)
   '14
   '#vu8(78 111)
   '10
   '#vu8(80 101)
   '13
   '#vu8(90 112)
   '30
   '#vu8(80 115)
   '12
   '#vu8(77 99)
   '21
   '#vu8(76 117)
   '2
   '#vu8(67 99)
   '33
   '#vu8(90)
   '32
   '#vu8(83)
   '28
   '#vu8(67 110)
   '36
   '#vu8(77)
   '23
   '#vu8(67 102)
   '34
   '#vu8(77 101)
   '22
   '#vu8(83 109)
   '26
   '#vu8(83 107)
   '25
   '#vu8(78 108)
   '9
   '#vu8(90 115)
   '31
   '#vu8(80 100)
   '17
   '#vu8(83 111)
   '27
   '#vu8(67 115)
   '35
   '#vu8(76 108)
   '1
   '#vu8(80 102)
   '15
   '#vu8(78 100)
   '8
   '#vu8(76 116)
   '3
   '#vu8(80 99)
   '16
   '#vu8(83 99)
   '24))
(define-values
 (prop:procedure-accessor procedure-accessor? procedure-accessor-ref)
 (make-struct-type-property
  'procedure
  (lambda (v_0 info-l_0)
    (if (exact-integer? v_0)
      (make-struct-field-accessor (list-ref info-l_0 3) v_0)
      #f))))
(define-values
 (new-prop:procedure new-procedure? new-procedure-ref)
 (make-struct-type-property
  'procedure
  #f
  (list (cons prop:procedure values) (cons prop:procedure-accessor values))))
(define check-reflection-name
  (lambda (name_0 what_0)
    (begin
      (if (symbol? what_0)
        (void)
        (raise-argument-error name_0 "symbol?" what_0))
      what_0)))
(define 1/reverse
  (lambda (l_0)
    (begin
      (if (list? l_0) (void) (raise-argument-error 'reverse "list?" l_0))
      (letrec ((loop_0
                (lambda (a_0 l_1)
                  (if (null? l_1)
                    a_0
                    (loop_0 (cons (car l_1) a_0) (cdr l_1))))))
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
                      (if (procedure? (vector-ref v_1 2))
                        (procedure-arity-includes? (vector-ref v_1 2) 1)
                        #f)
                      #f)
                    #f)
                  #f)
                #f)
              #f)
            #f)
        (void)
        (raise-argument-error
         'guard-for-prop:stream
         (string-append
          "(vector/c (procedure-arity-includes/c 1)\n"
          "          (procedure-arity-includes/c 1)\n"
          "          (procedure-arity-includes/c 1))")
         v_1))
      (vector->immutable-vector v_1)))))
(define-values
 (prop:gen-sequence sequence-via-prop? sequence-ref)
 (make-struct-type-property
  'sequence
  (lambda (v_2 si_1)
    (begin
      (if (if (procedure? v_2) (procedure-arity-includes? v_2 1) #f)
        (void)
        (raise-argument-error
         'guard-for-prop:sequence
         "(procedure-arity-includes/c 1)"
         v_2))
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
     (lambda (v_3)
       (let ((cont?_0 (|#%app| range-ref v_3 2)))
         (if cont?_0 (not (|#%app| cont?_0 (|#%app| range-ref v_3 0))) #f)))
     (lambda (v_4) (|#%app| range-ref v_4 0))
     (lambda (v_5)
       (|#%app|
        make-range
        (|#%app| (|#%app| range-ref v_5 1) (|#%app| range-ref v_5 0))
        (|#%app| range-ref v_5 1)
        (|#%app| range-ref v_5 2)))))
   (cons
    prop:gen-sequence
    (lambda (v_6)
      (values
       values
       #f
       (|#%app| range-ref v_6 1)
       (|#%app| range-ref v_6 0)
       (|#%app| range-ref v_6 2)
       #f
       #f))))))
(define check-range$1
  (lambda (a_1 b_0 step_0)
    (begin
      (if (real? a_1) (void) (raise-argument-error 'in-range "real?" a_1))
      (if (real? b_0) (void) (raise-argument-error 'in-range "real?" b_0))
      (if (real? step_0)
        (void)
        (raise-argument-error 'in-range "real?" step_0)))))
(define check-naturals
  (lambda (n_0)
    (if (if (integer? n_0) (if (exact? n_0) (>= n_0 0) #f) #f)
      (void)
      (raise-argument-error 'in-naturals "exact-nonnegative-integer?" n_0))))
(define-values
 (struct:list-stream
  make-list-stream
  list-stream?
  list-stream-ref
  list-stream-set!)
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
     (lambda (v_7) (not (pair? (|#%app| list-stream-ref v_7 0))))
     (lambda (v_8) (car (|#%app| list-stream-ref v_8 0)))
     (lambda (v_9)
       (|#%app| make-list-stream (cdr (|#%app| list-stream-ref v_9 0))))))
   (cons
    prop:gen-sequence
    (lambda (v_10)
      (values car cdr values (|#%app| list-stream-ref v_10 0) pair? #f #f))))))
(define check-list
  (lambda (l_2)
    (if (list? l_2) (void) (raise-argument-error 'in-list "list?" l_2))))
(define check-in-hash-keys
  (lambda (ht_0)
    (if ((lambda (ht_1) (hash? ht_1)) ht_0)
      (void)
      (raise-argument-error 'in-hash-keys "hash?" ht_0))))
(define check-ranges
  (lambda (who_0 vec_0 start_0 stop_0 step_1 len_0)
    (begin
      (if (if (exact-nonnegative-integer? start_0)
            (let ((or-part_0 (< start_0 len_0)))
              (if or-part_0 or-part_0 (= len_0 start_0 stop_0)))
            #f)
        (void)
        (raise-range-error
         who_0
         "vector"
         "starting "
         start_0
         vec_0
         0
         (sub1 len_0)))
      (if (if (exact-integer? stop_0)
            (if (<= -1 stop_0) (<= stop_0 len_0) #f)
            #f)
        (void)
        (raise-range-error who_0 "vector" "stopping " stop_0 vec_0 -1 len_0))
      (if (if (exact-integer? step_1) (not (zero? step_1)) #f)
        (void)
        (raise-argument-error
         who_0
         "(and/c exact-integer? (not/c zero?))"
         step_1))
      (if (if (< start_0 stop_0) (< step_1 0) #f)
        (raise-arguments-error
         who_0
         "starting index less than stopping index, but given a negative step"
         "starting index"
         start_0
         "stopping index"
         stop_0
         "step"
         step_1)
        (void))
      (if (if (< stop_0 start_0) (> step_1 0) #f)
        (raise-arguments-error
         who_0
         "starting index more than stopping index, but given a positive step"
         "starting index"
         start_0
         "stopping index"
         stop_0
         "step"
         step_1)
        (void)))))
(define normalise-inputs
  (lambda (who_1
           type-name_0
           vector?_0
           unsafe-vector-length_0
           vec_1
           start_1
           stop_1
           step_2)
    (begin
      (if (|#%app| vector?_0 vec_1)
        (void)
        (raise-argument-error who_1 type-name_0 vec_1))
      (let ((len_1 (|#%app| unsafe-vector-length_0 vec_1)))
        (let ((stop*_0 (if stop_1 stop_1 len_1)))
          (begin
            (check-ranges who_1 vec_1 start_1 stop*_0 step_2 len_1)
            (values vec_1 start_1 stop*_0 step_2)))))))
(define check-vector
  (lambda (v_11)
    (if (vector? v_11)
      (void)
      (raise-argument-error 'in-vector "vector" v_11))))
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
     (lambda (v_12) (|#%app| (|#%app| do-stream-ref v_12 0)))
     (lambda (v_13) (|#%app| (|#%app| do-stream-ref v_13 1)))
     (lambda (v_14) (|#%app| (|#%app| do-stream-ref v_14 2))))))))
(define empty-stream (|#%app| make-do-stream (lambda () #t) void void))
(define map2
  (let ((map_0
         (case-lambda
          ((f_0 l_3)
           (if (if (procedure? f_0)
                 (if (procedure-arity-includes? f_0 1) (list? l_3) #f)
                 #f)
             ((letrec ((loop_1
                        (lambda (l_4)
                          (if (null? l_4)
                            null
                            (let ((r_0 (cdr l_4)))
                              (cons (|#%app| f_0 (car l_4)) (loop_1 r_0)))))))
                loop_1)
              l_3)
             (map f_0 l_3)))
          ((f_1 l1_0 l2_0)
           (if (if (procedure? f_1)
                 (if (procedure-arity-includes? f_1 2)
                   (if (list? l1_0)
                     (if (list? l2_0) (= (length l1_0) (length l2_0)) #f)
                     #f)
                   #f)
                 #f)
             ((letrec ((loop_2
                        (lambda (l1_1 l2_1)
                          (if (null? l1_1)
                            null
                            (let-values (((r1_0) (cdr l1_1))
                                         ((r2_0) (cdr l2_1)))
                              (cons
                               (|#%app| f_1 (car l1_1) (car l2_1))
                               (loop_2 r1_0 r2_0)))))))
                loop_2)
              l1_0
              l2_0)
             (map f_1 l1_0 l2_0)))
          ((f_2 l_5 . args_0) (apply map f_2 l_5 args_0)))))
    map_0))
(define ormap2
  (let ((ormap_0
         (case-lambda
          ((f_3 l_6)
           (if (if (procedure? f_3)
                 (if (procedure-arity-includes? f_3 1) (list? l_6) #f)
                 #f)
             (if (null? l_6)
               #f
               ((letrec ((loop_3
                          (lambda (l_7)
                            (if (null? (cdr l_7))
                              (|#%app| f_3 (car l_7))
                              (let ((r_1 (cdr l_7)))
                                (let ((or-part_1 (|#%app| f_3 (car l_7))))
                                  (if or-part_1 or-part_1 (loop_3 r_1))))))))
                  loop_3)
                l_6))
             (ormap f_3 l_6)))
          ((f_4 l1_2 l2_2)
           (if (if (procedure? f_4)
                 (if (procedure-arity-includes? f_4 2)
                   (if (list? l1_2)
                     (if (list? l2_2) (= (length l1_2) (length l2_2)) #f)
                     #f)
                   #f)
                 #f)
             (if (null? l1_2)
               #f
               ((letrec ((loop_4
                          (lambda (l1_3 l2_3)
                            (if (null? (cdr l1_3))
                              (|#%app| f_4 (car l1_3) (car l2_3))
                              (let-values (((r1_1) (cdr l1_3))
                                           ((r2_1) (cdr l2_3)))
                                (let ((or-part_2
                                       (|#%app| f_4 (car l1_3) (car l2_3))))
                                  (if or-part_2
                                    or-part_2
                                    (loop_4 r1_1 r2_1))))))))
                  loop_4)
                l1_2
                l2_2))
             (ormap f_4 l1_2 l2_2)))
          ((f_5 l_8 . args_1) (apply ormap f_5 l_8 args_1)))))
    ormap_0))
(define no-empty-edge-table (make-hash))
(define regexp-error-tag (make-continuation-prompt-tag 'regexp-error))
(define regexp-error
  (lambda (fmt_0 . args_2)
    (abort-current-continuation regexp-error-tag (apply format fmt_0 args_2))))
(define chytes-length$1
  (lambda (s_0) (if (bytes? s_0) (bytes-length s_0) (string-length s_0))))
(define chytes-ref$1
  (lambda (s_1 i_0)
    (if (bytes? s_1)
      (bytes-ref s_1 i_0)
      (char->integer (string-ref s_1 i_0)))))
(define chytes-ref/char
  (lambda (s_2 i_1)
    (if (bytes? s_2)
      (integer->char (bytes-ref s_2 i_1))
      (string-ref s_2 i_1))))
(define chytes-limit (lambda (s_3) (if (bytes? s_3) 255 1114111)))
(define empty-range null)
(define range-invert
  (lambda (r_2 limit-c_0)
    ((letrec ((loop_5
               (lambda (r_3 start_2)
                 (if (null? r_3)
                   (if (> start_2 limit-c_0)
                     null
                     (list (cons start_2 limit-c_0)))
                   (if (= start_2 (caar r_3))
                     (loop_5 (cdr r_3) (add1 (cdar r_3)))
                     (cons
                      (cons start_2 (sub1 (caar r_3)))
                      (loop_5 (cdr r_3) (add1 (cdar r_3)))))))))
       loop_5)
     r_2
     0)))
(define range-in?
  (lambda (r_0 v_15)
    (let ((lst_0 r_0))
      (begin
        (if (list? lst_0) (void) (check-list lst_0))
        ((letrec ((for-loop_0
                   (lambda (result_0 lst_1)
                     (if (pair? lst_1)
                       (let-values (((p_0) (unsafe-car lst_1))
                                    ((rest_0) (unsafe-cdr lst_1)))
                         (let ((result_1
                                (let ((result_2
                                       (if (>= v_15 (car p_0))
                                         (<= v_15 (cdr p_0))
                                         #f)))
                                  (values result_2))))
                           (if (if (not ((lambda x_0 result_1) p_0))
                                 (not #f)
                                 #f)
                             (for-loop_0 result_1 rest_0)
                             result_1)))
                       result_0))))
           for-loop_0)
         #f
         lst_0)))))
(define range-add
  (lambda (r_4 v_16)
    (if (not v_16)
      r_4
      (if (range-in? r_4 v_16)
        r_4
        (range-union r_4 (list (cons v_16 v_16)))))))
(define range-union
  (lambda (r1_2 r2_2)
    (if (null? r1_2)
      r2_2
      (if (null? r2_2)
        r1_2
        (if (<= (caar r1_2) (caar r2_2))
          (if (>= (add1 (cdar r1_2)) (caar r2_2))
            (if (<= (cdar r1_2) (cdar r2_2))
              (range-union
               (cons (cons (caar r1_2) (cdar r2_2)) (cdr r2_2))
               (cdr r1_2))
              (range-union r1_2 (cdr r2_2)))
            (cons (car r1_2) (range-union (cdr r1_2) r2_2)))
          (range-union r2_2 r1_2))))))
(define range-add-span
  (lambda (range_0 from-c_0 to-c_0)
    (range-union range_0 (list (cons from-c_0 to-c_0)))))
(define range-singleton
  (lambda (range_1)
    (if (pair? range_1)
      (if (null? (cdr range_1))
        (if (= (caar range_1) (cdar range_1)) (caar range_1) #f)
        #f)
      #f)))
(define range-includes?
  (lambda (range_2 low_0 hi_0)
    (if (null? range_2)
      null
      (if (> low_0 (cdar range_2))
        (range-includes? (cdr range_2) low_0 hi_0)
        (if (>= low_0 (caar range_2)) (<= hi_0 (cdar range_2)) #f)))))
(define range-within?
  (lambda (range_3 low_1 hi_1)
    (if (null? range_3)
      #t
      (if (< (caar range_3) low_1)
        #f
        (if (> (cdar range_3) hi_1)
          #f
          (range-within? (cdr range_3) low_1 hi_1))))))
(define range->list (lambda (range_4) range_4))
(define rngs (make-weak-hash))
(define compile-range
  (lambda (range_5)
    (let ((or-part_3 (hash-ref rngs range_5 #f)))
      (if or-part_3
        or-part_3
        (let ((rng_0 (make-bytes 256 0)))
          (begin
            (let ((lst_2 range_5))
              (begin
                (if (list? lst_2) (void) (check-list lst_2))
                ((letrec ((for-loop_1
                           (lambda (lst_3)
                             (if (pair? lst_3)
                               (let-values (((p_1) (unsafe-car lst_3))
                                            ((rest_1) (unsafe-cdr lst_3)))
                                 (let-values ((()
                                               (let-values (((start_3)
                                                             (car p_1))
                                                            ((end_0)
                                                             (add1 (cdr p_1)))
                                                            ((inc_0) 1))
                                                 (begin
                                                   (if (if (real? start_3)
                                                         (if (real? end_0)
                                                           (real? inc_0)
                                                           #f)
                                                         #f)
                                                     (void)
                                                     (check-range$1
                                                      start_3
                                                      end_0
                                                      inc_0))
                                                   ((letrec ((for-loop_2
                                                              (lambda (pos_0)
                                                                (if (<
                                                                     pos_0
                                                                     end_0)
                                                                  (let ((i_2
                                                                         pos_0))
                                                                    (let-values ((()
                                                                                  (let-values ((()
                                                                                                (begin
                                                                                                  (bytes-set!
                                                                                                   rng_0
                                                                                                   i_2
                                                                                                   1)
                                                                                                  (values))))
                                                                                    (values))))
                                                                      (if (not
                                                                           #f)
                                                                        (for-loop_2
                                                                         (+
                                                                          pos_0
                                                                          inc_0))
                                                                        (values))))
                                                                  (values)))))
                                                      for-loop_2)
                                                    start_3)))))
                                   (if (not #f) (for-loop_1 rest_1) (values))))
                               (values)))))
                   for-loop_1)
                 lst_2)))
            (void)
            (hash-set! rngs range_5 rng_0)
            rng_0))))))
(define rng-in? (lambda (rng_1 v_17) (eq? 1 (bytes-ref rng_1 v_17))))
(define rx:never 'never)
(define rx:empty 'empty)
(define rx:any 'any)
(define rx:start 'start)
(define rx:end 'end)
(define rx:line-start 'line-start)
(define rx:line-end 'line-end)
(define rx:word-boundary 'word-boundary)
(define rx:not-word-boundary 'not-word-boundary)
(define-values
 (struct:rx:alts rx:alts1.1 rx:alts? rx:alts-rx1 rx:alts-rx2)
 (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
               (make-struct-type
                'rx:alts
                #f
                2
                0
                #f
                null
                #f
                #f
                '(0 1)
                #f
                'rx:alts)))
   (values
    struct:_0
    make-_0
    ?_0
    (make-struct-field-accessor -ref_0 0 'rx1)
    (make-struct-field-accessor -ref_0 1 'rx2))))
(define-values
 (struct:rx:sequence
  rx:sequence2.1
  rx:sequence?
  rx:sequence-rxs
  rx:sequence-needs-backtrack?)
 (let-values (((struct:_1 make-_1 ?_1 -ref_1 -set!_1)
               (make-struct-type
                'rx:sequence
                #f
                2
                0
                #f
                null
                #f
                #f
                '(0 1)
                #f
                'rx:sequence)))
   (values
    struct:_1
    make-_1
    ?_1
    (make-struct-field-accessor -ref_1 0 'rxs)
    (make-struct-field-accessor -ref_1 1 'needs-backtrack?))))
(define-values
 (struct:rx:group rx:group3.1 rx:group? rx:group-rx rx:group-number)
 (let-values (((struct:_2 make-_2 ?_2 -ref_2 -set!_2)
               (make-struct-type
                'rx:group
                #f
                2
                0
                #f
                null
                #f
                #f
                '(0 1)
                #f
                'rx:group)))
   (values
    struct:_2
    make-_2
    ?_2
    (make-struct-field-accessor -ref_2 0 'rx)
    (make-struct-field-accessor -ref_2 1 'number))))
(define-values
 (struct:rx:repeat
  rx:repeat4.1
  rx:repeat?
  rx:repeat-rx
  rx:repeat-min
  rx:repeat-max
  rx:repeat-non-greedy?)
 (let-values (((struct:_3 make-_3 ?_3 -ref_3 -set!_3)
               (make-struct-type
                'rx:repeat
                #f
                4
                0
                #f
                null
                #f
                #f
                '(0 1 2 3)
                #f
                'rx:repeat)))
   (values
    struct:_3
    make-_3
    ?_3
    (make-struct-field-accessor -ref_3 0 'rx)
    (make-struct-field-accessor -ref_3 1 'min)
    (make-struct-field-accessor -ref_3 2 'max)
    (make-struct-field-accessor -ref_3 3 'non-greedy?))))
(define-values
 (struct:rx:maybe rx:maybe5.1 rx:maybe? rx:maybe-rx rx:maybe-non-greedy?)
 (let-values (((struct:_4 make-_4 ?_4 -ref_4 -set!_4)
               (make-struct-type
                'rx:maybe
                #f
                2
                0
                #f
                null
                #f
                #f
                '(0 1)
                #f
                'rx:maybe)))
   (values
    struct:_4
    make-_4
    ?_4
    (make-struct-field-accessor -ref_4 0 'rx)
    (make-struct-field-accessor -ref_4 1 'non-greedy?))))
(define-values
 (struct:rx:conditional
  rx:conditional6.1
  rx:conditional?
  rx:conditional-tst
  rx:conditional-rx1
  rx:conditional-rx2
  rx:conditional-n-start
  rx:conditional-num-n
  rx:conditional-needs-backtrack?)
 (let-values (((struct:_5 make-_5 ?_5 -ref_5 -set!_5)
               (make-struct-type
                'rx:conditional
                #f
                6
                0
                #f
                null
                #f
                #f
                '(0 1 2 3 4 5)
                #f
                'rx:conditional)))
   (values
    struct:_5
    make-_5
    ?_5
    (make-struct-field-accessor -ref_5 0 'tst)
    (make-struct-field-accessor -ref_5 1 'rx1)
    (make-struct-field-accessor -ref_5 2 'rx2)
    (make-struct-field-accessor -ref_5 3 'n-start)
    (make-struct-field-accessor -ref_5 4 'num-n)
    (make-struct-field-accessor -ref_5 5 'needs-backtrack?))))
(define-values
 (struct:rx:lookahead
  rx:lookahead7.1
  rx:lookahead?
  rx:lookahead-rx
  rx:lookahead-match?
  rx:lookahead-n-start
  rx:lookahead-num-n)
 (let-values (((struct:_6 make-_6 ?_6 -ref_6 -set!_6)
               (make-struct-type
                'rx:lookahead
                #f
                4
                0
                #f
                null
                #f
                #f
                '(0 1 2 3)
                #f
                'rx:lookahead)))
   (values
    struct:_6
    make-_6
    ?_6
    (make-struct-field-accessor -ref_6 0 'rx)
    (make-struct-field-accessor -ref_6 1 'match?)
    (make-struct-field-accessor -ref_6 2 'n-start)
    (make-struct-field-accessor -ref_6 3 'num-n))))
(define-values
 (struct:rx:lookbehind
  rx:lookbehind8.1
  rx:lookbehind?
  rx:lookbehind-rx
  rx:lookbehind-match?
  rx:lookbehind-lb-min
  rx:lookbehind-lb-max
  rx:lookbehind-n-start
  rx:lookbehind-num-n
  set-rx:lookbehind-lb-min!
  set-rx:lookbehind-lb-max!)
 (let-values (((struct:_7 make-_7 ?_7 -ref_7 -set!_7)
               (make-struct-type
                'rx:lookbehind
                #f
                6
                0
                #f
                null
                #f
                #f
                '(0 1 4 5)
                #f
                'rx:lookbehind)))
   (values
    struct:_7
    make-_7
    ?_7
    (make-struct-field-accessor -ref_7 0 'rx)
    (make-struct-field-accessor -ref_7 1 'match?)
    (make-struct-field-accessor -ref_7 2 'lb-min)
    (make-struct-field-accessor -ref_7 3 'lb-max)
    (make-struct-field-accessor -ref_7 4 'n-start)
    (make-struct-field-accessor -ref_7 5 'num-n)
    (make-struct-field-mutator -set!_7 2 'lb-min)
    (make-struct-field-mutator -set!_7 3 'lb-max))))
(define-values
 (struct:rx:cut
  rx:cut9.1
  rx:cut?
  rx:cut-rx
  rx:cut-n-start
  rx:cut-num-n
  rx:cut-needs-backtrack?)
 (let-values (((struct:_8 make-_8 ?_8 -ref_8 -set!_8)
               (make-struct-type
                'rx:cut
                #f
                4
                0
                #f
                null
                #f
                #f
                '(0 1 2 3)
                #f
                'rx:cut)))
   (values
    struct:_8
    make-_8
    ?_8
    (make-struct-field-accessor -ref_8 0 'rx)
    (make-struct-field-accessor -ref_8 1 'n-start)
    (make-struct-field-accessor -ref_8 2 'num-n)
    (make-struct-field-accessor -ref_8 3 'needs-backtrack?))))
(define-values
 (struct:rx:reference
  rx:reference10.1
  rx:reference?
  rx:reference-n
  rx:reference-case-sensitive?)
 (let-values (((struct:_9 make-_9 ?_9 -ref_9 -set!_9)
               (make-struct-type
                'rx:reference
                #f
                2
                0
                #f
                null
                #f
                #f
                '(0 1)
                #f
                'rx:reference)))
   (values
    struct:_9
    make-_9
    ?_9
    (make-struct-field-accessor -ref_9 0 'n)
    (make-struct-field-accessor -ref_9 1 'case-sensitive?))))
(define-values
 (struct:rx:range rx:range11.1 rx:range? rx:range-range)
 (let-values (((struct:_10 make-_10 ?_10 -ref_10 -set!_10)
               (make-struct-type
                'rx:range
                #f
                1
                0
                #f
                null
                #f
                #f
                '(0)
                #f
                'rx:range)))
   (values
    struct:_10
    make-_10
    ?_10
    (make-struct-field-accessor -ref_10 0 'range))))
(define-values
 (struct:rx:unicode-categories
  rx:unicode-categories12.1
  rx:unicode-categories?
  rx:unicode-categories-symlist
  rx:unicode-categories-match?)
 (let-values (((struct:_11 make-_11 ?_11 -ref_11 -set!_11)
               (make-struct-type
                'rx:unicode-categories
                #f
                2
                0
                #f
                null
                #f
                #f
                '(0 1)
                #f
                'rx:unicode-categories)))
   (values
    struct:_11
    make-_11
    ?_11
    (make-struct-field-accessor -ref_11 0 'symlist)
    (make-struct-field-accessor -ref_11 1 'match?))))
(define needs-backtrack?
  (lambda (rx_0)
    (if (|#%app| rx:alts? rx_0)
      #t
      (if (|#%app| rx:sequence? rx_0)
        (|#%app| rx:sequence-needs-backtrack? rx_0)
        (if (|#%app| rx:group? rx_0)
          #t
          (if (|#%app| rx:repeat? rx_0)
            #t
            (if (|#%app| rx:maybe? rx_0)
              #t
              (if (|#%app| rx:conditional? rx_0)
                (|#%app| rx:conditional-needs-backtrack? rx_0)
                (if (|#%app| rx:cut? rx_0)
                  (|#%app| rx:cut-needs-backtrack? rx_0)
                  (if (|#%app| rx:unicode-categories? rx_0) #t #f))))))))))
(define rx-range
  (lambda (range_6 limit-c_1)
    (let ((c1_0 (range-singleton range_6)))
      (if c1_0
        ((lambda (c_0) c_0) c1_0)
        (if (range-includes? range_6 0 limit-c_1)
          rx:any
          (|#%app| rx:range11.1 range_6))))))
(define rx-sequence
  (lambda (l_9)
    (if (null? l_9)
      rx:empty
      (if (null? (cdr l_9))
        (car l_9)
        (let ((merged-l_0 (merge-adjacent l_9)))
          (if (null? (cdr merged-l_0))
            (car merged-l_0)
            (|#%app|
             rx:sequence2.1
             merged-l_0
             (ormap2 needs-backtrack? merged-l_0))))))))
(define merge-adjacent
  (lambda (l_10)
    ((letrec ((loop_6
               (lambda (mode_0 accum_0 l_11)
                 (if (if (pair? l_11) (|#%app| rx:sequence? (car l_11)) #f)
                   (loop_6
                    mode_0
                    accum_0
                    (append (|#%app| rx:sequence-rxs (car l_11)) (cdr l_11)))
                   (if (if (pair? l_11)
                         (let ((or-part_4 (eq? rx:empty (car l_11))))
                           (if or-part_4
                             or-part_4
                             (let ((or-part_5 (equal? "" (car l_11))))
                               (if or-part_5 or-part_5 (equal? #vu8() (car l_11))))))
                         #f)
                     (loop_6 mode_0 accum_0 (cdr l_11))
                     (if (let ((or-part_6 (null? l_11)))
                           (if or-part_6
                             or-part_6
                             (not
                              (let ((tmp_0 mode_0))
                                (if (equal? tmp_0 'byte)
                                  (let ((or-part_7 (byte? (car l_11))))
                                    (if or-part_7
                                      or-part_7
                                      (bytes? (car l_11))))
                                  (if (equal? tmp_0 'char)
                                    (let ((or-part_8 (integer? (car l_11))))
                                      (if or-part_8
                                        or-part_8
                                        (string? (car l_11))))
                                    #t))))))
                       (if (null? accum_0)
                         null
                         (if (null? (cdr accum_0))
                           (cons (car accum_0) (loop_6 #f null l_11))
                           (cons
                            (let ((tmp_1 mode_0))
                              (if (equal? tmp_1 'byte)
                                (apply
                                 bytes-append
                                 (let ((lst_4 (1/reverse accum_0)))
                                   (begin
                                     (if (list? lst_4)
                                       (void)
                                       (check-list lst_4))
                                     ((letrec ((for-loop_3
                                                (lambda (lst_5)
                                                  (if (pair? lst_5)
                                                    (let-values (((a_2)
                                                                  (unsafe-car
                                                                   lst_5))
                                                                 ((rest_2)
                                                                  (unsafe-cdr
                                                                   lst_5)))
                                                      (let ((post-guard-var_0
                                                             (lambda () #t)))
                                                        (let ((elem_0
                                                               (if (byte? a_2)
                                                                 (bytes a_2)
                                                                 a_2)))
                                                          (let ((result_3
                                                                 (if (post-guard-var_0)
                                                                   (for-loop_3
                                                                    rest_2)
                                                                   null)))
                                                            (cons
                                                             elem_0
                                                             result_3)))))
                                                    null))))
                                        for-loop_3)
                                      lst_4))))
                                (if (equal? tmp_1 'char)
                                  (apply
                                   string-append
                                   (let ((lst_6 (1/reverse accum_0)))
                                     (begin
                                       (if (list? lst_6)
                                         (void)
                                         (check-list lst_6))
                                       ((letrec ((for-loop_4
                                                  (lambda (lst_7)
                                                    (if (pair? lst_7)
                                                      (let-values (((a_3)
                                                                    (unsafe-car
                                                                     lst_7))
                                                                   ((rest_3)
                                                                    (unsafe-cdr
                                                                     lst_7)))
                                                        (let ((post-guard-var_1
                                                               (lambda () #t)))
                                                          (let ((elem_1
                                                                 (if (integer?
                                                                      a_3)
                                                                   (string
                                                                    (integer->char
                                                                     a_3))
                                                                   a_3)))
                                                            (let ((result_4
                                                                   (if (post-guard-var_1)
                                                                     (for-loop_4
                                                                      rest_3)
                                                                     null)))
                                                              (cons
                                                               elem_1
                                                               result_4)))))
                                                      null))))
                                          for-loop_4)
                                        lst_6))))
                                  (error "internal error"))))
                            (loop_6 #f null l_11))))
                       (if mode_0
                         (loop_6 mode_0 (cons (car l_11) accum_0) (cdr l_11))
                         (if (let ((or-part_9 (byte? (car l_11))))
                               (if or-part_9 or-part_9 (bytes? (car l_11))))
                           (loop_6 'byte (list (car l_11)) (cdr l_11))
                           (if (let ((or-part_10 (integer? (car l_11))))
                                 (if or-part_10
                                   or-part_10
                                   (string? (car l_11))))
                             (loop_6 'char (list (car l_11)) (cdr l_11))
                             (cons
                              (car l_11)
                              (loop_6 #f null (cdr l_11))))))))))))
       loop_6)
     #f
     null
     l_10)))
(define rx-alts
  (lambda (rx1_0 rx2_0 limit-c_2)
    (if (eq? rx:never rx1_0)
      rx2_0
      (if (eq? rx:never rx2_0)
        rx1_0
        (if (if (|#%app| rx:range? rx1_0) (|#%app| rx:range? rx2_0) #f)
          (rx-range
           (range-union
            (|#%app| rx:range-range rx1_0)
            (|#%app| rx:range-range rx2_0))
           limit-c_2)
          (if (if (|#%app| rx:range? rx1_0)
                (if (|#%app| rx:alts? rx2_0)
                  (|#%app| rx:range? (|#%app| rx:alts-rx1 rx2_0))
                  #f)
                #f)
            (rx-alts
             (rx-alts rx1_0 (|#%app| rx:alts-rx1 rx2_0) limit-c_2)
             (|#%app| rx:alts-rx2 rx2_0)
             limit-c_2)
            (if (if (|#%app| rx:range? rx1_0) (integer? rx2_0) #f)
              (rx-range
               (range-add (|#%app| rx:range-range rx1_0) rx2_0)
               limit-c_2)
              (if (if (|#%app| rx:range? rx2_0) (integer? rx1_0) #f)
                (rx-alts rx2_0 rx1_0 limit-c_2)
                (if (if (integer? rx1_0) (integer? rx2_0) #f)
                  (rx-range
                   (range-add (range-add empty-range rx1_0) rx2_0)
                   limit-c_2)
                  (|#%app| rx:alts1.1 rx1_0 rx2_0))))))))))
(define rx-group (lambda (rx_1 n_1) (|#%app| rx:group3.1 rx_1 n_1)))
(define rx-cut
  (lambda (rx_2 n-start_0 num-n_0)
    (|#%app| rx:cut9.1 rx_2 n-start_0 num-n_0 (needs-backtrack? rx_2))))
(define rx-conditional
  (lambda (tst_0 pces1_0 pces2_0 n-start_1 num-n_1)
    (|#%app|
     rx:conditional6.1
     tst_0
     pces1_0
     pces2_0
     n-start_1
     num-n_1
     (let ((or-part_11 (needs-backtrack? pces1_0)))
       (if or-part_11 or-part_11 (needs-backtrack? pces2_0))))))
(define-values
 (struct:parse-config
  parse-config1.1
  parse-config?
  parse-config-who
  parse-config-px?
  parse-config-case-sensitive?
  parse-config-multi-line?
  parse-config-group-number-box
  parse-config-references?-box
  parse-config-error-handler?)
 (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
               (make-struct-type
                'parse-config
                #f
                7
                0
                #f
                null
                (current-inspector)
                #f
                '(0 1 2 3 4 5 6)
                #f
                'parse-config)))
   (values
    struct:_0
    make-_0
    ?_0
    (make-struct-field-accessor -ref_0 0 'who)
    (make-struct-field-accessor -ref_0 1 'px?)
    (make-struct-field-accessor -ref_0 2 'case-sensitive?)
    (make-struct-field-accessor -ref_0 3 'multi-line?)
    (make-struct-field-accessor -ref_0 4 'group-number-box)
    (make-struct-field-accessor -ref_0 5 'references?-box)
    (make-struct-field-accessor -ref_0 6 'error-handler?))))
(define make-parse-config8.1
  (lambda (error-handler?4_0 error-handler?7_0 px?3_0 px?6_0 who2_0 who5_0)
    (let ((who_2 (if who5_0 who2_0 'regexp)))
      (let ((px?_0 (if px?6_0 px?3_0 #f)))
        (let ((error-handler?_0 (if error-handler?7_0 error-handler?4_0 #f)))
          (|#%app|
           parse-config1.1
           who_2
           px?_0
           #t
           #f
           (box 0)
           (box #f)
           error-handler?_0))))))
(define config-case-sensitive
  (lambda (config_0 cs?_0)
    (let ((the-struct_0 config_0))
      (if (|#%app| parse-config? the-struct_0)
        (let ((case-sensitive?12_0 cs?_0))
          (|#%app|
           parse-config1.1
           (|#%app| parse-config-who the-struct_0)
           (|#%app| parse-config-px? the-struct_0)
           case-sensitive?12_0
           (|#%app| parse-config-multi-line? the-struct_0)
           (|#%app| parse-config-group-number-box the-struct_0)
           (|#%app| parse-config-references?-box the-struct_0)
           (|#%app| parse-config-error-handler? the-struct_0)))
        (raise-argument-error 'struct-copy "parse-config?" the-struct_0)))))
(define config-multi-line
  (lambda (config_1 mm?_0)
    (let ((the-struct_1 config_1))
      (if (|#%app| parse-config? the-struct_1)
        (let ((multi-line?13_0 mm?_0))
          (|#%app|
           parse-config1.1
           (|#%app| parse-config-who the-struct_1)
           (|#%app| parse-config-px? the-struct_1)
           (|#%app| parse-config-case-sensitive? the-struct_1)
           multi-line?13_0
           (|#%app| parse-config-group-number-box the-struct_1)
           (|#%app| parse-config-references?-box the-struct_1)
           (|#%app| parse-config-error-handler? the-struct_1)))
        (raise-argument-error 'struct-copy "parse-config?" the-struct_1)))))
(define config-group-number
  (lambda (config_2) (unbox (|#%app| parse-config-group-number-box config_2))))
(define config-group-number+1
  (lambda (config_3)
    (let ((b_1 (|#%app| parse-config-group-number-box config_3)))
      (begin (set-box! b_1 (add1 (unbox b_1))) config_3))))
(define parse-error
  (lambda (s_4 pos_1 config_4 fmt_1 . args_3)
    (apply regexp-error fmt_1 args_3)))
(define parse-class
  (lambda (s_4 pos_1 config_4)
    (let ((success_0 (lambda (v_18) (values #t v_18 (add1 pos_1)))))
      (let ((tmp_2 (integer->char (chytes-ref$1 s_4 pos_1))))
        (if (equal? tmp_2 '#\x64)
          (success_0 (range:d))
          (if (equal? tmp_2 '#\x44)
            (success_0 (range-invert (range:d) (chytes-limit s_4)))
            (if (equal? tmp_2 '#\x77)
              (success_0 (range:w))
              (if (equal? tmp_2 '#\x57)
                (success_0 (range-invert (range:w) (chytes-limit s_4)))
                (if (equal? tmp_2 '#\x73)
                  (success_0 (range:s))
                  (if (equal? tmp_2 '#\x53)
                    (success_0 (range-invert (range:s) (chytes-limit s_4)))
                    (values #f #f #f)))))))))))
(define range:d (lambda () (range-add-span empty-range 48 57)))
(define range:w
  (lambda ()
    (range-add (range-add-span (range-add-span (range:d) 97 122) 65 90) 95)))
(define range:s
  (lambda ()
    (let ((r_5 (range-add empty-range 32)))
      (let ((r_6 (range-add r_5 9)))
        (let ((r_7 (range-add r_6 10)))
          (let ((r_8 (range-add r_7 12)))
            (let ((r_9 (range-add r_8 13))) r_9)))))))
(define parse-posix-char-class
  (lambda (s_5 pos_2)
    (let-values (((pos_3) pos_2) ((s_6) s_5))
      (let ((tmp_3
             (if (= pos_3 (chytes-length$1 s_6))
               'eos
               (chytes-ref/char s_6 pos_3))))
        (if (equal? tmp_3 '#\x3a)
          (let ((class_0
                 ((letrec ((loop_7
                            (lambda (accum_1 pos_4)
                              (if (= pos_4 (chytes-length$1 s_5))
                                #f
                                (let ((c_1 (chytes-ref$1 s_5 pos_4)))
                                  (if (if (>= c_1 97) (<= c_1 122) #f)
                                    (loop_7 (cons c_1 accum_1) (add1 pos_4))
                                    (if (if (= c_1 58)
                                          (if (<
                                               (add1 pos_4)
                                               (chytes-length$1 s_5))
                                            (=
                                             (chytes-ref$1 s_5 (add1 pos_4))
                                             93)
                                            #f)
                                          #f)
                                      (list->bytes (1/reverse accum_1))
                                      #f)))))))
                    loop_7)
                  null
                  (add1 pos_2))))
            (let ((range_7
                   (let ((tmp_4 class_0))
                     (let ((index_0 (hash-ref hash656 tmp_4 (lambda () 0))))
                       (if (unsafe-fx< index_0 6)
                         (if (unsafe-fx< index_0 2)
                           (if (unsafe-fx< index_0 1)
                             #f
                             (range-add-span
                              (range-add-span empty-range 97 122)
                              65
                              90))
                           (if (unsafe-fx< index_0 3)
                             (range-add-span empty-range 65 90)
                             (if (unsafe-fx< index_0 4)
                               (range-add-span empty-range 97 122)
                               (if (unsafe-fx< index_0 5)
                                 (range-add-span empty-range 48 57)
                                 (range-add-span
                                  (range-add-span
                                   (range-add-span empty-range 48 57)
                                   97
                                   102)
                                  65
                                  70)))))
                         (if (unsafe-fx< index_0 9)
                           (if (unsafe-fx< index_0 7)
                             (range-add-span
                              (range-add-span
                               (range-add-span empty-range 48 57)
                               97
                               122)
                              65
                              90)
                             (if (unsafe-fx< index_0 8)
                               (range-add
                                (range-add-span
                                 (range-add-span empty-range 97 122)
                                 65
                                 90)
                                95)
                               (range-add (range-add empty-range 32) 9)))
                           (if (unsafe-fx< index_0 10)
                             (range:s)
                             (if (unsafe-fx< index_0 11)
                               (let ((range_1
                                      (let-values (((start_4) 0)
                                                   ((end_1) 128)
                                                   ((inc_1) 1))
                                        (begin
                                          (if (if (real? start_4)
                                                (if (real? end_1)
                                                  (real? inc_1)
                                                  #f)
                                                #f)
                                            (void)
                                            (check-range$1
                                             start_4
                                             end_1
                                             inc_1))
                                          ((letrec ((for-loop_5
                                                     (lambda (range_8 pos_5)
                                                       (if (unsafe-fx<
                                                            pos_5
                                                            end_1)
                                                         (let ((i_3 pos_5))
                                                           (let ((range_9
                                                                  (let ((range_10
                                                                         range_8))
                                                                    (let ((range_11
                                                                           (if (char-graphic?
                                                                                (integer->char
                                                                                 i_3))
                                                                             (range-add
                                                                              range_10
                                                                              i_3)
                                                                             range_10)))
                                                                      (values
                                                                       range_11)))))
                                                             (if (not #f)
                                                               (for-loop_5
                                                                range_9
                                                                (unsafe-fx+
                                                                 pos_5
                                                                 inc_1))
                                                               range_9)))
                                                         range_8))))
                                             for-loop_5)
                                           empty-range
                                           start_4)))))
                                 (if (equal? class_0 #vu8(112 114 105 110 116))
                                   (range-add (range-add range_1 32) 9)
                                   range_1))
                               (if (unsafe-fx< index_0 12)
                                 (range-add-span empty-range 0 31)
                                 (range-add-span empty-range 0 127))))))))))
              (if range_7
                (values #t range_7 (+ pos_2 3 (bytes-length class_0)))
                (values #f #f #f))))
          (values #f #f #f))))))
(define parse-unicode-categories
  (lambda (p-c_0 s_7 pos_6 config_5)
    (let-values (((pos_7) pos_6) ((s_8) s_7))
      (let ((tmp_5
             (if (= pos_7 (chytes-length$1 s_8))
               'eos
               (chytes-ref/char s_8 pos_7))))
        (if (equal? tmp_5 '#\x7b)
          (let-values (((l_12 pos2_0)
                        ((letrec ((loop_8
                                   (lambda (accum_2 pos_2)
                                     (let-values (((pos_3) pos_2) ((s_6) s_7))
                                       (let ((tmp_3
                                              (if (=
                                                   pos_3
                                                   (chytes-length$1 s_6))
                                                'eos
                                                (chytes-ref/char s_6 pos_3))))
                                         (if (equal? tmp_3 'eos)
                                           (parse-error
                                            s_7
                                            pos_2
                                            config_5
                                            "missing `}` to close `\\~a{`"
                                            (integer->char p-c_0))
                                           (if (equal? tmp_3 '#\x7d)
                                             (values
                                              (1/reverse accum_2)
                                              (add1 pos_2))
                                             (loop_8
                                              (cons
                                               (chytes-ref$1 s_7 pos_2)
                                               accum_2)
                                              (add1 pos_2)))))))))
                           loop_8)
                         null
                         (add1 pos_6))))
            (let ((categories_0
                   (let ((tmp_6 (list->bytes l_12)))
                     (let ((index_1 (hash-ref hash657 tmp_6 (lambda () 0))))
                       (if (unsafe-fx< index_1 19)
                         (if (unsafe-fx< index_1 9)
                           (if (unsafe-fx< index_1 4)
                             (if (unsafe-fx< index_1 1)
                               (parse-error
                                s_7
                                pos2_0
                                config_5
                                "unrecognized property name in `\\~a{}`: `~a`"
                                (integer->char p-c_0)
                                (list->string (map2 integer->char l_12)))
                               (if (unsafe-fx< index_1 2)
                                 'll
                                 (if (unsafe-fx< index_1 3) 'lu 'lt)))
                             (if (unsafe-fx< index_1 6)
                               (if (unsafe-fx< index_1 5) 'lm '(ll lu lt lm))
                               (if (unsafe-fx< index_1 7)
                                 'lo
                                 (if (unsafe-fx< index_1 8)
                                   '(ll lu lt lm lo)
                                   'nd))))
                           (if (unsafe-fx< index_1 13)
                             (if (unsafe-fx< index_1 10)
                               'nl
                               (if (unsafe-fx< index_1 11)
                                 'no
                                 (if (unsafe-fx< index_1 12) '(nd nl no) 'ps)))
                             (if (unsafe-fx< index_1 15)
                               (if (unsafe-fx< index_1 14) 'pe 'pi)
                               (if (unsafe-fx< index_1 16)
                                 'pf
                                 (if (unsafe-fx< index_1 17)
                                   'pc
                                   (if (unsafe-fx< index_1 18) 'pd 'po))))))
                         (if (unsafe-fx< index_1 29)
                           (if (unsafe-fx< index_1 23)
                             (if (unsafe-fx< index_1 20)
                               '(ps pe pi pf pc pd po)
                               (if (unsafe-fx< index_1 21)
                                 'mn
                                 (if (unsafe-fx< index_1 22) 'mc 'me)))
                             (if (unsafe-fx< index_1 25)
                               (if (unsafe-fx< index_1 24) '(mn mc me) 'sc)
                               (if (unsafe-fx< index_1 26)
                                 'sk
                                 (if (unsafe-fx< index_1 27)
                                   'sm
                                   (if (unsafe-fx< index_1 28)
                                     'so
                                     '(sc sk sm so))))))
                           (if (unsafe-fx< index_1 34)
                             (if (unsafe-fx< index_1 31)
                               (if (unsafe-fx< index_1 30) 'zl 'zp)
                               (if (unsafe-fx< index_1 32)
                                 'zs
                                 (if (unsafe-fx< index_1 33) '(zl zp zs) 'cc)))
                             (if (unsafe-fx< index_1 36)
                               (if (unsafe-fx< index_1 35) 'cf 'cs)
                               (if (unsafe-fx< index_1 37)
                                 'cn
                                 (if (unsafe-fx< index_1 38)
                                   'co
                                   (if (unsafe-fx< index_1 39)
                                     '(cc cf cs cn so)
                                     #t)))))))))))
              (values
               (|#%app|
                rx:unicode-categories12.1
                categories_0
                (= p-c_0 (char->integer '#\x70)))
               pos2_0)))
          (parse-error
           s_7
           pos_6
           config_5
           "expected `{` after `\\~a`"
           (integer->char p-c_0)))))))
(define range-add*
  (lambda (range_12 c_2 config_4)
    (if (not c_2)
      range_12
      (let ((range2_0 (range-add range_12 c_2)))
        (if (|#%app| parse-config-case-sensitive? config_4)
          range2_0
          (let ((range3_0
                 (range-add
                  range2_0
                  (char->integer (char-upcase (integer->char c_2))))))
            (let ((range4_0
                   (range-add
                    range3_0
                    (char->integer (char-foldcase (integer->char c_2))))))
              (range-add
               range4_0
               (char->integer (char-downcase (integer->char c_2)))))))))))
(define range-add-span*
  (lambda (range_13 from-c_1 to-c_1 config_6)
    (if (|#%app| parse-config-case-sensitive? config_6)
      (range-add-span range_13 from-c_1 to-c_1)
      (let-values (((start_5) from-c_1) ((end_2) (add1 to-c_1)) ((inc_2) 1))
        (begin
          (if (if (real? start_5) (if (real? end_2) (real? inc_2) #f) #f)
            (void)
            (check-range$1 start_5 end_2 inc_2))
          ((letrec ((for-loop_6
                     (lambda (range_14 pos_8)
                       (if (< pos_8 end_2)
                         (let ((c_3 pos_8))
                           (let ((range_7
                                  (let ((range_15 range_14))
                                    (let ((range_16
                                           (range-add* range_15 c_3 config_6)))
                                      (values range_16)))))
                             (if (not #f)
                               (for-loop_6 range_7 (+ pos_8 inc_2))
                               range_7)))
                         range_14))))
             for-loop_6)
           range_13
           start_5))))))
(define parse-range/not
  (lambda (s_8 pos_9 config_7)
    (let-values (((pos_10) pos_9) ((s_9) s_8))
      (let ((tmp_7
             (if (= pos_10 (chytes-length$1 s_9))
               'eos
               (chytes-ref/char s_9 pos_10))))
        (if (equal? tmp_7 'eos)
          (missing-square-closing-error s_8 pos_9 config_7)
          (if (equal? tmp_7 '#\x5e)
            (let-values (((range_17 pos2_1)
                          (parse-range s_8 (add1 pos_9) config_7)))
              (values (range-invert range_17 (chytes-limit s_8)) pos2_1))
            (parse-range s_8 pos_9 config_7)))))))
(define parse-range
  (lambda (s_10 pos_11 config_8)
    (let-values (((pos_12) pos_11) ((s_11) s_10))
      (let ((tmp_8
             (if (= pos_12 (chytes-length$1 s_11))
               'eos
               (chytes-ref/char s_11 pos_12))))
        (if (equal? tmp_8 'eos)
          (missing-square-closing-error s_10 pos_11 config_8)
          (if (equal? tmp_8 '#\x5d)
            (let-values (((temp24_0) (range-add empty-range 93))
                         ((s25_0) s_10)
                         ((temp26_0) (add1 pos_11))
                         ((config27_0) config_8))
              (parse-range-rest9.1
               #f
               #f
               #f
               #f
               temp24_0
               s25_0
               temp26_0
               config27_0))
            (if (equal? tmp_8 '#\x2d)
              (let-values (((temp28_0) (range-add empty-range 45))
                           ((s29_0) s_10)
                           ((temp30_0) (add1 pos_11))
                           ((config31_0) config_8))
                (parse-range-rest9.1
                 #f
                 #f
                 #f
                 #f
                 temp28_0
                 s29_0
                 temp30_0
                 config31_0))
              (let-values (((empty-range32_0) empty-range)
                           ((s33_0) s_10)
                           ((pos34_0) pos_11)
                           ((config35_0) config_8))
                (parse-range-rest9.1
                 #f
                 #f
                 #f
                 #f
                 empty-range32_0
                 s33_0
                 pos34_0
                 config35_0)))))))))
(define parse-range-rest9.1
  (lambda (must-span-from2_0
           must-span-from4_0
           span-from1_0
           span-from3_0
           range5_0
           s6_0
           pos7_0
           config8_0)
    (let ((range_18 range5_0))
      (let ((s_12 s6_0))
        (let ((pos_13 pos7_0))
          (let ((config_9 config8_0))
            (let ((span-from_0 (if span-from3_0 span-from1_0 #f)))
              (let ((must-span-from_0
                     (if must-span-from4_0 must-span-from2_0 #f)))
                (let-values (((pos_14) pos_13) ((s_13) s_12))
                  (let ((tmp_9
                         (if (= pos_14 (chytes-length$1 s_13))
                           'eos
                           (chytes-ref/char s_13 pos_14))))
                    (if (equal? tmp_9 'eos)
                      (missing-square-closing-error s_12 pos_13 config_9)
                      (if (equal? tmp_9 '#\x5d)
                        (values
                         (range-add* range_18 span-from_0 config_9)
                         (add1 pos_13))
                        (if (equal? tmp_9 '#\x2d)
                          (let ((pos2_2 (add1 pos_13)))
                            (let-values (((pos_15) pos2_2) ((s_14) s_12))
                              (let ((tmp_10
                                     (if (= pos_15 (chytes-length$1 s_14))
                                       'eos
                                       (chytes-ref/char s_14 pos_15))))
                                (if (equal? tmp_10 'eos)
                                  (missing-square-closing-error
                                   s_12
                                   (add1 pos2_2)
                                   config_9)
                                  (if (equal? tmp_10 '#\x5d)
                                    (if must-span-from_0
                                      (misplaced-hyphen-error
                                       s_12
                                       pos_13
                                       config_9)
                                      (values
                                       (range-add
                                        (range-add*
                                         range_18
                                         span-from_0
                                         config_9)
                                        45)
                                       (add1 pos2_2)))
                                    (if span-from_0
                                      (let ((span-from40_0 span-from_0))
                                        (parse-range-rest9.1
                                         span-from40_0
                                         #t
                                         #f
                                         #f
                                         range_18
                                         s_12
                                         pos2_2
                                         config_9))
                                      (misplaced-hyphen-error
                                       s_12
                                       pos_13
                                       config_9)))))))
                          (if (equal? tmp_9 '#\x5c)
                            (if (|#%app| parse-config-px? config_9)
                              (let ((pos2_3 (add1 pos_13)))
                                (if (= pos2_3 (chytes-length$1 s_12))
                                  (parse-error
                                   s_12
                                   pos_13
                                   config_9
                                   "escaping backslash at end pattern (within square brackets)")
                                  (let ((c_4 (chytes-ref$1 s_12 pos2_3)))
                                    (if (let ((or-part_12
                                               (if (>= c_4 97)
                                                 (<= c_4 122)
                                                 #f)))
                                          (if or-part_12
                                            or-part_12
                                            (if (>= c_4 65) (<= c_4 90) #f)))
                                      (if must-span-from_0
                                        (parse-error
                                         s_12
                                         pos_13
                                         config_9
                                         "misplaced hyphen within square brackets in pattern")
                                        (let-values (((success?_0
                                                       range1_0
                                                       pos3_0)
                                                      (parse-class
                                                       s_12
                                                       pos2_3
                                                       config_9)))
                                          (let-values ((()
                                                        (begin
                                                          (if success?_0
                                                            (void)
                                                            (parse-error
                                                             s_12
                                                             pos3_0
                                                             config_9
                                                             "illegal alphabetic escape"))
                                                          (values))))
                                            (let ((range2_1
                                                   (range-union
                                                    range1_0
                                                    (range-add*
                                                     range_18
                                                     span-from_0
                                                     config_9))))
                                              (let-values (((range241_0)
                                                            range2_1)
                                                           ((s42_0) s_12)
                                                           ((temp43_0)
                                                            (add1 pos2_3))
                                                           ((config44_0)
                                                            config_9))
                                                (parse-range-rest9.1
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 range241_0
                                                 s42_0
                                                 temp43_0
                                                 config44_0))))))
                                      (let-values (((temp48_0) (add1 pos2_3))
                                                   ((config49_0) config_9)
                                                   ((span-from50_0)
                                                    span-from_0)
                                                   ((must-span-from51_0)
                                                    must-span-from_0))
                                        (parse-range-rest/span21.1
                                         must-span-from51_0
                                         span-from50_0
                                         c_4
                                         range_18
                                         s_12
                                         temp48_0
                                         config49_0))))))
                              (let-values (((temp52_0) 92)
                                           ((range53_0) range_18)
                                           ((s54_0) s_12)
                                           ((temp55_0) (add1 pos_13))
                                           ((config56_0) config_9)
                                           ((span-from57_0) span-from_0)
                                           ((must-span-from58_0)
                                            must-span-from_0))
                                (parse-range-rest/span21.1
                                 must-span-from58_0
                                 span-from57_0
                                 temp52_0
                                 range53_0
                                 s54_0
                                 temp55_0
                                 config56_0)))
                            (if (equal? tmp_9 '#\x5b)
                              (let-values (((success?_1 range1_1 pos2_4)
                                            (if (if (|#%app|
                                                     parse-config-px?
                                                     config_9)
                                                  (not must-span-from_0)
                                                  #f)
                                              (parse-posix-char-class
                                               s_12
                                               (add1 pos_13))
                                              (values #f #f #f))))
                                (if success?_1
                                  (let ((range2_2
                                         (range-union
                                          range1_1
                                          (range-add*
                                           range_18
                                           span-from_0
                                           config_9))))
                                    (let-values (((range259_0) range2_2)
                                                 ((s60_0) s_12)
                                                 ((pos261_0) pos2_4)
                                                 ((config62_0) config_9))
                                      (parse-range-rest9.1
                                       #f
                                       #f
                                       #f
                                       #f
                                       range259_0
                                       s60_0
                                       pos261_0
                                       config62_0)))
                                  (let-values (((temp63_0) 91)
                                               ((range64_0) range_18)
                                               ((s65_0) s_12)
                                               ((temp66_0) (add1 pos_13))
                                               ((config67_0) config_9)
                                               ((span-from68_0) span-from_0)
                                               ((must-span-from69_0)
                                                must-span-from_0))
                                    (parse-range-rest/span21.1
                                     must-span-from69_0
                                     span-from68_0
                                     temp63_0
                                     range64_0
                                     s65_0
                                     temp66_0
                                     config67_0))))
                              (let-values (((temp70_0)
                                            (chytes-ref$1 s_12 pos_13))
                                           ((range71_0) range_18)
                                           ((s72_0) s_12)
                                           ((temp73_0) (add1 pos_13))
                                           ((config74_0) config_9)
                                           ((span-from75_0) span-from_0)
                                           ((must-span-from76_0)
                                            must-span-from_0))
                                (parse-range-rest/span21.1
                                 must-span-from76_0
                                 span-from75_0
                                 temp70_0
                                 range71_0
                                 s72_0
                                 temp73_0
                                 config74_0)))))))))))))))))
(define parse-range-rest/span21.1
  (lambda (must-span-from13_0
           span-from12_0
           c16_0
           range17_0
           s18_0
           pos19_0
           config20_0)
    (let ((c_5 c16_0))
      (let ((range_19 range17_0))
        (let ((s_15 s18_0))
          (let ((pos_16 pos19_0))
            (let ((config_10 config20_0))
              (let ((span-from_1 span-from12_0))
                (let ((must-span-from_1 must-span-from13_0))
                  (if must-span-from_1
                    (if (> must-span-from_1 c_5)
                      (parse-error
                       s_15
                       pos_16
                       config_10
                       "invalid range within square brackets in pattern")
                      (let-values (((temp77_0)
                                    (range-add-span*
                                     range_19
                                     must-span-from_1
                                     c_5
                                     config_10))
                                   ((s78_0) s_15)
                                   ((pos79_0) pos_16)
                                   ((config80_0) config_10))
                        (parse-range-rest9.1
                         #f
                         #f
                         #f
                         #f
                         temp77_0
                         s78_0
                         pos79_0
                         config80_0)))
                    (let-values (((temp81_0)
                                  (range-add* range_19 span-from_1 config_10))
                                 ((s82_0) s_15)
                                 ((pos83_0) pos_16)
                                 ((config84_0) config_10)
                                 ((c85_0) c_5))
                      (parse-range-rest9.1
                       #f
                       #f
                       c85_0
                       #t
                       temp81_0
                       s82_0
                       pos83_0
                       config84_0))))))))))))
(define missing-square-closing-error
  (lambda (s_16 pos_17 config_11)
    (parse-error
     s_16
     pos_17
     config_11
     "missing closing square bracket in pattern")))
(define misplaced-hyphen-error
  (lambda (s_17 pos_18 config_12)
    (parse-error
     s_17
     pos_18
     config_12
     "misplaced hyphen within square brackets in pattern")))
(define parse4.1
  (lambda (px?1_0 px?2_0 p3_0)
    (let ((p_2 p3_0))
      (let ((px?_1 (if px?2_0 px?1_0 #f)))
        (let ((config_13
               (let ((px?15_0 px?_1))
                 (make-parse-config8.1 #f #f px?15_0 #t #f #f))))
          (let-values (((rx_3 pos_19)
                        (let-values (((p16_0) p_2)
                                     ((temp17_0) 0)
                                     ((config18_0) config_13))
                          (parse-regexp12.1 #f #f p16_0 temp17_0 config18_0))))
            (values
             rx_3
             (config-group-number config_13)
             (unbox (|#%app| parse-config-references?-box config_13)))))))))
(define parse-regexp12.1
  (lambda (parse-regexp7_0 parse-regexp8_0 s9_0 pos10_0 config11_0)
    (let ((s_18 s9_0))
      (let ((pos_20 pos10_0))
        (let ((config_14 config11_0))
          (let ((parse-regexp_0
                 (if parse-regexp8_0
                   parse-regexp7_0
                   (lambda (s_19 pos_21 config_15)
                     (let-values (((s19_0) s_19)
                                  ((pos20_0) pos_21)
                                  ((config21_0) config_15))
                       (parse-regexp12.1 #f #f s19_0 pos20_0 config21_0))))))
            (let-values (((rxs_0 pos2_5) (parse-pces s_18 pos_20 config_14)))
              (let-values (((pos_22) pos2_5) ((s_20) s_18))
                (let ((tmp_11
                       (if (= pos_22 (chytes-length$1 s_20))
                         'eos
                         (chytes-ref/char s_20 pos_22))))
                  (if (equal? tmp_11 '#\x7c)
                    (let-values (((rx_4 pos3_1)
                                  (|#%app|
                                   parse-regexp_0
                                   s_18
                                   (add1 pos2_5)
                                   config_14)))
                      (values
                       (rx-alts (rx-sequence rxs_0) rx_4 (chytes-limit s_18))
                       pos3_1))
                    (values (rx-sequence rxs_0) pos2_5)))))))))))
(define parse-regexp/maybe-empty
  (lambda (s_21 pos_23 config_16)
    (let-values (((pos_24) pos_23) ((s_22) s_21))
      (let ((tmp_12
             (if (= pos_24 (chytes-length$1 s_22))
               'eos
               (chytes-ref/char s_22 pos_24))))
        (if (equal? tmp_12 '#\x29)
          (values rx:empty pos_23)
          (let ((parse-regexp/maybe-empty25_0 parse-regexp/maybe-empty))
            (parse-regexp12.1
             parse-regexp/maybe-empty25_0
             #t
             s_21
             pos_23
             config_16)))))))
(define parse-pces
  (lambda (s_23 pos_25 config_17)
    (if (= pos_25 (chytes-length$1 s_23))
      (values null pos_25)
      (let-values (((rx_5 pos2_6) (parse-pce s_23 pos_25 config_17)))
        (let-values (((pos_26) pos2_6) ((s_24) s_23))
          (let ((tmp_13
                 (if (= pos_26 (chytes-length$1 s_24))
                   'eos
                   (chytes-ref/char s_24 pos_26))))
            (if (equal? tmp_13 'eos)
              (values (list rx_5) pos2_6)
              (if (if (equal? tmp_13 '#\x7c) #t (equal? tmp_13 '#\x29))
                (values (list rx_5) pos2_6)
                (let-values (((rxs_1 pos3_2)
                              (parse-pces s_23 pos2_6 config_17)))
                  (values (cons rx_5 rxs_1) pos3_2))))))))))
(define parse-pce
  (lambda (s_25 pos_27 config_18)
    (let-values (((rx_6 pos2_7) (parse-atom s_25 pos_27 config_18)))
      (let-values (((pos_28) pos2_7) ((s_26) s_25))
        (let ((tmp_14
               (if (= pos_28 (chytes-length$1 s_26))
                 'eos
                 (chytes-ref/char s_26 pos_28))))
          (if (equal? tmp_14 '#\x2a)
            (let-values (((non-greedy?_0 pos3_3)
                          (parse-non-greedy s_25 (add1 pos2_7) config_18)))
              (values
               (|#%app| rx:repeat4.1 rx_6 0 +inf.0 non-greedy?_0)
               pos3_3))
            (if (equal? tmp_14 '#\x2b)
              (let-values (((non-greedy?_1 pos3_4)
                            (parse-non-greedy s_25 (add1 pos2_7) config_18)))
                (values
                 (|#%app| rx:repeat4.1 rx_6 1 +inf.0 non-greedy?_1)
                 pos3_4))
              (if (equal? tmp_14 '#\x3f)
                (let-values (((non-greedy?_2 pos3_5)
                              (parse-non-greedy s_25 (add1 pos2_7) config_18)))
                  (values (|#%app| rx:maybe5.1 rx_6 non-greedy?_2) pos3_5))
                (if (equal? tmp_14 '#\x7b)
                  (if (|#%app| parse-config-px? config_18)
                    (let-values (((n1_0 pos3_6)
                                  (parse-integer
                                   0
                                   s_25
                                   (add1 pos2_7)
                                   config_18)))
                      (let-values (((pos_29) pos3_6) ((s_27) s_25))
                        (let ((tmp_15
                               (if (= pos_29 (chytes-length$1 s_27))
                                 'eos
                                 (chytes-ref/char s_27 pos_29))))
                          (if (equal? tmp_15 '#\x2c)
                            (let-values (((n2_0 pos4_0)
                                          (parse-integer
                                           0
                                           s_25
                                           (add1 pos3_6)
                                           config_18)))
                              (let-values (((pos_30) pos4_0) ((s_28) s_25))
                                (let ((tmp_16
                                       (if (= pos_30 (chytes-length$1 s_28))
                                         'eos
                                         (chytes-ref/char s_28 pos_30))))
                                  (if (equal? tmp_16 '#\x7d)
                                    (let ((n2*_0
                                           (if (= pos4_0 (add1 pos3_6))
                                             +inf.0
                                             n2_0)))
                                      (let-values (((non-greedy?_3 pos5_0)
                                                    (parse-non-greedy
                                                     s_25
                                                     (add1 pos4_0)
                                                     config_18)))
                                        (values
                                         (|#%app|
                                          rx:repeat4.1
                                          rx_6
                                          n1_0
                                          n2*_0
                                          non-greedy?_3)
                                         pos5_0)))
                                    (parse-error
                                     s_25
                                     pos3_6
                                     config_18
                                     "expected digit or `}` to end repetition specification started with `{`")))))
                            (if (equal? tmp_15 '#\x7d)
                              (let-values (((non-greedy?_4 pos4_1)
                                            (parse-non-greedy
                                             s_25
                                             (add1 pos3_6)
                                             config_18)))
                                (values
                                 (|#%app|
                                  rx:repeat4.1
                                  rx_6
                                  n1_0
                                  n1_0
                                  non-greedy?_4)
                                 pos4_1))
                              (parse-error
                               s_25
                               pos3_6
                               config_18
                               "expected digit, `,`, or `}' for repetition specification started with `{`"))))))
                    (values rx_6 pos2_7))
                  (values rx_6 pos2_7))))))))))
(define parse-non-greedy
  (lambda (s_29 pos_31 config_19)
    (let-values (((pos_32) pos_31) ((s_30) s_29))
      (let ((tmp_17
             (if (= pos_32 (chytes-length$1 s_30))
               'eos
               (chytes-ref/char s_30 pos_32))))
        (if (equal? tmp_17 '#\x3f)
          (values #t (check-not-nested s_29 (add1 pos_31) config_19))
          (values #f (check-not-nested s_29 pos_31 config_19)))))))
(define check-not-nested
  (lambda (s_31 pos_33 config_20)
    (begin
      (let-values (((pos_34) pos_33) ((s_32) s_31))
        (let ((tmp_18
               (if (= pos_34 (chytes-length$1 s_32))
                 'eos
                 (chytes-ref/char s_32 pos_34))))
          (if (if (equal? tmp_18 '#\x3f)
                #t
                (if (equal? tmp_18 '#\x2a) #t (equal? tmp_18 '#\x2b)))
            (parse-error
             s_31
             pos_33
             config_20
             "nested `~a` in patten"
             (integer->char (chytes-ref$1 s_31 pos_33)))
            (if (equal? tmp_18 '#\x7b)
              (if (|#%app| parse-config-px? config_20)
                (parse-error s_31 pos_33 config_20 "nested `{` in pattern")
                (void))
              (void)))))
      pos_33)))
(define parse-atom
  (lambda (s_33 pos_35 config_21)
    (let ((tmp_19 (integer->char (chytes-ref$1 s_33 pos_35))))
      (if (equal? tmp_19 '#\x7c)
        (values rx:empty pos_35)
        (if (equal? tmp_19 '#\x28)
          (parse-parenthesized-atom s_33 (add1 pos_35) config_21)
          (if (equal? tmp_19 '#\x5b)
            (let-values (((range_20 pos2_8)
                          (parse-range/not s_33 (add1 pos_35) config_21)))
              (values (rx-range range_20 (chytes-limit s_33)) pos2_8))
            (if (equal? tmp_19 '#\x2e)
              (let ((rx_7
                     (if (|#%app| parse-config-multi-line? config_21)
                       (rx-range
                        (range-invert
                         (range-add empty-range 10)
                         (chytes-limit s_33))
                        (chytes-limit s_33))
                       rx:any)))
                (values rx_7 (add1 pos_35)))
              (if (equal? tmp_19 '#\x5e)
                (values
                 (if (|#%app| parse-config-multi-line? config_21)
                   rx:line-start
                   rx:start)
                 (add1 pos_35))
                (if (equal? tmp_19 '#\x24)
                  (values
                   (if (|#%app| parse-config-multi-line? config_21)
                     rx:line-end
                     rx:end)
                   (add1 pos_35))
                  (parse-literal s_33 pos_35 config_21))))))))))
(define parse-parenthesized-atom
  (lambda (s_34 pos_36 config_22)
    (let-values (((pos_37) pos_36) ((s_35) s_34))
      (let ((tmp_20
             (if (= pos_37 (chytes-length$1 s_35))
               'eos
               (chytes-ref/char s_35 pos_37))))
        (if (equal? tmp_20 'eos)
          (missing-closing-error s_34 pos_36 config_22)
          (if (equal? tmp_20 '#\x3f)
            (let ((pos2_9 (add1 pos_36)))
              (let-values (((pos_38) pos2_9) ((s_36) s_34))
                (let ((tmp_21
                       (if (= pos_38 (chytes-length$1 s_36))
                         'eos
                         (chytes-ref/char s_36 pos_38))))
                  (if (equal? tmp_21 'eos)
                    (bad-?-sequence-error s_34 pos2_9 config_22)
                    (if (equal? tmp_21 '#\x3e)
                      (let ((pre-num-groups_0 (config-group-number config_22)))
                        (let-values (((rx_8 pos3_7)
                                      (parse-regexp/maybe-empty
                                       s_34
                                       (add1 pos2_9)
                                       config_22)))
                          (let ((post-num-groups_0
                                 (config-group-number config_22)))
                            (values
                             (rx-cut
                              rx_8
                              pre-num-groups_0
                              (- post-num-groups_0 pre-num-groups_0))
                             (check-close-paren s_34 pos3_7 config_22)))))
                      (if (equal? tmp_21 '#\x28)
                        (parse-conditional s_34 (add1 pos2_9) config_22)
                        (if (if (equal? tmp_21 '#\x69)
                              #t
                              (if (equal? tmp_21 '#\x73)
                                #t
                                (if (equal? tmp_21 '#\x6d)
                                  #t
                                  (if (equal? tmp_21 '#\x2d)
                                    #t
                                    (equal? tmp_21 '#\x3a)))))
                          (let-values (((config2_0 pos3_8)
                                        (parse-mode s_34 pos2_9 config_22)))
                            (let-values (((pos_39) pos3_8) ((s_37) s_34))
                              (let ((tmp_22
                                     (if (= pos_39 (chytes-length$1 s_37))
                                       'eos
                                       (chytes-ref/char s_37 pos_39))))
                                (if (equal? tmp_22 '#\x3a)
                                  (let-values (((rx_9 pos4_2)
                                                (parse-regexp/maybe-empty
                                                 s_34
                                                 (add1 pos3_8)
                                                 config2_0)))
                                    (values
                                     rx_9
                                     (check-close-paren
                                      s_34
                                      pos4_2
                                      config2_0)))
                                  (parse-error
                                   s_34
                                   pos3_8
                                   config2_0
                                   (string-append
                                    "expected `:` or another mode after `(?` and a mode sequence;\n"
                                    " a mode is `i`, `-i`, `m`, `-m`, `s`, or `-s`"))))))
                          (parse-look s_34 pos2_9 config_22))))))))
            (let ((group-number_0 (config-group-number config_22)))
              (let-values (((rx_10 pos2_10)
                            (parse-regexp/maybe-empty
                             s_34
                             pos_36
                             (config-group-number+1 config_22))))
                (values
                 (rx-group rx_10 group-number_0)
                 (check-close-paren s_34 pos2_10 config_22))))))))))
(define parse-look
  (lambda (s_38 pos2_11 config_23)
    (let ((pre-num-groups_1 (config-group-number config_23)))
      (let ((span-num-groups_0
             (lambda () (- (config-group-number config_23) pre-num-groups_1))))
        (let ((tmp_23 (integer->char (chytes-ref$1 s_38 pos2_11))))
          (if (equal? tmp_23 '#\x3d)
            (let-values (((rx_11 pos3_9)
                          (parse-regexp/maybe-empty
                           s_38
                           (add1 pos2_11)
                           config_23)))
              (values
               (|#%app|
                rx:lookahead7.1
                rx_11
                #t
                pre-num-groups_1
                (span-num-groups_0))
               (check-close-paren s_38 pos3_9 config_23)))
            (if (equal? tmp_23 '#\x21)
              (let-values (((rx_12 pos3_10)
                            (parse-regexp/maybe-empty
                             s_38
                             (add1 pos2_11)
                             config_23)))
                (values
                 (|#%app|
                  rx:lookahead7.1
                  rx_12
                  #f
                  pre-num-groups_1
                  (span-num-groups_0))
                 (check-close-paren s_38 pos3_10 config_23)))
              (if (equal? tmp_23 '#\x3c)
                (let ((pos2+_0 (add1 pos2_11)))
                  (let-values (((pos_40) pos2+_0) ((s_39) s_38))
                    (let ((tmp_24
                           (if (= pos_40 (chytes-length$1 s_39))
                             'eos
                             (chytes-ref/char s_39 pos_40))))
                      (if (equal? tmp_24 'eos)
                        (bad-?-sequence-error s_38 pos2+_0 config_23)
                        (if (equal? tmp_24 '#\x3d)
                          (let-values (((rx_13 pos3_11)
                                        (parse-regexp/maybe-empty
                                         s_38
                                         (add1 pos2+_0)
                                         config_23)))
                            (values
                             (|#%app|
                              rx:lookbehind8.1
                              rx_13
                              #t
                              0
                              0
                              pre-num-groups_1
                              (span-num-groups_0))
                             (check-close-paren s_38 pos3_11 config_23)))
                          (if (equal? tmp_24 '#\x21)
                            (let-values (((rx_14 pos3_12)
                                          (parse-regexp/maybe-empty
                                           s_38
                                           (add1 pos2+_0)
                                           config_23)))
                              (values
                               (|#%app|
                                rx:lookbehind8.1
                                rx_14
                                #f
                                0
                                0
                                pre-num-groups_1
                                (span-num-groups_0))
                               (check-close-paren s_38 pos3_12 config_23)))
                            (bad-?-sequence-error s_38 pos2+_0 config_23)))))))
                (bad-?-sequence-error s_38 pos2_11 config_23)))))))))
(define parse-conditional
  (lambda (s_40 pos_41 config_24)
    (let ((tst-pre-num-groups_0 (config-group-number config_24)))
      (let-values (((tst_1 pos2_12) (parse-test s_40 pos_41 config_24)))
        (let ((tst-span-num-groups_0
               (- (config-group-number config_24) tst-pre-num-groups_0)))
          (let-values (((pces_0 pos3_13) (parse-pces s_40 pos2_12 config_24)))
            (let-values (((pos_17) pos3_13) ((s_41) s_40))
              (let ((tmp_25
                     (if (= pos_17 (chytes-length$1 s_41))
                       'eos
                       (chytes-ref/char s_41 pos_17))))
                (if (equal? tmp_25 'eos)
                  (missing-closing-error s_40 pos3_13 config_24)
                  (if (equal? tmp_25 '#\x7c)
                    (let-values (((pces2_1 pos4_3)
                                  (parse-pces s_40 (add1 pos3_13) config_24)))
                      (let-values (((pos_42) pos4_3) ((s_42) s_40))
                        (let ((tmp_26
                               (if (= pos_42 (chytes-length$1 s_42))
                                 'eos
                                 (chytes-ref/char s_42 pos_42))))
                          (if (equal? tmp_26 'eos)
                            (missing-closing-error s_40 pos4_3 config_24)
                            (if (equal? tmp_26 '#\x29)
                              (values
                               (rx-conditional
                                tst_1
                                (rx-sequence pces_0)
                                (rx-sequence pces2_1)
                                tst-pre-num-groups_0
                                tst-span-num-groups_0)
                               (add1 pos4_3))
                              (parse-error
                               s_40
                               pos4_3
                               config_24
                               "expected `)` to close `(?(...)...` after second branch"))))))
                    (if (equal? tmp_25 '#\x29)
                      (values
                       (rx-conditional
                        tst_1
                        (rx-sequence pces_0)
                        rx:empty
                        tst-pre-num-groups_0
                        tst-span-num-groups_0)
                       (add1 pos3_13))
                      (void))))))))))))
(define parse-test
  (lambda (s_43 pos_43 config_25)
    (let-values (((pos_44) pos_43) ((s_44) s_43))
      (let ((tmp_27
             (if (= pos_44 (chytes-length$1 s_44))
               'eos
               (chytes-ref/char s_44 pos_44))))
        (if (equal? tmp_27 'eos)
          (missing-closing-error s_43 pos_43 config_25)
          (if (equal? tmp_27 '#\x3f)
            (parse-look s_43 (add1 pos_43) config_25)
            (let ((c_6 (chytes-ref$1 s_43 pos_43)))
              (if (if (>= c_6 48) (<= c_6 57) #f)
                (let-values ((()
                              (begin
                                (set-box!
                                 (|#%app|
                                  parse-config-references?-box
                                  config_25)
                                 #t)
                                (values))))
                  (let-values (((n_2 pos3_14)
                                (parse-integer 0 s_43 pos_43 config_25)))
                    (begin
                      (if (if (< pos3_14 (chytes-length$1 s_43))
                            (= (chytes-ref$1 s_43 pos3_14) 41)
                            #f)
                        (void)
                        (parse-error
                         s_43
                         pos3_14
                         config_25
                         "expected `)` after `(?(` followed by digits"))
                      (values
                       (|#%app| rx:reference10.1 n_2 #f)
                       (add1 pos3_14)))))
                (parse-error
                 s_43
                 pos_43
                 config_25
                 "expected `(?=`, `(?!`, `(?<`, or digit after `(?(`")))))))))
(define parse-integer
  (lambda (n_3 s_45 pos_45 config_26)
    (if (= pos_45 (chytes-length$1 s_45))
      (values n_3 pos_45)
      (let ((c_7 (chytes-ref$1 s_45 pos_45)))
        (if (if (>= c_7 48) (<= c_7 57) #f)
          (let ((n2_1 (+ (* n_3 10) (- c_7 48))))
            (parse-integer n2_1 s_45 (add1 pos_45) config_26))
          (values n_3 pos_45))))))
(define parse-literal
  (lambda (s_46 pos_46 config_27)
    (let ((c_8 (chytes-ref$1 s_46 pos_46)))
      (let ((tmp_28 (integer->char c_8)))
        (if (if (equal? tmp_28 '#\x2a)
              #t
              (if (equal? tmp_28 '#\x2b) #t (equal? tmp_28 '#\x3f)))
          (parse-error
           s_46
           pos_46
           config_27
           "`~a` follows nothing in pattern"
           (integer->char c_8))
          (if (equal? tmp_28 '#\x7b)
            (if (|#%app| parse-config-px? config_27)
              (parse-error
               s_46
               pos_46
               config_27
               "`{` follows nothing in pattern")
              (values c_8 (add1 pos_46)))
            (if (equal? tmp_28 '#\x5c)
              (parse-backslash-literal s_46 (add1 pos_46) config_27)
              (if (equal? tmp_28 '#\x29)
                (parse-error s_46 pos_46 config_27 "unmatched `)` in pattern")
                (if (if (equal? tmp_28 '#\x5d) #t (equal? tmp_28 '#\x7d))
                  (if (|#%app| parse-config-px? config_27)
                    (parse-error
                     s_46
                     pos_46
                     config_27
                     "unmatched `~a` in pattern"
                     (integer->char c_8))
                    (values c_8 (add1 pos_46)))
                  (if (|#%app| parse-config-case-sensitive? config_27)
                    (values c_8 (add1 pos_46))
                    (values
                     (rx-range
                      (range-add* empty-range c_8 config_27)
                      (chytes-limit s_46))
                     (add1 pos_46))))))))))))
(define parse-backslash-literal
  (lambda (s_47 pos2_13 config_28)
    (if (= pos2_13 (chytes-length$1 s_47))
      (values 0 pos2_13)
      (let ((c2_0 (chytes-ref$1 s_47 pos2_13)))
        (if (if (|#%app| parse-config-px? config_28)
              (if (>= c2_0 48) (<= c2_0 57) #f)
              #f)
          (let-values ((()
                        (begin
                          (set-box!
                           (|#%app| parse-config-references?-box config_28)
                           #t)
                          (values))))
            (let-values (((n_4 pos3_15)
                          (parse-integer 0 s_47 pos2_13 config_28)))
              (values
               (|#%app|
                rx:reference10.1
                n_4
                (|#%app| parse-config-case-sensitive? config_28))
               pos3_15)))
          (if (if (|#%app| parse-config-px? config_28)
                (let ((or-part_13 (if (>= c2_0 97) (<= c2_0 122) #f)))
                  (if or-part_13 or-part_13 (if (>= c2_0 65) (<= c2_0 90) #f)))
                #f)
            (let ((tmp_29 (integer->char c2_0)))
              (if (if (equal? tmp_29 '#\x70) #t (equal? tmp_29 '#\x50))
                (parse-unicode-categories c2_0 s_47 (add1 pos2_13) config_28)
                (if (equal? tmp_29 '#\x62)
                  (values rx:word-boundary (add1 pos2_13))
                  (if (equal? tmp_29 '#\x42)
                    (values rx:not-word-boundary (add1 pos2_13))
                    (let-values (((success?_2 range_21 pos3_16)
                                  (parse-class s_47 pos2_13 config_28)))
                      (if success?_2
                        (values
                         (rx-range range_21 (chytes-limit s_47))
                         pos3_16)
                        (parse-error
                         s_47
                         pos2_13
                         config_28
                         "illegal alphabetic escape")))))))
            (values c2_0 (add1 pos2_13))))))))
(define parse-mode
  (lambda (s_48 pos_47 config_29)
    (let-values (((pos_48) pos_47) ((s_49) s_48))
      (let ((tmp_30
             (if (= pos_48 (chytes-length$1 s_49))
               'eos
               (chytes-ref/char s_49 pos_48))))
        (if (equal? tmp_30 'eos)
          (values config_29 pos_47)
          (if (equal? tmp_30 '#\x69)
            (parse-mode
             s_48
             (add1 pos_47)
             (config-case-sensitive config_29 #f))
            (if (equal? tmp_30 '#\x73)
              (parse-mode s_48 (add1 pos_47) (config-multi-line config_29 #f))
              (if (equal? tmp_30 '#\x6d)
                (parse-mode
                 s_48
                 (add1 pos_47)
                 (config-multi-line config_29 #t))
                (if (equal? tmp_30 '#\x2d)
                  (let ((pos2_14 (add1 pos_47)))
                    (let-values (((pos_49) pos2_14) ((s_50) s_48))
                      (let ((tmp_31
                             (if (= pos_49 (chytes-length$1 s_50))
                               'eos
                               (chytes-ref/char s_50 pos_49))))
                        (if (equal? tmp_31 'eos)
                          (values config_29 pos_47)
                          (if (equal? tmp_31 '#\x69)
                            (parse-mode
                             s_48
                             (add1 pos2_14)
                             (config-case-sensitive config_29 #t))
                            (if (equal? tmp_31 '#\x73)
                              (parse-mode
                               s_48
                               (add1 pos2_14)
                               (config-multi-line config_29 #t))
                              (if (equal? tmp_31 '#\x6d)
                                (parse-mode
                                 s_48
                                 (add1 pos2_14)
                                 (config-multi-line config_29 #f))
                                (values config_29 pos_47))))))))
                  (values config_29 pos_47))))))))))
(define check-close-paren
  (lambda (s_51 pos_50 config_30)
    (begin
      (if (if (< pos_50 (chytes-length$1 s_51))
            (= 41 (chytes-ref$1 s_51 pos_50))
            #f)
        (void)
        (parse-error s_51 pos_50 config_30 "expected a closing `)`"))
      (add1 pos_50))))
(define missing-closing-error
  (lambda (s_52 pos_51 config_31)
    (parse-error
     s_52
     pos_51
     config_31
     "missing closing parenthesis in pattern")))
(define bad-?-sequence-error
  (lambda (s_53 pos_52 config_32)
    (parse-error
     s_53
     pos_52
     config_32
     "expected `:`, `=`, `!`, `<=`, `<!`, `i`, `-i`, `m`, `-m`, `s`, or `-s` after `(?`")))
(define validate
  (lambda (rx_15 num-groups_0)
    (let ((group-sizes_0 hash661))
      (let ((depends-sizes_0 hash661))
        (let ((must-sizes_0 hash661))
          (let ((might-be-empty-error_0
                 (lambda ()
                   (regexp-error
                    "`*`, `+`, or `{...}` operand could be empty"))))
            (let-values (((min-len_0 max-len_0 max-lookbehind_0)
                          ((letrec ((validate_0
                                     (lambda (rx_16)
                                       (if (eq? rx_16 rx:never)
                                         (values 1 1 0)
                                         (if (let ((or-part_14
                                                    (eq? rx_16 rx:any)))
                                               (if or-part_14
                                                 or-part_14
                                                 (let ((or-part_15
                                                        (exact-integer?
                                                         rx_16)))
                                                   (if or-part_15
                                                     or-part_15
                                                     (|#%app|
                                                      rx:range?
                                                      rx_16)))))
                                           (values 1 1 0)
                                           (if (bytes? rx_16)
                                             (let ((len_2
                                                    (bytes-length rx_16)))
                                               (values len_2 len_2 0))
                                             (if (let ((or-part_16
                                                        (eq? rx_16 rx:empty)))
                                                   (if or-part_16
                                                     or-part_16
                                                     (let ((or-part_17
                                                            (eq?
                                                             rx_16
                                                             rx:start)))
                                                       (if or-part_17
                                                         or-part_17
                                                         (let ((or-part_18
                                                                (eq?
                                                                 rx_16
                                                                 rx:end)))
                                                           (if or-part_18
                                                             or-part_18
                                                             (let ((or-part_19
                                                                    (eq?
                                                                     rx_16
                                                                     rx:line-start)))
                                                               (if or-part_19
                                                                 or-part_19
                                                                 (eq?
                                                                  rx_16
                                                                  rx:line-end)))))))))
                                               (values 0 0 0)
                                               (if (let ((or-part_20
                                                          (eq?
                                                           rx_16
                                                           rx:word-boundary)))
                                                     (if or-part_20
                                                       or-part_20
                                                       (eq?
                                                        rx_16
                                                        rx:not-word-boundary)))
                                                 (values 0 0 1)
                                                 (if (|#%app| rx:alts? rx_16)
                                                   (let-values (((min1_0
                                                                  max1_0
                                                                  lb1_0)
                                                                 (validate_0
                                                                  (|#%app|
                                                                   rx:alts-rx1
                                                                   rx_16))))
                                                     (let-values (((min2_0
                                                                    max2_0
                                                                    lb2_0)
                                                                   (validate_0
                                                                    (|#%app|
                                                                     rx:alts-rx2
                                                                     rx_16))))
                                                       (values
                                                        (min min1_0 min2_0)
                                                        (max max1_0 max2_0)
                                                        (max lb1_0 lb2_0))))
                                                   (if (|#%app|
                                                        rx:sequence?
                                                        rx_16)
                                                     (let ((lst_8
                                                            (|#%app|
                                                             rx:sequence-rxs
                                                             rx_16)))
                                                       (begin
                                                         (if (list? lst_8)
                                                           (void)
                                                           (check-list lst_8))
                                                         ((letrec ((for-loop_7
                                                                    (lambda (min-len_1
                                                                             max-len_1
                                                                             max-lb_0
                                                                             lst_9)
                                                                      (if (pair?
                                                                           lst_9)
                                                                        (let-values (((rx_17)
                                                                                      (unsafe-car
                                                                                       lst_9))
                                                                                     ((rest_4)
                                                                                      (unsafe-cdr
                                                                                       lst_9)))
                                                                          (let-values (((min-len_2
                                                                                         max-len_2
                                                                                         max-lb_1)
                                                                                        (let-values (((min-len_3)
                                                                                                      min-len_1)
                                                                                                     ((max-len_3)
                                                                                                      max-len_1)
                                                                                                     ((max-lb_2)
                                                                                                      max-lb_0))
                                                                                          (let-values (((min-len_4
                                                                                                         max-len_4
                                                                                                         max-lb_3)
                                                                                                        (let-values (((min1_1
                                                                                                                       max1_1
                                                                                                                       lb1_1)
                                                                                                                      (validate_0
                                                                                                                       rx_17)))
                                                                                                          (values
                                                                                                           (+
                                                                                                            min-len_3
                                                                                                            min1_1)
                                                                                                           (+
                                                                                                            max-len_3
                                                                                                            max1_1)
                                                                                                           (max
                                                                                                            max-lb_2
                                                                                                            lb1_1)))))
                                                                                            (values
                                                                                             min-len_4
                                                                                             max-len_4
                                                                                             max-lb_3)))))
                                                                            (if (not
                                                                                 #f)
                                                                              (for-loop_7
                                                                               min-len_2
                                                                               max-len_2
                                                                               max-lb_1
                                                                               rest_4)
                                                                              (values
                                                                               min-len_2
                                                                               max-len_2
                                                                               max-lb_1))))
                                                                        (values
                                                                         min-len_1
                                                                         max-len_1
                                                                         max-lb_0)))))
                                                            for-loop_7)
                                                          0
                                                          0
                                                          0
                                                          lst_8)))
                                                     (if (|#%app|
                                                          rx:group?
                                                          rx_16)
                                                       (let-values (((min1_2
                                                                      max1_2
                                                                      lb1_2)
                                                                     (validate_0
                                                                      (|#%app|
                                                                       rx:group-rx
                                                                       rx_16))))
                                                         (begin
                                                           (set! group-sizes_0
                                                             (hash-set
                                                              group-sizes_0
                                                              (|#%app|
                                                               rx:group-number
                                                               rx_16)
                                                              min1_2))
                                                           (values
                                                            min1_2
                                                            max1_2
                                                            lb1_2)))
                                                       (if (|#%app|
                                                            rx:repeat?
                                                            rx_16)
                                                         (let ((old-depends-sizes_0
                                                                depends-sizes_0))
                                                           (let-values ((()
                                                                         (begin
                                                                           (set! depends-sizes_0
                                                                             hash661)
                                                                           (values))))
                                                             (let-values (((min1_3
                                                                            max1_3
                                                                            lb1_3)
                                                                           (validate_0
                                                                            (|#%app|
                                                                             rx:repeat-rx
                                                                             rx_16))))
                                                               (begin
                                                                 (if (zero?
                                                                      min1_3)
                                                                   (might-be-empty-error_0)
                                                                   (void))
                                                                 (set! must-sizes_0
                                                                   (merge-depends-sizes
                                                                    must-sizes_0
                                                                    depends-sizes_0))
                                                                 (set! depends-sizes_0
                                                                   (merge-depends-sizes
                                                                    old-depends-sizes_0
                                                                    depends-sizes_0))
                                                                 (values
                                                                  (*
                                                                   min1_3
                                                                   (|#%app|
                                                                    rx:repeat-min
                                                                    rx_16))
                                                                  (*
                                                                   max1_3
                                                                   (|#%app|
                                                                    rx:repeat-max
                                                                    rx_16))
                                                                  lb1_3)))))
                                                         (if (|#%app|
                                                              rx:maybe?
                                                              rx_16)
                                                           (let-values (((min1_4
                                                                          max1_4
                                                                          lb1_4)
                                                                         (validate_0
                                                                          (|#%app|
                                                                           rx:maybe-rx
                                                                           rx_16))))
                                                             (values
                                                              0
                                                              max1_4
                                                              lb1_4))
                                                           (if (|#%app|
                                                                rx:conditional?
                                                                rx_16)
                                                             (let-values (((min0_0
                                                                            max0_0
                                                                            lb0_0)
                                                                           (validate_0
                                                                            (|#%app|
                                                                             rx:conditional-tst
                                                                             rx_16))))
                                                               (let-values (((min1_5
                                                                              max1_5
                                                                              lb1_5)
                                                                             (validate_0
                                                                              (|#%app|
                                                                               rx:conditional-rx1
                                                                               rx_16))))
                                                                 (let-values (((min2_1
                                                                                max2_1
                                                                                lb2_1)
                                                                               (validate_0
                                                                                (|#%app|
                                                                                 rx:conditional-rx2
                                                                                 rx_16))))
                                                                   (values
                                                                    (min
                                                                     min1_5
                                                                     min2_1)
                                                                    (max
                                                                     max1_5
                                                                     max2_1)
                                                                    (max
                                                                     lb0_0
                                                                     lb1_5
                                                                     lb2_1)))))
                                                             (if (|#%app|
                                                                  rx:lookahead?
                                                                  rx_16)
                                                               (let-values (((min1_6
                                                                              max1_6
                                                                              lb1_6)
                                                                             (validate_0
                                                                              (|#%app|
                                                                               rx:lookahead-rx
                                                                               rx_16))))
                                                                 (values
                                                                  0
                                                                  0
                                                                  lb1_6))
                                                               (if (|#%app|
                                                                    rx:lookbehind?
                                                                    rx_16)
                                                                 (let-values (((min1_7
                                                                                max1_7
                                                                                lb1_7)
                                                                               (validate_0
                                                                                (|#%app|
                                                                                 rx:lookbehind-rx
                                                                                 rx_16))))
                                                                   (begin
                                                                     (if (=
                                                                          +inf.0
                                                                          max1_7)
                                                                       (regexp-error
                                                                        "lookbehind pattern does not match a bounded length")
                                                                       (void))
                                                                     (|#%app|
                                                                      set-rx:lookbehind-lb-min!
                                                                      rx_16
                                                                      min1_7)
                                                                     (|#%app|
                                                                      set-rx:lookbehind-lb-max!
                                                                      rx_16
                                                                      max1_7)
                                                                     (values
                                                                      0
                                                                      0
                                                                      (max
                                                                       max1_7
                                                                       lb1_7))))
                                                                 (if (|#%app|
                                                                      rx:cut?
                                                                      rx_16)
                                                                   (validate_0
                                                                    (|#%app|
                                                                     rx:cut-rx
                                                                     rx_16))
                                                                   (if (|#%app|
                                                                        rx:reference?
                                                                        rx_16)
                                                                     (let ((n_5
                                                                            (|#%app|
                                                                             rx:reference-n
                                                                             rx_16)))
                                                                       (let-values ((()
                                                                                     (begin
                                                                                       (if (<=
                                                                                            n_5
                                                                                            num-groups_0)
                                                                                         (void)
                                                                                         (regexp-error
                                                                                          "backreference number is larger than the highest-numbered cluster"))
                                                                                       (values))))
                                                                         (let ((min-size_0
                                                                                (hash-ref
                                                                                 group-sizes_0
                                                                                 n_5
                                                                                 #f)))
                                                                           (if min-size_0
                                                                             (values
                                                                              min-size_0
                                                                              +inf.0
                                                                              0)
                                                                             (begin
                                                                               (set! depends-sizes_0
                                                                                 (hash-set
                                                                                  depends-sizes_0
                                                                                  (sub1
                                                                                   n_5)
                                                                                  #t))
                                                                               (values
                                                                                1
                                                                                +inf.0
                                                                                0))))))
                                                                     (if (|#%app|
                                                                          rx:unicode-categories?
                                                                          rx_16)
                                                                       (values
                                                                        1
                                                                        4
                                                                        0)
                                                                       (error
                                                                        'validate
                                                                        "internal error: ~s"
                                                                        rx_16))))))))))))))))))))
                             validate_0)
                           rx_15)))
              (begin
                (let ((ht_2 must-sizes_0))
                  (begin
                    (if ((lambda (ht_3) (hash? ht_3)) ht_2)
                      (void)
                      (check-in-hash-keys ht_2))
                    ((letrec ((for-loop_8
                               (lambda (i_4)
                                 (if i_4
                                   (let ((n_6 (hash-iterate-key ht_2 i_4)))
                                     (let-values ((()
                                                   (let-values ((()
                                                                 (begin
                                                                   (if (positive?
                                                                        (hash-ref
                                                                         group-sizes_0
                                                                         n_6
                                                                         0))
                                                                     (void)
                                                                     (might-be-empty-error_0))
                                                                   (values))))
                                                     (values))))
                                       (if (not #f)
                                         (for-loop_8
                                          (hash-iterate-next ht_2 i_4))
                                         (values))))
                                   (values)))))
                       for-loop_8)
                     (hash-iterate-first ht_2))))
                (void)
                max-lookbehind_0))))))))
(define merge-depends-sizes
  (lambda (ht1_0 ht2_0)
    (if (zero? (hash-count ht1_0))
      ht2_0
      (if (< (hash-count ht2_0) (hash-count ht1_0))
        (merge-depends-sizes ht2_0 ht1_0)
        (let ((ht_4 ht1_0))
          (begin
            (if ((lambda (ht_5) (hash? ht_5)) ht_4)
              (void)
              (check-in-hash-keys ht_4))
            ((letrec ((for-loop_9
                       (lambda (ht2_1 i_5)
                         (if i_5
                           (let ((k_0 (hash-iterate-key ht_4 i_5)))
                             (let ((ht2_2
                                    (let ((ht2_3 ht2_1))
                                      (let ((ht2_4 (hash-set ht2_3 k_0 #t)))
                                        (values ht2_4)))))
                               (if (not #f)
                                 (for-loop_9
                                  ht2_2
                                  (hash-iterate-next ht_4 i_5))
                                 ht2_2)))
                           ht2_1))))
               for-loop_9)
             ht2_0
             (hash-iterate-first ht_4))))))))
(define convert
  (lambda (rx_15)
    (if (eq? rx_15 rx:any)
      (|#%app| rx:unicode-categories12.1 null #f)
      (if (exact-integer? rx_15)
        (if (< rx_15 128)
          rx_15
          (string->bytes/utf-8 (string (integer->char rx_15))))
        (if (|#%app| rx:range? rx_15)
          (let ((range_22 (|#%app| rx:range-range rx_15)))
            (if (range-within? range_22 0 127) rx_15 (range->alts range_22)))
          (if (bytes? rx_15)
            (convert (bytes->string/latin-1 rx_15))
            (if (string? rx_15)
              (string->bytes/utf-8 rx_15)
              (if (|#%app| rx:alts? rx_15)
                (rx-alts
                 (convert (|#%app| rx:alts-rx1 rx_15))
                 (convert (|#%app| rx:alts-rx2 rx_15))
                 255)
                (if (|#%app| rx:sequence? rx_15)
                  (let ((the-struct_2 rx_15))
                    (if (|#%app| rx:sequence? the-struct_2)
                      (let ((rxs1_0
                             (let ((lst_10 (|#%app| rx:sequence-rxs rx_15)))
                               (begin
                                 (if (list? lst_10) (void) (check-list lst_10))
                                 ((letrec ((for-loop_10
                                            (lambda (lst_11)
                                              (if (pair? lst_11)
                                                (let-values (((rx_18)
                                                              (unsafe-car
                                                               lst_11))
                                                             ((rest_5)
                                                              (unsafe-cdr
                                                               lst_11)))
                                                  (let ((post-guard-var_2
                                                         (lambda () #t)))
                                                    (let ((elem_2
                                                           (convert rx_18)))
                                                      (let ((result_5
                                                             (if (post-guard-var_2)
                                                               (for-loop_10
                                                                rest_5)
                                                               null)))
                                                        (cons
                                                         elem_2
                                                         result_5)))))
                                                null))))
                                    for-loop_10)
                                  lst_10)))))
                        (|#%app|
                         rx:sequence2.1
                         rxs1_0
                         (|#%app| rx:sequence-needs-backtrack? the-struct_2)))
                      (raise-argument-error
                       'struct-copy
                       "rx:sequence?"
                       the-struct_2)))
                  (if (|#%app| rx:group? rx_15)
                    (let ((the-struct_3 rx_15))
                      (if (|#%app| rx:group? the-struct_3)
                        (let ((rx2_1 (convert (|#%app| rx:group-rx rx_15))))
                          (|#%app|
                           rx:group3.1
                           rx2_1
                           (|#%app| rx:group-number the-struct_3)))
                        (raise-argument-error
                         'struct-copy
                         "rx:group?"
                         the-struct_3)))
                    (if (|#%app| rx:repeat? rx_15)
                      (let ((the-struct_4 rx_15))
                        (if (|#%app| rx:repeat? the-struct_4)
                          (let ((rx3_0 (convert (|#%app| rx:repeat-rx rx_15))))
                            (|#%app|
                             rx:repeat4.1
                             rx3_0
                             (|#%app| rx:repeat-min the-struct_4)
                             (|#%app| rx:repeat-max the-struct_4)
                             (|#%app| rx:repeat-non-greedy? the-struct_4)))
                          (raise-argument-error
                           'struct-copy
                           "rx:repeat?"
                           the-struct_4)))
                      (if (|#%app| rx:maybe? rx_15)
                        (let ((the-struct_5 rx_15))
                          (if (|#%app| rx:maybe? the-struct_5)
                            (let ((rx4_0
                                   (convert (|#%app| rx:maybe-rx rx_15))))
                              (|#%app|
                               rx:maybe5.1
                               rx4_0
                               (|#%app| rx:maybe-non-greedy? the-struct_5)))
                            (raise-argument-error
                             'struct-copy
                             "rx:maybe?"
                             the-struct_5)))
                        (if (|#%app| rx:conditional? rx_15)
                          (let ((the-struct_6 rx_15))
                            (if (|#%app| rx:conditional? the-struct_6)
                              (let-values (((tst5_0)
                                            (convert
                                             (|#%app|
                                              rx:conditional-tst
                                              rx_15)))
                                           ((rx16_0)
                                            (convert
                                             (|#%app|
                                              rx:conditional-rx1
                                              rx_15)))
                                           ((rx27_0)
                                            (convert
                                             (|#%app|
                                              rx:conditional-rx2
                                              rx_15))))
                                (|#%app|
                                 rx:conditional6.1
                                 tst5_0
                                 rx16_0
                                 rx27_0
                                 (|#%app| rx:conditional-n-start the-struct_6)
                                 (|#%app| rx:conditional-num-n the-struct_6)
                                 (|#%app|
                                  rx:conditional-needs-backtrack?
                                  the-struct_6)))
                              (raise-argument-error
                               'struct-copy
                               "rx:conditional?"
                               the-struct_6)))
                          (if (|#%app| rx:lookahead? rx_15)
                            (let ((the-struct_7 rx_15))
                              (if (|#%app| rx:lookahead? the-struct_7)
                                (let ((rx8_0
                                       (convert
                                        (|#%app| rx:lookahead-rx rx_15))))
                                  (|#%app|
                                   rx:lookahead7.1
                                   rx8_0
                                   (|#%app| rx:lookahead-match? the-struct_7)
                                   (|#%app| rx:lookahead-n-start the-struct_7)
                                   (|#%app| rx:lookahead-num-n the-struct_7)))
                                (raise-argument-error
                                 'struct-copy
                                 "rx:lookahead?"
                                 the-struct_7)))
                            (if (|#%app| rx:lookbehind? rx_15)
                              (let ((the-struct_8 rx_15))
                                (if (|#%app| rx:lookbehind? the-struct_8)
                                  (let ((rx9_0
                                         (convert
                                          (|#%app| rx:lookbehind-rx rx_15))))
                                    (|#%app|
                                     rx:lookbehind8.1
                                     rx9_0
                                     (|#%app|
                                      rx:lookbehind-match?
                                      the-struct_8)
                                     (|#%app|
                                      rx:lookbehind-lb-min
                                      the-struct_8)
                                     (|#%app|
                                      rx:lookbehind-lb-max
                                      the-struct_8)
                                     (|#%app|
                                      rx:lookbehind-n-start
                                      the-struct_8)
                                     (|#%app|
                                      rx:lookbehind-num-n
                                      the-struct_8)))
                                  (raise-argument-error
                                   'struct-copy
                                   "rx:lookbehind?"
                                   the-struct_8)))
                              (if (|#%app| rx:cut? rx_15)
                                (let ((the-struct_9 rx_15))
                                  (if (|#%app| rx:cut? the-struct_9)
                                    (let ((rx10_0
                                           (convert
                                            (|#%app| rx:cut-rx rx_15))))
                                      (|#%app|
                                       rx:cut9.1
                                       rx10_0
                                       (|#%app| rx:cut-n-start the-struct_9)
                                       (|#%app| rx:cut-num-n the-struct_9)
                                       (|#%app|
                                        rx:cut-needs-backtrack?
                                        the-struct_9)))
                                    (raise-argument-error
                                     'struct-copy
                                     "rx:cut?"
                                     the-struct_9)))
                                rx_15))))))))))))))))
(define range->alts
  (lambda (args_4)
    (let ((l_13 (range->list args_4)))
      ((letrec ((loop_9
                 (lambda (l_14)
                   (if (null? l_14)
                     rx:never
                     (let-values (((start_6) (caar l_14))
                                  ((end_3) (cdar l_14)))
                       (let ((seg-end_0
                              (if (<= start_6 127)
                                127
                                (if (<= start_6 2047)
                                  2047
                                  (if (<= start_6 65535)
                                    65535
                                    (if (<= start_6 2097151)
                                      2097151
                                      (void)))))))
                         (if (> end_3 seg-end_0)
                           (loop_9
                            (cons
                             (cons start_6 seg-end_0)
                             (cons (cons (add1 seg-end_0) end_3) (cdr l_14))))
                           (if (<= end_3 127)
                             (rx-alts
                              (rx-range
                               (range-add-span empty-range start_6 end_3)
                               255)
                              (loop_9 (cdr l_14))
                              255)
                             (rx-alts
                              (bytes-range
                               (string->bytes/utf-8
                                (string (integer->char start_6)))
                               (string->bytes/utf-8
                                (string (integer->char end_3))))
                              (loop_9 (cdr l_14))
                              255)))))))))
         loop_9)
       l_13))))
(define bytes-range
  (lambda (start-str_0 end-str_0)
    (if (equal? start-str_0 end-str_0)
      start-str_0
      (if (= 1 (bytes-length start-str_0))
        (rx-range
         (range-add-span
          empty-range
          (bytes-ref start-str_0 0)
          (bytes-ref end-str_0 0))
         255)
        (let ((common_0
               ((letrec ((loop_10
                          (lambda (i_6)
                            (if (=
                                 (bytes-ref start-str_0 i_6)
                                 (bytes-ref end-str_0 i_6))
                              (loop_10 (add1 i_6))
                              i_6))))
                  loop_10)
                0)))
          (let ((common-str_0
                 (if (zero? common_0) #vu8() (subbytes start-str_0 0 common_0))))
            (let ((n_7 (bytes-ref start-str_0 common_0)))
              (let ((m_0 (bytes-ref end-str_0 common_0)))
                (let ((p_3
                       (if (zero-tail? start-str_0 (add1 common_0))
                         n_7
                         (add1 n_7))))
                  (let ((q_0
                         (if (zero-tail? end-str_0 (add1 common_0))
                           m_0
                           (sub1 m_0))))
                    (let ((tail-len_0
                           (sub1 (- (bytes-length start-str_0) common_0))))
                      (let ((n-to-p_0
                             (rx-sequence
                              (list
                               n_7
                               (bytes-range
                                (subbytes start-str_0 (add1 common_0))
                                (vector-ref FFFF-tails tail-len_0))))))
                        (let ((m-and-up_0
                               (rx-sequence
                                (list
                                 m_0
                                 (bytes-range
                                  (vector-ref 0000-tails tail-len_0)
                                  (subbytes end-str_0 (add1 common_0)))))))
                          (let ((p-through-q_0
                                 (if (= (add1 p_3) q_0)
                                   rx:never
                                   (rx-sequence
                                    (cons
                                     (rx-range
                                      (range-add-span empty-range p_3 q_0)
                                      255)
                                     (let-values (((start_7) 0)
                                                  ((end_4) tail-len_0)
                                                  ((inc_3) 1))
                                       (begin
                                         (if (if (real? start_7)
                                               (if (real? end_4)
                                                 (real? inc_3)
                                                 #f)
                                               #f)
                                           (void)
                                           (check-range$1 start_7 end_4 inc_3))
                                         ((letrec ((for-loop_11
                                                    (lambda (pos_53)
                                                      (if (< pos_53 end_4)
                                                        (let ((post-guard-var_3
                                                               (lambda () #t)))
                                                          (let ((elem_3
                                                                 rx:any))
                                                            (let ((result_6
                                                                   (if (post-guard-var_3)
                                                                     (for-loop_11
                                                                      (+
                                                                       pos_53
                                                                       inc_3))
                                                                     null)))
                                                              (cons
                                                               elem_3
                                                               result_6))))
                                                        null))))
                                            for-loop_11)
                                          start_7))))))))
                            (rx-sequence
                             (list
                              (if (= 1 (bytes-length common-str_0))
                                (bytes-ref common-str_0 0)
                                common-str_0)
                              (rx-alts
                               n-to-p_0
                               (rx-alts p-through-q_0 m-and-up_0 255)
                               255)))))))))))))))))
(define FFFF-tails '#(#vu8() #vu8(255) #vu8(255 255) #vu8(255 255 255) #vu8(255 255 255 255)))
(define 0000-tails '#(#vu8() #vu8(0) #vu8(0 0) #vu8(0 0 0) #vu8(0 0 0 0)))
(define zero-tail?
  (lambda (bstr_0 i_7)
    (let-values (((v*_0 start*_0 stop*_1 step*_0)
                  (normalise-inputs
                   'in-bytes
                   "bytes"
                   (lambda (x_1) (bytes? x_1))
                   (lambda (x_2) (unsafe-bytes-length x_2))
                   bstr_0
                   i_7
                   #f
                   1)))
      (begin
        #t
        ((letrec ((for-loop_12
                   (lambda (result_7 idx_0)
                     (if (unsafe-fx< idx_0 stop*_1)
                       (let ((c_9 (unsafe-bytes-ref v*_0 idx_0)))
                         (let ((result_8
                                (let ((result_9 (= c_9 0)))
                                  (values result_9))))
                           (if (if (not ((lambda x_3 (not result_8)) c_9))
                                 (not #f)
                                 #f)
                             (for-loop_12 result_8 (unsafe-fx+ idx_0 1))
                             result_8)))
                       result_7))))
           for-loop_12)
         #t
         start*_0)))))
(define anchored?
  (lambda (rx_15)
    (if (eq? rx_15 rx:start)
      #t
      (if (|#%app| rx:sequence? rx_15)
        ((letrec ((loop_0
                   (lambda (rxs_2)
                     (if (null? rxs_2)
                       #f
                       (if (|#%app| rx:lookahead? (car rxs_2))
                         (loop_0 (cdr rxs_2))
                         (if (|#%app| rx:lookbehind? (car rxs_2))
                           (loop_0 (cdr rxs_2))
                           (anchored? (car rxs_2))))))))
           loop_0)
         (|#%app| rx:sequence-rxs rx_15))
        (if (|#%app| rx:alts? rx_15)
          (if (anchored? (|#%app| rx:alts-rx1 rx_15))
            (anchored? (|#%app| rx:alts-rx2 rx_15))
            #f)
          (if (|#%app| rx:conditional? rx_15)
            (if (anchored? (|#%app| rx:conditional-rx1 rx_15))
              (anchored? (|#%app| rx:conditional-rx2 rx_15))
              #f)
            (if (|#%app| rx:group? rx_15)
              (anchored? (|#%app| rx:group-rx rx_15))
              (if (|#%app| rx:cut? rx_15)
                (anchored? (|#%app| rx:cut-rx rx_15))
                #f))))))))
(define get-must-string
  (lambda (rx_15)
    (if (something-expensive? rx_15)
      (choose (must-string rx_15) (must-range rx_15))
      #f)))
(define choose
  (lambda (bstr_1 seq_0)
    (if (not seq_0)
      bstr_1
      (if (not bstr_1)
        (compile-range-sequence seq_0)
        (if (>= (bytes-length bstr_1) (quotient (length seq_0) 2))
          bstr_1
          (compile-range-sequence seq_0))))))
(define something-expensive?
  (lambda (rx_19)
    (if (let ((or-part_21 (|#%app| rx:alts? rx_19)))
          (if or-part_21 or-part_21 (|#%app| rx:repeat? rx_19)))
      #t
      (if (|#%app| rx:maybe? rx_19)
        (something-expensive? (|#%app| rx:maybe-rx rx_19))
        (if (|#%app| rx:sequence? rx_19)
          (let ((lst_12 (|#%app| rx:sequence-rxs rx_19)))
            (begin
              (if (list? lst_12) (void) (check-list lst_12))
              ((letrec ((for-loop_13
                         (lambda (result_10 lst_13)
                           (if (pair? lst_13)
                             (let-values (((rx_20) (unsafe-car lst_13))
                                          ((rest_6) (unsafe-cdr lst_13)))
                               (let ((result_5
                                      (let ((result_1
                                             (something-expensive? rx_20)))
                                        (values result_1))))
                                 (if (if (not ((lambda x_4 result_5) rx_20))
                                       (not #f)
                                       #f)
                                   (for-loop_13 result_5 rest_6)
                                   result_5)))
                             result_10))))
                 for-loop_13)
               #f
               lst_12)))
          (if (|#%app| rx:conditional? rx_19)
            (let ((or-part_17
                   (something-expensive? (|#%app| rx:conditional-rx1 rx_19))))
              (if or-part_17
                or-part_17
                (something-expensive? (|#%app| rx:conditional-rx2 rx_19))))
            (if (|#%app| rx:group? rx_19)
              (something-expensive? (|#%app| rx:group-rx rx_19))
              (if (|#%app| rx:cut? rx_19)
                (something-expensive? (|#%app| rx:cut-rx rx_19))
                (if (|#%app| rx:lookahead? rx_19)
                  (something-expensive? (|#%app| rx:lookahead-rx rx_19))
                  (if (|#%app| rx:lookbehind? rx_19)
                    (something-expensive? (|#%app| rx:lookbehind-rx rx_19))
                    #f))))))))))
(define must-string
  (lambda (rx_21)
    (if (bytes? rx_21)
      rx_21
      (if (integer? rx_21)
        (bytes rx_21)
        (if (|#%app| rx:sequence? rx_21)
          (let ((lst_14 (|#%app| rx:sequence-rxs rx_21)))
            (begin
              (if (list? lst_14) (void) (check-list lst_14))
              ((letrec ((for-loop_14
                         (lambda (bstr_2 lst_15)
                           (if (pair? lst_15)
                             (let-values (((rx_22) (unsafe-car lst_15))
                                          ((rest_7) (unsafe-cdr lst_15)))
                               (let ((bstr_3
                                      (let ((bstr_4 bstr_2))
                                        (let ((bstr_5
                                               (let ((bstr1_0
                                                      (must-string rx_22)))
                                                 (if (not bstr_4)
                                                   bstr1_0
                                                   (if (not bstr1_0)
                                                     bstr_4
                                                     (if (>
                                                          (bytes-length bstr_4)
                                                          (bytes-length
                                                           bstr1_0))
                                                       bstr_4
                                                       bstr1_0))))))
                                          (values bstr_5)))))
                                 (if (not #f)
                                   (for-loop_14 bstr_3 rest_7)
                                   bstr_3)))
                             bstr_2))))
                 for-loop_14)
               #f
               lst_14)))
          (if (|#%app| rx:repeat? rx_21)
            (if (positive? (|#%app| rx:repeat-min rx_21))
              (must-string (|#%app| rx:repeat-rx rx_21))
              #f)
            (if (|#%app| rx:group? rx_21)
              (must-string (|#%app| rx:group-rx rx_21))
              (if (|#%app| rx:cut? rx_21)
                (must-string (|#%app| rx:cut-rx rx_21))
                (if (|#%app| rx:lookahead? rx_21)
                  (if (|#%app| rx:lookahead-match? rx_21)
                    (must-string (|#%app| rx:lookahead-rx rx_21))
                    #f)
                  (if (|#%app| rx:lookbehind? rx_21)
                    (if (|#%app| rx:lookbehind-match? rx_21)
                      (must-string (|#%app| rx:lookbehind-rx rx_21))
                      #f)
                    #f))))))))))
(define must-range
  (lambda (rx_23)
    (if (bytes? rx_23)
      (bytes->list rx_23)
      (if (integer? rx_23)
        (list rx_23)
        (if (|#%app| rx:range? rx_23)
          (list (|#%app| rx:range-range rx_23))
          (if (|#%app| rx:sequence? rx_23)
            ((letrec ((loop_11
                       (lambda (seq_1 l_15)
                         (if (null? l_15)
                           (if (pair? seq_1) (1/reverse seq_1) #f)
                           (if (bytes? (car l_15))
                             (loop_11
                              (append
                               (1/reverse (bytes->list (car l_15)))
                               seq_1)
                              (cdr l_15))
                             (if (|#%app| rx:range? (car l_15))
                               (loop_11
                                (cons
                                 (|#%app| rx:range-range (car l_15))
                                 seq_1)
                                (cdr l_15))
                               (if (null? seq_1)
                                 (loop_11 null (cdr l_15))
                                 (let ((rest-seq_0 (loop_11 null (cdr l_15))))
                                   (if (if rest-seq_0
                                         (> (length rest-seq_0) (length seq_1))
                                         #f)
                                     rest-seq_0
                                     (1/reverse seq_1))))))))))
               loop_11)
             null
             (|#%app| rx:sequence-rxs rx_23))
            (if (|#%app| rx:repeat? rx_23)
              (if (positive? (|#%app| rx:repeat-min rx_23))
                (must-range (|#%app| rx:repeat-rx rx_23))
                #f)
              (if (|#%app| rx:group? rx_23)
                (must-range (|#%app| rx:group-rx rx_23))
                (if (|#%app| rx:cut? rx_23)
                  (must-range (|#%app| rx:cut-rx rx_23))
                  (if (|#%app| rx:lookahead? rx_23)
                    (if (|#%app| rx:lookahead-match? rx_23)
                      (must-range (|#%app| rx:lookahead-rx rx_23))
                      #f)
                    (if (|#%app| rx:lookbehind? rx_23)
                      (if (|#%app| rx:lookbehind-match? rx_23)
                        (must-range (|#%app| rx:lookbehind-rx rx_23))
                        #f)
                      #f)))))))))))
(define compile-range-sequence
  (lambda (seq_2)
    (let ((lst_16 seq_2))
      (begin
        (if (list? lst_16) (void) (check-list lst_16))
        ((letrec ((for-loop_15
                   (lambda (lst_17)
                     (if (pair? lst_17)
                       (let-values (((r_10) (unsafe-car lst_17))
                                    ((rest_8) (unsafe-cdr lst_17)))
                         (let ((post-guard-var_4 (lambda () #t)))
                           (let ((elem_4
                                  (if (exact-integer? r_10)
                                    (compile-range
                                     (range-add empty-range r_10))
                                    (compile-range r_10))))
                             (let ((result_11
                                    (if (post-guard-var_4)
                                      (for-loop_15 rest_8)
                                      null)))
                               (cons elem_4 result_11)))))
                       null))))
           for-loop_15)
         lst_16)))))
(define get-start-range
  (lambda (rx_15)
    (let ((r_11 (start-range rx_15))) (if r_11 (compile-range r_11) #f))))
(define start-range
  (lambda (rx_24)
    (if (integer? rx_24)
      (range-add empty-range rx_24)
      (if (bytes? rx_24)
        (range-add empty-range (bytes-ref rx_24 0))
        (if (|#%app| rx:sequence? rx_24)
          ((letrec ((loop_1
                     (lambda (l_4)
                       (if (null? l_4)
                         #f
                         (let ((rx_25 (car l_4)))
                           (if (zero-sized? rx_25)
                             (loop_1 (cdr l_4))
                             (start-range rx_25)))))))
             loop_1)
           (|#%app| rx:sequence-rxs rx_24))
          (if (|#%app| rx:alts? rx_24)
            (union
             (start-range (|#%app| rx:alts-rx1 rx_24))
             (start-range (|#%app| rx:alts-rx2 rx_24)))
            (if (|#%app| rx:conditional? rx_24)
              (union
               (start-range (|#%app| rx:conditional-rx1 rx_24))
               (start-range (|#%app| rx:conditional-rx2 rx_24)))
              (if (|#%app| rx:group? rx_24)
                (start-range (|#%app| rx:group-rx rx_24))
                (if (|#%app| rx:cut? rx_24)
                  (start-range (|#%app| rx:cut-rx rx_24))
                  (if (|#%app| rx:repeat? rx_24)
                    (if (positive? (|#%app| rx:repeat-min rx_24))
                      (start-range (|#%app| rx:repeat-rx rx_24))
                      #f)
                    (if (|#%app| rx:range? rx_24)
                      (|#%app| rx:range-range rx_24)
                      #f)))))))))))
(define zero-sized?
  (lambda (rx_3)
    (let ((or-part_22 (eq? rx_3 rx:empty)))
      (if or-part_22
        or-part_22
        (let ((or-part_23 (eq? rx_3 rx:start)))
          (if or-part_23
            or-part_23
            (let ((or-part_24 (eq? rx_3 rx:line-start)))
              (if or-part_24
                or-part_24
                (let ((or-part_25 (eq? rx_3 rx:word-boundary)))
                  (if or-part_25
                    or-part_25
                    (let ((or-part_14 (eq? rx_3 rx:not-word-boundary)))
                      (if or-part_14
                        or-part_14
                        (let ((or-part_15 (|#%app| rx:lookahead? rx_3)))
                          (if or-part_15
                            or-part_15
                            (let ((or-part_26 (|#%app| rx:lookbehind? rx_3)))
                              (if or-part_26
                                or-part_26
                                (let ((or-part_16
                                       (if (|#%app| rx:group? rx_3)
                                         (zero-sized?
                                          (|#%app| rx:group-rx rx_3))
                                         #f)))
                                  (if or-part_16
                                    or-part_16
                                    (if (|#%app| rx:cut? rx_3)
                                      (zero-sized? (|#%app| rx:cut-rx rx_3))
                                      #f)))))))))))))))))))
(define union (lambda (a_4 b_2) (if a_4 (if b_2 (range-union a_4 b_2) #f) #f)))
(define-values
 (struct:lazy-bytes
  lazy-bytes1.1
  lazy-bytes?
  lazy-bytes-bstr
  lazy-bytes-end
  lazy-bytes-in
  lazy-bytes-skip-amt
  lazy-bytes-prefix-len
  lazy-bytes-peek?
  lazy-bytes-immediate-only?
  lazy-bytes-progress-evt
  lazy-bytes-out
  lazy-bytes-max-lookbehind
  lazy-bytes-failed?
  lazy-bytes-discarded-count
  set-lazy-bytes-bstr!
  set-lazy-bytes-end!
  set-lazy-bytes-failed?!
  set-lazy-bytes-discarded-count!)
 (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
               (make-struct-type
                'lazy-bytes
                #f
                12
                0
                #f
                null
                (current-inspector)
                #f
                '(2 3 4 5 6 7 8 9)
                #f
                'lazy-bytes)))
   (values
    struct:_0
    make-_0
    ?_0
    (make-struct-field-accessor -ref_0 0 'bstr)
    (make-struct-field-accessor -ref_0 1 'end)
    (make-struct-field-accessor -ref_0 2 'in)
    (make-struct-field-accessor -ref_0 3 'skip-amt)
    (make-struct-field-accessor -ref_0 4 'prefix-len)
    (make-struct-field-accessor -ref_0 5 'peek?)
    (make-struct-field-accessor -ref_0 6 'immediate-only?)
    (make-struct-field-accessor -ref_0 7 'progress-evt)
    (make-struct-field-accessor -ref_0 8 'out)
    (make-struct-field-accessor -ref_0 9 'max-lookbehind)
    (make-struct-field-accessor -ref_0 10 'failed?)
    (make-struct-field-accessor -ref_0 11 'discarded-count)
    (make-struct-field-mutator -set!_0 0 'bstr)
    (make-struct-field-mutator -set!_0 1 'end)
    (make-struct-field-mutator -set!_0 10 'failed?)
    (make-struct-field-mutator -set!_0 11 'discarded-count))))
(define make-lazy-bytes
  (lambda (in_0
           skip-amt_0
           prefix_0
           peek?_0
           immediate-only?_0
           progress-evt_0
           out_0
           max-lookbehind_1)
    (let ((len_3 (bytes-length prefix_0)))
      (|#%app|
       lazy-bytes1.1
       prefix_0
       len_3
       in_0
       skip-amt_0
       len_3
       peek?_0
       immediate-only?_0
       progress-evt_0
       out_0
       max-lookbehind_1
       #f
       0))))
(define lazy-bytes-before-end?
  (lambda (s_54 pos_54 end_5)
    (if (let ((or-part_27 (not (exact-integer? end_5))))
          (if or-part_27 or-part_27 (< pos_54 end_5)))
      (if (< pos_54 (|#%app| lazy-bytes-end s_54))
        #t
        (if (get-more-bytes! s_54)
          (lazy-bytes-before-end? s_54 pos_54 end_5)
          #f))
      #f)))
(define lazy-bytes-ref
  (lambda (s_55 pos_55)
    (bytes-ref
     (|#%app| lazy-bytes-bstr s_55)
     (- pos_55 (|#%app| lazy-bytes-discarded-count s_55)))))
(define lazy-bytes-advance!
  (lambda (s_56 pos_56 force?_0)
    (begin
      (if force?_0 (lazy-bytes-before-end? s_56 pos_56 'eof) (void))
      (if (if (|#%app| lazy-bytes? s_56)
            (not (|#%app| lazy-bytes-peek? s_56))
            #f)
        (let ((discarded-count_0 (|#%app| lazy-bytes-discarded-count s_56)))
          (let ((unneeded_0
                 (-
                  pos_56
                  discarded-count_0
                  (|#%app| lazy-bytes-max-lookbehind s_56))))
            (if (let ((or-part_28 force?_0))
                  (if or-part_28 or-part_28 (> unneeded_0 4096)))
              (let ((amt_0
                     (if force?_0
                       (- pos_56 (|#%app| lazy-bytes-discarded-count s_56))
                       4096)))
                (let ((bstr_6 (|#%app| lazy-bytes-bstr s_56)))
                  (let ((out_1 (|#%app| lazy-bytes-out s_56)))
                    (begin
                      (if out_1
                        (let ((prefix-len_0
                               (|#%app| lazy-bytes-prefix-len s_56)))
                          (write-bytes
                           bstr_6
                           out_1
                           (if (> discarded-count_0 prefix-len_0)
                             0
                             (min amt_0 (- prefix-len_0 discarded-count_0)))
                           amt_0))
                        (void))
                      (bytes-copy!
                       bstr_6
                       0
                       bstr_6
                       amt_0
                       (- (|#%app| lazy-bytes-end s_56) discarded-count_0))
                      (|#%app|
                       set-lazy-bytes-discarded-count!
                       s_56
                       (+ amt_0 discarded-count_0))))))
              (void))))
        (void)))))
(define get-more-bytes!
  (lambda (s_57)
    (if (|#%app| lazy-bytes? s_57)
      (let ((discarded-count_1 (|#%app| lazy-bytes-discarded-count s_57)))
        (let ((len_4 (- (|#%app| lazy-bytes-end s_57) discarded-count_1)))
          (let ((bstr_7 (|#%app| lazy-bytes-bstr s_57)))
            (if (|#%app| lazy-bytes-failed? s_57)
              #f
              (if (< len_4 (bytes-length bstr_7))
                (let ((n_8
                       (|#%app|
                        (if (|#%app| lazy-bytes-immediate-only? s_57)
                          peek-bytes-avail!*
                          peek-bytes-avail!)
                        bstr_7
                        (+
                         (- len_4 (|#%app| lazy-bytes-prefix-len s_57))
                         (|#%app| lazy-bytes-skip-amt s_57)
                         discarded-count_1)
                        (|#%app| lazy-bytes-progress-evt s_57)
                        (|#%app| lazy-bytes-in s_57)
                        len_4)))
                  (if (eof-object? n_8)
                    #f
                    (if (zero? n_8)
                      (begin (|#%app| set-lazy-bytes-failed?! s_57 #t) #f)
                      (begin
                        (|#%app|
                         set-lazy-bytes-end!
                         s_57
                         (+ n_8 len_4 discarded-count_1))
                        #t))))
                (let ((bstr2_0
                       (make-bytes (max 32 (* 2 (bytes-length bstr_7))))))
                  (begin
                    (bytes-copy! bstr2_0 0 bstr_7 0 len_4)
                    (|#%app| set-lazy-bytes-bstr! s_57 bstr2_0)
                    (get-more-bytes! s_57))))))))
      #f)))
(define bytes->char/utf-8
  (lambda (last-b_0 accum_3)
    (if (< last-b_0 128)
      (if (null? accum_3) (integer->char last-b_0) 'fail)
      (if (continue-byte? last-b_0)
        (if (null? accum_3)
          'fail
          (if (two-byte-prefix? (car accum_3))
            (integer->char
             (+
              (arithmetic-shift (bitwise-and 31 (car accum_3)) 6)
              (continue-value last-b_0)))
            (if (three-byte-prefix? (car accum_3))
              'continue
              (if (four-byte-prefix? (car accum_3))
                'continue
                (if (if (pair? (cdr accum_3))
                      (three-byte-prefix? (cadr accum_3))
                      #f)
                  (integer->char
                   (+
                    (arithmetic-shift (bitwise-and 15 (cadr accum_3)) 12)
                    (arithmetic-shift (continue-value (car accum_3)) 6)
                    (continue-value last-b_0)))
                  (if (if (pair? (cdr accum_3))
                        (four-byte-prefix? (cadr accum_3))
                        #f)
                    'continue
                    (if (if (pair? (cdr accum_3))
                          (if (pair? (cddr accum_3))
                            (four-byte-prefix? (caddr accum_3))
                            #f)
                          #f)
                      (integer->char
                       (+
                        (arithmetic-shift (bitwise-and 15 (caddr accum_3)) 18)
                        (arithmetic-shift (continue-value (cadr accum_3)) 12)
                        (arithmetic-shift (continue-value (car accum_3)) 6)
                        (continue-value last-b_0)))
                      'fail)))))))
        (if (if (let ((or-part_29 (two-byte-prefix? last-b_0)))
                  (if or-part_29
                    or-part_29
                    (let ((or-part_30 (three-byte-prefix? last-b_0)))
                      (if or-part_30
                        or-part_30
                        (four-byte-prefix? last-b_0)))))
              (null? accum_3)
              #f)
          'continue
          'fail)))))
(define continue-byte? (lambda (b_3) (= (bitwise-and b_3 192) 128)))
(define continue-value (lambda (b_4) (bitwise-and b_4 63)))
(define two-byte-prefix? (lambda (b_5) (= (bitwise-and b_5 224) 192)))
(define three-byte-prefix? (lambda (b_6) (= (bitwise-and b_6 240) 224)))
(define four-byte-prefix? (lambda (b_7) (= (bitwise-and b_7 248) 240)))
(define done-m
  (lambda (s_58 pos_57 start_8 limit_0 end_6 state_0 stack_0) pos_57))
(define continue-m
  (lambda (s_59 pos_58 start_9 limit_1 end_7 state_1 stack_1)
    (|#%app| (car stack_1) pos_58)))
(define limit-m
  (lambda (s_60 pos_59 start_10 limit_2 end_8 state_2 stack_2)
    (= pos_59 limit_2)))
(define byte-matcher
  (lambda (b_8 next-m_0)
    (lambda (s_61 pos_60 start_11 limit_3 end_9 state_3 stack_3)
      (if (if (bytes? s_61)
            (if (< pos_60 limit_3) (= b_8 (bytes-ref s_61 pos_60)) #f)
            (if (lazy-bytes-before-end? s_61 pos_60 limit_3)
              (= b_8 (lazy-bytes-ref s_61 pos_60))
              #f))
        (|#%app|
         next-m_0
         s_61
         (add1 pos_60)
         start_11
         limit_3
         end_9
         state_3
         stack_3)
        #f))))
(define byte-tail-matcher
  (lambda (b_9)
    (lambda (s_62 pos_61 start_12 limit_4 end_10 state_4 stack_4)
      (if (if (bytes? s_62)
            (if (< pos_61 limit_4) (= b_9 (bytes-ref s_62 pos_61)) #f)
            (if (lazy-bytes-before-end? s_62 pos_61 limit_4)
              (= b_9 (lazy-bytes-ref s_62 pos_61))
              #f))
        (add1 pos_61)
        #f))))
(define byte-matcher*
  (lambda (b_10 max_0)
    (lambda (s_39 pos_62 start_13 limit_5 end_11 state_5)
      (if (bytes? s_39)
        (let ((limit_6
               (if max_0 (min limit_5 (+ pos_62 (* 1 max_0))) limit_5)))
          ((letrec ((loop_12
                     (lambda (pos_63 n_9)
                       (let ((pos3_17 (+ pos_63 1)))
                         (if (let ((or-part_31 (> pos3_17 limit_6)))
                               (if or-part_31
                                 or-part_31
                                 (not (= b_10 (bytes-ref s_39 pos_63)))))
                           (values pos_63 n_9 1)
                           (loop_12 pos3_17 (add1 n_9)))))))
             loop_12)
           pos_62
           0))
        (let ((limit_7 (if max_0 (+ pos_62 (* 1 max_0)) #f)))
          ((letrec ((loop_13
                     (lambda (pos_64 n_10)
                       (if (let ((or-part_32
                                  (if limit_7 (> (+ pos_64 1) limit_7) #f)))
                             (if or-part_32
                               or-part_32
                               (let ((or-part_33
                                      (not
                                       (lazy-bytes-before-end?
                                        s_39
                                        (+ pos_64 (sub1 1))
                                        limit_7))))
                                 (if or-part_33
                                   or-part_33
                                   (not
                                    (= b_10 (lazy-bytes-ref s_39 pos_64)))))))
                         (values pos_64 n_10 1)
                         (loop_13 (+ pos_64 1) (add1 n_10))))))
             loop_13)
           pos_62
           0))))))
(define bytes-matcher
  (lambda (bstr_8 len_5 next-m_1)
    (lambda (s_42 pos_65 start_14 limit_8 end_12 state_6 stack_5)
      (if (if (bytes? s_42)
            (if (<= (+ pos_65 len_5) limit_8)
              (let-values (((v*_1 start*_1 stop*_2 step*_1)
                            (normalise-inputs
                             'in-bytes
                             "bytes"
                             (lambda (x_5) (bytes? x_5))
                             (lambda (x_6) (unsafe-bytes-length x_6))
                             bstr_8
                             0
                             len_5
                             1))
                           ((v*_2 start*_2 stop*_3 step*_2)
                            (normalise-inputs
                             'in-bytes
                             "bytes"
                             (lambda (x_7) (bytes? x_7))
                             (lambda (x_8) (unsafe-bytes-length x_8))
                             s_42
                             pos_65
                             (+ pos_65 len_5)
                             1)))
                (begin
                  #t
                  #t
                  ((letrec ((for-loop_16
                             (lambda (result_12 idx_1 idx_2)
                               (if (if (unsafe-fx< idx_1 stop*_2)
                                     (unsafe-fx< idx_2 stop*_3)
                                     #f)
                                 (let-values (((c1_1)
                                               (unsafe-bytes-ref v*_1 idx_1))
                                              ((c2_1)
                                               (unsafe-bytes-ref v*_2 idx_2)))
                                   (let ((result_13
                                          (let ((result_14 (= c1_1 c2_1)))
                                            (values result_14))))
                                     (if (if (not
                                              ((lambda x_9 (not result_13))
                                               c1_1))
                                           (if (not
                                                ((lambda x_10 (not result_13))
                                                 c2_1))
                                             (not #f)
                                             #f)
                                           #f)
                                       (for-loop_16
                                        result_13
                                        (unsafe-fx+ idx_1 1)
                                        (unsafe-fx+ idx_2 1))
                                       result_13)))
                                 result_12))))
                     for-loop_16)
                   #t
                   start*_1
                   start*_2)))
              #f)
            (if (lazy-bytes-before-end? s_42 (sub1 (+ pos_65 len_5)) limit_8)
              (let-values (((v*_3 start*_3 stop*_4 step*_3)
                            (normalise-inputs
                             'in-bytes
                             "bytes"
                             (lambda (x_11) (bytes? x_11))
                             (lambda (x_12) (unsafe-bytes-length x_12))
                             bstr_8
                             0
                             len_5
                             1))
                           ((start_15) pos_65))
                (begin
                  #t
                  (if (exact-nonnegative-integer? start_15)
                    (void)
                    (check-naturals start_15))
                  ((letrec ((for-loop_17
                             (lambda (result_15 idx_3 pos_49)
                               (if (if (unsafe-fx< idx_3 stop*_4) #t #f)
                                 (let-values (((c1_2)
                                               (unsafe-bytes-ref v*_3 idx_3))
                                              ((i_8) pos_49))
                                   (let ((result_16
                                          (let ((result_17
                                                 (let ((c2_2
                                                        (lazy-bytes-ref
                                                         s_42
                                                         i_8)))
                                                   (= c1_2 c2_2))))
                                            (values result_17))))
                                     (if (if (not
                                              ((lambda x_13 (not result_16))
                                               c1_2))
                                           (if (not
                                                ((lambda x_14 (not result_16))
                                                 i_8))
                                             (not #f)
                                             #f)
                                           #f)
                                       (for-loop_17
                                        result_16
                                        (unsafe-fx+ idx_3 1)
                                        (+ pos_49 1))
                                       result_16)))
                                 result_15))))
                     for-loop_17)
                   #t
                   start*_3
                   start_15)))
              #f))
        (|#%app|
         next-m_1
         s_42
         (+ pos_65 len_5)
         start_14
         limit_8
         end_12
         state_6
         stack_5)
        #f))))
(define bytes-tail-matcher
  (lambda (bstr_9 len_6)
    (lambda (s_63 pos_66 start_16 limit_9 end_13 state_7 stack_6)
      (if (if (bytes? s_63)
            (if (<= (+ pos_66 len_6) limit_9)
              (let-values (((v*_4 start*_4 stop*_5 step*_4)
                            (normalise-inputs
                             'in-bytes
                             "bytes"
                             (lambda (x_15) (bytes? x_15))
                             (lambda (x_16) (unsafe-bytes-length x_16))
                             bstr_9
                             0
                             len_6
                             1))
                           ((v*_5 start*_5 stop*_6 step*_5)
                            (normalise-inputs
                             'in-bytes
                             "bytes"
                             (lambda (x_17) (bytes? x_17))
                             (lambda (x_18) (unsafe-bytes-length x_18))
                             s_63
                             pos_66
                             (+ pos_66 len_6)
                             1)))
                (begin
                  #t
                  #t
                  ((letrec ((for-loop_18
                             (lambda (result_18 idx_4 idx_5)
                               (if (if (unsafe-fx< idx_4 stop*_5)
                                     (unsafe-fx< idx_5 stop*_6)
                                     #f)
                                 (let-values (((c1_3)
                                               (unsafe-bytes-ref v*_4 idx_4))
                                              ((c2_3)
                                               (unsafe-bytes-ref v*_5 idx_5)))
                                   (let ((result_19
                                          (let ((result_20 (= c1_3 c2_3)))
                                            (values result_20))))
                                     (if (if (not
                                              ((lambda x_19 (not result_19))
                                               c1_3))
                                           (if (not
                                                ((lambda x_20 (not result_19))
                                                 c2_3))
                                             (not #f)
                                             #f)
                                           #f)
                                       (for-loop_18
                                        result_19
                                        (unsafe-fx+ idx_4 1)
                                        (unsafe-fx+ idx_5 1))
                                       result_19)))
                                 result_18))))
                     for-loop_18)
                   #t
                   start*_4
                   start*_5)))
              #f)
            (if (lazy-bytes-before-end? s_63 (sub1 (+ pos_66 len_6)) limit_9)
              (let-values (((v*_6 start*_6 stop*_7 step*_6)
                            (normalise-inputs
                             'in-bytes
                             "bytes"
                             (lambda (x_21) (bytes? x_21))
                             (lambda (x_22) (unsafe-bytes-length x_22))
                             bstr_9
                             0
                             len_6
                             1))
                           ((start_17) pos_66))
                (begin
                  #t
                  (if (exact-nonnegative-integer? start_17)
                    (void)
                    (check-naturals start_17))
                  ((letrec ((for-loop_19
                             (lambda (result_21 idx_6 pos_67)
                               (if (if (unsafe-fx< idx_6 stop*_7) #t #f)
                                 (let-values (((c1_4)
                                               (unsafe-bytes-ref v*_6 idx_6))
                                              ((i_9) pos_67))
                                   (let ((result_22
                                          (let ((result_23
                                                 (let ((c2_4
                                                        (lazy-bytes-ref
                                                         s_63
                                                         i_9)))
                                                   (= c1_4 c2_4))))
                                            (values result_23))))
                                     (if (if (not
                                              ((lambda x_23 (not result_22))
                                               c1_4))
                                           (if (not
                                                ((lambda x_24 (not result_22))
                                                 i_9))
                                             (not #f)
                                             #f)
                                           #f)
                                       (for-loop_19
                                        result_22
                                        (unsafe-fx+ idx_6 1)
                                        (+ pos_67 1))
                                       result_22)))
                                 result_21))))
                     for-loop_19)
                   #t
                   start*_6
                   start_17)))
              #f))
        (+ pos_66 len_6)
        #f))))
(define bytes-matcher*
  (lambda (bstr_10 max_1)
    (let ((len_7 (bytes-length bstr_10)))
      (lambda (s_64 pos_68 start_18 limit_10 end_14 state_8)
        (if (bytes? s_64)
          (let ((limit_11
                 (if max_1
                   (min limit_10 (+ pos_68 (* len_7 max_1)))
                   limit_10)))
            ((letrec ((loop_14
                       (lambda (pos_69 n_11)
                         (let ((pos3_18 (+ pos_69 len_7)))
                           (if (let ((or-part_34 (> pos3_18 limit_11)))
                                 (if or-part_34
                                   or-part_34
                                   (not
                                    (let-values (((v*_7
                                                   start*_7
                                                   stop*_8
                                                   step*_7)
                                                  (normalise-inputs
                                                   'in-bytes
                                                   "bytes"
                                                   (lambda (x_25)
                                                     (bytes? x_25))
                                                   (lambda (x_26)
                                                     (unsafe-bytes-length
                                                      x_26))
                                                   bstr_10
                                                   0
                                                   len_7
                                                   1))
                                                 ((v*_8
                                                   start*_8
                                                   stop*_9
                                                   step*_8)
                                                  (normalise-inputs
                                                   'in-bytes
                                                   "bytes"
                                                   (lambda (x_27)
                                                     (bytes? x_27))
                                                   (lambda (x_28)
                                                     (unsafe-bytes-length
                                                      x_28))
                                                   s_64
                                                   pos_69
                                                   (+ pos_69 len_7)
                                                   1)))
                                      (begin
                                        #t
                                        #t
                                        ((letrec ((for-loop_20
                                                   (lambda (result_24
                                                            idx_7
                                                            idx_8)
                                                     (if (if (unsafe-fx<
                                                              idx_7
                                                              stop*_8)
                                                           (unsafe-fx<
                                                            idx_8
                                                            stop*_9)
                                                           #f)
                                                       (let-values (((c1_5)
                                                                     (unsafe-bytes-ref
                                                                      v*_7
                                                                      idx_7))
                                                                    ((c2_5)
                                                                     (unsafe-bytes-ref
                                                                      v*_8
                                                                      idx_8)))
                                                         (let ((result_25
                                                                (let ((result_26
                                                                       (=
                                                                        c1_5
                                                                        c2_5)))
                                                                  (values
                                                                   result_26))))
                                                           (if (if (not
                                                                    ((lambda x_29
                                                                       (not
                                                                        result_25))
                                                                     c1_5))
                                                                 (if (not
                                                                      ((lambda x_30
                                                                         (not
                                                                          result_25))
                                                                       c2_5))
                                                                   (not #f)
                                                                   #f)
                                                                 #f)
                                                             (for-loop_20
                                                              result_25
                                                              (unsafe-fx+
                                                               idx_7
                                                               1)
                                                              (unsafe-fx+
                                                               idx_8
                                                               1))
                                                             result_25)))
                                                       result_24))))
                                           for-loop_20)
                                         #t
                                         start*_7
                                         start*_8))))))
                             (values pos_69 n_11 len_7)
                             (loop_14 pos3_18 (add1 n_11)))))))
               loop_14)
             pos_68
             0))
          (let ((limit_12 (if max_1 (+ pos_68 (* len_7 max_1)) #f)))
            ((letrec ((loop_15
                       (lambda (pos_70 n_12)
                         (if (let ((or-part_35
                                    (if limit_12
                                      (> (+ pos_70 len_7) limit_12)
                                      #f)))
                               (if or-part_35
                                 or-part_35
                                 (let ((or-part_36
                                        (not
                                         (lazy-bytes-before-end?
                                          s_64
                                          (+ pos_70 (sub1 len_7))
                                          limit_12))))
                                   (if or-part_36
                                     or-part_36
                                     (not
                                      (let-values (((v*_9
                                                     start*_9
                                                     stop*_10
                                                     step*_9)
                                                    (normalise-inputs
                                                     'in-bytes
                                                     "bytes"
                                                     (lambda (x_31)
                                                       (bytes? x_31))
                                                     (lambda (x_32)
                                                       (unsafe-bytes-length
                                                        x_32))
                                                     bstr_10
                                                     0
                                                     len_7
                                                     1))
                                                   ((start_19) pos_70))
                                        (begin
                                          #t
                                          (if (exact-nonnegative-integer?
                                               start_19)
                                            (void)
                                            (check-naturals start_19))
                                          ((letrec ((for-loop_21
                                                     (lambda (result_27
                                                              idx_9
                                                              pos_71)
                                                       (if (if (unsafe-fx<
                                                                idx_9
                                                                stop*_10)
                                                             #t
                                                             #f)
                                                         (let-values (((c1_6)
                                                                       (unsafe-bytes-ref
                                                                        v*_9
                                                                        idx_9))
                                                                      ((i_10)
                                                                       pos_71))
                                                           (let ((result_28
                                                                  (let ((result_29
                                                                         (let ((c2_6
                                                                                (lazy-bytes-ref
                                                                                 s_64
                                                                                 i_10)))
                                                                           (=
                                                                            c1_6
                                                                            c2_6))))
                                                                    (values
                                                                     result_29))))
                                                             (if (if (not
                                                                      ((lambda x_33
                                                                         (not
                                                                          result_28))
                                                                       c1_6))
                                                                   (if (not
                                                                        ((lambda x_34
                                                                           (not
                                                                            result_28))
                                                                         i_10))
                                                                     (not #f)
                                                                     #f)
                                                                   #f)
                                                               (for-loop_21
                                                                result_28
                                                                (unsafe-fx+
                                                                 idx_9
                                                                 1)
                                                                (+ pos_71 1))
                                                               result_28)))
                                                         result_27))))
                                             for-loop_21)
                                           #t
                                           start*_9
                                           start_19))))))))
                           (values pos_70 n_12 len_7)
                           (loop_15 (+ pos_70 len_7) (add1 n_12))))))
               loop_15)
             pos_68
             0)))))))
(define never-matcher
  (lambda ()
    (lambda (s_65 pos_72 start_20 limit_13 end_15 state_9 stack_7) #f)))
(define any-matcher
  (lambda (next-m_2)
    (lambda (s_66 pos_73 start_21 limit_14 end_16 state_10 stack_8)
      (if (if (bytes? s_66)
            (< pos_73 limit_14)
            (lazy-bytes-before-end? s_66 pos_73 limit_14))
        (|#%app|
         next-m_2
         s_66
         (add1 pos_73)
         start_21
         limit_14
         end_16
         state_10
         stack_8)
        #f))))
(define any-tail-matcher
  (lambda ()
    (lambda (s_67 pos_74 start_22 limit_15 end_17 state_11 stack_9)
      (if (if (bytes? s_67)
            (< pos_74 limit_15)
            (lazy-bytes-before-end? s_67 pos_74 limit_15))
        (add1 pos_74)
        #f))))
(define any-matcher*
  (lambda (max-repeat_0)
    (lambda (s_68 pos_75 start_23 limit_16 end_18 state_12)
      (if (bytes? s_68)
        (let ((n_13
               (if max-repeat_0
                 (min max-repeat_0 (- limit_16 pos_75))
                 (- limit_16 pos_75))))
          (values (+ pos_75 n_13) n_13 1))
        ((letrec ((grow-loop_0
                   (lambda (size_0)
                     (let ((n_14
                            (if max-repeat_0
                              (min size_0 max-repeat_0)
                              size_0)))
                       (let ((pos2_15 (+ pos_75 n_14)))
                         (if (if (lazy-bytes-before-end?
                                  s_68
                                  (sub1 pos2_15)
                                  limit_16)
                               (let ((or-part_37 (not max-repeat_0)))
                                 (if or-part_37
                                   or-part_37
                                   (< n_14 max-repeat_0)))
                               #f)
                           (grow-loop_0 (* size_0 2))
                           ((letrec ((search-loop_0
                                      (lambda (min_0 too-high_0)
                                        (let ((mid_0
                                               (quotient
                                                (+ min_0 too-high_0)
                                                2)))
                                          (if (= mid_0 min_0)
                                            (values mid_0 (- mid_0 pos_75) 1)
                                            (if (lazy-bytes-before-end?
                                                 s_68
                                                 (sub1 mid_0)
                                                 limit_16)
                                              (search-loop_0 mid_0 too-high_0)
                                              (search-loop_0 min_0 mid_0)))))))
                              search-loop_0)
                            pos_75
                            (add1 pos2_15))))))))
           grow-loop_0)
         1)))))
(define range-matcher
  (lambda (rng_2 next-m_3)
    (lambda (s_69 pos_76 start_24 limit_17 end_19 state_13 stack_10)
      (if (if (bytes? s_69)
            (if (< pos_76 limit_17) (rng-in? rng_2 (bytes-ref s_69 pos_76)) #f)
            (if (lazy-bytes-before-end? s_69 pos_76 limit_17)
              (rng-in? rng_2 (lazy-bytes-ref s_69 pos_76))
              #f))
        (|#%app|
         next-m_3
         s_69
         (add1 pos_76)
         start_24
         limit_17
         end_19
         state_13
         stack_10)
        #f))))
(define range-tail-matcher
  (lambda (rng_3)
    (lambda (s_70 pos_77 start_25 limit_18 end_20 state_14 stack_11)
      (if (if (bytes? s_70)
            (if (< pos_77 limit_18) (rng-in? rng_3 (bytes-ref s_70 pos_77)) #f)
            (if (lazy-bytes-before-end? s_70 pos_77 limit_18)
              (rng-in? rng_3 (lazy-bytes-ref s_70 pos_77))
              #f))
        (add1 pos_77)
        #f))))
(define range-matcher*
  (lambda (rng_4 max_2)
    (lambda (s_71 pos_78 start_26 limit_19 end_21 state_15)
      (if (bytes? s_71)
        (let ((limit_20
               (if max_2 (min limit_19 (+ pos_78 (* 1 max_2))) limit_19)))
          ((letrec ((loop_16
                     (lambda (pos_79 n_15)
                       (let ((pos3_19 (+ pos_79 1)))
                         (if (let ((or-part_38 (> pos3_19 limit_20)))
                               (if or-part_38
                                 or-part_38
                                 (not
                                  (rng-in? rng_4 (bytes-ref s_71 pos_79)))))
                           (values pos_79 n_15 1)
                           (loop_16 pos3_19 (add1 n_15)))))))
             loop_16)
           pos_78
           0))
        (let ((limit_21 (if max_2 (+ pos_78 (* 1 max_2)) #f)))
          ((letrec ((loop_17
                     (lambda (pos_80 n_16)
                       (if (let ((or-part_39
                                  (if limit_21 (> (+ pos_80 1) limit_21) #f)))
                             (if or-part_39
                               or-part_39
                               (let ((or-part_40
                                      (not
                                       (lazy-bytes-before-end?
                                        s_71
                                        (+ pos_80 (sub1 1))
                                        limit_21))))
                                 (if or-part_40
                                   or-part_40
                                   (not
                                    (rng-in?
                                     rng_4
                                     (lazy-bytes-ref s_71 pos_80)))))))
                         (values pos_80 n_16 1)
                         (loop_17 (+ pos_80 1) (add1 n_16))))))
             loop_17)
           pos_78
           0))))))
(define start-matcher
  (lambda (next-m_4)
    (lambda (s_72 pos_81 start_27 limit_22 end_22 state_16 stack_12)
      (if (= pos_81 start_27)
        (|#%app|
         next-m_4
         s_72
         pos_81
         start_27
         limit_22
         end_22
         state_16
         stack_12)
        #f))))
(define end-matcher
  (lambda (next-m_5)
    (lambda (s_73 pos_82 start_28 limit_23 end_23 state_17 stack_13)
      (if (if (bytes? s_73)
            (= pos_82 end_23)
            (not (lazy-bytes-before-end? s_73 pos_82 end_23)))
        (|#%app|
         next-m_5
         s_73
         pos_82
         start_28
         limit_23
         end_23
         state_17
         stack_13)
        #f))))
(define line-start-matcher
  (lambda (next-m_6)
    (lambda (s_74 pos_83 start_29 limit_24 end_24 state_18 stack_14)
      (if (let ((or-part_41 (= pos_83 start_29)))
            (if or-part_41
              or-part_41
              (=
               (char->integer '#\xa)
               (if (bytes? s_74)
                 (bytes-ref s_74 (sub1 pos_83))
                 (lazy-bytes-ref s_74 (sub1 pos_83))))))
        (|#%app|
         next-m_6
         s_74
         pos_83
         start_29
         limit_24
         end_24
         state_18
         stack_14)
        #f))))
(define line-end-matcher
  (lambda (next-m_7)
    (lambda (s_75 pos_84 start_30 limit_25 end_25 state_19 stack_15)
      (if (if (bytes? s_75)
            (let ((or-part_42 (= pos_84 end_25)))
              (if or-part_42
                or-part_42
                (= (char->integer '#\xa) (bytes-ref s_75 pos_84))))
            (let ((or-part_43
                   (not (lazy-bytes-before-end? s_75 pos_84 end_25))))
              (if or-part_43
                or-part_43
                (= (char->integer '#\xa) (lazy-bytes-ref s_75 pos_84)))))
        (|#%app|
         next-m_7
         s_75
         pos_84
         start_30
         limit_25
         end_25
         state_19
         stack_15)
        #f))))
(define word-boundary-matcher
  (lambda (next-m_8)
    (lambda (s_76 pos_85 start_31 limit_26 end_26 state_20 stack_16)
      (if (word-boundary? s_76 pos_85 start_31 limit_26 end_26)
        (|#%app|
         next-m_8
         s_76
         pos_85
         start_31
         limit_26
         end_26
         state_20
         stack_16)
        #f))))
(define not-word-boundary-matcher
  (lambda (next-m_9)
    (lambda (s_77 pos_86 start_32 limit_27 end_27 state_21 stack_17)
      (if (not (word-boundary? s_77 pos_86 start_32 limit_27 end_27))
        (|#%app|
         next-m_9
         s_77
         pos_86
         start_32
         limit_27
         end_27
         state_21
         stack_17)
        #f))))
(define word-boundary?
  (lambda (s_78 pos_87 start_33 limit_28 end_28)
    (not
     (eq?
      (let ((or-part_44 (= pos_87 start_33)))
        (if or-part_44
          or-part_44
          (not
           (word-byte?
            (if (bytes? s_78)
              (bytes-ref s_78 (sub1 pos_87))
              (lazy-bytes-ref s_78 (sub1 pos_87)))))))
      (let ((or-part_45
             (if (bytes? s_78)
               (= pos_87 end_28)
               (not (lazy-bytes-before-end? s_78 pos_87 end_28)))))
        (if or-part_45
          or-part_45
          (not
           (word-byte?
            (if (bytes? s_78)
              (bytes-ref s_78 pos_87)
              (lazy-bytes-ref s_78 pos_87))))))))))
(define word-byte?
  (lambda (c_10)
    (let ((or-part_46
           (if (>= c_10 (char->integer '#\x30))
             (<= c_10 (char->integer '#\x39))
             #f)))
      (if or-part_46
        or-part_46
        (let ((or-part_47
               (if (>= c_10 (char->integer '#\x61))
                 (<= c_10 (char->integer '#\x7a))
                 #f)))
          (if or-part_47
            or-part_47
            (let ((or-part_48
                   (if (>= c_10 (char->integer '#\x41))
                     (<= c_10 (char->integer '#\x5a))
                     #f)))
              (if or-part_48 or-part_48 (= c_10 (char->integer '#\x5f))))))))))
(define alts-matcher
  (lambda (m1_0 m2_0)
    (lambda (s_79 pos_88 start_34 limit_29 end_29 state_22 stack_18)
      (let ((or-part_49
             (|#%app|
              m1_0
              s_79
              pos_88
              start_34
              limit_29
              end_29
              state_22
              stack_18)))
        (if or-part_49
          or-part_49
          (|#%app|
           m2_0
           s_79
           pos_88
           start_34
           limit_29
           end_29
           state_22
           stack_18))))))
(define repeat-matcher
  (lambda (r-m_0 min_1 max_3 next-m_10)
    (lambda (s_80 pos_89 start_35 limit_30 end_30 state_23 stack_19)
      ((letrec ((rloop_0
                 (lambda (pos_90 n_17)
                   (if (< n_17 min_1)
                     (let ((new-stack_0
                            (cons
                             (lambda (pos_91) (rloop_0 pos_91 (add1 n_17)))
                             stack_19)))
                       (|#%app|
                        r-m_0
                        s_80
                        pos_90
                        start_35
                        limit_30
                        end_30
                        state_23
                        new-stack_0))
                     (if (if max_3 (= n_17 max_3) #f)
                       (|#%app|
                        next-m_10
                        s_80
                        pos_90
                        start_35
                        limit_30
                        end_30
                        state_23
                        stack_19)
                       (let ((new-stack_1
                              (cons
                               (lambda (pos_92) (rloop_0 pos_92 (add1 n_17)))
                               stack_19)))
                         (let ((or-part_50
                                (|#%app|
                                 r-m_0
                                 s_80
                                 pos_90
                                 start_35
                                 limit_30
                                 end_30
                                 state_23
                                 new-stack_1)))
                           (if or-part_50
                             or-part_50
                             (|#%app|
                              next-m_10
                              s_80
                              pos_90
                              start_35
                              limit_30
                              end_30
                              state_23
                              stack_19)))))))))
         rloop_0)
       pos_89
       0))))
(define r-stack (list (lambda (pos_93) pos_93)))
(define repeat-simple-matcher
  (lambda (r-m_1 min_2 max_4 group-n_0 next-m_11)
    (lambda (s_81 pos_94 start_36 limit_31 end_31 state_24 stack_20)
      ((letrec ((rloop_1
                 (lambda (pos_95 n_18 back-amt_0)
                   (let ((pos2_16
                          (if (let ((or-part_51 (not max_4)))
                                (if or-part_51 or-part_51 (< n_18 max_4)))
                            (|#%app|
                             r-m_1
                             s_81
                             pos_95
                             start_36
                             limit_31
                             end_31
                             state_24
                             r-stack)
                            #f)))
                     (if pos2_16
                       (rloop_1 pos2_16 (add1 n_18) (- pos2_16 pos_95))
                       ((letrec ((bloop_0
                                  (lambda (pos_96 n_19)
                                    (if (< n_19 min_2)
                                      #f
                                      (let-values (((group-n_1) group-n_0)
                                                   ((state_25) state_24)
                                                   ((n_20) n_19)
                                                   ((pos_97) pos_96))
                                        (if (if group-n_1 state_25 #f)
                                          (let ((old-span_0
                                                 (vector-ref
                                                  state_25
                                                  group-n_1)))
                                            (let-values ((()
                                                          (begin
                                                            (vector-set!
                                                             state_25
                                                             group-n_1
                                                             (if (zero? n_20)
                                                               #f
                                                               (cons
                                                                (-
                                                                 pos_97
                                                                 back-amt_0)
                                                                pos_97)))
                                                            (values))))
                                              (let ((group-revert_0
                                                     (lambda ()
                                                       (vector-set!
                                                        state_25
                                                        group-n_1
                                                        old-span_0))))
                                                (let ((or-part_52
                                                       (|#%app|
                                                        next-m_11
                                                        s_81
                                                        pos_96
                                                        start_36
                                                        limit_31
                                                        end_31
                                                        state_24
                                                        stack_20)))
                                                  (if or-part_52
                                                    or-part_52
                                                    (begin
                                                      (group-revert_0)
                                                      (bloop_0
                                                       (- pos_96 back-amt_0)
                                                       (sub1 n_19))))))))
                                          (let ((group-revert_1
                                                 (lambda () (void))))
                                            (let ((or-part_53
                                                   (|#%app|
                                                    next-m_11
                                                    s_81
                                                    pos_96
                                                    start_36
                                                    limit_31
                                                    end_31
                                                    state_24
                                                    stack_20)))
                                              (if or-part_53
                                                or-part_53
                                                (begin
                                                  (group-revert_1)
                                                  (bloop_0
                                                   (- pos_96 back-amt_0)
                                                   (sub1 n_19))))))))))))
                          bloop_0)
                        pos_95
                        n_18))))))
         rloop_1)
       pos_94
       0
       0))))
(define repeat-simple-many-matcher
  (lambda (r-m*_0 min_3 max_5 group-n_2 next-m_12)
    (lambda (s_82 pos_98 start_37 limit_32 end_32 state_26 stack_21)
      (let-values (((pos2_17 n_21 back-amt_1)
                    (|#%app|
                     r-m*_0
                     s_82
                     pos_98
                     start_37
                     limit_32
                     end_32
                     state_26)))
        ((letrec ((bloop_1
                   (lambda (pos_99 n_22)
                     (if (< n_22 min_3)
                       #f
                       (let-values (((group-n_3) group-n_2)
                                    ((state_27) state_26)
                                    ((n_23) n_22)
                                    ((pos_100) pos_99))
                         (if (if group-n_3 state_27 #f)
                           (let ((old-span_1 (vector-ref state_27 group-n_3)))
                             (let-values ((()
                                           (begin
                                             (vector-set!
                                              state_27
                                              group-n_3
                                              (if (zero? n_23)
                                                #f
                                                (cons
                                                 (- pos_100 back-amt_1)
                                                 pos_100)))
                                             (values))))
                               (let ((group-revert_2
                                      (lambda ()
                                        (vector-set!
                                         state_27
                                         group-n_3
                                         old-span_1))))
                                 (let ((or-part_54
                                        (|#%app|
                                         next-m_12
                                         s_82
                                         pos_99
                                         start_37
                                         limit_32
                                         end_32
                                         state_26
                                         stack_21)))
                                   (if or-part_54
                                     or-part_54
                                     (begin
                                       (group-revert_2)
                                       (bloop_1
                                        (- pos_99 back-amt_1)
                                        (sub1 n_22))))))))
                           (let ((group-revert_3 (lambda () (void))))
                             (let ((or-part_55
                                    (|#%app|
                                     next-m_12
                                     s_82
                                     pos_99
                                     start_37
                                     limit_32
                                     end_32
                                     state_26
                                     stack_21)))
                               (if or-part_55
                                 or-part_55
                                 (begin
                                   (group-revert_3)
                                   (bloop_1
                                    (- pos_99 back-amt_1)
                                    (sub1 n_22))))))))))))
           bloop_1)
         pos2_17
         n_21)))))
(define lazy-repeat-matcher
  (lambda (r-m_2 min_4 max_6 next-m_13)
    (lambda (s_83 pos_101 start_38 limit_33 end_33 state_28 stack_22)
      ((letrec ((rloop_2
                 (lambda (pos_102 n_24 min_5)
                   (if (< n_24 min_5)
                     (let ((new-stack_2
                            (cons
                             (lambda (pos_103)
                               (rloop_2 pos_103 (add1 n_24) min_5))
                             stack_22)))
                       (|#%app|
                        r-m_2
                        s_83
                        pos_102
                        start_38
                        limit_33
                        end_33
                        state_28
                        new-stack_2))
                     (if (if max_6 (= n_24 max_6) #f)
                       (|#%app|
                        next-m_13
                        s_83
                        pos_102
                        start_38
                        limit_33
                        end_33
                        state_28
                        stack_22)
                       (let ((or-part_56
                              (|#%app|
                               next-m_13
                               s_83
                               pos_102
                               start_38
                               limit_33
                               end_33
                               state_28
                               stack_22)))
                         (if or-part_56
                           or-part_56
                           (rloop_2 pos_102 n_24 (add1 min_5)))))))))
         rloop_2)
       pos_101
       0
       min_4))))
(define lazy-repeat-simple-matcher
  (lambda (r-m_3 min_6 max_7 next-m_14)
    (lambda (s_84 pos_104 start_39 limit_34 end_34 state_29 stack_23)
      ((letrec ((rloop_3
                 (lambda (pos_105 n_25 min_7)
                   (if (< n_25 min_7)
                     (let ((pos2_18
                            (|#%app|
                             r-m_3
                             s_84
                             pos_105
                             start_39
                             limit_34
                             end_34
                             state_29
                             stack_23)))
                       (if pos2_18 (rloop_3 pos2_18 (add1 n_25) min_7) #f))
                     (if (if max_7 (= n_25 max_7) #f)
                       (|#%app|
                        next-m_14
                        s_84
                        pos_105
                        start_39
                        limit_34
                        end_34
                        state_29
                        stack_23)
                       (let ((or-part_57
                              (|#%app|
                               next-m_14
                               s_84
                               pos_105
                               start_39
                               limit_34
                               end_34
                               state_29
                               stack_23)))
                         (if or-part_57
                           or-part_57
                           (rloop_3 pos_105 n_25 (add1 min_7)))))))))
         rloop_3)
       pos_104
       0
       min_6))))
(define group-push-matcher
  (lambda (n_26 next-m_15)
    (lambda (s_85 pos_106 start_40 limit_35 end_35 state_30 stack_24)
      (let ((new-stack_3
             (cons
              (cons pos_106 (if state_30 (vector-ref state_30 n_26) #f))
              stack_24)))
        (|#%app|
         next-m_15
         s_85
         pos_106
         start_40
         limit_35
         end_35
         state_30
         new-stack_3)))))
(define group-set-matcher
  (lambda (n_27 next-m_16)
    (lambda (s_86 pos_107 start_41 limit_36 end_36 state_31 stack_25)
      (let ((old-pos+span_0 (car stack_25)))
        (let ((old-span_2 (cdr old-pos+span_0)))
          (begin
            (if state_31
              (vector-set! state_31 n_27 (cons (car old-pos+span_0) pos_107))
              (void))
            (let ((or-part_58
                   (|#%app|
                    next-m_16
                    s_86
                    pos_107
                    start_41
                    limit_36
                    end_36
                    state_31
                    (cdr stack_25))))
              (if or-part_58
                or-part_58
                (begin
                  (if state_31 (vector-set! state_31 n_27 old-span_2) (void))
                  #f)))))))))
(define reference-matcher
  (lambda (n_28 next-m_17)
    (lambda (s_87 pos_108 start_42 limit_37 end_37 state_32 stack_26)
      (let ((p_4 (vector-ref state_32 n_28)))
        (if (not p_4)
          #f
          (let ((len_8 (- (cdr p_4) (car p_4))))
            (let ((matches?_0
                   (if (bytes? s_87)
                     (if (<= (+ pos_108 len_8) limit_37)
                       (let-values (((v*_10 start*_10 stop*_11 step*_10)
                                     (normalise-inputs
                                      'in-bytes
                                      "bytes"
                                      (lambda (x_35) (bytes? x_35))
                                      (lambda (x_36)
                                        (unsafe-bytes-length x_36))
                                      s_87
                                      (car p_4)
                                      (cdr p_4)
                                      1))
                                    ((v*_11 start*_11 stop*_12 step*_11)
                                     (normalise-inputs
                                      'in-bytes
                                      "bytes"
                                      (lambda (x_37) (bytes? x_37))
                                      (lambda (x_38)
                                        (unsafe-bytes-length x_38))
                                      s_87
                                      pos_108
                                      (+ pos_108 len_8)
                                      1)))
                         (begin
                           #t
                           #t
                           ((letrec ((for-loop_22
                                      (lambda (result_30 idx_10 idx_11)
                                        (if (if (unsafe-fx< idx_10 stop*_11)
                                              (unsafe-fx< idx_11 stop*_12)
                                              #f)
                                          (let-values (((c1_7)
                                                        (unsafe-bytes-ref
                                                         v*_10
                                                         idx_10))
                                                       ((c2_7)
                                                        (unsafe-bytes-ref
                                                         v*_11
                                                         idx_11)))
                                            (let ((result_31
                                                   (let ((result_32
                                                          (= c1_7 c2_7)))
                                                     (values result_32))))
                                              (if (if (not
                                                       ((lambda x_39
                                                          (not result_31))
                                                        c1_7))
                                                    (if (not
                                                         ((lambda x_40
                                                            (not result_31))
                                                          c2_7))
                                                      (not #f)
                                                      #f)
                                                    #f)
                                                (for-loop_22
                                                 result_31
                                                 (unsafe-fx+ idx_10 1)
                                                 (unsafe-fx+ idx_11 1))
                                                result_31)))
                                          result_30))))
                              for-loop_22)
                            #t
                            start*_10
                            start*_11)))
                       #f)
                     (if (lazy-bytes-before-end?
                          s_87
                          (sub1 (+ pos_108 len_8))
                          limit_37)
                       (let-values (((start_43) (car p_4))
                                    ((end_38) (cdr p_4))
                                    ((inc_4) 1)
                                    ((start_44) pos_108))
                         (begin
                           (if (if (real? start_43)
                                 (if (real? end_38) (real? inc_4) #f)
                                 #f)
                             (void)
                             (check-range$1 start_43 end_38 inc_4))
                           (if (exact-nonnegative-integer? start_44)
                             (void)
                             (check-naturals start_44))
                           ((letrec ((for-loop_23
                                      (lambda (result_33 pos_109 pos_110)
                                        (if (if (< pos_109 end_38) #t #f)
                                          (let-values (((j_0) pos_109)
                                                       ((i_11) pos_110))
                                            (let ((result_34
                                                   (let ((result_35
                                                          (let ((c1_8
                                                                 (lazy-bytes-ref
                                                                  s_87
                                                                  j_0)))
                                                            (let ((c2_8
                                                                   (lazy-bytes-ref
                                                                    s_87
                                                                    i_11)))
                                                              (= c1_8 c2_8)))))
                                                     (values result_35))))
                                              (if (if (not
                                                       ((lambda x_41
                                                          (not result_34))
                                                        j_0))
                                                    (if (not
                                                         ((lambda x_42
                                                            (not result_34))
                                                          i_11))
                                                      (not #f)
                                                      #f)
                                                    #f)
                                                (for-loop_23
                                                 result_34
                                                 (+ pos_109 inc_4)
                                                 (+ pos_110 1))
                                                result_34)))
                                          result_33))))
                              for-loop_23)
                            #t
                            start_43
                            start_44)))
                       #f))))
              (if matches?_0
                (|#%app|
                 next-m_17
                 s_87
                 (+ pos_108 len_8)
                 start_42
                 limit_37
                 end_37
                 state_32
                 stack_26)
                #f))))))))
(define reference-matcher/case-insensitive
  (lambda (n_29 next-m_18)
    (lambda (s_88 pos_111 start_45 limit_38 end_39 state_33 stack_27)
      (let ((p_5 (vector-ref state_33 n_29)))
        (if (not p_5)
          #f
          (let ((len_9 (- (cdr p_5) (car p_5))))
            (let ((matches?_1
                   (if (bytes? s_88)
                     (if (<= (+ pos_111 len_9) limit_38)
                       (let-values (((v*_12 start*_12 stop*_13 step*_12)
                                     (normalise-inputs
                                      'in-bytes
                                      "bytes"
                                      (lambda (x_43) (bytes? x_43))
                                      (lambda (x_44)
                                        (unsafe-bytes-length x_44))
                                      s_88
                                      (car p_5)
                                      (cdr p_5)
                                      1))
                                    ((v*_13 start*_13 stop*_14 step*_13)
                                     (normalise-inputs
                                      'in-bytes
                                      "bytes"
                                      (lambda (x_45) (bytes? x_45))
                                      (lambda (x_46)
                                        (unsafe-bytes-length x_46))
                                      s_88
                                      pos_111
                                      (+ pos_111 len_9)
                                      1)))
                         (begin
                           #t
                           #t
                           ((letrec ((for-loop_24
                                      (lambda (result_36 idx_12 idx_13)
                                        (if (if (unsafe-fx< idx_12 stop*_13)
                                              (unsafe-fx< idx_13 stop*_14)
                                              #f)
                                          (let-values (((c1_9)
                                                        (unsafe-bytes-ref
                                                         v*_12
                                                         idx_12))
                                                       ((c2_9)
                                                        (unsafe-bytes-ref
                                                         v*_13
                                                         idx_13)))
                                            (let ((result_37
                                                   (let ((result_38
                                                          ((lambda (c1_10
                                                                    c2_10)
                                                             (=
                                                              (chyte-to-lower
                                                               c1_10)
                                                              (chyte-to-lower
                                                               c2_10)))
                                                           c1_9
                                                           c2_9)))
                                                     (values result_38))))
                                              (if (if (not
                                                       ((lambda x_47
                                                          (not result_37))
                                                        c1_9))
                                                    (if (not
                                                         ((lambda x_48
                                                            (not result_37))
                                                          c2_9))
                                                      (not #f)
                                                      #f)
                                                    #f)
                                                (for-loop_24
                                                 result_37
                                                 (unsafe-fx+ idx_12 1)
                                                 (unsafe-fx+ idx_13 1))
                                                result_37)))
                                          result_36))))
                              for-loop_24)
                            #t
                            start*_12
                            start*_13)))
                       #f)
                     (if (lazy-bytes-before-end?
                          s_88
                          (sub1 (+ pos_111 len_9))
                          limit_38)
                       (let-values (((start_46) (car p_5))
                                    ((end_40) (cdr p_5))
                                    ((inc_5) 1)
                                    ((start_47) pos_111))
                         (begin
                           (if (if (real? start_46)
                                 (if (real? end_40) (real? inc_5) #f)
                                 #f)
                             (void)
                             (check-range$1 start_46 end_40 inc_5))
                           (if (exact-nonnegative-integer? start_47)
                             (void)
                             (check-naturals start_47))
                           ((letrec ((for-loop_25
                                      (lambda (result_39 pos_112 pos_113)
                                        (if (if (< pos_112 end_40) #t #f)
                                          (let-values (((j_1) pos_112)
                                                       ((i_12) pos_113))
                                            (let ((result_40
                                                   (let ((result_41
                                                          (let ((c1_11
                                                                 (lazy-bytes-ref
                                                                  s_88
                                                                  j_1)))
                                                            (let ((c2_11
                                                                   (lazy-bytes-ref
                                                                    s_88
                                                                    i_12)))
                                                              ((lambda (c1_12
                                                                        c2_12)
                                                                 (=
                                                                  (chyte-to-lower
                                                                   c1_12)
                                                                  (chyte-to-lower
                                                                   c2_12)))
                                                               c1_11
                                                               c2_11)))))
                                                     (values result_41))))
                                              (if (if (not
                                                       ((lambda x_49
                                                          (not result_40))
                                                        j_1))
                                                    (if (not
                                                         ((lambda x_50
                                                            (not result_40))
                                                          i_12))
                                                      (not #f)
                                                      #f)
                                                    #f)
                                                (for-loop_25
                                                 result_40
                                                 (+ pos_112 inc_5)
                                                 (+ pos_113 1))
                                                result_40)))
                                          result_39))))
                              for-loop_25)
                            #t
                            start_46
                            start_47)))
                       #f))))
              (if matches?_1
                (|#%app|
                 next-m_18
                 s_88
                 (+ pos_111 len_9)
                 start_45
                 limit_38
                 end_39
                 state_33
                 stack_27)
                #f))))))))
(define chyte-to-lower
  (lambda (c_11)
    (if (if (>= c_11 (char->integer '#\x41))
          (<= c_11 (char->integer '#\x5a))
          #f)
      (+ c_11 (- (char->integer '#\x61) (char->integer '#\x41)))
      c_11)))
(define lookahead-matcher
  (lambda (match?_0 sub-m_0 n-start_2 num-n_2 next-m_19)
    (lambda (s_89 pos_114 start_48 limit_39 end_41 state_34 stack_28)
      (let ((old-state_0 (save-groups state_34 n-start_2 num-n_2)))
        (let ((pos2_19
               (|#%app|
                sub-m_0
                s_89
                pos_114
                start_48
                limit_39
                end_41
                state_34
                null)))
          (if match?_0
            (if pos2_19
              (let ((or-part_59
                     (|#%app|
                      next-m_19
                      s_89
                      pos_114
                      start_48
                      limit_39
                      end_41
                      state_34
                      stack_28)))
                (if or-part_59
                  or-part_59
                  (restore-groups state_34 old-state_0 n-start_2 num-n_2)))
              #f)
            (if pos2_19
              (restore-groups state_34 old-state_0 n-start_2 num-n_2)
              (|#%app|
               next-m_19
               s_89
               pos_114
               start_48
               limit_39
               end_41
               state_34
               stack_28))))))))
(define lookbehind-matcher
  (lambda (match?_1 lb-min_0 lb-max_0 sub-m_1 n-start_3 num-n_3 next-m_20)
    (lambda (s_90 pos_115 start_49 limit_40 end_42 state_35 stack_29)
      (let ((lb-min-pos_0 (max start_49 (- pos_115 lb-max_0))))
        ((letrec ((loop_18
                   (lambda (lb-pos_0)
                     (if (< lb-pos_0 lb-min-pos_0)
                       (if match?_1
                         #f
                         (|#%app|
                          next-m_20
                          s_90
                          pos_115
                          start_49
                          limit_40
                          end_42
                          state_35
                          stack_29))
                       (let ((old-state_1
                              (save-groups state_35 n-start_3 num-n_3)))
                         (let ((pos2_20
                                (|#%app|
                                 sub-m_1
                                 s_90
                                 lb-pos_0
                                 start_49
                                 pos_115
                                 end_42
                                 state_35
                                 null)))
                           (if match?_1
                             (if pos2_20
                               (let ((or-part_60
                                      (|#%app|
                                       next-m_20
                                       s_90
                                       pos_115
                                       start_49
                                       limit_40
                                       end_42
                                       state_35
                                       stack_29)))
                                 (if or-part_60
                                   or-part_60
                                   (restore-groups
                                    state_35
                                    old-state_1
                                    n-start_3
                                    num-n_3)))
                               (loop_18 (sub1 lb-pos_0)))
                             (if pos2_20
                               (restore-groups
                                state_35
                                old-state_1
                                n-start_3
                                num-n_3)
                               (|#%app|
                                next-m_20
                                s_90
                                pos_115
                                start_49
                                limit_40
                                end_42
                                state_35
                                stack_29)))))))))
           loop_18)
         (- pos_115 lb-min_0))))))
(define conditional/reference-matcher
  (lambda (n_30 m1_1 m2_1)
    (lambda (s_91 pos_116 start_50 limit_41 end_43 state_36 stack_30)
      (if (vector-ref state_36 n_30)
        (|#%app| m1_1 s_91 pos_116 start_50 limit_41 end_43 state_36 stack_30)
        (|#%app|
         m2_1
         s_91
         pos_116
         start_50
         limit_41
         end_43
         state_36
         stack_30)))))
(define conditional/look-matcher
  (lambda (tst-m_0 m1_2 m2_2 n-start_4 num-n_4)
    (lambda (s_92 pos_117 start_51 limit_42 end_44 state_37 stack_31)
      (let ((old-state_2 (save-groups state_37 n-start_4 num-n_4)))
        (let ((or-part_61
               (if (|#%app|
                    tst-m_0
                    s_92
                    pos_117
                    start_51
                    limit_42
                    end_44
                    state_37
                    null)
                 (|#%app|
                  m1_2
                  s_92
                  pos_117
                  start_51
                  limit_42
                  end_44
                  state_37
                  stack_31)
                 (|#%app|
                  m2_2
                  s_92
                  pos_117
                  start_51
                  limit_42
                  end_44
                  state_37
                  stack_31))))
          (if or-part_61
            or-part_61
            (restore-groups state_37 old-state_2 n-start_4 num-n_4)))))))
(define cut-matcher
  (lambda (sub-m_2 n-start_5 num-n_5 next-m_21)
    (lambda (s_93 pos_118 start_52 limit_43 end_45 state_38 stack_32)
      (let ((old-state_3 (save-groups state_38 n-start_5 num-n_5)))
        (let ((pos2_21
               (|#%app|
                sub-m_2
                s_93
                pos_118
                start_52
                limit_43
                end_45
                state_38
                null)))
          (if pos2_21
            (let ((or-part_62
                   (|#%app|
                    next-m_21
                    s_93
                    pos2_21
                    start_52
                    limit_43
                    end_45
                    state_38
                    stack_32)))
              (if or-part_62
                or-part_62
                (restore-groups state_38 old-state_3 n-start_5 num-n_5)))
            #f))))))
(define save-groups
  (lambda (state_39 n-start_6 num-n_6)
    (if (zero? num-n_6)
      #f
      (if (not state_39)
        #f
        (let ((vec_2 (make-vector num-n_6)))
          (begin
            (vector-copy! vec_2 0 state_39 n-start_6 (+ n-start_6 num-n_6))
            vec_2))))))
(define restore-groups
  (lambda (state_40 old-state_4 n-start_7 num-n_7)
    (begin
      (if old-state_4 (vector-copy! state_40 n-start_7 old-state_4) (void))
      #f)))
(define unicode-categories-matcher
  (lambda (cats_0 match?_2 next-m_22)
    (lambda (s_94 pos_119 start_53 limit_44 end_46 state_41 stack_33)
      ((letrec ((loop_19
                 (lambda (pos_120 accum_4)
                   (let ((b_11
                          (if (bytes? s_94)
                            (if (< pos_120 limit_44)
                              (bytes-ref s_94 pos_120)
                              #f)
                            (if (lazy-bytes-before-end? s_94 pos_120 limit_44)
                              (lazy-bytes-ref s_94 pos_120)
                              #f))))
                     (if (not b_11)
                       #f
                       (let ((c_12 (bytes->char/utf-8 b_11 accum_4)))
                         (if (char? c_12)
                           (if (eq?
                                match?_2
                                (let ((c-cat_0 (char-general-category c_12)))
                                  (if (list? cats_0)
                                    (let ((lst_18 cats_0))
                                      (begin
                                        (if (list? lst_18)
                                          (void)
                                          (check-list lst_18))
                                        ((letrec ((for-loop_26
                                                   (lambda (result_42 lst_19)
                                                     (if (pair? lst_19)
                                                       (let-values (((cat_0)
                                                                     (unsafe-car
                                                                      lst_19))
                                                                    ((rest_9)
                                                                     (unsafe-cdr
                                                                      lst_19)))
                                                         (let ((result_43
                                                                (let ((result_44
                                                                       (eq?
                                                                        cat_0
                                                                        c-cat_0)))
                                                                  (values
                                                                   result_44))))
                                                           (if (if (not
                                                                    ((lambda x_51
                                                                       result_43)
                                                                     cat_0))
                                                                 (not #f)
                                                                 #f)
                                                             (for-loop_26
                                                              result_43
                                                              rest_9)
                                                             result_43)))
                                                       result_42))))
                                           for-loop_26)
                                         #f
                                         lst_18)))
                                    (eq? cats_0 c-cat_0))))
                             (|#%app|
                              next-m_22
                              s_94
                              (add1 pos_120)
                              start_53
                              limit_44
                              end_46
                              state_41
                              stack_33)
                             #f)
                           (if (eq? c_12 'fail)
                             #f
                             (loop_19
                              (add1 pos_120)
                              (cons b_11 accum_4))))))))))
         loop_19)
       pos_119
       null))))
(define 1/compile
  (lambda (rx_15)
    ((letrec ((compile_0
               (lambda (rx_24 next-m_23)
                 (if (exact-integer? rx_24)
                   (if (eq? next-m_23 done-m)
                     (byte-tail-matcher rx_24)
                     (byte-matcher rx_24 next-m_23))
                   (if (bytes? rx_24)
                     (let ((len_10 (bytes-length rx_24)))
                       (if (eq? next-m_23 done-m)
                         (bytes-tail-matcher rx_24 len_10)
                         (bytes-matcher rx_24 len_10 next-m_23)))
                     (if (eq? rx_24 rx:empty)
                       next-m_23
                       (if (eq? rx_24 rx:never)
                         (never-matcher)
                         (if (eq? rx_24 rx:any)
                           (if (eq? next-m_23 done-m)
                             (any-tail-matcher)
                             (any-matcher next-m_23))
                           (if (|#%app| rx:range? rx_24)
                             (let ((rng_5
                                    (compile-range
                                     (|#%app| rx:range-range rx_24))))
                               (if (eq? next-m_23 done-m)
                                 (range-tail-matcher rng_5)
                                 (range-matcher rng_5 next-m_23)))
                             (if (eq? rx_24 rx:start)
                               (start-matcher next-m_23)
                               (if (eq? rx_24 rx:end)
                                 (end-matcher next-m_23)
                                 (if (eq? rx_24 rx:line-start)
                                   (line-start-matcher next-m_23)
                                   (if (eq? rx_24 rx:line-end)
                                     (line-end-matcher next-m_23)
                                     (if (eq? rx_24 rx:word-boundary)
                                       (word-boundary-matcher next-m_23)
                                       (if (eq? rx_24 rx:not-word-boundary)
                                         (not-word-boundary-matcher next-m_23)
                                         (if (|#%app| rx:sequence? rx_24)
                                           (let ((rxs_3
                                                  (|#%app|
                                                   rx:sequence-rxs
                                                   rx_24)))
                                             ((letrec ((loop_20
                                                        (lambda (rxs_4)
                                                          (if (null? rxs_4)
                                                            next-m_23
                                                            (let ((rest-node_0
                                                                   (loop_20
                                                                    (cdr
                                                                     rxs_4))))
                                                              (compile_0
                                                               (car rxs_4)
                                                               rest-node_0))))))
                                                loop_20)
                                              rxs_3))
                                           (if (|#%app| rx:alts? rx_24)
                                             (alts-matcher
                                              (compile_0
                                               (|#%app| rx:alts-rx1 rx_24)
                                               next-m_23)
                                              (compile_0
                                               (|#%app| rx:alts-rx2 rx_24)
                                               next-m_23))
                                             (if (|#%app| rx:maybe? rx_24)
                                               (if (|#%app|
                                                    rx:maybe-non-greedy?
                                                    rx_24)
                                                 (alts-matcher
                                                  next-m_23
                                                  (compile_0
                                                   (|#%app| rx:maybe-rx rx_24)
                                                   next-m_23))
                                                 (alts-matcher
                                                  (compile_0
                                                   (|#%app| rx:maybe-rx rx_24)
                                                   next-m_23)
                                                  next-m_23))
                                               (if (|#%app| rx:repeat? rx_24)
                                                 (let ((actual-r-rx_0
                                                        (|#%app|
                                                         rx:repeat-rx
                                                         rx_24)))
                                                   (let ((r-rx_0
                                                          (if (if (|#%app|
                                                                   rx:group?
                                                                   actual-r-rx_0)
                                                                (if (not
                                                                     (|#%app|
                                                                      rx:repeat-non-greedy?
                                                                      rx_24))
                                                                  (not
                                                                   (needs-backtrack?
                                                                    (|#%app|
                                                                     rx:group-rx
                                                                     actual-r-rx_0)))
                                                                  #f)
                                                                #f)
                                                            (|#%app|
                                                             rx:group-rx
                                                             actual-r-rx_0)
                                                            actual-r-rx_0)))
                                                     (let ((simple?_0
                                                            (not
                                                             (needs-backtrack?
                                                              r-rx_0))))
                                                       (let ((group-n_4
                                                              (if simple?_0
                                                                (if (|#%app|
                                                                     rx:group?
                                                                     actual-r-rx_0)
                                                                  (|#%app|
                                                                   rx:group-number
                                                                   actual-r-rx_0)
                                                                  #f)
                                                                #f)))
                                                         (let ((min_8
                                                                (|#%app|
                                                                 rx:repeat-min
                                                                 rx_24)))
                                                           (let ((max_8
                                                                  (let ((n_31
                                                                         (|#%app|
                                                                          rx:repeat-max
                                                                          rx_24)))
                                                                    (if (=
                                                                         n_31
                                                                         +inf.0)
                                                                      #f
                                                                      n_31))))
                                                             (let ((r-m*_1
                                                                    (compile*/maybe
                                                                     r-rx_0
                                                                     min_8
                                                                     max_8)))
                                                               (if (if r-m*_1
                                                                     (not
                                                                      (|#%app|
                                                                       rx:repeat-non-greedy?
                                                                       rx_24))
                                                                     #f)
                                                                 (repeat-simple-many-matcher
                                                                  r-m*_1
                                                                  min_8
                                                                  max_8
                                                                  group-n_4
                                                                  next-m_23)
                                                                 (let ((r-m_4
                                                                        (compile_0
                                                                         r-rx_0
                                                                         (if simple?_0
                                                                           done-m
                                                                           continue-m))))
                                                                   (if (|#%app|
                                                                        rx:repeat-non-greedy?
                                                                        rx_24)
                                                                     (if simple?_0
                                                                       (lazy-repeat-simple-matcher
                                                                        r-m_4
                                                                        min_8
                                                                        max_8
                                                                        next-m_23)
                                                                       (lazy-repeat-matcher
                                                                        r-m_4
                                                                        min_8
                                                                        max_8
                                                                        next-m_23))
                                                                     (if simple?_0
                                                                       (repeat-simple-matcher
                                                                        r-m_4
                                                                        min_8
                                                                        max_8
                                                                        group-n_4
                                                                        next-m_23)
                                                                       (repeat-matcher
                                                                        r-m_4
                                                                        min_8
                                                                        max_8
                                                                        next-m_23))))))))))))
                                                 (if (|#%app| rx:group? rx_24)
                                                   (let ((n_32
                                                          (|#%app|
                                                           rx:group-number
                                                           rx_24)))
                                                     (let ((m_1
                                                            (compile_0
                                                             (|#%app|
                                                              rx:group-rx
                                                              rx_24)
                                                             (group-set-matcher
                                                              n_32
                                                              next-m_23))))
                                                       (group-push-matcher
                                                        n_32
                                                        m_1)))
                                                   (if (|#%app|
                                                        rx:reference?
                                                        rx_24)
                                                     (let ((n_33
                                                            (|#%app|
                                                             rx:reference-n
                                                             rx_24)))
                                                       (if (zero? n_33)
                                                         (never-matcher)
                                                         (if (|#%app|
                                                              rx:reference-case-sensitive?
                                                              rx_24)
                                                           (reference-matcher
                                                            (sub1 n_33)
                                                            next-m_23)
                                                           (reference-matcher/case-insensitive
                                                            (sub1 n_33)
                                                            next-m_23))))
                                                     (if (|#%app|
                                                          rx:cut?
                                                          rx_24)
                                                       (cut-matcher
                                                        (compile_0
                                                         (|#%app|
                                                          rx:cut-rx
                                                          rx_24)
                                                         done-m)
                                                        (|#%app|
                                                         rx:cut-n-start
                                                         rx_24)
                                                        (|#%app|
                                                         rx:cut-num-n
                                                         rx_24)
                                                        next-m_23)
                                                       (if (|#%app|
                                                            rx:conditional?
                                                            rx_24)
                                                         (let ((tst_2
                                                                (|#%app|
                                                                 rx:conditional-tst
                                                                 rx_24)))
                                                           (let ((m1_3
                                                                  (compile_0
                                                                   (|#%app|
                                                                    rx:conditional-rx1
                                                                    rx_24)
                                                                   next-m_23)))
                                                             (let ((m2_3
                                                                    (compile_0
                                                                     (|#%app|
                                                                      rx:conditional-rx2
                                                                      rx_24)
                                                                     next-m_23)))
                                                               (if (|#%app|
                                                                    rx:reference?
                                                                    tst_2)
                                                                 (let ((n_34
                                                                        (sub1
                                                                         (|#%app|
                                                                          rx:reference-n
                                                                          tst_2))))
                                                                   (conditional/reference-matcher
                                                                    n_34
                                                                    m1_3
                                                                    m2_3))
                                                                 (conditional/look-matcher
                                                                  (compile_0
                                                                   tst_2
                                                                   done-m)
                                                                  m1_3
                                                                  m2_3
                                                                  (|#%app|
                                                                   rx:conditional-n-start
                                                                   rx_24)
                                                                  (|#%app|
                                                                   rx:conditional-num-n
                                                                   rx_24))))))
                                                         (if (|#%app|
                                                              rx:lookahead?
                                                              rx_24)
                                                           (lookahead-matcher
                                                            (|#%app|
                                                             rx:lookahead-match?
                                                             rx_24)
                                                            (compile_0
                                                             (|#%app|
                                                              rx:lookahead-rx
                                                              rx_24)
                                                             done-m)
                                                            (|#%app|
                                                             rx:lookahead-n-start
                                                             rx_24)
                                                            (|#%app|
                                                             rx:lookahead-num-n
                                                             rx_24)
                                                            next-m_23)
                                                           (if (|#%app|
                                                                rx:lookbehind?
                                                                rx_24)
                                                             (lookbehind-matcher
                                                              (|#%app|
                                                               rx:lookbehind-match?
                                                               rx_24)
                                                              (|#%app|
                                                               rx:lookbehind-lb-min
                                                               rx_24)
                                                              (|#%app|
                                                               rx:lookbehind-lb-max
                                                               rx_24)
                                                              (compile_0
                                                               (|#%app|
                                                                rx:lookbehind-rx
                                                                rx_24)
                                                               limit-m)
                                                              (|#%app|
                                                               rx:lookbehind-n-start
                                                               rx_24)
                                                              (|#%app|
                                                               rx:lookbehind-num-n
                                                               rx_24)
                                                              next-m_23)
                                                             (if (|#%app|
                                                                  rx:unicode-categories?
                                                                  rx_24)
                                                               (unicode-categories-matcher
                                                                (|#%app|
                                                                 rx:unicode-categories-symlist
                                                                 rx_24)
                                                                (|#%app|
                                                                 rx:unicode-categories-match?
                                                                 rx_24)
                                                                next-m_23)
                                                               (error
                                                                'compile/bt
                                                                "internal error: unrecognized ~s"
                                                                rx_24)))))))))))))))))))))))))))
       compile_0)
     rx_15
     done-m)))
(define compile*/maybe
  (lambda (rx_26 min_9 max_9)
    (if (exact-integer? rx_26)
      (byte-matcher* rx_26 max_9)
      (if (bytes? rx_26)
        (bytes-matcher* rx_26 max_9)
        (if (eq? rx_26 rx:any)
          (any-matcher* max_9)
          (if (|#%app| rx:range? rx_26)
            (range-matcher*
             (compile-range (|#%app| rx:range-range rx_26))
             max_9)
            #f))))))
(define-values
 (struct:rx:regexp
  rx:regexp1.1
  rx:regexp?
  rx:regexp-bytes?
  rx:regexp-px?
  rx:regexp-source
  rx:regexp-matcher
  rx:regexp-num-groups
  rx:regexp-references?
  rx:regexp-max-lookbehind
  rx:regexp-anchored?
  rx:regexp-must-string
  rx:regexp-start-range)
 (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
               (make-struct-type
                (check-reflection-name 'struct 'regexp)
                #f
                10
                0
                #f
                (list
                 (cons
                  prop:custom-write
                  (lambda (rx_27 port_0 mode_1)
                    (begin
                      (write-bytes
                       (if (|#%app| rx:regexp-px? rx_27) #vu8(35 112 120) #vu8(35 114 120))
                       port_0)
                      (write (|#%app| rx:regexp-source rx_27) port_0)))))
                (current-inspector)
                #f
                '(0 1 2 3 4 5 6 7 8 9)
                #f
                'rx:regexp)))
   (values
    struct:_0
    make-_0
    ?_0
    (make-struct-field-accessor -ref_0 0 'bytes?)
    (make-struct-field-accessor -ref_0 1 'px?)
    (make-struct-field-accessor -ref_0 2 'source)
    (make-struct-field-accessor -ref_0 3 'matcher)
    (make-struct-field-accessor -ref_0 4 'num-groups)
    (make-struct-field-accessor -ref_0 5 'references?)
    (make-struct-field-accessor -ref_0 6 'max-lookbehind)
    (make-struct-field-accessor -ref_0 7 'anchored?)
    (make-struct-field-accessor -ref_0 8 'must-string)
    (make-struct-field-accessor -ref_0 9 'start-range))))
(define make-regexp
  (lambda (who_3 orig-p_0 px?_2 as-bytes?_0 handler_0)
    (call-with-continuation-prompt
     (lambda ()
       (let ((p_6
              (if (bytes? orig-p_0)
                (bytes->immutable-bytes orig-p_0)
                (string->immutable-string orig-p_0))))
         (let-values (((raw-rx_0 num-groups_1 references?_0)
                       (let ((px?4_0 px?_2)) (parse4.1 px?4_0 #t p_6))))
           (let ((rx_28 (if as-bytes?_0 raw-rx_0 (convert raw-rx_0))))
             (let ((max-lookbehind_2 (validate rx_28 num-groups_1)))
               (let ((matcher_0 (1/compile rx_28)))
                 (|#%app|
                  rx:regexp1.1
                  as-bytes?_0
                  px?_2
                  p_6
                  matcher_0
                  num-groups_1
                  references?_0
                  max-lookbehind_2
                  (anchored? rx_28)
                  (get-must-string rx_28)
                  (get-start-range rx_28))))))))
     regexp-error-tag
     (lambda (str_0)
       (if handler_0
         (|#%app| handler_0 str_0)
         (raise-arguments-error who_3 str_0 "pattern" orig-p_0))))))
(define 1/regexp?
  (lambda (v_19)
    (if (|#%app| rx:regexp? v_19) (not (|#%app| rx:regexp-bytes? v_19)) #f)))
(define 1/byte-regexp?
  (lambda (v_20)
    (if (|#%app| rx:regexp? v_20) (|#%app| rx:regexp-bytes? v_20) #f)))
(define 1/pregexp?
  (lambda (v_21)
    (if (|#%app| rx:regexp? v_21)
      (if (not (|#%app| rx:regexp-bytes? v_21))
        (|#%app| rx:regexp-px? v_21)
        #f)
      #f)))
(define 1/byte-pregexp?
  (lambda (v_22)
    (if (|#%app| rx:regexp? v_22)
      (if (|#%app| rx:regexp-bytes? v_22) (|#%app| rx:regexp-px? v_22) #f)
      #f)))
(define copy-port-bytes
  (lambda (in_1 out_2 n_35)
    (let ((bstr_11
           (make-bytes
            (min
             4096
             (let ((or-part_63 n_35)) (if or-part_63 or-part_63 4096))))))
      (let ((copy_0
             (lambda (got_0 expect_0)
               (if (eof-object? got_0)
                 #f
                 (begin
                   (if out_2 (write-bytes bstr_11 out_2 0 got_0) (void))
                   (let ((or-part_23 (if (not n_35) (positive? got_0) #f)))
                     (if or-part_23
                       or-part_23
                       (if n_35 (= got_0 expect_0) #f))))))))
        ((letrec ((loop_2
                   (lambda (n_36)
                     (if (if n_36 (< n_36 4096) #f)
                       (copy_0 (read-bytes! bstr_11 in_1 0 n_36) n_36)
                       (if (copy_0 (read-bytes! bstr_11 in_1) 4096)
                         (loop_2 (if n_36 (- n_36 4096) #f))
                         #f)))))
           loop_2)
         n_35)))))
(define open-input-bytes/no-copy
  (lambda (bstr_12 pos_2 end_47)
    (let ((fill!_0
           (lambda (dest-bstr_0 skip_0)
             (let ((pos+skip_0 (+ pos_2 skip_0)))
               (if (>= pos+skip_0 end_47)
                 eof
                 (let ((len_11
                        (min
                         (bytes-length dest-bstr_0)
                         (- end_47 pos+skip_0))))
                   (begin
                     (bytes-copy!
                      dest-bstr_0
                      0
                      bstr_12
                      pos+skip_0
                      (+ pos+skip_0 len_11))
                     len_11)))))))
      (make-input-port
       'bytes
       (lambda (dest-bstr_1)
         (let ((len_12 (fill!_0 dest-bstr_1 0)))
           (begin
             (if (eof-object? len_12) (void) (set! pos_2 (+ len_12 pos_2)))
             len_12)))
       (lambda (dest-bstr_2 skip_1 evt_0) (fill!_0 dest-bstr_2 skip_1))
       void))))
(define open-input-string/lazy
  (lambda (str_1 pos_121 end_1)
    (let ((bstr_13 (make-bytes 64)))
      (let ((bstr-pos_0 0))
        (let ((bstr-end_0 0))
          (letrec ((fill!_1
                    (lambda (dest-bstr_3 skip_2)
                      (let ((bstr-pos+skip_0 (+ bstr-pos_0 skip_2)))
                        (begin
                          (if (>= bstr-pos+skip_0 bstr-end_0)
                            (decode-more!_0 (add1 bstr-pos+skip_0))
                            (void))
                          (if (>= bstr-pos+skip_0 bstr-end_0)
                            eof
                            (let ((len_13
                                   (min
                                    (bytes-length dest-bstr_3)
                                    (- bstr-end_0 bstr-pos+skip_0))))
                              (begin
                                (bytes-copy!
                                 dest-bstr_3
                                 0
                                 bstr_13
                                 bstr-pos+skip_0
                                 (+ bstr-pos+skip_0 len_13))
                                len_13)))))))
                   (decode-more!_0
                    (lambda (target-pos_0)
                      (if (= pos_121 end_1)
                        (void)
                        (let ((len_14 (min 64 (- end_1 pos_121))))
                          (let ((new-bstr_0
                                 (string->bytes/utf-8
                                  str_1
                                  0
                                  pos_121
                                  (+ pos_121 len_14))))
                            (let-values ((()
                                          (begin
                                            (set! pos_121 (+ len_14 pos_121))
                                            (values))))
                              (let ((new-len_0 (bytes-length new-bstr_0)))
                                (begin
                                  (if (<
                                       (- (bytes-length bstr_13) bstr-end_0)
                                       new-len_0)
                                    (let ((bstr2_1
                                           (make-bytes
                                            (max
                                             (* (bytes-length bstr_13) 2)
                                             (+ bstr-end_0 new-len_0)))))
                                      (begin
                                        (bytes-copy!
                                         bstr2_1
                                         0
                                         bstr_13
                                         0
                                         bstr-end_0)
                                        (set! bstr_13 bstr2_1)))
                                    (void))
                                  (bytes-copy! bstr_13 bstr-end_0 new-bstr_0)
                                  (set! bstr-end_0 (+ bstr-end_0 new-len_0))
                                  (if (< bstr-end_0 target-pos_0)
                                    (decode-more!_0 target-pos_0)
                                    (void)))))))))))
            (make-input-port
             'string
             (lambda (dest-bstr_4)
               (let ((len_15 (|#%app| fill!_1 dest-bstr_4 0)))
                 (begin
                   (if (eof-object? len_15)
                     (void)
                     (set! bstr-pos_0 (+ bstr-pos_0 len_15)))
                   len_15)))
             (lambda (dest-bstr_5 skip_3 evt_1)
               (|#%app| fill!_1 dest-bstr_5 skip_3))
             void)))))))
(define byte-positions->byte-positions6.1
  (lambda (delta1_0 delta2_0 ms-pos3_0 me-pos4_0 state5_0)
    (let ((ms-pos_0 ms-pos3_0))
      (let ((me-pos_0 me-pos4_0))
        (let ((state_42 state5_0))
          (let ((delta_0 (if delta2_0 delta1_0 0)))
            (if (not state_42)
              (list (cons (+ ms-pos_0 delta_0) (+ me-pos_0 delta_0)))
              (if (zero? delta_0)
                (cons (cons ms-pos_0 me-pos_0) (vector->list state_42))
                (cons
                 (cons (+ ms-pos_0 delta_0) (+ me-pos_0 delta_0))
                 (let-values (((vec_3 len_16)
                               (let ((vec_4 state_42))
                                 (begin
                                   (if (vector? vec_4)
                                     (void)
                                     (check-vector vec_4))
                                   (values
                                    vec_4
                                    (unsafe-vector-length vec_4))))))
                   (begin
                     #f
                     ((letrec ((for-loop_27
                                (lambda (pos_122)
                                  (if (unsafe-fx< pos_122 len_16)
                                    (let ((p_7
                                           (unsafe-vector-ref vec_3 pos_122)))
                                      (let ((post-guard-var_5 (lambda () #t)))
                                        (let ((elem_5
                                               (if p_7
                                                 (cons
                                                  (+ (car p_7) delta_0)
                                                  (+ (cdr p_7) delta_0))
                                                 #f)))
                                          (let ((result_45
                                                 (if (post-guard-var_5)
                                                   (for-loop_27
                                                    (unsafe-fx+ 1 pos_122))
                                                   null)))
                                            (cons elem_5 result_45)))))
                                    null))))
                        for-loop_27)
                      0))))))))))))
(define byte-positions->bytess15.1
  (lambda (delta9_0 delta10_0 in11_0 ms-pos12_0 me-pos13_0 state14_0)
    (let ((in_2 in11_0))
      (let ((ms-pos_1 ms-pos12_0))
        (let ((me-pos_1 me-pos13_0))
          (let ((state_43 state14_0))
            (let ((delta_1 (if delta10_0 delta9_0 0)))
              (cons
               (subbytes in_2 (+ ms-pos_1 delta_1) (+ me-pos_1 delta_1))
               (if state_43
                 (let-values (((vec_5 len_17)
                               (let ((vec_6 state_43))
                                 (begin
                                   (if (vector? vec_6)
                                     (void)
                                     (check-vector vec_6))
                                   (values
                                    vec_6
                                    (unsafe-vector-length vec_6))))))
                   (begin
                     #f
                     ((letrec ((for-loop_28
                                (lambda (pos_123)
                                  (if (unsafe-fx< pos_123 len_17)
                                    (let ((p_8
                                           (unsafe-vector-ref vec_5 pos_123)))
                                      (let ((post-guard-var_6 (lambda () #t)))
                                        (let ((elem_6
                                               (if p_8
                                                 (subbytes
                                                  in_2
                                                  (+ (car p_8) delta_1)
                                                  (+ (cdr p_8) delta_1))
                                                 #f)))
                                          (let ((result_46
                                                 (if (post-guard-var_6)
                                                   (for-loop_28
                                                    (unsafe-fx+ 1 pos_123))
                                                   null)))
                                            (cons elem_6 result_46)))))
                                    null))))
                        for-loop_28)
                      0)))
                 null)))))))))
(define byte-positions->string-positions26.1
  (lambda (start-offset18_0
           start-pos19_0
           start-pos21_0
           bstr-in22_0
           ms-pos23_0
           me-pos24_0
           state25_0)
    (let ((bstr-in_0 bstr-in22_0))
      (let ((ms-pos_2 ms-pos23_0))
        (let ((me-pos_2 me-pos24_0))
          (let ((state_44 state25_0))
            (let ((start-offset_0 start-offset18_0))
              (let ((start-pos_0 (if start-pos21_0 start-pos19_0 0)))
                (let ((string-offset_0
                       (lambda (pos_124)
                         (+
                          start-offset_0
                          (bytes-utf-8-length
                           bstr-in_0
                           '#\x3f
                           start-pos_0
                           pos_124)))))
                  (cons
                   (cons (string-offset_0 ms-pos_2) (string-offset_0 me-pos_2))
                   (if state_44
                     (let-values (((vec_7 len_18)
                                   (let ((vec_8 state_44))
                                     (begin
                                       (if (vector? vec_8)
                                         (void)
                                         (check-vector vec_8))
                                       (values
                                        vec_8
                                        (unsafe-vector-length vec_8))))))
                       (begin
                         #f
                         ((letrec ((for-loop_29
                                    (lambda (pos_31)
                                      (if (unsafe-fx< pos_31 len_18)
                                        (let ((p_9
                                               (unsafe-vector-ref
                                                vec_7
                                                pos_31)))
                                          (let ((post-guard-var_7
                                                 (lambda () #t)))
                                            (let ((elem_7
                                                   (if p_9
                                                     (cons
                                                      (string-offset_0
                                                       (car p_9))
                                                      (string-offset_0
                                                       (cdr p_9)))
                                                     #f)))
                                              (let ((result_47
                                                     (if (post-guard-var_7)
                                                       (for-loop_29
                                                        (unsafe-fx+ 1 pos_31))
                                                       null)))
                                                (cons elem_7 result_47)))))
                                        null))))
                            for-loop_29)
                          0)))
                     null)))))))))))
(define byte-positions->strings35.1
  (lambda (delta29_0 delta30_0 bstr-in31_0 ms-pos32_0 me-pos33_0 state34_0)
    (let ((bstr-in_1 bstr-in31_0))
      (let ((ms-pos_3 ms-pos32_0))
        (let ((me-pos_3 me-pos33_0))
          (let ((state_2 state34_0))
            (let ((delta_2 (if delta30_0 delta29_0 0)))
              (cons
               (bytes->string/utf-8
                bstr-in_1
                '#\x3f
                (+ ms-pos_3 delta_2)
                (+ me-pos_3 delta_2))
               (if state_2
                 (let-values (((vec_9 len_19)
                               (let ((vec_10 state_2))
                                 (begin
                                   (if (vector? vec_10)
                                     (void)
                                     (check-vector vec_10))
                                   (values
                                    vec_10
                                    (unsafe-vector-length vec_10))))))
                   (begin
                     #f
                     ((letrec ((for-loop_30
                                (lambda (pos_125)
                                  (if (unsafe-fx< pos_125 len_19)
                                    (let ((p_10
                                           (unsafe-vector-ref vec_9 pos_125)))
                                      (let ((post-guard-var_8 (lambda () #t)))
                                        (let ((elem_8
                                               (if p_10
                                                 (bytes->string/utf-8
                                                  bstr-in_1
                                                  '#\x3f
                                                  (+ (car p_10) delta_2)
                                                  (+ delta_2 (cdr p_10)))
                                                 #f)))
                                          (let ((result_48
                                                 (if (post-guard-var_8)
                                                   (for-loop_30
                                                    (unsafe-fx+ 1 pos_125))
                                                   null)))
                                            (cons elem_8 result_48)))))
                                    null))))
                        for-loop_30)
                      0)))
                 null)))))))))
(define add-end-bytes
  (lambda (results_0 end-bytes-count_0 bstr_14 me-pos_4)
    (if end-bytes-count_0
      (values
       results_0
       (if results_0
         (subbytes bstr_14 (max 0 (- me-pos_4 end-bytes-count_0)) me-pos_4)
         #f))
      results_0)))
(define interp
  (lambda (m_2 s_7 pos_6 start_54 limit/end_0 state_45)
    (|#%app| m_2 s_7 pos_6 start_54 limit/end_0 limit/end_0 state_45 null)))
(define search-match
  (lambda (rx_15 in_3 pos_6 start-pos_1 end-pos_0 state_45)
    (let ((must-string_0 (|#%app| rx:regexp-must-string rx_15)))
      (if (not (check-must-string must-string_0 in_3 pos_6 end-pos_0))
        (values #f #f)
        (let ((matcher_1 (|#%app| rx:regexp-matcher rx_15)))
          (let ((anchored?_0 (|#%app| rx:regexp-anchored? rx_15)))
            (let ((start-range_0 (|#%app| rx:regexp-start-range rx_15)))
              ((letrec ((loop_8
                         (lambda (pos_126)
                           (if (if anchored?_0
                                 (not (= pos_126 start-pos_1))
                                 #f)
                             (values #f #f)
                             (if (if start-range_0
                                   (if (bytes? in_3)
                                     (= pos_126 end-pos_0)
                                     (not
                                      (lazy-bytes-before-end?
                                       in_3
                                       pos_126
                                       end-pos_0)))
                                   #f)
                               (values #f #f)
                               (if (if start-range_0
                                     (not
                                      (check-start-range
                                       start-range_0
                                       in_3
                                       pos_126
                                       end-pos_0))
                                     #f)
                                 (loop_8 (add1 pos_126))
                                 (let ((pos2_1
                                        (interp
                                         matcher_1
                                         in_3
                                         pos_126
                                         start-pos_1
                                         end-pos_0
                                         state_45)))
                                   (if pos2_1
                                     (values pos_126 pos2_1)
                                     (if start-range_0
                                       (loop_8 (add1 pos_126))
                                       (if (if (bytes? in_3)
                                             (< pos_126 end-pos_0)
                                             (lazy-bytes-before-end?
                                              in_3
                                              pos_126
                                              end-pos_0))
                                         (let ((pos2_22 (add1 pos_126)))
                                           (begin
                                             (if (bytes? in_3)
                                               (void)
                                               (lazy-bytes-advance!
                                                in_3
                                                pos2_22
                                                #f))
                                             (loop_8 pos2_22)))
                                         (values #f #f)))))))))))
                 loop_8)
               pos_6))))))))
(define check-must-string
  (lambda (must-string_1 in_4 pos_12 end-pos_1)
    (if (not must-string_1)
      #t
      (if (not (bytes? in_4))
        #t
        (if (bytes? must-string_1)
          (if (= 1 (bytes-length must-string_1))
            (let ((mc_0 (bytes-ref must-string_1 0)))
              (let-values (((v*_14 start*_14 stop*_15 step*_14)
                            (normalise-inputs
                             'in-bytes
                             "bytes"
                             (lambda (x_52) (bytes? x_52))
                             (lambda (x_53) (unsafe-bytes-length x_53))
                             in_4
                             pos_12
                             end-pos_1
                             1)))
                (begin
                  #t
                  ((letrec ((for-loop_31
                             (lambda (result_49 idx_14)
                               (if (unsafe-fx< idx_14 stop*_15)
                                 (let ((c_13 (unsafe-bytes-ref v*_14 idx_14)))
                                   (let ((result_50
                                          (let ((result_51 (= c_13 mc_0)))
                                            (values result_51))))
                                     (if (if (not
                                              ((lambda x_54 result_50) c_13))
                                           (not #f)
                                           #f)
                                       (for-loop_31
                                        result_50
                                        (unsafe-fx+ idx_14 1))
                                       result_50)))
                                 result_49))))
                     for-loop_31)
                   #f
                   start*_14))))
            (let ((mc1_0 (bytes-ref must-string_1 0)))
              (let-values (((start_55) pos_12)
                           ((end_48)
                            (- end-pos_1 (sub1 (bytes-length must-string_1))))
                           ((inc_6) 1))
                (begin
                  (if (if (real? start_55)
                        (if (real? end_48) (real? inc_6) #f)
                        #f)
                    (void)
                    (check-range$1 start_55 end_48 inc_6))
                  ((letrec ((for-loop_32
                             (lambda (result_52 pos_127)
                               (if (< pos_127 end_48)
                                 (let ((i_13 pos_127))
                                   (let ((result_53
                                          (let ((result_54
                                                 (if (=
                                                      mc1_0
                                                      (bytes-ref in_4 i_13))
                                                   (let-values (((v*_15
                                                                  start*_15
                                                                  stop*_16
                                                                  step*_15)
                                                                 (normalise-inputs
                                                                  'in-bytes
                                                                  "bytes"
                                                                  (lambda (x_55)
                                                                    (bytes?
                                                                     x_55))
                                                                  (lambda (x_56)
                                                                    (unsafe-bytes-length
                                                                     x_56))
                                                                  in_4
                                                                  (add1 i_13)
                                                                  #f
                                                                  1))
                                                                ((v*_16
                                                                  start*_16
                                                                  stop*_17
                                                                  step*_16)
                                                                 (normalise-inputs
                                                                  'in-bytes
                                                                  "bytes"
                                                                  (lambda (x_57)
                                                                    (bytes?
                                                                     x_57))
                                                                  (lambda (x_58)
                                                                    (unsafe-bytes-length
                                                                     x_58))
                                                                  must-string_1
                                                                  1
                                                                  #f
                                                                  1)))
                                                     (begin
                                                       #t
                                                       #t
                                                       ((letrec ((for-loop_33
                                                                  (lambda (result_6
                                                                           idx_15
                                                                           idx_16)
                                                                    (if (if (unsafe-fx<
                                                                             idx_15
                                                                             stop*_16)
                                                                          (unsafe-fx<
                                                                           idx_16
                                                                           stop*_17)
                                                                          #f)
                                                                      (let-values (((c_14)
                                                                                    (unsafe-bytes-ref
                                                                                     v*_15
                                                                                     idx_15))
                                                                                   ((mc_1)
                                                                                    (unsafe-bytes-ref
                                                                                     v*_16
                                                                                     idx_16)))
                                                                        (let ((result_46
                                                                               (let ((result_55
                                                                                      (=
                                                                                       c_14
                                                                                       mc_1)))
                                                                                 (values
                                                                                  result_55))))
                                                                          (if (if (not
                                                                                   ((lambda x_2
                                                                                      (not
                                                                                       result_46))
                                                                                    c_14))
                                                                                (if (not
                                                                                     ((lambda x_59
                                                                                        (not
                                                                                         result_46))
                                                                                      mc_1))
                                                                                  (not
                                                                                   #f)
                                                                                  #f)
                                                                                #f)
                                                                            (for-loop_33
                                                                             result_46
                                                                             (unsafe-fx+
                                                                              idx_15
                                                                              1)
                                                                             (unsafe-fx+
                                                                              idx_16
                                                                              1))
                                                                            result_46)))
                                                                      result_6))))
                                                          for-loop_33)
                                                        #t
                                                        start*_15
                                                        start*_16)))
                                                   #f)))
                                            (values result_54))))
                                     (if (if (not
                                              ((lambda x_60 result_53) i_13))
                                           (not #f)
                                           #f)
                                       (for-loop_32
                                        result_53
                                        (+ pos_127 inc_6))
                                       result_53)))
                                 result_52))))
                     for-loop_32)
                   #f
                   start_55)))))
          (let-values (((start_56) pos_12)
                       ((end_49) (- end-pos_1 (sub1 (length must-string_1))))
                       ((inc_7) 1))
            (begin
              (if (if (real? start_56) (if (real? end_49) (real? inc_7) #f) #f)
                (void)
                (check-range$1 start_56 end_49 inc_7))
              ((letrec ((for-loop_34
                         (lambda (result_9 pos_128)
                           (if (< pos_128 end_49)
                             (let ((i_14 pos_128))
                               (let ((result_56
                                      (let ((result_57
                                             ((letrec ((loop_21
                                                        (lambda (i_15 l_16)
                                                          (if (null? l_16)
                                                            #t
                                                            (let ((e_0
                                                                   (car l_16)))
                                                              (if (rng-in?
                                                                   e_0
                                                                   (bytes-ref
                                                                    in_4
                                                                    i_15))
                                                                (loop_21
                                                                 (add1 i_15)
                                                                 (cdr l_16))
                                                                #f))))))
                                                loop_21)
                                              i_14
                                              must-string_1)))
                                        (values result_57))))
                                 (if (if (not ((lambda x_61 result_56) i_14))
                                       (not #f)
                                       #f)
                                   (for-loop_34 result_56 (+ pos_128 inc_7))
                                   result_56)))
                             result_9))))
                 for-loop_34)
               #f
               start_56))))))))
(define check-start-range
  (lambda (start-range_1 in_5 pos_54 end-pos_2)
    (rng-in?
     start-range_1
     (if (bytes? in_5) (bytes-ref in_5 pos_54) (lazy-bytes-ref in_5 pos_54)))))
(define FAST-STRING-LEN 64)
(define fast-drive-regexp-match?/bytes
  (lambda (rx_25 in_6 start-pos_2 end-pos_3)
    (let ((state_46
           (if (|#%app| rx:regexp-references? rx_25)
             (make-vector (|#%app| rx:regexp-num-groups rx_25) #f)
             #f)))
      (let-values (((ms-pos_0 me-pos_0)
                    (search-match
                     rx_25
                     in_6
                     start-pos_2
                     start-pos_2
                     (let ((or-part_15 end-pos_3))
                       (if or-part_15 or-part_15 (bytes-length in_6)))
                     state_46)))
        (if ms-pos_0 #t #f)))))
(define fast-drive-regexp-match?/string
  (lambda (rx_29 in-str_0 start-offset_1 end-offset_0)
    (let ((state_47
           (if (|#%app| rx:regexp-references? rx_29)
             (make-vector (|#%app| rx:regexp-num-groups rx_29) #f)
             #f)))
      (let ((in_7
             (string->bytes/utf-8
              in-str_0
              0
              start-offset_1
              (let ((or-part_64 end-offset_0))
                (if or-part_64 or-part_64 (string-length in-str_0))))))
        (let-values (((ms-pos_4 me-pos_5)
                      (search-match
                       rx_29
                       in_7
                       0
                       0
                       (bytes-length in_7)
                       state_47)))
          (if ms-pos_4 #t #f))))))
(define fast-drive-regexp-match-positions/bytes
  (lambda (rx_30 in_8 start-pos_3 end-pos_4)
    (let ((state_48
           (let ((n_31 (|#%app| rx:regexp-num-groups rx_30)))
             (if (positive? n_31) (make-vector n_31 #f) #f))))
      (let-values (((ms-pos_5 me-pos_6)
                    (search-match
                     rx_30
                     in_8
                     start-pos_3
                     start-pos_3
                     (let ((or-part_65 end-pos_4))
                       (if or-part_65 or-part_65 (bytes-length in_8)))
                     state_48)))
        (if ms-pos_5
          (if state_48
            (cons (cons ms-pos_5 me-pos_6) (vector->list state_48))
            (list (cons ms-pos_5 me-pos_6)))
          #f)))))
(define fast-drive-regexp-match-positions/string
  (lambda (rx_17 in-str_1 start-offset_2 end-offset_1)
    (let ((in_9
           (string->bytes/utf-8
            in-str_1
            0
            start-offset_2
            (let ((or-part_66 end-offset_1))
              (if or-part_66 or-part_66 (string-length in-str_1))))))
      (let ((state_49
             (let ((n_37 (|#%app| rx:regexp-num-groups rx_17)))
               (if (positive? n_37) (make-vector n_37 #f) #f))))
        (let-values (((ms-pos_6 me-pos_7)
                      (search-match
                       rx_17
                       in_9
                       0
                       0
                       (bytes-length in_9)
                       state_49)))
          (let ((string-offset_1
                 (lambda (pos_129)
                   (+
                    start-offset_2
                    (bytes-utf-8-length in_9 '#\x3f 0 pos_129)))))
            (if ms-pos_6
              (cons
               (cons (string-offset_1 ms-pos_6) (string-offset_1 me-pos_7))
               (if state_49
                 (let-values (((vec_11 len_20)
                               (let ((vec_12 state_49))
                                 (begin
                                   (if (vector? vec_12)
                                     (void)
                                     (check-vector vec_12))
                                   (values
                                    vec_12
                                    (unsafe-vector-length vec_12))))))
                   (begin
                     #f
                     ((letrec ((for-loop_35
                                (lambda (pos_130)
                                  (if (unsafe-fx< pos_130 len_20)
                                    (let ((p_11
                                           (unsafe-vector-ref vec_11 pos_130)))
                                      (let ((post-guard-var_9 (lambda () #t)))
                                        (let ((elem_9
                                               (if p_11
                                                 (cons
                                                  (string-offset_1 (car p_11))
                                                  (string-offset_1 (cdr p_11)))
                                                 #f)))
                                          (let ((result_58
                                                 (if (post-guard-var_9)
                                                   (for-loop_35
                                                    (unsafe-fx+ 1 pos_130))
                                                   null)))
                                            (cons elem_9 result_58)))))
                                    null))))
                        for-loop_35)
                      0)))
                 null))
              #f)))))))
(define fast-drive-regexp-match/bytes
  (lambda (rx_31 in_10 start-pos_4 end-pos_5)
    (let ((state_50
           (let ((n_38 (|#%app| rx:regexp-num-groups rx_31)))
             (if (positive? n_38) (make-vector n_38 #f) #f))))
      (let-values (((ms-pos_7 me-pos_8)
                    (search-match
                     rx_31
                     in_10
                     start-pos_4
                     start-pos_4
                     (let ((or-part_67 end-pos_5))
                       (if or-part_67 or-part_67 (bytes-length in_10)))
                     state_50)))
        (if ms-pos_7
          (cons
           (subbytes in_10 ms-pos_7 me-pos_8)
           (if state_50
             (let-values (((vec_13 len_21)
                           (let ((vec_14 state_50))
                             (begin
                               (if (vector? vec_14)
                                 (void)
                                 (check-vector vec_14))
                               (values
                                vec_14
                                (unsafe-vector-length vec_14))))))
               (begin
                 #f
                 ((letrec ((for-loop_36
                            (lambda (pos_131)
                              (if (unsafe-fx< pos_131 len_21)
                                (let ((p_12
                                       (unsafe-vector-ref vec_13 pos_131)))
                                  (let ((post-guard-var_10 (lambda () #t)))
                                    (let ((elem_10
                                           (if p_12
                                             (subbytes
                                              in_10
                                              (car p_12)
                                              (cdr p_12))
                                             #f)))
                                      (let ((result_59
                                             (if (post-guard-var_10)
                                               (for-loop_36
                                                (unsafe-fx+ 1 pos_131))
                                               null)))
                                        (cons elem_10 result_59)))))
                                null))))
                    for-loop_36)
                  0)))
             null))
          #f)))))
(define fast-drive-regexp-match/string
  (lambda (rx_32 in-str_2 start-offset_3 end-offset_2)
    (let ((in_11
           (string->bytes/utf-8
            in-str_2
            0
            start-offset_3
            (let ((or-part_68 end-offset_2))
              (if or-part_68 or-part_68 (string-length in-str_2))))))
      (let ((state_51
             (let ((n_39 (|#%app| rx:regexp-num-groups rx_32)))
               (if (positive? n_39) (make-vector n_39 #f) #f))))
        (let-values (((ms-pos_8 me-pos_9)
                      (search-match
                       rx_32
                       in_11
                       0
                       0
                       (bytes-length in_11)
                       state_51)))
          (if ms-pos_8
            (cons
             (bytes->string/utf-8 in_11 '#\x3f ms-pos_8 me-pos_9)
             (if state_51
               (let-values (((vec_15 len_22)
                             (let ((vec_16 state_51))
                               (begin
                                 (if (vector? vec_16)
                                   (void)
                                   (check-vector vec_16))
                                 (values
                                  vec_16
                                  (unsafe-vector-length vec_16))))))
                 (begin
                   #f
                   ((letrec ((for-loop_37
                              (lambda (pos_132)
                                (if (unsafe-fx< pos_132 len_22)
                                  (let ((p_13
                                         (unsafe-vector-ref vec_15 pos_132)))
                                    (let ((post-guard-var_11 (lambda () #t)))
                                      (let ((elem_11
                                             (if p_13
                                               (bytes->string/utf-8
                                                in_11
                                                '#\x3f
                                                (car p_13)
                                                (cdr p_13))
                                               #f)))
                                        (let ((result_60
                                               (if (post-guard-var_11)
                                                 (for-loop_37
                                                  (unsafe-fx+ 1 pos_132))
                                                 null)))
                                          (cons elem_11 result_60)))))
                                  null))))
                      for-loop_37)
                    0)))
               null))
            #f))))))
(define drive-regexp-match24.1
  (lambda (end-bytes-count8_0
           end-bytes-count16_0
           end-bytes?7_0
           end-bytes?15_0
           immediate-only?5_0
           immediate-only?13_0
           in-port-ok?3_0
           in-port-ok?11_0
           mode2_0
           peek?4_0
           peek?12_0
           progress-evt6_0
           progress-evt14_0
           search-offset1_0
           search-offset9_0
           who17_0
           orig-rx18_0
           in19_0
           orig-start-offset20_0
           orig-end-offset21_0
           out22_0
           prefix23_0)
    (let ((who_4 who17_0))
      (let ((orig-rx_0 orig-rx18_0))
        (let ((in_12 in19_0))
          (let ((orig-start-offset_0 orig-start-offset20_0))
            (let ((orig-end-offset_0 orig-end-offset21_0))
              (let ((out_3 out22_0))
                (let ((prefix_1 prefix23_0))
                  (let ((search-offset_0
                         (if search-offset9_0
                           search-offset1_0
                           orig-start-offset_0)))
                    (let ((mode_2 mode2_0))
                      (let ((in-port-ok?_0
                             (if in-port-ok?11_0 in-port-ok?3_0 #t)))
                        (let ((peek?_1 (if peek?12_0 peek?4_0 #f)))
                          (let ((immediate-only?_1
                                 (if immediate-only?13_0
                                   immediate-only?5_0
                                   #f)))
                            (let ((progress-evt_1
                                   (if progress-evt14_0 progress-evt6_0 #f)))
                              (let ((end-bytes?_0
                                     (if end-bytes?15_0 end-bytes?7_0 #f)))
                                (let ((end-bytes-count_1
                                       (if end-bytes-count16_0
                                         end-bytes-count8_0
                                         #f)))
                                  (let ((rx_33
                                         (if (|#%app| rx:regexp? orig-rx_0)
                                           orig-rx_0
                                           (if (string? orig-rx_0)
                                             (make-regexp
                                              who_4
                                              orig-rx_0
                                              #f
                                              #f
                                              #f)
                                             (if (bytes? orig-rx_0)
                                               (make-regexp
                                                who_4
                                                orig-rx_0
                                                #f
                                                #t
                                                #f)
                                               (raise-argument-error
                                                who_4
                                                "(or/c regexp? byte-regexp? string? bytes?)"
                                                orig-rx_0))))))
                                    (let-values ((()
                                                  (begin
                                                    (if (let ((or-part_69
                                                               (if (bytes?
                                                                    in_12)
                                                                 (not peek?_1)
                                                                 #f)))
                                                          (if or-part_69
                                                            or-part_69
                                                            (let ((or-part_70
                                                                   (if (string?
                                                                        in_12)
                                                                     (not
                                                                      peek?_1)
                                                                     #f)))
                                                              (if or-part_70
                                                                or-part_70
                                                                (if in-port-ok?_0
                                                                  (input-port?
                                                                   in_12)
                                                                  #f)))))
                                                      (void)
                                                      (raise-argument-error
                                                       who_4
                                                       (if peek?_1
                                                         "input-port?"
                                                         (if in-port-ok?_0
                                                           "(or/c bytes? string? input-port?)"
                                                           "(or/c bytes? string?)"))
                                                       in_12))
                                                    (values))))
                                      (let ((start-offset_4
                                             (if orig-start-offset_0
                                               (begin
                                                 (if (exact-nonnegative-integer?
                                                      orig-start-offset_0)
                                                   (void)
                                                   (raise-argument-error
                                                    who_4
                                                    "exact-nonnegative-integer?"
                                                    orig-start-offset_0))
                                                 (check-range
                                                  who_4
                                                  "starting index"
                                                  in_12
                                                  orig-start-offset_0
                                                  0)
                                                 orig-start-offset_0)
                                               0)))
                                        (let ((end-offset_3
                                               (if orig-end-offset_0
                                                 (begin
                                                   (if (exact-nonnegative-integer?
                                                        orig-end-offset_0)
                                                     (void)
                                                     (raise-argument-error
                                                      who_4
                                                      "(or/c #f exact-nonnegative-integer?)"
                                                      orig-end-offset_0))
                                                   (check-range
                                                    who_4
                                                    "ending index"
                                                    in_12
                                                    orig-end-offset_0
                                                    start-offset_4)
                                                   orig-end-offset_0)
                                                 (if (bytes? in_12)
                                                   (bytes-length in_12)
                                                   (if (string? in_12)
                                                     (string-length in_12)
                                                     'eof)))))
                                          (let-values ((()
                                                        (begin
                                                          (if (let ((or-part_71
                                                                     (not
                                                                      out_3)))
                                                                (if or-part_71
                                                                  or-part_71
                                                                  (output-port?
                                                                   out_3)))
                                                            (void)
                                                            (raise-argument-error
                                                             who_4
                                                             "(or/c #f output-port?)"
                                                             out_3))
                                                          (values))))
                                            (let-values ((()
                                                          (begin
                                                            (if (bytes?
                                                                 prefix_1)
                                                              (void)
                                                              (raise-argument-error
                                                               who_4
                                                               "bytes?"
                                                               prefix_1))
                                                            (values))))
                                              (let-values ((()
                                                            (begin
                                                              (if end-bytes?_0
                                                                (if (exact-nonnegative-integer?
                                                                     end-bytes-count_1)
                                                                  (void)
                                                                  (raise-argument-error
                                                                   who_4
                                                                   "exact-nonnegative-integer?"
                                                                   end-bytes-count_1))
                                                                (void))
                                                              (values))))
                                                (let ((state_52
                                                       (if (let ((or-part_72
                                                                  (not
                                                                   (eq?
                                                                    mode_2
                                                                    '?))))
                                                             (if or-part_72
                                                               or-part_72
                                                               (|#%app|
                                                                rx:regexp-references?
                                                                rx_33)))
                                                         (let ((n_40
                                                                (|#%app|
                                                                 rx:regexp-num-groups
                                                                 rx_33)))
                                                           (if (positive? n_40)
                                                             (make-vector
                                                              n_40
                                                              #f)
                                                             #f))
                                                         #f)))
                                                  (if (if (bytes? in_12)
                                                        (if (not out_3)
                                                          (equal? #vu8() prefix_1)
                                                          #f)
                                                        #f)
                                                    (let ((start-pos_5
                                                           start-offset_4))
                                                      (let ((search-pos_0
                                                             search-offset_0))
                                                        (let ((end-pos_6
                                                               end-offset_3))
                                                          (let-values (((ms-pos_9
                                                                         me-pos_10)
                                                                        (search-match
                                                                         rx_33
                                                                         in_12
                                                                         search-pos_0
                                                                         start-pos_5
                                                                         end-pos_6
                                                                         state_52)))
                                                            (begin
                                                              (if out_3
                                                                (write-bytes
                                                                 in_12
                                                                 out_3
                                                                 0
                                                                 (let ((or-part_73
                                                                        ms-pos_9))
                                                                   (if or-part_73
                                                                     or-part_73
                                                                     end-pos_6)))
                                                                (void))
                                                              (let ((tmp_32
                                                                     (if ms-pos_9
                                                                       mode_2
                                                                       #f)))
                                                                (if (equal?
                                                                     tmp_32
                                                                     #f)
                                                                  (add-end-bytes
                                                                   #f
                                                                   end-bytes-count_1
                                                                   #f
                                                                   #f)
                                                                  (if (equal?
                                                                       tmp_32
                                                                       '?)
                                                                    #t
                                                                    (if (equal?
                                                                         tmp_32
                                                                         'positions)
                                                                      (let ((positions_0
                                                                             (let-values (((ms-pos27_0)
                                                                                           ms-pos_9)
                                                                                          ((me-pos28_0)
                                                                                           me-pos_10)
                                                                                          ((state29_0)
                                                                                           state_52))
                                                                               (byte-positions->byte-positions6.1
                                                                                #f
                                                                                #f
                                                                                ms-pos27_0
                                                                                me-pos28_0
                                                                                state29_0))))
                                                                        (add-end-bytes
                                                                         positions_0
                                                                         end-bytes-count_1
                                                                         in_12
                                                                         me-pos_10))
                                                                      (if (equal?
                                                                           tmp_32
                                                                           'strings)
                                                                        (let ((bytess_0
                                                                               (let-values (((in30_0)
                                                                                             in_12)
                                                                                            ((ms-pos31_0)
                                                                                             ms-pos_9)
                                                                                            ((me-pos32_0)
                                                                                             me-pos_10)
                                                                                            ((state33_0)
                                                                                             state_52))
                                                                                 (byte-positions->bytess15.1
                                                                                  #f
                                                                                  #f
                                                                                  in30_0
                                                                                  ms-pos31_0
                                                                                  me-pos32_0
                                                                                  state33_0))))
                                                                          (add-end-bytes
                                                                           bytess_0
                                                                           end-bytes-count_1
                                                                           in_12
                                                                           me-pos_10))
                                                                        (void)))))))))))
                                                    (if (if (string? in_12)
                                                          (if (not out_3)
                                                            (if (equal?
                                                                 #vu8()
                                                                 prefix_1)
                                                              (<
                                                               (-
                                                                end-offset_3
                                                                start-offset_4)
                                                               FAST-STRING-LEN)
                                                              #f)
                                                            #f)
                                                          #f)
                                                      (let ((bstr-in_2
                                                             (string->bytes/utf-8
                                                              in_12
                                                              0
                                                              start-offset_4
                                                              end-offset_3)))
                                                        (let ((search-pos_1
                                                               (if (=
                                                                    start-offset_4
                                                                    search-offset_0)
                                                                 0
                                                                 (string-utf-8-length
                                                                  in_12
                                                                  start-offset_4
                                                                  search-offset_0))))
                                                          (let ((end-pos_7
                                                                 (bytes-length
                                                                  bstr-in_2)))
                                                            (let-values (((ms-pos_10
                                                                           me-pos_11)
                                                                          (search-match
                                                                           rx_33
                                                                           bstr-in_2
                                                                           search-pos_1
                                                                           0
                                                                           end-pos_7
                                                                           state_52)))
                                                              (begin
                                                                (if out_3
                                                                  (begin
                                                                    (write-string
                                                                     in_12
                                                                     out_3
                                                                     0
                                                                     start-offset_4)
                                                                    (write-bytes
                                                                     bstr-in_2
                                                                     out_3
                                                                     0
                                                                     (let ((or-part_74
                                                                            ms-pos_10))
                                                                       (if or-part_74
                                                                         or-part_74
                                                                         end-pos_7))))
                                                                  (void))
                                                                (let ((tmp_33
                                                                       (if ms-pos_10
                                                                         mode_2
                                                                         #f)))
                                                                  (if (equal?
                                                                       tmp_33
                                                                       #f)
                                                                    (add-end-bytes
                                                                     #f
                                                                     end-bytes-count_1
                                                                     #f
                                                                     #f)
                                                                    (if (equal?
                                                                         tmp_33
                                                                         '?)
                                                                      #t
                                                                      (if (equal?
                                                                           tmp_33
                                                                           'positions)
                                                                        (let ((positions_1
                                                                               (if (|#%app|
                                                                                    rx:regexp-bytes?
                                                                                    rx_33)
                                                                                 (let ((delta_3
                                                                                        (string-utf-8-length
                                                                                         in_12
                                                                                         0
                                                                                         start-offset_4)))
                                                                                   (let ((delta37_0
                                                                                          delta_3))
                                                                                     (byte-positions->byte-positions6.1
                                                                                      delta37_0
                                                                                      #t
                                                                                      ms-pos_10
                                                                                      me-pos_11
                                                                                      state_52)))
                                                                                 (let ((start-offset42_0
                                                                                        start-offset_4))
                                                                                   (byte-positions->string-positions26.1
                                                                                    start-offset42_0
                                                                                    #f
                                                                                    #f
                                                                                    bstr-in_2
                                                                                    ms-pos_10
                                                                                    me-pos_11
                                                                                    state_52)))))
                                                                          (add-end-bytes
                                                                           positions_1
                                                                           end-bytes-count_1
                                                                           bstr-in_2
                                                                           me-pos_11))
                                                                        (if (equal?
                                                                             tmp_33
                                                                             'strings)
                                                                          (let ((bytes/strings_0
                                                                                 (if (|#%app|
                                                                                      rx:regexp-bytes?
                                                                                      rx_33)
                                                                                   (let-values (((bstr-in43_0)
                                                                                                 bstr-in_2)
                                                                                                ((ms-pos44_0)
                                                                                                 ms-pos_10)
                                                                                                ((me-pos45_0)
                                                                                                 me-pos_11)
                                                                                                ((state46_0)
                                                                                                 state_52))
                                                                                     (byte-positions->bytess15.1
                                                                                      #f
                                                                                      #f
                                                                                      bstr-in43_0
                                                                                      ms-pos44_0
                                                                                      me-pos45_0
                                                                                      state46_0))
                                                                                   (let-values (((bstr-in47_0)
                                                                                                 bstr-in_2)
                                                                                                ((ms-pos48_0)
                                                                                                 ms-pos_10)
                                                                                                ((me-pos49_0)
                                                                                                 me-pos_11)
                                                                                                ((state50_0)
                                                                                                 state_52))
                                                                                     (byte-positions->strings35.1
                                                                                      #f
                                                                                      #f
                                                                                      bstr-in47_0
                                                                                      ms-pos48_0
                                                                                      me-pos49_0
                                                                                      state50_0)))))
                                                                            (add-end-bytes
                                                                             bytes/strings_0
                                                                             end-bytes-count_1
                                                                             bstr-in_2
                                                                             me-pos_11))
                                                                          (void)))))))))))
                                                      (let ((prefix-len_1
                                                             (bytes-length
                                                              prefix_1)))
                                                        (let ((start-pos_6
                                                               prefix-len_1))
                                                          (let ((search-pos_2
                                                                 (if (=
                                                                      start-offset_4
                                                                      search-offset_0)
                                                                   start-pos_6
                                                                   (+
                                                                    start-pos_6
                                                                    (if (string?
                                                                         in_12)
                                                                      (string-utf-8-length
                                                                       in_12
                                                                       start-offset_4
                                                                       search-offset_0)
                                                                      (-
                                                                       search-offset_0
                                                                       start-offset_4))))))
                                                            (let ((port-in_0
                                                                   (if (bytes?
                                                                        in_12)
                                                                     (open-input-bytes/no-copy
                                                                      in_12
                                                                      start-offset_4
                                                                      end-offset_3)
                                                                     (if (string?
                                                                          in_12)
                                                                       (open-input-string/lazy
                                                                        in_12
                                                                        start-offset_4
                                                                        end-offset_3)
                                                                       in_12))))
                                                              (let-values ((()
                                                                            (begin
                                                                              (if (if (not
                                                                                       peek?_1)
                                                                                    (positive?
                                                                                     start-offset_4)
                                                                                    #f)
                                                                                (if (bytes?
                                                                                     in_12)
                                                                                  (if out_3
                                                                                    (write-bytes
                                                                                     in_12
                                                                                     out_3
                                                                                     0
                                                                                     start-offset_4)
                                                                                    (void))
                                                                                  (if (string?
                                                                                       in_12)
                                                                                    (if out_3
                                                                                      (write-string
                                                                                       in_12
                                                                                       out_3
                                                                                       0
                                                                                       start-offset_4)
                                                                                      (void))
                                                                                    (if (input-port?
                                                                                         in_12)
                                                                                      (copy-port-bytes
                                                                                       port-in_0
                                                                                       out_3
                                                                                       start-offset_4)
                                                                                      (void))))
                                                                                (void))
                                                                              (values))))
                                                                (let ((lb-in_0
                                                                       (make-lazy-bytes
                                                                        port-in_0
                                                                        (if peek?_1
                                                                          start-offset_4
                                                                          0)
                                                                        prefix_1
                                                                        peek?_1
                                                                        immediate-only?_1
                                                                        progress-evt_1
                                                                        out_3
                                                                        (|#%app|
                                                                         rx:regexp-max-lookbehind
                                                                         rx_33))))
                                                                  (let ((end-pos_8
                                                                         (if (eq?
                                                                              'eof
                                                                              end-offset_3)
                                                                           'eof
                                                                           (+
                                                                            start-pos_6
                                                                            (if (string?
                                                                                 in_12)
                                                                              (string-utf-8-length
                                                                               in_12
                                                                               start-offset_4
                                                                               end-offset_3)
                                                                              (-
                                                                               end-offset_3
                                                                               start-offset_4))))))
                                                                    (let-values (((ms-pos_11
                                                                                   me-pos_12)
                                                                                  (search-match
                                                                                   rx_33
                                                                                   lb-in_0
                                                                                   search-pos_2
                                                                                   0
                                                                                   end-pos_8
                                                                                   state_52)))
                                                                      (let ((write/consume-skipped_0
                                                                             (lambda ()
                                                                               (if (not
                                                                                    peek?_1)
                                                                                 (if ms-pos_11
                                                                                   (if (let ((or-part_75
                                                                                              out_3))
                                                                                         (if or-part_75
                                                                                           or-part_75
                                                                                           (input-port?
                                                                                            in_12)))
                                                                                     (begin
                                                                                       (lazy-bytes-advance!
                                                                                        lb-in_0
                                                                                        ms-pos_11
                                                                                        #t)
                                                                                       (copy-port-bytes
                                                                                        port-in_0
                                                                                        #f
                                                                                        (-
                                                                                         me-pos_12
                                                                                         ms-pos_11)))
                                                                                     (void))
                                                                                   (if (eq?
                                                                                        end-pos_8
                                                                                        'eof)
                                                                                     (copy-port-bytes
                                                                                      port-in_0
                                                                                      out_3
                                                                                      #f)
                                                                                     (if (let ((or-part_76
                                                                                                out_3))
                                                                                           (if or-part_76
                                                                                             or-part_76
                                                                                             (input-port?
                                                                                              in_12)))
                                                                                       (lazy-bytes-advance!
                                                                                        lb-in_0
                                                                                        end-pos_8
                                                                                        #t)
                                                                                       (void))))
                                                                                 (void)))))
                                                                        (begin0
                                                                          (let ((tmp_34
                                                                                 (if ms-pos_11
                                                                                   (if (not
                                                                                        (|#%app|
                                                                                         lazy-bytes-failed?
                                                                                         lb-in_0))
                                                                                     mode_2
                                                                                     #f)
                                                                                   #f)))
                                                                            (if (equal?
                                                                                 tmp_34
                                                                                 #f)
                                                                              (add-end-bytes
                                                                               #f
                                                                               end-bytes-count_1
                                                                               #f
                                                                               #f)
                                                                              (if (equal?
                                                                                   tmp_34
                                                                                   '?)
                                                                                #t
                                                                                (if (equal?
                                                                                     tmp_34
                                                                                     'positions)
                                                                                  (let ((bstr_15
                                                                                         (|#%app|
                                                                                          lazy-bytes-bstr
                                                                                          lb-in_0)))
                                                                                    (let ((positions_2
                                                                                           (if (let ((or-part_77
                                                                                                      (not
                                                                                                       (string?
                                                                                                        in_12))))
                                                                                                 (if or-part_77
                                                                                                   or-part_77
                                                                                                   (|#%app|
                                                                                                    rx:regexp-bytes?
                                                                                                    rx_33)))
                                                                                             (let ((delta_4
                                                                                                    (-
                                                                                                     start-offset_4
                                                                                                     start-pos_6)))
                                                                                               (let ((delta54_0
                                                                                                      delta_4))
                                                                                                 (byte-positions->byte-positions6.1
                                                                                                  delta54_0
                                                                                                  #t
                                                                                                  ms-pos_11
                                                                                                  me-pos_12
                                                                                                  state_52)))
                                                                                             (let-values (((start-pos59_0)
                                                                                                           start-pos_6)
                                                                                                          ((start-offset60_0)
                                                                                                           start-offset_4))
                                                                                               (byte-positions->string-positions26.1
                                                                                                start-offset60_0
                                                                                                start-pos59_0
                                                                                                #t
                                                                                                bstr_15
                                                                                                ms-pos_11
                                                                                                me-pos_12
                                                                                                state_52)))))
                                                                                      (add-end-bytes
                                                                                       positions_2
                                                                                       end-bytes-count_1
                                                                                       bstr_15
                                                                                       me-pos_12)))
                                                                                  (if (equal?
                                                                                       tmp_34
                                                                                       'strings)
                                                                                    (let ((bstr_16
                                                                                           (|#%app|
                                                                                            lazy-bytes-bstr
                                                                                            lb-in_0)))
                                                                                      (let ((delta_5
                                                                                             (|#%app|
                                                                                              lazy-bytes-discarded-count
                                                                                              lb-in_0)))
                                                                                        (let ((bytes/strings_1
                                                                                               (if (let ((or-part_78
                                                                                                          (not
                                                                                                           (string?
                                                                                                            in_12))))
                                                                                                     (if or-part_78
                                                                                                       or-part_78
                                                                                                       (|#%app|
                                                                                                        rx:regexp-bytes?
                                                                                                        rx_33)))
                                                                                                 (let ((delta65_0
                                                                                                        delta_5))
                                                                                                   (byte-positions->bytess15.1
                                                                                                    delta65_0
                                                                                                    #t
                                                                                                    bstr_16
                                                                                                    ms-pos_11
                                                                                                    me-pos_12
                                                                                                    state_52))
                                                                                                 (let ((delta70_0
                                                                                                        delta_5))
                                                                                                   (byte-positions->strings35.1
                                                                                                    delta70_0
                                                                                                    #t
                                                                                                    bstr_16
                                                                                                    ms-pos_11
                                                                                                    me-pos_12
                                                                                                    state_52)))))
                                                                                          (add-end-bytes
                                                                                           bytes/strings_1
                                                                                           end-bytes-count_1
                                                                                           bstr_16
                                                                                           me-pos_12))))
                                                                                    (void))))))
                                                                          (write/consume-skipped_0))))))))))))))))))))))))))))))))))))))
(define check-range
  (lambda (who_5 what_1 in_13 pos_133 start-pos_7)
    (let ((len_23
           (if (bytes? in_13)
             (bytes-length in_13)
             (if (string? in_13) (string-length in_13) +inf.0))))
      (begin
        (if (>= pos_133 start-pos_7)
          (void)
          (raise-arguments-error
           who_5
           (format "~a is smaller than starting index" what_1)
           what_1
           pos_133
           "starting index"
           start-pos_7))
        (if (<= pos_133 len_23)
          (void)
          (raise-arguments-error
           who_5
           (format "~a is out of range" what_1)
           what_1
           pos_133))))))
(define chytes-ref
  (lambda (s_4 pos_1)
    (if (bytes? s_4)
      (bytes-ref s_4 pos_1)
      (char->integer (string-ref s_4 pos_1)))))
(define subchytes
  (let ((subchytes5_0
         (lambda (s3_0 a4_0 b1_0 b2_0)
           (let ((s_95 s3_0))
             (let ((a_5 a4_0))
               (let ((b_12 (if b2_0 b1_0 #f)))
                 (if (bytes? s_95)
                   (subbytes
                    s_95
                    a_5
                    (let ((or-part_25 b_12))
                      (if or-part_25 or-part_25 (bytes-length s_95))))
                   (substring
                    s_95
                    a_5
                    (let ((or-part_14 b_12))
                      (if or-part_14 or-part_14 (string-length s_95)))))))))))
    (case-lambda
     ((s_96 a_6) (subchytes5_0 s_96 a_6 #f #f))
     ((s_6 a_4 b1_1) (subchytes5_0 s_6 a_4 b1_1 #t)))))
(define chytes-append
  (case-lambda
   ((a_7) a_7)
   ((a_8 b_13)
    (if (bytes? a_8) (bytes-append a_8 b_13) (string-append a_8 b_13)))
   ((a_9 b_14 c_15)
    (if (bytes? a_9)
      (bytes-append a_9 b_14 c_15)
      (string-append a_9 b_14 c_15)))
   ((a_10 . l_17)
    (if (bytes? a_10)
      (apply bytes-append a_10 l_17)
      (apply string-append a_10 l_17)))))
(define chytes?
  (lambda (ex_0 v_23) (if (bytes? ex_0) (bytes? v_23) (string? v_23))))
(define chytes-length
  (lambda (s_97) (if (bytes? s_97) (bytes-length s_97) (string-length s_97))))
(define 1/regexp-replace
  (let ((regexp-replace6_0
         (lambda (rx3_1 orig-in4_0 insert5_0 prefix1_0 prefix2_0)
           (let ((rx_3 rx3_1))
             (let ((orig-in_0 orig-in4_0))
               (let ((insert_0 insert5_0))
                 (let ((prefix_2 (if prefix2_0 prefix1_0 #vu8())))
                   (do-regexp-replace
                    'regexp-replace
                    rx_3
                    orig-in_0
                    insert_0
                    prefix_2
                    #f))))))))
    (case-lambda
     ((rx_16 orig-in_1 insert_1)
      (regexp-replace6_0 rx_16 orig-in_1 insert_1 #f #f))
     ((rx_29 orig-in_2 insert_2 prefix1_1)
      (regexp-replace6_0 rx_29 orig-in_2 insert_2 prefix1_1 #t)))))
(define 1/regexp-replace*
  (let ((regexp-replace*13_0
         (lambda (rx10_1 orig-in11_0 insert12_0 prefix8_0 prefix9_0)
           (let ((rx_34 rx10_1))
             (let ((orig-in_3 orig-in11_0))
               (let ((insert_3 insert12_0))
                 (let ((prefix_3 (if prefix9_0 prefix8_0 #vu8())))
                   (do-regexp-replace
                    'regexp-replace*
                    rx_34
                    orig-in_3
                    insert_3
                    prefix_3
                    #t))))))))
    (case-lambda
     ((rx_23 orig-in_4 insert_4)
      (regexp-replace*13_0 rx_23 orig-in_4 insert_4 #f #f))
     ((rx_35 orig-in_5 insert_5 prefix8_1)
      (regexp-replace*13_0 rx_35 orig-in_5 insert_5 prefix8_1 #t)))))
(define do-regexp-replace
  (lambda (who_6 rx-in_0 orig-in_6 insert_6 prefix_4 all?_0)
    (let ((string-mode?_0
           (if (let ((or-part_79 (string? rx-in_0)))
                 (if or-part_79 or-part_79 (1/regexp? rx-in_0)))
             (string? orig-in_6)
             #f)))
      (let ((in_14
             (if (if (not string-mode?_0) (string? orig-in_6) #f)
               (string->bytes/utf-8 orig-in_6)
               orig-in_6)))
        (let-values ((()
                      (begin
                        (if (let ((or-part_80 string-mode?_0))
                              (if or-part_80
                                or-part_80
                                (if (let ((or-part_81 (bytes? rx-in_0)))
                                      (if or-part_81
                                        or-part_81
                                        (1/byte-regexp? rx-in_0)))
                                  (let ((or-part_82 (string? orig-in_6)))
                                    (if or-part_82
                                      or-part_82
                                      (bytes? orig-in_6)))
                                  #f)))
                          (if (let ((or-part_83 (string? insert_6)))
                                (if or-part_83
                                  or-part_83
                                  (let ((or-part_84 (bytes? insert_6)))
                                    (if or-part_84
                                      or-part_84
                                      (procedure? insert_6)))))
                            (void)
                            (raise-argument-error
                             who_6
                             "(or/c string? bytes? procedure?)"
                             insert_6))
                          (void))
                        (values))))
          (let-values ((()
                        (begin
                          (if string-mode?_0
                            (if (bytes? insert_6)
                              (raise-arguments-error
                               who_6
                               "cannot replace a string with a byte string"
                               "byte string"
                               insert_6)
                              (void))
                            (void))
                          (values))))
            (let ((rx_36
                   (if (string? rx-in_0)
                     (make-regexp who_6 rx-in_0 #f #f #f)
                     (if (bytes? rx-in_0)
                       (make-regexp who_6 rx-in_0 #f #t #f)
                       rx-in_0))))
              (let ((ins_0
                     (if (if (not string-mode?_0) (string? insert_6) #f)
                       (string->bytes/utf-8 insert_6)
                       insert_6)))
                ((letrec ((loop_22
                           (lambda (search-pos_3)
                             (let ((poss_0
                                    (let-values (((temp18_0) 0)
                                                 ((search-pos19_0)
                                                  search-pos_3)
                                                 ((temp20_0) #f)
                                                 ((temp21_0) #f)
                                                 ((prefix22_0) prefix_4)
                                                 ((temp23_0) #f)
                                                 ((temp24_1) 'positions))
                                      (drive-regexp-match24.1
                                       #f
                                       #f
                                       #f
                                       #f
                                       #f
                                       #f
                                       temp23_0
                                       #t
                                       temp24_1
                                       #f
                                       #f
                                       #f
                                       #f
                                       search-pos19_0
                                       #t
                                       who_6
                                       rx_36
                                       in_14
                                       temp18_0
                                       temp20_0
                                       temp21_0
                                       prefix22_0))))
                               (let ((recur_0
                                      (lambda ()
                                        (let ((pos_134 (cdar poss_0)))
                                          (if (= pos_134 search-pos_3)
                                            (if (=
                                                 search-pos_3
                                                 (chytes-length in_14))
                                              (subchytes in_14 0 0)
                                              (chytes-append
                                               (subchytes
                                                in_14
                                                search-pos_3
                                                (add1 search-pos_3))
                                               (loop_22 (add1 search-pos_3))))
                                            (loop_22 (cdar poss_0)))))))
                                 (if (not poss_0)
                                   (if (zero? search-pos_3)
                                     in_14
                                     (subchytes in_14 search-pos_3))
                                   (chytes-append
                                    (subchytes
                                     in_14
                                     search-pos_3
                                     (caar poss_0))
                                    (replacements who_6 in_14 poss_0 ins_0)
                                    (if all?_0
                                      (recur_0)
                                      (subchytes in_14 (cdar poss_0))))))))))
                   loop_22)
                 0)))))))))
(define replacements
  (lambda (who_7 in_15 poss_1 insert_7)
    (if (procedure? insert_7)
      (let ((a_11
             (apply
              insert_7
              (let ((lst_20 poss_1))
                (begin
                  (if (list? lst_20) (void) (check-list lst_20))
                  ((letrec ((for-loop_38
                             (lambda (lst_21)
                               (if (pair? lst_21)
                                 (let-values (((pos_135) (unsafe-car lst_21))
                                              ((rest_10) (unsafe-cdr lst_21)))
                                   (let ((post-guard-var_12 (lambda () #t)))
                                     (let ((elem_12
                                            (subchytes
                                             in_15
                                             (car pos_135)
                                             (cdr pos_135))))
                                       (let ((result_61
                                              (if (post-guard-var_12)
                                                (for-loop_38 rest_10)
                                                null)))
                                         (cons elem_12 result_61)))))
                                 null))))
                     for-loop_38)
                   lst_20))))))
        (begin
          (if (chytes? in_15 a_11)
            (void)
            (raise-result-error
             who_7
             (if (bytes? in_15) "bytes?" "string?")
             a_11))
          a_11))
      (let ((count_0 (length poss_1)))
        (let ((get-chytes_0
               (lambda (n_39)
                 (if (< n_39 count_0)
                   (let ((pos_26 (list-ref poss_1 n_39)))
                     (subchytes in_15 (car pos_26) (cdr pos_26)))
                   (subchytes in_15 0 0)))))
          (let ((cons-chytes_0
                 (lambda (since_0 pos_136 l_18)
                   (if (= since_0 pos_136)
                     l_18
                     (cons (subchytes insert_7 since_0 pos_136) l_18)))))
            (let ((len_24 (chytes-length insert_7)))
              (apply
               (if (bytes? insert_7) bytes-append string-append)
               ((letrec ((loop_23
                          (lambda (pos_54 since_1)
                            (if (= pos_54 len_24)
                              (cons-chytes_0 since_1 pos_54 null)
                              (if (=
                                   (char->integer '#\x26)
                                   (chytes-ref insert_7 pos_54))
                                (cons-chytes_0
                                 since_1
                                 pos_54
                                 (cons
                                  (get-chytes_0 0)
                                  (loop_23 (add1 pos_54) (add1 pos_54))))
                                (if (=
                                     (char->integer '#\x5c)
                                     (chytes-ref insert_7 pos_54))
                                  (cons-chytes_0
                                   since_1
                                   pos_54
                                   (let ((c_16
                                          (if (< (add1 pos_54) len_24)
                                            (chytes-ref insert_7 (add1 pos_54))
                                            #f)))
                                     (if (let ((or-part_85
                                                (eq?
                                                 c_16
                                                 (char->integer '#\x26))))
                                           (if or-part_85
                                             or-part_85
                                             (eq?
                                              c_16
                                              (char->integer '#\x5c))))
                                       (loop_23 (+ pos_54 2) (add1 pos_54))
                                       (if (eq? c_16 (char->integer '#\x24))
                                         (loop_23 (+ pos_54 2) (+ pos_54 2))
                                         ((letrec ((d-loop_0
                                                    (lambda (pos_28 accum_5)
                                                      (if (= pos_28 len_24)
                                                        (list
                                                         (get-chytes_0
                                                          accum_5))
                                                        (let ((c_17
                                                               (chytes-ref
                                                                insert_7
                                                                pos_28)))
                                                          (if (if (eq?
                                                                   c_17
                                                                   (char->integer
                                                                    '#\x30))
                                                                (eq?
                                                                 c_17
                                                                 (char->integer
                                                                  '#\x39))
                                                                #f)
                                                            (d-loop_0
                                                             (add1 pos_28)
                                                             (+
                                                              (* accum_5 10)
                                                              (-
                                                               c_17
                                                               (char->integer
                                                                '#\x30))))
                                                            (cons
                                                             (get-chytes_0
                                                              accum_5)
                                                             (loop_23
                                                              pos_28
                                                              pos_28))))))))
                                            d-loop_0)
                                          (add1 pos_54)
                                          0)))))
                                  (loop_23 (add1 pos_54) since_1)))))))
                  loop_23)
                0
                0)))))))))
(define 1/regexp
  (let ((regexp4_0
         (lambda (p3_1 handler1_0 handler2_0)
           (let ((p_14 p3_1))
             (let ((handler_1 (if handler2_0 handler1_0 #f)))
               (begin
                 (if (string? p_14)
                   (void)
                   (raise-argument-error 'regexp "string?" p_14))
                 (make-regexp 'regexp p_14 #f #f handler_1)))))))
    (case-lambda
     ((p_15) (regexp4_0 p_15 #f #f))
     ((p_16 handler1_1) (regexp4_0 p_16 handler1_1 #t)))))
(define 1/byte-regexp
  (let ((byte-regexp9_0
         (lambda (p8_0 handler6_0 handler7_0)
           (let ((p_17 p8_0))
             (let ((handler_2 (if handler7_0 handler6_0 #f)))
               (begin
                 (if (bytes? p_17)
                   (void)
                   (raise-argument-error 'byte-regexp "bytes?" p_17))
                 (make-regexp 'byte-regexp p_17 #f #t handler_2)))))))
    (case-lambda
     ((p_18) (byte-regexp9_0 p_18 #f #f))
     ((p_19 handler6_1) (byte-regexp9_0 p_19 handler6_1 #t)))))
(define 1/pregexp
  (let ((pregexp14_0
         (lambda (p13_0 handler11_0 handler12_0)
           (let ((p_20 p13_0))
             (let ((handler_3 (if handler12_0 handler11_0 #f)))
               (begin
                 (if (string? p_20)
                   (void)
                   (raise-argument-error 'pregexp "string?" p_20))
                 (make-regexp 'pregexp p_20 #t #f handler_3)))))))
    (case-lambda
     ((p_21) (pregexp14_0 p_21 #f #f))
     ((p_22 handler11_1) (pregexp14_0 p_22 handler11_1 #t)))))
(define 1/byte-pregexp
  (let ((byte-pregexp19_0
         (lambda (p18_0 handler16_0 handler17_0)
           (let ((p_23 p18_0))
             (let ((handler_4 (if handler17_0 handler16_0 #f)))
               (begin
                 (if (bytes? p_23)
                   (void)
                   (raise-argument-error 'byte-pregexp "bytes?" p_23))
                 (make-regexp 'byte-pregexp p_23 #t #t handler_4)))))))
    (case-lambda
     ((p_24) (byte-pregexp19_0 p_24 #f #f))
     ((p_25 handler16_1) (byte-pregexp19_0 p_25 handler16_1 #t)))))
(define 1/regexp-max-lookbehind
  (lambda (rx_37)
    (begin
      (if (let ((or-part_3 (1/regexp? rx_37)))
            (if or-part_3 or-part_3 (1/byte-regexp? rx_37)))
        (void)
        (raise-argument-error
         'regexp-max-lookbehind
         "(or regexp? byte-regexp?)"
         rx_37))
      (|#%app| rx:regexp-max-lookbehind rx_37))))
(define no-prefix #vu8())
(define fast-bytes?
  (lambda (rx_26 in_16 start-pos_8 end-pos_9 out_4 prefix_5)
    (if (1/byte-regexp? rx_26)
      (if (bytes? in_16)
        (if (exact-nonnegative-integer? start-pos_8)
          (if (let ((len_20 (bytes-length in_16)))
                (if (<= start-pos_8 len_20)
                  (let ((or-part_80 (not end-pos_9)))
                    (if or-part_80
                      or-part_80
                      (if (exact-nonnegative-integer? end-pos_9)
                        (if (<= end-pos_9 len_20)
                          (>= end-pos_9 start-pos_8)
                          #f)
                        #f)))
                  #f))
            (if (not out_4) (eq? prefix_5 no-prefix) #f)
            #f)
          #f)
        #f)
      #f)))
(define fast-string?
  (lambda (rx_4 in_17 start-pos_9 end-pos_10 out_5 prefix_6)
    (if (1/regexp? rx_4)
      (if (string? in_17)
        (if (exact-nonnegative-integer? start-pos_9)
          (if (let ((len_25 (string-length in_17)))
                (if (< len_25 FAST-STRING-LEN)
                  (if (<= start-pos_9 len_25)
                    (let ((or-part_86 (not end-pos_10)))
                      (if or-part_86
                        or-part_86
                        (if (exact-nonnegative-integer? end-pos_10)
                          (if (<= end-pos_10 len_25)
                            (>= end-pos_10 start-pos_9)
                            #f)
                          #f)))
                    #f)
                  #f))
            (if (not out_5) (eq? prefix_6 no-prefix) #f)
            #f)
          #f)
        #f)
      #f)))
(define 1/regexp-match?
  (let ((regexp-match?31_0
         (lambda (rx29_0
                  in30_1
                  start-pos21_1
                  end-pos22_0
                  out23_0
                  prefix24_0
                  start-pos25_0
                  end-pos26_0
                  out27_0
                  prefix28_0)
           (let ((rx_38 rx29_0))
             (let ((in_18 in30_1))
               (let ((start-pos_10 (if start-pos25_0 start-pos21_1 0)))
                 (let ((end-pos_11 (if end-pos26_0 end-pos22_0 #f)))
                   (let ((out_6 (if out27_0 out23_0 #f)))
                     (let ((prefix_7 (if prefix28_0 prefix24_0 no-prefix)))
                       (if (fast-bytes?
                            rx_38
                            in_18
                            start-pos_10
                            end-pos_11
                            out_6
                            prefix_7)
                         (fast-drive-regexp-match?/bytes
                          rx_38
                          in_18
                          start-pos_10
                          end-pos_11)
                         (if (fast-string?
                              rx_38
                              in_18
                              start-pos_10
                              end-pos_11
                              out_6
                              prefix_7)
                           (fast-drive-regexp-match?/string
                            rx_38
                            in_18
                            start-pos_10
                            end-pos_11)
                           (let-values (((temp161_0) 'regexp-match?)
                                        ((rx162_0) rx_38)
                                        ((in163_0) in_18)
                                        ((start-pos164_0) start-pos_10)
                                        ((end-pos165_0) end-pos_11)
                                        ((out166_0) out_6)
                                        ((prefix167_0) prefix_7)
                                        ((temp168_0) '?))
                             (drive-regexp-match24.1
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              temp168_0
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              temp161_0
                              rx162_0
                              in163_0
                              start-pos164_0
                              end-pos165_0
                              out166_0
                              prefix167_0)))))))))))))
    (case-lambda
     ((rx_39 in_19) (regexp-match?31_0 rx_39 in_19 #f #f #f #f #f #f #f #f))
     ((rx_40 in_20 start-pos_11 end-pos_12 out_7 prefix24_1)
      (regexp-match?31_0
       rx_40
       in_20
       start-pos_11
       end-pos_12
       out_7
       prefix24_1
       #t
       #t
       #t
       #t))
     ((rx_41 in_21 start-pos_12 end-pos_13 out23_1)
      (regexp-match?31_0
       rx_41
       in_21
       start-pos_12
       end-pos_13
       out23_1
       #f
       #t
       #t
       #t
       #f))
     ((rx_42 in_22 start-pos_13 end-pos22_1)
      (regexp-match?31_0
       rx_42
       in_22
       start-pos_13
       end-pos22_1
       #f
       #f
       #t
       #t
       #f
       #f))
     ((rx_43 in_23 start-pos21_0)
      (regexp-match?31_0 rx_43 in_23 start-pos21_0 #f #f #f #t #f #f #f)))))
(define 1/regexp-match-positions
  (let ((regexp-match-positions43_0
         (lambda (rx41_0
                  in42_0
                  start-pos33_0
                  end-pos34_0
                  out35_0
                  prefix36_0
                  start-pos37_0
                  end-pos38_0
                  out39_0
                  prefix40_0)
           (let ((rx_44 rx41_0))
             (let ((in_24 in42_0))
               (let ((start-pos_14 (if start-pos37_0 start-pos33_0 0)))
                 (let ((end-pos_14 (if end-pos38_0 end-pos34_0 #f)))
                   (let ((out_8 (if out39_0 out35_0 #f)))
                     (let ((prefix_8 (if prefix40_0 prefix36_0 no-prefix)))
                       (if (fast-bytes?
                            rx_44
                            in_24
                            start-pos_14
                            end-pos_14
                            out_8
                            prefix_8)
                         (fast-drive-regexp-match-positions/bytes
                          rx_44
                          in_24
                          start-pos_14
                          end-pos_14)
                         (if (fast-string?
                              rx_44
                              in_24
                              start-pos_14
                              end-pos_14
                              out_8
                              prefix_8)
                           (fast-drive-regexp-match-positions/string
                            rx_44
                            in_24
                            start-pos_14
                            end-pos_14)
                           (let-values (((temp169_0) 'regexp-match-positions)
                                        ((rx170_0) rx_44)
                                        ((in171_0) in_24)
                                        ((start-pos172_0) start-pos_14)
                                        ((end-pos173_0) end-pos_14)
                                        ((out174_0) out_8)
                                        ((prefix175_0) prefix_8)
                                        ((temp176_0) 'positions))
                             (drive-regexp-match24.1
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              temp176_0
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              temp169_0
                              rx170_0
                              in171_0
                              start-pos172_0
                              end-pos173_0
                              out174_0
                              prefix175_0)))))))))))))
    (case-lambda
     ((rx_45 in_25)
      (regexp-match-positions43_0 rx_45 in_25 #f #f #f #f #f #f #f #f))
     ((rx_46 in_26 start-pos_15 end-pos_15 out_9 prefix36_1)
      (regexp-match-positions43_0
       rx_46
       in_26
       start-pos_15
       end-pos_15
       out_9
       prefix36_1
       #t
       #t
       #t
       #t))
     ((rx_7 in_27 start-pos_16 end-pos_16 out35_1)
      (regexp-match-positions43_0
       rx_7
       in_27
       start-pos_16
       end-pos_16
       out35_1
       #f
       #t
       #t
       #t
       #f))
     ((rx_47 in_28 start-pos_17 end-pos34_1)
      (regexp-match-positions43_0
       rx_47
       in_28
       start-pos_17
       end-pos34_1
       #f
       #f
       #t
       #t
       #f
       #f))
     ((rx_48 in_29 start-pos33_1)
      (regexp-match-positions43_0
       rx_48
       in_29
       start-pos33_1
       #f
       #f
       #f
       #t
       #f
       #f
       #f)))))
(define 1/regexp-match
  (let ((regexp-match55_0
         (lambda (rx53_0
                  in54_0
                  start-pos45_0
                  end-pos46_0
                  out47_0
                  prefix48_0
                  start-pos49_0
                  end-pos50_0
                  out51_0
                  prefix52_0)
           (let ((rx_10 rx53_0))
             (let ((in_30 in54_0))
               (let ((start-pos_18 (if start-pos49_0 start-pos45_0 0)))
                 (let ((end-pos_17 (if end-pos50_0 end-pos46_0 #f)))
                   (let ((out_10 (if out51_0 out47_0 #f)))
                     (let ((prefix_9 (if prefix52_0 prefix48_0 no-prefix)))
                       (if (fast-bytes?
                            rx_10
                            in_30
                            start-pos_18
                            end-pos_17
                            out_10
                            prefix_9)
                         (fast-drive-regexp-match/bytes
                          rx_10
                          in_30
                          start-pos_18
                          end-pos_17)
                         (if (fast-string?
                              rx_10
                              in_30
                              start-pos_18
                              end-pos_17
                              out_10
                              prefix_9)
                           (fast-drive-regexp-match/string
                            rx_10
                            in_30
                            start-pos_18
                            end-pos_17)
                           (let-values (((temp177_0) 'regexp-match)
                                        ((rx178_0) rx_10)
                                        ((in179_0) in_30)
                                        ((start-pos180_0) start-pos_18)
                                        ((end-pos181_0) end-pos_17)
                                        ((out182_0) out_10)
                                        ((prefix183_0) prefix_9)
                                        ((temp184_0) 'strings))
                             (drive-regexp-match24.1
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              temp184_0
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f
                              temp177_0
                              rx178_0
                              in179_0
                              start-pos180_0
                              end-pos181_0
                              out182_0
                              prefix183_0)))))))))))))
    (case-lambda
     ((rx_49 in_31) (regexp-match55_0 rx_49 in_31 #f #f #f #f #f #f #f #f))
     ((rx_13 in_32 start-pos_19 end-pos_18 out_11 prefix48_1)
      (regexp-match55_0
       rx_13
       in_32
       start-pos_19
       end-pos_18
       out_11
       prefix48_1
       #t
       #t
       #t
       #t))
     ((rx_50 in_33 start-pos_20 end-pos_19 out47_1)
      (regexp-match55_0
       rx_50
       in_33
       start-pos_20
       end-pos_19
       out47_1
       #f
       #t
       #t
       #t
       #f))
     ((rx_51 in_34 start-pos_21 end-pos46_1)
      (regexp-match55_0
       rx_51
       in_34
       start-pos_21
       end-pos46_1
       #f
       #f
       #t
       #t
       #f
       #f))
     ((rx_52 in_35 start-pos45_1)
      (regexp-match55_0 rx_52 in_35 start-pos45_1 #f #f #f #t #f #f #f)))))
(define 1/regexp-match-positions/end
  (let ((regexp-match-positions/end69_0
         (lambda (rx67_0
                  in68_0
                  start-pos57_0
                  end-pos58_0
                  out59_0
                  prefix60_0
                  end-bytes-count61_0
                  start-pos62_0
                  end-pos63_0
                  out64_0
                  prefix65_0
                  end-bytes-count66_0)
           (let ((rx_53 rx67_0))
             (let ((in_36 in68_0))
               (let ((start-pos_22 (if start-pos62_0 start-pos57_0 0)))
                 (let ((end-pos_20 (if end-pos63_0 end-pos58_0 #f)))
                   (let ((out_12 (if out64_0 out59_0 #f)))
                     (let ((prefix_10 (if prefix65_0 prefix60_0 no-prefix)))
                       (let ((end-bytes-count_2
                              (if end-bytes-count66_0 end-bytes-count61_0 1)))
                         (let-values (((temp185_0) 'regexp-match-positions)
                                      ((rx186_0) rx_53)
                                      ((in187_0) in_36)
                                      ((start-pos188_0) start-pos_22)
                                      ((end-pos189_0) end-pos_20)
                                      ((out190_0) out_12)
                                      ((prefix191_0) prefix_10)
                                      ((temp192_0) 'positions)
                                      ((temp193_0) #t)
                                      ((end-bytes-count194_0)
                                       end-bytes-count_2))
                           (drive-regexp-match24.1
                            end-bytes-count194_0
                            #t
                            temp193_0
                            #t
                            #f
                            #f
                            #f
                            #f
                            temp192_0
                            #f
                            #f
                            #f
                            #f
                            #f
                            #f
                            temp185_0
                            rx186_0
                            in187_0
                            start-pos188_0
                            end-pos189_0
                            out190_0
                            prefix191_0))))))))))))
    (case-lambda
     ((rx_54 in_37)
      (regexp-match-positions/end69_0
       rx_54
       in_37
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f))
     ((rx_55
       in_38
       start-pos_23
       end-pos_21
       out_13
       prefix_11
       end-bytes-count61_1)
      (regexp-match-positions/end69_0
       rx_55
       in_38
       start-pos_23
       end-pos_21
       out_13
       prefix_11
       end-bytes-count61_1
       #t
       #t
       #t
       #t
       #t))
     ((rx_56 in_39 start-pos_24 end-pos_22 out_14 prefix60_1)
      (regexp-match-positions/end69_0
       rx_56
       in_39
       start-pos_24
       end-pos_22
       out_14
       prefix60_1
       #f
       #t
       #t
       #t
       #t
       #f))
     ((rx_57 in_40 start-pos_25 end-pos_23 out59_1)
      (regexp-match-positions/end69_0
       rx_57
       in_40
       start-pos_25
       end-pos_23
       out59_1
       #f
       #f
       #t
       #t
       #t
       #f
       #f))
     ((rx_58 in_41 start-pos_26 end-pos58_1)
      (regexp-match-positions/end69_0
       rx_58
       in_41
       start-pos_26
       end-pos58_1
       #f
       #f
       #f
       #t
       #t
       #f
       #f
       #f))
     ((rx_59 in_42 start-pos57_1)
      (regexp-match-positions/end69_0
       rx_59
       in_42
       start-pos57_1
       #f
       #f
       #f
       #f
       #t
       #f
       #f
       #f
       #f)))))
(define 1/regexp-match/end
  (let ((regexp-match/end83_0
         (lambda (rx81_0
                  in82_0
                  start-pos71_0
                  end-pos72_0
                  out73_0
                  prefix74_0
                  end-bytes-count75_0
                  start-pos76_0
                  end-pos77_0
                  out78_0
                  prefix79_0
                  end-bytes-count80_0)
           (let ((rx_60 rx81_0))
             (let ((in_43 in82_0))
               (let ((start-pos_27 (if start-pos76_0 start-pos71_0 0)))
                 (let ((end-pos_24 (if end-pos77_0 end-pos72_0 #f)))
                   (let ((out_15 (if out78_0 out73_0 #f)))
                     (let ((prefix_12 (if prefix79_0 prefix74_0 no-prefix)))
                       (let ((end-bytes-count_3
                              (if end-bytes-count80_0 end-bytes-count75_0 1)))
                         (let-values (((temp195_0) 'regexp-match)
                                      ((rx196_0) rx_60)
                                      ((in197_0) in_43)
                                      ((start-pos198_0) start-pos_27)
                                      ((end-pos199_0) end-pos_24)
                                      ((out200_0) out_15)
                                      ((prefix201_0) prefix_12)
                                      ((temp202_0) 'strings)
                                      ((temp203_0) #t)
                                      ((end-bytes-count204_0)
                                       end-bytes-count_3))
                           (drive-regexp-match24.1
                            end-bytes-count204_0
                            #t
                            temp203_0
                            #t
                            #f
                            #f
                            #f
                            #f
                            temp202_0
                            #f
                            #f
                            #f
                            #f
                            #f
                            #f
                            temp195_0
                            rx196_0
                            in197_0
                            start-pos198_0
                            end-pos199_0
                            out200_0
                            prefix201_0))))))))))))
    (case-lambda
     ((rx_61 in_44)
      (regexp-match/end83_0 rx_61 in_44 #f #f #f #f #f #f #f #f #f #f))
     ((rx_62
       in_45
       start-pos_28
       end-pos_25
       out_16
       prefix_13
       end-bytes-count75_1)
      (regexp-match/end83_0
       rx_62
       in_45
       start-pos_28
       end-pos_25
       out_16
       prefix_13
       end-bytes-count75_1
       #t
       #t
       #t
       #t
       #t))
     ((rx_63 in_46 start-pos_29 end-pos_26 out_17 prefix74_1)
      (regexp-match/end83_0
       rx_63
       in_46
       start-pos_29
       end-pos_26
       out_17
       prefix74_1
       #f
       #t
       #t
       #t
       #t
       #f))
     ((rx_64 in_47 start-pos_30 end-pos_27 out73_1)
      (regexp-match/end83_0
       rx_64
       in_47
       start-pos_30
       end-pos_27
       out73_1
       #f
       #f
       #t
       #t
       #t
       #f
       #f))
     ((rx_65 in_48 start-pos_31 end-pos72_1)
      (regexp-match/end83_0
       rx_65
       in_48
       start-pos_31
       end-pos72_1
       #f
       #f
       #f
       #t
       #t
       #f
       #f
       #f))
     ((rx_66 in_49 start-pos71_1)
      (regexp-match/end83_0
       rx_66
       in_49
       start-pos71_1
       #f
       #f
       #f
       #f
       #t
       #f
       #f
       #f
       #f)))))
(define 1/regexp-match-peek
  (let ((regexp-match-peek95_0
         (lambda (rx93_0
                  in94_0
                  start-pos85_0
                  end-pos86_0
                  progress-evt87_0
                  prefix88_0
                  start-pos89_0
                  end-pos90_0
                  progress-evt91_0
                  prefix92_0)
           (let ((rx_67 rx93_0))
             (let ((in_50 in94_0))
               (let ((start-pos_32 (if start-pos89_0 start-pos85_0 0)))
                 (let ((end-pos_28 (if end-pos90_0 end-pos86_0 #f)))
                   (let ((progress-evt_2
                          (if progress-evt91_0 progress-evt87_0 #f)))
                     (let ((prefix_14 (if prefix92_0 prefix88_0 no-prefix)))
                       (let-values (((temp205_0) 'regexp-match)
                                    ((rx206_0) rx_67)
                                    ((in207_0) in_50)
                                    ((start-pos208_0) start-pos_32)
                                    ((end-pos209_0) end-pos_28)
                                    ((temp210_0) #f)
                                    ((prefix211_0) prefix_14)
                                    ((temp212_0) #t)
                                    ((progress-evt213_0) progress-evt_2)
                                    ((temp214_0) 'strings))
                         (drive-regexp-match24.1
                          #f
                          #f
                          #f
                          #f
                          #f
                          #f
                          #f
                          #f
                          temp214_0
                          temp212_0
                          #t
                          progress-evt213_0
                          #t
                          #f
                          #f
                          temp205_0
                          rx206_0
                          in207_0
                          start-pos208_0
                          end-pos209_0
                          temp210_0
                          prefix211_0)))))))))))
    (case-lambda
     ((rx_68 in_51)
      (regexp-match-peek95_0 rx_68 in_51 #f #f #f #f #f #f #f #f))
     ((rx_69 in_52 start-pos_33 end-pos_29 progress-evt_3 prefix88_1)
      (regexp-match-peek95_0
       rx_69
       in_52
       start-pos_33
       end-pos_29
       progress-evt_3
       prefix88_1
       #t
       #t
       #t
       #t))
     ((rx_70 in_53 start-pos_34 end-pos_30 progress-evt87_1)
      (regexp-match-peek95_0
       rx_70
       in_53
       start-pos_34
       end-pos_30
       progress-evt87_1
       #f
       #t
       #t
       #t
       #f))
     ((rx_71 in_54 start-pos_35 end-pos86_1)
      (regexp-match-peek95_0
       rx_71
       in_54
       start-pos_35
       end-pos86_1
       #f
       #f
       #t
       #t
       #f
       #f))
     ((rx_72 in_55 start-pos85_1)
      (regexp-match-peek95_0
       rx_72
       in_55
       start-pos85_1
       #f
       #f
       #f
       #t
       #f
       #f
       #f)))))
(define 1/regexp-match-peek-immediate
  (let ((regexp-match-peek-immediate107_0
         (lambda (rx105_0
                  in106_0
                  start-pos97_0
                  end-pos98_0
                  progress-evt99_0
                  prefix100_0
                  start-pos101_0
                  end-pos102_0
                  progress-evt103_0
                  prefix104_0)
           (let ((rx_73 rx105_0))
             (let ((in_56 in106_0))
               (let ((start-pos_36 (if start-pos101_0 start-pos97_0 0)))
                 (let ((end-pos_31 (if end-pos102_0 end-pos98_0 #f)))
                   (let ((progress-evt_4
                          (if progress-evt103_0 progress-evt99_0 #f)))
                     (let ((prefix_15 (if prefix104_0 prefix100_0 no-prefix)))
                       (let-values (((temp215_0) 'regexp-match)
                                    ((rx216_0) rx_73)
                                    ((in217_0) in_56)
                                    ((start-pos218_0) start-pos_36)
                                    ((end-pos219_0) end-pos_31)
                                    ((temp220_0) #f)
                                    ((prefix221_0) prefix_15)
                                    ((temp222_0) #t)
                                    ((temp223_0) #t)
                                    ((progress-evt224_0) progress-evt_4)
                                    ((temp225_0) 'strings))
                         (drive-regexp-match24.1
                          #f
                          #f
                          #f
                          #f
                          temp223_0
                          #t
                          #f
                          #f
                          temp225_0
                          temp222_0
                          #t
                          progress-evt224_0
                          #t
                          #f
                          #f
                          temp215_0
                          rx216_0
                          in217_0
                          start-pos218_0
                          end-pos219_0
                          temp220_0
                          prefix221_0)))))))))))
    (case-lambda
     ((rx_74 in_57)
      (regexp-match-peek-immediate107_0 rx_74 in_57 #f #f #f #f #f #f #f #f))
     ((rx_75 in_58 start-pos_37 end-pos_32 progress-evt_5 prefix100_1)
      (regexp-match-peek-immediate107_0
       rx_75
       in_58
       start-pos_37
       end-pos_32
       progress-evt_5
       prefix100_1
       #t
       #t
       #t
       #t))
     ((rx_76 in_59 start-pos_38 end-pos_33 progress-evt99_1)
      (regexp-match-peek-immediate107_0
       rx_76
       in_59
       start-pos_38
       end-pos_33
       progress-evt99_1
       #f
       #t
       #t
       #t
       #f))
     ((rx_77 in_60 start-pos_39 end-pos98_1)
      (regexp-match-peek-immediate107_0
       rx_77
       in_60
       start-pos_39
       end-pos98_1
       #f
       #f
       #t
       #t
       #f
       #f))
     ((rx_78 in_61 start-pos97_1)
      (regexp-match-peek-immediate107_0
       rx_78
       in_61
       start-pos97_1
       #f
       #f
       #f
       #t
       #f
       #f
       #f)))))
(define 1/regexp-match-peek-positions
  (let ((regexp-match-peek-positions119_0
         (lambda (rx117_0
                  in118_0
                  start-pos109_0
                  end-pos110_0
                  progress-evt111_0
                  prefix112_0
                  start-pos113_0
                  end-pos114_0
                  progress-evt115_0
                  prefix116_0)
           (let ((rx_79 rx117_0))
             (let ((in_62 in118_0))
               (let ((start-pos_40 (if start-pos113_0 start-pos109_0 0)))
                 (let ((end-pos_34 (if end-pos114_0 end-pos110_0 #f)))
                   (let ((progress-evt_6
                          (if progress-evt115_0 progress-evt111_0 #f)))
                     (let ((prefix_16 (if prefix116_0 prefix112_0 no-prefix)))
                       (let-values (((temp226_0) 'regexp-match)
                                    ((rx227_0) rx_79)
                                    ((in228_0) in_62)
                                    ((start-pos229_0) start-pos_40)
                                    ((end-pos230_0) end-pos_34)
                                    ((temp231_0) #f)
                                    ((prefix232_0) prefix_16)
                                    ((temp233_0) #t)
                                    ((progress-evt234_0) progress-evt_6)
                                    ((temp235_0) 'positions))
                         (drive-regexp-match24.1
                          #f
                          #f
                          #f
                          #f
                          #f
                          #f
                          #f
                          #f
                          temp235_0
                          temp233_0
                          #t
                          progress-evt234_0
                          #t
                          #f
                          #f
                          temp226_0
                          rx227_0
                          in228_0
                          start-pos229_0
                          end-pos230_0
                          temp231_0
                          prefix232_0)))))))))))
    (case-lambda
     ((rx_80 in_63)
      (regexp-match-peek-positions119_0 rx_80 in_63 #f #f #f #f #f #f #f #f))
     ((rx_81 in_64 start-pos_41 end-pos_35 progress-evt_7 prefix112_1)
      (regexp-match-peek-positions119_0
       rx_81
       in_64
       start-pos_41
       end-pos_35
       progress-evt_7
       prefix112_1
       #t
       #t
       #t
       #t))
     ((rx_82 in_65 start-pos_42 end-pos_36 progress-evt111_1)
      (regexp-match-peek-positions119_0
       rx_82
       in_65
       start-pos_42
       end-pos_36
       progress-evt111_1
       #f
       #t
       #t
       #t
       #f))
     ((rx_83 in_66 start-pos_43 end-pos110_1)
      (regexp-match-peek-positions119_0
       rx_83
       in_66
       start-pos_43
       end-pos110_1
       #f
       #f
       #t
       #t
       #f
       #f))
     ((rx_84 in_67 start-pos109_1)
      (regexp-match-peek-positions119_0
       rx_84
       in_67
       start-pos109_1
       #f
       #f
       #f
       #t
       #f
       #f
       #f)))))
(define 1/regexp-match-peek-positions/end
  (let ((regexp-match-peek-positions/end133_0
         (lambda (rx131_0
                  in132_0
                  start-pos121_0
                  end-pos122_0
                  progress-evt123_0
                  prefix124_0
                  end-bytes-count125_0
                  start-pos126_0
                  end-pos127_0
                  progress-evt128_0
                  prefix129_0
                  end-bytes-count130_0)
           (let ((rx_85 rx131_0))
             (let ((in_68 in132_0))
               (let ((start-pos_44 (if start-pos126_0 start-pos121_0 0)))
                 (let ((end-pos_37 (if end-pos127_0 end-pos122_0 #f)))
                   (let ((progress-evt_8
                          (if progress-evt128_0 progress-evt123_0 #f)))
                     (let ((prefix_17 (if prefix129_0 prefix124_0 no-prefix)))
                       (let ((end-bytes-count_4
                              (if end-bytes-count130_0
                                end-bytes-count125_0
                                1)))
                         (let-values (((temp236_0) 'regexp-match)
                                      ((rx237_0) rx_85)
                                      ((in238_0) in_68)
                                      ((start-pos239_0) start-pos_44)
                                      ((end-pos240_0) end-pos_37)
                                      ((temp241_0) #f)
                                      ((prefix242_0) prefix_17)
                                      ((temp243_0) #t)
                                      ((progress-evt244_0) progress-evt_8)
                                      ((temp245_0) 'positions)
                                      ((temp246_0) #t)
                                      ((end-bytes-count247_0)
                                       end-bytes-count_4))
                           (drive-regexp-match24.1
                            end-bytes-count247_0
                            #t
                            temp246_0
                            #t
                            #f
                            #f
                            #f
                            #f
                            temp245_0
                            temp243_0
                            #t
                            progress-evt244_0
                            #t
                            #f
                            #f
                            temp236_0
                            rx237_0
                            in238_0
                            start-pos239_0
                            end-pos240_0
                            temp241_0
                            prefix242_0))))))))))))
    (case-lambda
     ((rx_86 in_69)
      (regexp-match-peek-positions/end133_0
       rx_86
       in_69
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f))
     ((rx_87
       in_70
       start-pos_45
       end-pos_38
       progress-evt_9
       prefix_18
       end-bytes-count125_1)
      (regexp-match-peek-positions/end133_0
       rx_87
       in_70
       start-pos_45
       end-pos_38
       progress-evt_9
       prefix_18
       end-bytes-count125_1
       #t
       #t
       #t
       #t
       #t))
     ((rx_88 in_71 start-pos_46 end-pos_39 progress-evt_10 prefix124_1)
      (regexp-match-peek-positions/end133_0
       rx_88
       in_71
       start-pos_46
       end-pos_39
       progress-evt_10
       prefix124_1
       #f
       #t
       #t
       #t
       #t
       #f))
     ((rx_89 in_72 start-pos_47 end-pos_40 progress-evt123_1)
      (regexp-match-peek-positions/end133_0
       rx_89
       in_72
       start-pos_47
       end-pos_40
       progress-evt123_1
       #f
       #f
       #t
       #t
       #t
       #f
       #f))
     ((rx_90 in_73 start-pos_48 end-pos122_1)
      (regexp-match-peek-positions/end133_0
       rx_90
       in_73
       start-pos_48
       end-pos122_1
       #f
       #f
       #f
       #t
       #t
       #f
       #f
       #f))
     ((rx_91 in_74 start-pos121_1)
      (regexp-match-peek-positions/end133_0
       rx_91
       in_74
       start-pos121_1
       #f
       #f
       #f
       #f
       #t
       #f
       #f
       #f
       #f)))))
(define 1/regexp-match-peek-positions-immediate
  (let ((regexp-match-peek-positions-immediate145_0
         (lambda (rx143_0
                  in144_0
                  start-pos135_0
                  end-pos136_0
                  progress-evt137_0
                  prefix138_0
                  start-pos139_0
                  end-pos140_0
                  progress-evt141_0
                  prefix142_0)
           (let ((rx_92 rx143_0))
             (let ((in_75 in144_0))
               (let ((start-pos_49 (if start-pos139_0 start-pos135_0 0)))
                 (let ((end-pos_41 (if end-pos140_0 end-pos136_0 #f)))
                   (let ((progress-evt_11
                          (if progress-evt141_0 progress-evt137_0 #f)))
                     (let ((prefix_19 (if prefix142_0 prefix138_0 no-prefix)))
                       (let-values (((temp248_0) 'regexp-match)
                                    ((rx249_0) rx_92)
                                    ((in250_0) in_75)
                                    ((start-pos251_0) start-pos_49)
                                    ((end-pos252_0) end-pos_41)
                                    ((temp253_0) #f)
                                    ((prefix254_0) prefix_19)
                                    ((temp255_0) #t)
                                    ((temp256_0) #t)
                                    ((progress-evt257_0) progress-evt_11)
                                    ((temp258_0) 'positions))
                         (drive-regexp-match24.1
                          #f
                          #f
                          #f
                          #f
                          temp256_0
                          #t
                          #f
                          #f
                          temp258_0
                          temp255_0
                          #t
                          progress-evt257_0
                          #t
                          #f
                          #f
                          temp248_0
                          rx249_0
                          in250_0
                          start-pos251_0
                          end-pos252_0
                          temp253_0
                          prefix254_0)))))))))))
    (case-lambda
     ((rx_93 in_76)
      (regexp-match-peek-positions-immediate145_0
       rx_93
       in_76
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f))
     ((rx_94 in_77 start-pos_50 end-pos_42 progress-evt_12 prefix138_1)
      (regexp-match-peek-positions-immediate145_0
       rx_94
       in_77
       start-pos_50
       end-pos_42
       progress-evt_12
       prefix138_1
       #t
       #t
       #t
       #t))
     ((rx_95 in_78 start-pos_51 end-pos_43 progress-evt137_1)
      (regexp-match-peek-positions-immediate145_0
       rx_95
       in_78
       start-pos_51
       end-pos_43
       progress-evt137_1
       #f
       #t
       #t
       #t
       #f))
     ((rx_96 in_79 start-pos_52 end-pos136_1)
      (regexp-match-peek-positions-immediate145_0
       rx_96
       in_79
       start-pos_52
       end-pos136_1
       #f
       #f
       #t
       #t
       #f
       #f))
     ((rx_97 in_80 start-pos135_1)
      (regexp-match-peek-positions-immediate145_0
       rx_97
       in_80
       start-pos135_1
       #f
       #f
       #f
       #t
       #f
       #f
       #f)))))
(define 1/regexp-match-peek-positions-immediate/end
  (let ((regexp-match-peek-positions-immediate/end159_0
         (lambda (rx157_0
                  in158_0
                  start-pos147_0
                  end-pos148_0
                  progress-evt149_0
                  prefix150_0
                  end-bytes-count151_0
                  start-pos152_0
                  end-pos153_0
                  progress-evt154_0
                  prefix155_0
                  end-bytes-count156_0)
           (let ((rx_98 rx157_0))
             (let ((in_81 in158_0))
               (let ((start-pos_53 (if start-pos152_0 start-pos147_0 0)))
                 (let ((end-pos_44 (if end-pos153_0 end-pos148_0 #f)))
                   (let ((progress-evt_13
                          (if progress-evt154_0 progress-evt149_0 #f)))
                     (let ((prefix_20 (if prefix155_0 prefix150_0 no-prefix)))
                       (let ((end-bytes-count_5
                              (if end-bytes-count156_0
                                end-bytes-count151_0
                                1)))
                         (let-values (((temp259_0) 'regexp-match)
                                      ((rx260_0) rx_98)
                                      ((in261_0) in_81)
                                      ((start-pos262_0) start-pos_53)
                                      ((end-pos263_0) end-pos_44)
                                      ((temp264_0) #f)
                                      ((prefix265_0) prefix_20)
                                      ((temp266_0) #t)
                                      ((temp267_0) #t)
                                      ((progress-evt268_0) progress-evt_13)
                                      ((temp269_0) 'positions)
                                      ((temp270_0) #t)
                                      ((end-bytes-count271_0)
                                       end-bytes-count_5))
                           (drive-regexp-match24.1
                            end-bytes-count271_0
                            #t
                            temp270_0
                            #t
                            temp267_0
                            #t
                            #f
                            #f
                            temp269_0
                            temp266_0
                            #t
                            progress-evt268_0
                            #t
                            #f
                            #f
                            temp259_0
                            rx260_0
                            in261_0
                            start-pos262_0
                            end-pos263_0
                            temp264_0
                            prefix265_0))))))))))))
    (case-lambda
     ((rx_99 in_82)
      (regexp-match-peek-positions-immediate/end159_0
       rx_99
       in_82
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f
       #f))
     ((rx_100
       in_83
       start-pos_54
       end-pos_45
       progress-evt_14
       prefix_21
       end-bytes-count151_1)
      (regexp-match-peek-positions-immediate/end159_0
       rx_100
       in_83
       start-pos_54
       end-pos_45
       progress-evt_14
       prefix_21
       end-bytes-count151_1
       #t
       #t
       #t
       #t
       #t))
     ((rx_101 in_84 start-pos_55 end-pos_46 progress-evt_15 prefix150_1)
      (regexp-match-peek-positions-immediate/end159_0
       rx_101
       in_84
       start-pos_55
       end-pos_46
       progress-evt_15
       prefix150_1
       #f
       #t
       #t
       #t
       #t
       #f))
     ((rx_102 in_85 start-pos_56 end-pos_47 progress-evt149_1)
      (regexp-match-peek-positions-immediate/end159_0
       rx_102
       in_85
       start-pos_56
       end-pos_47
       progress-evt149_1
       #f
       #f
       #t
       #t
       #t
       #f
       #f))
     ((rx_103 in_86 start-pos_57 end-pos148_1)
      (regexp-match-peek-positions-immediate/end159_0
       rx_103
       in_86
       start-pos_57
       end-pos148_1
       #f
       #f
       #f
       #t
       #t
       #f
       #f
       #f))
     ((rx_104 in_87 start-pos147_1)
      (regexp-match-peek-positions-immediate/end159_0
       rx_104
       in_87
       start-pos147_1
       #f
       #f
       #f
       #f
       #t
       #f
       #f
       #f
       #f)))))
