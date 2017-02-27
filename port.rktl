;; This is not the original source code. Instead, this is the code after
;; fully expanding and flattening into a single linklet.
(linklet
 ()
 ((1/build-path/convention-type build-path/convention-type)
  (1/peek-bytes! peek-bytes!)
  (1/explode-path explode-path)
  (1/peek-byte peek-byte)
  (1/write write)
  (1/fprintf fprintf)
  (1/write-bytes-avail write-bytes-avail)
  (1/open-output-bytes open-output-bytes)
  (1/open-input-file open-input-file)
  (1/write-bytes-avail* write-bytes-avail*)
  (1/path-element->string path-element->string)
  (1/simplify-path simplify-path)
  (1/get-output-bytes get-output-bytes)
  (1/bytes->string/locale bytes->string/locale)
  (1/error error)
  (1/current-input-port current-input-port)
  (1/path->directory-path path->directory-path)
  (1/read-bytes-avail!* read-bytes-avail!*)
  (1/make-pipe make-pipe)
  (1/write-string write-string)
  (1/get-output-string get-output-string)
  (1/bytes->path bytes->path)
  (1/path<? path<?)
  (1/open-input-bytes open-input-bytes)
  (1/read-string! read-string!)
  (1/string-port? string-port?)
  (1/string->bytes/latin-1 string->bytes/latin-1)
  (is-path? path?)
  (1/bytes->string/utf-8 bytes->string/utf-8)
  (1/path->bytes path->bytes)
  (1/format format)
  (1/newline newline)
  (1/string->bytes/utf-8 string->bytes/utf-8)
  (1/string->bytes/locale string->bytes/locale)
  (1/read-bytes read-bytes)
  (pipe-input-port? pipe-input-port?)
  (1/string->path-element string->path-element)
  (1/peek-char peek-char)
  (1/absolute-path? absolute-path?)
  (1/path-convention-type path-convention-type)
  (1/path->complete-path path->complete-path)
  (1/bytes-utf-8-length bytes-utf-8-length)
  (1/cleanse-path cleanse-path)
  (1/peek-string peek-string)
  (1/read-line read-line)
  (1/write-bytes-avail/enable-break write-bytes-avail/enable-break)
  (1/display display)
  (1/read-char read-char)
  (1/make-output-port make-output-port)
  (1/bytes->path-element bytes->path-element)
  (1/complete-path? complete-path?)
  (1/input-port? input-port?)
  (1/build-path build-path)
  (1/relative-path? relative-path?)
  (1/output-port? output-port?)
  (1/path-for-some-system? path-for-some-system?)
  (1/open-input-string open-input-string)
  (1/string->path string->path)
  (1/close-input-port close-input-port)
  (1/current-error-port current-error-port)
  (1/write-bytes write-bytes)
  (1/prop:custom-write prop:custom-write)
  (1/read-bytes-avail! read-bytes-avail!)
  (1/peek-string! peek-string!)
  (1/string-utf-8-length string-utf-8-length)
  (pipe-output-port? pipe-output-port?)
  (1/print print)
  (1/read-byte read-byte)
  (1/make-input-port make-input-port)
  (1/port-next-location port-next-location)
  (1/path-element->bytes path-element->bytes)
  (1/split-path split-path)
  (1/printf printf)
  (1/read-string read-string)
  (1/read-bytes-line read-bytes-line)
  (1/bytes->string/latin-1 bytes->string/latin-1)
  (1/port-count-lines! port-count-lines!)
  (port-name port-name)
  (1/path->string path->string)
  (1/current-output-port current-output-port)
  (1/peek-bytes-avail! peek-bytes-avail!)
  (1/pipe-content-length pipe-content-length)
  (1/peek-bytes-avail!* peek-bytes-avail!*)
  (1/read-bytes! read-bytes!)
  (1/peek-bytes peek-bytes)
  (1/close-output-port close-output-port)
  (1/open-output-string open-output-string))
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
  (path-string?$1)
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
  (1/reverse)
  (lambda (l_0)
    (begin
      (if (list? l_0) (void) (raise-argument-error 'reverse "list?" l_0))
      (letrec-values (((loop_4) (lambda (a_0 l_1) (if (null? l_1) a_0 (loop_4 (cons (car l_1) a_0) (cdr l_1))))))
        (loop_4 null l_0)))))
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
      (lambda (v_13) (not (pair? (list-stream-ref v_13 0))))
      (lambda (v_14) (car (list-stream-ref v_14 0)))
      (lambda (v_15) (make-list-stream (cdr (list-stream-ref v_15 0))))))
    (cons prop:gen-sequence (lambda (v_16) (values car cdr values (list-stream-ref v_16 0) pair? #f #f))))))
 (define-values
  (check-list)
  (lambda (l_2) (if (list? l_2) (void) (let-values () (raise-argument-error 'in-list "list?" l_2)))))
 (define-values
  (check-string)
  (lambda (v_17) (if (string? v_17) (void) (let-values () (raise-argument-error 'in-string "string" v_17)))))
 (define-values
  (check-bytes)
  (lambda (v_18) (if (bytes? v_18) (void) (let-values () (raise-argument-error 'in-bytes "bytes" v_18)))))
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
      (lambda (v_19) ((do-stream-ref v_19 0)))
      (lambda (v_20) ((do-stream-ref v_20 1)))
      (lambda (v_21) ((do-stream-ref v_21 2))))))))
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
              (if (path-string?$1 path_0)
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
                              ((letrec-values (((loop_5)
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
                                                                                (loop_5
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
                                                                            (loop_5
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
                                                                                      (loop_5
                                                                                       (add1 i_0)
                                                                                       j_0
                                                                                       base-i_1
                                                                                       next-accum_0
                                                                                       (sub1 remaining_1)))))))))))
                                                                    (if (not (zero? remaining_1))
                                                                      (let-values () (encoding-failure_0))
                                                                      (if (= 192 (bitwise-and b_0 224))
                                                                        (let-values ()
                                                                          (loop_5
                                                                           (add1 i_0)
                                                                           j_0
                                                                           i_0
                                                                           (bitwise-and b_0 31)
                                                                           1))
                                                                        (if (= 224 (bitwise-and b_0 240))
                                                                          (let-values ()
                                                                            (loop_5
                                                                             (add1 i_0)
                                                                             j_0
                                                                             i_0
                                                                             (bitwise-and b_0 15)
                                                                             2))
                                                                          (if (= 240 (bitwise-and b_0 248))
                                                                            (let-values ()
                                                                              (loop_5
                                                                               (add1 i_0)
                                                                               j_0
                                                                               i_0
                                                                               (bitwise-and b_0 7)
                                                                               3))
                                                                            (let-values ()
                                                                              (encoding-failure_0))))))))))))))))))
                                 loop_5)
                               in-start_0
                               out-start_0
                               base-i_0
                               accum_0
                               remaining_0))))))))))))))))
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
            ((letrec-values (((loop_6)
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
                                          (let-values (((keep-aborts_0) (lambda (s_1) (if (eq? s_1 'complete) #f s_1))))
                                            (loop_6
                                             end_0
                                             0
                                             line_0
                                             (+ column_0 got-chars_0)
                                             (+ position_0 got-chars_0)
                                             (keep-aborts_0 new-state_0)
                                             #f))))))
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
                                                        (loop_6
                                                         end_0
                                                         0
                                                         line_0
                                                         (+ column_0 got-chars_1)
                                                         (+ position_0 got-chars_1)
                                                         #f
                                                         #f)))))
                                        (if (eq? b_1 (char->integer '#\newline))
                                          (let-values ()
                                            (if (let-values (((or-part_3) state_1))
                                                  (if or-part_3 or-part_3 (not (zero? span_0))))
                                              (let-values () (end-utf-8_0))
                                              (if cr-state_0
                                                (let-values ()
                                                  (loop_6 (add1 i_1) 0 line_0 column_0 (add1 position_0) #f #f))
                                                (let-values ()
                                                  (loop_6 (add1 i_1) 0 (add1 line_0) 0 (add1 position_0) #f #f)))))
                                          (if (eq? b_1 (char->integer '#\return))
                                            (let-values ()
                                              (if (if (zero? span_0) (not state_1) #f)
                                                (loop_6 (add1 i_1) 0 (add1 line_0) 0 (add1 position_0) #f #t)
                                                (end-utf-8_0)))
                                            (if (eq? b_1 (char->integer '#\tab))
                                              (let-values ()
                                                (if (if (zero? span_0) (not state_1) #f)
                                                  (loop_6
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
                                                    (loop_6 (add1 i_1) 0 line_0 (add1 column_0) (add1 position_0) #f #f)
                                                    (loop_6
                                                     (add1 i_1)
                                                     (add1 span_0)
                                                     line_0
                                                     column_0
                                                     position_0
                                                     state_1
                                                     #f)))
                                                (let-values ()
                                                  (loop_6
                                                   (add1 i_1)
                                                   (add1 span_0)
                                                   line_0
                                                   column_0
                                                   position_0
                                                   state_1
                                                   #f)))))))))))))
               loop_6)
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
                                                      (let-values (((v_22)
                                                                    (read-in_1 bstr_1 start_1 end_1 copy-bstr?_0)))
                                                        (if (exact-nonnegative-integer? v_22)
                                                          (let-values ()
                                                            (if (zero? v_22)
                                                              (let-values () (if zero-ok?_0 0 (loop_1 in_2)))
                                                              (if (<= v_22 (- end_1 start_1))
                                                                (let-values ()
                                                                  (begin
                                                                    (input-port-count! orig-in_0 v_22 bstr_1 start_1)
                                                                    v_22))
                                                                (let-values ()
                                                                  (raise-arguments-error
                                                                   who_2
                                                                   "result integer is larger than the supplied byte string"
                                                                   "result"
                                                                   v_22
                                                                   "byte-string length"
                                                                   (- end_1 start_1))))))
                                                          (if (eof-object? v_22)
                                                            (let-values () eof)
                                                            (let-values ()
                                                              (raise-result-error
                                                               who_2
                                                               "(or/c exact-nonnegative-integer? eof-object? evt? pipe-input-port? #f procedure?)"
                                                               v_22))))))
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
                      ((letrec-values (((loop_7)
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
                                              (if (zero? (bytes-length bstr_2))
                                                (let-values () 0)
                                                (let-values ()
                                                  (let-values (((peek-in_1) (input-port-peek-in in_3)))
                                                    (if (procedure? peek-in_1)
                                                      (let-values ()
                                                        (let-values (((v_23)
                                                                      (peek-in_1
                                                                       bstr_2
                                                                       start_2
                                                                       end_2
                                                                       skip_0
                                                                       copy-bstr?_1)))
                                                          (if (exact-nonnegative-integer? v_23)
                                                            (let-values ()
                                                              (if (zero? v_23)
                                                                (let-values () (if zero-ok?_1 0 (loop_7 in_3)))
                                                                (if (<= v_23 (- end_2 start_2))
                                                                  (let-values () v_23)
                                                                  (let-values ()
                                                                    (raise-arguments-error
                                                                     who_3
                                                                     "result integer is larger than the supplied byte string"
                                                                     "result"
                                                                     v_23
                                                                     "byte-string length"
                                                                     (- end_2 start_2))))))
                                                            (if (eof-object? v_23)
                                                              (let-values () eof)
                                                              (let-values ()
                                                                (raise-result-error
                                                                 who_3
                                                                 "(or/c exact-nonnegative-integer? eof-object? evt? pipe-input-port? #f procedure?)"
                                                                 v_23))))))
                                                      (let-values () (loop_7 peek-in_1)))))))))))
                         loop_7)
                       orig-in_1))))))))))))
 (define-values
  (do-read-bytes!)
  (lambda (who_0 in_4 bstr_3 start_3 end_3)
    (let-values (((amt_1) (- end_3 start_3)))
      (let-values (((v_24)
                    (let-values (((who79_0) who_0)
                                 ((in80_0) in_4)
                                 ((bstr81_0) bstr_3)
                                 ((start82_0) start_3)
                                 ((end83_0) end_3))
                      (read-some-bytes!12.1 #f #f #f #f #f #f who79_0 in80_0 bstr81_0 start82_0 end83_0))))
        (if (not (exact-integer? v_24))
          (let-values () v_24)
          (if (= v_24 amt_1)
            (let-values () v_24)
            (let-values ()
              ((letrec-values (((loop_8)
                                (lambda (got_0)
                                  (let-values (((v_25)
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
                                    (if (eof-object? v_25)
                                      (let-values () got_0)
                                      (let-values ()
                                        (let-values (((new-got_0) (+ got_0 v_25)))
                                          (if (= new-got_0 amt_1)
                                            (let-values () amt_1)
                                            (let-values () (loop_8 new-got_0))))))))))
                 loop_8)
               v_24))))))))
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
                                (let-values (((v_26)
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
                                  (if (eq? v_26 1) (bytes-ref bstr_4 1) v_26))))))))))))
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
                              (let-values (((v_27) (do-read-bytes! 'read-bytes in_5 bstr_5 0 amt_2)))
                                (if (exact-integer? v_27)
                                  (if (= v_27 amt_2) bstr_5 (subbytes bstr_5 0 v_27))
                                  v_27)))))))))))
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
      (let-values (((v_28)
                    (let-values (((who107_0) who_4)
                                 ((in108_0) in_15)
                                 ((bstr109_0) bstr_20)
                                 ((start110_0) start_4)
                                 ((end111_0) end_4)
                                 ((skip112_0) skip_1))
                      (peek-some-bytes!25.1 #f #f #f #f who107_0 in108_0 bstr109_0 start110_0 end111_0 skip112_0))))
        (if (exact-integer? v_28)
          (if (= v_28 amt_5)
            (let-values () v_28)
            (let-values ()
              ((letrec-values (((loop_9)
                                (lambda (got_1)
                                  (let-values (((v_29)
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
                                    (if (eof-object? v_29)
                                      (let-values () got_1)
                                      (let-values ()
                                        (let-values (((new-got_1) (+ got_1 v_29)))
                                          (if (= new-got_1 amt_5)
                                            (let-values () amt_5)
                                            (let-values () (loop_9 new-got_1))))))))))
                 loop_9)
               v_28)))
          v_28)))))
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
                            (let-values (((peek-byte_1) (if (zero? skip-k_0) (input-port-peek-byte in_16) #f)))
                              (if peek-byte_1
                                (let-values () (peek-byte_1))
                                (let-values ()
                                  (let-values (((bstr_21) (make-bytes 1)))
                                    (let-values (((v_30)
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
                                      (if (eq? v_30 1) (bytes-ref bstr_21 0) v_30))))))))))))))
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
                                  (let-values (((v_31) (do-peek-bytes! 'read-bytes in_18 bstr_22 0 amt_6 skip-k_1)))
                                    (if (exact-integer? v_31)
                                      (if (= v_31 amt_6) bstr_22 (subbytes bstr_22 0 v_31))
                                      v_31)))))))))))))
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
                                  (let-values (((v_32)
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
                                    (if (not (exact-integer? v_32))
                                      (let-values () v_32)
                                      (if (zero? v_32)
                                        (let-values () 0)
                                        (let-values ()
                                          (let-values (((used-bytes_2 got-chars_2 state_2)
                                                        (let-values (((temp87_0) 0)
                                                                     ((v88_0) v_32)
                                                                     ((str89_0) str_0)
                                                                     ((start90_0) start_5)
                                                                     ((temp91_0) (+ start_5 amt_9))
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
                                                           temp91_0))))
                                            (if (zero? got-chars_2)
                                              (let-values ()
                                                ((letrec-values (((loop_10)
                                                                  (lambda (skip-k_20 state_3)
                                                                    (let-values (((v_33)
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
                                                                      (if (eq? v_33 0)
                                                                        (let-values () 0)
                                                                        (let-values ()
                                                                          (let-values (((used-bytes_3
                                                                                         got-chars_3
                                                                                         new-state_2)
                                                                                        (let-values (((temp102_0) 0)
                                                                                                     ((temp103_0)
                                                                                                      (if (eof-object?
                                                                                                           v_33)
                                                                                                        0
                                                                                                        v_33))
                                                                                                     ((str104_0) str_0)
                                                                                                     ((start105_0)
                                                                                                      start_5)
                                                                                                     ((amt106_0) amt_9)
                                                                                                     ((temp107_0) '#\?)
                                                                                                     ((state108_0)
                                                                                                      state_3)
                                                                                                     ((temp109_0)
                                                                                                      (if (eof-object?
                                                                                                           v_33)
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
                                                                                (loop_10
                                                                                 (+ skip-k_20 v_33)
                                                                                 new-state_2))
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
                                                   loop_10)
                                                 (+ skip-k_19 (- v_32 consumed-v_0))
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
                      (let-values (((v_34)
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
                        (if (not (exact-integer? v_34))
                          (let-values () v_34)
                          (if (= v_34 amt_10)
                            (let-values () v_34)
                            (let-values ()
                              ((letrec-values (((loop_11)
                                                (lambda (got_2)
                                                  (let-values (((v_35)
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
                                                    (if (eof-object? v_35)
                                                      (let-values () got_2)
                                                      (let-values ()
                                                        (let-values (((new-got_2) (+ got_2 v_35)))
                                                          (if (= new-got_2 amt_10)
                                                            (let-values () amt_10)
                                                            (let-values () (loop_11 new-got_2))))))))))
                                 loop_11)
                               v_34))))))))))))))))
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
                          ((letrec-values (((loop_12)
                                            (lambda (skip-k_7 state_5)
                                              (let-values (((v_36)
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
                                                (if (eof-object? v_36)
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
                                                        (let-values () (loop_12 (add1 skip-k_7) new-state_3))))))))))
                             loop_12)
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
                                (let-values (((v_37)
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
                                  (if (eq? v_37 1) (string-ref str_3 1) v_37))))
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
                              (let-values (((v_38)
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
                                (if (exact-integer? v_38)
                                  (if (= v_38 amt_11) bstr_40 (substring bstr_40 0 v_38))
                                  v_38)))))))))))
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
                            (let-values (((peek-byte_2) (if (zero? skip-k_22) (input-port-peek-byte in_36) #f)))
                              (let-values (((b_5) (if peek-byte_2 (peek-byte_2) #f)))
                                (if (if b_5
                                      (let-values (((or-part_9) (eof-object? b_5)))
                                        (if or-part_9 or-part_9 (< b_5 128)))
                                      #f)
                                  (let-values () (if (eof-object? b_5) b_5 (integer->char b_5)))
                                  (let-values ()
                                    (let-values (((bstr_41) (make-string 1)))
                                      (let-values (((v_39) (do-peek-string! 'peek-char in_36 bstr_41 0 1 skip-k_22)))
                                        (if (eq? v_39 1) (string-ref bstr_41 0) v_39)))))))))))))))
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
                                  (let-values (((v_40) (do-peek-string! 'peek-string bstr_42 in_38 0 amt_14 skip-k_23)))
                                    (if (exact-integer? v_40)
                                      (if (= v_40 amt_14) bstr_42 (substring bstr_42 0 v_40))
                                      v_40)))))))))))))
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
 (define-values (min+1) (lambda (a_1 b_6) (if a_1 (min (add1 a_1) b_6) b_6)))
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
                                                 (let-values (((or-part_10) (not x_2)))
                                                   (if or-part_10 or-part_10 (exact-positive-integer? limit_0))))
                                               limit_0)
                                            (void)
                                            (let-values ()
                                              (raise-argument-error
                                               'open-input-bytes
                                               "(or/c #f exact-nonnegative-integer?)"
                                               limit_0)))
                                          (values))))
                            (let-values (((bstr_43) (make-bytes (min+1 limit_0 256))))
                              (let-values (((start_8) 0))
                                (let-values (((end_8) 0))
                                  (let-values (((output-closed?_0) #f))
                                    (let-values (((data_2)
                                                  (pipe-data1.1
                                                   (lambda ()
                                                     (if (<= start_8 end_8)
                                                       (- end_8 start_8)
                                                       (+ end_8 (- (bytes-length bstr_43) start_8)))))))
                                      (values
                                       (let-values (((input-name11_0) input-name_0)
                                                    ((data12_0) data_2)
                                                    ((temp13_1)
                                                     (lambda ()
                                                       ((letrec-values (((try-again_0)
                                                                         (lambda ()
                                                                           (if (= start_8 end_8)
                                                                             (let-values ()
                                                                               (if output-closed?_0
                                                                                 eof
                                                                                 (begin '(wait) (try-again_0))))
                                                                             (let-values ()
                                                                               (let-values (((pos_0) start_8))
                                                                                 (begin
                                                                                   (set! start_8
                                                                                     (modulo
                                                                                      (add1 pos_0)
                                                                                      (bytes-length bstr_43)))
                                                                                   (bytes-ref bstr_43 pos_0))))))))
                                                          try-again_0))))
                                                    ((temp14_1)
                                                     (lambda (dest-bstr_0 dest-start_0 dest-end_0 copy?_0)
                                                       (if (= start_8 end_8)
                                                         (let-values () (if output-closed?_0 eof 0))
                                                         (let-values ()
                                                           (let-values (((len_0) (bytes-length bstr_43)))
                                                             (if (< start_8 end_8)
                                                               (let-values ()
                                                                 (let-values (((amt_17)
                                                                               (min
                                                                                (- dest-end_0 dest-start_0)
                                                                                (- end_8 start_8))))
                                                                   (begin
                                                                     (bytes-copy!
                                                                      dest-bstr_0
                                                                      dest-start_0
                                                                      bstr_43
                                                                      start_8
                                                                      (+ start_8 amt_17))
                                                                     (set! start_8 (+ start_8 amt_17))
                                                                     amt_17)))
                                                               (let-values ()
                                                                 (let-values (((amt_18)
                                                                               (min
                                                                                (- dest-end_0 dest-start_0)
                                                                                (- len_0 start_8))))
                                                                   (begin
                                                                     (bytes-copy!
                                                                      dest-bstr_0
                                                                      dest-start_0
                                                                      bstr_43
                                                                      start_8
                                                                      (+ start_8 amt_18))
                                                                     (set! start_8 (modulo (+ start_8 amt_18) len_0))
                                                                     amt_18)))))))))
                                                    ((temp15_1)
                                                     (lambda ()
                                                       ((letrec-values (((try-again_1)
                                                                         (lambda ()
                                                                           (if (= start_8 end_8)
                                                                             (let-values ()
                                                                               (if output-closed?_0
                                                                                 eof
                                                                                 (begin '(wait) (try-again_1))))
                                                                             (let-values ()
                                                                               (bytes-ref bstr_43 start_8))))))
                                                          try-again_1))))
                                                    ((temp16_1)
                                                     (lambda (dest-bstr_1 dest-start_1 dest-end_1 skip_3 copy?_1)
                                                       (let-values (((content-amt_0)
                                                                     (if (< start_8 end_8)
                                                                       (- end_8 start_8)
                                                                       (+ end_8 (- (bytes-length bstr_43) start_8)))))
                                                         (if (<= content-amt_0 skip_3)
                                                           (let-values () (if output-closed?_0 eof 0))
                                                           (let-values ()
                                                             (let-values (((len_1) (bytes-length bstr_43)))
                                                               (let-values (((peek-start_0)
                                                                             (modulo (+ start_8 skip_3) len_1)))
                                                                 (if (< peek-start_0 end_8)
                                                                   (let-values ()
                                                                     (let-values (((amt_19)
                                                                                   (min
                                                                                    (- dest-end_1 dest-start_1)
                                                                                    (- end_8 peek-start_0))))
                                                                       (begin
                                                                         (bytes-copy!
                                                                          dest-bstr_1
                                                                          dest-start_1
                                                                          bstr_43
                                                                          peek-start_0
                                                                          (+ peek-start_0 amt_19))
                                                                         amt_19)))
                                                                   (let-values ()
                                                                     (let-values (((amt_20)
                                                                                   (min
                                                                                    (- dest-end_1 dest-start_1)
                                                                                    (- len_1 peek-start_0))))
                                                                       (begin
                                                                         (bytes-copy!
                                                                          dest-bstr_1
                                                                          dest-start_1
                                                                          bstr_43
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
                                                              enable-break?_0)
                                                       ((letrec-values (((try-again_2)
                                                                         (lambda ()
                                                                           (let-values (((len_2)
                                                                                         (bytes-length bstr_43)))
                                                                             (let-values (((top-pos_0)
                                                                                           (if (zero? start_8)
                                                                                             (sub1 len_2)
                                                                                             len_2)))
                                                                               (let-values (((maybe-grow_0)
                                                                                             (lambda ()
                                                                                               (if (let-values (((or-part_11)
                                                                                                                 (not
                                                                                                                  limit_0)))
                                                                                                     (if or-part_11
                                                                                                       or-part_11
                                                                                                       (>
                                                                                                        limit_0
                                                                                                        (sub1 len_2))))
                                                                                                 (let-values ()
                                                                                                   (let-values (((new-bstr_0)
                                                                                                                 (make-bytes
                                                                                                                  (min+1
                                                                                                                   limit_0
                                                                                                                   (*
                                                                                                                    len_2
                                                                                                                    2)))))
                                                                                                     (begin
                                                                                                       (if (zero?
                                                                                                            start_8)
                                                                                                         (let-values ()
                                                                                                           (bytes-copy!
                                                                                                            new-bstr_0
                                                                                                            0
                                                                                                            bstr_43
                                                                                                            0
                                                                                                            (sub1
                                                                                                             len_2)))
                                                                                                         (let-values ()
                                                                                                           (begin
                                                                                                             (bytes-copy!
                                                                                                              new-bstr_0
                                                                                                              0
                                                                                                              bstr_43
                                                                                                              start_8
                                                                                                              len_2)
                                                                                                             (bytes-copy!
                                                                                                              new-bstr_0
                                                                                                              (-
                                                                                                               len_2
                                                                                                               start_8)
                                                                                                              bstr_43
                                                                                                              0
                                                                                                              end_8)
                                                                                                             (set! start_8
                                                                                                               0)
                                                                                                             (set! end_8
                                                                                                               (sub1
                                                                                                                len_2)))))
                                                                                                       (set! bstr_43
                                                                                                         new-bstr_0)
                                                                                                       (try-again_2))))
                                                                                                 (let-values () 0)))))
                                                                                 (if (if (>= end_8 start_8)
                                                                                       (< end_8 top-pos_0)
                                                                                       #f)
                                                                                   (let-values ()
                                                                                     (let-values (((amt_21)
                                                                                                   (min
                                                                                                    (- top-pos_0 end_8)
                                                                                                    (-
                                                                                                     src-end_0
                                                                                                     src-start_0))))
                                                                                       (begin
                                                                                         (bytes-copy!
                                                                                          bstr_43
                                                                                          end_8
                                                                                          src-bstr_0
                                                                                          src-start_0
                                                                                          (+ src-start_0 amt_21))
                                                                                         (let-values (((new-end_0)
                                                                                                       (+
                                                                                                        end_8
                                                                                                        amt_21)))
                                                                                           (set! end_8
                                                                                             (if (= new-end_0 len_2)
                                                                                               0
                                                                                               new-end_0)))
                                                                                         amt_21)))
                                                                                   (if (= end_8 top-pos_0)
                                                                                     (let-values ()
                                                                                       (if (zero? start_8)
                                                                                         (let-values () (maybe-grow_0))
                                                                                         (let-values ()
                                                                                           (let-values (((amt_22)
                                                                                                         (min
                                                                                                          (sub1 start_8)
                                                                                                          (-
                                                                                                           src-end_0
                                                                                                           src-start_0))))
                                                                                             (begin
                                                                                               (bytes-copy!
                                                                                                bstr_43
                                                                                                0
                                                                                                src-bstr_0
                                                                                                src-start_0
                                                                                                (+ src-start_0 amt_22))
                                                                                               (set! end_8 amt_22)
                                                                                               amt_22)))))
                                                                                     (if (< end_8 (sub1 start_8))
                                                                                       (let-values ()
                                                                                         (let-values (((amt_23)
                                                                                                       (min
                                                                                                        (-
                                                                                                         (sub1 start_8)
                                                                                                         end_8)
                                                                                                        (-
                                                                                                         src-end_0
                                                                                                         src-start_0))))
                                                                                           (begin
                                                                                             (bytes-copy!
                                                                                              bstr_43
                                                                                              end_8
                                                                                              src-bstr_0
                                                                                              src-start_0
                                                                                              (+ src-start_0 amt_23))
                                                                                             (set! end_8
                                                                                               (+ end_8 amt_23))
                                                                                             amt_23)))
                                                                                       (let-values ()
                                                                                         (maybe-grow_0)))))))))))
                                                          try-again_2))))
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
  (open-input-peek-to-read11.1)
  (lambda (close5_0 name1_0 peek-byte4_0 peek-byte9_0 read-byte2_0 read-in3_0)
    (let-values (((name_2) name1_0))
      (let-values (((read-byte_4) read-byte2_0))
        (let-values (((read-in_2) read-in3_0))
          (let-values (((peek-byte_3) (if peek-byte9_0 peek-byte4_0 #f)))
            (let-values (((close_2) close5_0))
              (let-values ()
                (let-values (((peek-pipe-i_0) #f))
                  (let-values (((peek-pipe-o_0) #f))
                    (let-values (((peeked-eof?_0) #f))
                      (let-values (((buf_0) (make-bytes 4096)))
                        (let-values (((name14_0) name_2)
                                     ((temp15_2)
                                      (lambda ()
                                        (if (if peek-pipe-i_0 (positive? (1/pipe-content-length peek-pipe-i_0)) #f)
                                          (let-values () ((input-port-read-byte peek-pipe-i_0)))
                                          (if peeked-eof?_0
                                            (let-values () (begin (set! peeked-eof?_0 #f) eof))
                                            (let-values () (read-byte_4))))))
                                     ((temp16_2)
                                      (lambda (dest-bstr_2 start_9 end_9 copy?_2)
                                        (if (if peek-pipe-i_0 (positive? (1/pipe-content-length peek-pipe-i_0)) #f)
                                          (let-values ()
                                            ((input-port-read-in peek-pipe-i_0) dest-bstr_2 start_9 end_9 copy?_2))
                                          (if peeked-eof?_0
                                            (let-values () (begin (set! peeked-eof?_0 #f) eof))
                                            (let-values () (read-in_2 dest-bstr_2 start_9 end_9 copy?_2))))))
                                     ((temp17_0)
                                      (if peek-byte_3
                                        (lambda ()
                                          (if (if peek-pipe-i_0 (positive? (1/pipe-content-length peek-pipe-i_0)) #f)
                                            (let-values () ((input-port-peek-byte peek-pipe-i_0)))
                                            (let-values () (peek-byte_3))))
                                        #f))
                                     ((temp18_0)
                                      (lambda (dest-bstr_3 start_10 end_10 skip_4 copy?_3)
                                        ((letrec-values (((try-again_3)
                                                          (lambda ()
                                                            (let-values (((peeked-amt_0)
                                                                          (if peek-pipe-i_0
                                                                            (1/pipe-content-length peek-pipe-i_0)
                                                                            0)))
                                                              (if (if peek-pipe-i_0 (> peeked-amt_0 skip_4) #f)
                                                                (let-values ()
                                                                  ((input-port-peek-in peek-pipe-i_0)
                                                                   dest-bstr_3
                                                                   start_10
                                                                   end_10
                                                                   skip_4
                                                                   copy?_3))
                                                                (if peeked-eof?_0
                                                                  (let-values () eof)
                                                                  (let-values ()
                                                                    (let-values ((()
                                                                                  (begin
                                                                                    (if (not peek-pipe-i_0)
                                                                                      (let-values ()
                                                                                        (let-values (((peek-pipe-i20_0
                                                                                                       peek-pipe-o21_0)
                                                                                                      (1/make-pipe)))
                                                                                          (begin
                                                                                            (set! peek-pipe-i_0
                                                                                              peek-pipe-i20_0)
                                                                                            (set! peek-pipe-o_0
                                                                                              peek-pipe-o21_0))))
                                                                                      (void))
                                                                                    (values))))
                                                                      (let-values (((v_27)
                                                                                    (read-in_2
                                                                                     buf_0
                                                                                     0
                                                                                     (bytes-length buf_0)
                                                                                     #f)))
                                                                        (if (eof-object? v_27)
                                                                          (let-values ()
                                                                            (begin (set! peeked-eof?_0 #t) eof))
                                                                          (if (zero? v_27)
                                                                            (let-values () 0)
                                                                            (let-values ()
                                                                              (begin
                                                                                ((letrec-values (((loop_13)
                                                                                                  (lambda (wrote_0)
                                                                                                    (let-values (((just-wrote_0)
                                                                                                                  ((output-port-write-out
                                                                                                                    peek-pipe-o_0)
                                                                                                                   buf_0
                                                                                                                   wrote_0
                                                                                                                   v_27
                                                                                                                   #t
                                                                                                                   #f)))
                                                                                                      (let-values (((next-wrote_0)
                                                                                                                    (+
                                                                                                                     wrote_0
                                                                                                                     just-wrote_0)))
                                                                                                        (if (=
                                                                                                             v_27
                                                                                                             next-wrote_0)
                                                                                                          (void)
                                                                                                          (let-values ()
                                                                                                            (loop_13
                                                                                                             next-wrote_0))))))))
                                                                                   loop_13)
                                                                                 0)
                                                                                (try-again_3))))))))))))))
                                           try-again_3))))
                                     ((temp19_0)
                                      (lambda () (begin (close_2) (set! peek-pipe-i_0 #f) (set! peek-pipe-o_0 #f)))))
                          (make-input-port24.1
                           temp19_0
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
                           name14_0
                           temp17_0
                           #t
                           temp18_0
                           temp15_2
                           #t
                           temp16_2))))))))))))))
 (define-values
  (open-input-host)
  (lambda (host-in_0 name_3)
    (let-values (((name1_1) name_3)
                 ((temp2_1) (lambda () (read-byte host-in_0)))
                 ((temp3_0)
                  (lambda (dest-bstr_4 start_11 end_11 copy?_4)
                    (read-bytes-avail!* dest-bstr_4 host-in_0 start_11 end_11)))
                 ((temp4_1) (lambda () (peek-byte host-in_0)))
                 ((temp5_1) (lambda () (close-input-port host-in_0))))
      (open-input-peek-to-read11.1 temp5_1 name1_1 temp4_1 #t temp2_1 temp3_0))))
 (define-values
  (open-output-host)
  (lambda (host-out_0 name_4)
    (let-values (((name6_0) name_4)
                 ((temp7_1) 'evt)
                 ((temp8_1)
                  (lambda (src-bstr_1 src-start_1 src-end_1 nonblock?_1 enable-break?_1)
                    (write-bytes-avail* src-bstr_1 host-out_0 src-start_1 src-end_1)))
                 ((temp9_0) (lambda () (close-output-port host-out_0))))
      (make-output-port22.1 temp9_0 #f #f #f #f temp7_1 #f #f #f #f #f #f name6_0 temp8_1 #f #f))))
 (define-values
  (1/current-input-port)
  (make-parameter
   (open-input-host (current-input-port) 'stdin)
   (lambda (v_41)
     (begin
       (if (1/input-port? v_41) (void) (let-values () (raise-argument-error 'current-input-port "input-port?" v_41)))
       v_41))))
 (define-values
  (1/current-output-port)
  (make-parameter
   (open-output-host (current-output-port) 'stdout)
   (lambda (v_42)
     (begin
       (if (1/output-port? v_42) (void) (let-values () (raise-argument-error 'current-output-port "output-port?" v_42)))
       v_42))))
 (define-values
  (1/current-error-port)
  (make-parameter
   (open-output-host (current-error-port) 'stderr)
   (lambda (v_43)
     (begin
       (if (1/output-port? v_43) (void) (let-values () (raise-argument-error 'current-error-port "output-port?" v_43)))
       v_43))))
 (define-values (abort) (lambda (str_15) (raise (exn:fail str_15 (current-continuation-marks)))))
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
                  (let-values (((enable-break?_2) (if enable-break?6_0 enable-break?3_0 #f)))
                    (let-values ()
                      (if (output-port-closed? out_0)
                        (let-values () (raise-arguments-error who_2 "output port is closed" "output port" out_0))
                        (if (= start_1 end_1)
                          (let-values () 0)
                          (let-values ()
                            (let-values (((write-out_1) (output-port-write-out out_0)))
                              ((letrec-values (((try-again_4)
                                                (lambda ()
                                                  (let-values (((v_44)
                                                                (write-out_1
                                                                 bstr_1
                                                                 start_1
                                                                 end_1
                                                                 (not buffer-ok?_0)
                                                                 enable-break?_2)))
                                                    (if (let-values (((or-part_12) (not v_44)))
                                                          (if or-part_12 or-part_12 (eq? v_44 0)))
                                                      (let-values () (if zero-ok?_3 0 (try-again_4)))
                                                      (if (exact-integer? v_44)
                                                        (let-values () v_44)
                                                        (let-values () (abort "write-some-bytes: weird result"))))))))
                                 try-again_4)))))))))))))))))
 (define-values
  (do-write-bytes)
  (lambda (who_5 out_1 bstr_44 start_5 end_5)
    ((letrec-values (((loop_14)
                      (lambda (i_2)
                        (if (= i_2 end_5)
                          (let-values () (- i_2 start_5))
                          (let-values ()
                            (let-values (((n_1)
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
                                             bstr_44
                                             i_2
                                             end_5))))
                              (loop_14 (+ n_1 i_2))))))))
       loop_14)
     start_5)))
 (define-values
  (1/write-bytes)
  (let-values (((write-bytes13_0)
                (lambda (bstr12_0 out6_0 start-pos7_0 end-pos8_0 out9_0 start-pos10_0 end-pos11_0)
                  (let-values (((bstr_45) bstr12_0))
                    (let-values (((out_2) (if out9_0 out6_0 (1/current-output-port))))
                      (let-values (((start-pos_17) (if start-pos10_0 start-pos7_0 0)))
                        (let-values (((end-pos_9)
                                      (if end-pos11_0 end-pos8_0 (if (bytes? bstr_45) (bytes-length bstr_45) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_45)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes "bytes?" bstr_45)))
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
                              (check-range 'write-bytes start-pos_17 end-pos_9 (bytes-length bstr_45) bstr_45)
                              (do-write-bytes 'write-bytes out_2 bstr_45 start-pos_17 end-pos_9))))))))))
    (case-lambda
     ((bstr_46) (write-bytes13_0 bstr_46 #f #f #f #f #f #f))
     ((bstr_47 out_3 start-pos_18 end-pos8_1) (write-bytes13_0 bstr_47 out_3 start-pos_18 end-pos8_1 #t #t #t))
     ((bstr_48 out_4 start-pos7_1) (write-bytes13_0 bstr_48 out_4 start-pos7_1 #f #t #t #f))
     ((bstr_49 out6_1) (write-bytes13_0 bstr_49 out6_1 #f #f #t #f #f)))))
 (define-values
  (1/write-bytes-avail)
  (let-values (((write-bytes-avail22_0)
                (lambda (bstr21_1 out15_0 start-pos16_0 end-pos17_0 out18_0 start-pos19_0 end-pos20_0)
                  (let-values (((bstr_50) bstr21_1))
                    (let-values (((out_5) (if out18_0 out15_0 (1/current-output-port))))
                      (let-values (((start-pos_19) (if start-pos19_0 start-pos16_0 0)))
                        (let-values (((end-pos_10)
                                      (if end-pos20_0 end-pos17_0 (if (bytes? bstr_50) (bytes-length bstr_50) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_50)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes-avail "bytes?" bstr_50)))
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
                              (check-range 'write-bytes-avail start-pos_19 end-pos_10 (bytes-length bstr_50) bstr_50)
                              (let-values (((temp54_0) 'write-bytes-avail)
                                           ((out55_0) out_5)
                                           ((bstr56_0) bstr_50)
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
     ((bstr_51 out_6 start-pos_20 end-pos17_1) (write-bytes-avail22_0 bstr_51 out_6 start-pos_20 end-pos17_1 #t #t #t))
     ((bstr_52 out_7 start-pos16_1) (write-bytes-avail22_0 bstr_52 out_7 start-pos16_1 #f #t #t #f))
     ((bstr_53 out15_1) (write-bytes-avail22_0 bstr_53 out15_1 #f #f #t #f #f)))))
 (define-values
  (1/write-bytes-avail*)
  (let-values (((write-bytes-avail*31_0)
                (lambda (bstr30_0 out24_0 start-pos25_0 end-pos26_0 out27_0 start-pos28_0 end-pos29_0)
                  (let-values (((bstr_54) bstr30_0))
                    (let-values (((out_8) (if out27_0 out24_0 (1/current-output-port))))
                      (let-values (((start-pos_21) (if start-pos28_0 start-pos25_0 0)))
                        (let-values (((end-pos_11)
                                      (if end-pos29_0 end-pos26_0 (if (bytes? bstr_54) (bytes-length bstr_54) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_54)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes-avail* "bytes?" bstr_54)))
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
                              (check-range 'write-bytes-avail* start-pos_21 end-pos_11 (bytes-length bstr_54) bstr_54)
                              (let-values (((temp59_0) 'write-bytes-avail*)
                                           ((out60_0) out_8)
                                           ((bstr61_0) bstr_54)
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
     ((bstr_55) (write-bytes-avail*31_0 bstr_55 #f #f #f #f #f #f))
     ((bstr_56 out_9 start-pos_22 end-pos26_1) (write-bytes-avail*31_0 bstr_56 out_9 start-pos_22 end-pos26_1 #t #t #t))
     ((bstr_57 out_10 start-pos25_1) (write-bytes-avail*31_0 bstr_57 out_10 start-pos25_1 #f #t #t #f))
     ((bstr_58 out24_1) (write-bytes-avail*31_0 bstr_58 out24_1 #f #f #t #f #f)))))
 (define-values
  (1/write-bytes-avail/enable-break)
  (let-values (((write-bytes-avail/enable-break40_0)
                (lambda (bstr39_0 out33_0 start-pos34_0 end-pos35_0 out36_0 start-pos37_0 end-pos38_0)
                  (let-values (((bstr_59) bstr39_0))
                    (let-values (((out_11) (if out36_0 out33_0 (1/current-output-port))))
                      (let-values (((start-pos_23) (if start-pos37_0 start-pos34_0 0)))
                        (let-values (((end-pos_12)
                                      (if end-pos38_0 end-pos35_0 (if (bytes? bstr_59) (bytes-length bstr_59) #f))))
                          (let-values ()
                            (begin
                              (if (bytes? bstr_59)
                                (void)
                                (let-values () (raise-argument-error 'write-bytes-avail/enable-break "bytes?" bstr_59)))
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
                               (bytes-length bstr_59)
                               bstr_59)
                              (let-values (((temp65_0) 'write-bytes-avail/enable-break)
                                           ((out66_0) out_11)
                                           ((bstr67_0) bstr_59)
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
     ((bstr_60) (write-bytes-avail/enable-break40_0 bstr_60 #f #f #f #f #f #f))
     ((bstr_61 out_12 start-pos_24 end-pos35_1)
      (write-bytes-avail/enable-break40_0 bstr_61 out_12 start-pos_24 end-pos35_1 #t #t #t))
     ((bstr_62 out_13 start-pos34_1) (write-bytes-avail/enable-break40_0 bstr_62 out_13 start-pos34_1 #f #t #t #f))
     ((bstr_63 out33_1) (write-bytes-avail/enable-break40_0 bstr_63 out33_1 #f #f #t #f #f)))))
 (define-values
  (utf-8-encode!)
  (lambda (in-str_0 in-start_1 in-end_1 out-bstr_0 out-start_1 out-end_1)
    ((letrec-values (((loop_15)
                      (lambda (i_3 j_1)
                        (if (= i_3 in-end_1)
                          (let-values () (values (- in-end_1 in-start_1) (- j_1 out-start_1) 'complete))
                          (let-values ()
                            (let-values (((b_7) (char->integer (string-ref in-str_0 i_3))))
                              (if (byte? b_7)
                                (let-values ()
                                  (if (if out-end_1 (= j_1 out-end_1) #f)
                                    (let-values () (values (- i_3 in-start_1) (- j_1 out-start_1) 'aborts))
                                    (let-values ()
                                      (begin
                                        (if out-bstr_0 (let-values () (bytes-set! out-bstr_0 j_1 b_7)) (void))
                                        (loop_15 (add1 i_3) (add1 j_1))))))
                                (if (< b_7 2047)
                                  (let-values ()
                                    (if (if out-end_1 (>= (add1 j_1) out-end_1) #f)
                                      (let-values () (values (- i_3 in-start_1) (- j_1 out-start_1) 'aborts))
                                      (let-values ()
                                        (begin
                                          (if out-bstr_0
                                            (let-values ()
                                              (begin
                                                (bytes-set! out-bstr_0 j_1 (bitwise-ior 192 (arithmetic-shift b_7 -6)))
                                                (bytes-set!
                                                 out-bstr_0
                                                 (add1 j_1)
                                                 (bitwise-ior 128 (bitwise-and b_7 63)))))
                                            (void))
                                          (loop_15 (add1 i_3) (+ j_1 2))))))
                                  (if (< b_7 65535)
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
                                                   (bitwise-ior 224 (arithmetic-shift b_7 -12)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 1)
                                                   (bitwise-ior 128 (bitwise-and (arithmetic-shift b_7 -6) 63)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 2)
                                                   (bitwise-ior 128 (bitwise-and b_7 63)))))
                                              (void))
                                            (loop_15 (add1 i_3) (+ j_1 3))))))
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
                                                   (bitwise-ior 240 (arithmetic-shift b_7 -18)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 1)
                                                   (bitwise-ior 128 (bitwise-and (arithmetic-shift b_7 -12) 63)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 2)
                                                   (bitwise-ior 128 (bitwise-and (arithmetic-shift b_7 -6) 63)))
                                                  (bytes-set!
                                                   out-bstr_0
                                                   (+ j_1 3)
                                                   (bitwise-ior 128 (bitwise-and b_7 63)))))
                                              (void))
                                            (loop_15 (add1 i_3) (+ j_1 4)))))))))))))))
       loop_15)
     in-start_1
     out-start_1)))
 (define-values
  (1/bytes->string/latin-1)
  (let-values (((bytes->string/latin-18_0)
                (lambda (bstr7_0 err-char1_0 start2_0 end3_1 err-char4_0 start5_0 end6_0)
                  (let-values (((bstr_0) bstr7_0))
                    (let-values (((err-char_0) (if err-char4_0 err-char1_0 #f)))
                      (let-values (((start_12) (if start5_0 start2_0 0)))
                        (let-values (((end_12) (if end6_0 end3_1 (if (bytes? bstr_0) (bytes-length bstr_0) #f))))
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
                                              (if ((lambda (v_25)
                                                     (let-values (((or-part_13) (not v_25)))
                                                       (if or-part_13 or-part_13 (char? v_25))))
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
                                                (if (exact-nonnegative-integer? start_12)
                                                  (void)
                                                  (let-values ()
                                                    (raise-argument-error
                                                     'bytes->string/latin-1
                                                     "exact-nonnegative-integer?"
                                                     start_12)))
                                                (values))))
                                  (let-values ((()
                                                (begin
                                                  (if (exact-nonnegative-integer? end_12)
                                                    (void)
                                                    (let-values ()
                                                      (raise-argument-error
                                                       'bytes->string/latin-1
                                                       "exact-nonnegative-integer?"
                                                       end_12)))
                                                  (values))))
                                    (let-values ((()
                                                  (begin
                                                    (check-range
                                                     'bytes->string/latin-1
                                                     start_12
                                                     end_12
                                                     (bytes-length bstr_0)
                                                     bstr_0)
                                                    (values))))
                                      (let-values (((len_3) (- end_12 start_12)))
                                        (let-values (((s_2) (make-string len_3)))
                                          (begin
                                            ((letrec-values (((loop_16)
                                                              (lambda (i_4)
                                                                (if (zero? i_4)
                                                                  (void)
                                                                  (let-values ()
                                                                    (let-values (((i_5) (sub1 i_4)))
                                                                      (begin
                                                                        (string-set!
                                                                         s_2
                                                                         i_5
                                                                         (integer->char
                                                                          (bytes-ref bstr_0 (+ i_5 start_12))))
                                                                        (loop_16 i_5))))))))
                                               loop_16)
                                             len_3)
                                            s_2))))))))))))))))
    (case-lambda
     ((bstr_64) (bytes->string/latin-18_0 bstr_64 #f #f #f #f #f #f))
     ((bstr_65 err-char_1 start_13 end3_2) (bytes->string/latin-18_0 bstr_65 err-char_1 start_13 end3_2 #t #t #t))
     ((bstr_66 err-char_2 start2_1) (bytes->string/latin-18_0 bstr_66 err-char_2 start2_1 #f #t #t #f))
     ((bstr_67 err-char1_1) (bytes->string/latin-18_0 bstr_67 err-char1_1 #f #f #t #f #f)))))
 (define-values
  (do-bytes->string/utf-817.1)
  (lambda (just-length?10_0 just-length?11_0 who12_0 bstr13_0 err-char14_0 start15_0 end16_0)
    (let-values (((who_9) who12_0))
      (let-values (((bstr_47) bstr13_0))
        (let-values (((err-char_3) err-char14_0))
          (let-values (((start_14) start15_0))
            (let-values (((end_13) end16_0))
              (let-values (((just-length?_0) (if just-length?11_0 just-length?10_0 #f)))
                (let-values ()
                  (let-values ((()
                                (begin
                                  (if (bytes? bstr_47)
                                    (void)
                                    (let-values () (raise-argument-error who_9 "bytes?" bstr_47)))
                                  (values))))
                    (let-values ((()
                                  (begin
                                    (if ((lambda (v_45)
                                           (let-values (((or-part_14) (not v_45)))
                                             (if or-part_14 or-part_14 (char? v_45))))
                                         err-char_3)
                                      (void)
                                      (let-values () (raise-argument-error who_9 "(or/c char? #f)" err-char_3)))
                                    (values))))
                      (let-values ((()
                                    (begin
                                      (if (exact-nonnegative-integer? start_14)
                                        (void)
                                        (let-values ()
                                          (raise-argument-error who_9 "exact-nonnegative-integer?" start_14)))
                                      (values))))
                        (let-values ((()
                                      (begin
                                        (if (exact-nonnegative-integer? end_13)
                                          (void)
                                          (let-values ()
                                            (raise-argument-error who_9 "exact-nonnegative-integer?" end_13)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (check-range who_9 start_14 end_13 (bytes-length bstr_47) bstr_47)
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
                                             bstr_47
                                             start_14
                                             end_13
                                             temp96_1
                                             temp97_1
                                             temp98_1))))
                              (if just-length?_0
                                (let-values () got-chars_6)
                                (let-values ()
                                  (let-values (((str_16) (make-string got-chars_6)))
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
                                         bstr_47
                                         start_14
                                         end_13
                                         str_16
                                         temp105_0
                                         temp106_1))
                                      str_16)))))))))))))))))))
 (define-values
  (1/bytes->string/utf-8)
  (let-values (((bytes->string/utf-827_0)
                (lambda (bstr26_0 err-char20_0 start21_0 end22_0 err-char23_0 start24_0 end25_0)
                  (let-values (((bstr_55) bstr26_0))
                    (let-values (((err-char_4) (if err-char23_0 err-char20_0 #f)))
                      (let-values (((start_15) (if start24_0 start21_0 0)))
                        (let-values (((end_14) (if end25_0 end22_0 (if (bytes? bstr_55) (bytes-length bstr_55) #f))))
                          (let-values ()
                            (let-values (((temp109_1) 'bytes->string/utf-8)
                                         ((bstr110_0) bstr_55)
                                         ((err-char111_0) err-char_4)
                                         ((start112_0) start_15)
                                         ((end113_0) end_14))
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
     ((bstr_68 err-char_5 start_16 end22_1) (bytes->string/utf-827_0 bstr_68 err-char_5 start_16 end22_1 #t #t #t))
     ((bstr_69 err-char_6 start21_1) (bytes->string/utf-827_0 bstr_69 err-char_6 start21_1 #f #t #t #f))
     ((bstr_70 err-char20_1) (bytes->string/utf-827_0 bstr_70 err-char20_1 #f #f #t #f #f)))))
 (define-values
  (1/bytes-utf-8-length)
  (let-values (((bytes-utf-8-length36_0)
                (lambda (bstr35_0 err-char29_0 start30_0 end31_0 err-char32_0 start33_0 end34_0)
                  (let-values (((bstr_19) bstr35_0))
                    (let-values (((err-char_7) (if err-char32_0 err-char29_0 #f)))
                      (let-values (((start_17) (if start33_0 start30_0 0)))
                        (let-values (((end_15) (if end34_0 end31_0 (if (bytes? bstr_19) (bytes-length bstr_19) #f))))
                          (let-values ()
                            (let-values (((temp114_0) 'bytes-utf-8-length)
                                         ((bstr115_0) bstr_19)
                                         ((err-char116_0) err-char_7)
                                         ((start117_0) start_17)
                                         ((end118_0) end_15)
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
     ((bstr_71) (bytes-utf-8-length36_0 bstr_71 #f #f #f #f #f #f))
     ((bstr_72 err-char_8 start_18 end31_1) (bytes-utf-8-length36_0 bstr_72 err-char_8 start_18 end31_1 #t #t #t))
     ((bstr_73 err-char_9 start30_1) (bytes-utf-8-length36_0 bstr_73 err-char_9 start30_1 #f #t #t #f))
     ((bstr_74 err-char29_1) (bytes-utf-8-length36_0 bstr_74 err-char29_1 #f #f #t #f #f)))))
 (define-values
  (1/bytes->string/locale)
  (let-values (((bytes->string/locale45_0)
                (lambda (bstr44_0 err-char38_0 start39_0 end40_0 err-char41_0 start42_0 end43_0)
                  (let-values (((bstr_75) bstr44_0))
                    (let-values (((err-char_10) (if err-char41_0 err-char38_0 #f)))
                      (let-values (((start_19) (if start42_0 start39_0 0)))
                        (let-values (((end_16) (if end43_0 end40_0 (if (bytes? bstr_75) (bytes-length bstr_75) #f))))
                          (let-values ()
                            (let-values (((temp120_0) 'bytes->string/locale)
                                         ((bstr121_0) bstr_75)
                                         ((err-char122_0) err-char_10)
                                         ((start123_0) start_19)
                                         ((end124_0) end_16))
                              (do-bytes->string/utf-817.1
                               #f
                               #f
                               temp120_0
                               bstr121_0
                               err-char122_0
                               start123_0
                               end124_0))))))))))
    (case-lambda
     ((bstr_76) (bytes->string/locale45_0 bstr_76 #f #f #f #f #f #f))
     ((bstr_77 err-char_11 start_20 end40_1) (bytes->string/locale45_0 bstr_77 err-char_11 start_20 end40_1 #t #t #t))
     ((bstr_78 err-char_12 start39_1) (bytes->string/locale45_0 bstr_78 err-char_12 start39_1 #f #t #t #f))
     ((bstr_79 err-char38_1) (bytes->string/locale45_0 bstr_79 err-char38_1 #f #f #t #f #f)))))
 (define-values
  (1/string->bytes/latin-1)
  (let-values (((string->bytes/latin-154_0)
                (lambda (str53_0 err-byte47_0 start48_0 end49_0 err-byte50_0 start51_0 end52_0)
                  (let-values (((str_17) str53_0))
                    (let-values (((err-byte_0) (if err-byte50_0 err-byte47_0 #f)))
                      (let-values (((start_21) (if start51_0 start48_0 0)))
                        (let-values (((end_17) (if end52_0 end49_0 (if (string? str_17) (string-length str_17) #f))))
                          (let-values ()
                            (let-values ((()
                                          (begin
                                            (if (string? str_17)
                                              (void)
                                              (let-values ()
                                                (raise-argument-error 'string->bytes/latin-1 "string?" str_17)))
                                            (values))))
                              (let-values ((()
                                            (begin
                                              (if ((lambda (v_46)
                                                     (let-values (((or-part_15) (not v_46)))
                                                       (if or-part_15 or-part_15 (byte? v_46))))
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
                                                (if (exact-nonnegative-integer? start_21)
                                                  (void)
                                                  (let-values ()
                                                    (raise-argument-error
                                                     'string->bytes/latin-1
                                                     "exact-nonnegative-integer?"
                                                     start_21)))
                                                (values))))
                                  (let-values ((()
                                                (begin
                                                  (if (exact-nonnegative-integer? end_17)
                                                    (void)
                                                    (let-values ()
                                                      (raise-argument-error
                                                       'string->bytes/latin-1
                                                       "exact-nonnegative-integer?"
                                                       end_17)))
                                                  (values))))
                                    (let-values ((()
                                                  (begin
                                                    (check-range
                                                     'string->bytes/latin-1
                                                     start_21
                                                     end_17
                                                     (string-length str_17)
                                                     str_17)
                                                    (values))))
                                      (let-values (((len_4) (- end_17 start_21)))
                                        (let-values (((bstr_80) (make-bytes len_4)))
                                          (begin
                                            ((letrec-values (((loop_17)
                                                              (lambda (i_6)
                                                                (if (zero? i_6)
                                                                  (void)
                                                                  (let-values ()
                                                                    (let-values (((i_7) (sub1 i_6)))
                                                                      (let-values (((b_4)
                                                                                    (char->integer
                                                                                     (string-ref
                                                                                      str_17
                                                                                      (+ i_7 start_21)))))
                                                                        (begin
                                                                          (if (byte? b_4)
                                                                            (let-values () (bytes-set! bstr_80 i_7 b_4))
                                                                            (if err-byte_0
                                                                              (let-values ()
                                                                                (bytes-set! bstr_80 i_7 err-byte_0))
                                                                              (let-values ()
                                                                                (raise-arguments-error
                                                                                 'string->bytes/latin-1
                                                                                 "string cannot be encoded in Latin-1"
                                                                                 "string"
                                                                                 str_17))))
                                                                          (loop_17 i_7)))))))))
                                               loop_17)
                                             len_4)
                                            bstr_80))))))))))))))))
    (case-lambda
     ((str_18) (string->bytes/latin-154_0 str_18 #f #f #f #f #f #f))
     ((str_2 err-byte_1 start_22 end49_1) (string->bytes/latin-154_0 str_2 err-byte_1 start_22 end49_1 #t #t #t))
     ((str_19 err-byte_2 start48_1) (string->bytes/latin-154_0 str_19 err-byte_2 start48_1 #f #t #t #f))
     ((str_20 err-byte47_1) (string->bytes/latin-154_0 str_20 err-byte47_1 #f #f #t #f #f)))))
 (define-values
  (do-string->bytes/utf-863.1)
  (lambda (just-length?56_0 just-length?57_0 who58_0 str59_0 err-byte60_0 start61_0 end62_0)
    (let-values (((who_10) who58_0))
      (let-values (((str_21) str59_0))
        (let-values (((err-byte_3) err-byte60_0))
          (let-values (((start_23) start61_0))
            (let-values (((end_18) end62_0))
              (let-values (((just-length?_1) (if just-length?57_0 just-length?56_0 #f)))
                (let-values ()
                  (let-values ((()
                                (begin
                                  (if (string? str_21)
                                    (void)
                                    (let-values () (raise-argument-error who_10 "string?" str_21)))
                                  (values))))
                    (let-values ((()
                                  (begin
                                    (if ((lambda (v_47)
                                           (let-values (((or-part_16) (not v_47)))
                                             (if or-part_16 or-part_16 (byte? v_47))))
                                         err-byte_3)
                                      (void)
                                      (let-values () (raise-argument-error who_10 "(or/c byte? #f)" err-byte_3)))
                                    (values))))
                      (let-values ((()
                                    (begin
                                      (if (exact-nonnegative-integer? start_23)
                                        (void)
                                        (let-values ()
                                          (raise-argument-error who_10 "exact-nonnegative-integer?" start_23)))
                                      (values))))
                        (let-values ((()
                                      (begin
                                        (if (exact-nonnegative-integer? end_18)
                                          (void)
                                          (let-values ()
                                            (raise-argument-error who_10 "exact-nonnegative-integer?" end_18)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (check-range who_10 start_23 end_18 (string-length str_21) str_21)
                                          (values))))
                            (let-values (((used-chars_0 got-bytes_0 status_0)
                                          (utf-8-encode! str_21 start_23 end_18 #f 0 #f)))
                              (if just-length?_1
                                (let-values () got-bytes_0)
                                (let-values ()
                                  (let-values (((bstr_81) (make-bytes got-bytes_0)))
                                    (begin
                                      (utf-8-encode! str_21 start_23 end_18 bstr_81 0 #f)
                                      bstr_81)))))))))))))))))))
 (define-values
  (1/string->bytes/utf-8)
  (let-values (((string->bytes/utf-873_0)
                (lambda (str72_0 err-byte66_0 start67_0 end68_0 err-byte69_0 start70_0 end71_0)
                  (let-values (((str_22) str72_0))
                    (let-values (((err-byte_4) (if err-byte69_0 err-byte66_0 #f)))
                      (let-values (((start_24) (if start70_0 start67_0 0)))
                        (let-values (((end_19) (if end71_0 end68_0 (if (string? str_22) (string-length str_22) #f))))
                          (let-values ()
                            (let-values (((temp125_0) 'string->bytes/utf-8)
                                         ((str126_0) str_22)
                                         ((err-byte127_0) err-byte_4)
                                         ((start128_0) start_24)
                                         ((end129_0) end_19))
                              (do-string->bytes/utf-863.1
                               #f
                               #f
                               temp125_0
                               str126_0
                               err-byte127_0
                               start128_0
                               end129_0))))))))))
    (case-lambda
     ((str_23) (string->bytes/utf-873_0 str_23 #f #f #f #f #f #f))
     ((str_24 err-byte_5 start_25 end68_1) (string->bytes/utf-873_0 str_24 err-byte_5 start_25 end68_1 #t #t #t))
     ((str_25 err-byte_6 start67_1) (string->bytes/utf-873_0 str_25 err-byte_6 start67_1 #f #t #t #f))
     ((str_26 err-byte66_1) (string->bytes/utf-873_0 str_26 err-byte66_1 #f #f #t #f #f)))))
 (define-values
  (1/string-utf-8-length)
  (let-values (((string-utf-8-length82_0)
                (lambda (str81_0 err-byte75_0 start76_0 end77_0 err-byte78_0 start79_0 end80_0)
                  (let-values (((str_9) str81_0))
                    (let-values (((err-byte_7) (if err-byte78_0 err-byte75_0 #f)))
                      (let-values (((start_26) (if start79_0 start76_0 0)))
                        (let-values (((end_20) (if end80_0 end77_0 (if (string? str_9) (string-length str_9) #f))))
                          (let-values ()
                            (let-values (((temp130_1) 'string-utf-8-length)
                                         ((str131_0) str_9)
                                         ((err-byte132_0) err-byte_7)
                                         ((start133_0) start_26)
                                         ((end134_0) end_20)
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
     ((str_27) (string-utf-8-length82_0 str_27 #f #f #f #f #f #f))
     ((str_28 err-byte_8 start_27 end77_1) (string-utf-8-length82_0 str_28 err-byte_8 start_27 end77_1 #t #t #t))
     ((str_29 err-byte_9 start76_1) (string-utf-8-length82_0 str_29 err-byte_9 start76_1 #f #t #t #f))
     ((str_30 err-byte75_1) (string-utf-8-length82_0 str_30 err-byte75_1 #f #f #t #f #f)))))
 (define-values
  (1/string->bytes/locale)
  (let-values (((string->bytes/locale91_0)
                (lambda (str90_0 err-byte84_0 start85_0 end86_0 err-byte87_0 start88_0 end89_0)
                  (let-values (((str_31) str90_0))
                    (let-values (((err-byte_10) (if err-byte87_0 err-byte84_0 #f)))
                      (let-values (((start_28) (if start88_0 start85_0 0)))
                        (let-values (((end_21) (if end89_0 end86_0 (if (string? str_31) (string-length str_31) #f))))
                          (let-values ()
                            (let-values (((temp136_1) 'string->bytes/locale)
                                         ((str137_0) str_31)
                                         ((err-byte138_0) err-byte_10)
                                         ((start139_0) start_28)
                                         ((end140_0) end_21))
                              (do-string->bytes/utf-863.1
                               #f
                               #f
                               temp136_1
                               str137_0
                               err-byte138_0
                               start139_0
                               end140_0))))))))))
    (case-lambda
     ((str_32) (string->bytes/locale91_0 str_32 #f #f #f #f #f #f))
     ((str_33 err-byte_11 start_29 end86_1) (string->bytes/locale91_0 str_33 err-byte_11 start_29 end86_1 #t #t #t))
     ((str_34 err-byte_12 start85_1) (string->bytes/locale91_0 str_34 err-byte_12 start85_1 #f #t #t #f))
     ((str_10 err-byte84_1) (string->bytes/locale91_0 str_10 err-byte84_1 #f #f #t #f #f)))))
 (define-values
  (1/write-string)
  (let-values (((write-string8_0)
                (lambda (str7_0 out1_0 start2_0 end3_1 out4_0 start5_0 end6_0)
                  (let-values (((str_35) str7_0))
                    (let-values (((out_14) (if out4_0 out1_0 (current-output-port))))
                      (let-values (((start_12) (if start5_0 start2_0 0)))
                        (let-values (((end_12) (if end6_0 end3_1 (if (string? str_35) (string-length str_35) #f))))
                          (let-values ()
                            (begin
                              (if (string? str_35)
                                (void)
                                (let-values () (raise-argument-error 'write-string "string?" str_35)))
                              (if (1/output-port? out_14)
                                (void)
                                (let-values () (raise-argument-error 'write-string "output-port?" out_14)))
                              (if (exact-nonnegative-integer? start_12)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-string "exact-nonnegative-integer?" start_12)))
                              (if (exact-nonnegative-integer? end_12)
                                (void)
                                (let-values ()
                                  (raise-argument-error 'write-string "exact-nonnegative-integer?" end_12)))
                              (check-range 'write-string start_12 end_12 (string-length str_35) str_35)
                              ((letrec-values (((loop_8)
                                                (lambda (i_8)
                                                  (if (= i_8 end_12)
                                                    (let-values () (- i_8 start_12))
                                                    (let-values ()
                                                      (let-values (((next-i_2) (min end_12 (+ i_8 4096))))
                                                        (let-values (((bstr_82)
                                                                      (1/string->bytes/utf-8 str_35 0 i_8 next-i_2)))
                                                          (begin
                                                            (do-write-bytes
                                                             'write-string
                                                             out_14
                                                             bstr_82
                                                             0
                                                             (bytes-length bstr_82))
                                                            (loop_8 next-i_2)))))))))
                                 loop_8)
                               start_12))))))))))
    (case-lambda
     ((str_36) (write-string8_0 str_36 #f #f #f #f #f #f))
     ((str_0 out_15 start_30 end3_3) (write-string8_0 str_0 out_15 start_30 end3_3 #t #t #t))
     ((str_37 out_16 start2_2) (write-string8_0 str_37 out_16 start2_2 #f #t #t #f))
     ((str_38 out1_1) (write-string8_0 str_38 out1_1 #f #f #t #f #f)))))
 (define-values (ok-mode?) (lambda (v_48) (memq v_48 '(linefeed return return-linefeed any any-one))))
 (define-values (ok-mode-str) "(or/c 'linefeed 'return 'return-linefeed 'any 'any-one)")
 (define-values
  (1/read-line)
  (let-values (((read-line5_0)
                (lambda (in1_2 mode2_0 in3_0 mode4_0)
                  (let-values (((in_42) (if in3_0 in1_2 (1/current-input-port))))
                    (let-values (((mode_1) (if mode4_0 mode2_0 'linefeed)))
                      (let-values ()
                        (let-values ((()
                                      (begin
                                        (if (1/input-port? in_42)
                                          (void)
                                          (let-values () (raise-argument-error 'read-line "input-port?" in_42)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (if (ok-mode? mode_1)
                                            (void)
                                            (let-values () (raise-argument-error 'read-line ok-mode-str mode_1)))
                                          (values))))
                            (let-values (((cr?_0) (memq mode_1 '(return any any-one))))
                              (let-values (((lf?_0) (memq mode_1 '(linefeed any any-one))))
                                (let-values (((crlf?_0) (memq mode_1 '(return-linefeed any))))
                                  ((letrec-values (((loop_3)
                                                    (lambda (str_39 pos_1)
                                                      (let-values (((ch_0) (1/read-char in_42)))
                                                        (let-values (((keep-char_0)
                                                                      (lambda ()
                                                                        (if (< pos_1 (string-length str_39))
                                                                          (begin
                                                                            (string-set! str_39 pos_1 ch_0)
                                                                            (loop_3 str_39 (add1 pos_1)))
                                                                          (let-values (((new-str_0)
                                                                                        (make-string
                                                                                         (* (string-length str_39) 2))))
                                                                            (begin
                                                                              (string-copy! new-str_0 0 str_39 0)
                                                                              (string-set! new-str_0 pos_1 ch_0)
                                                                              (loop_3 new-str_0 (add1 pos_1))))))))
                                                          (if (eof-object? ch_0)
                                                            (let-values ()
                                                              (if (zero? pos_1) eof (substring str_39 0 pos_1)))
                                                            (if (if (let-values (((or-part_17) cr?_0))
                                                                      (if or-part_17 or-part_17 crlf?_0))
                                                                  (eqv? ch_0 (values '#\return))
                                                                  #f)
                                                              (let-values ()
                                                                (if (if crlf?_0
                                                                      (char=? (1/peek-char in_42) (values '#\newline))
                                                                      #f)
                                                                  (let-values ()
                                                                    (begin
                                                                      (1/read-char in_42)
                                                                      (substring str_39 0 pos_1)))
                                                                  (if cr?_0
                                                                    (let-values () (substring str_39 0 pos_1))
                                                                    (let-values () (keep-char_0)))))
                                                              (if (if lf?_0 (eqv? ch_0 (values '#\newline)) #f)
                                                                (let-values () (substring str_39 0 pos_1))
                                                                (let-values () (keep-char_0))))))))))
                                     loop_3)
                                   (make-string 32)
                                   0))))))))))))
    (case-lambda
     (() (read-line5_0 #f #f #f #f))
     ((in_43 mode2_1) (read-line5_0 in_43 mode2_1 #t #t))
     ((in1_3) (read-line5_0 in1_3 #f #t #f)))))
 (define-values
  (1/read-bytes-line)
  (let-values (((read-bytes-line11_0)
                (lambda (in7_0 mode8_0 in9_0 mode10_0)
                  (let-values (((in_44) (if in9_0 in7_0 (1/current-input-port))))
                    (let-values (((mode_2) (if mode10_0 mode8_0 'linefeed)))
                      (let-values ()
                        (let-values ((()
                                      (begin
                                        (if (1/input-port? in_44)
                                          (void)
                                          (let-values () (raise-argument-error 'read-bytes-line "input-port?" in_44)))
                                        (values))))
                          (let-values ((()
                                        (begin
                                          (if (ok-mode? mode_2)
                                            (void)
                                            (let-values () (raise-argument-error 'read-bytes-line ok-mode-str mode_2)))
                                          (values))))
                            (let-values (((cr?_1) (memq mode_2 '(return any any-one))))
                              (let-values (((lf?_1) (memq mode_2 '(linefeed any any-one))))
                                (let-values (((crlf?_1) (memq mode_2 '(return-linefeed any))))
                                  ((letrec-values (((loop_18)
                                                    (lambda (str_40 pos_2)
                                                      (let-values (((ch_1) (1/read-byte in_44)))
                                                        (let-values (((keep-char_1)
                                                                      (lambda ()
                                                                        (if (< pos_2 (bytes-length str_40))
                                                                          (begin
                                                                            (bytes-set! str_40 pos_2 ch_1)
                                                                            (loop_18 str_40 (add1 pos_2)))
                                                                          (let-values (((new-str_1)
                                                                                        (make-bytes
                                                                                         (* (bytes-length str_40) 2))))
                                                                            (begin
                                                                              (bytes-copy! new-str_1 0 str_40 0)
                                                                              (bytes-set! new-str_1 pos_2 ch_1)
                                                                              (loop_18 new-str_1 (add1 pos_2))))))))
                                                          (if (eof-object? ch_1)
                                                            (let-values ()
                                                              (if (zero? pos_2) eof (subbytes str_40 0 pos_2)))
                                                            (if (if (let-values (((or-part_18) cr?_1))
                                                                      (if or-part_18 or-part_18 crlf?_1))
                                                                  (eqv? ch_1 (char->integer '#\return))
                                                                  #f)
                                                              (let-values ()
                                                                (if (if crlf?_1
                                                                      (char=?
                                                                       (1/peek-byte in_44)
                                                                       (char->integer '#\newline))
                                                                      #f)
                                                                  (let-values ()
                                                                    (begin
                                                                      (1/read-byte in_44)
                                                                      (subbytes str_40 0 pos_2)))
                                                                  (if cr?_1
                                                                    (let-values () (subbytes str_40 0 pos_2))
                                                                    (let-values () (keep-char_1)))))
                                                              (if (if lf?_1 (eqv? ch_1 (char->integer '#\newline)) #f)
                                                                (let-values () (subbytes str_40 0 pos_2))
                                                                (let-values () (keep-char_1))))))))))
                                     loop_18)
                                   (make-bytes 32)
                                   0))))))))))))
    (case-lambda
     (() (read-bytes-line11_0 #f #f #f #f))
     ((in_45 mode8_1) (read-bytes-line11_0 in_45 mode8_1 #t #t))
     ((in7_1) (read-bytes-line11_0 in7_1 #f #t #f)))))
 (define-values
  (1/prop:custom-write 1/custom-write? custom-write-ref)
  (make-struct-type-property
   'custom-write
   (lambda (v_41 info_0)
     (begin
       (if (if (procedure? v_41) (procedure-arity-includes? v_41 3) #f)
         (void)
         (let-values () (raise-argument-error 'guard-for-prop:custom-write "(procedure-arity-includes?/c 3)" v_41)))
       v_41))))
 (define-values
  (struct:path path1.1 1/path? path-bytes path-convention)
  (let-values (((struct:_1 make-_1 ?_1 -ref_1 -set!_1)
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
                       prop:equal+hash
                       (list
                        (lambda (p1_0 p2_0 eql?_0) (eql?_0 (path-bytes p1_0) (path-bytes p2_0)))
                        (lambda (p_5 hc_0) (hc_0 (path-bytes p_5)))
                        (lambda (p_6 hc_1) (hc_1 (path-bytes p_6)))))
                      (cons
                       1/prop:custom-write
                       (lambda (p_7 port_0 mode_3)
                         (begin
                           (if mode_3 (let-values () (1/write-string "#<path:" port_0)) (void))
                           (1/write-string (1/bytes->string/locale (path-bytes p_7)) port_0)
                           (if mode_3 (let-values () (1/write-string ">" port_0)) (void))))))
                     (current-inspector)
                     #f
                     '(0 1)
                     #f
                     'path)))))
    (values
     struct:_1
     make-_1
     ?_1
     (make-struct-field-accessor -ref_1 0 'bytes)
     (make-struct-field-accessor -ref_1 1 'convention))))
 (define-values
  (is-path?)
  (let-values (((path?_0)
                (lambda (p_8) (if (1/path? p_8) (eq? (path-convention p_8) (system-path-convention-type)) #f))))
    path?_0))
 (define-values (1/path-for-some-system?) (lambda (p_9) (1/path? p_9)))
 (define-values
  (path-string?)
  (lambda (p_10)
    (let-values (((or-part_6) (is-path? p_10)))
      (if or-part_6
        or-part_6
        (if (string? p_10)
          (if (positive? (string-length p_10))
            (let-values (((vec_0 len_5)
                          (let-values (((vec_1) p_10))
                            (begin (check-string vec_1) (values vec_1 (unsafe-string-length vec_1))))))
              (begin
                #f
                ((letrec-values (((for-loop_0)
                                  (lambda (result_0 pos_3)
                                    (if (unsafe-fx< pos_3 len_5)
                                      (let-values (((c_0) (string-ref vec_0 pos_3)))
                                        (let-values (((result_1)
                                                      (let-values ()
                                                        (let-values (((result_2)
                                                                      (let-values ()
                                                                        (let-values () (not (char=? c_0 '#\nul))))))
                                                          (values result_2)))))
                                          (if (if (not ((lambda x_3 (not result_1)) c_0)) (not #f) #f)
                                            (for-loop_0 result_1 (unsafe-fx+ 1 pos_3))
                                            result_1)))
                                      result_0))))
                   for-loop_0)
                 #t
                 0)))
            #f)
          #f)))))
 (define-values
  (string->path$1)
  (lambda (s_3) (path1.1 (1/string->bytes/locale s_3 (char->integer '#\?)) (system-path-convention-type))))
 (define-values (->path) (lambda (p_11) (if (string? p_11) (string->path$1 p_11) p_11)))
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
  (lambda (p_12)
    (begin
      (if (1/output-port? p_12) (void) (let-values () (raise-argument-error 'close-output-port "output-port?" p_12)))
      (if (output-port-closed? p_12)
        (void)
        (let-values () (begin (set-output-port-closed?! p_12 #t) ((output-port-close p_12))))))))
 (define-values
  (1/open-input-file)
  (let-values (((open-input-file6_0)
                (lambda (path5_1 mode11_0 mode22_0 mode13_0 mode24_0)
                  (let-values (((path_1) path5_1))
                    (let-values ()
                      (let-values ()
                        (let-values ()
                          (begin
                            (if (path-string? path_1)
                              (void)
                              (let-values () (raise-argument-error 'open-input-file "path-string?" path_1)))
                            (open-input-host
                             (let-values (((temp37_0) (path->string (path->complete-path path_1))))
                               (open-input-file6.1 #f #f #f #f temp37_0))
                             path_1)))))))))
    (case-lambda
     ((path_2) (open-input-file6_0 path_2 #f #f #f #f))
     ((path_3 mode1_1 mode22_1) (open-input-file6_0 path_3 mode1_1 mode22_1 #t #t))
     ((path_4 mode11_1) (open-input-file6_0 path_4 mode11_1 #f #t #f)))))
 (define-values
  (struct:input-bytes-data input-bytes-data1.1 input-bytes-data?)
  (let-values (((struct:_1 make-_1 ?_1 -ref_1 -set!_1)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'input-bytes-data
                     #f
                     0
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '()
                     #f
                     'input-bytes-data)))))
    (values struct:_1 make-_1 ?_1)))
 (define-values
  (1/open-input-bytes)
  (let-values (((open-input-bytes5_0)
                (lambda (bstr4_0 name2_2 name3_0)
                  (let-values (((bstr_64) bstr4_0))
                    (let-values (((name_5) (if name3_0 name2_2 'string)))
                      (let-values ()
                        (let-values ((()
                                      (begin
                                        (if (bytes? bstr_64)
                                          (void)
                                          (let-values () (raise-argument-error 'open-input-bytes "bytes?" bstr_64)))
                                        (values))))
                          (let-values (((i_2) 0))
                            (let-values (((len_6) (bytes-length bstr_64)))
                              (let-values (((name22_0) name_5)
                                           ((temp23_0) (input-bytes-data1.1))
                                           ((temp24_0)
                                            (lambda ()
                                              (let-values (((pos_4) i_2))
                                                (if (< pos_4 len_6)
                                                  (begin (set! i_2 (add1 pos_4)) (bytes-ref bstr_64 pos_4))
                                                  eof))))
                                           ((temp25_0)
                                            (lambda (dest-bstr_5 start_31 end_22 copy?_5)
                                              (let-values (((pos_5) i_2))
                                                (if (< pos_5 len_6)
                                                  (let-values ()
                                                    (let-values (((amt_2) (min (- end_22 start_31) (- len_6 pos_5))))
                                                      (begin
                                                        (set! i_2 (+ pos_5 amt_2))
                                                        (bytes-copy! dest-bstr_5 start_31 bstr_64 pos_5 (+ pos_5 amt_2))
                                                        amt_2)))
                                                  (let-values () eof)))))
                                           ((temp26_0)
                                            (lambda ()
                                              (let-values (((pos_6) i_2))
                                                (if (< pos_6 len_6) (bytes-ref bstr_64 pos_6) eof))))
                                           ((temp27_0)
                                            (lambda (dest-bstr_6 start_14 end_13 skip_5 copy?_6)
                                              (let-values (((pos_7) (+ i_2 skip_5)))
                                                (if (< pos_7 len_6)
                                                  (let-values ()
                                                    (let-values (((amt_24) (min (- end_13 start_14) (- len_6 pos_7))))
                                                      (begin
                                                        (bytes-copy!
                                                         dest-bstr_6
                                                         start_14
                                                         bstr_64
                                                         pos_7
                                                         (+ pos_7 amt_24))
                                                        amt_24)))
                                                  (let-values () eof)))))
                                           ((void28_0) void))
                                (make-input-port24.1
                                 void28_0
                                 #f
                                 #f
                                 #f
                                 #f
                                 temp23_0
                                 #t
                                 #f
                                 #f
                                 #f
                                 #f
                                 name22_0
                                 temp26_0
                                 #t
                                 temp27_0
                                 temp24_0
                                 #t
                                 temp25_0)))))))))))
    (case-lambda
     ((bstr_83) (open-input-bytes5_0 bstr_83 #f #f))
     ((bstr_84 name2_3) (open-input-bytes5_0 bstr_84 name2_3 #t)))))
 (define-values
  (struct:output-bytes-data output-bytes-data7.1 output-bytes-data? output-bytes-data-i)
  (let-values (((struct:_3 make-_3 ?_3 -ref_3 -set!_3)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'output-bytes-data
                     #f
                     1
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '(0)
                     #f
                     'output-bytes-data)))))
    (values struct:_3 make-_3 ?_3 (make-struct-field-accessor -ref_3 0 'i))))
 (define-values
  (1/open-output-bytes)
  (let-values (((open-output-bytes10_0)
                (lambda (name8_0 name9_0)
                  (let-values (((name_6) (if name9_0 name8_0 'string)))
                    (let-values ()
                      (let-values (((i_9 o_0) (1/make-pipe)))
                        (let-values (((name30_0) name_6)
                                     ((temp31_0) (output-bytes-data7.1 i_9))
                                     ((o32_0) o_0)
                                     ((temp33_0) (output-port-write-out o_0))
                                     ((temp34_0) (output-port-close o_0))
                                     ((temp35_0) (output-port-get-write-evt o_0))
                                     ((temp36_0) (output-port-get-location o_0))
                                     ((temp37_1) (output-port-count-lines! o_0)))
                          (make-output-port22.1
                           temp34_0
                           temp37_1
                           #t
                           temp31_0
                           #t
                           o32_0
                           temp36_0
                           #t
                           temp35_0
                           #t
                           #f
                           #f
                           name30_0
                           temp33_0
                           #f
                           #f))))))))
    (case-lambda (() (open-output-bytes10_0 #f #f)) ((name8_1) (open-output-bytes10_0 name8_1 #t)))))
 (define-values
  (1/get-output-bytes)
  (let-values (((get-output-bytes19_0)
                (lambda (o18_0 reset?12_0 start-pos13_0 end-pos14_0 reset?15_0 start-pos16_2 end-pos17_2)
                  (let-values (((o_1) o18_0))
                    (let-values ()
                      (let-values (((start-pos_25) (if start-pos16_2 start-pos13_0 0)))
                        (let-values (((end-pos_13) (if end-pos17_2 end-pos14_0 #f)))
                          (let-values ()
                            (let-values ((()
                                          (begin
                                            (if ((lambda (v_49) (if (1/output-port? o_1) (1/string-port? o_1) #f)) o_1)
                                              (void)
                                              (let-values ()
                                                (raise-argument-error
                                                 'get-output-bytes
                                                 "(and/c output-port? string-port?)"
                                                 o_1)))
                                            (values))))
                              (let-values (((i_10) (output-bytes-data-i (output-port-data o_1))))
                                (let-values (((len_7) (1/pipe-content-length i_10)))
                                  (let-values (((amt_25)
                                                (-
                                                 (min
                                                  len_7
                                                  (let-values (((or-part_19) end-pos_13))
                                                    (if or-part_19 or-part_19 len_7)))
                                                 start-pos_25)))
                                    (let-values (((bstr_85) (make-bytes amt_25)))
                                      (begin (1/peek-bytes! bstr_85 start-pos_25 i_10) bstr_85))))))))))))))
    (case-lambda
     ((o_2) (get-output-bytes19_0 o_2 #f #f #f #f #f #f))
     ((o_3 reset?_0 start-pos_26 end-pos14_1) (get-output-bytes19_0 o_3 reset?_0 start-pos_26 end-pos14_1 #t #t #t))
     ((o_4 reset?_1 start-pos13_1) (get-output-bytes19_0 o_4 reset?_1 start-pos13_1 #f #t #t #f))
     ((o_5 reset?12_1) (get-output-bytes19_0 o_5 reset?12_1 #f #f #t #f #f)))))
 (define-values
  (1/string-port?)
  (lambda (p_13)
    (if (1/input-port? p_13)
      (let-values () (input-bytes-data? (input-port-data p_13)))
      (if (1/output-port? p_13)
        (let-values () (output-bytes-data? (output-port-data p_13)))
        (let-values () (raise-argument-error 'string-port? "port?" p_13))))))
 (define-values
  (1/open-input-string)
  (let-values (((open-input-string4_0)
                (lambda (str3_0 name1_1 name2_4)
                  (let-values (((str_41) str3_0))
                    (let-values (((name_7) (if name2_4 name1_1 'string)))
                      (let-values ()
                        (begin
                          (if (string? str_41)
                            (void)
                            (let-values () (raise-argument-error 'open-input-string "string?" str_41)))
                          (1/open-input-bytes (1/string->bytes/utf-8 str_41) name_7))))))))
    (case-lambda
     ((str_42) (open-input-string4_0 str_42 #f #f))
     ((str_43 name1_0) (open-input-string4_0 str_43 name1_0 #t)))))
 (define-values
  (1/open-output-string)
  (let-values (((open-output-string8_0)
                (lambda (name6_1 name7_0)
                  (let-values (((name_4) (if name7_0 name6_1 'string))) (let-values () (1/open-output-bytes name_4))))))
    (case-lambda (() (open-output-string8_0 #f #f)) ((name6_0) (open-output-string8_0 name6_0 #t)))))
 (define-values
  (1/get-output-string)
  (lambda (o_6)
    (begin
      (if ((lambda (v_50) (if (1/output-port? o_6) (1/string-port? o_6) #f)) o_6)
        (void)
        (let-values () (raise-argument-error 'get-output-string "(and/c output-port? string-port?)" o_6)))
      (1/bytes->string/utf-8 (1/get-output-bytes o_6) '#\?))))
 (define-values
  (1/make-input-port)
  (let-values (((make-input-port17_0)
                (lambda (name13_0
                         user-read-in14_0
                         user-peek-in15_0
                         user-close16_0
                         user-get-progress-evt1_0
                         user-commit2_0
                         user-get-location3_0
                         user-count-lines!4_0
                         user-init-position5_0
                         user-buffer-mode6_0
                         user-get-progress-evt7_0
                         user-commit8_0
                         user-get-location9_0
                         user-count-lines!10_0
                         user-init-position11_0
                         user-buffer-mode12_0)
                  (let-values (((name_8) name13_0))
                    (let-values (((user-read-in_0) user-read-in14_0))
                      (let-values (((user-peek-in_0) user-peek-in15_0))
                        (let-values (((user-close_0) user-close16_0))
                          (let-values ()
                            (let-values ()
                              (let-values ()
                                (let-values ()
                                  (let-values ()
                                    (let-values ()
                                      (let-values ()
                                        (let-values (((protect-in_0)
                                                      (lambda (dest-bstr_5 dest-start_2 dest-end_2 copy?_5 read-in_3)
                                                        (let-values (((len_8) (- dest-end_2 dest-start_2)))
                                                          (let-values (((user-bstr_0)
                                                                        (if (let-values (((or-part_2) copy?_5))
                                                                              (if or-part_2
                                                                                or-part_2
                                                                                (let-values (((or-part_20)
                                                                                              (not
                                                                                               (zero? dest-start_2))))
                                                                                  (if or-part_20
                                                                                    or-part_20
                                                                                    (not (= len_8 dest-end_2))))))
                                                                          (make-bytes len_8)
                                                                          dest-bstr_5)))
                                                            (let-values (((n_2) (read-in_3 user-bstr_0)))
                                                              (begin
                                                                (if (exact-positive-integer? n_2)
                                                                  (let-values ()
                                                                    (if (eq? user-bstr_0 dest-bstr_5)
                                                                      (void)
                                                                      (let-values ()
                                                                        (bytes-copy!
                                                                         dest-bstr_5
                                                                         dest-start_2
                                                                         user-bstr_0
                                                                         0
                                                                         len_8))))
                                                                  (void))
                                                                n_2)))))))
                                          (let-values (((read-in_4)
                                                        (lambda (dest-bstr_7 dest-start_3 dest-end_3 copy?_7)
                                                          (protect-in_0
                                                           dest-bstr_7
                                                           dest-start_3
                                                           dest-end_3
                                                           copy?_7
                                                           user-read-in_0))))
                                            (letrec-values (((read-byte_5)
                                                             (lambda ()
                                                               (let-values (((bstr_83) (make-bytes 1)))
                                                                 (let-values (((n_3) (user-read-in_0 bstr_83)))
                                                                   (if (eof-object? n_3)
                                                                     (let-values () n_3)
                                                                     (if (= n_3 1)
                                                                       (let-values () (bytes-ref bstr_83 0))
                                                                       (let-values () (read-byte_5)))))))))
                                              (let-values (((peek-in_2)
                                                            (lambda (dest-bstr_8
                                                                     dest-start_4
                                                                     dest-end_4
                                                                     skip-k_20
                                                                     copy?_8)
                                                              (protect-in_0
                                                               dest-bstr_8
                                                               dest-start_4
                                                               dest-end_4
                                                               copy?_8
                                                               (lambda (user-bstr_1)
                                                                 (user-peek-in_0 user-bstr_1 skip-k_20 #f))))))
                                                (if user-peek-in_0
                                                  (let-values ()
                                                    (let-values (((name19_0) name_8)
                                                                 ((temp20_1)
                                                                  (if (1/input-port? user-read-in_0)
                                                                    user-read-in_0
                                                                    read-in_4))
                                                                 ((temp21_1)
                                                                  (if (1/input-port? user-peek-in_0)
                                                                    user-peek-in_0
                                                                    peek-in_2))
                                                                 ((user-close22_0) user-close_0))
                                                      (make-input-port24.1
                                                       user-close22_0
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
                                                       name19_0
                                                       #f
                                                       #f
                                                       temp21_1
                                                       #f
                                                       #f
                                                       temp20_1)))
                                                  (let-values ()
                                                    (let-values (((name23_0) name_8)
                                                                 ((read-byte24_0) read-byte_5)
                                                                 ((read-in25_0) read-in_4)
                                                                 ((user-close26_0) user-close_0))
                                                      (open-input-peek-to-read11.1
                                                       user-close26_0
                                                       name23_0
                                                       #f
                                                       #f
                                                       read-byte24_0
                                                       read-in25_0))))))))))))))))))))))
    (case-lambda
     ((name_9 user-read-in_1 user-peek-in_1 user-close_1)
      (make-input-port17_0 name_9 user-read-in_1 user-peek-in_1 user-close_1 #f #f #f #f #f #f #f #f #f #f #f #f))
     ((name_10
       user-read-in_2
       user-peek-in_2
       user-close_2
       user-get-progress-evt_0
       user-commit_0
       user-get-location_0
       user-count-lines!_0
       user-init-position_0
       user-buffer-mode6_1)
      (make-input-port17_0
       name_10
       user-read-in_2
       user-peek-in_2
       user-close_2
       user-get-progress-evt_0
       user-commit_0
       user-get-location_0
       user-count-lines!_0
       user-init-position_0
       user-buffer-mode6_1
       #t
       #t
       #t
       #t
       #t
       #t))
     ((name_11
       user-read-in_3
       user-peek-in_3
       user-close_3
       user-get-progress-evt_1
       user-commit_1
       user-get-location_1
       user-count-lines!_1
       user-init-position5_1)
      (make-input-port17_0
       name_11
       user-read-in_3
       user-peek-in_3
       user-close_3
       user-get-progress-evt_1
       user-commit_1
       user-get-location_1
       user-count-lines!_1
       user-init-position5_1
       #f
       #t
       #t
       #t
       #t
       #t
       #f))
     ((name_12
       user-read-in_4
       user-peek-in_4
       user-close_4
       user-get-progress-evt_2
       user-commit_2
       user-get-location_2
       user-count-lines!4_1)
      (make-input-port17_0
       name_12
       user-read-in_4
       user-peek-in_4
       user-close_4
       user-get-progress-evt_2
       user-commit_2
       user-get-location_2
       user-count-lines!4_1
       #f
       #f
       #t
       #t
       #t
       #t
       #f
       #f))
     ((name_13 user-read-in_5 user-peek-in_5 user-close_5 user-get-progress-evt_3 user-commit_3 user-get-location3_1)
      (make-input-port17_0
       name_13
       user-read-in_5
       user-peek-in_5
       user-close_5
       user-get-progress-evt_3
       user-commit_3
       user-get-location3_1
       #f
       #f
       #f
       #t
       #t
       #t
       #f
       #f
       #f))
     ((name_14 user-read-in_6 user-peek-in_6 user-close_6 user-get-progress-evt_4 user-commit2_1)
      (make-input-port17_0
       name_14
       user-read-in_6
       user-peek-in_6
       user-close_6
       user-get-progress-evt_4
       user-commit2_1
       #f
       #f
       #f
       #f
       #t
       #t
       #f
       #f
       #f
       #f))
     ((name_15 user-read-in_7 user-peek-in_7 user-close_7 user-get-progress-evt1_1)
      (make-input-port17_0
       name_15
       user-read-in_7
       user-peek-in_7
       user-close_7
       user-get-progress-evt1_1
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
       #f)))))
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
     ((name_16 evt_1 write-out_2 close_3)
      (make-output-port19_0 name_16 evt_1 write-out_2 close_3 #f #f #f #f #f #f #f #f #f #f #f #f #f #f))
     ((name_17
       evt_2
       write-out_3
       close_4
       write-out-special_1
       get-write-evt_1
       get-write-special-evt_1
       get-location_2
       count-lines!_4
       init-position_0
       buffer-mode7_1)
      (make-output-port19_0
       name_17
       evt_2
       write-out_3
       close_4
       write-out-special_1
       get-write-evt_1
       get-write-special-evt_1
       get-location_2
       count-lines!_4
       init-position_0
       buffer-mode7_1
       #t
       #t
       #t
       #t
       #t
       #t
       #t))
     ((name_18
       evt_3
       write-out_4
       close_5
       write-out-special_2
       get-write-evt_2
       get-write-special-evt_2
       get-location_3
       count-lines!_5
       init-position6_1)
      (make-output-port19_0
       name_18
       evt_3
       write-out_4
       close_5
       write-out-special_2
       get-write-evt_2
       get-write-special-evt_2
       get-location_3
       count-lines!_5
       init-position6_1
       #f
       #t
       #t
       #t
       #t
       #t
       #t
       #f))
     ((name_19
       evt_4
       write-out_5
       close_6
       write-out-special_3
       get-write-evt_3
       get-write-special-evt_3
       get-location_4
       count-lines!5_1)
      (make-output-port19_0
       name_19
       evt_4
       write-out_5
       close_6
       write-out-special_3
       get-write-evt_3
       get-write-special-evt_3
       get-location_4
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
     ((name_20 evt_5 write-out_6 close_7 write-out-special_4 get-write-evt_4 get-write-special-evt_4 get-location4_1)
      (make-output-port19_0
       name_20
       evt_5
       write-out_6
       close_7
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
     ((name_21 evt_6 write-out_7 close_8 write-out-special_5 get-write-evt_5 get-write-special-evt3_1)
      (make-output-port19_0
       name_21
       evt_6
       write-out_7
       close_8
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
     ((name_22 evt_7 write-out_8 close_9 write-out-special_6 get-write-evt2_1)
      (make-output-port19_0
       name_22
       evt_7
       write-out_8
       close_9
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
     ((name_23 evt_8 write-out_9 close_10 write-out-special1_1)
      (make-output-port19_0
       name_23
       evt_8
       write-out_9
       close_10
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
  (port-name)
  (lambda (p_0)
    (if (1/input-port? p_0)
      (let-values () (input-port-name p_0))
      (if (1/output-port? p_0)
        (let-values () (output-port-name p_0))
        (let-values () (raise-argument-error 'port-name "port?" p_0))))))
 (define-values
  (check-convention)
  (lambda (who_0 c_1)
    (if ((lambda (c_2) (let-values (((or-part_21) (eq? c_2 'windows))) (if or-part_21 or-part_21 (eq? c_2 'unix)))) c_1)
      (void)
      (let-values () (raise-argument-error who_0 "(or/c 'windows 'unix)" c_1)))))
 (define-values
  (check-path-string)
  (lambda (who_11 s_4)
    (begin
      (if (zero? (string-length s_4)) (let-values () (raise-arguments-error who_11 "path string is empty")) (void))
      (let-values (((vec_2 len_9)
                    (let-values (((vec_3) s_4))
                      (begin (check-string vec_3) (values vec_3 (unsafe-string-length vec_3))))))
        (begin
          #f
          ((letrec-values (((for-loop_1)
                            (lambda (pos_8)
                              (if (unsafe-fx< pos_8 len_9)
                                (let-values (((c_3) (string-ref vec_2 pos_8)))
                                  (let-values ((()
                                                (let-values ()
                                                  (let-values ((()
                                                                (let-values ()
                                                                  (begin
                                                                    (let-values ()
                                                                      (if (char=? c_3 '#\nul)
                                                                        (let-values ()
                                                                          (raise-arguments-error
                                                                           who_11
                                                                           "path string contains a nul character"
                                                                           "path string"
                                                                           s_4))
                                                                        (void)))
                                                                    (values)))))
                                                    (values)))))
                                    (if (not #f) (for-loop_1 (unsafe-fx+ 1 pos_8)) (values))))
                                (values)))))
             for-loop_1)
           0)))
      (void))))
 (define-values
  (check-path-bytes)
  (lambda (who_12 s_2)
    (begin
      (if (zero? (bytes-length s_2)) (let-values () (raise-arguments-error who_12 "byte string is empty")) (void))
      (let-values (((vec_4 len_10)
                    (let-values (((vec_5) s_2))
                      (begin (check-bytes vec_5) (values vec_5 (unsafe-bytes-length vec_5))))))
        (begin
          #f
          ((letrec-values (((for-loop_2)
                            (lambda (pos_9)
                              (if (unsafe-fx< pos_9 len_10)
                                (let-values (((c_4) (unsafe-bytes-ref vec_4 pos_9)))
                                  (let-values ((()
                                                (let-values ()
                                                  (let-values ((()
                                                                (let-values ()
                                                                  (begin
                                                                    (let-values ()
                                                                      (if (zero? c_4)
                                                                        (let-values ()
                                                                          (raise-arguments-error
                                                                           who_12
                                                                           "byte string contains a nul character"
                                                                           "byte string"
                                                                           s_2))
                                                                        (void)))
                                                                    (values)))))
                                                    (values)))))
                                    (if (not #f) (for-loop_2 (unsafe-fx+ 1 pos_9)) (values))))
                                (values)))))
             for-loop_2)
           0)))
      (void))))
 (define-values
  (is-sep?)
  (lambda (c_5 convention_0)
    (let-values (((or-part_1) (eq? c_5 (char->integer '#\/))))
      (if or-part_1 or-part_1 (if (eq? convention_0 'windows) (eq? c_5 (char->integer '#\\)) #f)))))
 (define-values (1/build-path) (lambda (base_0 . subs_0) (build 'build-path #f base_0 subs_0)))
 (define-values
  (1/build-path/convention-type)
  (lambda (convention_1 base_1 . subs_1) (build 'build-path/convention-type convention_1 base_1 subs_1)))
 (define-values
  (build)
  (lambda (who_13 init-convention_0 base_2 subs_2)
    (let-values ((() (begin (check-build-path-arg who_13 base_2) (values))))
      (let-values (((convention_2)
                    ((letrec-values (((loop_19)
                                      (lambda (convention_3 subs_3)
                                        (if (null? subs_3)
                                          (let-values () convention_3)
                                          (let-values ()
                                            (let-values (((sub_0) (car subs_3)))
                                              (begin
                                                (check-build-path-arg who_13 sub_0)
                                                (loop_19
                                                 (let-values (((temp12_0) #f))
                                                   (argument->convention6.1 temp12_0 sub_0 convention_3 who_13))
                                                 (cdr subs_3)))))))))
                       loop_19)
                     (let-values (((temp16_3) #t)) (argument->convention6.1 temp16_3 base_2 init-convention_0 who_13))
                     subs_2)))
        (path1.1 (append-path-parts convention_2 who_13 base_2 subs_2) convention_2)))))
 (define-values
  (check-build-path-arg)
  (lambda (who_14 p_2)
    (if ((lambda (p_3)
           (let-values (((or-part_22) (path-string? p_3)))
             (if or-part_22
               or-part_22
               (let-values (((or-part_23) (1/path-for-some-system? p_3)))
                 (if or-part_23
                   or-part_23
                   (let-values (((or-part_24) (eq? p_3 'up))) (if or-part_24 or-part_24 (eq? p_3 'same))))))))
         p_2)
      (void)
      (let-values () (raise-argument-error who_14 "(or/c path-string? path-for-some-system? 'up 'same)" p_2)))))
 (define-values
  (argument->convention6.1)
  (lambda (first?1_0 p3_0 convention4_0 who5_0)
    (let-values (((p_14) p3_0))
      (let-values (((convention_4) convention4_0))
        (let-values (((who_15) who5_0))
          (let-values (((first?_0) first?1_0))
            (let-values ()
              (let-values (((check_0)
                            (lambda (c_6)
                              (begin
                                (if (if convention_4 (not (eq? c_6 convention_4)) #f)
                                  (let-values ()
                                    (raise-arguments-error
                                     who_15
                                     (format
                                      (if first?_0
                                        "specified convention incompatible with ~a path element"
                                        "preceding path's convention incompatible with ~a path element")
                                      (if (string? p_14) "string" "given"))
                                     "path element"
                                     p_14
                                     (if first?_0 "convention" "preceding path's convention")
                                     convention_4))
                                  (void))
                                c_6))))
                (if (1/path? p_14)
                  (let-values () (check_0 (path-convention p_14)))
                  (if (string? p_14)
                    (let-values () (check_0 (system-path-convention-type)))
                    (let-values () convention_4)))))))))))
 (define-values
  (append-path-parts)
  (lambda (convention_5 who_16 base_3 subs_4)
    (apply
     bytes-append
     ((letrec-values (((loop_20)
                       (lambda (prev_0 subs_5)
                         (if (null? subs_5)
                           (let-values () (list prev_0))
                           (let-values ()
                             (let-values (((sub_1) (car subs_5)))
                               (let-values (((bstr_86) (as-bytes sub_1)))
                                 (if (eq? convention_5 'unix)
                                   (let-values ()
                                     (begin
                                       (if (is-sep? (bytes-ref bstr_86 0) 'unix)
                                         (let-values ()
                                           (raise-arguments-error
                                            who_16
                                            "absolute path cannot be added to a path"
                                            "absolute path"
                                            sub_1))
                                         (void))
                                       (cons
                                        prev_0
                                        (if (is-sep? (bytes-ref prev_0 (sub1 (bytes-length prev_0))) 'unix)
                                          (let-values () (loop_20 bstr_86 (cdr subs_5)))
                                          (let-values () (cons #"/" (loop_20 bstr_86 (cdr subs_5))))))))
                                   (let-values ()
                                     (let-values (((cleaned-prev_0) (strip-trailing-spaces prev_0)))
                                       cleaned-prev_0))))))))))
        loop_20)
      (as-bytes base_3)
      subs_4))))
 (define-values
  (as-bytes)
  (lambda (p_15)
    (if (eq? p_15 'up)
      (let-values () #"..")
      (if (eq? p_15 'same)
        (let-values () #".")
        (if (1/path? p_15)
          (let-values () (path-bytes p_15))
          (let-values () (1/string->bytes/locale p_15 (char->integer '#\?))))))))
 (define-values (strip-trailing-spaces) (lambda (prev_1) prev_1))
 (define-values
  (check-path-argument)
  (lambda (who_0 p_12)
    (if ((lambda (p_16)
           (let-values (((or-part_21) (path-string? p_16))) (if or-part_21 or-part_21 (1/path-for-some-system? p_16))))
         p_12)
      (void)
      (let-values () (raise-argument-error who_0 "(or/c path-string? path-for-some-system?)" p_12)))))
 (define-values (drive-letter?) (lambda (c_5) (if (< c_5 128) (char-alphabetic? (integer->char c_5)) #f)))
 (define-values
  (1/cleanse-path)
  (lambda (p-in_0)
    (let-values ((() (begin (check-path-argument 'cleanse-path p-in_0) (values))))
      (let-values (((p_12) (->path p-in_0)))
        (let-values (((tmp_0) (path-convention p_12)))
          (if (equal? tmp_0 'unix)
            (let-values ()
              (let-values (((bstr_87) (clean-double-slashes (path-bytes p_12) 'unix 0)))
                (if (eq? bstr_87 (path-bytes p_12)) p_12 (path1.1 bstr_87 'unix))))
            (if (equal? tmp_0 'windows) (let-values () (abort "Windows path cleanse")) (let-values () (void)))))))))
 (define-values
  (clean-double-slashes)
  (lambda (bstr_88 convention_6 allow-double-before_0)
    (let-values (((extra-count_0)
                  ((letrec-values (((loop_21)
                                    (lambda (i_11)
                                      (if (= i_11 allow-double-before_0)
                                        (let-values () 0)
                                        (if (if (is-sep? (bytes-ref bstr_88 i_11) convention_6)
                                              (is-sep? (bytes-ref bstr_88 (sub1 i_11)) convention_6)
                                              #f)
                                          (let-values () (add1 (loop_21 (sub1 i_11))))
                                          (let-values () (loop_21 (sub1 i_11))))))))
                     loop_21)
                   (sub1 (bytes-length bstr_88)))))
      (if (zero? extra-count_0)
        (let-values () bstr_88)
        (let-values ()
          (let-values (((new-bstr_1) (make-bytes (- (bytes-length bstr_88) extra-count_0))))
            (begin
              ((letrec-values (((loop_6)
                                (lambda (i_1 j_2)
                                  (if (= i_1 allow-double-before_0)
                                    (void)
                                    (let-values ()
                                      (if (if (is-sep? (bytes-ref bstr_88 i_1) convention_6)
                                            (is-sep? (bytes-ref bstr_88 (sub1 i_1)) convention_6)
                                            #f)
                                        (let-values () (loop_6 (sub1 i_1) j_2))
                                        (let-values ()
                                          (begin
                                            (bytes-set! new-bstr_1 j_2 (bytes-ref bstr_88 i_1))
                                            (loop_6 (sub1 i_1) (sub1 j_2))))))))))
                 loop_6)
               (sub1 (bytes-length bstr_88))
               (sub1 (bytes-length new-bstr_1)))
              (bytes-copy! new-bstr_1 0 bstr_88 0 (add1 allow-double-before_0))
              new-bstr_1)))))))
 (define-values
  (1/split-path)
  (lambda (p_17)
    (begin (check-path-argument 'split-path p_17) (let-values (((temp42_0) (->path p_17))) (split4.1 #f #f temp42_0)))))
 (define-values
  (1/explode-path)
  (lambda (p_18)
    (begin
      (check-path-argument 'explode-path p_18)
      (1/reverse (let-values (((temp43_0) (->path p_18)) ((temp44_0) #t)) (split4.1 temp44_0 #t temp43_0))))))
 (define-values
  (split4.1)
  (lambda (explode?1_0 explode?2_0 p3_1)
    (let-values (((p_3) p3_1))
      (let-values (((explode?_0) (if explode?2_0 explode?1_0 #f)))
        (let-values ()
          (if (not (eq? (path-convention p_3) 'windows))
            (let-values ()
              (let-values (((explode?46_0) explode?_0))
                (split-after-drive20.1 #f #f #f #f explode?46_0 #f #f #f #f #f #f p_3)))
            (let-values ()
              (let-values (((bstr_38) (path-bytes p_3)))
                (if (if (> (bytes-length bstr_38) 2)
                      (if (is-sep? (bytes-ref bstr_38 0) 'windows) (is-sep? (bytes-ref bstr_38 1) 'windows) #f)
                      #f)
                  (let-values ()
                    (let-values (((//?-drive-end_0) (parse-//?-drive bstr_38)))
                      (if //?-drive-end_0
                        (let-values ()
                          (let-values ()
                            (if (eq? //?-drive-end_0 'reld)
                              (let-values () (split-reld bstr_38 //?-drive-end_0))
                              (let-values ()
                                (let-values (((temp48_0)
                                              (if (if (< //?-drive-end_0 (bytes-length bstr_38))
                                                    (eq? (bytes-ref bstr_38 //?-drive-end_0) (char->integer '#\\))
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
                                   p_3))))))
                        (let-values ()
                          (let-values (((//-drive-end_0) (parse-//-drive bstr_38)))
                            (if //-drive-end_0
                              (let-values ()
                                (let-values (((temp53_1)
                                              (if (if (< //-drive-end_0 (bytes-length bstr_38))
                                                    (is-sep? (bytes-ref bstr_38 //?-drive-end_0) 'windows)
                                                    #f)
                                                (let-values () (add1 //-drive-end_0))
                                                (let-values () //-drive-end_0)))
                                             ((temp54_1) 1)
                                             ((explode?55_0) explode?_0))
                                  (split-after-drive20.1 temp54_1 #t temp53_1 #t explode?55_0 #f #f #f #f #f #f p_3)))
                              (let-values ()
                                (let-values (((explode?57_0) explode?_0))
                                  (split-after-drive20.1 #f #f #f #f explode?57_0 #f #f #f #f #f #f p_3)))))))))
                  (if (if (> (bytes-length bstr_38) 2)
                        (if (drive-letter? (bytes-ref bstr_38 0)) (eq? (bytes-ref bstr_38 1) (char->integer '#\:)) #f)
                        #f)
                    (let-values ()
                      (let-values (((temp59_1)
                                    (if (if (< 2 (bytes-length bstr_38)) (is-sep? (bytes-ref bstr_38 2) 'windows) #f)
                                      (let-values () 3)
                                      (let-values () 2)))
                                   ((explode?60_0) explode?_0))
                        (split-after-drive20.1 #f #f temp59_1 #t explode?60_0 #f #f #f #f #f #f p_3)))
                    (let-values (((c1_0)
                                  (let-values (((explode?62_0) explode?_0))
                                    (split-after-drive20.1 #f #f #f #f explode?62_0 #f #f #f #f #f #f p_3))))
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
    (let-values (((p_19) p19_0))
      (let-values (((in-len_0) (if len13_0 len7_0 #f)))
        (let-values (((drive-end_0) (if drive-end14_0 drive-end8_0 0)))
          (let-values (((no-slash-sep?_0) (if no-slash-sep?15_0 no-slash-sep?9_0 #f)))
            (let-values (((no-up?_0) (if no-up?16_0 no-up?10_0 #f)))
              (let-values (((allow-double-before_1) (if allow-double-before17_0 allow-double-before11_0 0)))
                (let-values (((explode?_1) explode?12_0))
                  (let-values ()
                    (let-values (((convention_7) (path-convention p_19)))
                      (let-values (((bstr_89)
                                    (if in-len_0
                                      (path-bytes p_19)
                                      (clean-double-slashes (path-bytes p_19) convention_7 allow-double-before_1))))
                        (let-values (((len_11)
                                      (let-values (((or-part_25) in-len_0))
                                        (if or-part_25 or-part_25 (bytes-length bstr_89)))))
                          (let-values (((split-pos_0 ends-sep?_0)
                                        ((letrec-values (((loop_22)
                                                          (lambda (i_12 ends-sep?_1)
                                                            (if (< i_12 drive-end_0)
                                                              (let-values () (values #f ends-sep?_1))
                                                              (let-values ()
                                                                (let-values (((sep?_0)
                                                                              (if no-slash-sep?_0
                                                                                (let-values ()
                                                                                  (eq? (bytes-ref bstr_89 i_12) '#\\))
                                                                                (let-values ()
                                                                                  (is-sep?
                                                                                   (bytes-ref bstr_89 i_12)
                                                                                   convention_7)))))
                                                                  (if sep?_0
                                                                    (let-values ()
                                                                      (if (< i_12 (sub1 len_11))
                                                                        (values i_12 ends-sep?_1)
                                                                        (loop_22 (sub1 i_12) #t)))
                                                                    (let-values ()
                                                                      (loop_22 (sub1 i_12) ends-sep?_1)))))))))
                                           loop_22)
                                         (sub1 len_11)
                                         #f)))
                            (if (not split-pos_0)
                              (let-values ()
                                (if (let-values (((or-part_26) (is-sep? (bytes-ref bstr_89 0) convention_7)))
                                      (if or-part_26 or-part_26 (positive? drive-end_0)))
                                  (let-values ()
                                    (let-values (((new-p_0) (path1.1 (subbytes bstr_89 0 len_11) convention_7)))
                                      (if explode?_1 (list new-p_0) (values #f new-p_0 #t))))
                                  (let-values ()
                                    (let-values (((name_24 is-dir?_0)
                                                  (let-values (((temp65_1) 0)
                                                               ((convention66_0) convention_7)
                                                               ((ends-sep?67_0) ends-sep?_0)
                                                               ((no-up?68_0) no-up?_0))
                                                    (split-tail31.1
                                                     ends-sep?67_0
                                                     no-up?68_0
                                                     bstr_89
                                                     len_11
                                                     temp65_1
                                                     convention66_0))))
                                      (if explode?_1 (list name_24) (values 'relative name_24 is-dir?_0))))))
                              (let-values ()
                                (let-values (((name_25 is-dir?_1)
                                              (let-values (((temp71_0) (add1 split-pos_0))
                                                           ((convention72_0) convention_7)
                                                           ((ends-sep?73_0) ends-sep?_0)
                                                           ((no-up?74_0) no-up?_0))
                                                (split-tail31.1
                                                 ends-sep?73_0
                                                 no-up?74_0
                                                 bstr_89
                                                 len_11
                                                 temp71_0
                                                 convention72_0))))
                                  (if (zero? split-pos_0)
                                    (let-values ()
                                      (let-values (((base_4)
                                                    (if (eq? (bytes-ref bstr_89 0) '#\/)
                                                      (path1.1 #"/" convention_7)
                                                      (path1.1 (subbytes bstr_89 0 1) convention_7))))
                                        (if explode?_1
                                          (let-values () (list name_25 base_4))
                                          (let-values () (values base_4 name_25 is-dir?_1)))))
                                    (let-values ()
                                      (let-values (((exposed-bstr_0 exposed-len_0)
                                                    (let-values (((temp76_0) (add1 split-pos_0))
                                                                 ((convention77_0) convention_7)
                                                                 ((no-up?78_0) no-up?_0))
                                                      (bytes->exposed-path-bytes39.1
                                                       no-up?78_0
                                                       bstr_89
                                                       temp76_0
                                                       convention77_0))))
                                        (if explode?_1
                                          (let-values ()
                                            (cons
                                             name_25
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
                                              (values base_5 name_25 is-dir?_1))))))))))))))))))))))))
 (define-values
  (split-tail31.1)
  (lambda (ends-sep?23_0 no-up?24_0 bstr27_0 len28_0 start-pos29_2 convention30_0)
    (let-values (((bstr_90) bstr27_0))
      (let-values (((len_12) len28_0))
        (let-values (((start-pos_27) start-pos29_2))
          (let-values (((convention_8) convention30_0))
            (let-values (((ends-sep?_2) ends-sep?23_0))
              (let-values (((no-up?_1) no-up?24_0))
                (let-values ()
                  (if (if (not no-up?_1)
                        (if (<= (+ start-pos_27 2) len_12)
                          (if (eq? (bytes-ref bstr_90 start-pos_27) (char->integer '#\.))
                            (if (eq? (bytes-ref bstr_90 (+ start-pos_27 1)) (char->integer '#\.))
                              (let-values (((or-part_27) (= (+ start-pos_27 2) len_12)))
                                (if or-part_27 or-part_27 (if (= (+ start-pos_27 3) len_12) ends-sep?_2 #f)))
                              #f)
                            #f)
                          #f)
                        #f)
                    (let-values () (values 'up #t))
                    (if (if (not no-up?_1)
                          (if (<= (+ start-pos_27 1) len_12)
                            (if (eq? (bytes-ref bstr_90 start-pos_27) (char->integer '#\.))
                              (let-values (((or-part_28) (= (+ start-pos_27 1) len_12)))
                                (if or-part_28 or-part_28 (if (= (+ start-pos_27 2) len_12) ends-sep?_2 #f)))
                              #f)
                            #f)
                          #f)
                      (let-values () (values 'same #t))
                      (let-values ()
                        (let-values (((new-bstr_2)
                                      (if ends-sep?_2
                                        (let-values () (subbytes bstr_90 start-pos_27 (sub1 len_12)))
                                        (if (zero? start-pos_27)
                                          (let-values () (bytes->immutable-bytes bstr_90))
                                          (let-values () (subbytes bstr_90 start-pos_27))))))
                          (let-values (((prot-bstr_0)
                                        (if (let-values (((or-part_29) no-up?_1))
                                              (if or-part_29 or-part_29 ends-sep?_2))
                                          (protect-path-element new-bstr_2 convention_8)
                                          new-bstr_2)))
                            (values (path1.1 prot-bstr_0 convention_8) ends-sep?_2)))))))))))))))
 (define-values
  (bytes->exposed-path-bytes39.1)
  (lambda (already-protected?34_0 bstr36_0 pos37_0 convention38_0)
    (let-values (((bstr_91) bstr36_0))
      (let-values (((pos_10) pos37_0)) (let-values () (let-values () (let-values () (values bstr_91 pos_10))))))))
 (define-values (protect-path-element) (lambda (new-bstr_3 convention_9) new-bstr_3))
 (define-values (parse-//?-drive) (lambda (bstr_30) (abort "finish me")))
 (define-values (parse-//-drive) (lambda (bstr_92) (abort "finish-me")))
 (define-values (split-reld) (lambda (bstr_93 drive-end_1) (abort "finish-me")))
 (define-values
  (1/relative-path?)
  (lambda (p_20)
    (begin
      (check-path-argument 'relative-path? p_20)
      (if (1/path? p_20)
        (let-values ()
          (let-values (((tmp_1) (path-convention p_20)))
            (if (equal? tmp_1 'unix)
              (let-values ()
                (let-values (((bstr_65) (path-bytes p_20)))
                  ((lambda (p_21) (not (is-sep? (bytes-ref p_21 0) 'unix))) bstr_65)))
              (if (equal? tmp_1 'windows) (let-values () (abort "much more here")) (let-values () (void))))))
        (if (string? p_20)
          (let-values ()
            (let-values (((tmp_2) (system-path-convention-type)))
              (if (equal? tmp_2 'unix)
                (let-values () ((lambda (p_3) (not (is-sep? (char->integer (string-ref p_3 0)) 'unix))) p_20))
                (if (equal? tmp_2 'windows) (let-values () (abort "much more here")) (let-values () (void))))))
          (void))))))
 (define-values
  (1/absolute-path?)
  (lambda (p_4)
    (begin
      (check-path-argument 'absolute-path? p_4)
      (if (1/path? p_4)
        (let-values ()
          (let-values (((tmp_3) (path-convention p_4)))
            (if (equal? tmp_3 'unix)
              (let-values ()
                (let-values (((bstr_38) (path-bytes p_4)))
                  ((lambda (p_22) (is-sep? (bytes-ref p_22 0) 'unix)) bstr_38)))
              (if (equal? tmp_3 'windows) (let-values () (abort "much more here")) (let-values () (void))))))
        (if (string? p_4)
          (let-values ()
            (let-values (((tmp_4) (system-path-convention-type)))
              (if (equal? tmp_4 'unix)
                (let-values () ((lambda (p_23) (is-sep? (char->integer (string-ref p_23 0)) 'unix)) p_4))
                (if (equal? tmp_4 'windows) (let-values () (abort "much more here")) (let-values () (void))))))
          (void))))))
 (define-values
  (1/complete-path?)
  (lambda (p_24)
    (begin
      (check-path-argument 'complete-path? p_24)
      (if (1/path? p_24)
        (let-values ()
          (let-values (((tmp_5) (path-convention p_24)))
            (if (equal? tmp_5 'unix)
              (let-values ()
                (let-values (((bstr_45) (path-bytes p_24)))
                  ((lambda (p_25) (is-sep? (bytes-ref p_25 0) 'unix)) bstr_45)))
              (if (equal? tmp_5 'windows) (let-values () (abort "much more here")) (let-values () (void))))))
        (if (string? p_24)
          (let-values ()
            (let-values (((tmp_6) (system-path-convention-type)))
              (if (equal? tmp_6 'unix)
                (let-values () ((lambda (p_26) (is-sep? (char->integer (string-ref p_26 0)) 'unix)) p_24))
                (if (equal? tmp_6 'windows) (let-values () (abort "much more here")) (let-values () (void))))))
          (void))))))
 (define-values
  (1/path->directory-path)
  (lambda (p-in_0)
    (let-values ((() (begin (check-path-argument 'path->directory-path p-in_0) (values))))
      (let-values (((p_12) (->path p-in_0)))
        (if (directory-path? p_12)
          (let-values () p_12)
          (let-values ()
            (let-values (((tmp_0) (path-convention p_12)))
              (if (equal? tmp_0 'unix)
                (let-values () (path1.1 (bytes-append (path-bytes p_12) #"/") 'unix))
                (let-values () (abort "path->dir-path for Windows"))))))))))
 (define-values
  (directory-path?)
  (lambda (p_27)
    (let-values (((bstr_88) (path-bytes p_27)))
      (let-values (((len_13) (bytes-length bstr_88)))
        (let-values (((tmp_7) (path-convention p_27)))
          (if (equal? tmp_7 'unix)
            (let-values ()
              (let-values (((or-part_30) (is-sep? (bytes-ref bstr_88 (sub1 len_13)) 'unix)))
                (if or-part_30
                  or-part_30
                  (let-values (((or-part_31)
                                (if (>= len_13 2)
                                  (if (eq? (bytes-ref bstr_88 (sub1 len_13)) (char->integer '#\.))
                                    (if (eq? (bytes-ref bstr_88 (- len_13 2)) (char->integer '#\.))
                                      (let-values (((or-part_32) (= len_13 2)))
                                        (if or-part_32 or-part_32 (is-sep? (bytes-ref bstr_88 (- len_13 3)) 'unix)))
                                      #f)
                                    #f)
                                  #f)))
                    (if or-part_31
                      or-part_31
                      (if (>= len_13 1)
                        (if (eq? (bytes-ref bstr_88 (sub1 len_13)) (char->integer '#\.))
                          (let-values (((or-part_33) (= len_13 1)))
                            (if or-part_33 or-part_33 (is-sep? (bytes-ref bstr_88 (- len_13 2)) 'unix)))
                          #f)
                        #f))))))
            (let-values () (abort "dir-path? for Windows"))))))))
 (define-values
  (1/simplify-path)
  (let-values (((simplify-path4_0)
                (lambda (p-in3_0 use-filesystem?1_0 use-filesystem?2_0)
                  (let-values (((p-in_1) p-in3_0))
                    (let-values ()
                      (let-values ()
                        (let-values ((() (begin (check-path-argument 'simplify-path p-in_1) (values))))
                          (let-values (((p_28) (->path p-in_1)))
                            (let-values (((convention_1) (path-convention p_28)))
                              (if (simple? p_28 convention_1)
                                (let-values () p_28)
                                (let-values ()
                                  (let-values (((clean-p_0) (1/cleanse-path p_28)))
                                    (if (simple? clean-p_0 convention_1)
                                      (let-values () clean-p_0)
                                      (let-values ()
                                        (let-values (((l_3) (1/explode-path clean-p_0)))
                                          (let-values (((simpler-l_0)
                                                        ((letrec-values (((loop_8)
                                                                          (lambda (l_4 accum_2)
                                                                            (if (null? l_4)
                                                                              (let-values () (1/reverse accum_2))
                                                                              (if (eq? 'same (car l_4))
                                                                                (let-values ()
                                                                                  (loop_8 (cdr l_4) accum_2))
                                                                                (if (if (eq? 'up (car l_4))
                                                                                      (pair? accum_2)
                                                                                      #f)
                                                                                  (let-values ()
                                                                                    (loop_8 (cdr l_4) (cdr accum_2)))
                                                                                  (let-values ()
                                                                                    (loop_8
                                                                                     (cdr l_4)
                                                                                     (cons (car l_4) accum_2)))))))))
                                                           loop_8)
                                                         l_3
                                                         null)))
                                            (let-values (((simple-p_0) (apply 1/build-path simpler-l_0)))
                                              (if (directory-path? p_28)
                                                (1/path->directory-path simple-p_0)
                                                simple-p_0))))))))))))))))))
    (case-lambda
     ((p-in_2) (simplify-path4_0 p-in_2 #f #f))
     ((p-in_3 use-filesystem?1_1) (simplify-path4_0 p-in_3 use-filesystem?1_1 #t)))))
 (define-values
  (simple?)
  (lambda (p_20 convention_10)
    (let-values (((bstr_65) (path-bytes p_20)))
      (let-values (((len_14) (bytes-length bstr_65)))
        ((letrec-values (((loop_23)
                          (lambda (i_13)
                            (if (= i_13 len_14)
                              (let-values () #t)
                              (if (is-sep? (bytes-ref bstr_65 i_13) convention_10)
                                (let-values ()
                                  (if (= (add1 i_13) len_14)
                                    (let-values () #t)
                                    (if (is-sep? (bytes-ref bstr_65 (add1 i_13)) convention_10)
                                      (let-values () #f)
                                      (if (if (eq? (bytes-ref bstr_65 (add1 i_13)) (char->integer '#\.))
                                            (let-values (((or-part_22) (= (+ i_13 2) len_14)))
                                              (if or-part_22
                                                or-part_22
                                                (let-values (((or-part_23)
                                                              (is-sep? (bytes-ref bstr_65 (+ i_13 2)) convention_10)))
                                                  (if or-part_23
                                                    or-part_23
                                                    (if (eq? (bytes-ref bstr_65 (+ i_13 2)) (char->integer '#\.))
                                                      (let-values (((or-part_24) (= (+ i_13 3) len_14)))
                                                        (if or-part_24
                                                          or-part_24
                                                          (is-sep? (bytes-ref bstr_65 (+ i_13 3)) convention_10)))
                                                      #f)))))
                                            #f)
                                        (let-values () #f)
                                        (let-values () (loop_23 (add1 i_13)))))))
                                (if (if (zero? i_13)
                                      (if (eq? (bytes-ref bstr_65 0) (char->integer '#\.))
                                        (let-values (((or-part_34) (= 1 len_14)))
                                          (if or-part_34
                                            or-part_34
                                            (let-values (((or-part_35) (is-sep? (bytes-ref bstr_65 1) convention_10)))
                                              (if or-part_35
                                                or-part_35
                                                (if (eq? (bytes-ref bstr_65 1) (char->integer '#\.))
                                                  (let-values (((or-part_36) (= 2 len_14)))
                                                    (if or-part_36
                                                      or-part_36
                                                      (is-sep? (bytes-ref bstr_65 2) convention_10)))
                                                  #f)))))
                                        #f)
                                      #f)
                                  (let-values () #f)
                                  (let-values () (loop_23 (add1 i_13)))))))))
           loop_23)
         0)))))
 (define-values
  (1/path->complete-path)
  (case-lambda
   ((p_29) (let-values (((temp9_1) (current-directory)) ((temp10_0) #f)) (->complete-path5.1 temp10_0 p_29 temp9_1)))
   ((p_30 wrt_0) (let-values (((temp13_2) #t)) (->complete-path5.1 temp13_2 p_30 wrt_0)))))
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
                                  (if ((lambda (p_4)
                                         (if (let-values (((or-part_23) (path-string? p_4)))
                                               (if or-part_23 or-part_23 (1/path-for-some-system? p_4)))
                                           (1/complete-path? p_4)
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
                  (let-values (((p_3) (->path p-in_4)))
                    (if (1/complete-path? p_3)
                      (let-values () p_3)
                      (if (1/relative-path? p_3)
                        (let-values () (1/build-path wrt_1 p_3))
                        (let-values () (abort "non-complete absolute path on Windows"))))))))))))))
 (define-values
  (convention-of-path)
  (lambda (p_5) (if (1/path? p_5) (path-convention p_5) (system-path-convention-type))))
 (define-values
  (1/string->path)
  (lambda (s_0)
    (begin
      (if (string? s_0) (void) (let-values () (raise-argument-error 'string->path "string?" s_0)))
      (check-path-string 'string->path s_0)
      (string->path$1 s_0))))
 (define-values
  (1/path->string)
  (lambda (p_12)
    (begin
      (if (is-path? p_12) (void) (let-values () (raise-argument-error 'path->string "path?" p_12)))
      (1/bytes->string/locale (path-bytes p_12) '#\?))))
 (define-values
  (1/bytes->path)
  (let-values (((bytes->path4_0)
                (lambda (bstr3_0 convention1_0 convention2_0)
                  (let-values (((bstr_94) bstr3_0))
                    (let-values (((convention_1) (if convention2_0 convention1_0 (system-path-convention-type))))
                      (let-values ()
                        (begin
                          (if (bytes? bstr_94)
                            (void)
                            (let-values () (raise-argument-error 'bytes->path "bytes?" bstr_94)))
                          (check-convention 'bytes->path convention_1)
                          (check-path-bytes 'bytes->path bstr_94)
                          (path1.1 (bytes->immutable-bytes bstr_94) convention_1))))))))
    (case-lambda
     ((bstr_0) (bytes->path4_0 bstr_0 #f #f))
     ((bstr_95 convention1_1) (bytes->path4_0 bstr_95 convention1_1 #t)))))
 (define-values
  (1/path->bytes)
  (lambda (p_31)
    (begin
      (if (1/path? p_31) (void) (let-values () (raise-argument-error 'path->bytes "path-for-some-system?" p_31)))
      (bytes-copy (path-bytes p_31)))))
 (define-values
  (1/string->path-element)
  (lambda (s_5)
    (begin
      (if (string? s_5) (void) (let-values () (raise-argument-error 'string->path-element "string?" s_5)))
      (check-path-string 'string->path-element s_5)
      (do-bytes->path-element
       (1/string->bytes/locale s_5 '#\?)
       (system-path-convention-type)
       'string->path-element
       s_5))))
 (define-values
  (1/bytes->path-element)
  (let-values (((bytes->path-element9_0)
                (lambda (bstr8_0 convention6_0 convention7_0)
                  (let-values (((bstr_44) bstr8_0))
                    (let-values (((convention_11) (if convention7_0 convention6_0 (system-path-convention-type))))
                      (let-values ()
                        (begin
                          (if (bytes? bstr_44)
                            (void)
                            (let-values () (raise-argument-error 'bytes->path-element "bytes?" bstr_44)))
                          (check-convention 'bytes->path-element convention_11)
                          (check-path-bytes 'bytes->path-element bstr_44)
                          (do-bytes->path-element bstr_44 convention_11 'bytes->path-element bstr_44))))))))
    (case-lambda
     ((bstr_64) (bytes->path-element9_0 bstr_64 #f #f))
     ((bstr_65 convention6_1) (bytes->path-element9_0 bstr_65 convention6_1 #t)))))
 (define-values
  (path-element?)
  (lambda (p_2)
    (if (1/path? p_2)
      (let-values ()
        (let-values (((bstr_4) (path-bytes p_2)))
          (let-values (((convention_12) (path-convention p_2)))
            (if (not
                 (let-values (((vec_6 len_15)
                               (let-values (((vec_7) bstr_4))
                                 (begin (check-bytes vec_7) (values vec_7 (unsafe-bytes-length vec_7)))))
                              ((start_32) 0))
                   (begin
                     #f
                     (check-naturals start_32)
                     ((letrec-values (((for-loop_3)
                                       (lambda (result_3 pos_11 pos_12)
                                         (if (if (unsafe-fx< pos_11 len_15) #t #f)
                                           (let-values (((c_7) (unsafe-bytes-ref vec_6 pos_11)) ((i_14) pos_12))
                                             (let-values (((result_4)
                                                           (let-values ()
                                                             (let-values (((result_5)
                                                                           (let-values ()
                                                                             (let-values ()
                                                                               (if (is-sep? c_7 convention_12)
                                                                                 i_14
                                                                                 #f)))))
                                                               (values result_5)))))
                                               (if (if (not ((lambda x_4 result_4) c_7))
                                                     (if (not ((lambda x_5 result_4) i_14)) (not #f) #f)
                                                     #f)
                                                 (for-loop_3 result_4 (unsafe-fx+ 1 pos_11) (+ pos_12 1))
                                                 result_4)))
                                           result_3))))
                        for-loop_3)
                      #f
                      0
                      start_32))))
              (let-values (((base_6 name_26 dir?_0) (1/split-path p_2))) (if (symbol? base_6) (1/path? name_26) #f))
              #f))))
      (let-values () #f))))
 (define-values
  (do-bytes->path-element)
  (lambda (bstr_96 convention_13 who_17 orig-arg_0)
    (let-values (((len_16) (bytes-length bstr_96)))
      (let-values (((p_10) (path1.1 (bytes->immutable-bytes bstr_96) convention_13)))
        (begin
          (if (path-element? p_10)
            (void)
            (let-values ()
              (raise-arguments-error
               who_17
               (string-append
                "cannot be converted to a path element;\n"
                " path can be split, is not relative, or names a special element")
               "argument"
               orig-arg_0)))
          p_10)))))
 (define-values
  (1/path-element->string)
  (lambda (p_32)
    (begin
      (if (path-element? p_32) (void) (let-values () (raise-argument-error 'path-element->string "path-element?" p_32)))
      (1/bytes->string/locale (path-bytes p_32) '#\?))))
 (define-values
  (1/path-element->bytes)
  (lambda (p_33)
    (begin
      (if (path-element? p_33) (void) (let-values () (raise-argument-error 'path-element->string "path-element?" p_33)))
      (bytes-copy (path-bytes p_33)))))
 (define-values
  (1/path<?)
  (case-lambda
   ((p_34) (begin (if (is-path? p_34) (void) (let-values () (raise-argument-error 'path<? "path?" p_34))) #t))
   ((p1_1 p2_1)
    (begin
      (if (is-path? p1_1) (void) (let-values () (raise-argument-error 'path<? "path?" p1_1)))
      (if (is-path? p2_1) (void) (let-values () (raise-argument-error 'path<? "path?" p2_1)))
      (bytes<? (path-bytes p1_1) (path-bytes p2_1))))
   ((p_35 . ps_0)
    (begin
      (if (is-path? p_35) (void) (let-values () (raise-argument-error 'path<? "path?" p_35)))
      ((letrec-values (((loop_18)
                        (lambda (bstr_97 ps_1)
                          (if (null? ps_1)
                            (let-values () #t)
                            (let-values ()
                              (let-values (((p_36) (car ps_1)))
                                (let-values ((()
                                              (begin
                                                (if (is-path? p_36)
                                                  (void)
                                                  (let-values () (raise-argument-error 'path<? "path?" p_36)))
                                                (values))))
                                  (let-values (((bstr2_0) (path-bytes p_36)))
                                    (if (bytes<? bstr_97 bstr2_0) (loop_18 bstr2_0 (cdr ps_1)) #f)))))))))
         loop_18)
       (path-bytes p_35)
       ps_0)))))
 (define-values
  (1/path-convention-type)
  (lambda (p_37)
    (begin
      (if (1/path-for-some-system? p_37)
        (void)
        (let-values () (raise-argument-error 'path-convention-type "path-for-some-system?" p_37)))
      (path-convention p_37))))
 (define-values
  (write-string/max)
  (let-values (((write-string/max8_0)
                (lambda (str5_0 o6_0 max-length7_0 start1_0 end2_0 start3_0 end4_0)
                  (let-values (((str_35) str5_0))
                    (let-values (((o_7) o6_0))
                      (let-values (((max-length_0) max-length7_0))
                        (let-values (((start_33) (if start3_0 start1_0 0)))
                          (let-values (((end_23) (if end4_0 end2_0 (string-length str_35))))
                            (let-values ()
                              (if (eq? max-length_0 'full)
                                (let-values () 'full)
                                (if (not max-length_0)
                                  (let-values () (begin (1/write-string str_35 o_7 start_33 end_23) #f))
                                  (let-values ()
                                    (let-values (((len_17) (- end_23 start_33)))
                                      (if (< len_17 max-length_0)
                                        (let-values ()
                                          (begin (1/write-string str_35 o_7 start_33 end_23) (- max-length_0 len_17)))
                                        (let-values ()
                                          (begin
                                            (1/write-string str_35 o_7 start_33 (+ start_33 max-length_0))
                                            'full))))))))))))))))
    (case-lambda
     ((str_44 o_8 max-length_1) (write-string/max8_0 str_44 o_8 max-length_1 #f #f #f #f))
     ((str_0 o_9 max-length_2 start_34 end2_1) (write-string/max8_0 str_0 o_9 max-length_2 start_34 end2_1 #t #t))
     ((str_45 o_10 max-length_3 start1_1) (write-string/max8_0 str_45 o_10 max-length_3 start1_1 #f #t #f)))))
 (define-values
  (write-bytes/max)
  (let-values (((write-bytes/max17_0)
                (lambda (bstr14_0 o15_0 max-length16_0 start10_1 end11_1 start12_0 end13_0)
                  (let-values (((bstr_98) bstr14_0))
                    (let-values (((o_11) o15_0))
                      (let-values (((max-length_4) max-length16_0))
                        (let-values (((start_35) (if start12_0 start10_1 0)))
                          (let-values (((end_24) (if end13_0 end11_1 (bytes-length bstr_98))))
                            (let-values ()
                              (if (eq? max-length_4 'full)
                                (let-values () 'full)
                                (if (not max-length_4)
                                  (let-values () (begin (1/write-bytes bstr_98 o_11 start_35 end_24) #f))
                                  (let-values ()
                                    (let-values (((len_18) (- end_24 start_35)))
                                      (if (< len_18 max-length_4)
                                        (let-values ()
                                          (begin (1/write-bytes bstr_98 o_11 start_35 end_24) (- max-length_4 len_18)))
                                        (let-values ()
                                          (begin
                                            (1/write-bytes bstr_98 o_11 start_35 (+ start_35 max-length_4))
                                            'full))))))))))))))))
    (case-lambda
     ((bstr_99 o_12 max-length_5) (write-bytes/max17_0 bstr_99 o_12 max-length_5 #f #f #f #f))
     ((bstr_96 o_13 max-length_6 start_36 end11_2)
      (write-bytes/max17_0 bstr_96 o_13 max-length_6 start_36 end11_2 #t #t))
     ((bstr_100 o_14 max-length_7 start10_2) (write-bytes/max17_0 bstr_100 o_14 max-length_7 start10_2 #f #t #f)))))
 (define-values
  (make-output-port/max)
  (lambda (o_15 max-length_8)
    (if max-length_8
      (let-values ()
        (let-values (((temp19_1) (output-port-name o_15))
                     ((temp20_2) (lambda () max-length_8))
                     ((o21_0) o_15)
                     ((temp22_1)
                      (lambda (src-bstr_2 src-start_2 src-end_2 nonblock?_2 enable-break?_3)
                        (let-values (((len_19) (- src-end_2 src-start_2)))
                          (begin
                            (if (eq? max-length_8 'full)
                              (void)
                              (let-values ()
                                (let-values (((write-len_0) (min len_19 max-length_8)))
                                  (let-values (((wrote-len_0)
                                                (1/write-bytes-avail*
                                                 src-bstr_2
                                                 o_15
                                                 src-start_2
                                                 (+ src-start_2 write-len_0))))
                                    (if (= max-length_8 wrote-len_0)
                                      (set! max-length_8 'full)
                                      (set! max-length_8 (- max-length_8 wrote-len_0)))))))
                            len_19))))
                     ((void23_0) void))
          (make-output-port22.1 void23_0 #f #f temp20_2 #t o21_0 #f #f #f #f #f #f temp19_1 temp22_1 #f #f)))
      (let-values () o_15))))
 (define-values
  (output-port/max-max-length)
  (lambda (o_16 max-length_9) (if max-length_9 ((output-port-data o_16)) #f)))
 (define-values
  (print-string)
  (lambda (str_15 o_17 max-length_10)
    (let-values (((max-length_11) (write-bytes/max #"\"" o_17 max-length_10)))
      (let-values (((len_20) (string-length str_15)))
        ((letrec-values (((loop_24)
                          (lambda (start-i_0 i_3 max-length_12)
                            (if (eq? max-length_12 'full)
                              (let-values () 'full)
                              (if (let-values (((or-part_32) (= i_3 len_20)))
                                    (if or-part_32
                                      or-part_32
                                      (if max-length_12 (> (- i_3 start-i_0) max-length_12) #f)))
                                (let-values ()
                                  (let-values (((max-length_0)
                                                (write-string/max str_15 o_17 max-length_12 start-i_0 i_3)))
                                    (write-bytes/max #"\"" o_17 max-length_0)))
                                (let-values ()
                                  (let-values (((c_3) (string-ref str_15 i_3)))
                                    (let-values (((escaped_0)
                                                  (let-values (((tmp_8) c_3))
                                                    (if (equal? tmp_8 '#\")
                                                      (let-values () #"\\\"")
                                                      (if (equal? tmp_8 '#\\)
                                                        (let-values () #"\\\\")
                                                        (if (equal? tmp_8 '#\u0007)
                                                          (let-values () #"\\a")
                                                          (if (equal? tmp_8 '#\backspace)
                                                            (let-values () #"\\b")
                                                            (if (equal? tmp_8 '#\u001B)
                                                              (let-values () #"\\e")
                                                              (if (equal? tmp_8 '#\page)
                                                                (let-values () #"\\f")
                                                                (if (equal? tmp_8 '#\newline)
                                                                  (let-values () #"\\n")
                                                                  (if (equal? tmp_8 '#\return)
                                                                    (let-values () #"\\r")
                                                                    (if (equal? tmp_8 '#\tab)
                                                                      (let-values () #"\\t")
                                                                      (if (equal? tmp_8 '#\vtab)
                                                                        (let-values () #"\\v")
                                                                        (let-values () #f))))))))))))))
                                      (if escaped_0
                                        (let-values ()
                                          (let-values (((max-length_13)
                                                        (write-string/max str_15 o_17 max-length_12 start-i_0 i_3)))
                                            (let-values (((max-length_14)
                                                          (write-bytes/max escaped_0 o_17 max-length_13)))
                                              (let-values (((i_15) (add1 i_3))) (loop_24 i_15 i_15 max-length_14)))))
                                        (if (let-values (((or-part_37) (char-graphic? c_3)))
                                              (if or-part_37 or-part_37 (char-blank? c_3)))
                                          (let-values () (loop_24 start-i_0 (add1 i_3) max-length_12))
                                          (let-values ()
                                            (let-values (((n_4) (char->integer c_3)))
                                              (let-values (((pad_0)
                                                            (lambda (n_5 s_6)
                                                              (let-values (((len_6) (string-length s_6)))
                                                                (if (< len_6 n_5)
                                                                  (string-append (make-string (- n_5 len_6) '#\0) s_6)
                                                                  s_6)))))
                                                (let-values (((max-length_15)
                                                              (write-string/max
                                                               str_15
                                                               o_17
                                                               max-length_12
                                                               start-i_0
                                                               i_3)))
                                                  (let-values (((max-length_3)
                                                                (if (<= n_4 65535)
                                                                  (let-values ()
                                                                    (let-values (((max-length_16)
                                                                                  (write-bytes/max
                                                                                   #"\\u"
                                                                                   o_17
                                                                                   max-length_15)))
                                                                      (write-string/max
                                                                       (pad_0 4 (number->string n_4 16))
                                                                       o_17
                                                                       max-length_16)))
                                                                  (let-values ()
                                                                    (let-values (((max-length_17)
                                                                                  (write-bytes/max
                                                                                   #"\\U"
                                                                                   o_17
                                                                                   max-length_15)))
                                                                      (write-string/max
                                                                       (pad_0 8 (number->string n_4 16))
                                                                       o_17
                                                                       max-length_17))))))
                                                    (let-values (((i_16) (add1 i_3)))
                                                      (loop_24 i_16 i_16 max-length_3)))))))))))))))))
           loop_24)
         0
         0
         max-length_11)))))
 (define-values
  (print-bytes)
  (lambda (bstr_101 o_17 max-length_10)
    (let-values (((max-length_11) (write-bytes/max #"#\"" o_17 max-length_10)))
      (let-values (((len_20) (bytes-length bstr_101)))
        ((letrec-values (((loop_24)
                          (lambda (start-i_0 i_3 max-length_12)
                            (if (eq? max-length_12 'full)
                              (let-values () 'full)
                              (if (let-values (((or-part_32) (= i_3 len_20)))
                                    (if or-part_32
                                      or-part_32
                                      (if max-length_12 (> (- i_3 start-i_0) max-length_12) #f)))
                                (let-values ()
                                  (let-values (((max-length_0)
                                                (write-bytes/max bstr_101 o_17 max-length_12 start-i_0 i_3)))
                                    (write-bytes/max #"\"" o_17 max-length_0)))
                                (let-values ()
                                  (let-values (((b_8) (bytes-ref bstr_101 i_3)))
                                    (if (if (< b_8 128)
                                          (let-values (((c_8) (integer->char b_8)))
                                            (if (let-values (((or-part_38) (char-blank? c_8)))
                                                  (if or-part_38 or-part_38 (char-graphic? c_8)))
                                              (if (not (char=? c_8 '#\")) (not (char=? c_8 '#\\)) #f)
                                              #f))
                                          #f)
                                      (let-values () (loop_24 start-i_0 (add1 i_3) max-length_12))
                                      (let-values ()
                                        (let-values (((max-length_13)
                                                      (write-bytes/max bstr_101 o_17 max-length_12 start-i_0 i_3)))
                                          (let-values (((escaped_1)
                                                        (let-values (((tmp_9) (if (< b_8 128) (integer->char b_8) #f)))
                                                          (if (equal? tmp_9 '#\")
                                                            (let-values () #"\\\"")
                                                            (if (equal? tmp_9 '#\\)
                                                              (let-values () #"\\\\")
                                                              (if (equal? tmp_9 '#\u0007)
                                                                (let-values () #"\\a")
                                                                (if (equal? tmp_9 '#\backspace)
                                                                  (let-values () #"\\b")
                                                                  (if (equal? tmp_9 '#\u001B)
                                                                    (let-values () #"\\e")
                                                                    (if (equal? tmp_9 '#\page)
                                                                      (let-values () #"\\f")
                                                                      (if (equal? tmp_9 '#\newline)
                                                                        (let-values () #"\\n")
                                                                        (if (equal? tmp_9 '#\return)
                                                                          (let-values () #"\\r")
                                                                          (if (equal? tmp_9 '#\tab)
                                                                            (let-values () #"\\t")
                                                                            (if (equal? tmp_9 '#\vtab)
                                                                              (let-values () #"\\v")
                                                                              (let-values () #f))))))))))))))
                                            (if escaped_1
                                              (let-values ()
                                                (let-values (((max-length_18)
                                                              (write-bytes/max escaped_1 o_17 max-length_13))
                                                             ((i_5) (add1 i_3)))
                                                  (loop_24 i_5 i_5 max-length_18)))
                                              (let-values ()
                                                (let-values (((i_17) (add1 i_3)))
                                                  (let-values (((next-b_0)
                                                                (let-values (((or-part_39)
                                                                              (if (< i_17 len_20)
                                                                                (bytes-ref bstr_101 i_17)
                                                                                #f)))
                                                                  (if or-part_39 or-part_39 0))))
                                                    (if (let-values (((or-part_12) (>= b_8 64)))
                                                          (if or-part_12
                                                            or-part_12
                                                            (if (>= next-b_0 (char->integer '#\0))
                                                              (<= next-b_0 (char->integer '#\9))
                                                              #f)))
                                                      (let-values ()
                                                        (let-values (((max-length_15)
                                                                      (write-bytes/max #"\\" o_17 max-length_13)))
                                                          (let-values (((max-length_3)
                                                                        (write-bytes/max
                                                                         (digit (arithmetic-shift b_8 -6))
                                                                         o_17
                                                                         max-length_15)))
                                                            (let-values (((max-length_16)
                                                                          (write-bytes/max
                                                                           (digit
                                                                            (bitwise-and 7 (arithmetic-shift b_8 -3)))
                                                                           o_17
                                                                           max-length_3)))
                                                              (let-values (((max-length_17)
                                                                            (write-bytes/max
                                                                             (digit (bitwise-and 7 b_8))
                                                                             o_17
                                                                             max-length_16)))
                                                                (loop_24 i_17 i_17 max-length_17))))))
                                                      (if (>= b_8 8)
                                                        (let-values ()
                                                          (let-values (((max-length_19)
                                                                        (write-bytes/max #"\\" o_17 max-length_13)))
                                                            (let-values (((max-length_20)
                                                                          (write-bytes/max
                                                                           (digit
                                                                            (bitwise-and 7 (arithmetic-shift b_8 -3)))
                                                                           o_17
                                                                           max-length_19)))
                                                              (let-values (((max-length_21)
                                                                            (write-bytes/max
                                                                             (digit (bitwise-and 7 b_8))
                                                                             o_17
                                                                             max-length_20)))
                                                                (loop_24 i_17 i_17 max-length_21)))))
                                                        (let-values ()
                                                          (let-values (((max-length_22)
                                                                        (write-bytes/max #"\\" o_17 max-length_13)))
                                                            (let-values (((max-length_23)
                                                                          (write-bytes/max
                                                                           (digit b_8)
                                                                           o_17
                                                                           max-length_22)))
                                                              (loop_24 i_17 i_17 max-length_23)))))))))))))))))))))
           loop_24)
         0
         0
         max-length_11)))))
 (define-values
  (digit)
  (lambda (v_51)
    (let-values (((tmp_10) v_51))
      (if (equal? tmp_10 0)
        (let-values () #"0")
        (if (equal? tmp_10 1)
          (let-values () #"1")
          (if (equal? tmp_10 2)
            (let-values () #"2")
            (if (equal? tmp_10 3)
              (let-values () #"3")
              (if (equal? tmp_10 4)
                (let-values () #"4")
                (if (equal? tmp_10 5)
                  (let-values () #"5")
                  (if (equal? tmp_10 6)
                    (let-values () #"6")
                    (if (equal? tmp_10 7) (let-values () #"7") (let-values () (void)))))))))))))
 (define-values
  (print-symbol)
  (lambda (sym_0 o_17 max-length_10)
    (let-values (((str_46) (symbol->string sym_0))) (write-string/max str_46 o_17 max-length_10))))
 (define-values
  (print-char)
  (lambda (c_5 o_17 max-length_10)
    (let-values (((esc-str_0)
                  (let-values (((tmp_11) c_5))
                    (if (equal? tmp_11 '#\nul)
                      (let-values () "#\\nul")
                      (if (equal? tmp_11 '#\backspace)
                        (let-values () "#\\backspace")
                        (if (equal? tmp_11 '#\tab)
                          (let-values () "#\\tab")
                          (if (equal? tmp_11 '#\page)
                            (let-values () "#\\page")
                            (if (equal? tmp_11 '#\newline)
                              (let-values () "#\\newline")
                              (if (equal? tmp_11 '#\return)
                                (let-values () "#\\return")
                                (if (equal? tmp_11 '#\vtab)
                                  (let-values () "#\\vtab")
                                  (if (equal? tmp_11 '#\space)
                                    (let-values () "#\\space")
                                    (if (equal? tmp_11 '#\rubout)
                                      (let-values () "#\\rubout")
                                      (let-values () #f)))))))))))))
      (if esc-str_0
        (let-values () (write-string/max esc-str_0 o_17 max-length_10))
        (if (char-graphic? c_5)
          (let-values ()
            (let-values (((max-length_24) (write-string/max "#\\" o_17 max-length_10)))
              (write-string/max (string c_5) o_17 max-length_24)))
          (let-values ()
            (let-values (((n_6) (char->integer c_5)))
              (let-values (((pad_1)
                            (lambda (n_7 s_7)
                              (let-values (((len_21) (string-length s_7)))
                                (if (< len_21 n_7) (string-append (make-string (- n_7 len_21) '#\0) s_7) s_7)))))
                (if (<= n_6 65535)
                  (let-values ()
                    (let-values (((max-length_25) (write-string/max "#\\u" o_17 max-length_10)))
                      (write-string/max (pad_1 4 (number->string n_6 16)) o_17 max-length_25)))
                  (let-values ()
                    (let-values (((max-length_26) (write-string/max "#\\U" o_17 max-length_10)))
                      (write-string/max (pad_1 8 (number->string n_6 16)) o_17 max-length_26))))))))))))
 (define-values
  (1/display)
  (let-values (((display6_0)
                (lambda (v5_0 o1_0 max-length2_0 o3_0 max-length4_0)
                  (let-values (((v_24) v5_0))
                    (let-values (((o_18) (if o3_0 o1_0 (1/current-output-port))))
                      (let-values (((max-length_12) (if max-length4_0 max-length2_0 #f)))
                        (let-values ()
                          (begin
                            (if (1/output-port? o_18)
                              (void)
                              (let-values () (raise-argument-error 'display "output-port?" o_18)))
                            (if (max-length? max-length_12)
                              (void)
                              (let-values () (raise-argument-error 'display max-length-contract max-length_12)))
                            (dots (p 'display v_24 #f o_18 (sub3 max-length_12)) o_18)
                            (void)))))))))
    (case-lambda
     ((v_52) (display6_0 v_52 #f #f #f #f))
     ((v_53 o_19 max-length2_1) (display6_0 v_53 o_19 max-length2_1 #t #t))
     ((v_54 o1_1) (display6_0 v_54 o1_1 #f #t #f)))))
 (define-values
  (1/write)
  (let-values (((write13_0)
                (lambda (v12_0 o8_0 max-length9_0 o10_0 max-length11_0)
                  (let-values (((v_44) v12_0))
                    (let-values (((o_20) (if o10_0 o8_0 (1/current-output-port))))
                      (let-values (((max-length_15) (if max-length11_0 max-length9_0 #f)))
                        (let-values ()
                          (begin
                            (if (1/output-port? o_20)
                              (void)
                              (let-values () (raise-argument-error 'write "output-port?" o_20)))
                            (if (max-length? max-length_15)
                              (void)
                              (let-values () (raise-argument-error 'write max-length-contract max-length_15)))
                            (dots (p 'write v_44 #t o_20 (sub3 max-length_15)) o_20)
                            (void)))))))))
    (case-lambda
     ((v_26) (write13_0 v_26 #f #f #f #f))
     ((v_48 o_21 max-length9_1) (write13_0 v_48 o_21 max-length9_1 #t #t))
     ((v_3 o8_1) (write13_0 v_3 o8_1 #f #t #f)))))
 (define-values
  (1/print)
  (let-values (((print22_0)
                (lambda (v21_0 o15_1 quote-depth16_0 max-length17_0 o18_1 quote-depth19_0 max-length20_0)
                  (let-values (((v_55) v21_0))
                    (let-values (((o_22) (if o18_1 o15_1 (1/current-output-port))))
                      (let-values (((quote-depth_0) (if quote-depth19_0 quote-depth16_0 0)))
                        (let-values (((max-length_27) (if max-length20_0 max-length17_0 #f)))
                          (let-values ()
                            (begin
                              (if (1/output-port? o_22)
                                (void)
                                (let-values () (raise-argument-error 'print "output-port?" o_22)))
                              (if ((lambda (v_56)
                                     (let-values (((or-part_40) (eq? v_56 0))) (if or-part_40 or-part_40 (eq? v_56 1))))
                                   quote-depth_0)
                                (void)
                                (let-values () (raise-argument-error 'print "(or/c 0 1)" quote-depth_0)))
                              (if (max-length? max-length_27)
                                (void)
                                (let-values () (raise-argument-error 'print max-length-contract max-length_27)))
                              (dots (p 'print v_55 0 o_22 (sub3 max-length_27)) o_22)
                              (void))))))))))
    (case-lambda
     ((v_57) (print22_0 v_57 #f #f #f #f #f #f))
     ((v_45 o_23 quote-depth_1 max-length17_1) (print22_0 v_45 o_23 quote-depth_1 max-length17_1 #t #t #t))
     ((v_58 o_24 quote-depth16_1) (print22_0 v_58 o_24 quote-depth16_1 #f #t #t #f))
     ((v_33 o15_2) (print22_0 v_33 o15_2 #f #f #t #f #f)))))
 (define-values
  (1/newline)
  (let-values (((newline26_0)
                (lambda (o24_0 o25_0)
                  (let-values (((o_25) (if o25_0 o24_0 (1/current-output-port))))
                    (let-values ()
                      (begin
                        (if (1/output-port? o_25)
                          (void)
                          (let-values () (raise-argument-error 'newline "output-port?" o_25)))
                        (1/write-bytes #"\n" o_25)))))))
    (case-lambda (() (newline26_0 #f #f)) ((o24_1) (newline26_0 o24_1 #t)))))
 (define-values
  (max-length?)
  (lambda (v_59)
    (let-values (((or-part_41) (not v_59)))
      (if or-part_41 or-part_41 (if (exact-nonnegative-integer? v_59) (>= v_59 3) #f)))))
 (define-values (max-length-contract) "(or/c #f (and/c exact-integer? (>=/c 3)))")
 (define-values (sub3) (lambda (n_8) (if n_8 (- n_8 3) #f)))
 (define-values
  (dots)
  (lambda (max-length_28 o_26) (if (eq? max-length_28 'full) (let-values () (1/write-string "..." o_26)) (void))))
 (define-values
  (p)
  (lambda (who_18 v_60 mode_4 o_16 max-length_9)
    (if (eq? max-length_9 'full)
      (let-values () 'full)
      (if (number? v_60)
        (let-values () (write-string/max (number->string v_60) o_16 max-length_9))
        (if (string? v_60)
          (let-values ()
            (let-values (((tmp_12) mode_4))
              (if (equal? tmp_12 #f)
                (let-values () (write-string/max v_60 o_16 max-length_9))
                (let-values () (print-string v_60 o_16 max-length_9)))))
          (if (bytes? v_60)
            (let-values ()
              (let-values (((tmp_13) mode_4))
                (if (equal? tmp_13 #f)
                  (let-values () (write-bytes/max v_60 o_16 max-length_9))
                  (let-values () (print-bytes v_60 o_16 max-length_9)))))
            (if (symbol? v_60)
              (let-values ()
                (let-values (((tmp_14) mode_4))
                  (if (equal? tmp_14 #f)
                    (let-values () (write-string/max (symbol->string v_60) o_16 max-length_9))
                    (let-values () (print-symbol v_60 o_16 max-length_9)))))
              (if (keyword? v_60)
                (let-values ()
                  (let-values (((max-length_29) (write-string/max "#:" o_16 max-length_9)))
                    (let-values (((tmp_15) mode_4))
                      (if (equal? tmp_15 #f)
                        (let-values () (write-string/max (symbol->string v_60) o_16 max-length_29))
                        (let-values () (print-symbol v_60 o_16 max-length_29))))))
                (if (char? v_60)
                  (let-values ()
                    (let-values (((tmp_16) mode_4))
                      (if (equal? tmp_16 #f)
                        (let-values () (write-string/max (string v_60) o_16 max-length_9))
                        (let-values () (print-char v_60 o_16 max-length_9)))))
                  (if (not v_60)
                    (let-values () (write-string/max "#f" o_16 max-length_9))
                    (if (eq? v_60 #t)
                      (let-values () (write-string/max "#t" o_16 max-length_9))
                      (if (pair? v_60)
                        (let-values ()
                          ((letrec-values (((loop_25)
                                            (lambda (v_61 max-length_30)
                                              (if (eq? max-length_30 'full)
                                                (let-values () 'full)
                                                (if (null? (cdr v_61))
                                                  (let-values ()
                                                    (let-values (((max-length_31)
                                                                  (p who_18 (car v_61) mode_4 o_16 max-length_30)))
                                                      (write-string/max ")" o_16 max-length_31)))
                                                  (if (pair? (cdr v_61))
                                                    (let-values ()
                                                      (let-values (((max-length_32)
                                                                    (p who_18 (car v_61) mode_4 o_16 max-length_30)))
                                                        (loop_25 (cdr v_61) (write-string/max " " o_16 max-length_32))))
                                                    (let-values ()
                                                      (let-values (((max-length_33)
                                                                    (p who_18 (car v_61) mode_4 o_16 max-length_30)))
                                                        (let-values (((max-length_34)
                                                                      (write-string/max " . " o_16 max-length_33)))
                                                          (let-values (((max-length_35)
                                                                        (p
                                                                         who_18
                                                                         (cdr v_61)
                                                                         mode_4
                                                                         o_16
                                                                         max-length_34)))
                                                            (write-string/max ")" o_16 max-length_35)))))))))))
                             loop_25)
                           v_60
                           (write-string/max "(" o_16 max-length_9)))
                        (if (1/custom-write? v_60)
                          (let-values ()
                            (let-values (((o_27) (make-output-port/max o_16 max-length_9)))
                              (begin
                                ((custom-write-ref v_60) v_60 o_27 mode_4)
                                (output-port/max-max-length o_27 max-length_9))))
                          (let-values () (write-string/max (format "~s" v_60) o_16 max-length_9)))))))))))))))
 (define-values
  (do-printf)
  (lambda (who_0 o_17 fmt_0 all-args_0)
    (let-values (((len_20) (string-length fmt_0)))
      (let-values (((next_1) (lambda (args_0) (if (pair? args_0) (cdr args_0) #f))))
        (begin
          ((letrec-values (((loop_26)
                            (lambda (i_18 expected-count_0 args_1 error-thunk_0)
                              (if (= i_18 len_20)
                                (let-values ()
                                  (check-conclusions who_0 expected-count_0 args_1 error-thunk_0 fmt_0 args_1))
                                (let-values ()
                                  (let-values (((tmp_17) (string-ref fmt_0 i_18)))
                                    (if (equal? tmp_17 '#\~)
                                      (let-values ()
                                        (let-values (((i_8) (add1 i_18)))
                                          (begin
                                            (if (= i_8 len_20)
                                              (let-values ()
                                                (ill-formed-error who_0 "cannot end in `~`" fmt_0 all-args_0))
                                              (void))
                                            (let-values (((tmp_18) (string-ref fmt_0 i_8)))
                                              (let-values (((index_0)
                                                            (if (char? tmp_18)
                                                              (let-values (((codepoint_0) (char->integer tmp_18)))
                                                                (if (if (unsafe-fx>= codepoint_0 37)
                                                                      (unsafe-fx< codepoint_0 127)
                                                                      #f)
                                                                  (let-values (((tbl_0)
                                                                                '#(1
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   3
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   2
                                                                                   4
                                                                                   5
                                                                                   0
                                                                                   2
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   1
                                                                                   4
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   2
                                                                                   0
                                                                                   0
                                                                                   2
                                                                                   0
                                                                                   4
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   2
                                                                                   4
                                                                                   5
                                                                                   0
                                                                                   2
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   1
                                                                                   4
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   2
                                                                                   0
                                                                                   0
                                                                                   2
                                                                                   0
                                                                                   4
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   0
                                                                                   1)))
                                                                    (unsafe-vector*-ref
                                                                     tbl_0
                                                                     (unsafe-fx- codepoint_0 37)))
                                                                  0))
                                                              0)))
                                                (if (unsafe-fx< index_0 2)
                                                  (if (unsafe-fx< index_0 1)
                                                    (let-values ()
                                                      (if (char-whitespace? (string-ref fmt_0 i_8))
                                                        (let-values ()
                                                          (loop_26 (add1 i_8) expected-count_0 args_1 error-thunk_0))
                                                        (let-values ()
                                                          (ill-formed-error
                                                           who_0
                                                           (string-append
                                                            "tag `~"
                                                            (substring fmt_0 i_8 (add1 i_8))
                                                            "` not allowed")
                                                           fmt_0
                                                           all-args_0))))
                                                    (let-values ()
                                                      (loop_26 (add1 i_8) expected-count_0 args_1 error-thunk_0)))
                                                  (if (unsafe-fx< index_0 3)
                                                    (let-values ()
                                                      (loop_26
                                                       (add1 i_8)
                                                       (add1 expected-count_0)
                                                       (next_1 args_1)
                                                       error-thunk_0))
                                                    (if (unsafe-fx< index_0 4)
                                                      (let-values ()
                                                        (let-values (((i_5) (add1 i_8)))
                                                          (let-values (((bad-dot_0)
                                                                        (lambda ()
                                                                          (ill-formed-error
                                                                           who_0
                                                                           "tag `~.` not followed by `a`, `s`, or `v`"
                                                                           fmt_0
                                                                           all-args_0))))
                                                            (begin
                                                              (if (= i_5 len_20) (let-values () (bad-dot_0)) (void))
                                                              (let-values (((tmp_19) (string-ref fmt_0 i_5)))
                                                                (if (if (equal? tmp_19 '#\a)
                                                                      #t
                                                                      (if (equal? tmp_19 '#\A)
                                                                        #t
                                                                        (if (equal? tmp_19 '#\s)
                                                                          #t
                                                                          (if (equal? tmp_19 '#\S)
                                                                            #t
                                                                            (if (equal? tmp_19 '#\v)
                                                                              #t
                                                                              (equal? tmp_19 '#\V))))))
                                                                  (let-values ()
                                                                    (loop_26
                                                                     (add1 i_5)
                                                                     (add1 expected-count_0)
                                                                     (next_1 args_1)
                                                                     error-thunk_0))
                                                                  (let-values () (bad-dot_0))))))))
                                                      (if (unsafe-fx< index_0 5)
                                                        (let-values ()
                                                          (let-values (((new-error-thunk_0)
                                                                        (if (not error-thunk_0)
                                                                          (if (pair? args_1)
                                                                            (if (let-values (((a_2) (car args_1)))
                                                                                  (let-values (((or-part_42)
                                                                                                (not (number? a_2))))
                                                                                    (if or-part_42
                                                                                      or-part_42
                                                                                      (not (exact? a_2)))))
                                                                              (lambda ()
                                                                                (arg-type-error
                                                                                 who_0
                                                                                 "exact integer"
                                                                                 (car args_1)
                                                                                 fmt_0
                                                                                 args_1))
                                                                              #f)
                                                                            #f)
                                                                          #f)))
                                                            (loop_26
                                                             (add1 i_8)
                                                             (add1 expected-count_0)
                                                             (next_1 args_1)
                                                             new-error-thunk_0)))
                                                        (let-values ()
                                                          (let-values (((new-error-thunk_1)
                                                                        (if (not error-thunk_0)
                                                                          (if (pair? args_1)
                                                                            (if (not (char? (car args_1)))
                                                                              (lambda ()
                                                                                (arg-type-error
                                                                                 who_0
                                                                                 "character"
                                                                                 (car args_1)
                                                                                 fmt_0
                                                                                 args_1))
                                                                              #f)
                                                                            #f)
                                                                          #f)))
                                                            (loop_26
                                                             (add1 i_8)
                                                             (add1 expected-count_0)
                                                             (next_1 args_1)
                                                             new-error-thunk_1))))))))))))
                                      (let-values () (loop_26 (add1 i_18) expected-count_0 args_1 error-thunk_0)))))))))
             loop_26)
           0
           0
           all-args_0
           #f)
          ((letrec-values (((loop_2)
                            (lambda (start-i_1 i_16 args_2)
                              (if (= i_16 len_20)
                                (let-values () (1/write-string fmt_0 o_17 start-i_1 i_16))
                                (let-values ()
                                  (let-values (((tmp_20) (string-ref fmt_0 i_16)))
                                    (if (equal? tmp_20 '#\~)
                                      (let-values ()
                                        (let-values (((next_2)
                                                      (lambda (i_19 args_3)
                                                        (let-values (((i_20) (add1 i_19))) (loop_2 i_20 i_20 args_3)))))
                                          (begin
                                            (1/write-string fmt_0 o_17 start-i_1 i_16)
                                            (let-values (((i_14) (add1 i_16)))
                                              (let-values (((tmp_21) (string-ref fmt_0 i_14)))
                                                (let-values (((index_1)
                                                              (if (char? tmp_21)
                                                                (let-values (((codepoint_1) (char->integer tmp_21)))
                                                                  (if (if (unsafe-fx>= codepoint_1 37)
                                                                        (unsafe-fx< codepoint_1 127)
                                                                        #f)
                                                                    (let-values (((tbl_1)
                                                                                  '#(2
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     6
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     3
                                                                                     9
                                                                                     10
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     2
                                                                                     8
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     4
                                                                                     0
                                                                                     0
                                                                                     5
                                                                                     0
                                                                                     7
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     3
                                                                                     9
                                                                                     10
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     2
                                                                                     8
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     4
                                                                                     0
                                                                                     0
                                                                                     5
                                                                                     0
                                                                                     7
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     0
                                                                                     1)))
                                                                      (unsafe-vector*-ref
                                                                       tbl_1
                                                                       (unsafe-fx- codepoint_1 37)))
                                                                    0))
                                                                0)))
                                                  (if (unsafe-fx< index_1 5)
                                                    (if (unsafe-fx< index_1 2)
                                                      (if (unsafe-fx< index_1 1)
                                                        (let-values ()
                                                          (if (char-whitespace? (string-ref fmt_0 i_14))
                                                            (let-values ()
                                                              ((letrec-values (((ws-loop_0)
                                                                                (lambda (i_21 saw-newline?_0)
                                                                                  (if (= i_21 len_20)
                                                                                    (let-values ()
                                                                                      (loop_2 i_21 i_21 args_2))
                                                                                    (let-values ()
                                                                                      (let-values (((c_9)
                                                                                                    (string-ref
                                                                                                     fmt_0
                                                                                                     i_21)))
                                                                                        (let-values (((tmp_22) c_9))
                                                                                          (if (equal? tmp_22 '#\n)
                                                                                            (let-values ()
                                                                                              (if saw-newline?_0
                                                                                                (loop_2
                                                                                                 i_21
                                                                                                 i_21
                                                                                                 args_2)
                                                                                                (ws-loop_0
                                                                                                 (add1 i_21)
                                                                                                 #t)))
                                                                                            (if (equal? tmp_22 '#\r)
                                                                                              (let-values ()
                                                                                                (if saw-newline?_0
                                                                                                  (loop_2
                                                                                                   i_21
                                                                                                   i_21
                                                                                                   args_2)
                                                                                                  (ws-loop_0
                                                                                                   (if (if (<
                                                                                                            (add1 i_21)
                                                                                                            len_20)
                                                                                                         (char=?
                                                                                                          '#\n
                                                                                                          (string-ref
                                                                                                           fmt_0
                                                                                                           (add1 i_21)))
                                                                                                         #f)
                                                                                                     (+ i_21 2)
                                                                                                     (add1 i_21))
                                                                                                   #t)))
                                                                                              (let-values ()
                                                                                                (if (char-whitespace?
                                                                                                     (string-ref
                                                                                                      fmt_0
                                                                                                      i_21))
                                                                                                  (ws-loop_0
                                                                                                   (add1 i_21)
                                                                                                   saw-newline?_0)
                                                                                                  (loop_2
                                                                                                   i_21
                                                                                                   i_21
                                                                                                   args_2))))))))))))
                                                                 ws-loop_0)
                                                               i_14
                                                               #f))
                                                            (void)))
                                                        (let-values ()
                                                          (begin (1/write-string "~" o_17) (next_2 i_14 args_2))))
                                                      (if (unsafe-fx< index_1 3)
                                                        (let-values ()
                                                          (begin (1/write-string "\n" o_17) (next_2 i_14 args_2)))
                                                        (if (unsafe-fx< index_1 4)
                                                          (let-values ()
                                                            (begin
                                                              (1/display (car args_2) o_17)
                                                              (next_2 i_14 (cdr args_2))))
                                                          (let-values ()
                                                            (begin
                                                              (1/write (car args_2) o_17)
                                                              (next_2 i_14 (cdr args_2)))))))
                                                    (if (unsafe-fx< index_1 7)
                                                      (if (unsafe-fx< index_1 6)
                                                        (let-values ()
                                                          (begin
                                                            (1/print (car args_2) o_17)
                                                            (next_2 i_14 (cdr args_2))))
                                                        (let-values ()
                                                          (let-values (((i_22) (add1 i_14)))
                                                            (let-values (((tmp_23) (string-ref fmt_0 i_22)))
                                                              (if (if (equal? tmp_23 '#\a) #t (equal? tmp_23 '#\A))
                                                                (let-values ()
                                                                  (begin
                                                                    (1/display (car args_2) o_17 (error-print-width))
                                                                    (next_2 i_22 (cdr args_2))))
                                                                (if (if (equal? tmp_23 '#\s) #t (equal? tmp_23 '#\S))
                                                                  (let-values ()
                                                                    (begin
                                                                      (1/write (car args_2) o_17 (error-print-width))
                                                                      (next_2 i_22 (cdr args_2))))
                                                                  (if (if (equal? tmp_23 '#\v) #t (equal? tmp_23 '#\V))
                                                                    (let-values ()
                                                                      (begin
                                                                        (1/print
                                                                         (car args_2)
                                                                         o_17
                                                                         0
                                                                         (error-print-width))
                                                                        (next_2 i_22 (cdr args_2))))
                                                                    (let-values () (void)))))))))
                                                      (if (unsafe-fx< index_1 8)
                                                        (let-values ()
                                                          (begin
                                                            (1/write-string (number->string (car args_2) 16) o_17)
                                                            (next_2 i_14 (cdr args_2))))
                                                        (if (unsafe-fx< index_1 9)
                                                          (let-values ()
                                                            (begin
                                                              (1/write-string (number->string (car args_2) 8) o_17)
                                                              (next_2 i_14 (cdr args_2))))
                                                          (if (unsafe-fx< index_1 10)
                                                            (let-values ()
                                                              (begin
                                                                (1/write-string (number->string (car args_2) 2) o_17)
                                                                (next_2 i_14 (cdr args_2))))
                                                            (let-values ()
                                                              (begin
                                                                (1/write-string (string (car args_2)) o_17)
                                                                (next_2 i_14 (cdr args_2)))))))))))))))
                                      (let-values () (loop_2 start-i_1 (add1 i_16) args_2)))))))))
             loop_2)
           0
           0
           all-args_0)
          (void))))))
 (define-values (raise-error) (lambda (str_47) (raise (exn:fail:contract str_47 (current-continuation-marks)))))
 (define-values
  (check-conclusions)
  (lambda (who_19 expected-count_1 args_4 error-thunk_1 fmt_1 all-args_1)
    (begin
      (if (null? args_4)
        (void)
        (let-values ()
          (raise-error
           (string-append
            (symbol->string who_19)
            ": "
            "format string requires "
            (number->string expected-count_1)
            " arguments, given "
            (number->string (length all-args_1))
            (arguments->string (cons fmt_1 all-args_1))))))
      (if error-thunk_1 (let-values () (error-thunk_1)) (void)))))
 (define-values
  (ill-formed-error)
  (lambda (who_20 explanation_0 fmt_2 args_5)
    (raise-error
     (string-append
      (symbol->string who_20)
      ": "
      "ill-formed pattern string\n"
      "  explanation: "
      explanation_0
      (arguments->string (cons fmt_2 args_5))))))
 (define-values
  (arg-type-error)
  (lambda (who_21 what_0 val_0 fmt_3 args_6)
    (raise-error
     (string-append
      (symbol->string who_21)
      ": "
      "format string requires a "
      what_0
      ", given something else\n"
      "  bad argument: "
      (value->string val_0)
      (arguments->string (cons fmt_3 args_6))))))
 (define-values (value->string) (lambda (v_62) ((error-value->string-handler) v_62 (error-print-width))))
 (define-values (arguments->string) (lambda (args_7) ""))
 (define-values
  (1/format)
  (lambda (fmt_4 . args_8)
    (let-values ((()
                  (begin
                    (if (string? fmt_4) (void) (let-values () (raise-argument-error 'format "string?" fmt_4)))
                    (values))))
      (let-values (((o_28) (1/open-output-string)))
        (begin (do-printf 'printf o_28 fmt_4 args_8) (1/get-output-string o_28))))))
 (define-values
  (1/printf)
  (lambda (fmt_5 . args_9)
    (begin
      (if (string? fmt_5) (void) (let-values () (raise-argument-error 'printf "string?" fmt_5)))
      (do-printf 'printf (1/current-output-port) fmt_5 args_9))))
 (define-values
  (1/fprintf)
  (lambda (o_29 fmt_6 . args_10)
    (begin
      (if (1/output-port? o_29) (void) (let-values () (raise-argument-error 'fprintf "output-port?" o_29)))
      (if (string? fmt_6) (void) (let-values () (raise-argument-error 'fprintf "string?" fmt_6)))
      (do-printf 'fprintf o_29 fmt_6 args_10))))
 (define-values
  (1/error)
  (lambda (init_0 . args_8)
    (if (if (symbol? init_0) (null? args_8) #f)
      (let-values () (raise (exn:fail (format "error: ~a" init_0) (current-continuation-marks))))
      (if (symbol? init_0)
        (let-values ()
          (let-values ((()
                        (begin
                          (if (string? (car args_8))
                            (void)
                            (let-values () (raise-argument-error 'error "string?" (car args_8))))
                          (values))))
            (let-values (((o_28) (1/open-output-string)))
              (begin
                (do-printf 'error o_28 (car args_8) (cdr args_8))
                (raise
                 (exn:fail
                  (string-append (symbol->string init_0) ": " (1/get-output-string o_28))
                  (current-continuation-marks)))))))
        (if (string? init_0)
          (let-values ()
            (raise
             (exn:fail
              (apply
               string-append
               init_0
               (let-values (((lst_0) args_8))
                 (begin
                   (check-list lst_0)
                   ((letrec-values (((for-loop_4)
                                     (lambda (lst_1)
                                       (if (pair? lst_1)
                                         (let-values (((arg_0) (unsafe-car lst_1)) ((rest_0) (unsafe-cdr lst_1)))
                                           (let-values (((post-guard-var_0) (lambda () #t)))
                                             (let-values ()
                                               (let-values (((elem_0)
                                                             (let-values ()
                                                               (let-values ()
                                                                 (string-append
                                                                  " "
                                                                  ((error-value->string-handler)
                                                                   arg_0
                                                                   (error-print-width)))))))
                                                 (let-values (((result_6)
                                                               (if (post-guard-var_0) (for-loop_4 rest_0) null)))
                                                   (cons elem_0 result_6))))))
                                         null))))
                      for-loop_4)
                    lst_0))))
              (current-continuation-marks))))
          (let-values () (raise-argument-error 'error "(or/c symbol? string?)" init_0)))))))
 (void
  (error-value->string-handler
   (lambda (v_63 len_3)
     (let-values ((()
                   (begin
                     (if (exact-nonnegative-integer? len_3)
                       (void)
                       (let-values ()
                         (raise-argument-error
                          'default-error-value->string-handler
                          "exact-nonnegative-integer?"
                          len_3)))
                     (values))))
       (let-values (((o_30) (1/open-output-string)))
         (begin (1/print v_63 o_30 0 len_3) (1/get-output-string o_30))))))))
