;; This is not the original source code. Instead, this is the code after
;; fully expanding and flattening into a single linklet.
(linklet
 ()
 ((1/peek-bytes! peek-bytes!)
  (1/peek-byte peek-byte)
  (1/write-bytes-avail write-bytes-avail)
  (1/open-input-file open-input-file)
  (1/write-bytes-avail* write-bytes-avail*)
  (1/bytes->string/locale bytes->string/locale)
  (1/read-bytes-avail!* read-bytes-avail!*)
  (1/make-pipe make-pipe)
  (1/write-string write-string)
  (1/open-input-bytes open-input-bytes)
  (1/read-string! read-string!)
  (1/string->bytes/latin-1 string->bytes/latin-1)
  (1/bytes->string/utf-8 bytes->string/utf-8)
  (1/string->bytes/utf-8 string->bytes/utf-8)
  (1/string->bytes/locale string->bytes/locale)
  (1/read-bytes read-bytes)
  (pipe-input-port? pipe-input-port?)
  (1/peek-char peek-char)
  (1/bytes-utf-8-length bytes-utf-8-length)
  (1/peek-string peek-string)
  (1/write-bytes-avail/enable-break write-bytes-avail/enable-break)
  (1/read-char read-char)
  (1/make-output-port make-output-port)
  (1/close-input-port close-input-port)
  (1/write-bytes write-bytes)
  (1/read-bytes-avail! read-bytes-avail!)
  (1/peek-string! peek-string!)
  (1/string-utf-8-length string-utf-8-length)
  (pipe-output-port? pipe-output-port?)
  (1/read-byte read-byte)
  (1/make-input-port make-input-port)
  (1/port-next-location port-next-location)
  (1/read-string read-string)
  (1/bytes->string/latin-1 bytes->string/latin-1)
  (1/port-count-lines! port-count-lines!)
  (1/peek-bytes-avail! peek-bytes-avail!)
  (1/pipe-content-length pipe-content-length)
  (1/peek-bytes-avail!* peek-bytes-avail!*)
  (1/read-bytes! read-bytes!)
  (1/peek-bytes peek-bytes)
  (1/close-output-port close-output-port))
 (define-values (bad-list$1) (lambda (who_0 orig-l_0) (raise-mismatch-error who_0 "not a proper list: " orig-l_0)))
 (define-values
  (memq memv member)
  (let-values ()
    (let-values ()
      (values
       (let-values (((memq_0)
                     (lambda (v_0 orig-l_1)
                       ((letrec-values (((loop_0)
                                         (lambda (ls_0)
                                           (if (null? ls_0)
                                             (let-values () #f)
                                             (if (not (pair? ls_0))
                                               (let-values () (bad-list$1 'memq orig-l_1))
                                               (if (eq? v_0 (car ls_0))
                                                 (let-values () ls_0)
                                                 (let-values () (loop_0 (cdr ls_0)))))))))
                          loop_0)
                        orig-l_1))))
         memq_0)
       (let-values (((memv_0)
                     (lambda (v_1 orig-l_2)
                       ((letrec-values (((loop_1)
                                         (lambda (ls_1)
                                           (if (null? ls_1)
                                             (let-values () #f)
                                             (if (not (pair? ls_1))
                                               (let-values () (bad-list$1 'memv orig-l_2))
                                               (if (eqv? v_1 (car ls_1))
                                                 (let-values () ls_1)
                                                 (let-values () (loop_1 (cdr ls_1)))))))))
                          loop_1)
                        orig-l_2))))
         memv_0)
       (let-values (((default_0)
                     (let-values (((member_0)
                                   (lambda (v_2 orig-l_3)
                                     ((letrec-values (((loop_2)
                                                       (lambda (ls_2)
                                                         (if (null? ls_2)
                                                           (let-values () #f)
                                                           (if (not (pair? ls_2))
                                                             (let-values () (bad-list$1 'member orig-l_3))
                                                             (if (equal? v_2 (car ls_2))
                                                               (let-values () ls_2)
                                                               (let-values () (loop_2 (cdr ls_2)))))))))
                                        loop_2)
                                      orig-l_3))))
                       member_0)))
         (let-values (((member_1)
                       (case-lambda
                        ((v_3 orig-l_4) (default_0 v_3 orig-l_4))
                        ((v_4 orig-l_5 eq?_0)
                         (begin
                           (if (if (procedure? eq?_0) (procedure-arity-includes? eq?_0 2) #f)
                             (void)
                             (raise-argument-error 'member "(procedure-arity-includes/c 2)" eq?_0))
                           ((let-values (((member_2)
                                          (lambda (v_5 orig-l_6)
                                            ((letrec-values (((loop_3)
                                                              (lambda (ls_3)
                                                                (if (null? ls_3)
                                                                  (let-values () #f)
                                                                  (if (not (pair? ls_3))
                                                                    (let-values () (bad-list$1 'member orig-l_6))
                                                                    (if (eq?_0 v_5 (car ls_3))
                                                                      (let-values () ls_3)
                                                                      (let-values () (loop_3 (cdr ls_3)))))))))
                                               loop_3)
                                             orig-l_6))))
                              member_2)
                            v_4
                            orig-l_5))))))
           member_1))))))
 (define-values
  (path-string?)
  (lambda (s_0)
    (let-values (((or-part_0) (path? s_0)))
      (if or-part_0
        or-part_0
        (if (string? s_0)
          (let-values (((or-part_1) (relative-path? s_0))) (if or-part_1 or-part_1 (absolute-path? s_0)))
          #f)))))
 (define-values
  (prop:procedure-accessor procedure-accessor? procedure-accessor-ref)
  (make-struct-type-property
   'procedure
   (lambda (v_6 info-l_0) (if (exact-integer? v_6) (make-struct-field-accessor (list-ref info-l_0 3) v_6) #f))))
 (define-values
  (new-prop:procedure new-procedure? new-procedure-ref)
  (make-struct-type-property 'procedure #f (list (cons prop:procedure values) (cons prop:procedure-accessor values))))
 (define-values
  (prop:stream stream-via-prop? stream-ref)
  (make-struct-type-property
   'stream
   (lambda (v_7 si_0)
     (begin
       (if (if (vector? v_7)
             (if (= 3 (vector-length v_7))
               (if (procedure? (vector-ref v_7 0))
                 (if (procedure-arity-includes? (vector-ref v_7 0) 1)
                   (if (procedure? (vector-ref v_7 1))
                     (if (procedure-arity-includes? (vector-ref v_7 1) 1)
                       (if (procedure? (vector-ref v_7 2)) (procedure-arity-includes? (vector-ref v_7 2) 1) #f)
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
            v_7)))
       (vector->immutable-vector v_7)))))
 (define-values
  (prop:gen-sequence sequence-via-prop? sequence-ref)
  (make-struct-type-property
   'sequence
   (lambda (v_8 si_1)
     (begin
       (if (if (procedure? v_8) (procedure-arity-includes? v_8 1) #f)
         (void)
         (let-values () (raise-argument-error 'guard-for-prop:sequence "(procedure-arity-includes/c 1)" v_8)))
       v_8))))
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
      (lambda (v_9) (let-values (((cont?_0) (range-ref v_9 2))) (if cont?_0 (not (cont?_0 (range-ref v_9 0))) #f)))
      (lambda (v_10) (range-ref v_10 0))
      (lambda (v_11) (make-range ((range-ref v_11 1) (range-ref v_11 0)) (range-ref v_11 1) (range-ref v_11 2)))))
    (cons
     prop:gen-sequence
     (lambda (v_12) (values values #f (range-ref v_12 1) (range-ref v_12 0) (range-ref v_12 2) #f #f))))))
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
      (lambda (v_13) (not (pair? (list-stream-ref v_13 0))))
      (lambda (v_14) (car (list-stream-ref v_14 0)))
      (lambda (v_15) (make-list-stream (cdr (list-stream-ref v_15 0))))))
    (cons prop:gen-sequence (lambda (v_16) (values car cdr values (list-stream-ref v_16 0) pair? #f #f))))))
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
      (lambda (v_17) ((do-stream-ref v_17 0)))
      (lambda (v_18) ((do-stream-ref v_18 1)))
      (lambda (v_19) ((do-stream-ref v_19 2))))))))
 (define-values (empty-stream) (make-do-stream (lambda () #t) void void))
 (define-values (no-empty-edge-table) (make-hash))
 (define-values (binary-or-text-desc) "(or/c 'binary 'text)")
 (define-values
  (open-input-file6.1)
  (lambda (for-module?2_0 for-module?4_0 mode1_0 mode3_0 path5_0)
    (let-values (((path_0) path5_0))
      (let-values (((mode_0) (if mode3_0 mode1_0 'binary)))
        (let-values (((for-module?_0) (if for-module?4_0 for-module?2_0 #f)))
          (let-values ()
            (begin
              (if (path-string? path_0)
                (void)
                (let-values () (raise-argument-error 'open-input-file "path-string?" path_0)))
              (if (memq mode_0 '(binary text))
                (void)
                (let-values () (raise-argument-error 'open-input-file binary-or-text-desc mode_0)))
              (open-input-file path_0 mode_0 (if for-module?_0 'module 'none)))))))))
 (define-values
  (struct:input-port
   input-port1.1
   1/input-port?
   input-port-name
   input-port-data
   input-port-read-byte
   input-port-read-in
   input-port-peek-byte
   input-port-peek-in
   input-port-close
   input-port-get-progress-evt
   input-port-commit
   input-port-get-location
   input-port-count-lines!
   input-port-closed?
   input-port-offset
   input-port-state
   input-port-cr-state
   input-port-line
   input-port-column
   input-port-position
   input-port-pending-eof?
   set-input-port-closed?!
   set-input-port-offset!
   set-input-port-state!
   set-input-port-cr-state!
   set-input-port-line!
   set-input-port-column!
   set-input-port-position!
   set-input-port-pending-eof?!)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'input-port
                     #f
                     19
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '(0 1 2 3 4 5 6 7 8 9 10)
                     #f
                     'input-port)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'name)
     (make-struct-field-accessor -ref_0 1 'data)
     (make-struct-field-accessor -ref_0 2 'read-byte)
     (make-struct-field-accessor -ref_0 3 'read-in)
     (make-struct-field-accessor -ref_0 4 'peek-byte)
     (make-struct-field-accessor -ref_0 5 'peek-in)
     (make-struct-field-accessor -ref_0 6 'close)
     (make-struct-field-accessor -ref_0 7 'get-progress-evt)
     (make-struct-field-accessor -ref_0 8 'commit)
     (make-struct-field-accessor -ref_0 9 'get-location)
     (make-struct-field-accessor -ref_0 10 'count-lines!)
     (make-struct-field-accessor -ref_0 11 'closed?)
     (make-struct-field-accessor -ref_0 12 'offset)
     (make-struct-field-accessor -ref_0 13 'state)
     (make-struct-field-accessor -ref_0 14 'cr-state)
     (make-struct-field-accessor -ref_0 15 'line)
     (make-struct-field-accessor -ref_0 16 'column)
     (make-struct-field-accessor -ref_0 17 'position)
     (make-struct-field-accessor -ref_0 18 'pending-eof?)
     (make-struct-field-mutator -set!_0 11 'closed?)
     (make-struct-field-mutator -set!_0 12 'offset)
     (make-struct-field-mutator -set!_0 13 'state)
     (make-struct-field-mutator -set!_0 14 'cr-state)
     (make-struct-field-mutator -set!_0 15 'line)
     (make-struct-field-mutator -set!_0 16 'column)
     (make-struct-field-mutator -set!_0 17 'position)
     (make-struct-field-mutator -set!_0 18 'pending-eof?))))
 (define-values
  (make-input-port24.1)
  (lambda (close8_0
           commit10_0
           commit21_0
           count-lines!12_0
           count-lines!23_0
           data3_0
           data14_0
           get-location11_0
           get-location22_0
           get-progress-evt9_0
           get-progress-evt20_0
           name2_0
           peek-byte6_0
           peek-byte17_0
           peek-in7_0
           read-byte4_0
           read-byte15_0
           read-in5_0)
    (let-values (((name_0) name2_0))
      (let-values (((data_0) (if data14_0 data3_0 #f)))
        (let-values (((read-byte_0) (if read-byte15_0 read-byte4_0 #f)))
          (let-values (((read-in_0) read-in5_0))
            (let-values (((peek-byte_0) (if peek-byte17_0 peek-byte6_0 #f)))
              (let-values (((peek-in_0) peek-in7_0))
                (let-values (((close_0) close8_0))
                  (let-values (((get-progress-evt_0) (if get-progress-evt20_0 get-progress-evt9_0 #f)))
                    (let-values (((commit_0) (if commit21_0 commit10_0 #f)))
                      (let-values (((get-location_0) (if get-location22_0 get-location11_0 #f)))
                        (let-values (((count-lines!_0) (if count-lines!23_0 count-lines!12_0 #f)))
                          (let-values ()
                            (input-port1.1
                             name_0
                             data_0
                             read-byte_0
                             read-in_0
                             peek-byte_0
                             peek-in_0
                             close_0
                             get-progress-evt_0
                             commit_0
                             get-location_0
                             count-lines!_0
                             #f
                             0
                             #f
                             #f
                             #f
                             #f
                             #f
                             #f)))))))))))))))
 (define-values
  (struct:output-port
   output-port1.1
   1/output-port?
   output-port-name
   output-port-data
   output-port-evt
   output-port-write-out
   output-port-close
   output-port-write-out-special
   output-port-get-write-evt
   output-port-get-write-special-evt
   output-port-get-location
   output-port-count-lines!
   output-port-buffer-mode
   output-port-closed?
   output-port-offset
   output-port-line
   output-port-column
   output-port-position
   set-output-port-closed?!
   set-output-port-offset!
   set-output-port-line!
   set-output-port-column!
   set-output-port-position!)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'output-port
                     #f
                     16
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '(0 1 2 3 4 5 6 7 8 9 10)
                     #f
                     'output-port)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'name)
     (make-struct-field-accessor -ref_0 1 'data)
     (make-struct-field-accessor -ref_0 2 'evt)
     (make-struct-field-accessor -ref_0 3 'write-out)
     (make-struct-field-accessor -ref_0 4 'close)
     (make-struct-field-accessor -ref_0 5 'write-out-special)
     (make-struct-field-accessor -ref_0 6 'get-write-evt)
     (make-struct-field-accessor -ref_0 7 'get-write-special-evt)
     (make-struct-field-accessor -ref_0 8 'get-location)
     (make-struct-field-accessor -ref_0 9 'count-lines!)
     (make-struct-field-accessor -ref_0 10 'buffer-mode)
     (make-struct-field-accessor -ref_0 11 'closed?)
     (make-struct-field-accessor -ref_0 12 'offset)
     (make-struct-field-accessor -ref_0 13 'line)
     (make-struct-field-accessor -ref_0 14 'column)
     (make-struct-field-accessor -ref_0 15 'position)
     (make-struct-field-mutator -set!_0 11 'closed?)
     (make-struct-field-mutator -set!_0 12 'offset)
     (make-struct-field-mutator -set!_0 13 'line)
     (make-struct-field-mutator -set!_0 14 'column)
     (make-struct-field-mutator -set!_0 15 'position))))
 (define-values
  (make-output-port22.1)
  (lambda (close6_0
           count-lines!11_0
           count-lines!21_0
           data3_1
           data13_0
           evt4_0
           get-location10_0
           get-location20_0
           get-write-evt8_0
           get-write-evt18_0
           get-write-special-evt9_0
           get-write-special-evt19_0
           name2_1
           write-out5_0
           write-out-special7_0
           write-out-special17_0)
    (let-values (((name_1) name2_1))
      (let-values (((data_1) (if data13_0 data3_1 #f)))
        (let-values (((evt_0) evt4_0))
          (let-values (((write-out_0) write-out5_0))
            (let-values (((close_1) close6_0))
              (let-values (((write-out-special_0) (if write-out-special17_0 write-out-special7_0 #f)))
                (let-values (((get-write-evt_0) (if get-write-evt18_0 get-write-evt8_0 #f)))
                  (let-values (((get-write-special-evt_0) (if get-write-special-evt19_0 get-write-special-evt9_0 #f)))
                    (let-values (((get-location_1) (if get-location20_0 get-location10_0 #f)))
                      (let-values (((count-lines!_1) (if count-lines!21_0 count-lines!11_0 #f)))
                        (let-values ()
                          (output-port1.1
                           name_1
                           data_1
                           evt_0
                           write-out_0
                           close_1
                           write-out-special_0
                           get-write-evt_0
                           get-write-special-evt_0
                           get-location_1
                           count-lines!_1
                           'block
                           #f
                           0
                           #f
                           #f
                           #f))))))))))))))
 (define-values (utf-8-max-aborts-amt) 3)
 (define-values
  (struct:utf-8-state utf-8-state1.1 utf-8-state? utf-8-state-accum utf-8-state-remaining utf-8-state-pending-amt)
  (let-values (((struct:_1 make-_1 ?_1 -ref_1 -set!_1)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'utf-8-state #f 3 0 #f null (current-inspector) #f '(0 1 2) #f 'utf-8-state)))))
    (values
     struct:_1
     make-_1
     ?_1
     (make-struct-field-accessor -ref_1 0 'accum)
     (make-struct-field-accessor -ref_1 1 'remaining)
     (make-struct-field-accessor -ref_1 2 'pending-amt))))
 (define-values
  (utf-8-decode!14.1)
  (lambda (abort-mode3_0
           abort-mode6_0
           error-char2_0
           error-char5_0
           state4_0
           state7_0
           in-bstr8_0
           in-start9_0
           in-end10_0
           out-str11_0
           out-start12_0
           out-end13_0)
    (let-values (((in-bstr_0) in-bstr8_0))
      (let-values (((in-start_0) in-start9_0))
        (let-values (((in-end_0) in-end10_0))
          (let-values (((out-str_0) out-str11_0))
            (let-values (((out-start_0) out-start12_0))
              (let-values (((out-end_0) out-end13_0))
                (let-values (((error-ch_0) (if error-char5_0 error-char2_0 #f)))
                  (let-values (((abort-mode_0) (if abort-mode6_0 abort-mode3_0 'error)))
                    (let-values (((state_0) (if state7_0 state4_0 #f)))
                      (let-values ()
                        (let-values (((base-i_0)
                                      (if state_0 (- in-start_0 (utf-8-state-pending-amt state_0)) in-start_0)))
                          (let-values (((accum_0) (if state_0 (utf-8-state-accum state_0) 0)))
                            (let-values (((remaining_0) (if state_0 (utf-8-state-remaining state_0) 0)))
                              ((letrec-values (((loop_4)
                                                (lambda (i_0 j_0 base-i_1 accum_1 remaining_1)
                                                  (let-values (((encoding-failure_0)
                                                                (lambda ()
                                                                  (if error-ch_0
                                                                    (let-values ()
                                                                      (let-values ((()
                                                                                    (begin
                                                                                      (if out-str_0
                                                                                        (let-values ()
                                                                                          (string-set!
                                                                                           out-str_0
                                                                                           j_0
                                                                                           error-ch_0))
                                                                                        (void))
                                                                                      (values))))
                                                                        (let-values (((next-j_0) (add1 j_0)))
                                                                          (let-values (((next-i_0) (add1 base-i_1)))
                                                                            (if (if out-end_0 (= next-j_0 out-end_0) #f)
                                                                              (let-values ()
                                                                                (values
                                                                                 (- next-i_0 in-start_0)
                                                                                 (- next-j_0 out-start_0)
                                                                                 'continues))
                                                                              (let-values ()
                                                                                (loop_4
                                                                                 next-i_0
                                                                                 next-j_0
                                                                                 next-i_0
                                                                                 0
                                                                                 0)))))))
                                                                    (let-values ()
                                                                      (values
                                                                       (- base-i_1 in-start_0)
                                                                       (- j_0 out-start_0)
                                                                       'error))))))
                                                    (let-values (((continue_0)
                                                                  (lambda ()
                                                                    (let-values (((next-j_1) (add1 j_0)))
                                                                      (let-values (((next-i_1) (add1 i_0)))
                                                                        (if (if out-end_0 (= next-j_1 out-end_0) #f)
                                                                          (let-values ()
                                                                            (values
                                                                             (- next-i_1 in-start_0)
                                                                             (- next-j_1 out-start_0)
                                                                             (if (= next-i_1 in-end_0)
                                                                               'complete
                                                                               'continues)))
                                                                          (let-values ()
                                                                            (loop_4
                                                                             next-i_1
                                                                             next-j_1
                                                                             next-i_1
                                                                             0
                                                                             0))))))))
                                                      (if (= i_0 in-end_0)
                                                        (let-values ()
                                                          (if (zero? remaining_1)
                                                            (let-values ()
                                                              (values
                                                               (- base-i_1 in-start_0)
                                                               (- j_0 out-start_0)
                                                               'complete))
                                                            (if (eq? abort-mode_0 'error)
                                                              (let-values () (encoding-failure_0))
                                                              (if (eq? abort-mode_0 'state)
                                                                (let-values ()
                                                                  (values
                                                                   (- i_0 in-start_0)
                                                                   (- j_0 out-start_0)
                                                                   (utf-8-state1.1
                                                                    accum_1
                                                                    remaining_1
                                                                    (- i_0 base-i_1))))
                                                                (let-values ()
                                                                  (values
                                                                   (- base-i_1 in-start_0)
                                                                   (- j_0 out-start_0)
                                                                   'aborts))))))
                                                        (if (< i_0 in-start_0)
                                                          (let-values () (encoding-failure_0))
                                                          (let-values ()
                                                            (let-values (((b_0) (bytes-ref in-bstr_0 i_0)))
                                                              (if (< b_0 128)
                                                                (let-values ()
                                                                  (if (zero? remaining_1)
                                                                    (let-values ()
                                                                      (begin
                                                                        (if out-str_0
                                                                          (let-values ()
                                                                            (string-set!
                                                                             out-str_0
                                                                             j_0
                                                                             (integer->char b_0)))
                                                                          (void))
                                                                        (continue_0)))
                                                                    (let-values () (encoding-failure_0))))
                                                                (let-values ()
                                                                  (if (= 128 (bitwise-and b_0 192))
                                                                    (let-values ()
                                                                      (if (zero? remaining_1)
                                                                        (let-values () (encoding-failure_0))
                                                                        (let-values ()
                                                                          (let-values (((next_0) (bitwise-and b_0 63)))
                                                                            (if (zero? next_0)
                                                                              (let-values () (encoding-failure_0))
                                                                              (let-values ()
                                                                                (let-values (((next-accum_0)
                                                                                              (+
                                                                                               (arithmetic-shift
                                                                                                accum_1
                                                                                                6)
                                                                                               next_0)))
                                                                                  (if (= 1 remaining_1)
                                                                                    (let-values ()
                                                                                      (if (if (< next-accum_0 1114111)
                                                                                            (not
                                                                                             (if (>= next-accum_0 55296)
                                                                                               (<= next-accum_0 57343)
                                                                                               #f))
                                                                                            #f)
                                                                                        (let-values ()
                                                                                          (begin
                                                                                            (if out-str_0
                                                                                              (let-values ()
                                                                                                (string-set!
                                                                                                 out-str_0
                                                                                                 j_0
                                                                                                 (integer->char
                                                                                                  next-accum_0)))
                                                                                              (void))
                                                                                            (continue_0)))
                                                                                        (let-values ()
                                                                                          (encoding-failure_0))))
                                                                                    (let-values ()
                                                                                      (loop_4
                                                                                       (add1 i_0)
                                                                                       j_0
                                                                                       base-i_1
                                                                                       next-accum_0
                                                                                       (sub1 remaining_1)))))))))))
                                                                    (if (not (zero? remaining_1))
                                                                      (let-values () (encoding-failure_0))
                                                                      (if (= 192 (bitwise-and b_0 224))
                                                                        (let-values ()
                                                                          (loop_4
                                                                           (add1 i_0)
                                                                           j_0
                                                                           i_0
                                                                           (bitwise-and b_0 31)
                                                                           1))
                                                                        (if (= 224 (bitwise-and b_0 240))
                                                                          (let-values ()
                                                                            (loop_4
                                                                             (add1 i_0)
                                                                             j_0
                                                                             i_0
                                                                             (bitwise-and b_0 15)
                                                                             2))
                                                                          (if (= 240 (bitwise-and b_0 248))
                                                                            (let-values ()
                                                                              (loop_4
                                                                               (add1 i_0)
                                                                               j_0
                                                                               i_0
                                                                               (bitwise-and b_0 7)
                                                                               3))
                                                                            (let-values ()
                                                                              (encoding-failure_0))))))))))))))))))
                                 loop_4)
                               in-start_0
                               out-start_0
                               base-i_0
                               accum_0
                               remaining_0))))))))))))))))
 (define-values
  (check-range)
  (lambda (who_1 start-pos_0 end-pos_0 max-end_0 in-value_0)
    (begin
      (if (> start-pos_0 max-end_0)
        (let-values () (raise-range-error who_1 "byte string" "starting " start-pos_0 in-value_0 0 max-end_0 #f))
        (void))
      (if (let-values (((or-part_2) (< end-pos_0 start-pos_0))) (if or-part_2 or-part_2 (> end-pos_0 max-end_0)))
        (let-values () (raise-range-error who_1 "byte string" "starting " end-pos_0 in-value_0 0 max-end_0 start-pos_0))
        (void)))))
 (define-values
  (1/port-count-lines!)
  (lambda (p_0)
    (if (1/input-port? p_0)
      (let-values ()
        (if (input-port-line p_0)
          (void)
          (let-values ()
            (let-values ((() (begin (set-input-port-line! p_0 1) (values))))
              (let-values ((() (begin (set-input-port-column! p_0 0) (values))))
                (let-values ((() (begin (set-input-port-position! p_0 1) (values))))
                  (let-values (((count-lines!_2) (input-port-count-lines! p_0)))
                    (if count-lines!_2 (let-values () (count-lines!_2)) (void)))))))))
      (if (1/output-port? p_0)
        (let-values ()
          (if (output-port-line p_0)
            (void)
            (let-values ()
              (let-values ((() (begin (set-output-port-line! p_0 1) (values))))
                (let-values ((() (begin (set-output-port-column! p_0 0) (values))))
                  (let-values ((() (begin (set-output-port-position! p_0 1) (values))))
                    (let-values (((count-lines!_3) (output-port-count-lines! p_0)))
                      (if count-lines!_3 (let-values () (count-lines!_3)) (void)))))))))
        (let-values ()
          (if ((lambda (x_0) #f) p_0)
            (void)
            (let-values () (raise-argument-error 'port-count-lines! "(or/c input-port? output-port?)" p_0))))))))
 (define-values
  (1/port-next-location)
  (lambda (p_1)
    (if (1/input-port? p_1)
      (let-values () (values (input-port-line p_1) (input-port-column p_1) (input-port-position p_1)))
      (if (1/output-port? p_1)
        (let-values () (values (output-port-line p_1) (output-port-column p_1) (output-port-position p_1)))
        (let-values ()
          (if ((lambda (x_1) #f) p_1)
            (void)
            (let-values () (raise-argument-error 'port-next-location "(or/c input-port? output-port?)" p_1))))))))
 (define-values
  (input-port-count!)
  (lambda (in_0 amt_0 bstr_0 start_0)
    (begin
      (set-input-port-offset! in_0 (+ amt_0 (input-port-offset in_0)))
      (if (input-port-line in_0)
        (let-values ()
          (let-values (((end_0) (+ start_0 amt_0)))
            ((letrec-values (((loop_5)
                              (lambda (i_1 span_0 line_0 column_0 position_0 state_1 cr-state_0)
                                (if (= i_1 end_0)
                                  (let-values ()
                                    (if (zero? span_0)
                                      (let-values ()
                                        (begin
                                          (set-input-port-line! in_0 line_0)
                                          (set-input-port-column! in_0 column_0)
                                          (set-input-port-position! in_0 position_0)
                                          (set-input-port-state! in_0 state_1)
                                          (set-input-port-cr-state! in_0 cr-state_0)))
                                      (let-values ()
                                        (let-values (((used-bytes_0 got-chars_0 new-state_0)
                                                      (let-values (((temp2_0) (- end_0 span_0))
                                                                   ((end3_0) end_0)
                                                                   ((temp4_0) #f)
                                                                   ((temp5_0) 0)
                                                                   ((temp6_0) #f)
                                                                   ((temp7_0) '#\?)
                                                                   ((temp8_0) 'state)
                                                                   ((state9_0) state_1))
                                                        (utf-8-decode!14.1
                                                         temp8_0
                                                         #t
                                                         temp7_0
                                                         #t
                                                         state9_0
                                                         #t
                                                         bstr_0
                                                         temp2_0
                                                         end3_0
                                                         temp4_0
                                                         temp5_0
                                                         temp6_0))))
                                          (loop_5
                                           end_0
                                           0
                                           line_0
                                           (+ column_0 got-chars_0)
                                           (+ position_0 got-chars_0)
                                           new-state_0
                                           #f)))))
                                  (let-values ()
                                    (let-values (((b_1) (bytes-ref bstr_0 i_1)))
                                      (let-values (((end-utf-8_0)
                                                    (lambda ()
                                                      (let-values (((used-bytes_1 got-chars_1 new-state_1)
                                                                    (let-values (((temp11_0) (- i_1 span_0))
                                                                                 ((i12_0) i_1)
                                                                                 ((temp13_0) #f)
                                                                                 ((temp14_0) 0)
                                                                                 ((temp15_0) #f)
                                                                                 ((temp16_0) '#\?)
                                                                                 ((state17_0) state_1))
                                                                      (utf-8-decode!14.1
                                                                       #f
                                                                       #f
                                                                       temp16_0
                                                                       #t
                                                                       state17_0
                                                                       #t
                                                                       bstr_0
                                                                       temp11_0
                                                                       i12_0
                                                                       temp13_0
                                                                       temp14_0
                                                                       temp15_0))))
                                                        (loop_5
                                                         end_0
                                                         0
                                                         line_0
                                                         (+ column_0 got-chars_1)
                                                         (+ position_0 got-chars_1)
                                                         new-state_1
                                                         #f)))))
                                        (if (eq? b_1 (char->integer '#\newline))
                                          (let-values ()
                                            (if (let-values (((or-part_3) state_1))
                                                  (if or-part_3 or-part_3 (not (zero? span_0))))
                                              (let-values () (end-utf-8_0))
                                              (if cr-state_0
                                                (let-values ()
                                                  (loop_5 (add1 i_1) 0 line_0 column_0 (add1 position_0) #f #f))
                                                (let-values ()
                                                  (loop_5 (add1 i_1) 0 (add1 line_0) 0 (add1 position_0) #f #f)))))
                                          (if (eq? b_1 (char->integer '#\return))
                                            (let-values ()
                                              (if (if (zero? span_0) (not state_1) #f)
                                                (loop_5 (add1 i_1) 0 (add1 line_0) 0 (add1 position_0) #f #t)
                                                (end-utf-8_0)))
                                            (if (eq? b_1 (char->integer '#\tab))
                                              (let-values ()
                                                (if (if (zero? span_0) (not state_1) #f)
                                                  (loop_5
                                                   (add1 i_1)
                                                   0
                                                   line_0
                                                   (+ column_0 (bitwise-and (+ column_0 7) -8))
                                                   (add1 position_0)
                                                   #f
                                                   #f)
                                                  (end-utf-8_0)))
                                              (if (< b_1 128)
                                                (let-values ()
                                                  (if (if (zero? span_0) (not state_1) #f)
                                                    (loop_5 (add1 i_1) 0 line_0 (add1 column_0) (add1 position_0) #f #f)
                                                    (loop_5
                                                     (add1 i_1)
                                                     (add1 span_0)
                                                     line_0
                                                     column_0
                                                     position_0
                                                     state_1
                                                     #f)))
                                                (let-values ()
                                                  (loop_5
                                                   (add1 i_1)
                                                   (add1 span_0)
                                                   line_0
                                                   column_0
                                                   position_0
                                                   state_1
                                                   #f)))))))))))))
               loop_5)
             start_0
             0
             (input-port-line in_0)
             (input-port-column in_0)
             (input-port-position in_0)
             (input-port-state in_0)
             (input-port-cr-state in_0))))
        (void)))))
 (define-values
  (input-port-count-byte!)
  (lambda (in_1 b_2)
    (begin
      (set-input-port-offset! in_1 (add1 (input-port-offset in_1)))
      (if (input-port-line in_1)
        (let-values ()
          (if (let-values (((or-part_4) (input-port-state in_1)))
                (if or-part_4
                  or-part_4
                  (let-values (((or-part_5) (input-port-cr-state in_1)))
                    (if or-part_5
                      or-part_5
                      (let-values (((or-part_6) (eq? b_2 (char->integer '#\return))))
                        (if or-part_6
                          or-part_6
                          (let-values (((or-part_7) (eq? b_2 (char->integer '#\newline))))
                            (if or-part_7 or-part_7 (eq? b_2 (char->integer '#\tab))))))))))
            (let-values () (input-port-count! in_1 1 (bytes b_2) 0))
            (let-values ()
              (begin
                (set-input-port-position! in_1 (add1 (input-port-position in_1)))
                (set-input-port-column! in_1 (add1 (input-port-column in_1)))))))
        (void)))))
 (define-values
  (read-some-bytes!12.1)
  (lambda (copy-bstr?2_0
           copy-bstr?5_0
           keep-eof?3_0
           keep-eof?6_0
           zero-ok?1_0
           zero-ok?4_0
           who7_0
           orig-in8_0
           bstr9_0
           start10_0
           end11_0)
    (let-values (((who_2) who7_0))
      (let-values (((orig-in_0) orig-in8_0))
        (let-values (((bstr_1) bstr9_0))
          (let-values (((start_1) start10_0))
            (let-values (((end_1) end11_0))
              (let-values (((zero-ok?_0) (if zero-ok?4_0 zero-ok?1_0 #f)))
                (let-values (((copy-bstr?_0) (if copy-bstr?5_0 copy-bstr?2_0 #t)))
                  (let-values (((keep-eof?_0) (if keep-eof?6_0 keep-eof?3_0 #f)))
                    (let-values ()
                      ((letrec-values (((loop_1)
                                        (lambda (in_2)
                                          (if (input-port-closed? in_2)
                                            (let-values ()
                                              (raise-arguments-error
                                               who_2
                                               "input port is closed"
                                               "input port"
                                               orig-in_0))
                                            (if (input-port-pending-eof? in_2)
                                              (let-values ()
                                                (begin
                                                  (if keep-eof?_0
                                                    (void)
                                                    (let-values () (set-input-port-pending-eof?! in_2 #f)))
                                                  eof))
                                              (let-values ()
                                                (let-values (((read-in_1) (input-port-read-in in_2)))
                                                  (if (procedure? read-in_1)
                                                    (let-values ()
                                                      (let-values (((v_20)
                                                                    (read-in_1 bstr_1 start_1 end_1 copy-bstr?_0)))
                                                        (if (exact-nonnegative-integer? v_20)
                                                          (let-values ()
                                                            (if (zero? v_20)
                                                              (let-values () (if zero-ok?_0 0 (loop_1 in_2)))
                                                              (if (<= v_20 (- end_1 start_1))
                                                                (let-values ()
                                                                  (begin
                                                                    (input-port-count! orig-in_0 v_20 bstr_1 start_1)
                                                                    v_20))
                                                                (let-values ()
                                                                  (raise-arguments-error
                                                                   who_2
                                                                   "result integer is larger than the supplied byte string"
                                                                   "result"
                                                                   v_20
                                                                   "byte-string length"
                                                                   (- end_1 start_1))))))
                                                          (if (eof-object? v_20)
                                                            (let-values () eof)
                                                            (let-values ()
                                                              (raise-result-error
                                                               who_2
                                                               "(or/c exact-nonnegative-integer? eof-object? evt? pipe-input-port? #f procedure?)"
                                                               v_20))))))
                                                    (let-values () (loop_1 read-in_1))))))))))
                         loop_1)
                       orig-in_0))))))))))))
 (define-values
  (peek-some-bytes!25.1)
  (lambda (copy-bstr?16_0
           copy-bstr?18_0
           zero-ok?15_0
           zero-ok?17_0
           who19_0
           orig-in20_0
           bstr21_0
           start22_0
           end23_0
           skip24_0)
    (let-values (((who_3) who19_0))
      (let-values (((orig-in_1) orig-in20_0))
        (let-values (((bstr_2) bstr21_0))
          (let-values (((start_2) start22_0))
            (let-values (((end_2) end23_0))
              (let-values (((skip_0) skip24_0))
                (let-values (((zero-ok?_1) (if zero-ok?17_0 zero-ok?15_0 #f)))
                  (let-values (((copy-bstr?_1) (if copy-bstr?18_0 copy-bstr?16_0 #t)))
                    (let-values ()
                      ((letrec-values (((loop_6)
                                        (lambda (in_3)
                                          (if (input-port-closed? in_3)
                                            (let-values ()
                                              (raise-arguments-error
                                               who_3
                                               "input port is closed"
                                               "input port"
                                               orig-in_1))
                                            (if (input-port-pending-eof? in_3)
                                              (let-values () eof)
                                              (let-values ()
                                                (let-values (((peek-in_1) (input-port-peek-in in_3)))
                                                  (if (procedure? peek-in_1)
                                                    (let-values ()
                                                      (let-values (((v_21)
                                                                    (peek-in_1
                                                                     bstr_2
                                                                     start_2
                                                                     end_2
                                                                     skip_0
                                                                     copy-bstr?_1)))
                                                        (if (exact-nonnegative-integer? v_21)
                                                          (let-values ()
                                                            (if (zero? v_21)
                                                              (let-values () (if zero-ok?_1 0 (loop_6 in_3)))
                                                              (if (<= v_21 (- end_2 start_2))
                                                                (let-values () v_21)
                                                                (let-values ()
                                                                  (raise-arguments-error
                                                                   who_3
                                                                   "result integer is larger than the supplied byte string"
                                                                   "result"
                                                                   v_21
                                                                   "byte-string length"
                                                                   (- end_2 start_2))))))
                                                          (if (eof-object? v_21)
                                                            (let-values () eof)
                                                            (let-values ()
                                                              (raise-result-error
                                                               who_3
                                                               "(or/c exact-nonnegative-integer? eof-object? evt? pipe-input-port? #f procedure?)"
                                                               v_21))))))
                                                    (let-values () (loop_6 peek-in_1))))))))))
                         loop_6)
                       orig-in_1))))))))))))
 (define-values
  (do-read-bytes!)
  (lambda (who_0 in_4 bstr_3 start_3 end_3)
    (let-values (((amt_1) (- end_3 start_3)))
      (let-values (((v_22)
                    (let-values (((who79_0) who_0)
                                 ((in80_0) in_4)
                                 ((bstr81_0) bstr_3)
                                 ((start82_0) start_3)
                                 ((end83_0) end_3))
                      (read-some-bytes!12.1 #f #f #f #f #f #f who79_0 in80_0 bstr81_0 start82_0 end83_0))))
        (if (not (exact-integer? v_22))
          (let-values () v_22)
          (if (= v_22 amt_1)
            (let-values () v_22)
            (let-values ()
              ((letrec-values (((loop_7)
                                (lambda (got_0)
                                  (let-values (((v_23)
                                                (let-values (((temp89_0) #t))
                                                  (read-some-bytes!12.1
                                                   #f
                                                   #f
                                                   temp89_0
                                                   #t
                                                   #f
                                                   #f
                                                   who_0
                                                   in_4
                                                   bstr_3
                                                   got_0
                                                   amt_1))))
                                    (if (eof-object? v_23)
                                      (let-values () got_0)
                                      (let-values ()
                                        (let-values (((new-got_0) (+ got_0 v_23)))
                                          (if (= new-got_0 amt_1)
                                            (let-values () amt_1)
                                            (let-values () (loop_7 new-got_0))))))))))
                 loop_7)
               v_22))))))))
 (define-values
  (1/read-byte)
  (let-values (((read-byte3_0)
                (lambda (in1_0 in2_0)
                  (let-values (((in_2) (if in2_0 in1_0 (current-input-port))))
                    (let-values ()
                      (let-values ((()
                                    (begin
                                      (if (1/input-port? in_2)
                                        (void)
                                        (let-values () (raise-argument-error 'read-byte "input-port?" in_2)))
                                      (values))))
                        (let-values (((read-byte_1) (input-port-read-byte in_2)))
                          (if read-byte_1
                            (let-values ()
                              (let-values (((b_3) (read-byte_1)))
                                (begin
                                  (if (eof-object? b_3) (void) (let-values () (input-port-count-byte! in_2 b_3)))
                                  b_3)))
                            (let-values ()
                              (let-values (((bstr_4) (make-bytes 1)))
                                (let-values (((v_24)
                                              (let-values (((temp90_0) 'read-byte)
                                                           ((in91_0) in_2)
                                                           ((bstr92_0) bstr_4)
                                                           ((temp93_0) 0)
                                                           ((temp94_0) 1)
                                                           ((temp95_0) #f))
                                                (read-some-bytes!12.1
                                                 temp95_0
                                                 #t
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 temp90_0
                                                 in91_0
                                                 bstr92_0
                                                 temp93_0
                                                 temp94_0))))
                                  (if (eq? v_24 1) (bytes-ref bstr_4 1) v_24))))))))))))
    (case-lambda (() (read-byte3_0 #f #f)) ((in1_1) (read-byte3_0 in1_1 #t)))))
 (define-values
  (1/read-bytes)
  (let-values (((read-bytes8_0)
                (lambda (amt7_0 in5_0 in6_0)
                  (let-values (((amt_2) amt7_0))
                    (let-values (((in_5) (if in6_0 in5_0 (current-input-port))))
                      (let-values ()
                        (let-values ((()
                                      (begin
                                        (if (exact-nonnegative-integer? amt_2)
                                          (void)
                                          (let-values ()
                                            (raise-argument-error 'read-bytes "exact-nonnegative-integer?" amt_2)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (if (1/input-port? in_5)
                                            (void)
                                            (let-values () (raise-argument-error 'read-bytes "input-port?" in_5)))
                                          (values))))
                            (let-values (((bstr_5) (make-bytes amt_2)))
                              (let-values (((v_25) (do-read-bytes! 'read-bytes in_5 bstr_5 0 amt_2)))
                                (if (exact-integer? v_25)
                                  (if (= v_25 amt_2) bstr_5 (subbytes bstr_5 0 v_25))
                                  v_25)))))))))))
    (case-lambda ((amt_3) (read-bytes8_0 amt_3 #f #f)) ((amt_4 in5_1) (read-bytes8_0 amt_4 in5_1 #t)))))
 (define-values
  (1/read-bytes!)
  (let-values (((read-bytes!17_0)
                (lambda (bstr16_0 in10_0 start-pos11_0 end-pos12_0 in13_0 start-pos14_0 end-pos15_0)
                  (let-values (((bstr_6) bstr16_0))
                    (let-values (((in_6) (if in13_0 in10_0 (current-input-port))))
                      (let-values (((start-pos_1) (if start-pos14_0 start-pos11_0 0)))
                        (let-values (((end-pos_1)
                                      (if end-pos15_0 end-pos12_0 (if (bytes? bstr_6) (bytes-length bstr_6) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_6)
                                (void)
                                (let-values () (raise-argument-error 'read-bytes! "bytes?" bstr_6)))
                              (if (1/input-port? in_6)
                                (void)
                                (let-values () (raise-argument-error 'read-bytes! "input-port?" in_6)))
                              (if (exact-nonnegative-integer? start-pos_1)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'read-bytes! "exact-nonnegative-integer?" start-pos_1)))
                              (if (exact-nonnegative-integer? end-pos_1)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'read-bytes! "exact-nonnegative-integer?" end-pos_1)))
                              (check-range 'read-bytes! start-pos_1 end-pos_1 (bytes-length bstr_6) bstr_6)
                              (do-read-bytes! 'read-bytes! in_6 bstr_6 start-pos_1 end-pos_1))))))))))
    (case-lambda
     ((bstr_7) (read-bytes!17_0 bstr_7 #f #f #f #f #f #f))
     ((bstr_8 in_7 start-pos_2 end-pos12_1) (read-bytes!17_0 bstr_8 in_7 start-pos_2 end-pos12_1 #t #t #t))
     ((bstr_9 in_8 start-pos11_1) (read-bytes!17_0 bstr_9 in_8 start-pos11_1 #f #t #t #f))
     ((bstr_10 in10_1) (read-bytes!17_0 bstr_10 in10_1 #f #f #t #f #f)))))
 (define-values
  (1/read-bytes-avail!)
  (let-values (((read-bytes-avail!26_0)
                (lambda (bstr25_0 in19_0 start-pos20_0 end-pos21_0 in22_0 start-pos23_0 end-pos24_0)
                  (let-values (((bstr_2) bstr25_0))
                    (let-values (((in_9) (if in22_0 in19_0 (current-input-port))))
                      (let-values (((start-pos_3) (if start-pos23_0 start-pos20_0 0)))
                        (let-values (((end-pos_2)
                                      (if end-pos24_0 end-pos21_0 (if (bytes? bstr_2) (bytes-length bstr_2) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_2)
                                (void)
                                (let-values () (raise-argument-error 'read-bytes-avail! "bytes?" bstr_2)))
                              (if (1/input-port? in_9)
                                (void)
                                (let-values () (raise-argument-error 'read-bytes-avail! "input-port?" in_9)))
                              (if (exact-nonnegative-integer? start-pos_3)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'read-bytes-avail! "exact-nonnegative-integer?" start-pos_3)))
                              (if (exact-nonnegative-integer? end-pos_2)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'read-bytes-avail! "exact-nonnegative-integer?" end-pos_2)))
                              (check-range 'read-bytes-avail! start-pos_3 end-pos_2 (bytes-length bstr_2) bstr_2)
                              (let-values (((temp96_0) 'read-bytes-avail!)
                                           ((in97_0) in_9)
                                           ((bstr98_0) bstr_2)
                                           ((start-pos99_0) start-pos_3)
                                           ((end-pos100_0) end-pos_2))
                                (read-some-bytes!12.1
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 temp96_0
                                 in97_0
                                 bstr98_0
                                 start-pos99_0
                                 end-pos100_0)))))))))))
    (case-lambda
     ((bstr_11) (read-bytes-avail!26_0 bstr_11 #f #f #f #f #f #f))
     ((bstr_12 in_10 start-pos_4 end-pos21_1) (read-bytes-avail!26_0 bstr_12 in_10 start-pos_4 end-pos21_1 #t #t #t))
     ((bstr_13 in_11 start-pos20_1) (read-bytes-avail!26_0 bstr_13 in_11 start-pos20_1 #f #t #t #f))
     ((bstr_14 in19_1) (read-bytes-avail!26_0 bstr_14 in19_1 #f #f #t #f #f)))))
 (define-values
  (1/read-bytes-avail!*)
  (let-values (((read-bytes-avail!*35_0)
                (lambda (bstr34_0 in28_0 start-pos29_0 end-pos30_0 in31_0 start-pos32_0 end-pos33_0)
                  (let-values (((bstr_15) bstr34_0))
                    (let-values (((in_12) (if in31_0 in28_0 (current-input-port))))
                      (let-values (((start-pos_5) (if start-pos32_0 start-pos29_0 0)))
                        (let-values (((end-pos_3)
                                      (if end-pos33_0 end-pos30_0 (if (bytes? bstr_15) (bytes-length bstr_15) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_15)
                                (void)
                                (let-values () (raise-argument-error 'read-bytes-avail!* "bytes?" bstr_15)))
                              (if (1/input-port? in_12)
                                (void)
                                (let-values () (raise-argument-error 'read-bytes-avail!* "input-port?" in_12)))
                              (if (exact-nonnegative-integer? start-pos_5)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'read-bytes-avail!* "exact-nonnegative-integer?" start-pos_5)))
                              (if (exact-nonnegative-integer? end-pos_3)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'read-bytes-avail!* "exact-nonnegative-integer?" end-pos_3)))
                              (check-range 'read-bytes-avail!* start-pos_5 end-pos_3 (bytes-length bstr_15) bstr_15)
                              (let-values (((temp101_0) 'read-bytes-avail!*)
                                           ((in102_0) in_12)
                                           ((bstr103_0) bstr_15)
                                           ((start-pos104_0) start-pos_5)
                                           ((end-pos105_0) end-pos_3)
                                           ((temp106_0) #t))
                                (read-some-bytes!12.1
                                 #f
                                 #f
                                 #f
                                 #f
                                 temp106_0
                                 #t
                                 temp101_0
                                 in102_0
                                 bstr103_0
                                 start-pos104_0
                                 end-pos105_0)))))))))))
    (case-lambda
     ((bstr_16) (read-bytes-avail!*35_0 bstr_16 #f #f #f #f #f #f))
     ((bstr_17 in_13 start-pos_6 end-pos30_1) (read-bytes-avail!*35_0 bstr_17 in_13 start-pos_6 end-pos30_1 #t #t #t))
     ((bstr_18 in_14 start-pos29_1) (read-bytes-avail!*35_0 bstr_18 in_14 start-pos29_1 #f #t #t #f))
     ((bstr_19 in28_1) (read-bytes-avail!*35_0 bstr_19 in28_1 #f #f #t #f #f)))))
 (define-values
  (do-peek-bytes!)
  (lambda (who_4 in_15 bstr_20 start_4 end_4 skip_1)
    (let-values (((amt_5) (- end_4 start_4)))
      (let-values (((v_26)
                    (let-values (((who107_0) who_4)
                                 ((in108_0) in_15)
                                 ((bstr109_0) bstr_20)
                                 ((start110_0) start_4)
                                 ((end111_0) end_4)
                                 ((skip112_0) skip_1))
                      (peek-some-bytes!25.1 #f #f #f #f who107_0 in108_0 bstr109_0 start110_0 end111_0 skip112_0))))
        (if (exact-integer? v_26)
          (if (= v_26 amt_5)
            (let-values () v_26)
            (let-values ()
              ((letrec-values (((loop_8)
                                (lambda (got_1)
                                  (let-values (((v_27)
                                                (let-values (((temp118_0) (+ got_1 skip_1)) ((temp119_0) #f))
                                                  (peek-some-bytes!25.1
                                                   temp119_0
                                                   #t
                                                   #f
                                                   #f
                                                   who_4
                                                   in_15
                                                   bstr_20
                                                   got_1
                                                   amt_5
                                                   temp118_0))))
                                    (if (eof-object? v_27)
                                      (let-values () got_1)
                                      (let-values ()
                                        (let-values (((new-got_1) (+ got_1 v_27)))
                                          (if (= new-got_1 amt_5)
                                            (let-values () amt_5)
                                            (let-values () (loop_8 new-got_1))))))))))
                 loop_8)
               v_26)))
          v_26)))))
 (define-values
  (1/peek-byte)
  (let-values (((peek-byte41_0)
                (lambda (in37_0 skip-k38_0 in39_0 skip-k40_0)
                  (let-values (((in_16) (if in39_0 in37_0 (current-input-port))))
                    (let-values (((skip-k_0) (if skip-k40_0 skip-k38_0 0)))
                      (let-values ()
                        (let-values ((()
                                      (begin
                                        (if (1/input-port? in_16)
                                          (void)
                                          (let-values () (raise-argument-error 'peek-byte "input-port?" in_16)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (if (exact-nonnegative-integer? skip-k_0)
                                            (void)
                                            (let-values ()
                                              (raise-argument-error 'peek-byte "exact-nonnegative-integer?" skip-k_0)))
                                          (values))))
                            (let-values (((peek-byte_1) (if (zero? skip-k_0) (input-port-read-byte in_16) #f)))
                              (if peek-byte_1
                                (let-values () (peek-byte_1))
                                (let-values ()
                                  (let-values (((bstr_21) (make-bytes 1)))
                                    (let-values (((v_28)
                                                  (let-values (((temp120_0) 'peek-byte)
                                                               ((in121_0) in_16)
                                                               ((bstr122_0) bstr_21)
                                                               ((temp123_0) 0)
                                                               ((temp124_0) 1)
                                                               ((skip-k125_0) skip-k_0)
                                                               ((temp126_0) #f))
                                                    (peek-some-bytes!25.1
                                                     temp126_0
                                                     #t
                                                     #f
                                                     #f
                                                     temp120_0
                                                     in121_0
                                                     bstr122_0
                                                     temp123_0
                                                     temp124_0
                                                     skip-k125_0))))
                                      (if (eq? v_28 1) (bytes-ref bstr_21 1) v_28))))))))))))))
    (case-lambda
     (() (peek-byte41_0 #f #f #f #f))
     ((in_17 skip-k38_1) (peek-byte41_0 in_17 skip-k38_1 #t #t))
     ((in37_1) (peek-byte41_0 in37_1 #f #t #f)))))
 (define-values
  (1/peek-bytes)
  (let-values (((peek-bytes47_0)
                (lambda (amt45_0 skip-k46_0 in43_0 in44_0)
                  (let-values (((amt_6) amt45_0))
                    (let-values (((skip-k_1) skip-k46_0))
                      (let-values (((in_18) (if in44_0 in43_0 (current-input-port))))
                        (let-values ()
                          (let-values ((()
                                        (begin
                                          (if (exact-nonnegative-integer? amt_6)
                                            (void)
                                            (let-values ()
                                              (raise-argument-error 'peek-bytes "exact-nonnegative-integer?" amt_6)))
                                          (values))))
                            (let-values ((()
                                          (begin
                                            (if (exact-nonnegative-integer? skip-k_1)
                                              (void)
                                              (let-values ()
                                                (raise-argument-error
                                                 'peek-bytes
                                                 "exact-nonnegative-integer?"
                                                 skip-k_1)))
                                            (values))))
                              (let-values ((()
                                            (begin
                                              (if (1/input-port? in_18)
                                                (void)
                                                (let-values () (raise-argument-error 'peek-bytes "input-port?" in_18)))
                                              (values))))
                                (let-values (((bstr_22) (make-bytes amt_6)))
                                  (let-values (((v_29) (do-peek-bytes! 'read-bytes in_18 bstr_22 0 amt_6 skip-k_1)))
                                    (if (exact-integer? v_29)
                                      (if (= v_29 amt_6) bstr_22 (subbytes bstr_22 0 v_29))
                                      v_29)))))))))))))
    (case-lambda
     ((amt_7 skip-k_2) (peek-bytes47_0 amt_7 skip-k_2 #f #f))
     ((amt_8 skip-k_3 in43_1) (peek-bytes47_0 amt_8 skip-k_3 in43_1 #t)))))
 (define-values
  (1/peek-bytes!)
  (let-values (((peek-bytes!57_0)
                (lambda (bstr55_0 skip-k56_0 in49_0 start-pos50_0 end-pos51_0 in52_0 start-pos53_0 end-pos54_0)
                  (let-values (((bstr_23) bstr55_0))
                    (let-values (((skip-k_4) skip-k56_0))
                      (let-values (((in_19) (if in52_0 in49_0 (current-input-port))))
                        (let-values (((start-pos_7) (if start-pos53_0 start-pos50_0 0)))
                          (let-values (((end-pos_4)
                                        (if end-pos54_0 end-pos51_0 (if (bytes? bstr_23) (bytes-length bstr_23) #f))))
                            (let-values ()
                              (begin
                                (if (bytes? bstr_23)
                                  (void)
                                  (let-values () (raise-argument-error 'peek-bytes! "bytes?" bstr_23)))
                                (if (exact-nonnegative-integer? skip-k_4)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-bytes! "exact-nonnegative-integer?" skip-k_4)))
                                (if (1/input-port? in_19)
                                  (void)
                                  (let-values () (raise-argument-error 'peek-bytes! "input-port?" in_19)))
                                (if (exact-nonnegative-integer? start-pos_7)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-bytes! "exact-nonnegative-integer?" start-pos_7)))
                                (if (exact-nonnegative-integer? end-pos_4)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-bytes! "exact-nonnegative-integer?" end-pos_4)))
                                (check-range 'peek-bytes! start-pos_7 end-pos_4 (bytes-length bstr_23) bstr_23)
                                (do-peek-bytes! 'peek-bytes! in_19 bstr_23 start-pos_7 end-pos_4 skip-k_4)))))))))))
    (case-lambda
     ((bstr_24 skip-k_5) (peek-bytes!57_0 bstr_24 skip-k_5 #f #f #f #f #f #f))
     ((bstr_25 skip-k_6 in_20 start-pos_8 end-pos51_1)
      (peek-bytes!57_0 bstr_25 skip-k_6 in_20 start-pos_8 end-pos51_1 #t #t #t))
     ((bstr_26 skip-k_7 in_21 start-pos50_1) (peek-bytes!57_0 bstr_26 skip-k_7 in_21 start-pos50_1 #f #t #t #f))
     ((bstr_27 skip-k_8 in49_1) (peek-bytes!57_0 bstr_27 skip-k_8 in49_1 #f #f #t #f #f)))))
 (define-values
  (1/peek-bytes-avail!)
  (let-values (((peek-bytes-avail!67_0)
                (lambda (bstr65_0 skip-k66_0 in59_0 start-pos60_0 end-pos61_0 in62_0 start-pos63_0 end-pos64_0)
                  (let-values (((bstr_28) bstr65_0))
                    (let-values (((skip-k_9) skip-k66_0))
                      (let-values (((in_22) (if in62_0 in59_0 (current-input-port))))
                        (let-values (((start-pos_9) (if start-pos63_0 start-pos60_0 0)))
                          (let-values (((end-pos_5)
                                        (if end-pos64_0 end-pos61_0 (if (bytes? bstr_28) (bytes-length bstr_28) #f))))
                            (let-values ()
                              (begin
                                (if (bytes? bstr_28)
                                  (void)
                                  (let-values () (raise-argument-error 'peek-bytes-avail! "bytes?" bstr_28)))
                                (if (exact-nonnegative-integer? skip-k_9)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-bytes-avail! "exact-nonnegative-integer?" skip-k_9)))
                                (if (1/input-port? in_22)
                                  (void)
                                  (let-values () (raise-argument-error 'peek-bytes-avail! "input-port?" in_22)))
                                (if (exact-nonnegative-integer? start-pos_9)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-bytes-avail! "exact-nonnegative-integer?" start-pos_9)))
                                (if (exact-nonnegative-integer? end-pos_5)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-bytes-avail! "exact-nonnegative-integer?" end-pos_5)))
                                (check-range 'peek-bytes-avail! start-pos_9 end-pos_5 (bytes-length bstr_28) bstr_28)
                                (let-values (((temp127_0) 'peek-bytes-avail!)
                                             ((bstr128_0) bstr_28)
                                             ((in129_0) in_22)
                                             ((start-pos130_0) start-pos_9)
                                             ((end-pos131_0) end-pos_5)
                                             ((skip-k132_0) skip-k_9))
                                  (peek-some-bytes!25.1
                                   #f
                                   #f
                                   #f
                                   #f
                                   temp127_0
                                   bstr128_0
                                   in129_0
                                   start-pos130_0
                                   end-pos131_0
                                   skip-k132_0))))))))))))
    (case-lambda
     ((bstr_29 skip-k_10) (peek-bytes-avail!67_0 bstr_29 skip-k_10 #f #f #f #f #f #f))
     ((bstr_30 skip-k_11 in_23 start-pos_10 end-pos61_1)
      (peek-bytes-avail!67_0 bstr_30 skip-k_11 in_23 start-pos_10 end-pos61_1 #t #t #t))
     ((bstr_31 skip-k_12 in_24 start-pos60_1) (peek-bytes-avail!67_0 bstr_31 skip-k_12 in_24 start-pos60_1 #f #t #t #f))
     ((bstr_32 skip-k_13 in59_1) (peek-bytes-avail!67_0 bstr_32 skip-k_13 in59_1 #f #f #t #f #f)))))
 (define-values
  (1/peek-bytes-avail!*)
  (let-values (((peek-bytes-avail!*77_0)
                (lambda (bstr75_0 skip-k76_0 in69_0 start-pos70_0 end-pos71_0 in72_0 start-pos73_0 end-pos74_0)
                  (let-values (((bstr_33) bstr75_0))
                    (let-values (((skip-k_14) skip-k76_0))
                      (let-values (((in_25) (if in72_0 in69_0 (current-input-port))))
                        (let-values (((start-pos_11) (if start-pos73_0 start-pos70_0 0)))
                          (let-values (((end-pos_6)
                                        (if end-pos74_0 end-pos71_0 (if (bytes? bstr_33) (bytes-length bstr_33) #f))))
                            (let-values ()
                              (begin
                                (if (bytes? bstr_33)
                                  (void)
                                  (let-values () (raise-argument-error 'peek-bytes-avail!* "bytes?" bstr_33)))
                                (if (exact-nonnegative-integer? skip-k_14)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-bytes-avail! "exact-nonnegative-integer?" skip-k_14)))
                                (if (1/input-port? in_25)
                                  (void)
                                  (let-values () (raise-argument-error 'peek-bytes-avail!* "input-port?" in_25)))
                                (if (exact-nonnegative-integer? start-pos_11)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error
                                     'peek-bytes-avail!*
                                     "exact-nonnegative-integer?"
                                     start-pos_11)))
                                (if (exact-nonnegative-integer? end-pos_6)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-bytes-avail!* "exact-nonnegative-integer?" end-pos_6)))
                                (check-range 'peek-bytes-avail!* start-pos_11 end-pos_6 (bytes-length bstr_33) bstr_33)
                                (let-values (((temp133_0) 'peek-bytes-avail!*)
                                             ((bstr134_0) bstr_33)
                                             ((in135_0) in_25)
                                             ((start-pos136_0) start-pos_11)
                                             ((end-pos137_0) end-pos_6)
                                             ((skip-k138_0) skip-k_14)
                                             ((temp139_0) #t))
                                  (peek-some-bytes!25.1
                                   #f
                                   #f
                                   temp139_0
                                   #t
                                   temp133_0
                                   bstr134_0
                                   in135_0
                                   start-pos136_0
                                   end-pos137_0
                                   skip-k138_0))))))))))))
    (case-lambda
     ((bstr_34 skip-k_15) (peek-bytes-avail!*77_0 bstr_34 skip-k_15 #f #f #f #f #f #f))
     ((bstr_35 skip-k_16 in_26 start-pos_12 end-pos71_1)
      (peek-bytes-avail!*77_0 bstr_35 skip-k_16 in_26 start-pos_12 end-pos71_1 #t #t #t))
     ((bstr_36 skip-k_17 in_27 start-pos70_1)
      (peek-bytes-avail!*77_0 bstr_36 skip-k_17 in_27 start-pos70_1 #f #t #t #f))
     ((bstr_37 skip-k_18 in69_1) (peek-bytes-avail!*77_0 bstr_37 skip-k_18 in69_1 #f #f #t #f #f)))))
 (define-values
  (read-some-chars!16.1)
  (lambda (extra-bytes-amt2_0
           extra-bytes-amt7_0
           just-peek?4_0
           just-peek?9_0
           keep-eof?3_1
           keep-eof?8_0
           skip5_0
           skip10_0
           zero-ok?1_1
           zero-ok?6_0
           who11_0
           orig-in12_0
           str13_0
           start14_0
           end15_0)
    (let-values (((who_5) who11_0))
      (let-values (((orig-in_2) orig-in12_0))
        (let-values (((str_0) str13_0))
          (let-values (((start_5) start14_0))
            (let-values (((end_5) end15_0))
              (let-values (((zero-ok?_2) (if zero-ok?6_0 zero-ok?1_1 #f)))
                (let-values ()
                  (let-values (((keep-eof?_1) (if keep-eof?8_0 keep-eof?3_1 #f)))
                    (let-values (((just-peek?_0) (if just-peek?9_0 just-peek?4_0 #f)))
                      (let-values (((skip-k_19) (if skip10_0 skip5_0 0)))
                        (let-values ()
                          (let-values (((amt_9) (- end_5 start_5)))
                            (let-values (((bstr_38) (make-bytes amt_9)))
                              (let-values (((min-consume-ok-amt_0)
                                            (if just-peek?_0 0 (max 0 (- amt_9 utf-8-max-aborts-amt)))))
                                (let-values (((consumed-v_0)
                                              (if (positive? min-consume-ok-amt_0)
                                                (let-values (((temp74_0) 0)
                                                             ((min-consume-ok-amt75_0) min-consume-ok-amt_0)
                                                             ((zero-ok?76_0) zero-ok?_2)
                                                             ((temp77_0) #f)
                                                             ((keep-eof?78_0) keep-eof?_1))
                                                  (read-some-bytes!12.1
                                                   temp77_0
                                                   #t
                                                   keep-eof?78_0
                                                   #t
                                                   zero-ok?76_0
                                                   #t
                                                   who_5
                                                   orig-in_2
                                                   bstr_38
                                                   temp74_0
                                                   min-consume-ok-amt75_0))
                                                0)))
                                  (let-values (((v_30)
                                                (if (if (exact-integer? consumed-v_0)
                                                      (= consumed-v_0 min-consume-ok-amt_0)
                                                      #f)
                                                  (let-values ()
                                                    (let-values (((v2_0)
                                                                  (let-values (((temp83_0)
                                                                                (+
                                                                                 consumed-v_0
                                                                                 (- amt_9 min-consume-ok-amt_0)))
                                                                               ((skip-k84_0) skip-k_19)
                                                                               ((temp85_0) #t))
                                                                    (peek-some-bytes!25.1
                                                                     #f
                                                                     #f
                                                                     temp85_0
                                                                     #t
                                                                     who_5
                                                                     orig-in_2
                                                                     bstr_38
                                                                     consumed-v_0
                                                                     temp83_0
                                                                     skip-k84_0))))
                                                      (if (exact-integer? v2_0)
                                                        (let-values () (+ consumed-v_0 v2_0))
                                                        (if (zero? consumed-v_0)
                                                          (let-values () v2_0)
                                                          (let-values () consumed-v_0)))))
                                                  (let-values () consumed-v_0))))
                                    (if (not (exact-integer? v_30))
                                      (let-values () v_30)
                                      (if (zero? v_30)
                                        (let-values () 0)
                                        (let-values ()
                                          (let-values (((used-bytes_2 got-chars_2 state_2)
                                                        (let-values (((temp87_0) 0)
                                                                     ((v88_0) v_30)
                                                                     ((str89_0) str_0)
                                                                     ((start90_0) start_5)
                                                                     ((amt91_0) amt_9)
                                                                     ((temp92_0) '#\?)
                                                                     ((temp93_1) 'state))
                                                          (utf-8-decode!14.1
                                                           temp93_1
                                                           #t
                                                           temp92_0
                                                           #t
                                                           #f
                                                           #f
                                                           bstr_38
                                                           temp87_0
                                                           v88_0
                                                           str89_0
                                                           start90_0
                                                           amt91_0))))
                                            (if (zero? got-chars_2)
                                              (let-values ()
                                                ((letrec-values (((loop_9)
                                                                  (lambda (skip-k_20 state_3)
                                                                    (let-values (((v_31)
                                                                                  (let-values (((temp97_0) 0)
                                                                                               ((temp98_0) 1)
                                                                                               ((skip-k99_0) skip-k_20)
                                                                                               ((zero-ok?100_0)
                                                                                                zero-ok?_2))
                                                                                    (peek-some-bytes!25.1
                                                                                     #f
                                                                                     #f
                                                                                     zero-ok?100_0
                                                                                     #t
                                                                                     who_5
                                                                                     orig-in_2
                                                                                     bstr_38
                                                                                     temp97_0
                                                                                     temp98_0
                                                                                     skip-k99_0))))
                                                                      (if (eq? v_31 0)
                                                                        (let-values () 0)
                                                                        (let-values ()
                                                                          (let-values (((used-bytes_3
                                                                                         got-chars_3
                                                                                         new-state_2)
                                                                                        (let-values (((temp102_0) 0)
                                                                                                     ((temp103_0)
                                                                                                      (if (eof-object?
                                                                                                           v_31)
                                                                                                        0
                                                                                                        v_31))
                                                                                                     ((str104_0) str_0)
                                                                                                     ((start105_0)
                                                                                                      start_5)
                                                                                                     ((amt106_0) amt_9)
                                                                                                     ((temp107_0) '#\?)
                                                                                                     ((state108_0)
                                                                                                      state_3)
                                                                                                     ((temp109_0)
                                                                                                      (if (eof-object?
                                                                                                           v_31)
                                                                                                        'error
                                                                                                        'state)))
                                                                                          (utf-8-decode!14.1
                                                                                           temp109_0
                                                                                           #t
                                                                                           temp107_0
                                                                                           #t
                                                                                           state108_0
                                                                                           #t
                                                                                           bstr_38
                                                                                           temp102_0
                                                                                           temp103_0
                                                                                           str104_0
                                                                                           start105_0
                                                                                           amt106_0))))
                                                                            (if (zero? got-chars_3)
                                                                              (let-values ()
                                                                                (loop_9 (+ skip-k_20 v_31) new-state_2))
                                                                              (let-values ()
                                                                                (begin
                                                                                  (if just-peek?_0
                                                                                    (void)
                                                                                    (let-values ()
                                                                                      (let-values (((actually-used-bytes_0)
                                                                                                    (+
                                                                                                     skip-k_20
                                                                                                     used-bytes_3)))
                                                                                        (if (zero?
                                                                                             actually-used-bytes_0)
                                                                                          (void)
                                                                                          (let-values ()
                                                                                            (let-values (((finish-bstr_0)
                                                                                                          (if (<=
                                                                                                               actually-used-bytes_0
                                                                                                               (bytes-length
                                                                                                                bstr_38))
                                                                                                            bstr_38
                                                                                                            (make-bytes
                                                                                                             actually-used-bytes_0))))
                                                                                              (do-read-bytes!
                                                                                               who_5
                                                                                               orig-in_2
                                                                                               finish-bstr_0
                                                                                               0
                                                                                               actually-used-bytes_0)))))))
                                                                                  got-chars_3))))))))))
                                                   loop_9)
                                                 (+ skip-k_19 (- v_30 consumed-v_0))
                                                 state_2))
                                              (let-values ()
                                                (let-values (((actually-used-bytes_1)
                                                              (-
                                                               used-bytes_2
                                                               (if (utf-8-state? state_2)
                                                                 (utf-8-state-pending-amt state_2)
                                                                 0))))
                                                  (begin
                                                    (if (let-values (((or-part_8) just-peek?_0))
                                                          (if or-part_8
                                                            or-part_8
                                                            (= actually-used-bytes_1 consumed-v_0)))
                                                      (void)
                                                      (let-values ()
                                                        (do-read-bytes!
                                                         who_5
                                                         orig-in_2
                                                         bstr_38
                                                         0
                                                         (- actually-used-bytes_1 consumed-v_0))))
                                                    got-chars_2))))))))))))))))))))))))))
 (define-values
  (do-read-string!28.1)
  (lambda (just-peek?19_0 just-peek?21_0 skip20_0 skip22_0 who23_0 in24_0 str25_0 start26_0 end27_0)
    (let-values (((who_6) who23_0))
      (let-values (((in_28) in24_0))
        (let-values (((str_1) str25_0))
          (let-values (((start_6) start26_0))
            (let-values (((end_6) end27_0))
              (let-values (((just-peek?_1) (if just-peek?21_0 just-peek?19_0 #f)))
                (let-values (((skip-k_21) (if skip22_0 skip20_0 0)))
                  (let-values ()
                    (let-values (((amt_10) (- end_6 start_6)))
                      (let-values (((v_32)
                                    (let-values (((just-peek?115_0) just-peek?_1) ((skip-k116_0) skip-k_21))
                                      (read-some-chars!16.1
                                       #f
                                       #f
                                       just-peek?115_0
                                       #t
                                       #f
                                       #f
                                       skip-k116_0
                                       #t
                                       #f
                                       #f
                                       who_6
                                       in_28
                                       str_1
                                       start_6
                                       end_6))))
                        (if (not (exact-integer? v_32))
                          (let-values () v_32)
                          (if (= v_32 amt_10)
                            (let-values () v_32)
                            (let-values ()
                              ((letrec-values (((loop_10)
                                                (lambda (got_2)
                                                  (let-values (((v_33)
                                                                (let-values (((temp122_0) #t)
                                                                             ((just-peek?123_0) just-peek?_1)
                                                                             ((temp124_1)
                                                                              (if just-peek?_1 (+ skip-k_21 got_2) 0)))
                                                                  (read-some-chars!16.1
                                                                   #f
                                                                   #f
                                                                   just-peek?123_0
                                                                   #t
                                                                   temp122_0
                                                                   #t
                                                                   temp124_1
                                                                   #t
                                                                   #f
                                                                   #f
                                                                   who_6
                                                                   in_28
                                                                   str_1
                                                                   got_2
                                                                   amt_10))))
                                                    (if (eof-object? v_33)
                                                      (let-values () got_2)
                                                      (let-values ()
                                                        (let-values (((new-got_2) (+ got_2 v_33)))
                                                          (if (= new-got_2 amt_10)
                                                            (let-values () amt_10)
                                                            (let-values () (loop_10 new-got_2))))))))))
                                 loop_10)
                               v_32))))))))))))))))
 (define-values
  (read-char-via-read-byte)
  (lambda (who_7 in_29 read-byte_2)
    (let-values (((b_4) (read-byte_2)))
      (if (eof-object? b_4)
        (let-values () b_4)
        (let-values ()
          (begin
            (input-port-count-byte! in_29 b_4)
            (if (< b_4 128)
              (let-values () (integer->char b_4))
              (let-values ()
                (let-values (((bstr_39) (bytes b_4)))
                  (let-values (((str_2) (make-string 1)))
                    (let-values (((used-bytes_4 got-chars_4 state_4)
                                  (let-values (((temp126_1) 0)
                                               ((temp127_1) 1)
                                               ((temp128_0) #f)
                                               ((temp129_0) 0)
                                               ((temp130_0) #f)
                                               ((temp131_0) 'state))
                                    (utf-8-decode!14.1
                                     temp131_0
                                     #t
                                     #f
                                     #f
                                     #f
                                     #f
                                     bstr_39
                                     temp126_1
                                     temp127_1
                                     temp128_0
                                     temp129_0
                                     temp130_0))))
                      (if (eq? state_4 'error)
                        (let-values () '#\?)
                        (let-values ()
                          ((letrec-values (((loop_11)
                                            (lambda (skip-k_7 state_5)
                                              (let-values (((v_34)
                                                            (let-values (((temp135_0) 0)
                                                                         ((temp136_0) 1)
                                                                         ((skip-k137_0) skip-k_7)
                                                                         ((temp138_0) #f))
                                                              (peek-some-bytes!25.1
                                                               temp138_0
                                                               #t
                                                               #f
                                                               #f
                                                               who_7
                                                               in_29
                                                               bstr_39
                                                               temp135_0
                                                               temp136_0
                                                               skip-k137_0))))
                                                (if (eof-object? v_34)
                                                  (let-values () '#\?)
                                                  (let-values ()
                                                    (let-values (((used-bytes_5 got-chars_5 new-state_3)
                                                                  (let-values (((temp140_0) 0)
                                                                               ((temp141_0) 1)
                                                                               ((str142_0) str_2)
                                                                               ((temp143_0) 0)
                                                                               ((temp144_0) 1)
                                                                               ((state145_0) state_5)
                                                                               ((temp146_0) '#\?)
                                                                               ((temp147_0) 'state))
                                                                    (utf-8-decode!14.1
                                                                     temp147_0
                                                                     #t
                                                                     temp146_0
                                                                     #t
                                                                     state145_0
                                                                     #t
                                                                     bstr_39
                                                                     temp140_0
                                                                     temp141_0
                                                                     str142_0
                                                                     temp143_0
                                                                     temp144_0))))
                                                      (if (= got-chars_5 1)
                                                        (let-values ()
                                                          (let-values (((actually-used-bytes_2)
                                                                        (+ skip-k_7 used-bytes_5)))
                                                            (begin
                                                              (if (zero? actually-used-bytes_2)
                                                                (void)
                                                                (let-values ()
                                                                  (let-values (((finish-bstr_1)
                                                                                (if (<=
                                                                                     actually-used-bytes_2
                                                                                     (bytes-length bstr_39))
                                                                                  bstr_39
                                                                                  (make-bytes actually-used-bytes_2))))
                                                                    (do-read-bytes!
                                                                     who_7
                                                                     in_29
                                                                     finish-bstr_1
                                                                     0
                                                                     actually-used-bytes_2))))
                                                              (string-ref str_2 0))))
                                                        (let-values () (loop_11 (add1 skip-k_7) new-state_3))))))))))
                             loop_11)
                           0
                           state_4))))))))))))))
 (define-values
  (1/read-char)
  (let-values (((read-char33_0)
                (lambda (in31_1 in32_0)
                  (let-values (((in_30) (if in32_0 in31_1 (current-input-port))))
                    (let-values ()
                      (let-values ((()
                                    (begin
                                      (if (1/input-port? in_30)
                                        (void)
                                        (let-values () (raise-argument-error 'read-char "input-port?" in_30)))
                                      (values))))
                        (let-values (((read-byte_3) (input-port-read-byte in_30)))
                          (if (not read-byte_3)
                            (let-values ()
                              (let-values (((str_3) (make-string 1)))
                                (let-values (((v_35)
                                              (let-values (((temp148_0) 'read-char)
                                                           ((in149_0) in_30)
                                                           ((str150_0) str_3)
                                                           ((temp151_0) 0)
                                                           ((temp152_0) 1))
                                                (read-some-chars!16.1
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 #f
                                                 temp148_0
                                                 in149_0
                                                 str150_0
                                                 temp151_0
                                                 temp152_0))))
                                  (if (eq? v_35 1) (string-ref str_3 1) v_35))))
                            (let-values () (read-char-via-read-byte 'read-char in_30 read-byte_3))))))))))
    (case-lambda (() (read-char33_0 #f #f)) ((in31_2) (read-char33_0 in31_2 #t)))))
 (define-values
  (1/read-string)
  (let-values (((read-string38_0)
                (lambda (amt37_0 in35_0 in36_0)
                  (let-values (((amt_11) amt37_0))
                    (let-values (((in_31) (if in36_0 in35_0 (current-input-port))))
                      (let-values ()
                        (let-values ((()
                                      (begin
                                        (if (exact-nonnegative-integer? amt_11)
                                          (void)
                                          (let-values ()
                                            (raise-argument-error 'read-string "exact-nonnegative-integer?" amt_11)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (if (1/input-port? in_31)
                                            (void)
                                            (let-values () (raise-argument-error 'read-string "input-port?" in_31)))
                                          (values))))
                            (let-values (((bstr_40) (make-string amt_11)))
                              (let-values (((v_36)
                                            (let-values (((temp153_0) 'read-string)
                                                         ((in154_0) in_31)
                                                         ((bstr155_0) bstr_40)
                                                         ((temp156_0) 0)
                                                         ((amt157_0) amt_11))
                                              (do-read-string!28.1
                                               #f
                                               #f
                                               #f
                                               #f
                                               temp153_0
                                               in154_0
                                               bstr155_0
                                               temp156_0
                                               amt157_0))))
                                (if (exact-integer? v_36)
                                  (if (= v_36 amt_11) bstr_40 (substring bstr_40 0 v_36))
                                  v_36)))))))))))
    (case-lambda ((amt_12) (read-string38_0 amt_12 #f #f)) ((amt_13 in35_1) (read-string38_0 amt_13 in35_1 #t)))))
 (define-values
  (1/read-string!)
  (let-values (((read-string!47_0)
                (lambda (str46_0 in40_0 start-pos41_0 end-pos42_0 in43_2 start-pos44_0 end-pos45_0)
                  (let-values (((str_4) str46_0))
                    (let-values (((in_32) (if in43_2 in40_0 (current-input-port))))
                      (let-values (((start-pos_13) (if start-pos44_0 start-pos41_0 0)))
                        (let-values (((end-pos_7)
                                      (if end-pos45_0 end-pos42_0 (if (string? str_4) (string-length str_4) #f))))
                          (let-values ()
                            (begin
                              (if (string? str_4)
                                (void)
                                (let-values () (raise-argument-error 'read-string! "string?" str_4)))
                              (if (1/input-port? in_32)
                                (void)
                                (let-values () (raise-argument-error 'read-string! "input-port?" in_32)))
                              (if (exact-nonnegative-integer? start-pos_13)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'read-string! "exact-nonnegative-integer?" start-pos_13)))
                              (if (exact-nonnegative-integer? end-pos_7)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'read-string! "exact-nonnegative-integer?" end-pos_7)))
                              (check-range 'read-string! start-pos_13 end-pos_7 (string-length str_4) str_4)
                              (let-values (((temp158_0) 'read-string!)
                                           ((in159_0) in_32)
                                           ((str160_0) str_4)
                                           ((start-pos161_0) start-pos_13)
                                           ((end-pos162_0) end-pos_7))
                                (do-read-string!28.1
                                 #f
                                 #f
                                 #f
                                 #f
                                 temp158_0
                                 in159_0
                                 str160_0
                                 start-pos161_0
                                 end-pos162_0)))))))))))
    (case-lambda
     ((str_5) (read-string!47_0 str_5 #f #f #f #f #f #f))
     ((str_6 in_33 start-pos_14 end-pos42_1) (read-string!47_0 str_6 in_33 start-pos_14 end-pos42_1 #t #t #t))
     ((str_7 in_34 start-pos41_1) (read-string!47_0 str_7 in_34 start-pos41_1 #f #t #t #f))
     ((str_8 in40_1) (read-string!47_0 str_8 in40_1 #f #f #t #f #f)))))
 (define-values
  (do-peek-string!)
  (lambda (who_8 in_35 str_9 start_7 end_7 skip_2)
    (let-values (((skip168_0) skip_2) ((temp169_0) #t))
      (do-read-string!28.1 temp169_0 #t skip168_0 #t who_8 in_35 str_9 start_7 end_7))))
 (define-values
  (1/peek-char)
  (let-values (((peek-char53_0)
                (lambda (in49_2 skip-k50_0 in51_0 skip-k52_0)
                  (let-values (((in_36) (if in51_0 in49_2 (current-input-port))))
                    (let-values (((skip-k_22) (if skip-k52_0 skip-k50_0 0)))
                      (let-values ()
                        (let-values ((()
                                      (begin
                                        (if (1/input-port? in_36)
                                          (void)
                                          (let-values () (raise-argument-error 'peek-char "input-port?" in_36)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (if (exact-nonnegative-integer? skip-k_22)
                                            (void)
                                            (let-values ()
                                              (raise-argument-error 'peek-char "exact-nonnegative-integer?" skip-k_22)))
                                          (values))))
                            (let-values (((peek-byte_2) (if (zero? skip-k_22) (input-port-read-byte in_36) #f)))
                              (let-values (((b_5) (if peek-byte_2 (peek-byte_2) #f)))
                                (if (if b_5
                                      (let-values (((or-part_9) (eof-object? b_5)))
                                        (if or-part_9 or-part_9 (< b_5 128)))
                                      #f)
                                  (let-values () (integer->char b_5))
                                  (let-values ()
                                    (let-values (((bstr_41) (make-string 1)))
                                      (let-values (((v_37) (do-peek-string! 'peek-char in_36 bstr_41 0 1 skip-k_22)))
                                        (if (eq? v_37 1) (string-ref bstr_41 1) v_37)))))))))))))))
    (case-lambda
     (() (peek-char53_0 #f #f #f #f))
     ((in_37 skip-k50_1) (peek-char53_0 in_37 skip-k50_1 #t #t))
     ((in49_3) (peek-char53_0 in49_3 #f #t #f)))))
 (define-values
  (1/peek-string)
  (let-values (((peek-string59_0)
                (lambda (amt57_0 skip-k58_0 in55_0 in56_0)
                  (let-values (((amt_14) amt57_0))
                    (let-values (((skip-k_23) skip-k58_0))
                      (let-values (((in_38) (if in56_0 in55_0 (current-input-port))))
                        (let-values ()
                          (let-values ((()
                                        (begin
                                          (if (exact-nonnegative-integer? amt_14)
                                            (void)
                                            (let-values ()
                                              (raise-argument-error 'peek-string "exact-nonnegative-integer?" amt_14)))
                                          (values))))
                            (let-values ((()
                                          (begin
                                            (if (exact-nonnegative-integer? skip-k_23)
                                              (void)
                                              (let-values ()
                                                (raise-argument-error
                                                 'peek-string
                                                 "exact-nonnegative-integer?"
                                                 skip-k_23)))
                                            (values))))
                              (let-values ((()
                                            (begin
                                              (if (1/input-port? in_38)
                                                (void)
                                                (let-values () (raise-argument-error 'peek-string "input-port?" in_38)))
                                              (values))))
                                (let-values (((bstr_42) (make-string amt_14)))
                                  (let-values (((v_38) (do-peek-string! 'peek-string bstr_42 in_38 0 amt_14 skip-k_23)))
                                    (if (exact-integer? v_38)
                                      (if (= v_38 amt_14) bstr_42 (substring bstr_42 0 v_38))
                                      v_38)))))))))))))
    (case-lambda
     ((amt_15 skip-k_24) (peek-string59_0 amt_15 skip-k_24 #f #f))
     ((amt_16 skip-k_25 in55_1) (peek-string59_0 amt_16 skip-k_25 in55_1 #t)))))
 (define-values
  (1/peek-string!)
  (let-values (((peek-string!69_0)
                (lambda (str67_0 skip-k68_0 in61_0 start-pos62_0 end-pos63_0 in64_0 start-pos65_0 end-pos66_0)
                  (let-values (((str_10) str67_0))
                    (let-values (((skip-k_26) skip-k68_0))
                      (let-values (((in_39) (if in64_0 in61_0 (current-input-port))))
                        (let-values (((start-pos_15) (if start-pos65_0 start-pos62_0 0)))
                          (let-values (((end-pos_8)
                                        (if end-pos66_0 end-pos63_0 (if (string? str_10) (string-length str_10) #f))))
                            (let-values ()
                              (begin
                                (if (string? str_10)
                                  (void)
                                  (let-values () (raise-argument-error 'peek-string! "string?" str_10)))
                                (if (exact-nonnegative-integer? skip-k_26)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-string! "exact-nonnegative-integer?" skip-k_26)))
                                (if (1/input-port? in_39)
                                  (void)
                                  (let-values () (raise-argument-error 'peek-string! "input-port?" in_39)))
                                (if (exact-nonnegative-integer? start-pos_15)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-string! "exact-nonnegative-integer?" start-pos_15)))
                                (if (exact-nonnegative-integer? end-pos_8)
                                  (void)
                                  (let-values ()
                                    (raise-argument-error 'peek-string! "exact-nonnegative-integer?" end-pos_8)))
                                (check-range 'peek-string! start-pos_15 end-pos_8 (string-length str_10) str_10)
                                (do-peek-string! 'peek-string! str_10 in_39 start-pos_15 end-pos_8 skip-k_26)))))))))))
    (case-lambda
     ((str_11 skip-k_27) (peek-string!69_0 str_11 skip-k_27 #f #f #f #f #f #f))
     ((str_12 skip-k_28 in_40 start-pos_16 end-pos63_1)
      (peek-string!69_0 str_12 skip-k_28 in_40 start-pos_16 end-pos63_1 #t #t #t))
     ((str_13 skip-k_29 in_41 start-pos62_1) (peek-string!69_0 str_13 skip-k_29 in_41 start-pos62_1 #f #t #t #f))
     ((str_14 skip-k_30 in61_1) (peek-string!69_0 str_14 skip-k_30 in61_1 #f #f #t #f #f)))))
 (define-values
  (write-some-bytes12.1)
  (lambda (buffer-ok?1_0
           buffer-ok?4_0
           enable-break?3_0
           enable-break?6_0
           zero-ok?2_0
           zero-ok?5_0
           who7_0
           out8_0
           bstr9_0
           start10_0
           end11_0)
    (let-values (((who_2) who7_0))
      (let-values (((out_0) out8_0))
        (let-values (((bstr_1) bstr9_0))
          (let-values (((start_1) start10_0))
            (let-values (((end_1) end11_0))
              (let-values (((buffer-ok?_0) (if buffer-ok?4_0 buffer-ok?1_0 #f)))
                (let-values (((zero-ok?_3) (if zero-ok?5_0 zero-ok?2_0 #f)))
                  (let-values (((enable-break?_0) (if enable-break?6_0 enable-break?3_0 #f)))
                    (let-values ()
                      (if (output-port-closed? out_0)
                        (let-values () (raise-arguments-error who_2 "output port is closed" "output port" out_0))
                        (if (= start_1 end_1)
                          (let-values () 0)
                          (let-values ()
                            (let-values (((write-out_1) (output-port-write-out out_0)))
                              ((letrec-values (((try-again_0)
                                                (lambda ()
                                                  (let-values (((v_39)
                                                                (write-out_1
                                                                 bstr_1
                                                                 start_1
                                                                 end_1
                                                                 (not buffer-ok?_0)
                                                                 enable-break?_0)))
                                                    (if (let-values (((or-part_10) (not v_39)))
                                                          (if or-part_10 or-part_10 (eq? v_39 0)))
                                                      (let-values () (if zero-ok?_3 0 (try-again_0)))
                                                      (if (exact-integer? v_39)
                                                        (let-values () v_39)
                                                        (let-values () (error who_2 "weird result"))))))))
                                 try-again_0)))))))))))))))))
 (define-values
  (do-write-bytes)
  (lambda (who_5 out_1 bstr_43 start_5 end_5)
    ((letrec-values (((loop_12)
                      (lambda (i_2)
                        (if (= i_2 end_5)
                          (let-values () (- i_2 start_5))
                          (let-values ()
                            (let-values (((n_0)
                                          (let-values (((temp53_0) #t))
                                            (write-some-bytes12.1
                                             temp53_0
                                             #t
                                             #f
                                             #f
                                             #f
                                             #f
                                             who_5
                                             out_1
                                             bstr_43
                                             i_2
                                             end_5))))
                              (loop_12 (+ n_0 i_2))))))))
       loop_12)
     start_5)))
 (define-values
  (1/write-bytes)
  (let-values (((write-bytes13_0)
                (lambda (bstr12_0 out6_0 start-pos7_0 end-pos8_0 out9_0 start-pos10_0 end-pos11_0)
                  (let-values (((bstr_44) bstr12_0))
                    (let-values (((out_2) (if out9_0 out6_0 (current-output-port))))
                      (let-values (((start-pos_17) (if start-pos10_0 start-pos7_0 0)))
                        (let-values (((end-pos_9)
                                      (if end-pos11_0 end-pos8_0 (if (bytes? bstr_44) (bytes-length bstr_44) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_44)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes "bytes?" bstr_44)))
                              (if (1/output-port? out_2)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes "output-port?" out_2)))
                              (if (exact-nonnegative-integer? start-pos_17)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-bytes "exact-nonnegative-integer?" start-pos_17)))
                              (if (exact-nonnegative-integer? end-pos_9)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-bytes "exact-nonnegative-integer?" end-pos_9)))
                              (check-range 'write-bytes start-pos_17 end-pos_9 (bytes-length bstr_44) bstr_44)
                              (do-write-bytes 'write-bytes out_2 bstr_44 start-pos_17 end-pos_9))))))))))
    (case-lambda
     ((bstr_45) (write-bytes13_0 bstr_45 #f #f #f #f #f #f))
     ((bstr_46 out_3 start-pos_18 end-pos8_1) (write-bytes13_0 bstr_46 out_3 start-pos_18 end-pos8_1 #t #t #t))
     ((bstr_47 out_4 start-pos7_1) (write-bytes13_0 bstr_47 out_4 start-pos7_1 #f #t #t #f))
     ((bstr_48 out6_1) (write-bytes13_0 bstr_48 out6_1 #f #f #t #f #f)))))
 (define-values
  (1/write-bytes-avail)
  (let-values (((write-bytes-avail22_0)
                (lambda (bstr21_1 out15_0 start-pos16_0 end-pos17_0 out18_0 start-pos19_0 end-pos20_0)
                  (let-values (((bstr_49) bstr21_1))
                    (let-values (((out_5) (if out18_0 out15_0 (current-output-port))))
                      (let-values (((start-pos_19) (if start-pos19_0 start-pos16_0 0)))
                        (let-values (((end-pos_10)
                                      (if end-pos20_0 end-pos17_0 (if (bytes? bstr_49) (bytes-length bstr_49) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_49)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes-avail "bytes?" bstr_49)))
                              (if (1/output-port? out_5)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes-avail "output-port?" out_5)))
                              (if (exact-nonnegative-integer? start-pos_19)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-bytes-avail "exact-nonnegative-integer?" start-pos_19)))
                              (if (exact-nonnegative-integer? end-pos_10)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-bytes-avail "exact-nonnegative-integer?" end-pos_10)))
                              (check-range 'write-bytes-avail start-pos_19 end-pos_10 (bytes-length bstr_49) bstr_49)
                              (let-values (((temp54_0) 'write-bytes-avail)
                                           ((out55_0) out_5)
                                           ((bstr56_0) bstr_49)
                                           ((start-pos57_0) start-pos_19)
                                           ((end-pos58_0) end-pos_10))
                                (write-some-bytes12.1
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 temp54_0
                                 out55_0
                                 bstr56_0
                                 start-pos57_0
                                 end-pos58_0)))))))))))
    (case-lambda
     ((bstr_10) (write-bytes-avail22_0 bstr_10 #f #f #f #f #f #f))
     ((bstr_50 out_6 start-pos_20 end-pos17_1) (write-bytes-avail22_0 bstr_50 out_6 start-pos_20 end-pos17_1 #t #t #t))
     ((bstr_51 out_7 start-pos16_1) (write-bytes-avail22_0 bstr_51 out_7 start-pos16_1 #f #t #t #f))
     ((bstr_52 out15_1) (write-bytes-avail22_0 bstr_52 out15_1 #f #f #t #f #f)))))
 (define-values
  (1/write-bytes-avail*)
  (let-values (((write-bytes-avail*31_0)
                (lambda (bstr30_0 out24_0 start-pos25_0 end-pos26_0 out27_0 start-pos28_0 end-pos29_0)
                  (let-values (((bstr_53) bstr30_0))
                    (let-values (((out_8) (if out27_0 out24_0 (current-output-port))))
                      (let-values (((start-pos_21) (if start-pos28_0 start-pos25_0 0)))
                        (let-values (((end-pos_11)
                                      (if end-pos29_0 end-pos26_0 (if (bytes? bstr_53) (bytes-length bstr_53) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_53)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes-avail* "bytes?" bstr_53)))
                              (if (1/output-port? out_8)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes-avail* "output-port?" out_8)))
                              (if (exact-nonnegative-integer? start-pos_21)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-bytes-avail* "exact-nonnegative-integer?" start-pos_21)))
                              (if (exact-nonnegative-integer? end-pos_11)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-bytes-avail* "exact-nonnegative-integer?" end-pos_11)))
                              (check-range 'write-bytes-avail* start-pos_21 end-pos_11 (bytes-length bstr_53) bstr_53)
                              (let-values (((temp59_0) 'write-bytes-avail*)
                                           ((out60_0) out_8)
                                           ((bstr61_0) bstr_53)
                                           ((start-pos62_2) start-pos_21)
                                           ((end-pos63_2) end-pos_11)
                                           ((temp64_0) #t))
                                (write-some-bytes12.1
                                 #f
                                 #f
                                 #f
                                 #f
                                 temp64_0
                                 #t
                                 temp59_0
                                 out60_0
                                 bstr61_0
                                 start-pos62_2
                                 end-pos63_2)))))))))))
    (case-lambda
     ((bstr_54) (write-bytes-avail*31_0 bstr_54 #f #f #f #f #f #f))
     ((bstr_55 out_9 start-pos_22 end-pos26_1) (write-bytes-avail*31_0 bstr_55 out_9 start-pos_22 end-pos26_1 #t #t #t))
     ((bstr_56 out_10 start-pos25_1) (write-bytes-avail*31_0 bstr_56 out_10 start-pos25_1 #f #t #t #f))
     ((bstr_57 out24_1) (write-bytes-avail*31_0 bstr_57 out24_1 #f #f #t #f #f)))))
 (define-values
  (1/write-bytes-avail/enable-break)
  (let-values (((write-bytes-avail/enable-break40_0)
                (lambda (bstr39_0 out33_0 start-pos34_0 end-pos35_0 out36_0 start-pos37_0 end-pos38_0)
                  (let-values (((bstr_58) bstr39_0))
                    (let-values (((out_11) (if out36_0 out33_0 (current-output-port))))
                      (let-values (((start-pos_23) (if start-pos37_0 start-pos34_0 0)))
                        (let-values (((end-pos_12)
                                      (if end-pos38_0 end-pos35_0 (if (bytes? bstr_58) (bytes-length bstr_58) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_58)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes-avail/enable-break "bytes?" bstr_58)))
                              (if (1/output-port? out_11)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-bytes-avail/enable-break "output-port?" out_11)))
                              (if (exact-nonnegative-integer? start-pos_23)
                                (void)
                                (let-values ()
                                  (raise-argument-error
                                   'write-bytes-avail/enable-break
                                   "exact-nonnegative-integer?"
                                   start-pos_23)))
                              (if (exact-nonnegative-integer? end-pos_12)
                                (void)
                                (let-values ()
                                  (raise-argument-error
                                   'write-bytes-avail/enable-break
                                   "exact-nonnegative-integer?"
                                   end-pos_12)))
                              (check-range
                               'write-bytes-avail/enable-break
                               start-pos_23
                               end-pos_12
                               (bytes-length bstr_58)
                               bstr_58)
                              (let-values (((temp65_0) 'write-bytes-avail/enable-break)
                                           ((out66_0) out_11)
                                           ((bstr67_0) bstr_58)
                                           ((start-pos68_0) start-pos_23)
                                           ((end-pos69_0) end-pos_12)
                                           ((temp70_0) #t))
                                (write-some-bytes12.1
                                 #f
                                 #f
                                 temp70_0
                                 #t
                                 #f
                                 #f
                                 temp65_0
                                 out66_0
                                 bstr67_0
                                 start-pos68_0
                                 end-pos69_0)))))))))))
    (case-lambda
     ((bstr_59) (write-bytes-avail/enable-break40_0 bstr_59 #f #f #f #f #f #f))
     ((bstr_60 out_12 start-pos_24 end-pos35_1)
      (write-bytes-avail/enable-break40_0 bstr_60 out_12 start-pos_24 end-pos35_1 #t #t #t))
     ((bstr_61 out_13 start-pos34_1) (write-bytes-avail/enable-break40_0 bstr_61 out_13 start-pos34_1 #f #t #t #f))
     ((bstr_62 out33_1) (write-bytes-avail/enable-break40_0 bstr_62 out33_1 #f #f #t #f #f)))))
 (define-values
  (utf-8-encode!)
  (lambda (in-str_0 in-start_1 in-end_1 out-bstr_0 out-start_1 out-end_1)
    ((letrec-values (((loop_13)
                      (lambda (i_3 j_1)
                        (if (= i_3 in-end_1)
                          (let-values () (values (- in-end_1 in-start_1) (- j_1 out-start_1) 'complete))
                          (let-values ()
                            (let-values (((b_6) (char->integer (string-ref in-str_0 i_3))))
                              (if (byte? b_6)
                                (let-values ()
                                  (if (if out-end_1 (= j_1 out-end_1) #f)
                                    (let-values () (values (- i_3 in-start_1) (- j_1 out-start_1) 'aborts))
                                    (let-values ()
                                      (begin
                                        (if out-bstr_0 (let-values () (bytes-set! out-bstr_0 j_1 b_6)) (void))
                                        (loop_13 (add1 i_3) (add1 j_1))))))
                                (if (< b_6 2047)
                                  (let-values ()
                                    (if (if out-end_1 (>= (add1 j_1) out-end_1) #f)
                                      (let-values () (values (- i_3 in-start_1) (- j_1 out-start_1) 'aborts))
                                      (let-values ()
                                        (begin
                                          (if out-bstr_0
                                            (let-values ()
                                              (begin
                                                (bytes-set! out-bstr_0 j_1 (bitwise-ior 192 (arithmetic-shift b_6 -6)))
                                                (bytes-set!
                                                 out-bstr_0
                                                 (add1 j_1)
                                                 (bitwise-ior 128 (bitwise-and b_6 63)))))
                                            (void))
                                          (loop_13 (add1 i_3) (+ j_1 2))))))
                                  (if (< b_6 65535)
                                    (let-values ()
                                      (if (if out-end_1 (>= (+ j_1 2) out-end_1) #f)
                                        (let-values () (values (- i_3 in-start_1) (- j_1 out-start_1) 'aborts))
                                        (let-values ()
                                          (begin
                                            (if out-bstr_0
                                              (let-values ()
                                                (begin
                                                  (bytes-set!
                                                   out-bstr_0
                                                   j_1
                                                   (bitwise-ior 224 (arithmetic-shift b_6 -12)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 1)
                                                   (bitwise-ior 128 (bitwise-and (arithmetic-shift b_6 -6) 63)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 2)
                                                   (bitwise-ior 128 (bitwise-and b_6 63)))))
                                              (void))
                                            (loop_13 (add1 i_3) (+ j_1 3))))))
                                    (let-values ()
                                      (if (if out-end_1 (>= (+ j_1 3) out-end_1) #f)
                                        (let-values () (values (- i_3 in-start_1) (- j_1 out-start_1) 'aborts))
                                        (let-values ()
                                          (begin
                                            (if out-bstr_0
                                              (let-values ()
                                                (begin
                                                  (bytes-set!
                                                   out-bstr_0
                                                   j_1
                                                   (bitwise-ior 240 (arithmetic-shift b_6 -18)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 1)
                                                   (bitwise-ior 128 (bitwise-and (arithmetic-shift b_6 -12) 63)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 2)
                                                   (bitwise-ior 128 (bitwise-and (arithmetic-shift b_6 -6) 63)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 3)
                                                   (bitwise-ior 128 (bitwise-and b_6 63)))))
                                              (void))
                                            (loop_13 (add1 i_3) (+ j_1 4)))))))))))))))
       loop_13)
     in-start_1
     out-start_1)))
 (define-values
  (1/bytes->string/latin-1)
  (let-values (((bytes->string/latin-18_0)
                (lambda (bstr7_0 err-char1_0 start2_0 end3_1 err-char4_0 start5_0 end6_0)
                  (let-values (((bstr_0) bstr7_0))
                    (let-values (((err-char_0) (if err-char4_0 err-char1_0 #f)))
                      (let-values (((start_8) (if start5_0 start2_0 0)))
                        (let-values (((end_8) (if end6_0 end3_1 (if (bytes? bstr_0) (bytes-length bstr_0) #f))))
                          (let-values ()
                            (let-values ((()
                                          (begin
                                            (if (bytes? bstr_0)
                                              (void)
                                              (let-values ()
                                                (raise-argument-error 'bytes->string/latin-1 "bytes?" bstr_0)))
                                            (values))))
                              (let-values ((()
                                            (begin
                                              (if ((lambda (v_23)
                                                     (let-values (((or-part_11) (not v_23)))
                                                       (if or-part_11 or-part_11 (char? v_23))))
                                                   err-char_0)
                                                (void)
                                                (let-values ()
                                                  (raise-argument-error
                                                   'bytes->string/latin-1
                                                   "(or/c char? #f)"
                                                   err-char_0)))
                                              (values))))
                                (let-values ((()
                                              (begin
                                                (if (exact-nonnegative-integer? start_8)
                                                  (void)
                                                  (let-values ()
                                                    (raise-argument-error
                                                     'bytes->string/latin-1
                                                     "exact-nonnegative-integer?"
                                                     start_8)))
                                                (values))))
                                  (let-values ((()
                                                (begin
                                                  (if (exact-nonnegative-integer? end_8)
                                                    (void)
                                                    (let-values ()
                                                      (raise-argument-error
                                                       'bytes->string/latin-1
                                                       "exact-nonnegative-integer?"
                                                       end_8)))
                                                  (values))))
                                    (let-values ((()
                                                  (begin
                                                    (check-range
                                                     'bytes->string/latin-1
                                                     start_8
                                                     end_8
                                                     (bytes-length bstr_0)
                                                     bstr_0)
                                                    (values))))
                                      (let-values (((len_0) (- end_8 start_8)))
                                        (let-values (((s_1) (make-string len_0)))
                                          (begin
                                            ((letrec-values (((loop_14)
                                                              (lambda (i_4)
                                                                (if (zero? i_4)
                                                                  (void)
                                                                  (let-values ()
                                                                    (let-values (((i_5) (sub1 i_4)))
                                                                      (begin
                                                                        (string-set!
                                                                         s_1
                                                                         i_5
                                                                         (integer->char
                                                                          (bytes-ref bstr_0 (+ i_5 start_8))))
                                                                        (loop_14 i_5))))))))
                                               loop_14)
                                             len_0)
                                            s_1))))))))))))))))
    (case-lambda
     ((bstr_63) (bytes->string/latin-18_0 bstr_63 #f #f #f #f #f #f))
     ((bstr_64 err-char_1 start_9 end3_0) (bytes->string/latin-18_0 bstr_64 err-char_1 start_9 end3_0 #t #t #t))
     ((bstr_65 err-char_2 start2_1) (bytes->string/latin-18_0 bstr_65 err-char_2 start2_1 #f #t #t #f))
     ((bstr_66 err-char1_1) (bytes->string/latin-18_0 bstr_66 err-char1_1 #f #f #t #f #f)))))
 (define-values
  (do-bytes->string/utf-817.1)
  (lambda (just-length?10_0 just-length?11_0 who12_0 bstr13_0 err-char14_0 start15_0 end16_0)
    (let-values (((who_9) who12_0))
      (let-values (((bstr_46) bstr13_0))
        (let-values (((err-char_3) err-char14_0))
          (let-values (((start_10) start15_0))
            (let-values (((end_9) end16_0))
              (let-values (((just-length?_0) (if just-length?11_0 just-length?10_0 #f)))
                (let-values ()
                  (let-values ((()
                                (begin
                                  (if (bytes? bstr_46)
                                    (void)
                                    (let-values () (raise-argument-error who_9 "bytes?" bstr_46)))
                                  (values))))
                    (let-values ((()
                                  (begin
                                    (if ((lambda (v_40)
                                           (let-values (((or-part_5) (not v_40)))
                                             (if or-part_5 or-part_5 (char? v_40))))
                                         err-char_3)
                                      (void)
                                      (let-values () (raise-argument-error who_9 "(or/c char? #f)" err-char_3)))
                                    (values))))
                      (let-values ((()
                                    (begin
                                      (if (exact-nonnegative-integer? start_10)
                                        (void)
                                        (let-values ()
                                          (raise-argument-error who_9 "exact-nonnegative-integer?" start_10)))
                                      (values))))
                        (let-values ((()
                                      (begin
                                        (if (exact-nonnegative-integer? end_9)
                                          (void)
                                          (let-values ()
                                            (raise-argument-error who_9 "exact-nonnegative-integer?" end_9)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (check-range who_9 start_10 end_9 (bytes-length bstr_46) bstr_46)
                                          (values))))
                            (let-values (((used-bytes_6 got-chars_6 state_6)
                                          (let-values (((temp96_1) #f)
                                                       ((temp97_1) 0)
                                                       ((temp98_1) #f)
                                                       ((err-char99_0) err-char_3)
                                                       ((temp100_0) 'error))
                                            (utf-8-decode!14.1
                                             temp100_0
                                             #t
                                             err-char99_0
                                             #t
                                             #f
                                             #f
                                             bstr_46
                                             start_10
                                             end_9
                                             temp96_1
                                             temp97_1
                                             temp98_1))))
                              (if just-length?_0
                                (let-values () got-chars_6)
                                (let-values ()
                                  (let-values (((str_15) (make-string got-chars_6)))
                                    (begin
                                      (let-values (((temp105_0) 0)
                                                   ((temp106_1) #f)
                                                   ((err-char107_0) err-char_3)
                                                   ((temp108_0) 'error))
                                        (utf-8-decode!14.1
                                         temp108_0
                                         #t
                                         err-char107_0
                                         #t
                                         #f
                                         #f
                                         bstr_46
                                         start_10
                                         end_9
                                         str_15
                                         temp105_0
                                         temp106_1))
                                      str_15)))))))))))))))))))
 (define-values
  (1/bytes->string/utf-8)
  (let-values (((bytes->string/utf-827_0)
                (lambda (bstr26_0 err-char20_0 start21_0 end22_0 err-char23_0 start24_0 end25_0)
                  (let-values (((bstr_54) bstr26_0))
                    (let-values (((err-char_4) (if err-char23_0 err-char20_0 #f)))
                      (let-values (((start_11) (if start24_0 start21_0 0)))
                        (let-values (((end_10) (if end25_0 end22_0 (if (bytes? bstr_54) (bytes-length bstr_54) #f))))
                          (let-values ()
                            (let-values (((temp109_1) 'bytes->string/utf-8)
                                         ((bstr110_0) bstr_54)
                                         ((err-char111_0) err-char_4)
                                         ((start112_0) start_11)
                                         ((end113_0) end_10))
                              (do-bytes->string/utf-817.1
                               #f
                               #f
                               temp109_1
                               bstr110_0
                               err-char111_0
                               start112_0
                               end113_0))))))))))
    (case-lambda
     ((bstr_15) (bytes->string/utf-827_0 bstr_15 #f #f #f #f #f #f))
     ((bstr_67 err-char_5 start_12 end22_1) (bytes->string/utf-827_0 bstr_67 err-char_5 start_12 end22_1 #t #t #t))
     ((bstr_68 err-char_6 start21_1) (bytes->string/utf-827_0 bstr_68 err-char_6 start21_1 #f #t #t #f))
     ((bstr_69 err-char20_1) (bytes->string/utf-827_0 bstr_69 err-char20_1 #f #f #t #f #f)))))
 (define-values
  (1/bytes-utf-8-length)
  (let-values (((bytes-utf-8-length36_0)
                (lambda (bstr35_0 err-char29_0 start30_0 end31_0 err-char32_0 start33_0 end34_0)
                  (let-values (((bstr_19) bstr35_0))
                    (let-values (((err-char_7) (if err-char32_0 err-char29_0 #f)))
                      (let-values (((start_13) (if start33_0 start30_0 0)))
                        (let-values (((end_11) (if end34_0 end31_0 (if (bytes? bstr_19) (bytes-length bstr_19) #f))))
                          (let-values ()
                            (let-values (((temp114_0) 'bytes-utf-8-length)
                                         ((bstr115_0) bstr_19)
                                         ((err-char116_0) err-char_7)
                                         ((start117_0) start_13)
                                         ((end118_0) end_11)
                                         ((temp119_1) #t))
                              (do-bytes->string/utf-817.1
                               temp119_1
                               #t
                               temp114_0
                               bstr115_0
                               err-char116_0
                               start117_0
                               end118_0))))))))))
    (case-lambda
     ((bstr_70) (bytes-utf-8-length36_0 bstr_70 #f #f #f #f #f #f))
     ((bstr_71 err-char_8 start_14 end31_1) (bytes-utf-8-length36_0 bstr_71 err-char_8 start_14 end31_1 #t #t #t))
     ((bstr_72 err-char_9 start30_1) (bytes-utf-8-length36_0 bstr_72 err-char_9 start30_1 #f #t #t #f))
     ((bstr_73 err-char29_1) (bytes-utf-8-length36_0 bstr_73 err-char29_1 #f #f #t #f #f)))))
 (define-values
  (1/bytes->string/locale)
  (let-values (((bytes->string/locale45_0)
                (lambda (bstr44_0 err-char38_0 start39_0 end40_0 err-char41_0 start42_0 end43_0)
                  (let-values (((bstr_74) bstr44_0))
                    (let-values (((err-char_10) (if err-char41_0 err-char38_0 #f)))
                      (let-values (((start_15) (if start42_0 start39_0 0)))
                        (let-values (((end_12) (if end43_0 end40_0 (if (bytes? bstr_74) (bytes-length bstr_74) #f))))
                          (let-values ()
                            (let-values (((temp120_0) 'bytes->string/locale)
                                         ((bstr121_0) bstr_74)
                                         ((err-char122_0) err-char_10)
                                         ((start123_0) start_15)
                                         ((end124_0) end_12))
                              (do-bytes->string/utf-817.1
                               #f
                               #f
                               temp120_0
                               bstr121_0
                               err-char122_0
                               start123_0
                               end124_0))))))))))
    (case-lambda
     ((bstr_75) (bytes->string/locale45_0 bstr_75 #f #f #f #f #f #f))
     ((bstr_76 err-char_11 start_16 end40_1) (bytes->string/locale45_0 bstr_76 err-char_11 start_16 end40_1 #t #t #t))
     ((bstr_77 err-char_12 start39_1) (bytes->string/locale45_0 bstr_77 err-char_12 start39_1 #f #t #t #f))
     ((bstr_78 err-char38_1) (bytes->string/locale45_0 bstr_78 err-char38_1 #f #f #t #f #f)))))
 (define-values
  (1/string->bytes/latin-1)
  (let-values (((string->bytes/latin-154_0)
                (lambda (str53_0 err-byte47_0 start48_0 end49_0 err-byte50_0 start51_0 end52_0)
                  (let-values (((str_16) str53_0))
                    (let-values (((err-byte_0) (if err-byte50_0 err-byte47_0 #f)))
                      (let-values (((start_17) (if start51_0 start48_0 0)))
                        (let-values (((end_13) (if end52_0 end49_0 (if (string? str_16) (string-length str_16) #f))))
                          (let-values ()
                            (let-values ((()
                                          (begin
                                            (if (string? str_16)
                                              (void)
                                              (let-values ()
                                                (raise-argument-error 'string->bytes/latin-1 "string?" str_16)))
                                            (values))))
                              (let-values ((()
                                            (begin
                                              (if ((lambda (v_41)
                                                     (let-values (((or-part_12) (not v_41)))
                                                       (if or-part_12 or-part_12 (byte? v_41))))
                                                   err-byte_0)
                                                (void)
                                                (let-values ()
                                                  (raise-argument-error
                                                   'string->bytes/latin-1
                                                   "(or/c byte? #f)"
                                                   err-byte_0)))
                                              (values))))
                                (let-values ((()
                                              (begin
                                                (if (exact-nonnegative-integer? start_17)
                                                  (void)
                                                  (let-values ()
                                                    (raise-argument-error
                                                     'string->bytes/latin-1
                                                     "exact-nonnegative-integer?"
                                                     start_17)))
                                                (values))))
                                  (let-values ((()
                                                (begin
                                                  (if (exact-nonnegative-integer? end_13)
                                                    (void)
                                                    (let-values ()
                                                      (raise-argument-error
                                                       'string->bytes/latin-1
                                                       "exact-nonnegative-integer?"
                                                       end_13)))
                                                  (values))))
                                    (let-values ((()
                                                  (begin
                                                    (check-range
                                                     'string->bytes/latin-1
                                                     start_17
                                                     end_13
                                                     (string-length str_16)
                                                     str_16)
                                                    (values))))
                                      (let-values (((len_1) (- end_13 start_17)))
                                        (let-values (((bstr_79) (make-bytes len_1)))
                                          (begin
                                            ((letrec-values (((loop_15)
                                                              (lambda (i_6)
                                                                (if (zero? i_6)
                                                                  (void)
                                                                  (let-values ()
                                                                    (let-values (((i_7) (sub1 i_6)))
                                                                      (let-values (((b_4)
                                                                                    (char->integer
                                                                                     (string-ref
                                                                                      str_16
                                                                                      (+ i_7 start_17)))))
                                                                        (begin
                                                                          (if (byte? b_4)
                                                                            (let-values () (bytes-set! bstr_79 i_7 b_4))
                                                                            (if err-byte_0
                                                                              (let-values ()
                                                                                (bytes-set! bstr_79 i_7 err-byte_0))
                                                                              (let-values ()
                                                                                (raise-arguments-error
                                                                                 'string->bytes/latin-1
                                                                                 "string cannot be encoded in Latin-1"
                                                                                 "string"
                                                                                 str_16))))
                                                                          (loop_15 i_7)))))))))
                                               loop_15)
                                             len_1)
                                            bstr_79))))))))))))))))
    (case-lambda
     ((str_17) (string->bytes/latin-154_0 str_17 #f #f #f #f #f #f))
     ((str_2 err-byte_1 start_18 end49_1) (string->bytes/latin-154_0 str_2 err-byte_1 start_18 end49_1 #t #t #t))
     ((str_18 err-byte_2 start48_1) (string->bytes/latin-154_0 str_18 err-byte_2 start48_1 #f #t #t #f))
     ((str_19 err-byte47_1) (string->bytes/latin-154_0 str_19 err-byte47_1 #f #f #t #f #f)))))
 (define-values
  (do-string->bytes/utf-863.1)
  (lambda (just-length?56_0 just-length?57_0 who58_0 str59_0 err-byte60_0 start61_0 end62_0)
    (let-values (((who_10) who58_0))
      (let-values (((str_20) str59_0))
        (let-values (((err-byte_3) err-byte60_0))
          (let-values (((start_19) start61_0))
            (let-values (((end_14) end62_0))
              (let-values (((just-length?_1) (if just-length?57_0 just-length?56_0 #f)))
                (let-values ()
                  (let-values ((()
                                (begin
                                  (if (string? str_20)
                                    (void)
                                    (let-values () (raise-argument-error who_10 "string?" str_20)))
                                  (values))))
                    (let-values ((()
                                  (begin
                                    (if ((lambda (v_42)
                                           (let-values (((or-part_13) (not v_42)))
                                             (if or-part_13 or-part_13 (byte? v_42))))
                                         err-byte_3)
                                      (void)
                                      (let-values () (raise-argument-error who_10 "(or/c byte? #f)" err-byte_3)))
                                    (values))))
                      (let-values ((()
                                    (begin
                                      (if (exact-nonnegative-integer? start_19)
                                        (void)
                                        (let-values ()
                                          (raise-argument-error who_10 "exact-nonnegative-integer?" start_19)))
                                      (values))))
                        (let-values ((()
                                      (begin
                                        (if (exact-nonnegative-integer? end_14)
                                          (void)
                                          (let-values ()
                                            (raise-argument-error who_10 "exact-nonnegative-integer?" end_14)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (check-range who_10 start_19 end_14 (string-length str_20) str_20)
                                          (values))))
                            (let-values (((used-chars_0 got-bytes_0 status_0)
                                          (utf-8-encode! str_20 start_19 end_14 #f 0 #f)))
                              (if just-length?_1
                                (let-values () got-bytes_0)
                                (let-values ()
                                  (let-values (((bstr_80) (make-bytes got-bytes_0)))
                                    (begin
                                      (utf-8-encode! str_20 start_19 end_14 bstr_80 0 #f)
                                      bstr_80)))))))))))))))))))
 (define-values
  (1/string->bytes/utf-8)
  (let-values (((string->bytes/utf-873_0)
                (lambda (str72_0 err-byte66_0 start67_0 end68_0 err-byte69_0 start70_0 end71_0)
                  (let-values (((str_21) str72_0))
                    (let-values (((err-byte_4) (if err-byte69_0 err-byte66_0 #f)))
                      (let-values (((start_20) (if start70_0 start67_0 0)))
                        (let-values (((end_15) (if end71_0 end68_0 (if (string? str_21) (string-length str_21) #f))))
                          (let-values ()
                            (let-values (((temp125_0) 'string->bytes/utf-8)
                                         ((str126_0) str_21)
                                         ((err-byte127_0) err-byte_4)
                                         ((start128_0) start_20)
                                         ((end129_0) end_15))
                              (do-string->bytes/utf-863.1
                               #f
                               #f
                               temp125_0
                               str126_0
                               err-byte127_0
                               start128_0
                               end129_0))))))))))
    (case-lambda
     ((str_22) (string->bytes/utf-873_0 str_22 #f #f #f #f #f #f))
     ((str_23 err-byte_5 start_21 end68_1) (string->bytes/utf-873_0 str_23 err-byte_5 start_21 end68_1 #t #t #t))
     ((str_24 err-byte_6 start67_1) (string->bytes/utf-873_0 str_24 err-byte_6 start67_1 #f #t #t #f))
     ((str_25 err-byte66_1) (string->bytes/utf-873_0 str_25 err-byte66_1 #f #f #t #f #f)))))
 (define-values
  (1/string-utf-8-length)
  (let-values (((string-utf-8-length82_0)
                (lambda (str81_0 err-byte75_0 start76_0 end77_0 err-byte78_0 start79_0 end80_0)
                  (let-values (((str_9) str81_0))
                    (let-values (((err-byte_7) (if err-byte78_0 err-byte75_0 #f)))
                      (let-values (((start_22) (if start79_0 start76_0 0)))
                        (let-values (((end_16) (if end80_0 end77_0 (if (string? str_9) (string-length str_9) #f))))
                          (let-values ()
                            (let-values (((temp130_1) 'string-utf-8-length)
                                         ((str131_0) str_9)
                                         ((err-byte132_0) err-byte_7)
                                         ((start133_0) start_22)
                                         ((end134_0) end_16)
                                         ((temp135_1) #t))
                              (do-string->bytes/utf-863.1
                               temp135_1
                               #t
                               temp130_1
                               str131_0
                               err-byte132_0
                               start133_0
                               end134_0))))))))))
    (case-lambda
     ((str_26) (string-utf-8-length82_0 str_26 #f #f #f #f #f #f))
     ((str_27 err-byte_8 start_23 end77_1) (string-utf-8-length82_0 str_27 err-byte_8 start_23 end77_1 #t #t #t))
     ((str_28 err-byte_9 start76_1) (string-utf-8-length82_0 str_28 err-byte_9 start76_1 #f #t #t #f))
     ((str_29 err-byte75_1) (string-utf-8-length82_0 str_29 err-byte75_1 #f #f #t #f #f)))))
 (define-values
  (1/string->bytes/locale)
  (let-values (((string->bytes/locale91_0)
                (lambda (str90_0 err-byte84_0 start85_0 end86_0 err-byte87_0 start88_0 end89_0)
                  (let-values (((str_30) str90_0))
                    (let-values (((err-byte_10) (if err-byte87_0 err-byte84_0 #f)))
                      (let-values (((start_24) (if start88_0 start85_0 0)))
                        (let-values (((end_17) (if end89_0 end86_0 (if (string? str_30) (string-length str_30) #f))))
                          (let-values ()
                            (let-values (((temp136_1) 'string->bytes/locale)
                                         ((str137_0) str_30)
                                         ((err-byte138_0) err-byte_10)
                                         ((start139_0) start_24)
                                         ((end140_0) end_17))
                              (do-string->bytes/utf-863.1
                               #f
                               #f
                               temp136_1
                               str137_0
                               err-byte138_0
                               start139_0
                               end140_0))))))))))
    (case-lambda
     ((str_31) (string->bytes/locale91_0 str_31 #f #f #f #f #f #f))
     ((str_32 err-byte_11 start_25 end86_1) (string->bytes/locale91_0 str_32 err-byte_11 start_25 end86_1 #t #t #t))
     ((str_33 err-byte_12 start85_1) (string->bytes/locale91_0 str_33 err-byte_12 start85_1 #f #t #t #f))
     ((str_10 err-byte84_1) (string->bytes/locale91_0 str_10 err-byte84_1 #f #f #t #f #f)))))
 (define-values
  (1/write-string)
  (let-values (((write-string8_0)
                (lambda (str7_0 out1_0 start2_0 end3_1 out4_0 start5_0 end6_0)
                  (let-values (((str_34) str7_0))
                    (let-values (((out_14) (if out4_0 out1_0 (current-output-port))))
                      (let-values (((start_8) (if start5_0 start2_0 0)))
                        (let-values (((end_8) (if end6_0 end3_1 (if (string? str_34) (string-length str_34) #f))))
                          (let-values ()
                            (begin
                              (if (string? str_34)
                                (void)
                                (let-values () (raise-argument-error 'write-string "string?" str_34)))
                              (if (1/output-port? out_14)
                                (void)
                                (let-values () (raise-argument-error 'write-string "output-port?" out_14)))
                              (if (exact-nonnegative-integer? start_8)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-string "exact-nonnegative-integer?" start_8)))
                              (if (exact-nonnegative-integer? end_8)
                                (void)
                                (let-values () (raise-argument-error 'write-string "exact-nonnegative-integer?" end_8)))
                              (check-range 'write-string start_8 end_8 (string-length str_34) str_34)
                              ((letrec-values (((loop_7)
                                                (lambda (i_8)
                                                  (if (= i_8 end_8)
                                                    (let-values () (- i_8 start_8))
                                                    (let-values ()
                                                      (let-values (((next-i_2) (min end_8 (+ i_8 4096))))
                                                        (let-values (((bstr_81)
                                                                      (1/string->bytes/utf-8 str_34 0 i_8 next-i_2)))
                                                          (begin
                                                            (do-write-bytes
                                                             'write-string
                                                             out_14
                                                             bstr_81
                                                             0
                                                             (bytes-length bstr_81))
                                                            (loop_7 next-i_2)))))))))
                                 loop_7)
                               start_8))))))))))
    (case-lambda
     ((str_35) (write-string8_0 str_35 #f #f #f #f #f #f))
     ((str_0 out_15 start_26 end3_2) (write-string8_0 str_0 out_15 start_26 end3_2 #t #t #t))
     ((str_36 out_16 start2_2) (write-string8_0 str_36 out_16 start2_2 #f #t #t #f))
     ((str_37 out1_1) (write-string8_0 str_37 out1_1 #f #f #t #f #f)))))
 (define-values (min+1) (lambda (a_0 b_7) (if a_0 (min (add1 a_0) b_7) b_7)))
 (define-values
  (struct:pipe-data pipe-data1.1 pipe-data? pipe-data-get-content-length)
  (let-values (((struct:_2 make-_2 ?_2 -ref_2 -set!_2)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'pipe-data #f 1 0 #f null (current-inspector) #f '(0) #f 'pipe-data)))))
    (values struct:_2 make-_2 ?_2 (make-struct-field-accessor -ref_2 0 'get-content-length))))
 (define-values (pipe-input-port?) (lambda (p_2) (if (1/input-port? p_2) (pipe-data? (input-port-data p_2)) #f)))
 (define-values (pipe-output-port?) (lambda (p_3) (if (1/output-port? p_3) (pipe-data? (output-port-data p_3)) #f)))
 (define-values
  (1/pipe-content-length)
  (lambda (p_4)
    (if (pipe-input-port? p_4)
      (let-values () ((pipe-data-get-content-length (input-port-data p_4))))
      (if (pipe-output-port? p_4)
        (let-values () ((pipe-data-get-content-length (output-port-data p_4))))
        (let-values () (raise-argument-error 'pipe-contact-length "(or/c pipe-input-port? pipe-output-port?)" p_4))))))
 (define-values
  (1/make-pipe)
  (let-values (((make-pipe8_0)
                (lambda (limit2_0 input-name3_0 output-name4_0 limit5_0 input-name6_0 output-name7_0)
                  (let-values (((limit_0) (if limit5_0 limit2_0 #f)))
                    (let-values (((input-name_0) (if input-name6_0 input-name3_0 'pipe)))
                      (let-values (((output-name_0) (if output-name7_0 output-name4_0 'pipe)))
                        (let-values ()
                          (let-values ((()
                                        (begin
                                          (if ((lambda (x_2)
                                                 (let-values (((or-part_14) (not x_2)))
                                                   (if or-part_14 or-part_14 (exact-positive-integer? limit_0))))
                                               limit_0)
                                            (void)
                                            (let-values ()
                                              (raise-argument-error
                                               'open-input-bytes
                                               "(or/c #f exact-nonnegative-integer?)"
                                               limit_0)))
                                          (values))))
                            (let-values (((bstr_82) (make-bytes (min+1 limit_0 256))))
                              (let-values (((start_27) 0))
                                (let-values (((end_18) 0))
                                  (let-values (((output-closed?_0) #f))
                                    (let-values (((data_2)
                                                  (pipe-data1.1
                                                   (lambda ()
                                                     (if (<= start_27 end_18)
                                                       (- end_18 start_27)
                                                       (+ end_18 (- (bytes-length bstr_82) start_27)))))))
                                      (values
                                       (let-values (((input-name11_0) input-name_0)
                                                    ((data12_0) data_2)
                                                    ((temp13_1)
                                                     (lambda ()
                                                       ((letrec-values (((try-again_1)
                                                                         (lambda ()
                                                                           (if (= start_27 end_18)
                                                                             (let-values ()
                                                                               (if output-closed?_0
                                                                                 eof
                                                                                 (begin '(wait) (try-again_1))))
                                                                             (let-values ()
                                                                               (let-values (((pos_0) start_27))
                                                                                 (begin
                                                                                   (set! start_27
                                                                                     (modulo
                                                                                      (add1 pos_0)
                                                                                      (bytes-length bstr_82)))
                                                                                   (bytes-ref bstr_82 pos_0))))))))
                                                          try-again_1))))
                                                    ((temp14_1)
                                                     (lambda (dest-bstr_0 dest-start_0 dest-end_0 copy?_0)
                                                       (if (= start_27 end_18)
                                                         (let-values () (if output-closed?_0 eof 0))
                                                         (let-values ()
                                                           (let-values (((len_2) (bytes-length bstr_82)))
                                                             (if (< start_27 end_18)
                                                               (let-values ()
                                                                 (let-values (((amt_17)
                                                                               (min
                                                                                (- dest-end_0 dest-start_0)
                                                                                (- end_18 start_27))))
                                                                   (begin
                                                                     (bytes-copy!
                                                                      dest-bstr_0
                                                                      dest-start_0
                                                                      bstr_82
                                                                      start_27
                                                                      (+ start_27 amt_17))
                                                                     (set! start_27 (+ start_27 amt_17))
                                                                     amt_17)))
                                                               (let-values ()
                                                                 (let-values (((amt_18)
                                                                               (min
                                                                                (- dest-end_0 dest-start_0)
                                                                                (- len_2 start_27))))
                                                                   (begin
                                                                     (bytes-copy!
                                                                      dest-bstr_0
                                                                      dest-start_0
                                                                      bstr_82
                                                                      start_27
                                                                      (+ start_27 amt_18))
                                                                     (set! start_27 (modulo (+ start_27 amt_18) len_2))
                                                                     amt_18)))))))))
                                                    ((temp15_1)
                                                     (lambda ()
                                                       ((letrec-values (((try-again_2)
                                                                         (lambda ()
                                                                           (if (= start_27 end_18)
                                                                             (let-values ()
                                                                               (if output-closed?_0
                                                                                 eof
                                                                                 (begin '(wait) (try-again_2))))
                                                                             (let-values ()
                                                                               (bytes-ref bstr_82 start_27))))))
                                                          try-again_2))))
                                                    ((temp16_1)
                                                     (lambda (dest-bstr_1 dest-start_1 dest-end_1 skip_3 copy?_1)
                                                       (let-values (((content-amt_0)
                                                                     (if (< start_27 end_18)
                                                                       (- end_18 start_27)
                                                                       (+ end_18 (- (bytes-length bstr_82) start_27)))))
                                                         (if (<= content-amt_0 skip_3)
                                                           (let-values () (if output-closed?_0 eof 0))
                                                           (let-values ()
                                                             (let-values (((len_3) (bytes-length bstr_82)))
                                                               (let-values (((peek-start_0)
                                                                             (modulo (+ start_27 skip_3) len_3)))
                                                                 (if (< peek-start_0 end_18)
                                                                   (let-values ()
                                                                     (let-values (((amt_19)
                                                                                   (min
                                                                                    (- dest-end_1 dest-start_1)
                                                                                    (- end_18 peek-start_0))))
                                                                       (begin
                                                                         (bytes-copy!
                                                                          dest-bstr_1
                                                                          dest-start_1
                                                                          bstr_82
                                                                          peek-start_0
                                                                          (+ peek-start_0 amt_19))
                                                                         amt_19)))
                                                                   (let-values ()
                                                                     (let-values (((amt_20)
                                                                                   (min
                                                                                    (- dest-end_1 dest-start_1)
                                                                                    (- len_3 peek-start_0))))
                                                                       (begin
                                                                         (bytes-copy!
                                                                          dest-bstr_1
                                                                          dest-start_1
                                                                          bstr_82
                                                                          peek-start_0
                                                                          (+ peek-start_0 amt_20))
                                                                         amt_20)))))))))))
                                                    ((void17_0) void))
                                         (make-input-port24.1
                                          void17_0
                                          #f
                                          #f
                                          #f
                                          #f
                                          data12_0
                                          #t
                                          #f
                                          #f
                                          #f
                                          #f
                                          input-name11_0
                                          temp15_1
                                          #t
                                          temp16_1
                                          temp13_1
                                          #t
                                          temp14_1))
                                       (let-values (((output-name18_0) output-name_0)
                                                    ((data19_0) data_2)
                                                    ((temp20_0) 'evt)
                                                    ((temp21_0)
                                                     (lambda (src-bstr_0
                                                              src-start_0
                                                              src-end_0
                                                              nonblock?_0
                                                              enable-break?_1)
                                                       ((letrec-values (((try-again_3)
                                                                         (lambda ()
                                                                           (let-values (((len_4)
                                                                                         (bytes-length bstr_82)))
                                                                             (let-values (((top-pos_0)
                                                                                           (if (zero? start_27)
                                                                                             (sub1 len_4)
                                                                                             len_4)))
                                                                               (let-values (((maybe-grow_0)
                                                                                             (lambda ()
                                                                                               (if (let-values (((or-part_15)
                                                                                                                 (not
                                                                                                                  limit_0)))
                                                                                                     (if or-part_15
                                                                                                       or-part_15
                                                                                                       (>
                                                                                                        limit_0
                                                                                                        (sub1 len_4))))
                                                                                                 (let-values ()
                                                                                                   (let-values (((new-bstr_0)
                                                                                                                 (make-bytes
                                                                                                                  (min+1
                                                                                                                   limit_0
                                                                                                                   (*
                                                                                                                    len_4
                                                                                                                    2)))))
                                                                                                     (begin
                                                                                                       (if (zero?
                                                                                                            start_27)
                                                                                                         (let-values ()
                                                                                                           (bytes-copy!
                                                                                                            new-bstr_0
                                                                                                            0
                                                                                                            bstr_82
                                                                                                            0
                                                                                                            (sub1
                                                                                                             len_4)))
                                                                                                         (let-values ()
                                                                                                           (begin
                                                                                                             (bytes-copy!
                                                                                                              new-bstr_0
                                                                                                              0
                                                                                                              bstr_82
                                                                                                              start_27
                                                                                                              len_4)
                                                                                                             (bytes-copy!
                                                                                                              new-bstr_0
                                                                                                              (-
                                                                                                               len_4
                                                                                                               start_27)
                                                                                                              bstr_82
                                                                                                              0
                                                                                                              end_18)
                                                                                                             (set! start_27
                                                                                                               0)
                                                                                                             (set! end_18
                                                                                                               (sub1
                                                                                                                len_4)))))
                                                                                                       (set! bstr_82
                                                                                                         new-bstr_0)
                                                                                                       (try-again_3))))
                                                                                                 (let-values () 0)))))
                                                                                 (if (if (>= end_18 start_27)
                                                                                       (< end_18 top-pos_0)
                                                                                       #f)
                                                                                   (let-values ()
                                                                                     (let-values (((amt_21)
                                                                                                   (min
                                                                                                    (- top-pos_0 end_18)
                                                                                                    (-
                                                                                                     src-end_0
                                                                                                     src-start_0))))
                                                                                       (begin
                                                                                         (bytes-copy!
                                                                                          bstr_82
                                                                                          end_18
                                                                                          src-bstr_0
                                                                                          src-start_0
                                                                                          (+ src-start_0 amt_21))
                                                                                         (set! end_18 (+ end_18 amt_21))
                                                                                         amt_21)))
                                                                                   (if (= end_18 top-pos_0)
                                                                                     (let-values ()
                                                                                       (if (zero? start_27)
                                                                                         (let-values () (maybe-grow_0))
                                                                                         (let-values ()
                                                                                           (let-values (((amt_22)
                                                                                                         (min
                                                                                                          (sub1
                                                                                                           start_27)
                                                                                                          (-
                                                                                                           src-end_0
                                                                                                           src-start_0))))
                                                                                             (begin
                                                                                               (bytes-copy!
                                                                                                bstr_82
                                                                                                0
                                                                                                src-bstr_0
                                                                                                src-start_0
                                                                                                (+ src-start_0 amt_22))
                                                                                               (set! end_18 amt_22)
                                                                                               amt_22)))))
                                                                                     (if (< end_18 (sub1 start_27))
                                                                                       (let-values ()
                                                                                         (let-values (((amt_23)
                                                                                                       (min
                                                                                                        (-
                                                                                                         (sub1 start_27)
                                                                                                         end_18)
                                                                                                        (-
                                                                                                         src-end_0
                                                                                                         src-start_0))))
                                                                                           (begin
                                                                                             (bytes-copy!
                                                                                              bstr_82
                                                                                              end_18
                                                                                              src-bstr_0
                                                                                              src-start_0
                                                                                              (+ src-start_0 amt_23))
                                                                                             (set! end_18
                                                                                               (+ end_18 amt_23))
                                                                                             amt_23)))
                                                                                       (let-values ()
                                                                                         (maybe-grow_0)))))))))))
                                                          try-again_3))))
                                                    ((temp22_0) (lambda () (set! output-closed?_0 #t))))
                                         (make-output-port22.1
                                          temp22_0
                                          #f
                                          #f
                                          data19_0
                                          #t
                                          temp20_0
                                          #f
                                          #f
                                          #f
                                          #f
                                          #f
                                          #f
                                          output-name18_0
                                          temp21_0
                                          #f
                                          #f))))))))))))))))
    (case-lambda
     (() (make-pipe8_0 #f #f #f #f #f #f))
     ((limit_1 input-name_1 output-name4_1) (make-pipe8_0 limit_1 input-name_1 output-name4_1 #t #t #t))
     ((limit_2 input-name3_1) (make-pipe8_0 limit_2 input-name3_1 #f #t #t #f))
     ((limit2_1) (make-pipe8_0 limit2_1 #f #f #t #f #f)))))
 (define-values
  (1/open-input-file)
  (let-values (((open-input-file6_0)
                (lambda (path5_1 mode11_0 mode22_0 mode13_0 mode24_0)
                  (let-values (((path_1) path5_1))
                    (let-values ()
                      (let-values ()
                        (let-values ()
                          (let-values ((()
                                        (begin
                                          (if (path-string? path_1)
                                            (void)
                                            (let-values ()
                                              (raise-argument-error 'open-input-file "path-string?" path_1)))
                                          (values))))
                            (let-values (((host-in_0)
                                          (let-values (((temp14_2) (path->string (path->complete-path path_1))))
                                            (open-input-file6.1 #f #f #f #f temp14_2))))
                              (let-values (((peek-pipe-i_0) #f))
                                (let-values (((peek-pipe-o_0) #f))
                                  (let-values (((peeked-eof?_0) #f))
                                    (let-values (((buf_0) (make-bytes 4096)))
                                      (let-values (((path8_0) path_1)
                                                   ((temp9_0)
                                                    (lambda ()
                                                      (if (if peek-pipe-i_0
                                                            (positive? (1/pipe-content-length peek-pipe-i_0))
                                                            #f)
                                                        (let-values () ((input-port-read-byte peek-pipe-i_0)))
                                                        (if peeked-eof?_0
                                                          (let-values () (begin (set! peeked-eof?_0 #f) eof))
                                                          (let-values () (read-byte host-in_0))))))
                                                   ((temp10_0)
                                                    (lambda (dest-bstr_2 start_9 end_19 copy?_2)
                                                      (if (if peek-pipe-i_0
                                                            (positive? (1/pipe-content-length peek-pipe-i_0))
                                                            #f)
                                                        (let-values ()
                                                          ((input-port-read-in peek-pipe-i_0)
                                                           dest-bstr_2
                                                           start_9
                                                           end_19
                                                           copy?_2))
                                                        (if peeked-eof?_0
                                                          (let-values () (begin (set! peeked-eof?_0 #f) eof))
                                                          (let-values ()
                                                            (read-bytes-avail!*
                                                             dest-bstr_2
                                                             host-in_0
                                                             start_9
                                                             end_19))))))
                                                   ((temp11_1)
                                                    (lambda ()
                                                      (if (if peek-pipe-i_0
                                                            (positive? (1/pipe-content-length peek-pipe-i_0))
                                                            #f)
                                                        (let-values () ((input-port-peek-byte peek-pipe-i_0)))
                                                        (let-values () (peek-byte host-in_0)))))
                                                   ((temp12_0)
                                                    (lambda (dest-bstr_3 start_28 end_20 skip_4 copy?_3)
                                                      ((letrec-values (((try-again_4)
                                                                        (lambda ()
                                                                          (let-values (((peeked-amt_0)
                                                                                        (if peek-pipe-i_0
                                                                                          (1/pipe-content-length
                                                                                           peek-pipe-i_0)
                                                                                          0)))
                                                                            (if (if peek-pipe-i_0
                                                                                  (> peeked-amt_0 skip_4)
                                                                                  #f)
                                                                              (let-values ()
                                                                                ((input-port-peek-in peek-pipe-i_0)
                                                                                 dest-bstr_3
                                                                                 start_28
                                                                                 end_20
                                                                                 skip_4
                                                                                 copy?_3))
                                                                              (if peeked-eof?_0
                                                                                (let-values () eof)
                                                                                (let-values ()
                                                                                  (let-values ((()
                                                                                                (begin
                                                                                                  (if (not
                                                                                                       peek-pipe-i_0)
                                                                                                    (let-values ()
                                                                                                      (let-values (((peek-pipe-i15_0
                                                                                                                     peek-pipe-o16_0)
                                                                                                                    (1/make-pipe)))
                                                                                                        (begin
                                                                                                          (set! peek-pipe-i_0
                                                                                                            peek-pipe-i15_0)
                                                                                                          (set! peek-pipe-o_0
                                                                                                            peek-pipe-o16_0))))
                                                                                                    (void))
                                                                                                  (values))))
                                                                                    (let-values (((v_43)
                                                                                                  (read-bytes-avail!*
                                                                                                   buf_0
                                                                                                   host-in_0
                                                                                                   0
                                                                                                   (bytes-length
                                                                                                    buf_0))))
                                                                                      (if (eof-object? v_43)
                                                                                        (let-values ()
                                                                                          (begin
                                                                                            (set! peeked-eof?_0 #t)
                                                                                            eof))
                                                                                        (if (zero? v_43)
                                                                                          (let-values () 0)
                                                                                          (let-values ()
                                                                                            (begin
                                                                                              ((output-port-write-out
                                                                                                peek-pipe-o_0)
                                                                                               buf_0
                                                                                               0
                                                                                               v_43
                                                                                               #t
                                                                                               #f)
                                                                                              (try-again_4))))))))))))))
                                                         try-again_4))))
                                                   ((temp13_2)
                                                    (lambda ()
                                                      (begin
                                                        (close-input-port host-in_0)
                                                        (set! peek-pipe-i_0 #f)
                                                        (set! peek-pipe-o_0 #f)))))
                                        (make-input-port24.1
                                         temp13_2
                                         #f
                                         #f
                                         #f
                                         #f
                                         #f
                                         #f
                                         #f
                                         #f
                                         #f
                                         #f
                                         path8_0
                                         temp11_1
                                         #t
                                         temp12_0
                                         temp9_0
                                         #t
                                         temp10_0)))))))))))))))
    (case-lambda
     ((path_2) (open-input-file6_0 path_2 #f #f #f #f))
     ((path_3 mode1_1 mode22_1) (open-input-file6_0 path_3 mode1_1 mode22_1 #t #t))
     ((path_4 mode11_1) (open-input-file6_0 path_4 mode11_1 #f #t #f)))))
 (define-values
  (1/open-input-bytes)
  (let-values (((open-input-bytes4_0)
                (lambda (bstr3_0 name1_0 name2_2)
                  (let-values (((bstr_83) bstr3_0))
                    (let-values (((name_2) (if name2_2 name1_0 'string)))
                      (let-values ()
                        (let-values ((()
                                      (begin
                                        (if (bytes? bstr_83)
                                          (void)
                                          (let-values () (raise-argument-error 'open-input-bytes "bytes?" bstr_83)))
                                        (values))))
                          (let-values (((i_9) 0))
                            (let-values (((len_5) (bytes-length bstr_83)))
                              (let-values (((name6_0) name_2)
                                           ((temp7_1)
                                            (lambda ()
                                              (let-values (((pos_1) i_9))
                                                (if (< pos_1 len_5)
                                                  (begin (set! i_9 (add1 pos_1)) (bytes-ref bstr_83 pos_1))
                                                  eof))))
                                           ((temp8_1)
                                            (lambda (dest-bstr_4 start_29 end_21 copy?_4)
                                              (let-values (((pos_2) i_9))
                                                (if (< pos_2 len_5)
                                                  (let-values ()
                                                    (let-values (((amt_24) (min (- end_21 start_29) (- len_5 pos_2))))
                                                      (begin
                                                        (set! i_9 (+ pos_2 amt_24))
                                                        (bytes-copy!
                                                         dest-bstr_4
                                                         start_29
                                                         bstr_83
                                                         pos_2
                                                         (+ pos_2 amt_24))
                                                        amt_24)))
                                                  (let-values () eof)))))
                                           ((temp9_1)
                                            (lambda ()
                                              (let-values (((pos_3) i_9))
                                                (if (< pos_3 len_5) (bytes-ref bstr_83 pos_3) eof))))
                                           ((temp10_1)
                                            (lambda (dest-bstr_5 start_30 end_22 skip_5 copy?_5)
                                              (let-values (((pos_4) (+ i_9 skip_5)))
                                                (if (< pos_4 len_5)
                                                  (let-values ()
                                                    (let-values (((amt_25) (min (- end_22 start_30) (- len_5 pos_4))))
                                                      (begin
                                                        (bytes-copy!
                                                         dest-bstr_5
                                                         start_30
                                                         bstr_83
                                                         pos_4
                                                         (+ pos_4 amt_25))
                                                        amt_25)))
                                                  (let-values () eof)))))
                                           ((void11_0) void))
                                (make-input-port24.1
                                 void11_0
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 #f
                                 name6_0
                                 temp9_1
                                 #t
                                 temp10_1
                                 temp7_1
                                 #t
                                 temp8_1)))))))))))
    (case-lambda
     ((bstr_84) (open-input-bytes4_0 bstr_84 #f #f))
     ((bstr_85 name1_1) (open-input-bytes4_0 bstr_85 name1_1 #t)))))
 (define-values
  (1/make-input-port)
  (let-values (((make-input-port17_0)
                (lambda (name13_0
                         read-in14_0
                         peek15_0
                         close16_0
                         get-progress-evt1_0
                         commit2_0
                         get-location3_0
                         count-lines!4_0
                         init-position5_0
                         buffer-mode6_0
                         get-progress-evt7_0
                         commit8_0
                         get-location9_0
                         count-lines!10_0
                         init-position11_0
                         buffer-mode12_0)
                  (let-values ()
                    (let-values ()
                      (let-values ()
                        (let-values ()
                          (let-values ()
                            (let-values ()
                              (let-values ()
                                (let-values ()
                                  (let-values ()
                                    (let-values ()
                                      (let-values () (error 'make-input-port "not yet implemented")))))))))))))))
    (case-lambda
     ((name_3 read-in_2 peek_0 close_2)
      (make-input-port17_0 name_3 read-in_2 peek_0 close_2 #f #f #f #f #f #f #f #f #f #f #f #f))
     ((name_4
       read-in_3
       peek_1
       close_3
       get-progress-evt_1
       commit_1
       get-location_2
       count-lines!_4
       init-position_0
       buffer-mode6_1)
      (make-input-port17_0
       name_4
       read-in_3
       peek_1
       close_3
       get-progress-evt_1
       commit_1
       get-location_2
       count-lines!_4
       init-position_0
       buffer-mode6_1
       #t
       #t
       #t
       #t
       #t
       #t))
     ((name_5 read-in_4 peek_2 close_4 get-progress-evt_2 commit_2 get-location_3 count-lines!_5 init-position5_1)
      (make-input-port17_0
       name_5
       read-in_4
       peek_2
       close_4
       get-progress-evt_2
       commit_2
       get-location_3
       count-lines!_5
       init-position5_1
       #f
       #t
       #t
       #t
       #t
       #t
       #f))
     ((name_6 read-in_5 peek_3 close_5 get-progress-evt_3 commit_3 get-location_4 count-lines!4_1)
      (make-input-port17_0
       name_6
       read-in_5
       peek_3
       close_5
       get-progress-evt_3
       commit_3
       get-location_4
       count-lines!4_1
       #f
       #f
       #t
       #t
       #t
       #t
       #f
       #f))
     ((name_7 read-in_6 peek_4 close_6 get-progress-evt_4 commit_4 get-location3_1)
      (make-input-port17_0
       name_7
       read-in_6
       peek_4
       close_6
       get-progress-evt_4
       commit_4
       get-location3_1
       #f
       #f
       #f
       #t
       #t
       #t
       #f
       #f
       #f))
     ((name_8 read-in_7 peek_5 close_7 get-progress-evt_5 commit2_1)
      (make-input-port17_0 name_8 read-in_7 peek_5 close_7 get-progress-evt_5 commit2_1 #f #f #f #f #t #t #f #f #f #f))
     ((name_9 read-in_8 peek_6 close_8 get-progress-evt1_1)
      (make-input-port17_0 name_9 read-in_8 peek_6 close_8 get-progress-evt1_1 #f #f #f #f #f #t #f #f #f #f #f)))))
 (define-values
  (1/make-output-port)
  (let-values (((make-output-port19_0)
                (lambda (name15_0
                         evt16_0
                         write-out17_0
                         close18_0
                         write-out-special1_0
                         get-write-evt2_0
                         get-write-special-evt3_0
                         get-location4_0
                         count-lines!5_0
                         init-position6_0
                         buffer-mode7_0
                         write-out-special8_0
                         get-write-evt9_0
                         get-write-special-evt10_0
                         get-location11_1
                         count-lines!12_1
                         init-position13_0
                         buffer-mode14_0)
                  (let-values ()
                    (let-values ()
                      (let-values ()
                        (let-values ()
                          (let-values ()
                            (let-values ()
                              (let-values ()
                                (let-values ()
                                  (let-values ()
                                    (let-values ()
                                      (let-values ()
                                        (let-values () (error 'make-output-port "not yet implemented"))))))))))))))))
    (case-lambda
     ((name_10 evt_1 write-out_2 close_9)
      (make-output-port19_0 name_10 evt_1 write-out_2 close_9 #f #f #f #f #f #f #f #f #f #f #f #f #f #f))
     ((name_11
       evt_2
       write-out_3
       close_10
       write-out-special_1
       get-write-evt_1
       get-write-special-evt_1
       get-location_5
       count-lines!_6
       init-position_1
       buffer-mode7_1)
      (make-output-port19_0
       name_11
       evt_2
       write-out_3
       close_10
       write-out-special_1
       get-write-evt_1
       get-write-special-evt_1
       get-location_5
       count-lines!_6
       init-position_1
       buffer-mode7_1
       #t
       #t
       #t
       #t
       #t
       #t
       #t))
     ((name_12
       evt_3
       write-out_4
       close_11
       write-out-special_2
       get-write-evt_2
       get-write-special-evt_2
       get-location_6
       count-lines!_7
       init-position6_1)
      (make-output-port19_0
       name_12
       evt_3
       write-out_4
       close_11
       write-out-special_2
       get-write-evt_2
       get-write-special-evt_2
       get-location_6
       count-lines!_7
       init-position6_1
       #f
       #t
       #t
       #t
       #t
       #t
       #t
       #f))
     ((name_13
       evt_4
       write-out_5
       close_12
       write-out-special_3
       get-write-evt_3
       get-write-special-evt_3
       get-location_7
       count-lines!5_1)
      (make-output-port19_0
       name_13
       evt_4
       write-out_5
       close_12
       write-out-special_3
       get-write-evt_3
       get-write-special-evt_3
       get-location_7
       count-lines!5_1
       #f
       #f
       #t
       #t
       #t
       #t
       #t
       #f
       #f))
     ((name_14 evt_5 write-out_6 close_13 write-out-special_4 get-write-evt_4 get-write-special-evt_4 get-location4_1)
      (make-output-port19_0
       name_14
       evt_5
       write-out_6
       close_13
       write-out-special_4
       get-write-evt_4
       get-write-special-evt_4
       get-location4_1
       #f
       #f
       #f
       #t
       #t
       #t
       #t
       #f
       #f
       #f))
     ((name_15 evt_6 write-out_7 close_14 write-out-special_5 get-write-evt_5 get-write-special-evt3_1)
      (make-output-port19_0
       name_15
       evt_6
       write-out_7
       close_14
       write-out-special_5
       get-write-evt_5
       get-write-special-evt3_1
       #f
       #f
       #f
       #f
       #t
       #t
       #t
       #f
       #f
       #f
       #f))
     ((name_16 evt_7 write-out_8 close_15 write-out-special_6 get-write-evt2_1)
      (make-output-port19_0
       name_16
       evt_7
       write-out_8
       close_15
       write-out-special_6
       get-write-evt2_1
       #f
       #f
       #f
       #f
       #f
       #t
       #t
       #f
       #f
       #f
       #f
       #f))
     ((name_17 evt_8 write-out_9 close_16 write-out-special1_1)
      (make-output-port19_0
       name_17
       evt_8
       write-out_9
       close_16
       write-out-special1_1
       #f
       #f
       #f
       #f
       #f
       #f
       #t
       #f
       #f
       #f
       #f
       #f
       #f)))))
 (define-values
  (1/close-input-port)
  (lambda (p_0)
    (begin
      (if (1/input-port? p_0) (void) (let-values () (raise-argument-error 'close-input-port "input-port?" p_0)))
      (if (input-port-closed? p_0)
        (void)
        (let-values () (begin (set-input-port-closed?! p_0 #t) ((input-port-close p_0))))))))
 (define-values
  (1/close-output-port)
  (lambda (p_5)
    (begin
      (if (1/output-port? p_5) (void) (let-values () (raise-argument-error 'close-output-port "output-port?" p_5)))
      (if (output-port-closed? p_5)
        (void)
        (let-values () (begin (set-output-port-closed?! p_5 #t) ((output-port-close p_5)))))))))
