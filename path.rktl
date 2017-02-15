;; This is not the original source code. Instead, this is the code after
;; fully expanding and flattening into a single linklet.
(linklet
 ()
 ((1/build-path/convention-type build-path/convention-type)
  (1/explode-path explode-path)
  (1/path-element->string path-element->string)
  (1/simplify-path simplify-path)
  (1/path->directory-path path->directory-path)
  (1/bytes->path bytes->path)
  (1/path<? path<?)
  (is-path? path?)
  (1/path->bytes path->bytes)
  (1/string->path-element string->path-element)
  (1/absolute-path? absolute-path?)
  (1/path-convention-type path-convention-type)
  (1/path->complete-path path->complete-path)
  (1/cleanse-path cleanse-path)
  (1/bytes->path-element bytes->path-element)
  (1/complete-path? complete-path?)
  (1/build-path build-path)
  (1/relative-path? relative-path?)
  (1/path-for-some-system? path-for-some-system?)
  (1/string->path string->path)
  (1/path-element->bytes path-element->bytes)
  (1/split-path split-path)
  (1/path->string path->string))
 (define-values
  (prop:procedure-accessor procedure-accessor? procedure-accessor-ref)
  (make-struct-type-property
   'procedure
   (lambda (v_0 info-l_0) (if (exact-integer? v_0) (make-struct-field-accessor (list-ref info-l_0 3) v_0) #f))))
 (define-values
  (new-prop:procedure new-procedure? new-procedure-ref)
  (make-struct-type-property 'procedure #f (list (cons prop:procedure values) (cons prop:procedure-accessor values))))
 (define-values
  (1/reverse)
  (lambda (l_0)
    (begin
      (if (list? l_0) (void) (raise-argument-error 'reverse "list?" l_0))
      (letrec-values (((loop_0) (lambda (a_0 l_1) (if (null? l_1) a_0 (loop_0 (cons (car l_1) a_0) (cdr l_1))))))
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
  (check-string)
  (lambda (v_11) (if (string? v_11) (void) (let-values () (raise-argument-error 'in-string "string" v_11)))))
 (define-values
  (check-bytes)
  (lambda (v_12) (if (bytes? v_12) (void) (let-values () (raise-argument-error 'in-bytes "bytes" v_12)))))
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
      (lambda (v_13) ((do-stream-ref v_13 0)))
      (lambda (v_14) ((do-stream-ref v_14 1)))
      (lambda (v_15) ((do-stream-ref v_15 2))))))))
 (define-values (empty-stream) (make-do-stream (lambda () #t) void void))
 (define-values (no-empty-edge-table) (make-hash))
 (define-values
  (struct:path path1.1 1/path? path-bytes path-convention)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'path
                     #f
                     2
                     0
                     #f
                     (list
                      (cons
                       prop:custom-write
                       (lambda (p_0 port_0 mode_0)
                         (begin
                           (write-string "#<path:" port_0)
                           (write-string (bytes->string/locale (path-bytes p_0)) port_0)
                           (write-string ">" port_0)))))
                     (current-inspector)
                     #f
                     '(0 1)
                     #f
                     'path)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'bytes)
     (make-struct-field-accessor -ref_0 1 'convention))))
 (define-values
  (is-path?)
  (let-values (((path?_0)
                (lambda (p_1) (if (1/path? p_1) (eq? (path-convention p_1) (system-path-convention-type)) #f))))
    path?_0))
 (define-values (1/path-for-some-system?) (lambda (p_2) (1/path? p_2)))
 (define-values
  (path-string?)
  (lambda (p_3)
    (let-values (((or-part_0) (is-path? p_3)))
      (if or-part_0
        or-part_0
        (if (string? p_3)
          (if (positive? (string-length p_3))
            (let-values (((vec_0 len_0)
                          (let-values (((vec_1) p_3))
                            (begin
                              (if (string? vec_1) (void) (let-values () (check-string vec_1)))
                              (values vec_1 (unsafe-string-length vec_1))))))
              (begin
                #f
                ((letrec-values (((for-loop_0)
                                  (lambda (result_0 pos_0)
                                    (if (unsafe-fx< pos_0 len_0)
                                      (let-values (((c_0) (string-ref vec_0 pos_0)))
                                        (let-values (((result_1)
                                                      (let-values ()
                                                        (let-values (((result_2)
                                                                      (let-values ()
                                                                        (let-values () (not (char=? c_0 '#\nul))))))
                                                          (values result_2)))))
                                          (if (if (not ((lambda x_0 (not result_1)) c_0)) (not #f) #f)
                                            (for-loop_0 result_1 (unsafe-fx+ 1 pos_0))
                                            result_1)))
                                      result_0))))
                   for-loop_0)
                 #t
                 0)))
            #f)
          #f)))))
 (define-values
  (string->path$1)
  (lambda (s_0) (path1.1 (string->bytes/locale s_0 (char->integer '#\?)) (system-path-convention-type))))
 (define-values (->path) (lambda (p_4) (if (string? p_4) (string->path$1 p_4) p_4)))
 (define-values
  (check-convention)
  (lambda (who_0 c_1)
    (if ((lambda (c_2) (let-values (((or-part_1) (eq? c_2 'windows))) (if or-part_1 or-part_1 (eq? c_2 'unix)))) c_1)
      (void)
      (let-values () (raise-argument-error who_0 "(or/c 'windows 'unix)" c_1)))))
 (define-values
  (check-path-string)
  (lambda (who_1 s_1)
    (begin
      (if (zero? (string-length s_1)) (let-values () (raise-arguments-error who_1 "path string is empty")) (void))
      (let-values (((vec_2 len_1)
                    (let-values (((vec_3) s_1))
                      (begin
                        (if (string? vec_3) (void) (let-values () (check-string vec_3)))
                        (values vec_3 (unsafe-string-length vec_3))))))
        (begin
          #f
          ((letrec-values (((for-loop_1)
                            (lambda (pos_1)
                              (if (unsafe-fx< pos_1 len_1)
                                (let-values (((c_3) (string-ref vec_2 pos_1)))
                                  (let-values ((()
                                                (let-values ()
                                                  (let-values ((()
                                                                (let-values ()
                                                                  (begin
                                                                    (let-values ()
                                                                      (if (char=? c_3 '#\nul)
                                                                        (let-values ()
                                                                          (raise-arguments-error
                                                                           who_1
                                                                           "path string contains a nul character"
                                                                           "path string"
                                                                           s_1))
                                                                        (void)))
                                                                    (values)))))
                                                    (values)))))
                                    (if (not #f) (for-loop_1 (unsafe-fx+ 1 pos_1)) (values))))
                                (values)))))
             for-loop_1)
           0)))
      (void))))
 (define-values
  (check-path-bytes)
  (lambda (who_2 s_0)
    (begin
      (if (zero? (bytes-length s_0)) (let-values () (raise-arguments-error who_2 "byte string is empty")) (void))
      (let-values (((vec_4 len_2)
                    (let-values (((vec_5) s_0))
                      (begin
                        (if (bytes? vec_5) (void) (let-values () (check-bytes vec_5)))
                        (values vec_5 (unsafe-bytes-length vec_5))))))
        (begin
          #f
          ((letrec-values (((for-loop_2)
                            (lambda (pos_2)
                              (if (unsafe-fx< pos_2 len_2)
                                (let-values (((c_4) (unsafe-bytes-ref vec_4 pos_2)))
                                  (let-values ((()
                                                (let-values ()
                                                  (let-values ((()
                                                                (let-values ()
                                                                  (begin
                                                                    (let-values ()
                                                                      (if (zero? c_4)
                                                                        (let-values ()
                                                                          (raise-arguments-error
                                                                           who_2
                                                                           "byte string contains a nul character"
                                                                           "byte string"
                                                                           s_0))
                                                                        (void)))
                                                                    (values)))))
                                                    (values)))))
                                    (if (not #f) (for-loop_2 (unsafe-fx+ 1 pos_2)) (values))))
                                (values)))))
             for-loop_2)
           0)))
      (void))))
 (define-values
  (is-sep?)
  (lambda (c_5 convention_0)
    (let-values (((or-part_2) (eq? c_5 (char->integer '#\/))))
      (if or-part_2 or-part_2 (if (eq? convention_0 'windows) (eq? c_5 (char->integer '#\\)) #f)))))
 (define-values (1/build-path) (lambda (base_0 . subs_0) (build 'build-path #f base_0 subs_0)))
 (define-values
  (1/build-path/convention-type)
  (lambda (convention_1 base_1 . subs_1) (build 'build-path/convention-type convention_1 base_1 subs_1)))
 (define-values
  (build)
  (lambda (who_3 init-convention_0 base_2 subs_2)
    (let-values ((() (begin (check-build-path-arg who_3 base_2) (values))))
      (let-values (((convention_2)
                    ((letrec-values (((loop_1)
                                      (lambda (convention_3 subs_3)
                                        (if (null? subs_3)
                                          (let-values () convention_3)
                                          (let-values ()
                                            (let-values (((sub_0) (car subs_3)))
                                              (begin
                                                (check-build-path-arg who_3 sub_0)
                                                (loop_1
                                                 (let-values (((temp12_0) #f))
                                                   (argument->convention6.1 temp12_0 sub_0 convention_3 who_3))
                                                 (cdr subs_3)))))))))
                       loop_1)
                     (let-values (((temp16_0) #t)) (argument->convention6.1 temp16_0 base_2 init-convention_0 who_3))
                     subs_2)))
        (path1.1 (append-path-parts convention_2 who_3 base_2 subs_2) convention_2)))))
 (define-values
  (check-build-path-arg)
  (lambda (who_4 p_5)
    (if ((lambda (p_6)
           (let-values (((or-part_3) (path-string? p_6)))
             (if or-part_3
               or-part_3
               (let-values (((or-part_4) (1/path-for-some-system? p_6)))
                 (if or-part_4
                   or-part_4
                   (let-values (((or-part_5) (eq? p_6 'up))) (if or-part_5 or-part_5 (eq? p_6 'same))))))))
         p_5)
      (void)
      (let-values () (raise-argument-error who_4 "(or/c path-string? path-for-some-system? 'up 'same)" p_5)))))
 (define-values
  (argument->convention6.1)
  (lambda (first?1_0 p3_0 convention4_0 who5_0)
    (let-values (((p_7) p3_0))
      (let-values (((convention_4) convention4_0))
        (let-values (((who_5) who5_0))
          (let-values (((first?_0) first?1_0))
            (let-values ()
              (let-values (((check_0)
                            (lambda (c_6)
                              (begin
                                (if (if convention_4 (not (eq? c_6 convention_4)) #f)
                                  (let-values ()
                                    (raise-arguments-error
                                     who_5
                                     (format
                                      (if first?_0
                                        "specified convention incompatible with ~a path element"
                                        "preceding path's convention incompatible with ~a path element")
                                      (if (string? p_7) "string" "given"))
                                     "path element"
                                     p_7
                                     (if first?_0 "convention" "preceding path's convention")
                                     convention_4))
                                  (void))
                                c_6))))
                (if (1/path? p_7)
                  (let-values () (check_0 (path-convention p_7)))
                  (if (string? p_7)
                    (let-values () (check_0 (system-path-convention-type)))
                    (let-values () convention_4)))))))))))
 (define-values
  (append-path-parts)
  (lambda (convention_5 who_6 base_3 subs_4)
    (apply
     bytes-append
     ((letrec-values (((loop_2)
                       (lambda (prev_0 subs_5)
                         (if (null? subs_5)
                           (let-values () (list prev_0))
                           (let-values ()
                             (let-values (((sub_1) (car subs_5)))
                               (let-values (((bstr_0) (as-bytes sub_1)))
                                 (if (eq? convention_5 'unix)
                                   (let-values ()
                                     (begin
                                       (if (is-sep? (bytes-ref bstr_0 0) 'unix)
                                         (let-values ()
                                           (raise-arguments-error
                                            who_6
                                            "absolute path cannot be added to a path"
                                            "absolute path"
                                            sub_1))
                                         (void))
                                       (cons
                                        prev_0
                                        (if (is-sep? (bytes-ref prev_0 (sub1 (bytes-length prev_0))) 'unix)
                                          (let-values () (loop_2 bstr_0 (cdr subs_5)))
                                          (let-values () (cons #"/" (loop_2 bstr_0 (cdr subs_5))))))))
                                   (let-values ()
                                     (let-values (((cleaned-prev_0) (strip-trailing-spaces prev_0)))
                                       cleaned-prev_0))))))))))
        loop_2)
      (as-bytes base_3)
      subs_4))))
 (define-values
  (as-bytes)
  (lambda (p_8)
    (if (eq? p_8 'up)
      (let-values () #"..")
      (if (eq? p_8 'same)
        (let-values () #".")
        (if (1/path? p_8)
          (let-values () (path-bytes p_8))
          (let-values () (string->bytes/locale p_8 (char->integer '#\?))))))))
 (define-values (strip-trailing-spaces) (lambda (prev_1) prev_1))
 (define-values
  (check-path-argument)
  (lambda (who_7 p_9)
    (if ((lambda (p_10)
           (let-values (((or-part_6) (path-string? p_10))) (if or-part_6 or-part_6 (1/path-for-some-system? p_10))))
         p_9)
      (void)
      (let-values () (raise-argument-error who_7 "(or/c path-string? path-for-some-system?)" p_9)))))
 (define-values (drive-letter?) (lambda (c_5) (if (< c_5 128) (char-alphabetic? (integer->char c_5)) #f)))
 (define-values
  (1/cleanse-path)
  (lambda (p-in_0)
    (let-values ((() (begin (check-path-argument 'cleanse-path p-in_0) (values))))
      (let-values (((p_9) (->path p-in_0)))
        (let-values (((tmp_0) (path-convention p_9)))
          (if (equal? tmp_0 'unix)
            (let-values ()
              (let-values (((bstr_1) (clean-double-slashes (path-bytes p_9) 'unix 0)))
                (if (eq? bstr_1 (path-bytes p_9)) p_9 (path1.1 bstr_1 'unix))))
            (if (equal? tmp_0 'windows) (let-values () (error "Windows path cleanse")) (let-values () (void)))))))))
 (define-values
  (clean-double-slashes)
  (lambda (bstr_2 convention_6 allow-double-before_0)
    (let-values (((extra-count_0)
                  ((letrec-values (((loop_3)
                                    (lambda (i_0)
                                      (if (= i_0 allow-double-before_0)
                                        (let-values () 0)
                                        (if (if (is-sep? (bytes-ref bstr_2 i_0) convention_6)
                                              (is-sep? (bytes-ref bstr_2 (sub1 i_0)) convention_6)
                                              #f)
                                          (let-values () (add1 (loop_3 (sub1 i_0))))
                                          (let-values () (loop_3 (sub1 i_0))))))))
                     loop_3)
                   (sub1 (bytes-length bstr_2)))))
      (if (zero? extra-count_0)
        (let-values () bstr_2)
        (let-values ()
          (let-values (((new-bstr_0) (make-bytes (- (bytes-length bstr_2) extra-count_0))))
            (begin
              ((letrec-values (((loop_4)
                                (lambda (i_1 j_0)
                                  (if (= i_1 allow-double-before_0)
                                    (void)
                                    (let-values ()
                                      (if (if (is-sep? (bytes-ref bstr_2 i_1) convention_6)
                                            (is-sep? (bytes-ref bstr_2 (sub1 i_1)) convention_6)
                                            #f)
                                        (let-values () (loop_4 (sub1 i_1) j_0))
                                        (let-values ()
                                          (begin
                                            (bytes-set! new-bstr_0 j_0 (bytes-ref bstr_2 i_1))
                                            (loop_4 (sub1 i_1) (sub1 j_0))))))))))
                 loop_4)
               (sub1 (bytes-length bstr_2))
               (sub1 (bytes-length new-bstr_0)))
              (bytes-copy! new-bstr_0 0 bstr_2 0 (add1 allow-double-before_0))
              new-bstr_0)))))))
 (define-values
  (1/split-path)
  (lambda (p_11)
    (begin (check-path-argument 'split-path p_11) (let-values (((temp42_0) (->path p_11))) (split4.1 #f #f temp42_0)))))
 (define-values
  (1/explode-path)
  (lambda (p_12)
    (begin
      (check-path-argument 'explode-path p_12)
      (1/reverse (let-values (((temp43_0) (->path p_12)) ((temp44_0) #t)) (split4.1 temp44_0 #t temp43_0))))))
 (define-values
  (split4.1)
  (lambda (explode?1_0 explode?2_0 p3_1)
    (let-values (((p_6) p3_1))
      (let-values (((explode?_0) (if explode?2_0 explode?1_0 #f)))
        (let-values ()
          (if (not (eq? (path-convention p_6) 'windows))
            (let-values ()
              (let-values (((explode?46_0) explode?_0))
                (split-after-drive20.1 #f #f #f #f explode?46_0 #f #f #f #f #f #f p_6)))
            (let-values ()
              (let-values (((bstr_3) (path-bytes p_6)))
                (if (if (> (bytes-length bstr_3) 2)
                      (if (is-sep? (bytes-ref bstr_3 0) 'windows) (is-sep? (bytes-ref bstr_3 1) 'windows) #f)
                      #f)
                  (let-values ()
                    (let-values (((//?-drive-end_0) (parse-//?-drive bstr_3)))
                      (if //?-drive-end_0
                        (let-values ()
                          (let-values ()
                            (if (eq? //?-drive-end_0 'reld)
                              (let-values () (split-reld bstr_3 //?-drive-end_0))
                              (let-values ()
                                (let-values (((temp48_0)
                                              (if (if (< //?-drive-end_0 (bytes-length bstr_3))
                                                    (eq? (bytes-ref bstr_3 //?-drive-end_0) (char->integer '#\\))
                                                    #f)
                                                (let-values () (add1 //?-drive-end_0))
                                                (let-values () //?-drive-end_0)))
                                             ((temp49_0) #t)
                                             ((temp50_0) #t)
                                             ((explode?51_0) explode?_0))
                                  (split-after-drive20.1
                                   #f
                                   #f
                                   temp48_0
                                   #t
                                   explode?51_0
                                   #f
                                   #f
                                   temp49_0
                                   #t
                                   temp50_0
                                   #t
                                   p_6))))))
                        (let-values ()
                          (let-values (((//-drive-end_0) (parse-//-drive bstr_3)))
                            (if //-drive-end_0
                              (let-values ()
                                (let-values (((temp53_0)
                                              (if (if (< //-drive-end_0 (bytes-length bstr_3))
                                                    (is-sep? (bytes-ref bstr_3 //?-drive-end_0) 'windows)
                                                    #f)
                                                (let-values () (add1 //-drive-end_0))
                                                (let-values () //-drive-end_0)))
                                             ((temp54_0) 1)
                                             ((explode?55_0) explode?_0))
                                  (split-after-drive20.1 temp54_0 #t temp53_0 #t explode?55_0 #f #f #f #f #f #f p_6)))
                              (let-values ()
                                (let-values (((explode?57_0) explode?_0))
                                  (split-after-drive20.1 #f #f #f #f explode?57_0 #f #f #f #f #f #f p_6)))))))))
                  (if (if (> (bytes-length bstr_3) 2)
                        (if (drive-letter? (bytes-ref bstr_3 0)) (eq? (bytes-ref bstr_3 1) (char->integer '#\:)) #f)
                        #f)
                    (let-values ()
                      (let-values (((temp59_0)
                                    (if (if (< 2 (bytes-length bstr_3)) (is-sep? (bytes-ref bstr_3 2) 'windows) #f)
                                      (let-values () 3)
                                      (let-values () 2)))
                                   ((explode?60_0) explode?_0))
                        (split-after-drive20.1 #f #f temp59_0 #t explode?60_0 #f #f #f #f #f #f p_6)))
                    (let-values (((c1_0)
                                  (let-values (((explode?62_0) explode?_0))
                                    (split-after-drive20.1 #f #f #f #f explode?62_0 #f #f #f #f #f #f p_6))))
                      (if c1_0 c1_0 (void)))))))))))))
 (define-values
  (split-after-drive20.1)
  (lambda (allow-double-before11_0
           allow-double-before17_0
           drive-end8_0
           drive-end14_0
           explode?12_0
           len7_0
           len13_0
           no-slash-sep?9_0
           no-slash-sep?15_0
           no-up?10_0
           no-up?16_0
           p19_0)
    (let-values (((p_13) p19_0))
      (let-values (((in-len_0) (if len13_0 len7_0 #f)))
        (let-values (((drive-end_0) (if drive-end14_0 drive-end8_0 0)))
          (let-values (((no-slash-sep?_0) (if no-slash-sep?15_0 no-slash-sep?9_0 #f)))
            (let-values (((no-up?_0) (if no-up?16_0 no-up?10_0 #f)))
              (let-values (((allow-double-before_1) (if allow-double-before17_0 allow-double-before11_0 0)))
                (let-values (((explode?_1) explode?12_0))
                  (let-values ()
                    (let-values (((convention_7) (path-convention p_13)))
                      (let-values (((bstr_4)
                                    (if in-len_0
                                      (path-bytes p_13)
                                      (clean-double-slashes (path-bytes p_13) convention_7 allow-double-before_1))))
                        (let-values (((len_3)
                                      (let-values (((or-part_7) in-len_0))
                                        (if or-part_7 or-part_7 (bytes-length bstr_4)))))
                          (let-values (((split-pos_0 ends-sep?_0)
                                        ((letrec-values (((loop_5)
                                                          (lambda (i_2 ends-sep?_1)
                                                            (if (< i_2 drive-end_0)
                                                              (let-values () (values #f ends-sep?_1))
                                                              (let-values ()
                                                                (let-values (((sep?_0)
                                                                              (if no-slash-sep?_0
                                                                                (let-values ()
                                                                                  (eq? (bytes-ref bstr_4 i_2) '#\\))
                                                                                (let-values ()
                                                                                  (is-sep?
                                                                                   (bytes-ref bstr_4 i_2)
                                                                                   convention_7)))))
                                                                  (if sep?_0
                                                                    (let-values ()
                                                                      (if (< i_2 (sub1 len_3))
                                                                        (values i_2 ends-sep?_1)
                                                                        (loop_5 (sub1 i_2) #t)))
                                                                    (let-values ()
                                                                      (loop_5 (sub1 i_2) ends-sep?_1)))))))))
                                           loop_5)
                                         (sub1 len_3)
                                         #f)))
                            (if (not split-pos_0)
                              (let-values ()
                                (if (let-values (((or-part_8) (is-sep? (bytes-ref bstr_4 0) convention_7)))
                                      (if or-part_8 or-part_8 (positive? drive-end_0)))
                                  (let-values ()
                                    (let-values (((new-p_0) (path1.1 (subbytes bstr_4 0 len_3) convention_7)))
                                      (if explode?_1 (list new-p_0) (values #f new-p_0 #t))))
                                  (let-values ()
                                    (let-values (((name_0 is-dir?_0)
                                                  (let-values (((temp65_0) 0)
                                                               ((convention66_0) convention_7)
                                                               ((ends-sep?67_0) ends-sep?_0)
                                                               ((no-up?68_0) no-up?_0))
                                                    (split-tail31.1
                                                     ends-sep?67_0
                                                     no-up?68_0
                                                     bstr_4
                                                     len_3
                                                     temp65_0
                                                     convention66_0))))
                                      (if explode?_1 (list name_0) (values 'relative name_0 is-dir?_0))))))
                              (let-values ()
                                (let-values (((name_1 is-dir?_1)
                                              (let-values (((temp71_0) (add1 split-pos_0))
                                                           ((convention72_0) convention_7)
                                                           ((ends-sep?73_0) ends-sep?_0)
                                                           ((no-up?74_0) no-up?_0))
                                                (split-tail31.1
                                                 ends-sep?73_0
                                                 no-up?74_0
                                                 bstr_4
                                                 len_3
                                                 temp71_0
                                                 convention72_0))))
                                  (if (zero? split-pos_0)
                                    (let-values ()
                                      (let-values (((base_4)
                                                    (if (eq? (bytes-ref bstr_4 0) '#\/)
                                                      (path1.1 #"/" convention_7)
                                                      (path1.1 (subbytes bstr_4 0 1) convention_7))))
                                        (if explode?_1
                                          (let-values () (list name_1 base_4))
                                          (let-values () (values base_4 name_1 is-dir?_1)))))
                                    (let-values ()
                                      (let-values (((exposed-bstr_0 exposed-len_0)
                                                    (let-values (((temp76_0) (add1 split-pos_0))
                                                                 ((convention77_0) convention_7)
                                                                 ((no-up?78_0) no-up?_0))
                                                      (bytes->exposed-path-bytes39.1
                                                       no-up?78_0
                                                       bstr_4
                                                       temp76_0
                                                       convention77_0))))
                                        (if explode?_1
                                          (let-values ()
                                            (cons
                                             name_1
                                             (let-values (((temp79_0) (path1.1 exposed-bstr_0 convention_7))
                                                          ((temp80_0) #t)
                                                          ((exposed-len81_0) exposed-len_0)
                                                          ((drive-end82_0) drive-end_0)
                                                          ((no-slash-sep?83_0) no-slash-sep?_0)
                                                          ((no-up?84_0) no-up?_0)
                                                          ((allow-double-before85_0) allow-double-before_1))
                                               (split-after-drive20.1
                                                allow-double-before85_0
                                                #t
                                                drive-end82_0
                                                #t
                                                temp80_0
                                                exposed-len81_0
                                                #t
                                                no-slash-sep?83_0
                                                #t
                                                no-up?84_0
                                                #t
                                                temp79_0))))
                                          (let-values ()
                                            (let-values (((base_5)
                                                          (path1.1
                                                           (subbytes exposed-bstr_0 0 exposed-len_0)
                                                           convention_7)))
                                              (values base_5 name_1 is-dir?_1))))))))))))))))))))))))
 (define-values
  (split-tail31.1)
  (lambda (ends-sep?23_0 no-up?24_0 bstr27_0 len28_0 start-pos29_0 convention30_0)
    (let-values (((bstr_5) bstr27_0))
      (let-values (((len_4) len28_0))
        (let-values (((start-pos_0) start-pos29_0))
          (let-values (((convention_8) convention30_0))
            (let-values (((ends-sep?_2) ends-sep?23_0))
              (let-values (((no-up?_1) no-up?24_0))
                (let-values ()
                  (if (if (not no-up?_1)
                        (if (<= (+ start-pos_0 2) len_4)
                          (if (eq? (bytes-ref bstr_5 start-pos_0) (char->integer '#\.))
                            (if (eq? (bytes-ref bstr_5 (+ start-pos_0 1)) (char->integer '#\.))
                              (let-values (((or-part_9) (= (+ start-pos_0 2) len_4)))
                                (if or-part_9 or-part_9 (if (= (+ start-pos_0 3) len_4) ends-sep?_2 #f)))
                              #f)
                            #f)
                          #f)
                        #f)
                    (let-values () (values 'up #t))
                    (if (if (not no-up?_1)
                          (if (<= (+ start-pos_0 1) len_4)
                            (if (eq? (bytes-ref bstr_5 start-pos_0) (char->integer '#\.))
                              (let-values (((or-part_10) (= (+ start-pos_0 1) len_4)))
                                (if or-part_10 or-part_10 (if (= (+ start-pos_0 2) len_4) ends-sep?_2 #f)))
                              #f)
                            #f)
                          #f)
                      (let-values () (values 'same #t))
                      (let-values ()
                        (let-values (((new-bstr_1)
                                      (if ends-sep?_2
                                        (let-values () (subbytes bstr_5 start-pos_0 (sub1 len_4)))
                                        (if (zero? start-pos_0)
                                          (let-values () (bytes->immutable-bytes bstr_5))
                                          (let-values () (subbytes bstr_5 start-pos_0))))))
                          (let-values (((prot-bstr_0)
                                        (if (let-values (((or-part_11) no-up?_1))
                                              (if or-part_11 or-part_11 ends-sep?_2))
                                          (protect-path-element new-bstr_1 convention_8)
                                          new-bstr_1)))
                            (values (path1.1 prot-bstr_0 convention_8) ends-sep?_2)))))))))))))))
 (define-values
  (bytes->exposed-path-bytes39.1)
  (lambda (already-protected?34_0 bstr36_0 pos37_0 convention38_0)
    (let-values (((bstr_6) bstr36_0))
      (let-values (((pos_3) pos37_0)) (let-values () (let-values () (let-values () (values bstr_6 pos_3))))))))
 (define-values (protect-path-element) (lambda (new-bstr_2 convention_9) new-bstr_2))
 (define-values (parse-//?-drive) (lambda (bstr_7) (error "finish me")))
 (define-values (parse-//-drive) (lambda (bstr_8) (error "finish-me")))
 (define-values (split-reld) (lambda (bstr_9 drive-end_1) (error "finish-me")))
 (define-values
  (1/relative-path?)
  (lambda (p_14)
    (begin
      (check-path-argument 'relative-path? p_14)
      (if (1/path? p_14)
        (let-values ()
          (let-values (((tmp_1) (path-convention p_14)))
            (if (equal? tmp_1 'unix)
              (let-values ()
                (let-values (((bstr_10) (path-bytes p_14)))
                  ((lambda (p_15) (not (is-sep? (bytes-ref p_15 0) 'unix))) bstr_10)))
              (if (equal? tmp_1 'windows) (let-values () (error "much more here")) (let-values () (void))))))
        (if (string? p_14)
          (let-values ()
            (let-values (((tmp_2) (system-path-convention-type)))
              (if (equal? tmp_2 'unix)
                (let-values () ((lambda (p_6) (not (is-sep? (char->integer (string-ref p_6 0)) 'unix))) p_14))
                (if (equal? tmp_2 'windows) (let-values () (error "much more here")) (let-values () (void))))))
          (void))))))
 (define-values
  (1/absolute-path?)
  (lambda (p_16)
    (begin
      (check-path-argument 'absolute-path? p_16)
      (if (1/path? p_16)
        (let-values ()
          (let-values (((tmp_3) (path-convention p_16)))
            (if (equal? tmp_3 'unix)
              (let-values ()
                (let-values (((bstr_3) (path-bytes p_16))) ((lambda (p_17) (is-sep? (bytes-ref p_17 0) 'unix)) bstr_3)))
              (if (equal? tmp_3 'windows) (let-values () (error "much more here")) (let-values () (void))))))
        (if (string? p_16)
          (let-values ()
            (let-values (((tmp_4) (system-path-convention-type)))
              (if (equal? tmp_4 'unix)
                (let-values () ((lambda (p_18) (is-sep? (char->integer (string-ref p_18 0)) 'unix)) p_16))
                (if (equal? tmp_4 'windows) (let-values () (error "much more here")) (let-values () (void))))))
          (void))))))
 (define-values
  (1/complete-path?)
  (lambda (p_19)
    (begin
      (check-path-argument 'complete-path? p_19)
      (if (1/path? p_19)
        (let-values ()
          (let-values (((tmp_5) (path-convention p_19)))
            (if (equal? tmp_5 'unix)
              (let-values ()
                (let-values (((bstr_11) (path-bytes p_19))) ((lambda (p_2) (is-sep? (bytes-ref p_2 0) 'unix)) bstr_11)))
              (if (equal? tmp_5 'windows) (let-values () (error "much more here")) (let-values () (void))))))
        (if (string? p_19)
          (let-values ()
            (let-values (((tmp_6) (system-path-convention-type)))
              (if (equal? tmp_6 'unix)
                (let-values () ((lambda (p_20) (is-sep? (char->integer (string-ref p_20 0)) 'unix)) p_19))
                (if (equal? tmp_6 'windows) (let-values () (error "much more here")) (let-values () (void))))))
          (void))))))
 (define-values
  (1/path->directory-path)
  (lambda (p-in_0)
    (let-values ((() (begin (check-path-argument 'path->directory-path p-in_0) (values))))
      (let-values (((p_9) (->path p-in_0)))
        (if (directory-path? p_9)
          (let-values () p_9)
          (let-values ()
            (let-values (((tmp_0) (path-convention p_9)))
              (if (equal? tmp_0 'unix)
                (let-values () (path1.1 (bytes-append (path-bytes p_9) #"/") 'unix))
                (let-values () (error "path->dir-path for Windows"))))))))))
 (define-values
  (directory-path?)
  (lambda (p_21)
    (let-values (((bstr_2) (path-bytes p_21)))
      (let-values (((len_5) (bytes-length bstr_2)))
        (let-values (((tmp_7) (path-convention p_21)))
          (if (equal? tmp_7 'unix)
            (let-values ()
              (let-values (((or-part_12) (is-sep? (bytes-ref bstr_2 (sub1 len_5)) 'unix)))
                (if or-part_12
                  or-part_12
                  (let-values (((or-part_13)
                                (if (>= len_5 2)
                                  (if (eq? (bytes-ref bstr_2 (sub1 len_5)) (char->integer '#\.))
                                    (if (eq? (bytes-ref bstr_2 (- len_5 2)) (char->integer '#\.))
                                      (let-values (((or-part_14) (= len_5 2)))
                                        (if or-part_14 or-part_14 (is-sep? (bytes-ref bstr_2 (- len_5 3)) 'unix)))
                                      #f)
                                    #f)
                                  #f)))
                    (if or-part_13
                      or-part_13
                      (if (>= len_5 1)
                        (if (eq? (bytes-ref bstr_2 (sub1 len_5)) (char->integer '#\.))
                          (let-values (((or-part_15) (= len_5 1)))
                            (if or-part_15 or-part_15 (is-sep? (bytes-ref bstr_2 (- len_5 2)) 'unix)))
                          #f)
                        #f))))))
            (let-values () (error "dir-path? for Windows"))))))))
 (define-values
  (1/simplify-path)
  (let-values (((simplify-path4_0)
                (lambda (p-in3_0 use-filesystem?1_0 use-filesystem?2_0)
                  (let-values (((p-in_1) p-in3_0))
                    (let-values (((use-filesystem?_0) (if use-filesystem?2_0 use-filesystem?1_0 #t)))
                      (let-values ()
                        (let-values ((() (begin (check-path-argument 'simplify-path p-in_1) (values))))
                          (let-values (((p_22) (->path p-in_1)))
                            (let-values (((convention_1) (path-convention p_22)))
                              (if (simple? p_22 convention_1)
                                (let-values () p_22)
                                (let-values ()
                                  (let-values (((clean-p_0) (1/cleanse-path p_22)))
                                    (if (simple? clean-p_0 convention_1)
                                      (let-values () clean-p_0)
                                      (let-values ()
                                        (let-values (((l_2) (1/explode-path clean-p_0)))
                                          (let-values (((simpler-l_0)
                                                        ((letrec-values (((loop_6)
                                                                          (lambda (l_3 accum_0)
                                                                            (if (null? l_3)
                                                                              (let-values () (1/reverse accum_0))
                                                                              (if (eq? 'same (car l_3))
                                                                                (let-values ()
                                                                                  (loop_6 (cdr l_3) accum_0))
                                                                                (if (if (eq? 'up (car l_3))
                                                                                      (pair? accum_0)
                                                                                      #f)
                                                                                  (let-values ()
                                                                                    (loop_6 (cdr l_3) (cdr accum_0)))
                                                                                  (let-values ()
                                                                                    (loop_6
                                                                                     (cdr l_3)
                                                                                     (cons (car l_3) accum_0)))))))))
                                                           loop_6)
                                                         l_2
                                                         null)))
                                            (let-values (((simple-p_0) (apply 1/build-path simpler-l_0)))
                                              (if (directory-path? p_22)
                                                (1/path->directory-path simple-p_0)
                                                simple-p_0))))))))))))))))))
    (case-lambda
     ((p-in_2) (simplify-path4_0 p-in_2 #f #f))
     ((p-in_3 use-filesystem?1_1) (simplify-path4_0 p-in_3 use-filesystem?1_1 #t)))))
 (define-values
  (simple?)
  (lambda (p_14 convention_10)
    (let-values (((bstr_10) (path-bytes p_14)))
      (let-values (((len_6) (bytes-length bstr_10)))
        ((letrec-values (((loop_7)
                          (lambda (i_3)
                            (if (= i_3 len_6)
                              (let-values () #t)
                              (if (is-sep? (bytes-ref bstr_10 i_3) convention_10)
                                (let-values ()
                                  (if (= (add1 i_3) len_6)
                                    (let-values () #t)
                                    (if (is-sep? (bytes-ref bstr_10 (add1 i_3)) convention_10)
                                      (let-values () #f)
                                      (if (if (eq? (bytes-ref bstr_10 (add1 i_3)) (char->integer '#\.))
                                            (let-values (((or-part_3) (= (+ i_3 2) len_6)))
                                              (if or-part_3
                                                or-part_3
                                                (let-values (((or-part_4)
                                                              (is-sep? (bytes-ref bstr_10 (+ i_3 2)) convention_10)))
                                                  (if or-part_4
                                                    or-part_4
                                                    (if (eq? (bytes-ref bstr_10 (+ i_3 2)) (char->integer '#\.))
                                                      (let-values (((or-part_5) (= (+ i_3 3) len_6)))
                                                        (if or-part_5
                                                          or-part_5
                                                          (is-sep? (bytes-ref bstr_10 (+ i_3 3)) convention_10)))
                                                      #f)))))
                                            #f)
                                        (let-values () #f)
                                        (let-values () (loop_7 (add1 i_3)))))))
                                (if (if (zero? i_3)
                                      (if (eq? (bytes-ref bstr_10 0) (char->integer '#\.))
                                        (let-values (((or-part_16) (= 1 len_6)))
                                          (if or-part_16
                                            or-part_16
                                            (let-values (((or-part_17) (is-sep? (bytes-ref bstr_10 1) convention_10)))
                                              (if or-part_17
                                                or-part_17
                                                (if (eq? (bytes-ref bstr_10 1) (char->integer '#\.))
                                                  (let-values (((or-part_18) (= 2 len_6)))
                                                    (if or-part_18
                                                      or-part_18
                                                      (is-sep? (bytes-ref bstr_10 2) convention_10)))
                                                  #f)))))
                                        #f)
                                      #f)
                                  (let-values () #f)
                                  (let-values () (loop_7 (add1 i_3)))))))))
           loop_7)
         0)))))
 (define-values
  (1/path->complete-path)
  (case-lambda
   ((p_23) (let-values (((temp9_0) (current-directory)) ((temp10_0) #f)) (->complete-path5.1 temp10_0 p_23 temp9_0)))
   ((p_24 wrt_0) (let-values (((temp13_0) #t)) (->complete-path5.1 temp13_0 p_24 wrt_0)))))
 (define-values
  (->complete-path5.1)
  (lambda (wrt-given?1_0 p-in3_1 wrt4_0)
    (let-values (((p-in_4) p-in3_1))
      (let-values (((wrt_1) wrt4_0))
        (let-values (((wrt-given?_0) wrt-given?1_0))
          (let-values ()
            (let-values ((() (begin (check-path-argument 'path->complete-path p-in_4) (values))))
              (let-values ((()
                            (begin
                              (if wrt-given?_0
                                (let-values ()
                                  (if ((lambda (p_16)
                                         (if (let-values (((or-part_4) (path-string? p_16)))
                                               (if or-part_4 or-part_4 (1/path-for-some-system? p_16)))
                                           (1/complete-path? p_16)
                                           #f))
                                       wrt_1)
                                    (void)
                                    (let-values ()
                                      (raise-argument-error
                                       'path->complete-path
                                       "(and/c (or/c path-string? path-for-some-system?) complete-path?)"
                                       wrt_1))))
                                (void))
                              (values))))
                (let-values ((()
                              (begin
                                (if (eq? (convention-of-path p-in_4) (convention-of-path wrt_1))
                                  (void)
                                  (let-values ()
                                    (if wrt-given?_0
                                      (raise-arguments-error
                                       'path->complete-path
                                       "convention of first path incompatible with convention of second path"
                                       "first path"
                                       p-in_4
                                       "second path"
                                       wrt_1)
                                      (raise-arguments-error
                                       'path->complete-path
                                       "no second path supplied, and given path is not for the current platform"
                                       "given path"
                                       p-in_4))))
                                (values))))
                  (let-values (((p_6) (->path p-in_4)))
                    (if (1/complete-path? p_6)
                      (let-values () p_6)
                      (if (1/relative-path? p_6)
                        (let-values () (1/build-path wrt_1 p_6))
                        (let-values () (error "non-complete absolute path on windows"))))))))))))))
 (define-values
  (convention-of-path)
  (lambda (p_25) (if (1/path? p_25) (path-convention p_25) (system-path-convention-type))))
 (define-values
  (1/string->path)
  (lambda (s_2)
    (begin
      (if (string? s_2) (void) (let-values () (raise-argument-error 'string->path "string?" s_2)))
      (check-path-string 'string->path s_2)
      (string->path$1 s_2))))
 (define-values
  (1/path->string)
  (lambda (p_9)
    (begin
      (if (is-path? p_9) (void) (let-values () (raise-argument-error 'path->string "path?" p_9)))
      (bytes->string/locale (path-bytes p_9) '#\?))))
 (define-values
  (1/bytes->path)
  (let-values (((bytes->path4_0)
                (lambda (bstr3_0 convention1_0 convention2_0)
                  (let-values (((bstr_12) bstr3_0))
                    (let-values (((convention_1) (if convention2_0 convention1_0 (system-path-convention-type))))
                      (let-values ()
                        (begin
                          (if (bytes? bstr_12)
                            (void)
                            (let-values () (raise-argument-error 'bytes->path "bytes?" bstr_12)))
                          (check-convention 'bytes->path convention_1)
                          (check-path-bytes 'bytes->path bstr_12)
                          (path1.1 (bytes->immutable-bytes bstr_12) convention_1))))))))
    (case-lambda
     ((bstr_13) (bytes->path4_0 bstr_13 #f #f))
     ((bstr_14 convention1_1) (bytes->path4_0 bstr_14 convention1_1 #t)))))
 (define-values
  (1/path->bytes)
  (lambda (p_26)
    (begin
      (if (1/path? p_26) (void) (let-values () (raise-argument-error 'path->bytes "path-for-some-system?" p_26)))
      (bytes-copy (path-bytes p_26)))))
 (define-values
  (1/string->path-element)
  (lambda (s_3)
    (begin
      (if (string? s_3) (void) (let-values () (raise-argument-error 'string->path-element "string?" s_3)))
      (check-path-string 'string->path-element s_3)
      (do-bytes->path-element
       (string->bytes/locale s_3 '#\?)
       (system-path-convention-type)
       'string->path-element
       s_3))))
 (define-values
  (1/bytes->path-element)
  (let-values (((bytes->path-element9_0)
                (lambda (bstr8_0 convention6_0 convention7_0)
                  (let-values (((bstr_15) bstr8_0))
                    (let-values (((convention_11) (if convention7_0 convention6_0 (system-path-convention-type))))
                      (let-values ()
                        (begin
                          (if (bytes? bstr_15)
                            (void)
                            (let-values () (raise-argument-error 'bytes->path-element "bytes?" bstr_15)))
                          (check-convention 'bytes->path-element convention_11)
                          (check-path-bytes 'bytes->path-element bstr_15)
                          (do-bytes->path-element bstr_15 convention_11 'bytes->path-element bstr_15))))))))
    (case-lambda
     ((bstr_16) (bytes->path-element9_0 bstr_16 #f #f))
     ((bstr_10 convention6_1) (bytes->path-element9_0 bstr_10 convention6_1 #t)))))
 (define-values
  (path-element?)
  (lambda (p_5)
    (if (1/path? p_5)
      (let-values ()
        (let-values (((bstr_17) (path-bytes p_5)))
          (let-values (((convention_12) (path-convention p_5)))
            (if (not
                 (let-values (((vec_6 len_7)
                               (let-values (((vec_7) bstr_17))
                                 (begin
                                   (if (bytes? vec_7) (void) (let-values () (check-bytes vec_7)))
                                   (values vec_7 (unsafe-bytes-length vec_7)))))
                              ((start_0) 0))
                   (begin
                     #f
                     (if (exact-nonnegative-integer? start_0) (void) (let-values () (check-naturals start_0)))
                     ((letrec-values (((for-loop_3)
                                       (lambda (result_3 pos_4 pos_5)
                                         (if (if (unsafe-fx< pos_4 len_7) #t #f)
                                           (let-values (((c_7) (unsafe-bytes-ref vec_6 pos_4)) ((i_4) pos_5))
                                             (let-values (((result_4)
                                                           (let-values ()
                                                             (let-values (((result_5)
                                                                           (let-values ()
                                                                             (let-values ()
                                                                               (if (is-sep? c_7 convention_12)
                                                                                 i_4
                                                                                 #f)))))
                                                               (values result_5)))))
                                               (if (if (not ((lambda x_1 result_4) c_7))
                                                     (if (not ((lambda x_2 result_4) i_4)) (not #f) #f)
                                                     #f)
                                                 (for-loop_3 result_4 (unsafe-fx+ 1 pos_4) (+ pos_5 1))
                                                 result_4)))
                                           result_3))))
                        for-loop_3)
                      #f
                      0
                      start_0))))
              (let-values (((base_6 name_2 dir?_0) (1/split-path p_5))) (if (symbol? base_6) (1/path? name_2) #f))
              #f))))
      (let-values () #f))))
 (define-values
  (do-bytes->path-element)
  (lambda (bstr_18 convention_13 who_8 orig-arg_0)
    (let-values (((len_8) (bytes-length bstr_18)))
      (let-values (((p_4) (path1.1 (bytes->immutable-bytes bstr_18) convention_13)))
        (begin
          (if (path-element? p_4)
            (void)
            (let-values ()
              (raise-arguments-error
               who_8
               (string-append
                "cannot be converted to a path element;\n"
                " path can be split, is not relative, or names a special element")
               "argument"
               orig-arg_0)))
          p_4)))))
 (define-values
  (1/path-element->string)
  (lambda (p_27)
    (begin
      (if (path-element? p_27) (void) (let-values () (raise-argument-error 'path-element->string "path-element?" p_27)))
      (bytes->string/locale (path-bytes p_27) '#\?))))
 (define-values
  (1/path-element->bytes)
  (lambda (p_28)
    (begin
      (if (path-element? p_28) (void) (let-values () (raise-argument-error 'path-element->string "path-element?" p_28)))
      (bytes-copy (path-bytes p_28)))))
 (define-values
  (1/path<?)
  (case-lambda
   ((p_29) (begin (if (is-path? p_29) (void) (let-values () (raise-argument-error 'path<? "path?" p_29))) #t))
   ((p1_0 p2_0)
    (begin
      (if (is-path? p1_0) (void) (let-values () (raise-argument-error 'path<? "path?" p1_0)))
      (if (is-path? p2_0) (void) (let-values () (raise-argument-error 'path<? "path?" p2_0)))
      (bytes<? (path-bytes p1_0) (path-bytes p2_0))))
   ((p_30 . ps_0)
    (begin
      (if (is-path? p_30) (void) (let-values () (raise-argument-error 'path<? "path?" p_30)))
      ((letrec-values (((loop_8)
                        (lambda (bstr_19 ps_1)
                          (if (null? ps_1)
                            (let-values () #t)
                            (let-values ()
                              (let-values (((p_31) (car ps_1)))
                                (let-values ((()
                                              (begin
                                                (if (is-path? p_31)
                                                  (void)
                                                  (let-values () (raise-argument-error 'path<? "path?" p_31)))
                                                (values))))
                                  (let-values (((bstr2_0) (path-bytes p_31)))
                                    (if (bytes<? bstr_19 bstr2_0) (loop_8 bstr2_0 (cdr ps_1)) #f)))))))))
         loop_8)
       (path-bytes p_30)
       ps_0)))))
 (define-values
  (1/path-convention-type)
  (lambda (p_32)
    (begin
      (if (1/path-for-some-system? p_32)
        (void)
        (let-values () (raise-argument-error 'path-convention-type "path-for-some-system?" p_32)))
      (path-convention p_32)))))
