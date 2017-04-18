(export (rename (1/wrap-evt wrap-evt)
                (1/sync sync)
                (1/current-thread-group current-thread-group)
                (guard-evt guard-evt)
                (call-in-main-thread call-in-main-thread)
                (the-always-evt always-evt)
                (1/thread-wait thread-wait)
                (make-thread thread)
                (1/thread-running? thread-running?)
                (1/thread? thread?)
                (1/make-thread-group make-thread-group)
                (the-never-evt never-evt)
                (1/semaphore-peek-evt semaphore-peek-evt)
                (1/semaphore? semaphore?)
                (1/make-semaphore make-semaphore)
                (1/semaphore-peek-evt? semaphore-peek-evt?)
                (1/break-enabled-key break-enabled-key)
                (1/handle-evt handle-evt)
                (1/prop:evt prop:evt)
                (1/channel? channel?)
                (1/evt? evt?)
                (channel-get channel-get)
                (1/semaphore-wait semaphore-wait)
                (get-thread-dead-evt thread-dead-evt)
                (get-system-idle-evt system-idle-evt)
                (channel-put channel-put)
                (1/check-for-break check-for-break)
                (1/sleep sleep)
                (1/break-thread break-thread)
                (1/semaphore-post semaphore-post)
                (1/make-channel make-channel)
                (1/thread-dead? thread-dead?)
                (1/sync/timeout sync/timeout)
                (1/channel-put-evt channel-put-evt)
                (1/thread-suspend thread-suspend)
                (1/nack-guard-evt nack-guard-evt)
                (1/current-thread current-thread)
                (1/thread-group? thread-group?)))
(define hash3712 (hasheq))
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
       (let ((app_3813 make-range))
         (let ((app_3814
                (let ((app_3809 (|#%app| range-ref v_5 1)))
                  (|#%app| app_3809 (|#%app| range-ref v_5 0)))))
           (let ((app_3815 (|#%app| range-ref v_5 1)))
             (|#%app|
              app_3813
              app_3814
              app_3815
              (|#%app| range-ref v_5 2))))))))
   (cons
    prop:gen-sequence
    (lambda (v_6)
      (let ((app_3820 (|#%app| range-ref v_6 1)))
        (let ((app_3821 (|#%app| range-ref v_6 0)))
          (values
           values
           #f
           app_3820
           app_3821
           (|#%app| range-ref v_6 2)
           #f
           #f))))))))
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
       (let ((app_3830 make-list-stream))
         (|#%app| app_3830 (cdr (|#%app| list-stream-ref v_9 0)))))))
   (cons
    prop:gen-sequence
    (lambda (v_10)
      (values car cdr values (|#%app| list-stream-ref v_10 0) pair? #f #f))))))
(define check-list
  (lambda (l_0)
    (if (list? l_0) (void) (raise-argument-error 'in-list "list?" l_0))))
(define check-in-hash-keys
  (lambda (ht_0)
    (if ((lambda (ht_1) (hash? ht_1)) ht_0)
      (void)
      (raise-argument-error 'in-hash-keys "hash?" ht_0))))
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
     (lambda (v_11) (|#%app| (|#%app| do-stream-ref v_11 0)))
     (lambda (v_12) (|#%app| (|#%app| do-stream-ref v_12 1)))
     (lambda (v_13) (|#%app| (|#%app| do-stream-ref v_13 2))))))))
(define empty-stream (make-do-stream (lambda () #t) void void))
(define no-empty-edge-table (make-hash))
(define internal-error
  (lambda (s_0)
    (raise
     (let ((app_3840 (string-append "internal error: " s_0)))
       (exn:fail app_3840 (current-continuation-marks))))))
(define-values
 (make-engine engine-block engine-return root-continuation-prompt-tag)
 (let ((ht_2 (|#%app| primitive-table '|#%engine|)))
   (begin
     (if ht_2 (void) (internal-error "engines not provided by host"))
     (let ((app_3843 (hash-ref ht_2 'make-engine)))
       (let ((app_3844 (hash-ref ht_2 'engine-block)))
         (let ((app_3845 (hash-ref ht_2 'engine-return)))
           (values
            app_3843
            app_3844
            app_3845
            (hash-ref ht_2 'root-continuation-prompt-tag))))))))
(define struct:node$2
  (make-record-type-descriptor
   'node
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1) (mutable f2) (mutable f3) (mutable f4))))
(define g3847
  (struct-type-install-properties!
   struct:node$2
   'node
   5
   0
   #f
   null
   #f
   #f
   '(0 1 2 3 4)
   #f
   'node))
(define node1.1
  (record-constructor
   (make-record-constructor-descriptor struct:node$2 #f #f)))
(define node?$2 (record-predicate struct:node$2))
(define node-key (record-accessor struct:node$2 0))
(define node-val (record-accessor struct:node$2 1))
(define node-height (record-accessor struct:node$2 2))
(define node-left (record-accessor struct:node$2 3))
(define node-right (record-accessor struct:node$2 4))
(define empty-tree #f)
(define is-empty? (lambda (t_0) (not t_0)))
(define tree-height (lambda (t_1) (if (not t_1) 0 (node-height t_1))))
(define tree-balance
  (lambda (t_2)
    (let ((app_3850 (tree-height (node-left t_2))))
      (- app_3850 (tree-height (node-right t_2))))))
(define combine
  (lambda (key_0 val_0 left_0 right_0)
    (node1.1
     key_0
     val_0
     (add1
      (let ((app_3852 (tree-height left_0)))
        (max app_3852 (tree-height right_0))))
     left_0
     right_0)))
(define reverse-combine
  (lambda (key_1 val_1 right_1 left_1) (combine key_1 val_1 left_1 right_1)))
(define lookup
  (lambda (t_3 key_2 <?_0)
    (if (not t_3)
      #f
      (if (|#%app| <?_0 key_2 (node-key t_3))
        (lookup (node-left t_3) key_2 <?_0)
        (if (|#%app| <?_0 (node-key t_3) key_2)
          (lookup (node-right t_3) key_2 <?_0)
          (node-val t_3))))))
(define insert
  (lambda (t_4 key_3 val_2 <?_1)
    (if (not t_4)
      (combine key_3 val_2 #f #f)
      (if (|#%app| <?_1 key_3 (node-key t_4))
        (insert-to t_4 key_3 val_2 <?_1 node-left node-right combine)
        (if (|#%app| <?_1 (node-key t_4) key_3)
          (insert-to t_4 key_3 val_2 <?_1 node-right node-left reverse-combine)
          t_4)))))
(define insert-to
  (lambda (t_5 new-key_0 new-val_0 <?_2 node-to_0 node-other_0 comb_0)
    (let ((new-to_0 (insert (|#%app| node-to_0 t_5) new-key_0 new-val_0 <?_2)))
      (let ((new-other_0 (|#%app| node-other_0 t_5)))
        (let ((new-t_0
               (let ((app_3863 (node-key t_5)))
                 (|#%app|
                  comb_0
                  app_3863
                  (node-val t_5)
                  new-to_0
                  new-other_0))))
          (check-rotate new-t_0 node-to_0 node-other_0 comb_0))))))
(define check-rotate
  (lambda (new-t_1 node-to_1 node-other_1 comb_1)
    (let ((new-to_1 (|#%app| node-to_1 new-t_1)))
      (let ((new-other_1 (|#%app| node-other_1 new-t_1)))
        (let ((to-height_0 (tree-height new-to_1)))
          (let ((other-height_0 (tree-height new-other_1)))
            (if (= (- to-height_0 other-height_0) 2)
              (rotate new-t_1 node-to_1 node-other_1 comb_1)
              new-t_1)))))))
(define rotate
  (lambda (t_6 node-to_2 node-other_2 comb_2)
    (let ((to_0 (|#%app| node-to_2 t_6)))
      (let ((to-balance_0
             (let ((app_3868 (tree-height (|#%app| node-to_2 to_0))))
               (- app_3868 (tree-height (|#%app| node-other_2 to_0))))))
        (if (negative? to-balance_0)
          (double-rotate t_6 node-to_2 node-other_2 comb_2)
          (single-rotate t_6 node-to_2 node-other_2 comb_2))))))
(define double-rotate
  (lambda (t_7 node-to_3 node-other_3 comb_3)
    (let ((orange_0 (|#%app| node-to_3 t_7)))
      (let ((yellow_0 (|#%app| node-other_3 orange_0)))
        (let ((A_0 (|#%app| node-to_3 orange_0)))
          (let ((B_0 (|#%app| node-to_3 yellow_0)))
            (let ((C_0 (|#%app| node-other_3 yellow_0)))
              (let ((D_0 (|#%app| node-other_3 t_7)))
                (single-rotate
                 (let ((app_3875 (node-key t_7)))
                   (let ((app_3876 (node-val t_7)))
                     (|#%app|
                      comb_3
                      app_3875
                      app_3876
                      (let ((app_3872 (node-key yellow_0)))
                        (let ((app_3873 (node-val yellow_0)))
                          (|#%app|
                           comb_3
                           app_3872
                           app_3873
                           (let ((app_3870 (node-key orange_0)))
                             (|#%app|
                              comb_3
                              app_3870
                              (node-val orange_0)
                              A_0
                              B_0))
                           C_0)))
                      D_0)))
                 node-to_3
                 node-other_3
                 comb_3)))))))))
(define single-rotate
  (lambda (t_8 node-to_4 node-other_4 comb_4)
    (let ((yellow_1 (|#%app| node-to_4 t_8)))
      (let ((app_3883 (node-key yellow_1)))
        (let ((app_3884 (node-val yellow_1)))
          (let ((app_3885 (|#%app| node-to_4 yellow_1)))
            (|#%app|
             comb_4
             app_3883
             app_3884
             app_3885
             (let ((app_3879 (node-key t_8)))
               (let ((app_3880 (node-val t_8)))
                 (let ((app_3881 (|#%app| node-other_4 yellow_1)))
                   (|#%app|
                    comb_4
                    app_3879
                    app_3880
                    app_3881
                    (|#%app| node-other_4 t_8))))))))))))
(define delete
  (lambda (t_9 key_4 <?_3)
    (if (not t_9)
      #f
      (if (|#%app| <?_3 key_4 (node-key t_9))
        (delete-at t_9 key_4 <?_3 node-left node-right combine reverse-combine)
        (if (|#%app| <?_3 (node-key t_9) key_4)
          (delete-at
           t_9
           key_4
           <?_3
           node-right
           node-left
           reverse-combine
           combine)
          (if (not (node-left t_9))
            (node-right t_9)
            (if (not (node-right t_9))
              (node-left t_9)
              (call-with-values
               (lambda () (max-key+value (node-left t_9)))
               (case-lambda
                ((move-key_0 move-val_0)
                 (begin
                   (let ((new-left_0 (delete (node-left t_9) move-key_0 <?_3)))
                     (let ((new-t_2
                            (combine
                             move-key_0
                             move-val_0
                             new-left_0
                             (node-right t_9))))
                       (let ((balance_0 (tree-balance new-t_2)))
                         (if (= balance_0 -2)
                           (check-rotate
                            new-t_2
                            node-right
                            node-left
                            reverse-combine)
                           (check-rotate
                            new-t_2
                            node-left
                            node-right
                            combine)))))))
                (args
                 (raise-result-arity-error
                  '(move-key_0 move-val_0)
                  args)))))))))))
(define delete-at
  (lambda (t_10 key_5 <?_4 node-to_5 node-from_0 combine_0 reverse-combine_0)
    (let ((new-to_2 (delete (|#%app| node-to_5 t_10) key_5 <?_4)))
      (if (eq? new-to_2 (|#%app| node-to_5 t_10))
        t_10
        (check-rotate
         (let ((app_3896 (node-key t_10)))
           (let ((app_3897 (node-val t_10)))
             (|#%app|
              combine_0
              app_3896
              app_3897
              new-to_2
              (|#%app| node-from_0 t_10))))
         node-from_0
         node-to_5
         reverse-combine_0)))))
(define min-key+value
  (lambda (t_11)
    (if (not (node-left t_11))
      (let ((app_3901 (node-key t_11))) (values app_3901 (node-val t_11)))
      (min-key+value (node-left t_11)))))
(define max-key+value
  (lambda (t_12)
    (if (not (node-right t_12))
      (let ((app_3905 (node-key t_12))) (values app_3905 (node-val t_12)))
      (max-key+value (node-right t_12)))))
(define 1/thread #f)
(define 1/current-thread
  (case-lambda (() 1/thread) ((v_14) (set! 1/thread v_14))))
(define-values (1/prop:evt 1/evt? evt-ref) (make-struct-type-property 'evt))
(define struct:poller
  (make-record-type-descriptor 'poller #f #f #f #f '#((mutable f0))))
(define g3908
  (struct-type-install-properties!
   struct:poller
   'poller
   1
   0
   #f
   null
   (current-inspector)
   #f
   '(0)
   #f
   'poller))
(define poller1.1
  (record-constructor
   (make-record-constructor-descriptor struct:poller #f #f)))
(define poller? (record-predicate struct:poller))
(define poller-proc (record-accessor struct:poller 0))
(define struct:poll-ctx
  (make-record-type-descriptor
   'poll-ctx
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1) (mutable f2))))
(define g3909
  (struct-type-install-properties!
   struct:poll-ctx
   'poll-ctx
   3
   0
   #f
   null
   (current-inspector)
   #f
   '(0 1 2)
   #f
   'poll-ctx))
(define poll-ctx2.1
  (record-constructor
   (make-record-constructor-descriptor struct:poll-ctx #f #f)))
(define poll-ctx? (record-predicate struct:poll-ctx))
(define poll-ctx-poll? (record-accessor struct:poll-ctx 0))
(define poll-ctx-select-proc (record-accessor struct:poll-ctx 1))
(define poll-ctx-sched-info (record-accessor struct:poll-ctx 2))
(define struct:never-evt
  (make-record-type-descriptor 'never-evt #f #f #f #f '#()))
(define g3910
  (struct-type-install-properties!
   struct:never-evt
   'never-evt
   0
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1 (lambda (self_0 poll-ctx_0) (values #f self_0)))))
   (current-inspector)
   #f
   '()
   #f
   'never-evt))
(define never-evt3.1
  (record-constructor
   (make-record-constructor-descriptor struct:never-evt #f #f)))
(define never-evt? (record-predicate struct:never-evt))
(define the-never-evt (never-evt3.1))
(define struct:always-evt
  (make-record-type-descriptor 'always-evt #f #f #f #f '#()))
(define g3913
  (struct-type-install-properties!
   struct:always-evt
   'always-evt
   0
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1 (lambda (self_1 poll-ctx_1) (values (list self_1) #f)))))
   (current-inspector)
   #f
   '()
   #f
   'always-evt))
(define always-evt4.1
  (record-constructor
   (make-record-constructor-descriptor struct:always-evt #f #f)))
(define always-evt? (record-predicate struct:always-evt))
(define the-always-evt (always-evt4.1))
(define struct:async-evt
  (make-record-type-descriptor 'async-evt #f #f #f #f '#()))
(define g3916
  (struct-type-install-properties!
   struct:async-evt
   'async-evt
   0
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1 (lambda (self_2 poll-ctx_2) (values #f self_2)))))
   (current-inspector)
   #f
   '()
   #f
   'async-evt))
(define async-evt5.1
  (record-constructor
   (make-record-constructor-descriptor struct:async-evt #f #f)))
(define async-evt? (record-predicate struct:async-evt))
(define the-async-evt (async-evt5.1))
(define struct:wrap-evt
  (make-record-type-descriptor
   'wrap-evt
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1))))
(define g3919
  (struct-type-install-properties!
   struct:wrap-evt
   'wrap-evt
   2
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1 (lambda (self_3 poll-ctx_3) (values #f self_3)))))
   (current-inspector)
   #f
   '(0 1)
   #f
   'wrap-evt))
(define wrap-evt6.1
  (record-constructor
   (make-record-constructor-descriptor struct:wrap-evt #f #f)))
(define wrap-evt? (record-predicate struct:wrap-evt))
(define wrap-evt-evt (record-accessor struct:wrap-evt 0))
(define wrap-evt-wrap (record-accessor struct:wrap-evt 1))
(define struct:handle-evt
  (make-record-type-descriptor 'handle-evt struct:wrap-evt #f #f #f '#()))
(define g3922
  (struct-type-install-properties!
   struct:handle-evt
   'handle-evt
   0
   0
   struct:wrap-evt
   null
   (current-inspector)
   #f
   '()
   #f
   'handle-evt))
(define handle-evt7.1
  (record-constructor
   (make-record-constructor-descriptor struct:handle-evt #f #f)))
(define 1/handle-evt? (record-predicate struct:handle-evt))
(define struct:nack-evt
  (make-record-type-descriptor
   'nack-evt
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1))))
(define g3923
  (struct-type-install-properties!
   struct:nack-evt
   'nack-evt
   2
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1 (lambda (self_4 poll-ctx_4) (values #f self_4)))))
   (current-inspector)
   #f
   '(0 1)
   #f
   'nack-evt))
(define nack-evt8.1
  (record-constructor
   (make-record-constructor-descriptor struct:nack-evt #f #f)))
(define nack-evt? (record-predicate struct:nack-evt))
(define nack-evt-evt (record-accessor struct:nack-evt 0))
(define nack-evt-nack-proc (record-accessor struct:nack-evt 1))
(define struct:guard-evt
  (make-record-type-descriptor 'guard-evt #f #f #f #f '#((mutable f0))))
(define g3926
  (struct-type-install-properties!
   struct:guard-evt
   'guard-evt
   1
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1 (lambda (self_5 poll-ctx_5) (values #f self_5)))))
   (current-inspector)
   #f
   '(0)
   #f
   'guard-evt))
(define guard-evt9.1
  (record-constructor
   (make-record-constructor-descriptor struct:guard-evt #f #f)))
(define guard-evt? (record-predicate struct:guard-evt))
(define guard-evt-proc (record-accessor struct:guard-evt 0))
(define evt-poll
  (lambda (evt_0 poll-ctx_6)
    (let ((v_15 (evt-ref evt_0)))
      (let ((v_16 (if (fixnum? v_15) (unsafe-struct-ref evt_0 v_15) v_15)))
        (let ((v_17 (if (procedure? v_16) (|#%app| v_16 evt_0) v_16)))
          (if (1/evt? v_17)
            (values #f v_17)
            (if (poller? v_17)
              (|#%app| (poller-proc v_17) evt_0 poll-ctx_6)
              (values #f never-evt3.1))))))))
(define-values
 (prop:waiter waiter? waiter-ref)
 (make-struct-type-property 'waiter))
(define struct:waiter-methods
  (make-record-type-descriptor
   'waiter-methods
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1))))
(define g3930
  (struct-type-install-properties!
   struct:waiter-methods
   'waiter-methods
   2
   0
   #f
   null
   (current-inspector)
   #f
   '(0 1)
   #f
   'waiter-methods))
(define waiter-methods1.1
  (record-constructor
   (make-record-constructor-descriptor struct:waiter-methods #f #f)))
(define waiter-methods? (record-predicate struct:waiter-methods))
(define waiter-methods-suspend (record-accessor struct:waiter-methods 0))
(define waiter-methods-resume (record-accessor struct:waiter-methods 1))
(define make-waiter-methods6.1
  (lambda (resume!3_0 suspend!2_0)
    (let ((suspend_0 suspend!2_0))
      (let ((resume_0 resume!3_0)) (waiter-methods1.1 suspend_0 resume_0)))))
(define waiter-resume!
  (lambda (w_0 s_1)
    (|#%app| (waiter-methods-resume (waiter-ref w_0)) w_0 s_1)))
(define waiter-suspend!
  (lambda (w_1 cb_0)
    (|#%app| (waiter-methods-suspend (waiter-ref w_1)) w_1 cb_0)))
(define struct:select-waiter
  (make-record-type-descriptor 'select-waiter #f #f #f #f '#((mutable f0))))
(define g3935
  (struct-type-install-properties!
   struct:select-waiter
   'select-waiter
   1
   0
   #f
   (list
    (cons
     prop:waiter
     (let ((void12_0 void))
       (let ((temp13_0
              (lambda (w_2 s_2) (|#%app| (|#%app| select-waiter-proc w_2)))))
         (make-waiter-methods6.1 temp13_0 void12_0)))))
   (current-inspector)
   #f
   '(0)
   #f
   'select-waiter))
(define select-waiter9.1
  (record-constructor
   (make-record-constructor-descriptor struct:select-waiter #f #f)))
(define select-waiter? (record-predicate struct:select-waiter))
(define select-waiter-proc (record-accessor struct:select-waiter 0))
(define atomic 0)
(define current-atomic (case-lambda (() atomic) ((v_18) (set! atomic v_18))))
(define start-atomic (lambda () (current-atomic (add1 (current-atomic)))))
(define end-atomic (lambda () (current-atomic (sub1 (current-atomic)))))
(define struct:queue
  (make-record-type-descriptor
   'queue
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1))))
(define g3944
  (struct-type-install-properties!
   struct:queue
   'queue
   2
   0
   #f
   null
   (current-inspector)
   #f
   '()
   #f
   'queue))
(define queue1.1
  (record-constructor (make-record-constructor-descriptor struct:queue #f #f)))
(define queue? (record-predicate struct:queue))
(define queue-start (record-accessor struct:queue 0))
(define queue-end (record-accessor struct:queue 1))
(define set-queue-start! (record-mutator struct:queue 0))
(define set-queue-end! (record-mutator struct:queue 1))
(define struct:node$1
  (make-record-type-descriptor
   'node
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1) (mutable f2))))
(define g3945
  (struct-type-install-properties!
   struct:node$1
   'node
   3
   0
   #f
   null
   (current-inspector)
   #f
   '(0)
   #f
   'node))
(define node2.1$1
  (record-constructor
   (make-record-constructor-descriptor struct:node$1 #f #f)))
(define node?$1 (record-predicate struct:node$1))
(define node-waiter (record-accessor struct:node$1 0))
(define node-prev$1 (record-accessor struct:node$1 1))
(define node-next$1 (record-accessor struct:node$1 2))
(define set-node-prev!$1 (record-mutator struct:node$1 1))
(define set-node-next!$1 (record-mutator struct:node$1 2))
(define make-queue (lambda () (queue1.1 #f #f)))
(define queue-empty? (lambda (q_0) (not (queue-start q_0))))
(define queue-remove!
  (lambda (q_1)
    (let ((qs_0 (queue-start q_1)))
      (if (not qs_0)
        #f
        (let ((n_0 (node-next$1 qs_0)))
          (begin
            (set-queue-start! q_1 n_0)
            (if n_0 (set-node-prev!$1 n_0 #f) (set-queue-end! q_1 #f))
            (node-waiter qs_0)))))))
(define queue-fremove!
  (lambda (q_2 pred_0)
    ((letrec*
      ((loop_0
        (lambda (qs_1)
          (if qs_1
            (let ((w_3 (node-waiter qs_1)))
              (if (|#%app| pred_0 w_3)
                (begin (queue-remove-node! q_2 qs_1) w_3)
                (loop_0 (node-next$1 qs_1))))
            #f))))
      loop_0)
     (queue-start q_2))))
(define queue-remove-all!
  (lambda (q_3 proc_0)
    (begin
      ((letrec*
        ((loop_1
          (lambda (qs_2)
            (if qs_2
              (begin
                (|#%app| proc_0 (node-waiter qs_2))
                (loop_1 (node-next$1 qs_2)))
              (void)))))
        loop_1)
       (queue-start q_3))
      (set-queue-start! q_3 #f)
      (set-queue-end! q_3 #f))))
(define queue-add!
  (lambda (q_4 w_4)
    (let ((e_0 (queue-end q_4)))
      (let ((n_1 (node2.1$1 w_4 e_0 #f)))
        (begin
          (if (not e_0)
            (begin (set-queue-start! q_4 n_1) (set-queue-end! q_4 n_1))
            (begin (set-node-next!$1 e_0 n_1) (set-node-prev!$1 n_1 e_0)))
          n_1)))))
(define queue-remove-node!
  (lambda (q_5 n_2)
    (begin
      (if (node-prev$1 n_2)
        (let ((app_3952 (node-prev$1 n_2)))
          (set-node-next!$1 app_3952 (node-next$1 n_2)))
        (set-queue-start! q_5 (node-next$1 n_2)))
      (if (node-next$1 n_2)
        (let ((app_3955 (node-next$1 n_2)))
          (set-node-prev!$1 app_3955 (node-prev$1 n_2)))
        (set-queue-end! q_5 (node-prev$1 n_2))))))
(define struct:semaphore
  (make-record-type-descriptor
   'semaphore
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1))))
(define g3958
  (struct-type-install-properties!
   struct:semaphore
   'semaphore
   2
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1
      (lambda (s_3 poll-ctx_7)
        (let ((s18_0 s_3))
          (let ((poll-ctx19_0 poll-ctx_7))
            (|#%app|
             semaphore-wait/poll14.1
             #f
             #f
             #f
             #f
             s18_0
             poll-ctx19_0)))))))
   (current-inspector)
   #f
   '(1)
   #f
   'semaphore))
(define semaphore1.1
  (record-constructor
   (make-record-constructor-descriptor struct:semaphore #f #f)))
(define 1/semaphore? (record-predicate struct:semaphore))
(define semaphore-count (record-accessor struct:semaphore 0))
(define semaphore-queue (record-accessor struct:semaphore 1))
(define set-semaphore-count! (record-mutator struct:semaphore 0))
(define struct:semaphore-peek-evt
  (make-record-type-descriptor
   'semaphore-peek-evt
   #f
   #f
   #f
   #f
   '#((mutable f0))))
(define g3962
  (struct-type-install-properties!
   struct:semaphore-peek-evt
   'semaphore-peek-evt
   1
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1
      (lambda (sp_0 poll-ctx_8)
        (let ((temp21_0 (|#%app| semaphore-peek-evt-sema sp_0)))
          (let ((poll-ctx22_0 poll-ctx_8))
            (let ((temp23_0 #t))
              (let ((sp24_0 sp_0))
                (let ((temp21_0 temp21_0))
                  (|#%app|
                   semaphore-wait/poll14.1
                   temp23_0
                   #t
                   sp24_0
                   #t
                   temp21_0
                   poll-ctx22_0))))))))))
   (current-inspector)
   #f
   '(0)
   #f
   'semaphore-peek-evt))
(define semaphore-peek-evt2.1
  (record-constructor
   (make-record-constructor-descriptor struct:semaphore-peek-evt #f #f)))
(define 1/semaphore-peek-evt? (record-predicate struct:semaphore-peek-evt))
(define semaphore-peek-evt-sema (record-accessor struct:semaphore-peek-evt 0))
(define struct:semaphore-peek-select-waiter
  (make-record-type-descriptor
   'semaphore-peek-select-waiter
   struct:select-waiter
   #f
   #f
   #f
   '#()))
(define g3967
  (struct-type-install-properties!
   struct:semaphore-peek-select-waiter
   'semaphore-peek-select-waiter
   0
   0
   struct:select-waiter
   null
   (current-inspector)
   #f
   '()
   #f
   'semaphore-peek-select-waiter))
(define semaphore-peek-select-waiter3.1
  (record-constructor
   (make-record-constructor-descriptor
    struct:semaphore-peek-select-waiter
    #f
    #f)))
(define semaphore-peek-select-waiter?
  (record-predicate struct:semaphore-peek-select-waiter))
(define 1/make-semaphore
  (let ((make-semaphore6_0
         (lambda (init4_0 init5_0)
           (let ((init_0 (if init5_0 init4_0 0)))
             (begin
               (if (exact-nonnegative-integer? init_0)
                 (void)
                 (raise-argument-error
                  'make-semaphore
                  "exact-nonnegative-integer?"
                  init_0))
               (semaphore1.1 init_0 (make-queue)))))))
    (case-lambda
     (() (make-semaphore6_0 #f #f))
     ((init4_1) (make-semaphore6_0 init4_1 #t)))))
(define 1/semaphore-post
  (lambda (s_4)
    (begin
      (if (1/semaphore? s_4)
        (void)
        (raise-argument-error 'semaphore-post "semaphore?" s_4))
      (start-atomic)
      (begin0
        ((letrec*
          ((loop_2
            (lambda ()
              (let ((w_5 (queue-remove! (semaphore-queue s_4))))
                (if (not w_5)
                  (set-semaphore-count! s_4 (add1 (semaphore-count s_4)))
                  (begin
                    (waiter-resume! w_5 s_4)
                    (if (semaphore-peek-select-waiter? w_5)
                      (loop_2)
                      (void))))))))
          loop_2))
        (end-atomic)))))
(define semaphore-post-all
  (lambda (s_5)
    (begin
      (start-atomic)
      (begin0
        (begin
          (set-semaphore-count! s_5 +inf.0)
          (queue-remove-all!
           (semaphore-queue s_5)
           (lambda (w_6) (waiter-resume! w_6 s_5))))
        (end-atomic)))))
(define semaphore-any-waiters?
  (lambda (s_6) (not (queue-empty? (semaphore-queue s_6)))))
(define 1/semaphore-wait
  (lambda (s_7)
    (begin
      (if (1/semaphore? s_7)
        (void)
        (raise-argument-error 'semaphore-wait "semaphore?" s_7))
      (|#%app|
       (begin
         (start-atomic)
         (begin0
           (let ((c_0 (semaphore-count s_7)))
             (if (positive? c_0)
               (begin (set-semaphore-count! s_7 (sub1 c_0)) void)
               (let ((w_7 (1/current-thread)))
                 (let ((q_6 (semaphore-queue s_7)))
                   (let ((n_3 (queue-add! q_6 w_7)))
                     (waiter-suspend!
                      w_7
                      (lambda () (queue-remove-node! q_6 n_3))))))))
           (end-atomic))))
      (void))))
(define semaphore-wait/poll14.1
  (lambda (peek?8_0 peek?10_0 result9_0 result11_0 s12_0 poll-ctx13_0)
    (let ((s_8 s12_0))
      (let ((poll-ctx_9 poll-ctx13_0))
        (let ((peek?_0 (if peek?10_0 peek?8_0 #f)))
          (let ((result_0 (if result11_0 result9_0 s_8)))
            (let ((c_1 (semaphore-count s_8)))
              (if (positive? c_1)
                (begin
                  (if peek?_0 (void) (set-semaphore-count! s_8 (sub1 c_1)))
                  (values (list result_0) #f))
                (if (poll-ctx-poll? poll-ctx_9)
                  (values #f the-never-evt)
                  (let ((w_8
                         (if peek?_0
                           (select-waiter9.1 (poll-ctx-select-proc poll-ctx_9))
                           (semaphore-peek-select-waiter3.1
                            (poll-ctx-select-proc poll-ctx_9)))))
                    (let ((q_7 (semaphore-queue s_8)))
                      (let ((n_4 (queue-add! q_7 w_8)))
                        (values
                         #f
                         (wrap-evt6.1
                          (nack-evt8.1
                           the-async-evt
                           (lambda () (queue-remove-node! q_7 n_4)))
                          (lambda (v_19) result_0)))))))))))))))
(define struct:thread-group
  (make-record-type-descriptor
   'thread-group
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1) (mutable f2) (mutable f3) (mutable f4))))
(define g3983
  (struct-type-install-properties!
   struct:thread-group
   'thread-group
   5
   0
   #f
   null
   (current-inspector)
   #f
   '(0 1)
   #f
   'thread-group))
(define thread-group1.1
  (record-constructor
   (make-record-constructor-descriptor struct:thread-group #f #f)))
(define 1/thread-group? (record-predicate struct:thread-group))
(define thread-group-parent (record-accessor struct:thread-group 0))
(define thread-group-children (record-accessor struct:thread-group 1))
(define thread-group-chain-start (record-accessor struct:thread-group 2))
(define thread-group-chain (record-accessor struct:thread-group 3))
(define thread-group-chain-end (record-accessor struct:thread-group 4))
(define set-thread-group-chain-start! (record-mutator struct:thread-group 2))
(define set-thread-group-chain! (record-mutator struct:thread-group 3))
(define set-thread-group-chain-end! (record-mutator struct:thread-group 4))
(define struct:node
  (make-record-type-descriptor
   'node
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1) (mutable f2))))
(define g3984
  (struct-type-install-properties!
   struct:node
   'node
   3
   0
   #f
   null
   #f
   #f
   '(0)
   #f
   'node))
(define node2.1
  (record-constructor (make-record-constructor-descriptor struct:node #f #f)))
(define node? (record-predicate struct:node))
(define node-child (record-accessor struct:node 0))
(define node-prev (record-accessor struct:node 1))
(define node-next (record-accessor struct:node 2))
(define set-node-prev! (record-mutator struct:node 1))
(define set-node-next! (record-mutator struct:node 2))
(define root-thread-group (thread-group1.1 #f (make-hasheq) #f #f #f))
(define num-threads-in-groups 0)
(define 1/current-thread-group
  (make-parameter
   root-thread-group
   (lambda (v_20)
     (begin
       (if (1/thread-group? v_20)
         (void)
         (raise-argument-error 'current-thread-group "thread-group?" v_20))
       v_20))))
(define 1/make-thread-group
  (let ((make-thread-group5_0
         (lambda (parent3_0 parent4_0)
           (let ((parent_0
                  (if parent4_0 parent3_0 (|#%app| 1/current-thread-group))))
             (begin
               (if (1/thread-group? parent_0)
                 (void)
                 (raise-argument-error
                  'make-thread-group
                  "thread-group?"
                  parent_0))
               (begin
                 (let ((tg_0
                        (thread-group1.1 parent_0 (make-hasheq) #f #f #f)))
                   (begin (thread-group-add! parent_0 tg_0) tg_0))))))))
    (case-lambda
     (() (make-thread-group5_0 #f #f))
     ((parent3_1) (make-thread-group5_0 parent3_1 #t)))))
(define thread-group-next!
  (lambda (tg_1)
    (let ((n_5 (thread-group-chain tg_1)))
      (if (not n_5)
        (let ((n_6 (thread-group-chain-start tg_1)))
          (if (not n_6)
            #f
            (begin
              (set-thread-group-chain! tg_1 (node-next n_6))
              (node-child n_6))))
        (begin
          (set-thread-group-chain! tg_1 (node-next n_5))
          (node-child n_5))))))
(define thread-group-add!
  (lambda (parent_1 child_0)
    (begin
      (start-atomic)
      (begin0
        (let ((t_7 (thread-group-chain-end parent_1)))
          (let ((n_7 (node2.1 child_0 t_7 #f)))
            (begin
              (if t_7
                (set-node-next! t_7 n_7)
                (set-thread-group-chain-start! parent_1 n_7))
              (set-thread-group-chain-end! parent_1 n_7)
              (hash-set! (thread-group-children parent_1) child_0 n_7)
              (if (1/thread-group? child_0)
                (void)
                (set! num-threads-in-groups (add1 num-threads-in-groups))))))
        (end-atomic)))))
(define thread-group-remove!
  (lambda (parent_2 child_1)
    (begin
      (start-atomic)
      (begin0
        (let ((children_0 (thread-group-children parent_2)))
          (let ((n_8 (hash-ref children_0 child_1)))
            (begin
              (hash-remove! children_0 child_1)
              (if (node-next n_8)
                (let ((app_3991 (node-next n_8)))
                  (set-node-prev! app_3991 (node-prev n_8)))
                (set-thread-group-chain-end! parent_2 (node-prev n_8)))
              (if (node-prev n_8)
                (let ((app_3994 (node-prev n_8)))
                  (set-node-next! app_3994 (node-next n_8)))
                (set-thread-group-chain-start! parent_2 (node-next n_8)))
              (if (eq? n_8 (thread-group-chain parent_2))
                (set-thread-group-chain! parent_2 (node-next n_8))
                (void))
              (if (1/thread-group? child_1)
                (void)
                (set! num-threads-in-groups (sub1 num-threads-in-groups))))))
        (end-atomic)))))
(define thread-group-all-threads
  (lambda (parent_3 accum_0)
    (if (not (1/thread-group? parent_3))
      (cons parent_3 accum_0)
      ((letrec*
        ((loop_3
          (lambda (n_9 accum_1)
            (if (not n_9)
              accum_1
              (let ((app_4001 (node-next n_9)))
                (loop_3
                 app_4001
                 (thread-group-all-threads (node-child n_9) accum_1)))))))
        loop_3)
       (thread-group-chain-start parent_3)
       accum_0))))
(define struct:schedule-info
  (make-record-type-descriptor
   'schedule-info
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1))))
(define g4004
  (struct-type-install-properties!
   struct:schedule-info
   'schedule-info
   2
   0
   #f
   null
   (current-inspector)
   #f
   '()
   #f
   'schedule-info))
(define schedule-info1.1
  (record-constructor
   (make-record-constructor-descriptor struct:schedule-info #f #f)))
(define schedule-info? (record-predicate struct:schedule-info))
(define schedule-info-did-work? (record-accessor struct:schedule-info 0))
(define schedule-info-timeout-at (record-accessor struct:schedule-info 1))
(define set-schedule-info-did-work?! (record-mutator struct:schedule-info 0))
(define set-schedule-info-timeout-at! (record-mutator struct:schedule-info 1))
(define make-schedule-info6.1
  (lambda (did-work?2_0 did-work?4_0 timeout-at3_0 timeout-at5_0)
    (let ((did-work?_0 (if did-work?4_0 did-work?2_0 #t)))
      (let ((timeout-at_0 (if timeout-at5_0 timeout-at3_0 #f)))
        (schedule-info1.1 did-work?_0 timeout-at_0)))))
(define schedule-info-add-timeout-at!
  (lambda (sched-info_0 timeout-at_1)
    (let ((tm_0 (schedule-info-timeout-at sched-info_0)))
      (set-schedule-info-timeout-at!
       sched-info_0
       (if tm_0 (min tm_0 timeout-at_1) timeout-at_1)))))
(define struct:thread
  (make-record-type-descriptor
   'thread
   #f
   #f
   #f
   #f
   '#((mutable f0)
      (mutable f1)
      (mutable f2)
      (mutable f3)
      (mutable f4)
      (mutable f5)
      (mutable f6)
      (mutable f7)
      (mutable f8)
      (mutable f9)
      (mutable f10)
      (mutable f11))))
(define g4006
  (struct-type-install-properties!
   struct:thread
   'thread
   12
   0
   #f
   (list
    (cons
     1/prop:evt
     (lambda (t_13)
       (wrap-evt6.1 (|#%app| get-thread-dead-evt t_13) (lambda (v_21) t_13))))
    (cons
     prop:waiter
     (let ((temp17_0
            (lambda (t_14 cb_1)
              (|#%app| thread-internal-suspend! t_14 #f cb_1))))
       (let ((temp18_0
              (lambda (t_15 v_22)
                (begin (|#%app| thread-internal-resume! t_15) v_22))))
         (make-waiter-methods6.1 temp18_0 temp17_0)))))
   (current-inspector)
   #f
   '(0 2 5)
   #f
   'thread))
(define thread1.1
  (record-constructor
   (make-record-constructor-descriptor struct:thread #f #f)))
(define 1/thread? (record-predicate struct:thread))
(define thread-name (record-accessor struct:thread 0))
(define thread-engine (record-accessor struct:thread 1))
(define thread-parent (record-accessor struct:thread 2))
(define thread-sleep-until (record-accessor struct:thread 3))
(define thread-sched-info (record-accessor struct:thread 4))
(define thread-suspend-to-kill? (record-accessor struct:thread 5))
(define thread-kill-callback (record-accessor struct:thread 6))
(define thread-dead-sema (record-accessor struct:thread 7))
(define 1/thread-dead-evt (record-accessor struct:thread 8))
(define thread-suspended? (record-accessor struct:thread 9))
(define thread-suspended-sema (record-accessor struct:thread 10))
(define thread-pending-break? (record-accessor struct:thread 11))
(define set-thread-engine! (record-mutator struct:thread 1))
(define set-thread-sleep-until! (record-mutator struct:thread 3))
(define set-thread-sched-info! (record-mutator struct:thread 4))
(define set-thread-kill-callback! (record-mutator struct:thread 6))
(define set-thread-dead-sema! (record-mutator struct:thread 7))
(define set-thread-dead-evt! (record-mutator struct:thread 8))
(define set-thread-suspended?! (record-mutator struct:thread 9))
(define set-thread-suspended-sema! (record-mutator struct:thread 10))
(define set-thread-pending-break?! (record-mutator struct:thread 11))
(define do-make-thread8.1
  (lambda (initial?2_0
           initial?4_0
           suspend-to-kill?3_0
           suspend-to-kill?5_0
           who6_0
           proc7_0)
    (let ((who_0 who6_0))
      (let ((proc_1 proc7_0))
        (let ((initial?_0 (if initial?4_0 initial?2_0 #f)))
          (let ((suspend-to-kill?_0
                 (if suspend-to-kill?5_0 suspend-to-kill?3_0 #f)))
            (begin
              (if ((lambda (proc_2)
                     (if (procedure? proc_2)
                       (procedure-arity-includes? proc_2 0)
                       #f))
                   proc_1)
                (void)
                (raise-argument-error
                 who_0
                 "(procedure-arity-includes?/c 0)"
                 proc_1))
              (begin
                (let ((p_0 (|#%app| 1/current-thread-group)))
                  (let ((bc_0
                         (if initial?_0
                           break-enabled-default-cell
                           (current-break-enabled-cell))))
                    (let ((e_1
                           (|#%app|
                            make-engine
                            (lambda ()
                              (with-continuation-mark
                               1/break-enabled-key
                               bc_0
                               (|#%app| proc_1))))))
                      (let ((t_16
                             (thread1.1
                              (gensym)
                              e_1
                              p_0
                              #f
                              #f
                              suspend-to-kill?_0
                              #f
                              #f
                              #f
                              #f
                              #f
                              #f)))
                        (begin (thread-group-add! p_0 t_16) t_16)))))))))))))
(define make-thread
  (let ((thread_0
         (lambda (proc_3)
           (let ((temp19_0 'thread))
             (let ((proc20_0 proc_3))
               (do-make-thread8.1 #f #f #f #f temp19_0 proc20_0))))))
    thread_0))
(define make-initial-thread
  (lambda (thunk_0)
    (let ((temp24_0 'thread))
      (let ((thunk25_0 thunk_0))
        (let ((temp26_0 #t))
          (do-make-thread8.1 temp26_0 #t #f #f temp24_0 thunk25_0))))))
(define 1/thread-running?
  (lambda (t_17)
    (begin
      (if (1/thread? t_17)
        (void)
        (raise-argument-error 'thread-running? "thread?" t_17))
      (if (not (eq? 'done (thread-engine t_17)))
        (not (thread-suspended? t_17))
        #f))))
(define 1/thread-dead?
  (lambda (t_18)
    (begin
      (if (1/thread? t_18)
        (void)
        (raise-argument-error 'thread-dead? "thread?" t_18))
      (eq? 'done (thread-engine t_18)))))
(define thread-dead!
  (lambda (t_19)
    (begin
      (set-thread-engine! t_19 'done)
      (if (thread-dead-sema t_19)
        (semaphore-post-all (thread-dead-sema t_19))
        (void))
      (thread-group-remove! (thread-parent t_19) t_19)
      (remove-from-sleeping-threads! t_19))))
(define 1/thread-wait
  (lambda (t_20)
    (begin
      (if (1/thread? t_20)
        (void)
        (raise-argument-error 'thread-wait "thread?" t_20))
      (1/semaphore-wait (get-thread-dead-sema t_20)))))
(define struct:dead-evt
  (make-record-type-descriptor 'thread-dead-evt #f #f #f #f '#((mutable f0))))
(define g4021
  (struct-type-install-properties!
   struct:dead-evt
   'thread-dead-evt
   1
   0
   #f
   (list
    (cons
     1/prop:evt
     (lambda (tde_0)
       (wrap-evt6.1 (dead-evt-sema tde_0) (lambda (s_9) tde_0)))))
   (current-inspector)
   #f
   '(0)
   #f
   'dead-evt))
(define dead-evt11.1
  (record-constructor
   (make-record-constructor-descriptor struct:dead-evt #f #f)))
(define dead-evt? (record-predicate struct:dead-evt))
(define dead-evt-sema (record-accessor struct:dead-evt 0))
(define get-thread-dead-evt
  (let ((thread-dead-evt_0
         (lambda (t_21)
           (begin
             (if (1/thread? t_21)
               (void)
               (raise-argument-error 'thread-dead-evt "thread?" t_21))
             (start-atomic)
             (begin0
               (if (1/thread-dead-evt t_21)
                 (void)
                 (set-thread-dead-evt!
                  t_21
                  (dead-evt11.1 (get-thread-dead-sema t_21))))
               (end-atomic))
             (1/thread-dead-evt t_21)))))
    thread-dead-evt_0))
(define get-thread-dead-sema
  (lambda (t_22)
    (begin
      (start-atomic)
      (begin0
        (if (thread-dead-sema t_22)
          (void)
          (begin
            (set-thread-dead-sema! t_22 (1/make-semaphore 0))
            (if (eq? 'done (thread-engine t_22))
              (semaphore-post-all (thread-dead-sema t_22))
              (void))))
        (end-atomic))
      (thread-dead-sema t_22))))
(define sleeping-threads empty-tree)
(define remove-from-sleeping-threads!
  (lambda (t_23)
    (let ((sleep-until_0 (thread-sleep-until t_23)))
      (if sleep-until_0
        (begin
          (set-thread-sleep-until! t_23 #f)
          (begin
            (let ((threads_0 (lookup sleeping-threads sleep-until_0 <)))
              (begin
                (if threads_0
                  (void)
                  (internal-error "thread not found among sleeping threads"))
                (begin
                  (let ((new-threads_0 (hash-remove threads_0 t_23)))
                    (set! sleeping-threads
                      (if (zero? (hash-count new-threads_0))
                        (delete sleeping-threads sleep-until_0 <)
                        (insert
                         sleeping-threads
                         sleep-until_0
                         new-threads_0
                         <)))))))))
        (void)))))
(define add-to-sleeping-threads!
  (lambda (t_24 timeout-at_2)
    (begin
      (set-thread-sleep-until! t_24 timeout-at_2)
      (set! sleeping-threads
        (let ((app_4034 sleeping-threads))
          (insert
           app_4034
           timeout-at_2
           (hash-set
            (let ((or-part_0 (lookup sleeping-threads timeout-at_2 <)))
              (if or-part_0 or-part_0 hash3712))
            t_24
            #t)
           <))))))
(define thread-internal-suspend!
  (lambda (t_25 timeout-at_3 kill-callback_0)
    (begin
      (start-atomic)
      (begin0
        (begin
          (set-thread-kill-callback! t_25 kill-callback_0)
          (thread-group-remove! (thread-parent t_25) t_25)
          (if timeout-at_3 (add-to-sleeping-threads! t_25 timeout-at_3) (void))
          (if (eq? t_25 (1/current-thread)) (thread-did-work!) (void))
          (lambda ()
            (if (eq? t_25 (1/current-thread)) (|#%app| engine-block) (void))))
        (end-atomic)))))
(define thread-internal-resume!
  (lambda (t_26)
    (begin
      (set-thread-kill-callback! t_26 #f)
      (remove-from-sleeping-threads! t_26)
      (thread-group-add! (thread-parent t_26) t_26))))
(define 1/thread-suspend
  (lambda (t_27)
    (begin
      (if (1/thread? t_27)
        (void)
        (raise-argument-error 'thread-suspend "thread?" t_27))
      (|#%app|
       (begin
         (start-atomic)
         (begin0
           (begin
             (if (thread-suspended? t_27)
               (void)
               (begin
                 (set-thread-suspended?! t_27 #t)
                 (if (thread-suspended-sema t_27)
                   (begin
                     (semaphore-post-all (thread-suspended-sema t_27))
                     (set-thread-suspended-sema! t_27 #f))
                   (void))))
             (if (thread-parent t_27)
               (|#%app| thread-internal-suspend! t_27 #f void)
               void))
           (end-atomic)))))))
(define thread-yield
  (lambda (sched-info_1)
    (begin
      (start-atomic)
      (begin0
        (begin
          (if (let ((or-part_1 (not sched-info_1)))
                (if or-part_1
                  or-part_1
                  (schedule-info-did-work? sched-info_1)))
            (thread-did-work!)
            (thread-did-no-work!))
          (set-thread-sched-info! (1/current-thread) sched-info_1))
        (end-atomic))
      (|#%app| engine-block))))
(define 1/sleep
  (let ((sleep14_0
         (lambda (secs12_0 secs13_0)
           (let ((secs_0 (if secs13_0 secs12_0 0)))
             (begin
               (if ((lambda (c_2) (if (real? c_2) (>= c_2 0) #f)) secs_0)
                 (void)
                 (raise-argument-error 'sleep "(>=/c 0)" secs_0))
               (|#%app|
                (let ((app_4046 thread-internal-suspend!))
                  (let ((app_4047 (1/current-thread)))
                    (|#%app|
                     app_4046
                     app_4047
                     (let ((app_4044 (* secs_0 1000.0)))
                       (+ app_4044 (current-inexact-milliseconds)))
                     void)))))))))
    (case-lambda (() (sleep14_0 #f #f)) ((secs12_1) (sleep14_0 secs12_1 #t)))))
(define poll-done-threads hash3712)
(define thread-did-no-work!
  (lambda ()
    (set! poll-done-threads
      (let ((app_4050 poll-done-threads))
        (hash-set app_4050 (1/current-thread))))))
(define thread-did-work! (lambda () (set! poll-done-threads hash3712)))
(define 1/break-enabled-key (gensym))
(define break-enabled-default-cell (make-thread-cell #t #t))
(define current-break-enabled-cell
  (lambda ()
    (continuation-mark-set-first
     #f
     1/break-enabled-key
     break-enabled-default-cell
     (|#%app| root-continuation-prompt-tag))))
(define 1/check-for-break
  (lambda ()
    (let ((t_28 (1/current-thread)))
      (if (thread-pending-break? t_28)
        (if (thread-cell-ref (current-break-enabled-cell))
          (begin
            (set-thread-pending-break?! t_28 #f)
            (call-with-escape-continuation
             (lambda (k_0)
               (raise
                (exn:break "user break" (current-continuation-marks) k_0)))))
          (void))
        (void)))))
(define 1/break-thread
  (lambda (t_29)
    (begin
      (if (1/thread? t_29)
        (void)
        (raise-argument-error 'break-thread "thread?" t_29))
      (if (thread-pending-break? t_29)
        (void)
        (begin
          (set-thread-pending-break?! t_29 #t)
          (if (eq? t_29 (1/current-thread)) (1/check-for-break) (void)))))))
(define struct:channel
  (make-record-type-descriptor
   'channel
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1))))
(define g4057
  (struct-type-install-properties!
   struct:channel
   'channel
   2
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1
      (lambda (ch_0 poll-ctx_10)
        (|#%app| channel-get/poll ch_0 poll-ctx_10)))))
   (current-inspector)
   #f
   '(0 1)
   #f
   'channel))
(define channel1.1
  (record-constructor
   (make-record-constructor-descriptor struct:channel #f #f)))
(define 1/channel? (record-predicate struct:channel))
(define channel-get-queue (record-accessor struct:channel 0))
(define channel-put-queue (record-accessor struct:channel 1))
(define struct:channel-put-evt
  (make-record-type-descriptor
   'channel-put-evt
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1))))
(define g4061
  (struct-type-install-properties!
   struct:channel-put-evt
   'channel-put-evt
   2
   0
   #f
   (list
    (cons
     1/prop:evt
     (poller1.1
      (lambda (cp_0 poll-ctx_11)
        (let ((app_4064 channel-put/poll))
          (let ((app_4065 (|#%app| channel-put-evt-ch cp_0)))
            (|#%app|
             app_4064
             app_4065
             (|#%app| channel-put-evt-v cp_0)
             cp_0
             poll-ctx_11)))))))
   (current-inspector)
   #f
   '(0 1)
   #f
   'channel-put-evt))
(define channel-put-evt2.1
  (record-constructor
   (make-record-constructor-descriptor struct:channel-put-evt #f #f)))
(define 1/channel-put-evt? (record-predicate struct:channel-put-evt))
(define channel-put-evt-ch (record-accessor struct:channel-put-evt 0))
(define channel-put-evt-v (record-accessor struct:channel-put-evt 1))
(define struct:channel-select-waiter
  (make-record-type-descriptor
   'channel-select-waiter
   struct:select-waiter
   #f
   #f
   #f
   '#((mutable f0))))
(define g4069
  (struct-type-install-properties!
   struct:channel-select-waiter
   'channel-select-waiter
   1
   0
   struct:select-waiter
   null
   (current-inspector)
   #f
   '(0)
   #f
   'channel-select-waiter))
(define channel-select-waiter3.1
  (record-constructor
   (make-record-constructor-descriptor struct:channel-select-waiter #f #f)))
(define channel-select-waiter? (record-predicate struct:channel-select-waiter))
(define channel-select-waiter-thread
  (record-accessor struct:channel-select-waiter 0))
(define 1/make-channel
  (lambda ()
    (let ((app_4070 (make-queue))) (channel1.1 app_4070 (make-queue)))))
(define channel-get
  (lambda (ch_1)
    (begin
      (if (1/channel? ch_1)
        (void)
        (raise-argument-error 'channel-get "channel?" ch_1))
      (begin
        (let ((b_0 (box #f)))
          (begin
            (|#%app|
             (begin
               (start-atomic)
               (begin0
                 (let ((pw+v_0 (queue-remove! (channel-put-queue ch_1))))
                   (let ((gw_0 (1/current-thread)))
                     (if (not pw+v_0)
                       (let ((gq_0 (channel-get-queue ch_1)))
                         (let ((n_7 (queue-add! gq_0 (cons gw_0 b_0))))
                           (waiter-suspend!
                            gw_0
                            (lambda () (queue-remove-node! gq_0 n_7)))))
                       (begin
                         (set-box! b_0 (cdr pw+v_0))
                         (let ((app_4074 (car pw+v_0)))
                           (waiter-resume! app_4074 (void)))
                         void))))
                 (end-atomic))))
            (unbox b_0)))))))
(define channel-get/poll
  (lambda (ch_2 poll-ctx_12)
    (let ((pw+v_1
           (queue-fremove!
            (channel-put-queue ch_2)
            not-matching-select-waiter)))
      (if pw+v_1
        (begin
          (let ((app_4078 (car pw+v_1))) (waiter-resume! app_4078 (void)))
          (values (list (cdr pw+v_1)) #f))
        (if (poll-ctx-poll? poll-ctx_12)
          (values #f the-never-evt)
          (let ((b_1 (box #f)))
            (let ((gq_1 (channel-get-queue ch_2)))
              (let ((gw_1
                     (let ((app_4082 (poll-ctx-select-proc poll-ctx_12)))
                       (channel-select-waiter3.1
                        app_4082
                        (1/current-thread)))))
                (let ((n_10 (queue-add! gq_1 (cons gw_1 b_1))))
                  (values
                   #f
                   (wrap-evt6.1
                    (nack-evt8.1
                     the-async-evt
                     (lambda () (queue-remove-node! gq_1 n_10)))
                    (lambda (v_23) (unbox b_1)))))))))))))
(define channel-put
  (lambda (ch_3 v_24)
    (begin
      (if (1/channel? ch_3)
        (void)
        (raise-argument-error 'channel-put "channel?" ch_3))
      (|#%app|
       (begin
         (start-atomic)
         (begin0
           (let ((gw+b_0 (queue-remove! (channel-get-queue ch_3))))
             (let ((pw_0 (1/current-thread)))
               (if (not gw+b_0)
                 (let ((pq_0 (channel-put-queue ch_3)))
                   (let ((n_11 (queue-add! pq_0 (cons pw_0 v_24))))
                     (waiter-suspend!
                      pw_0
                      (lambda () (queue-remove-node! pq_0 n_11)))))
                 (begin
                   (set-box! (cdr gw+b_0) v_24)
                   (waiter-resume! (car gw+b_0) v_24)
                   void))))
           (end-atomic))))
      (void))))
(define channel-put/poll
  (lambda (ch_4 v_25 result_1 poll-ctx_13)
    (let ((gw+b_1
           (queue-fremove!
            (channel-get-queue ch_4)
            not-matching-select-waiter)))
      (if (not gw+b_1)
        (let ((pq_1 (channel-put-queue ch_4)))
          (let ((pw_1
                 (let ((app_4091 (poll-ctx-select-proc poll-ctx_13)))
                   (channel-select-waiter3.1 app_4091 (1/current-thread)))))
            (let ((n_12 (queue-add! pq_1 (cons pw_1 v_25))))
              (values
               #f
               (wrap-evt6.1
                (nack-evt8.1
                 the-async-evt
                 (lambda () (queue-remove-node! pq_1 n_12)))
                (lambda (v_26) result_1))))))
        (if (poll-ctx-poll? poll-ctx_13)
          (values #f the-async-evt)
          (begin
            (set-box! (cdr gw+b_1) v_25)
            (waiter-resume! (car gw+b_1) v_25)
            (values (list result_1) #f)))))))
(define not-matching-select-waiter
  (lambda (w+b/v_0)
    (let ((w_9 (car w+b/v_0)))
      (let ((or-part_2 (not (channel-select-waiter? w_9))))
        (if or-part_2
          or-part_2
          (not
           (let ((app_4097 (1/current-thread)))
             (eq? app_4097 (channel-select-waiter-thread w_9)))))))))
(define struct:syncing
  (make-record-type-descriptor
   'syncing
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1) (mutable f2))))
(define g4100
  (struct-type-install-properties!
   struct:syncing
   'syncing
   3
   0
   #f
   null
   (current-inspector)
   #f
   '()
   #f
   'syncing))
(define syncing1.1
  (record-constructor
   (make-record-constructor-descriptor struct:syncing #f #f)))
(define syncing? (record-predicate struct:syncing))
(define syncing-selected (record-accessor struct:syncing 0))
(define syncing-syncers (record-accessor struct:syncing 1))
(define syncing-wakeup (record-accessor struct:syncing 2))
(define set-syncing-selected! (record-mutator struct:syncing 0))
(define set-syncing-syncers! (record-mutator struct:syncing 1))
(define set-syncing-wakeup! (record-mutator struct:syncing 2))
(define struct:syncer
  (make-record-type-descriptor
   'syncer
   #f
   #f
   #f
   #f
   '#((mutable f0) (mutable f1) (mutable f2) (mutable f3) (mutable f4))))
(define g4101
  (struct-type-install-properties!
   struct:syncer
   'syncer
   5
   0
   #f
   null
   (current-inspector)
   #f
   '()
   #f
   'syncer))
(define syncer2.1
  (record-constructor
   (make-record-constructor-descriptor struct:syncer #f #f)))
(define syncer? (record-predicate struct:syncer))
(define syncer-evt (record-accessor struct:syncer 0))
(define syncer-wraps (record-accessor struct:syncer 1))
(define syncer-nacks (record-accessor struct:syncer 2))
(define syncer-prev (record-accessor struct:syncer 3))
(define syncer-next (record-accessor struct:syncer 4))
(define set-syncer-evt! (record-mutator struct:syncer 0))
(define set-syncer-wraps! (record-mutator struct:syncer 1))
(define set-syncer-nacks! (record-mutator struct:syncer 2))
(define set-syncer-prev! (record-mutator struct:syncer 3))
(define set-syncer-next! (record-mutator struct:syncer 4))
(define none-syncer (syncer2.1 #f null null #f #f))
(define do-sync
  (lambda (who_1 timeout_0 args_0)
    (begin
      (if ((lambda (timeout_1)
             (let ((or-part_3 (not timeout_1)))
               (if or-part_3
                 or-part_3
                 (let ((or-part_4 (if (real? timeout_1) (>= timeout_1 0) #f)))
                   (if or-part_4
                     or-part_4
                     (if (procedure? timeout_1)
                       (procedure-arity-includes? timeout_1 0)
                       #f))))))
           timeout_0)
        (void)
        (raise-argument-error
         who_1
         "(or/c #f (and/c real? (not/c negative?)) (-> any))"
         timeout_0))
      (begin
        (let ((syncers_0
               ((letrec*
                 ((loop_4
                   (lambda (args_1 first_0 last_0)
                     (if (null? args_1)
                       first_0
                       (let ((arg_0 (car args_1)))
                         (begin
                           (if (1/evt? arg_0)
                             (void)
                             (raise-argument-error who_1 "evt?" arg_0))
                           (begin
                             (let ((sr_0
                                    (syncer2.1 arg_0 null null last_0 #f)))
                               (begin
                                 (if last_0
                                   (set-syncer-next! last_0 sr_0)
                                   (void))
                                 (let ((app_4102 (cdr args_1)))
                                   (loop_4
                                    app_4102
                                    (let ((or-part_5 first_0))
                                      (if or-part_5 or-part_5 sr_0))
                                    sr_0)))))))))))
                 loop_4)
                args_0
                #f
                #f)))
          (let ((s_10 (syncing1.1 #f syncers_0 void)))
            (if (if (real? timeout_0) (zero? timeout_0) #f)
              (let ((temp15_0 (lambda (sched-info_2) #f)))
                (let ((temp16_0 #t))
                  (sync-poll9.1 #f #f temp16_0 #t s_10 temp15_0)))
              (if (procedure? timeout_0)
                (let ((temp18_1 (lambda (sched-info_3) (|#%app| timeout_0))))
                  (let ((temp19_1 #t))
                    (sync-poll9.1 #f #f temp19_1 #t s_10 temp18_1)))
                (let ((timeout-at_4
                       (if timeout_0
                         (let ((app_4104 (* timeout_0 1000)))
                           (+ app_4104 (current-inexact-milliseconds)))
                         #f)))
                  ((letrec*
                    ((loop_5
                      (lambda (did-work?_1)
                        (if (if timeout_0
                              (>= timeout_0 (current-inexact-milliseconds))
                              #f)
                          (begin (syncing-done! s_10 none-syncer) #f)
                          (if (if (all-asynchronous? s_10)
                                (not (syncing-selected s_10))
                                #f)
                            (begin
                              (suspend-syncing-thread s_10 timeout-at_4)
                              (loop_5 #f))
                            (let ((did-work?21_0 did-work?_1))
                              (let ((temp22_0
                                     (lambda (sched-info_4)
                                       (begin
                                         (if timeout-at_4
                                           (schedule-info-add-timeout-at!
                                            sched-info_4
                                            timeout-at_4)
                                           (void))
                                         (thread-yield sched-info_4)
                                         (loop_5 #f)))))
                                (sync-poll9.1
                                 did-work?21_0
                                 #t
                                 #f
                                 #f
                                 s_10
                                 temp22_0))))))))
                    loop_5)
                   #t))))))))))
(define 1/sync (lambda args_2 (do-sync 'sync #f args_2)))
(define 1/sync/timeout
  (lambda (timeout_2 . args_3) (do-sync 'sync/timeout timeout_2 args_3)))
(define sync-poll9.1
  (lambda (did-work?4_1
           did-work?6_0
           just-poll?3_0
           just-poll?5_0
           s7_0
           none-k8_0)
    (let ((s_11 s7_0))
      (let ((none-k_0 none-k8_0))
        (let ((just-poll?_0 (if just-poll?5_0 just-poll?3_0 #f)))
          (let ((did-work?_2 (if did-work?6_0 did-work?4_1 #f)))
            (let ((sched-info_5
                   (let ((did-work?23_0 did-work?_2))
                     (make-schedule-info6.1 did-work?23_0 #t #f #f))))
              ((letrec*
                ((loop_6
                  (lambda (sr_1)
                    (|#%app|
                     (begin
                       (start-atomic)
                       (begin0
                         (let ((c1_0 (syncing-selected s_11)))
                           (if c1_0
                             ((lambda (sr_2)
                                (make-result-thunk
                                 sr_2
                                 (list (syncer-evt sr_2))))
                              c1_0)
                             (if (not sr_1)
                               (begin
                                 (if just-poll?_0
                                   (syncing-done! s_11 none-syncer)
                                   (void))
                                 (lambda () (|#%app| none-k_0 sched-info_5)))
                               (call-with-values
                                (lambda ()
                                  (let ((app_4110 (syncer-evt sr_1)))
                                    (evt-poll
                                     app_4110
                                     (poll-ctx2.1
                                      just-poll?_0
                                      (lambda () (syncing-done! s_11 sr_1))
                                      sched-info_5))))
                                (case-lambda
                                 ((results_0 new-evt_0)
                                  (begin
                                    (if results_0
                                      (begin
                                        (syncing-done! s_11 sr_1)
                                        (make-result-thunk sr_1 results_0))
                                      (if (wrap-evt? new-evt_0)
                                        (begin
                                          (set-syncer-wraps!
                                           sr_1
                                           (let ((app_4112
                                                  (wrap-evt-wrap new-evt_0)))
                                             (cons
                                              app_4112
                                              (let ((l_1 (syncer-wraps sr_1)))
                                                (if (if (null? l_1)
                                                      (not
                                                       (1/handle-evt?
                                                        new-evt_0))
                                                      #f)
                                                  (list values)
                                                  l_1)))))
                                          (set-syncer-evt!
                                           sr_1
                                           (wrap-evt-evt new-evt_0))
                                          (lambda () (loop_6 sr_1)))
                                        (if (nack-evt? new-evt_0)
                                          (begin
                                            (set-syncer-nacks!
                                             sr_1
                                             (let ((app_4116
                                                    (nack-evt-nack-proc
                                                     new-evt_0)))
                                               (cons
                                                app_4116
                                                (syncer-nacks sr_1))))
                                            (set-syncer-evt!
                                             sr_1
                                             (nack-evt-evt new-evt_0))
                                            (lambda () (loop_6 sr_1)))
                                          (if (guard-evt? new-evt_0)
                                            (lambda ()
                                              (let ((generated_0
                                                     (|#%app|
                                                      (guard-evt-proc
                                                       new-evt_0))))
                                                (begin
                                                  (set-syncer-evt!
                                                   sr_1
                                                   (if (1/evt? generated_0)
                                                     generated_0
                                                     (wrap-evt6.1
                                                      the-always-evt
                                                      (lambda (a_0)
                                                        generated_0))))
                                                  (loop_6 sr_1))))
                                            (if (if (never-evt? new-evt_0)
                                                  (null? (syncer-nacks sr_1))
                                                  #f)
                                              (begin
                                                (if (syncer-prev sr_1)
                                                  (let ((app_4123
                                                         (syncer-prev sr_1)))
                                                    (set-syncer-next!
                                                     app_4123
                                                     (syncer-next sr_1)))
                                                  (set-syncing-syncers!
                                                   s_11
                                                   (syncer-next sr_1)))
                                                (if (syncer-next sr_1)
                                                  (let ((app_4126
                                                         (syncer-next sr_1)))
                                                    (set-syncer-prev!
                                                     app_4126
                                                     (syncer-prev sr_1)))
                                                  (void))
                                                (lambda ()
                                                  (loop_6 (syncer-next sr_1))))
                                              (begin
                                                (set-syncer-evt!
                                                 sr_1
                                                 new-evt_0)
                                                (lambda ()
                                                  (loop_6
                                                   (syncer-next sr_1)))))))))))
                                 (args
                                  (raise-result-arity-error
                                   '(results_0 new-evt_0)
                                   args)))))))
                         (end-atomic)))))))
                loop_6)
               (syncing-syncers s_11)))))))))
(define make-result-thunk
  (lambda (sr_3 results_1)
    (let ((wraps_0 (syncer-wraps sr_3)))
      (lambda ()
        ((letrec*
          ((loop_7
            (lambda (wraps_1 results_2)
              (if (null? wraps_1)
                (apply values results_2)
                (if (null? (cdr wraps_1))
                  (apply (car wraps_1) results_2)
                  (let ((app_4135 (cdr wraps_1)))
                    (loop_7
                     app_4135
                     (call-with-values
                      (lambda () (apply (car wraps_1) results_2))
                      list))))))))
          loop_7)
         wraps_0
         results_1)))))
(define syncing-done!
  (lambda (s_12 selected-sr_0)
    (begin
      (set-syncing-selected! s_12 selected-sr_0)
      ((letrec*
        ((loop_8
          (lambda (sr_4)
            (if sr_4
              (begin
                (if (eq? sr_4 selected-sr_0)
                  (void)
                  (begin
                    (let ((lst_0 (syncer-nacks sr_4)))
                      (begin
                        (check-list lst_0)
                        ((letrec*
                          ((for-loop_0
                            (lambda (lst_1)
                              (if (pair? lst_1)
                                (let ((nack_0 (unsafe-car lst_1)))
                                  (let ((rest_0 (unsafe-cdr lst_1)))
                                    (let ((nack_0 nack_0))
                                      (call-with-values
                                       (lambda ()
                                         (begin
                                           (|#%app| nack_0)
                                           (begin (values))))
                                       (case-lambda
                                        (()
                                         (begin
                                           (if (not #f)
                                             (for-loop_0 rest_0)
                                             (values))))
                                        (args
                                         (raise-result-arity-error
                                          '()
                                          args)))))))
                                (values)))))
                          for-loop_0)
                         lst_0)))
                    (void)))
                (loop_8 (syncer-next sr_4)))
              (void)))))
        loop_8)
       (syncing-syncers s_12))
      (|#%app| (syncing-wakeup s_12)))))
(define all-asynchronous?
  (lambda (s_13)
    (begin
      (start-atomic)
      (begin0
        ((letrec*
          ((loop_9
            (lambda (sr_5)
              (if (not sr_5)
                #t
                (if (async-evt? (syncer-evt sr_5))
                  (loop_9 (syncer-next sr_5))
                  #f)))))
          loop_9)
         (syncing-syncers s_13))
        (end-atomic)))))
(define suspend-syncing-thread
  (lambda (s_14 timeout-at_5)
    (|#%app|
     (begin
       (start-atomic)
       (begin0
         (if (syncing-selected s_14)
           void
           (let ((t_30 (1/current-thread)))
             (begin
               (set-syncing-wakeup!
                s_14
                (lambda ()
                  (begin
                    (set-syncing-wakeup! s_14 void)
                    (|#%app| thread-internal-resume! t_30))))
               (|#%app|
                thread-internal-suspend!
                t_30
                timeout-at_5
                (lambda ()
                  (if (syncing-selected s_14)
                    (void)
                    (syncing-done! s_14 none-syncer)))))))
         (end-atomic))))))
(define idle-sema (1/make-semaphore))
(define wrapped-idle-sema (wrap-evt6.1 idle-sema void))
(define struct:system-idle-evt
  (make-record-type-descriptor 'system-idle-evt #f #f #f #f '#()))
(define g4146
  (struct-type-install-properties!
   struct:system-idle-evt
   'system-idle-evt
   0
   0
   #f
   (list (cons 1/prop:evt (lambda (i_0) wrapped-idle-sema)))
   (current-inspector)
   #f
   '()
   #f
   'system-idle-evt))
(define system-idle-evt1.1
  (record-constructor
   (make-record-constructor-descriptor struct:system-idle-evt #f #f)))
(define system-idle-evt? (record-predicate struct:system-idle-evt))
(define the-idle-evt (system-idle-evt1.1))
(define get-system-idle-evt
  (let ((system-idle-evt_0 (lambda () the-idle-evt))) system-idle-evt_0))
(define any-idle-waiters? (lambda () (semaphore-any-waiters? idle-sema)))
(define post-idle
  (lambda ()
    (if (semaphore-any-waiters? idle-sema)
      (begin (1/semaphore-post idle-sema) #t)
      #f)))
(define TICKS 100000)
(define call-in-main-thread
  (lambda (thunk_1) (begin (make-initial-thread thunk_1) (select-thread!))))
(define select-thread!
  (lambda ()
    ((letrec*
      ((loop_10
        (lambda (g_0 none-k_1)
          (begin
            (check-timeouts)
            (begin
              (begin
                (if (if (all-threads-poll-done?) (maybe-future-work?) #f)
                  (let ((or-part_6 (post-idle)))
                    (if or-part_6 or-part_6 (process-sleep)))
                  (void))
                (begin
                  (let ((child_2 (thread-group-next! g_0)))
                    (if (not child_2)
                      (|#%app| none-k_1)
                      (if (1/thread? child_2)
                        (swap-in-thread child_2)
                        (loop_10
                         child_2
                         (lambda () (loop_10 g_0 none-k_1)))))))))))))
      loop_10)
     root-thread-group
     maybe-done)))
(define swap-in-thread
  (lambda (t_31)
    (let ((e_2 (thread-engine t_31)))
      (begin
        (set-thread-engine! t_31 'running)
        (set-thread-sched-info! t_31 #f)
        (1/current-thread t_31)
        ((letrec*
          ((loop_11
            (lambda (e_3)
              (|#%app|
               e_3
               TICKS
               (lambda () (1/check-for-break))
               (lambda args_4
                 (begin
                   (1/current-thread #f)
                   (if (zero? (current-atomic))
                     (void)
                     (internal-error "terminated in atomic mode!"))
                   (thread-dead! t_31)
                   (thread-did-work!)
                   (select-thread!)))
               (lambda (e_4)
                 (if (zero? (current-atomic))
                   (begin
                     (1/current-thread #f)
                     (set-thread-engine! t_31 e_4)
                     (select-thread!))
                   (loop_11 e_4)))))))
          loop_11)
         e_2)))))
(define maybe-done
  (lambda ()
    (if (if (is-empty? sleeping-threads) (not (any-idle-waiters?)) #f)
      (void)
      (select-thread!))))
(define check-timeouts
  (lambda ()
    (if (is-empty? sleeping-threads)
      (void)
      (call-with-values
       (lambda () (min-key+value sleeping-threads))
       (case-lambda
        ((timeout-at_6 threads_1)
         (begin
           (if (<= timeout-at_6 (current-inexact-milliseconds))
             (if (null? threads_1)
               (void)
               (begin
                 (let ((ht_3 threads_1))
                   (begin
                     (check-in-hash-keys ht_3)
                     ((letrec*
                       ((for-loop_1
                         (lambda (i_0)
                           (if i_0
                             (let ((t_32 (hash-iterate-key ht_3 i_0)))
                               (call-with-values
                                (lambda ()
                                  (begin
                                    (|#%app| thread-internal-resume! t_32)
                                    (begin (values))))
                                (case-lambda
                                 (()
                                  (begin
                                    (if (not #f)
                                      (for-loop_1 (hash-iterate-next ht_3 i_0))
                                      (values))))
                                 (args (raise-result-arity-error '() args)))))
                             (values)))))
                       for-loop_1)
                      (hash-iterate-first ht_3))))
                 (void)
                 (thread-did-work!)))
             (void))))
        (args (raise-result-arity-error '(timeout-at_6 threads_1) args)))))))
(define all-threads-poll-done?
  (lambda ()
    (let ((app_4158 (hash-count poll-done-threads)))
      (= app_4158 num-threads-in-groups))))
(define maybe-future-work?
  (lambda ()
    (let ((or-part_7 (positive? num-threads-in-groups)))
      (if or-part_7
        or-part_7
        (let ((or-part_8 (not (is-empty? sleeping-threads))))
          (if or-part_8 or-part_8 (any-idle-waiters?)))))))
(define process-sleep
  (lambda ()
    (let ((ts_0 (thread-group-all-threads root-thread-group null)))
      (let ((sleep-timeout_0
             (if (is-empty? sleeping-threads)
               (distant-future)
               (call-with-values
                (lambda () (min-key+value sleeping-threads))
                (case-lambda
                 ((timeout-at_7 threads_2) (begin timeout-at_7))
                 (args
                  (raise-result-arity-error
                   '(timeout-at_7 threads_2)
                   args)))))))
        (let ((timeout-at_8
               (let ((lst_2 ts_0))
                 (begin
                   (check-list lst_2)
                   ((letrec*
                     ((for-loop_2
                       (lambda (timeout-at_9 lst_3)
                         (if (pair? lst_3)
                           (let ((t_33 (unsafe-car lst_3)))
                             (let ((rest_1 (unsafe-cdr lst_3)))
                               (let ((t_33 t_33))
                                 (let ((timeout-at_10
                                        (let ((timeout-at_11 timeout-at_9))
                                          (let ((timeout-at_12
                                                 (let ((sched-info_6
                                                        (thread-sched-info
                                                         t_33)))
                                                   (let ((t-timeout-at_0
                                                          (if sched-info_6
                                                            (schedule-info-timeout-at
                                                             sched-info_6)
                                                            #f)))
                                                     (if (not t-timeout-at_0)
                                                       timeout-at_11
                                                       (min
                                                        timeout-at_11
                                                        t-timeout-at_0))))))
                                            (values timeout-at_12)))))
                                   (if (not #f)
                                     (for-loop_2 timeout-at_10 rest_1)
                                     timeout-at_10)))))
                           timeout-at_9))))
                     for-loop_2)
                    sleep-timeout_0
                    lst_2)))))
          (begin
            (sleep (/ (- timeout-at_8 (current-inexact-milliseconds)) 1000.0))
            (thread-did-work!)))))))
(define distant-future
  (lambda ()
    (let ((app_4168 (current-inexact-milliseconds)))
      (+ app_4168 (* 1000.0 60 60 24 365)))))
(define 1/wrap-evt
  (lambda (evt_1 proc_4)
    (begin
      (if (1/evt? evt_1) (void) (raise-argument-error 'wrap-evt "evt?" evt_1))
      (if (procedure? proc_4)
        (void)
        (raise-argument-error 'wrap-evt "procedure?" proc_4))
      (wrap-evt6.1 evt_1 proc_4))))
(define 1/handle-evt
  (lambda (evt_2 proc_5)
    (begin
      (if (1/evt? evt_2)
        (void)
        (raise-argument-error 'handle-evt "evt?" evt_2))
      (if (procedure? proc_5)
        (void)
        (raise-argument-error 'handle-evt "procedure?" proc_5))
      (handle-evt7.1 evt_2 proc_5))))
(define guard-evt
  (lambda (proc_6)
    (begin
      (if ((lambda (v_27)
             (if (procedure? v_27) (procedure-arity-includes? v_27 0) #f))
           proc_6)
        (void)
        (raise-argument-error
         'guard-evt
         "(procedure-arity-includes?/c 0)"
         proc_6))
      (guard-evt9.1 proc_6))))
(define 1/nack-guard-evt
  (lambda (proc_7)
    (begin
      (if ((lambda (v_28)
             (if (procedure? v_28) (procedure-arity-includes? v_28 1) #f))
           proc_7)
        (void)
        (raise-argument-error
         'nack-guard-evt
         "(procedure-arity-includes?/c 1)"
         proc_7))
      (guard-evt9.1
       (lambda ()
         (let ((s_15 (1/make-semaphore)))
           (let ((v_29 (|#%app| proc_7 (semaphore-peek-evt2.1 s_15))))
             (nack-evt8.1
              (if (1/evt? v_29)
                v_29
                (1/wrap-evt the-always-evt (lambda () v_29)))
              (lambda () (1/semaphore-post s_15))))))))))
(define 1/channel-put-evt
  (lambda (ch_5 v_18)
    (begin
      (if (1/channel? ch_5)
        (void)
        (raise-argument-error 'channel-put-evt "channel?" ch_5))
      (channel-put-evt2.1 ch_5 v_18))))
(define 1/semaphore-peek-evt
  (lambda (s_16)
    (begin
      (if (1/semaphore? s_16)
        (void)
        (raise-argument-error 'semaphore-peek-evt "semaphore?" s_16))
      (semaphore-peek-evt2.1 s_16))))
