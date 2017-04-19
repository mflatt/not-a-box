;; This is not the original source code. Instead, this is the code after
;; fully expanding and flattening into a single linklet.
(linklet
 ()
 ((1/wrap-evt wrap-evt)
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
  (1/thread-group? thread-group?))
 (define-values
  (prop:procedure-accessor procedure-accessor? procedure-accessor-ref)
  (make-struct-type-property
   'procedure
   (lambda (v_0 info-l_0) (if (exact-integer? v_0) (make-struct-field-accessor (list-ref info-l_0 3) v_0) #f))))
 (define-values
  (new-prop:procedure new-procedure? new-procedure-ref)
  (make-struct-type-property 'procedure #f (list (cons prop:procedure values) (cons prop:procedure-accessor values))))
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
  (lambda (l_0) (if (list? l_0) (void) (let-values () (raise-argument-error 'in-list "list?" l_0)))))
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
 (define-values (no-empty-edge-table) (make-hash))
 (define-values
  (internal-error)
  (lambda (s_0) (raise (exn:fail (string-append "internal error: " s_0) (current-continuation-marks)))))
 (define-values
  (make-engine engine-block engine-return root-continuation-prompt-tag)
  (let-values (((ht_2) (primitive-table '#%engine)))
    (begin
      (if ht_2 (void) (let-values () (internal-error "engines not provided by host")))
      (values
       (hash-ref ht_2 'make-engine)
       (hash-ref ht_2 'engine-block)
       (hash-ref ht_2 'engine-return)
       (hash-ref ht_2 'root-continuation-prompt-tag)))))
 (define-values
  (struct:node$2 node1.1 node?$2 node-key node-val node-height node-left node-right)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values () (let-values () (make-struct-type 'node #f 5 0 #f null #f #f '(0 1 2 3 4) #f 'node)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'key)
     (make-struct-field-accessor -ref_0 1 'val)
     (make-struct-field-accessor -ref_0 2 'height)
     (make-struct-field-accessor -ref_0 3 'left)
     (make-struct-field-accessor -ref_0 4 'right))))
 (define-values (empty-tree) #f)
 (define-values (is-empty?) (lambda (t_0) (not t_0)))
 (define-values (tree-height) (lambda (t_1) (if (not t_1) (let-values () 0) (let-values () (node-height t_1)))))
 (define-values (tree-balance) (lambda (t_2) (- (tree-height (node-left t_2)) (tree-height (node-right t_2)))))
 (define-values
  (combine)
  (lambda (key_0 val_0 left_0 right_0)
    (node1.1 key_0 val_0 (add1 (max (tree-height left_0) (tree-height right_0))) left_0 right_0)))
 (define-values (reverse-combine) (lambda (key_1 val_1 right_1 left_1) (combine key_1 val_1 left_1 right_1)))
 (define-values
  (lookup)
  (lambda (t_3 key_2 <?_0)
    (if (not t_3)
      (let-values () #f)
      (if (<?_0 key_2 (node-key t_3))
        (let-values () (lookup (node-left t_3) key_2 <?_0))
        (if (<?_0 (node-key t_3) key_2)
          (let-values () (lookup (node-right t_3) key_2 <?_0))
          (let-values () (node-val t_3)))))))
 (define-values
  (insert)
  (lambda (t_4 key_3 val_2 <?_1)
    (if (not t_4)
      (let-values () (combine key_3 val_2 #f #f))
      (if (<?_1 key_3 (node-key t_4))
        (let-values () (insert-to t_4 key_3 val_2 <?_1 node-left node-right combine))
        (if (<?_1 (node-key t_4) key_3)
          (let-values () (insert-to t_4 key_3 val_2 <?_1 node-right node-left reverse-combine))
          (let-values () t_4))))))
 (define-values
  (insert-to)
  (lambda (t_5 new-key_0 new-val_0 <?_2 node-to_0 node-other_0 comb_0)
    (let-values (((new-to_0) (insert (node-to_0 t_5) new-key_0 new-val_0 <?_2)))
      (let-values (((new-other_0) (node-other_0 t_5)))
        (let-values (((new-t_0) (comb_0 (node-key t_5) (node-val t_5) new-to_0 new-other_0)))
          (check-rotate new-t_0 node-to_0 node-other_0 comb_0))))))
 (define-values
  (check-rotate)
  (lambda (new-t_1 node-to_1 node-other_1 comb_1)
    (let-values (((new-to_1) (node-to_1 new-t_1)))
      (let-values (((new-other_1) (node-other_1 new-t_1)))
        (let-values (((to-height_0) (tree-height new-to_1)))
          (let-values (((other-height_0) (tree-height new-other_1)))
            (if (= (- to-height_0 other-height_0) 2) (rotate new-t_1 node-to_1 node-other_1 comb_1) new-t_1)))))))
 (define-values
  (rotate)
  (lambda (t_6 node-to_2 node-other_2 comb_2)
    (let-values (((to_0) (node-to_2 t_6)))
      (let-values (((to-balance_0) (- (tree-height (node-to_2 to_0)) (tree-height (node-other_2 to_0)))))
        (if (negative? to-balance_0)
          (let-values () (double-rotate t_6 node-to_2 node-other_2 comb_2))
          (let-values () (single-rotate t_6 node-to_2 node-other_2 comb_2)))))))
 (define-values
  (double-rotate)
  (lambda (t_7 node-to_3 node-other_3 comb_3)
    (let-values (((orange_0) (node-to_3 t_7)))
      (let-values (((yellow_0) (node-other_3 orange_0)))
        (let-values (((A_0) (node-to_3 orange_0)))
          (let-values (((B_0) (node-to_3 yellow_0)))
            (let-values (((C_0) (node-other_3 yellow_0)))
              (let-values (((D_0) (node-other_3 t_7)))
                (single-rotate
                 (comb_3
                  (node-key t_7)
                  (node-val t_7)
                  (comb_3
                   (node-key yellow_0)
                   (node-val yellow_0)
                   (comb_3 (node-key orange_0) (node-val orange_0) A_0 B_0)
                   C_0)
                  D_0)
                 node-to_3
                 node-other_3
                 comb_3)))))))))
 (define-values
  (single-rotate)
  (lambda (t_8 node-to_4 node-other_4 comb_4)
    (let-values (((yellow_1) (node-to_4 t_8)))
      (comb_4
       (node-key yellow_1)
       (node-val yellow_1)
       (node-to_4 yellow_1)
       (comb_4 (node-key t_8) (node-val t_8) (node-other_4 yellow_1) (node-other_4 t_8))))))
 (define-values
  (delete)
  (lambda (t_9 key_4 <?_3)
    (if (not t_9)
      (let-values () #f)
      (if (<?_3 key_4 (node-key t_9))
        (let-values () (delete-at t_9 key_4 <?_3 node-left node-right combine reverse-combine))
        (if (<?_3 (node-key t_9) key_4)
          (let-values () (delete-at t_9 key_4 <?_3 node-right node-left reverse-combine combine))
          (if (not (node-left t_9))
            (let-values () (node-right t_9))
            (if (not (node-right t_9))
              (let-values () (node-left t_9))
              (let-values ()
                (let-values (((move-key_0 move-val_0) (max-key+value (node-left t_9))))
                  (let-values (((new-left_0) (delete (node-left t_9) move-key_0 <?_3)))
                    (let-values (((new-t_2) (combine move-key_0 move-val_0 new-left_0 (node-right t_9))))
                      (let-values (((balance_0) (tree-balance new-t_2)))
                        (if (= balance_0 -2)
                          (check-rotate new-t_2 node-right node-left reverse-combine)
                          (check-rotate new-t_2 node-left node-right combine))))))))))))))
 (define-values
  (delete-at)
  (lambda (t_10 key_5 <?_4 node-to_5 node-from_0 combine_0 reverse-combine_0)
    (let-values (((new-to_2) (delete (node-to_5 t_10) key_5 <?_4)))
      (if (eq? new-to_2 (node-to_5 t_10))
        (let-values () t_10)
        (let-values ()
          (check-rotate
           (combine_0 (node-key t_10) (node-val t_10) new-to_2 (node-from_0 t_10))
           node-from_0
           node-to_5
           reverse-combine_0))))))
 (define-values
  (min-key+value)
  (lambda (t_11)
    (if (not (node-left t_11))
      (let-values () (values (node-key t_11) (node-val t_11)))
      (let-values () (min-key+value (node-left t_11))))))
 (define-values
  (max-key+value)
  (lambda (t_12)
    (if (not (node-right t_12))
      (let-values () (values (node-key t_12) (node-val t_12)))
      (let-values () (max-key+value (node-right t_12))))))
 (define-values (1/thread) #f)
 (define-values (1/current-thread) (case-lambda (() 1/thread) ((v_14) (set! 1/thread v_14))))
 (define-values (1/prop:evt 1/evt? evt-ref) (make-struct-type-property 'evt))
 (define-values
  (struct:poller poller1.1 poller? poller-proc)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values () (make-struct-type 'poller #f 1 0 #f null (current-inspector) #f '(0) #f 'poller)))))
    (values struct:_0 make-_0 ?_0 (make-struct-field-accessor -ref_0 0 'proc))))
 (define-values
  (struct:poll-ctx poll-ctx2.1 poll-ctx? poll-ctx-poll? poll-ctx-select-proc poll-ctx-sched-info)
  (let-values (((struct:_1 make-_1 ?_1 -ref_1 -set!_1)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'poll-ctx #f 3 0 #f null (current-inspector) #f '(0 1 2) #f 'poll-ctx)))))
    (values
     struct:_1
     make-_1
     ?_1
     (make-struct-field-accessor -ref_1 0 'poll?)
     (make-struct-field-accessor -ref_1 1 'select-proc)
     (make-struct-field-accessor -ref_1 2 'sched-info))))
 (define-values
  (struct:never-evt never-evt3.1 never-evt?)
  (let-values (((struct:_2 make-_2 ?_2 -ref_2 -set!_2)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'never-evt
                     #f
                     0
                     0
                     #f
                     (list (cons 1/prop:evt (poller1.1 (lambda (self_0 poll-ctx_0) (values #f self_0)))))
                     (current-inspector)
                     #f
                     '()
                     #f
                     'never-evt)))))
    (values struct:_2 make-_2 ?_2)))
 (define-values (the-never-evt) (never-evt3.1))
 (define-values
  (struct:always-evt always-evt4.1 always-evt?)
  (let-values (((struct:_3 make-_3 ?_3 -ref_3 -set!_3)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'always-evt
                     #f
                     0
                     0
                     #f
                     (list (cons 1/prop:evt (poller1.1 (lambda (self_1 poll-ctx_1) (values (list self_1) #f)))))
                     (current-inspector)
                     #f
                     '()
                     #f
                     'always-evt)))))
    (values struct:_3 make-_3 ?_3)))
 (define-values (the-always-evt) (always-evt4.1))
 (define-values
  (struct:async-evt async-evt5.1 async-evt?)
  (let-values (((struct:_4 make-_4 ?_4 -ref_4 -set!_4)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'async-evt
                     #f
                     0
                     0
                     #f
                     (list (cons 1/prop:evt (poller1.1 (lambda (self_2 poll-ctx_2) (values #f self_2)))))
                     (current-inspector)
                     #f
                     '()
                     #f
                     'async-evt)))))
    (values struct:_4 make-_4 ?_4)))
 (define-values (the-async-evt) (async-evt5.1))
 (define-values
  (struct:wrap-evt wrap-evt6.1 wrap-evt? wrap-evt-evt wrap-evt-wrap)
  (let-values (((struct:_5 make-_5 ?_5 -ref_5 -set!_5)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'wrap-evt
                     #f
                     2
                     0
                     #f
                     (list (cons 1/prop:evt (poller1.1 (lambda (self_3 poll-ctx_3) (values #f self_3)))))
                     (current-inspector)
                     #f
                     '(0 1)
                     #f
                     'wrap-evt)))))
    (values
     struct:_5
     make-_5
     ?_5
     (make-struct-field-accessor -ref_5 0 'evt)
     (make-struct-field-accessor -ref_5 1 'wrap))))
 (define-values
  (struct:handle-evt handle-evt7.1 1/handle-evt?)
  (let-values (((struct:_6 make-_6 ?_6 -ref_6 -set!_6)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'handle-evt
                     struct:wrap-evt
                     0
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '()
                     #f
                     'handle-evt)))))
    (values struct:_6 make-_6 ?_6)))
 (define-values
  (struct:nack-evt nack-evt8.1 nack-evt? nack-evt-evt nack-evt-nack-proc)
  (let-values (((struct:_7 make-_7 ?_7 -ref_7 -set!_7)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'nack-evt
                     #f
                     2
                     0
                     #f
                     (list (cons 1/prop:evt (poller1.1 (lambda (self_4 poll-ctx_4) (values #f self_4)))))
                     (current-inspector)
                     #f
                     '(0 1)
                     #f
                     'nack-evt)))))
    (values
     struct:_7
     make-_7
     ?_7
     (make-struct-field-accessor -ref_7 0 'evt)
     (make-struct-field-accessor -ref_7 1 'nack-proc))))
 (define-values
  (struct:guard-evt guard-evt9.1 guard-evt? guard-evt-proc)
  (let-values (((struct:_8 make-_8 ?_8 -ref_8 -set!_8)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'guard-evt
                     #f
                     1
                     0
                     #f
                     (list (cons 1/prop:evt (poller1.1 (lambda (self_5 poll-ctx_5) (values #f self_5)))))
                     (current-inspector)
                     #f
                     '(0)
                     #f
                     'guard-evt)))))
    (values struct:_8 make-_8 ?_8 (make-struct-field-accessor -ref_8 0 'proc))))
 (define-values
  (evt-poll)
  (lambda (evt_0 poll-ctx_6)
    (let-values (((v_15) (evt-ref evt_0)))
      (let-values (((v_16) (if (fixnum? v_15) (unsafe-struct-ref evt_0 v_15) v_15)))
        (let-values (((v_17) (if (procedure? v_16) (v_16 evt_0) v_16)))
          (if (1/evt? v_17)
            (let-values () (values #f v_17))
            (if (poller? v_17)
              (let-values () ((poller-proc v_17) evt_0 poll-ctx_6))
              (let-values () (values #f never-evt3.1)))))))))
 (define-values (prop:waiter waiter? waiter-ref) (make-struct-type-property 'waiter))
 (define-values
  (struct:waiter-methods waiter-methods1.1 waiter-methods? waiter-methods-suspend waiter-methods-resume)
  (let-values (((struct:_9 make-_9 ?_9 -ref_9 -set!_9)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'waiter-methods
                     #f
                     2
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '(0 1)
                     #f
                     'waiter-methods)))))
    (values
     struct:_9
     make-_9
     ?_9
     (make-struct-field-accessor -ref_9 0 'suspend)
     (make-struct-field-accessor -ref_9 1 'resume))))
 (define-values
  (make-waiter-methods6.1)
  (lambda (resume!3_0 suspend!2_0)
    (let-values (((suspend_0) suspend!2_0))
      (let-values (((resume_0) resume!3_0)) (let-values () (waiter-methods1.1 suspend_0 resume_0))))))
 (define-values (waiter-resume!) (lambda (w_0 s_1) ((waiter-methods-resume (waiter-ref w_0)) w_0 s_1)))
 (define-values (waiter-suspend!) (lambda (w_1 cb_0) ((waiter-methods-suspend (waiter-ref w_1)) w_1 cb_0)))
 (define-values
  (struct:select-waiter select-waiter9.1 select-waiter? select-waiter-proc)
  (let-values (((struct:_10 make-_10 ?_10 -ref_10 -set!_10)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'select-waiter
                     #f
                     1
                     0
                     #f
                     (list
                      (cons
                       prop:waiter
                       (let-values (((void12_0) void) ((temp13_0) (lambda (w_2 s_2) ((select-waiter-proc w_2)))))
                         (make-waiter-methods6.1 temp13_0 void12_0))))
                     (current-inspector)
                     #f
                     '(0)
                     #f
                     'select-waiter)))))
    (values struct:_10 make-_10 ?_10 (make-struct-field-accessor -ref_10 0 'proc))))
 (define-values (atomic) 0)
 (define-values (current-atomic) (case-lambda (() atomic) ((v_18) (set! atomic v_18))))
 (define-values (start-atomic) (lambda () (current-atomic (add1 (current-atomic)))))
 (define-values (end-atomic) (lambda () (current-atomic (sub1 (current-atomic)))))
 (define-values
  (struct:queue queue1.1 queue? queue-start queue-end set-queue-start! set-queue-end!)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values () (make-struct-type 'queue #f 2 0 #f null (current-inspector) #f '() #f 'queue)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'start)
     (make-struct-field-accessor -ref_0 1 'end)
     (make-struct-field-mutator -set!_0 0 'start)
     (make-struct-field-mutator -set!_0 1 'end))))
 (define-values
  (struct:node$1 node2.1$1 node?$1 node-waiter node-prev$1 node-next$1 set-node-prev!$1 set-node-next!$1)
  (let-values (((struct:_11 make-_11 ?_11 -ref_11 -set!_11)
                (let-values ()
                  (let-values () (make-struct-type 'node #f 3 0 #f null (current-inspector) #f '(0) #f 'node)))))
    (values
     struct:_11
     make-_11
     ?_11
     (make-struct-field-accessor -ref_11 0 'waiter)
     (make-struct-field-accessor -ref_11 1 'prev)
     (make-struct-field-accessor -ref_11 2 'next)
     (make-struct-field-mutator -set!_11 1 'prev)
     (make-struct-field-mutator -set!_11 2 'next))))
 (define-values (make-queue) (lambda () (queue1.1 #f #f)))
 (define-values (queue-empty?) (lambda (q_0) (not (queue-start q_0))))
 (define-values
  (queue-remove!)
  (lambda (q_1)
    (let-values (((qs_0) (queue-start q_1)))
      (if (not qs_0)
        (let-values () #f)
        (let-values ()
          (let-values (((n_0) (node-next$1 qs_0)))
            (begin
              (set-queue-start! q_1 n_0)
              (if n_0 (set-node-prev!$1 n_0 #f) (set-queue-end! q_1 #f))
              (node-waiter qs_0))))))))
 (define-values
  (queue-fremove!)
  (lambda (q_2 pred_0)
    ((letrec-values (((loop_0)
                      (lambda (qs_1)
                        (if qs_1
                          (let-values ()
                            (let-values (((w_3) (node-waiter qs_1)))
                              (if (pred_0 w_3)
                                (let-values () (begin (queue-remove-node! q_2 qs_1) w_3))
                                (let-values () (loop_0 (node-next$1 qs_1))))))
                          (let-values () #f)))))
       loop_0)
     (queue-start q_2))))
 (define-values
  (queue-remove-all!)
  (lambda (q_3 proc_0)
    (begin
      ((letrec-values (((loop_1)
                        (lambda (qs_2)
                          (if qs_2
                            (let-values () (begin (proc_0 (node-waiter qs_2)) (loop_1 (node-next$1 qs_2))))
                            (void)))))
         loop_1)
       (queue-start q_3))
      (set-queue-start! q_3 #f)
      (set-queue-end! q_3 #f))))
 (define-values
  (queue-add!)
  (lambda (q_4 w_4)
    (let-values (((e_0) (queue-end q_4)))
      (let-values (((n_1) (node2.1$1 w_4 e_0 #f)))
        (begin
          (if (not e_0)
            (let-values () (begin (set-queue-start! q_4 n_1) (set-queue-end! q_4 n_1)))
            (let-values () (begin (set-node-next!$1 e_0 n_1) (set-node-prev!$1 n_1 e_0))))
          n_1)))))
 (define-values
  (queue-remove-node!)
  (lambda (q_5 n_2)
    (begin
      (if (node-prev$1 n_2)
        (set-node-next!$1 (node-prev$1 n_2) (node-next$1 n_2))
        (set-queue-start! q_5 (node-next$1 n_2)))
      (if (node-next$1 n_2)
        (set-node-prev!$1 (node-next$1 n_2) (node-prev$1 n_2))
        (set-queue-end! q_5 (node-prev$1 n_2))))))
 (define-values
  (struct:semaphore semaphore1.1 1/semaphore? semaphore-count semaphore-queue set-semaphore-count!)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'semaphore
                     #f
                     2
                     0
                     #f
                     (list
                      (cons
                       1/prop:evt
                       (poller1.1
                        (lambda (s_3 poll-ctx_7)
                          (let-values (((s18_0) s_3) ((poll-ctx19_0) poll-ctx_7))
                            (semaphore-wait/poll14.1 #f #f #f #f s18_0 poll-ctx19_0))))))
                     (current-inspector)
                     #f
                     '(1)
                     #f
                     'semaphore)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'count)
     (make-struct-field-accessor -ref_0 1 'queue)
     (make-struct-field-mutator -set!_0 0 'count))))
 (define-values
  (struct:semaphore-peek-evt semaphore-peek-evt2.1 1/semaphore-peek-evt? semaphore-peek-evt-sema)
  (let-values (((struct:_12 make-_12 ?_12 -ref_12 -set!_12)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'semaphore-peek-evt
                     #f
                     1
                     0
                     #f
                     (list
                      (cons
                       1/prop:evt
                       (poller1.1
                        (lambda (sp_0 poll-ctx_8)
                          (let-values (((temp21_0) (semaphore-peek-evt-sema sp_0))
                                       ((poll-ctx22_0) poll-ctx_8)
                                       ((temp23_0) #t)
                                       ((sp24_0) sp_0))
                            (semaphore-wait/poll14.1 temp23_0 #t sp24_0 #t temp21_0 poll-ctx22_0))))))
                     (current-inspector)
                     #f
                     '(0)
                     #f
                     'semaphore-peek-evt)))))
    (values struct:_12 make-_12 ?_12 (make-struct-field-accessor -ref_12 0 'sema))))
 (define-values
  (struct:semaphore-peek-select-waiter semaphore-peek-select-waiter3.1 semaphore-peek-select-waiter?)
  (let-values (((struct:_13 make-_13 ?_13 -ref_13 -set!_13)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'semaphore-peek-select-waiter
                     struct:select-waiter
                     0
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '()
                     #f
                     'semaphore-peek-select-waiter)))))
    (values struct:_13 make-_13 ?_13)))
 (define-values
  (1/make-semaphore)
  (let-values (((make-semaphore6_0)
                (lambda (init4_0 init5_0)
                  (let-values (((init_0) (if init5_0 init4_0 0)))
                    (let-values ()
                      (begin
                        (if (exact-nonnegative-integer? init_0)
                          (void)
                          (let-values () (raise-argument-error 'make-semaphore "exact-nonnegative-integer?" init_0)))
                        (semaphore1.1 init_0 (make-queue))))))))
    (case-lambda (() (make-semaphore6_0 #f #f)) ((init4_1) (make-semaphore6_0 init4_1 #t)))))
 (define-values
  (1/semaphore-post)
  (lambda (s_4)
    (begin
      (if (1/semaphore? s_4) (void) (let-values () (raise-argument-error 'semaphore-post "semaphore?" s_4)))
      (start-atomic)
      (begin0
        (let-values ()
          ((letrec-values (((loop_2)
                            (lambda ()
                              (let-values (((w_5) (queue-remove! (semaphore-queue s_4))))
                                (if (not w_5)
                                  (let-values () (set-semaphore-count! s_4 (add1 (semaphore-count s_4))))
                                  (let-values ()
                                    (begin
                                      (waiter-resume! w_5 s_4)
                                      (if (semaphore-peek-select-waiter? w_5) (let-values () (loop_2)) (void)))))))))
             loop_2)))
        (end-atomic)))))
 (define-values
  (semaphore-post-all)
  (lambda (s_5)
    (begin
      (start-atomic)
      (begin0
        (let-values ()
          (begin
            (set-semaphore-count! s_5 +inf.0)
            (queue-remove-all! (semaphore-queue s_5) (lambda (w_6) (waiter-resume! w_6 s_5)))))
        (end-atomic)))))
 (define-values (semaphore-any-waiters?) (lambda (s_6) (not (queue-empty? (semaphore-queue s_6)))))
 (define-values
  (1/semaphore-wait)
  (lambda (s_7)
    (begin
      (if (1/semaphore? s_7) (void) (let-values () (raise-argument-error 'semaphore-wait "semaphore?" s_7)))
      ((begin
         (start-atomic)
         (begin0
           (let-values ()
             (let-values (((c_0) (semaphore-count s_7)))
               (if (positive? c_0)
                 (let-values () (begin (set-semaphore-count! s_7 (sub1 c_0)) void))
                 (let-values ()
                   (let-values (((w_7) (1/current-thread)))
                     (let-values (((q_6) (semaphore-queue s_7)))
                       (let-values (((n_3) (queue-add! q_6 w_7)))
                         (waiter-suspend! w_7 (lambda () (queue-remove-node! q_6 n_3))))))))))
           (end-atomic))))
      (void))))
 (define-values
  (semaphore-wait/poll14.1)
  (lambda (peek?8_0 peek?10_0 result9_0 result11_0 s12_0 poll-ctx13_0)
    (let-values (((s_8) s12_0))
      (let-values (((poll-ctx_9) poll-ctx13_0))
        (let-values (((peek?_0) (if peek?10_0 peek?8_0 #f)))
          (let-values (((result_0) (if result11_0 result9_0 s_8)))
            (let-values ()
              (let-values (((c_1) (semaphore-count s_8)))
                (if (positive? c_1)
                  (let-values ()
                    (begin
                      (if peek?_0 (void) (let-values () (set-semaphore-count! s_8 (sub1 c_1))))
                      (values (list result_0) #f)))
                  (if (poll-ctx-poll? poll-ctx_9)
                    (let-values () (values #f the-never-evt))
                    (let-values ()
                      (let-values (((w_8)
                                    (if peek?_0
                                      (select-waiter9.1 (poll-ctx-select-proc poll-ctx_9))
                                      (semaphore-peek-select-waiter3.1 (poll-ctx-select-proc poll-ctx_9)))))
                        (let-values (((q_7) (semaphore-queue s_8)))
                          (let-values (((n_4) (queue-add! q_7 w_8)))
                            (values
                             #f
                             (wrap-evt6.1
                              (nack-evt8.1 the-async-evt (lambda () (queue-remove-node! q_7 n_4)))
                              (lambda (v_19) result_0)))))))))))))))))
 (define-values
  (struct:thread-group
   thread-group1.1
   1/thread-group?
   thread-group-parent
   thread-group-children
   thread-group-chain-start
   thread-group-chain
   thread-group-chain-end
   set-thread-group-chain-start!
   set-thread-group-chain!
   set-thread-group-chain-end!)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'thread-group #f 5 0 #f null (current-inspector) #f '(0 1) #f 'thread-group)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'parent)
     (make-struct-field-accessor -ref_0 1 'children)
     (make-struct-field-accessor -ref_0 2 'chain-start)
     (make-struct-field-accessor -ref_0 3 'chain)
     (make-struct-field-accessor -ref_0 4 'chain-end)
     (make-struct-field-mutator -set!_0 2 'chain-start)
     (make-struct-field-mutator -set!_0 3 'chain)
     (make-struct-field-mutator -set!_0 4 'chain-end))))
 (define-values
  (struct:node node2.1 node? node-child node-prev node-next set-node-prev! set-node-next!)
  (let-values (((struct:_14 make-_14 ?_14 -ref_14 -set!_14)
                (let-values () (let-values () (make-struct-type 'node #f 3 0 #f null #f #f '(0) #f 'node)))))
    (values
     struct:_14
     make-_14
     ?_14
     (make-struct-field-accessor -ref_14 0 'child)
     (make-struct-field-accessor -ref_14 1 'prev)
     (make-struct-field-accessor -ref_14 2 'next)
     (make-struct-field-mutator -set!_14 1 'prev)
     (make-struct-field-mutator -set!_14 2 'next))))
 (define-values (root-thread-group) (thread-group1.1 #f (make-hasheq) #f #f #f))
 (define-values (num-threads-in-groups) 0)
 (define-values
  (1/current-thread-group)
  (make-parameter
   root-thread-group
   (lambda (v_20)
     (begin
       (if (1/thread-group? v_20)
         (void)
         (let-values () (raise-argument-error 'current-thread-group "thread-group?" v_20)))
       v_20))))
 (define-values
  (1/make-thread-group)
  (let-values (((make-thread-group5_0)
                (lambda (parent3_0 parent4_0)
                  (let-values (((parent_0) (if parent4_0 parent3_0 (1/current-thread-group))))
                    (let-values ()
                      (let-values ((()
                                    (begin
                                      (if (1/thread-group? parent_0)
                                        (void)
                                        (let-values ()
                                          (raise-argument-error 'make-thread-group "thread-group?" parent_0)))
                                      (values))))
                        (let-values (((tg_0) (thread-group1.1 parent_0 (make-hasheq) #f #f #f)))
                          (begin (thread-group-add! parent_0 tg_0) tg_0))))))))
    (case-lambda (() (make-thread-group5_0 #f #f)) ((parent3_1) (make-thread-group5_0 parent3_1 #t)))))
 (define-values
  (thread-group-next!)
  (lambda (tg_1)
    (let-values (((n_5) (thread-group-chain tg_1)))
      (if (not n_5)
        (let-values ()
          (let-values (((n_6) (thread-group-chain-start tg_1)))
            (if (not n_6)
              (let-values () #f)
              (let-values () (begin (set-thread-group-chain! tg_1 (node-next n_6)) (node-child n_6))))))
        (let-values () (begin (set-thread-group-chain! tg_1 (node-next n_5)) (node-child n_5)))))))
 (define-values
  (thread-group-add!)
  (lambda (parent_1 child_0)
    (begin
      (start-atomic)
      (begin0
        (let-values ()
          (let-values (((t_7) (thread-group-chain-end parent_1)))
            (let-values (((n_7) (node2.1 child_0 t_7 #f)))
              (begin
                (if t_7 (set-node-next! t_7 n_7) (set-thread-group-chain-start! parent_1 n_7))
                (set-thread-group-chain-end! parent_1 n_7)
                (hash-set! (thread-group-children parent_1) child_0 n_7)
                (if (1/thread-group? child_0)
                  (void)
                  (let-values () (set! num-threads-in-groups (add1 num-threads-in-groups))))))))
        (end-atomic)))))
 (define-values
  (thread-group-remove!)
  (lambda (parent_2 child_1)
    (begin
      (start-atomic)
      (begin0
        (let-values ()
          (let-values (((children_0) (thread-group-children parent_2)))
            (let-values (((n_8) (hash-ref children_0 child_1)))
              (begin
                (hash-remove! children_0 child_1)
                (if (node-next n_8)
                  (set-node-prev! (node-next n_8) (node-prev n_8))
                  (set-thread-group-chain-end! parent_2 (node-prev n_8)))
                (if (node-prev n_8)
                  (set-node-next! (node-prev n_8) (node-next n_8))
                  (set-thread-group-chain-start! parent_2 (node-next n_8)))
                (if (eq? n_8 (thread-group-chain parent_2))
                  (let-values () (set-thread-group-chain! parent_2 (node-next n_8)))
                  (void))
                (if (1/thread-group? child_1)
                  (void)
                  (let-values () (set! num-threads-in-groups (sub1 num-threads-in-groups))))))))
        (end-atomic)))))
 (define-values
  (thread-group-all-threads)
  (lambda (parent_3 accum_0)
    (if (not (1/thread-group? parent_3))
      (let-values () (cons parent_3 accum_0))
      (let-values ()
        ((letrec-values (((loop_3)
                          (lambda (n_9 accum_1)
                            (if (not n_9)
                              (let-values () accum_1)
                              (let-values ()
                                (loop_3 (node-next n_9) (thread-group-all-threads (node-child n_9) accum_1)))))))
           loop_3)
         (thread-group-chain-start parent_3)
         accum_0)))))
 (define-values
  (struct:schedule-info
   schedule-info1.1
   schedule-info?
   schedule-info-did-work?
   schedule-info-timeout-at
   set-schedule-info-did-work?!
   set-schedule-info-timeout-at!)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type 'schedule-info #f 2 0 #f null (current-inspector) #f '() #f 'schedule-info)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'did-work?)
     (make-struct-field-accessor -ref_0 1 'timeout-at)
     (make-struct-field-mutator -set!_0 0 'did-work?)
     (make-struct-field-mutator -set!_0 1 'timeout-at))))
 (define-values
  (make-schedule-info6.1)
  (lambda (did-work?2_0 did-work?4_0 timeout-at3_0 timeout-at5_0)
    (let-values (((did-work?_0) (if did-work?4_0 did-work?2_0 #t)))
      (let-values (((timeout-at_0) (if timeout-at5_0 timeout-at3_0 #f)))
        (let-values () (schedule-info1.1 did-work?_0 timeout-at_0))))))
 (define-values
  (schedule-info-add-timeout-at!)
  (lambda (sched-info_0 timeout-at_1)
    (let-values (((tm_0) (schedule-info-timeout-at sched-info_0)))
      (set-schedule-info-timeout-at! sched-info_0 (if tm_0 (min tm_0 timeout-at_1) timeout-at_1)))))
 (define-values
  (struct:thread
   thread1.1
   1/thread?
   thread-name
   thread-engine
   thread-parent
   thread-sleep-until
   thread-sched-info
   thread-suspend-to-kill?
   thread-kill-callback
   thread-dead-sema
   1/thread-dead-evt
   thread-suspended?
   thread-suspended-sema
   thread-pending-break?
   set-thread-engine!
   set-thread-sleep-until!
   set-thread-sched-info!
   set-thread-kill-callback!
   set-thread-dead-sema!
   set-thread-dead-evt!
   set-thread-suspended?!
   set-thread-suspended-sema!
   set-thread-pending-break?!)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'thread
                     #f
                     12
                     0
                     #f
                     (list
                      (cons 1/prop:evt (lambda (t_13) (wrap-evt6.1 (get-thread-dead-evt t_13) (lambda (v_21) t_13))))
                      (cons
                       prop:waiter
                       (let-values (((temp17_0) (lambda (t_14 cb_1) (thread-internal-suspend! t_14 #f cb_1)))
                                    ((temp18_0) (lambda (t_15 v_22) (begin (thread-internal-resume! t_15) v_22))))
                         (make-waiter-methods6.1 temp18_0 temp17_0))))
                     (current-inspector)
                     #f
                     '(0 2 5)
                     #f
                     'thread)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'name)
     (make-struct-field-accessor -ref_0 1 'engine)
     (make-struct-field-accessor -ref_0 2 'parent)
     (make-struct-field-accessor -ref_0 3 'sleep-until)
     (make-struct-field-accessor -ref_0 4 'sched-info)
     (make-struct-field-accessor -ref_0 5 'suspend-to-kill?)
     (make-struct-field-accessor -ref_0 6 'kill-callback)
     (make-struct-field-accessor -ref_0 7 'dead-sema)
     (make-struct-field-accessor -ref_0 8 'dead-evt)
     (make-struct-field-accessor -ref_0 9 'suspended?)
     (make-struct-field-accessor -ref_0 10 'suspended-sema)
     (make-struct-field-accessor -ref_0 11 'pending-break?)
     (make-struct-field-mutator -set!_0 1 'engine)
     (make-struct-field-mutator -set!_0 3 'sleep-until)
     (make-struct-field-mutator -set!_0 4 'sched-info)
     (make-struct-field-mutator -set!_0 6 'kill-callback)
     (make-struct-field-mutator -set!_0 7 'dead-sema)
     (make-struct-field-mutator -set!_0 8 'dead-evt)
     (make-struct-field-mutator -set!_0 9 'suspended?)
     (make-struct-field-mutator -set!_0 10 'suspended-sema)
     (make-struct-field-mutator -set!_0 11 'pending-break?))))
 (define-values
  (do-make-thread8.1)
  (lambda (initial?2_0 initial?4_0 suspend-to-kill?3_0 suspend-to-kill?5_0 who6_0 proc7_0)
    (let-values (((who_0) who6_0))
      (let-values (((proc_1) proc7_0))
        (let-values (((initial?_0) (if initial?4_0 initial?2_0 #f)))
          (let-values (((suspend-to-kill?_0) (if suspend-to-kill?5_0 suspend-to-kill?3_0 #f)))
            (let-values ()
              (let-values ((()
                            (begin
                              (if ((lambda (proc_2) (if (procedure? proc_2) (procedure-arity-includes? proc_2 0) #f))
                                   proc_1)
                                (void)
                                (let-values () (raise-argument-error who_0 "(procedure-arity-includes?/c 0)" proc_1)))
                              (values))))
                (let-values (((p_0) (1/current-thread-group)))
                  (let-values (((bc_0) (if initial?_0 break-enabled-default-cell (current-break-enabled-cell))))
                    (let-values (((e_1)
                                  (make-engine (lambda () (with-continuation-mark 1/break-enabled-key bc_0 (proc_1))))))
                      (let-values (((t_16) (thread1.1 (gensym) e_1 p_0 #f #f suspend-to-kill?_0 #f #f #f #f #f #f)))
                        (begin (thread-group-add! p_0 t_16) t_16)))))))))))))
 (define-values
  (make-thread)
  (let-values (((thread_0)
                (lambda (proc_3)
                  (let-values (((temp19_0) 'thread) ((proc20_0) proc_3))
                    (do-make-thread8.1 #f #f #f #f temp19_0 proc20_0)))))
    thread_0))
 (define-values
  (make-initial-thread)
  (lambda (thunk_0)
    (let-values (((temp24_0) 'thread) ((thunk25_0) thunk_0) ((temp26_0) #t))
      (do-make-thread8.1 temp26_0 #t #f #f temp24_0 thunk25_0))))
 (define-values
  (1/thread-running?)
  (lambda (t_17)
    (begin
      (if (1/thread? t_17) (void) (let-values () (raise-argument-error 'thread-running? "thread?" t_17)))
      (if (not (eq? 'done (thread-engine t_17))) (not (thread-suspended? t_17)) #f))))
 (define-values
  (1/thread-dead?)
  (lambda (t_18)
    (begin
      (if (1/thread? t_18) (void) (let-values () (raise-argument-error 'thread-dead? "thread?" t_18)))
      (eq? 'done (thread-engine t_18)))))
 (define-values
  (thread-dead!)
  (lambda (t_19)
    (begin
      (set-thread-engine! t_19 'done)
      (if (thread-dead-sema t_19) (let-values () (semaphore-post-all (thread-dead-sema t_19))) (void))
      (thread-group-remove! (thread-parent t_19) t_19)
      (remove-from-sleeping-threads! t_19))))
 (define-values
  (1/thread-wait)
  (lambda (t_20)
    (begin
      (if (1/thread? t_20) (void) (let-values () (raise-argument-error 'thread-wait "thread?" t_20)))
      (1/semaphore-wait (get-thread-dead-sema t_20)))))
 (define-values
  (struct:dead-evt dead-evt11.1 dead-evt? dead-evt-sema)
  (let-values (((struct:_15 make-_15 ?_15 -ref_15 -set!_15)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'thread-dead-evt
                     #f
                     1
                     0
                     #f
                     (list (cons 1/prop:evt (lambda (tde_0) (wrap-evt6.1 (dead-evt-sema tde_0) (lambda (s_9) tde_0)))))
                     (current-inspector)
                     #f
                     '(0)
                     #f
                     'dead-evt)))))
    (values struct:_15 make-_15 ?_15 (make-struct-field-accessor -ref_15 0 'sema))))
 (define-values
  (get-thread-dead-evt)
  (let-values (((thread-dead-evt_0)
                (lambda (t_21)
                  (begin
                    (if (1/thread? t_21) (void) (let-values () (raise-argument-error 'thread-dead-evt "thread?" t_21)))
                    (start-atomic)
                    (begin0
                      (let-values ()
                        (if (1/thread-dead-evt t_21)
                          (void)
                          (let-values () (set-thread-dead-evt! t_21 (dead-evt11.1 (get-thread-dead-sema t_21))))))
                      (end-atomic))
                    (1/thread-dead-evt t_21)))))
    thread-dead-evt_0))
 (define-values
  (get-thread-dead-sema)
  (lambda (t_22)
    (begin
      (start-atomic)
      (begin0
        (let-values ()
          (if (thread-dead-sema t_22)
            (void)
            (let-values ()
              (begin
                (set-thread-dead-sema! t_22 (1/make-semaphore 0))
                (if (eq? 'done (thread-engine t_22))
                  (let-values () (semaphore-post-all (thread-dead-sema t_22)))
                  (void))))))
        (end-atomic))
      (thread-dead-sema t_22))))
 (define-values (sleeping-threads) empty-tree)
 (define-values
  (remove-from-sleeping-threads!)
  (lambda (t_23)
    (let-values (((sleep-until_0) (thread-sleep-until t_23)))
      (if sleep-until_0
        (let-values ()
          (let-values ((() (begin (set-thread-sleep-until! t_23 #f) (values))))
            (let-values (((threads_0) (lookup sleeping-threads sleep-until_0 <)))
              (let-values ((()
                            (begin
                              (if threads_0
                                (void)
                                (let-values () (internal-error "thread not found among sleeping threads")))
                              (values))))
                (let-values (((new-threads_0) (hash-remove threads_0 t_23)))
                  (set! sleeping-threads
                    (if (zero? (hash-count new-threads_0))
                      (delete sleeping-threads sleep-until_0 <)
                      (insert sleeping-threads sleep-until_0 new-threads_0 <))))))))
        (void)))))
 (define-values
  (add-to-sleeping-threads!)
  (lambda (t_24 timeout-at_2)
    (begin
      (set-thread-sleep-until! t_24 timeout-at_2)
      (set! sleeping-threads
        (insert
         sleeping-threads
         timeout-at_2
         (hash-set
          (let-values (((or-part_0) (lookup sleeping-threads timeout-at_2 <))) (if or-part_0 or-part_0 '#hasheq()))
          t_24
          #t)
         <)))))
 (define-values
  (thread-internal-suspend!)
  (lambda (t_25 timeout-at_3 kill-callback_0)
    (begin
      (start-atomic)
      (begin0
        (let-values ()
          (begin
            (set-thread-kill-callback! t_25 kill-callback_0)
            (thread-group-remove! (thread-parent t_25) t_25)
            (if timeout-at_3 (let-values () (add-to-sleeping-threads! t_25 timeout-at_3)) (void))
            (if (eq? t_25 (1/current-thread)) (let-values () (thread-did-work!)) (void))
            (lambda () (if (eq? t_25 (1/current-thread)) (let-values () (engine-block)) (void)))))
        (end-atomic)))))
 (define-values
  (thread-internal-resume!)
  (lambda (t_26)
    (begin
      (set-thread-kill-callback! t_26 #f)
      (remove-from-sleeping-threads! t_26)
      (thread-group-add! (thread-parent t_26) t_26))))
 (define-values
  (1/thread-suspend)
  (lambda (t_27)
    (begin
      (if (1/thread? t_27) (void) (let-values () (raise-argument-error 'thread-suspend "thread?" t_27)))
      ((begin
         (start-atomic)
         (begin0
           (let-values ()
             (begin
               (if (thread-suspended? t_27)
                 (void)
                 (let-values ()
                   (begin
                     (set-thread-suspended?! t_27 #t)
                     (if (thread-suspended-sema t_27)
                       (let-values ()
                         (begin (semaphore-post-all (thread-suspended-sema t_27)) (set-thread-suspended-sema! t_27 #f)))
                       (void)))))
               (if (thread-parent t_27) (let-values () (thread-internal-suspend! t_27 #f void)) (let-values () void))))
           (end-atomic)))))))
 (define-values
  (thread-yield)
  (lambda (sched-info_1)
    (begin
      (start-atomic)
      (begin0
        (let-values ()
          (begin
            (if (let-values (((or-part_1) (not sched-info_1)))
                  (if or-part_1 or-part_1 (schedule-info-did-work? sched-info_1)))
              (let-values () (thread-did-work!))
              (let-values () (thread-did-no-work!)))
            (set-thread-sched-info! (1/current-thread) sched-info_1)))
        (end-atomic))
      (engine-block))))
 (define-values
  (1/sleep)
  (let-values (((sleep14_0)
                (lambda (secs12_0 secs13_0)
                  (let-values (((secs_0) (if secs13_0 secs12_0 0)))
                    (let-values ()
                      (begin
                        (if ((lambda (c_2) (if (real? c_2) (>= c_2 0) #f)) secs_0)
                          (void)
                          (let-values () (raise-argument-error 'sleep "(>=/c 0)" secs_0)))
                        ((thread-internal-suspend!
                          (1/current-thread)
                          (+ (* secs_0 1000.0) (current-inexact-milliseconds))
                          void))))))))
    (case-lambda (() (sleep14_0 #f #f)) ((secs12_1) (sleep14_0 secs12_1 #t)))))
 (define-values (poll-done-threads) '#hasheq())
 (define-values
  (thread-did-no-work!)
  (lambda () (set! poll-done-threads (hash-set poll-done-threads (1/current-thread)))))
 (define-values (thread-did-work!) (lambda () (set! poll-done-threads '#hasheq())))
 (define-values (1/break-enabled-key) (gensym))
 (define-values (break-enabled-default-cell) (make-thread-cell #t #t))
 (define-values
  (current-break-enabled-cell)
  (lambda ()
    (let-values (((or-part_2)
                  (continuation-mark-set-first
                   #f
                   1/break-enabled-key
                   break-enabled-default-cell
                   (root-continuation-prompt-tag))))
      (if or-part_2 or-part_2 break-enabled-default-cell))))
 (define-values
  (1/check-for-break)
  (lambda ()
    (let-values (((t_28) (1/current-thread)))
      (if (thread-pending-break? t_28)
        (let-values ()
          (if (thread-cell-ref (current-break-enabled-cell))
            (let-values ()
              (begin
                (set-thread-pending-break?! t_28 #f)
                (call-with-escape-continuation
                 (lambda (k_0) (raise (exn:break "user break" (current-continuation-marks) k_0))))))
            (void)))
        (void)))))
 (define-values
  (1/break-thread)
  (lambda (t_29)
    (begin
      (if (1/thread? t_29) (void) (let-values () (raise-argument-error 'break-thread "thread?" t_29)))
      (if (thread-pending-break? t_29)
        (void)
        (let-values ()
          (begin
            (set-thread-pending-break?! t_29 #t)
            (if (eq? t_29 (1/current-thread)) (let-values () (1/check-for-break)) (void))))))))
 (define-values
  (struct:channel channel1.1 1/channel? channel-get-queue channel-put-queue)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'channel
                     #f
                     2
                     0
                     #f
                     (list
                      (cons 1/prop:evt (poller1.1 (lambda (ch_0 poll-ctx_10) (channel-get/poll ch_0 poll-ctx_10)))))
                     (current-inspector)
                     #f
                     '(0 1)
                     #f
                     'channel)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'get-queue)
     (make-struct-field-accessor -ref_0 1 'put-queue))))
 (define-values
  (struct:channel-put-evt channel-put-evt2.1 1/channel-put-evt? channel-put-evt-ch channel-put-evt-v)
  (let-values (((struct:_16 make-_16 ?_16 -ref_16 -set!_16)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'channel-put-evt
                     #f
                     2
                     0
                     #f
                     (list
                      (cons
                       1/prop:evt
                       (poller1.1
                        (lambda (cp_0 poll-ctx_11)
                          (channel-put/poll (channel-put-evt-ch cp_0) (channel-put-evt-v cp_0) cp_0 poll-ctx_11)))))
                     (current-inspector)
                     #f
                     '(0 1)
                     #f
                     'channel-put-evt)))))
    (values
     struct:_16
     make-_16
     ?_16
     (make-struct-field-accessor -ref_16 0 'ch)
     (make-struct-field-accessor -ref_16 1 'v))))
 (define-values
  (struct:channel-select-waiter channel-select-waiter3.1 channel-select-waiter? channel-select-waiter-thread)
  (let-values (((struct:_17 make-_17 ?_17 -ref_17 -set!_17)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'channel-select-waiter
                     struct:select-waiter
                     1
                     0
                     #f
                     null
                     (current-inspector)
                     #f
                     '(0)
                     #f
                     'channel-select-waiter)))))
    (values struct:_17 make-_17 ?_17 (make-struct-field-accessor -ref_17 0 'thread))))
 (define-values (1/make-channel) (lambda () (channel1.1 (make-queue) (make-queue))))
 (define-values
  (channel-get)
  (lambda (ch_1)
    (let-values ((()
                  (begin
                    (if (1/channel? ch_1) (void) (let-values () (raise-argument-error 'channel-get "channel?" ch_1)))
                    (values))))
      (let-values (((b_0) (box #f)))
        (begin
          ((begin
             (start-atomic)
             (begin0
               (let-values ()
                 (let-values (((pw+v_0) (queue-remove! (channel-put-queue ch_1))))
                   (let-values (((gw_0) (1/current-thread)))
                     (if (not pw+v_0)
                       (let-values ()
                         (let-values (((gq_0) (channel-get-queue ch_1)))
                           (let-values (((n_7) (queue-add! gq_0 (cons gw_0 b_0))))
                             (waiter-suspend! gw_0 (lambda () (queue-remove-node! gq_0 n_7))))))
                       (let-values () (begin (set-box! b_0 (cdr pw+v_0)) (waiter-resume! (car pw+v_0) (void)) void))))))
               (end-atomic))))
          (unbox b_0))))))
 (define-values
  (channel-get/poll)
  (lambda (ch_2 poll-ctx_12)
    (let-values (((pw+v_1) (queue-fremove! (channel-put-queue ch_2) not-matching-select-waiter)))
      (if pw+v_1
        (let-values () (begin (waiter-resume! (car pw+v_1) (void)) (values (list (cdr pw+v_1)) #f)))
        (if (poll-ctx-poll? poll-ctx_12)
          (let-values () (values #f the-never-evt))
          (let-values ()
            (let-values (((b_1) (box #f)))
              (let-values (((gq_1) (channel-get-queue ch_2)))
                (let-values (((gw_1) (channel-select-waiter3.1 (poll-ctx-select-proc poll-ctx_12) (1/current-thread))))
                  (let-values (((n_10) (queue-add! gq_1 (cons gw_1 b_1))))
                    (values
                     #f
                     (wrap-evt6.1
                      (nack-evt8.1 the-async-evt (lambda () (queue-remove-node! gq_1 n_10)))
                      (lambda (v_23) (unbox b_1))))))))))))))
 (define-values
  (channel-put)
  (lambda (ch_3 v_24)
    (begin
      (if (1/channel? ch_3) (void) (let-values () (raise-argument-error 'channel-put "channel?" ch_3)))
      ((begin
         (start-atomic)
         (begin0
           (let-values ()
             (let-values (((gw+b_0) (queue-remove! (channel-get-queue ch_3))))
               (let-values (((pw_0) (1/current-thread)))
                 (if (not gw+b_0)
                   (let-values ()
                     (let-values (((pq_0) (channel-put-queue ch_3)))
                       (let-values (((n_11) (queue-add! pq_0 (cons pw_0 v_24))))
                         (waiter-suspend! pw_0 (lambda () (queue-remove-node! pq_0 n_11))))))
                   (let-values () (begin (set-box! (cdr gw+b_0) v_24) (waiter-resume! (car gw+b_0) v_24) void))))))
           (end-atomic))))
      (void))))
 (define-values
  (channel-put/poll)
  (lambda (ch_4 v_25 result_1 poll-ctx_13)
    (let-values (((gw+b_1) (queue-fremove! (channel-get-queue ch_4) not-matching-select-waiter)))
      (if (not gw+b_1)
        (let-values ()
          (let-values (((pq_1) (channel-put-queue ch_4)))
            (let-values (((pw_1) (channel-select-waiter3.1 (poll-ctx-select-proc poll-ctx_13) (1/current-thread))))
              (let-values (((n_12) (queue-add! pq_1 (cons pw_1 v_25))))
                (values
                 #f
                 (wrap-evt6.1
                  (nack-evt8.1 the-async-evt (lambda () (queue-remove-node! pq_1 n_12)))
                  (lambda (v_26) result_1)))))))
        (if (poll-ctx-poll? poll-ctx_13)
          (let-values () (values #f the-async-evt))
          (let-values ()
            (begin (set-box! (cdr gw+b_1) v_25) (waiter-resume! (car gw+b_1) v_25) (values (list result_1) #f))))))))
 (define-values
  (not-matching-select-waiter)
  (lambda (w+b/v_0)
    (let-values (((w_9) (car w+b/v_0)))
      (let-values (((or-part_3) (not (channel-select-waiter? w_9))))
        (if or-part_3 or-part_3 (not (eq? (1/current-thread) (channel-select-waiter-thread w_9))))))))
 (define-values
  (struct:syncing
   syncing1.1
   syncing?
   syncing-selected
   syncing-syncers
   syncing-wakeup
   set-syncing-selected!
   set-syncing-syncers!
   set-syncing-wakeup!)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values () (make-struct-type 'syncing #f 3 0 #f null (current-inspector) #f '() #f 'syncing)))))
    (values
     struct:_0
     make-_0
     ?_0
     (make-struct-field-accessor -ref_0 0 'selected)
     (make-struct-field-accessor -ref_0 1 'syncers)
     (make-struct-field-accessor -ref_0 2 'wakeup)
     (make-struct-field-mutator -set!_0 0 'selected)
     (make-struct-field-mutator -set!_0 1 'syncers)
     (make-struct-field-mutator -set!_0 2 'wakeup))))
 (define-values
  (struct:syncer
   syncer2.1
   syncer?
   syncer-evt
   syncer-wraps
   syncer-nacks
   syncer-prev
   syncer-next
   set-syncer-evt!
   set-syncer-wraps!
   set-syncer-nacks!
   set-syncer-prev!
   set-syncer-next!)
  (let-values (((struct:_18 make-_18 ?_18 -ref_18 -set!_18)
                (let-values ()
                  (let-values () (make-struct-type 'syncer #f 5 0 #f null (current-inspector) #f '() #f 'syncer)))))
    (values
     struct:_18
     make-_18
     ?_18
     (make-struct-field-accessor -ref_18 0 'evt)
     (make-struct-field-accessor -ref_18 1 'wraps)
     (make-struct-field-accessor -ref_18 2 'nacks)
     (make-struct-field-accessor -ref_18 3 'prev)
     (make-struct-field-accessor -ref_18 4 'next)
     (make-struct-field-mutator -set!_18 0 'evt)
     (make-struct-field-mutator -set!_18 1 'wraps)
     (make-struct-field-mutator -set!_18 2 'nacks)
     (make-struct-field-mutator -set!_18 3 'prev)
     (make-struct-field-mutator -set!_18 4 'next))))
 (define-values (none-syncer) (syncer2.1 #f null null #f #f))
 (define-values
  (do-sync)
  (lambda (who_1 timeout_0 args_0)
    (let-values ((()
                  (begin
                    (if ((lambda (timeout_1)
                           (let-values (((or-part_4) (not timeout_1)))
                             (if or-part_4
                               or-part_4
                               (let-values (((or-part_5) (if (real? timeout_1) (>= timeout_1 0) #f)))
                                 (if or-part_5
                                   or-part_5
                                   (if (procedure? timeout_1) (procedure-arity-includes? timeout_1 0) #f))))))
                         timeout_0)
                      (void)
                      (let-values ()
                        (raise-argument-error who_1 "(or/c #f (and/c real? (not/c negative?)) (-> any))" timeout_0)))
                    (values))))
      (let-values (((syncers_0)
                    ((letrec-values (((loop_4)
                                      (lambda (args_1 first_0 last_0)
                                        (if (null? args_1)
                                          (let-values () first_0)
                                          (let-values ()
                                            (let-values (((arg_0) (car args_1)))
                                              (let-values ((()
                                                            (begin
                                                              (if (1/evt? arg_0)
                                                                (void)
                                                                (let-values ()
                                                                  (raise-argument-error who_1 "evt?" arg_0)))
                                                              (values))))
                                                (let-values (((sr_0) (syncer2.1 arg_0 null null last_0 #f)))
                                                  (begin
                                                    (if last_0 (let-values () (set-syncer-next! last_0 sr_0)) (void))
                                                    (loop_4
                                                     (cdr args_1)
                                                     (let-values (((or-part_6) first_0)) (if or-part_6 or-part_6 sr_0))
                                                     sr_0))))))))))
                       loop_4)
                     args_0
                     #f
                     #f)))
        (let-values (((s_10) (syncing1.1 #f syncers_0 void)))
          (if (if (real? timeout_0) (zero? timeout_0) #f)
            (let-values ()
              (let-values (((temp15_0) (lambda (sched-info_2) #f)) ((temp16_0) #t))
                (sync-poll9.1 #f #f temp16_0 #t s_10 temp15_0)))
            (if (procedure? timeout_0)
              (let-values ()
                (let-values (((temp18_1) (lambda (sched-info_3) (timeout_0))) ((temp19_1) #t))
                  (sync-poll9.1 #f #f temp19_1 #t s_10 temp18_1)))
              (let-values ()
                (let-values (((timeout-at_4) (if timeout_0 (+ (* timeout_0 1000) (current-inexact-milliseconds)) #f)))
                  ((letrec-values (((loop_5)
                                    (lambda (did-work?_1)
                                      (if (if timeout_0 (>= timeout_0 (current-inexact-milliseconds)) #f)
                                        (let-values () (begin (syncing-done! s_10 none-syncer) #f))
                                        (if (if (all-asynchronous? s_10) (not (syncing-selected s_10)) #f)
                                          (let-values () (begin (suspend-syncing-thread s_10 timeout-at_4) (loop_5 #f)))
                                          (let-values ()
                                            (let-values (((did-work?21_0) did-work?_1)
                                                         ((temp22_0)
                                                          (lambda (sched-info_4)
                                                            (begin
                                                              (if timeout-at_4
                                                                (let-values ()
                                                                  (schedule-info-add-timeout-at!
                                                                   sched-info_4
                                                                   timeout-at_4))
                                                                (void))
                                                              (thread-yield sched-info_4)
                                                              (loop_5 #f)))))
                                              (sync-poll9.1 did-work?21_0 #t #f #f s_10 temp22_0))))))))
                     loop_5)
                   #t))))))))))
 (define-values (1/sync) (lambda args_2 (do-sync 'sync #f args_2)))
 (define-values (1/sync/timeout) (lambda (timeout_2 . args_3) (do-sync 'sync/timeout timeout_2 args_3)))
 (define-values
  (sync-poll9.1)
  (lambda (did-work?4_1 did-work?6_0 just-poll?3_0 just-poll?5_0 s7_0 none-k8_0)
    (let-values (((s_11) s7_0))
      (let-values (((none-k_0) none-k8_0))
        (let-values (((just-poll?_0) (if just-poll?5_0 just-poll?3_0 #f)))
          (let-values (((did-work?_2) (if did-work?6_0 did-work?4_1 #f)))
            (let-values ()
              (let-values (((sched-info_5)
                            (let-values (((did-work?23_0) did-work?_2))
                              (make-schedule-info6.1 did-work?23_0 #t #f #f))))
                ((letrec-values (((loop_6)
                                  (lambda (sr_1)
                                    ((begin
                                       (start-atomic)
                                       (begin0
                                         (let-values ()
                                           (let-values (((c1_0) (syncing-selected s_11)))
                                             (if c1_0
                                               ((lambda (sr_2) (make-result-thunk sr_2 (list (syncer-evt sr_2)))) c1_0)
                                               (if (not sr_1)
                                                 (let-values ()
                                                   (begin
                                                     (if just-poll?_0
                                                       (let-values () (syncing-done! s_11 none-syncer))
                                                       (void))
                                                     (lambda () (none-k_0 sched-info_5))))
                                                 (let-values ()
                                                   (let-values (((results_0 new-evt_0)
                                                                 (evt-poll
                                                                  (syncer-evt sr_1)
                                                                  (poll-ctx2.1
                                                                   just-poll?_0
                                                                   (lambda () (syncing-done! s_11 sr_1))
                                                                   sched-info_5))))
                                                     (if results_0
                                                       (let-values ()
                                                         (begin
                                                           (syncing-done! s_11 sr_1)
                                                           (make-result-thunk sr_1 results_0)))
                                                       (if (wrap-evt? new-evt_0)
                                                         (let-values ()
                                                           (begin
                                                             (set-syncer-wraps!
                                                              sr_1
                                                              (cons
                                                               (wrap-evt-wrap new-evt_0)
                                                               (let-values (((l_1) (syncer-wraps sr_1)))
                                                                 (if (if (null? l_1) (not (1/handle-evt? new-evt_0)) #f)
                                                                   (list values)
                                                                   l_1))))
                                                             (set-syncer-evt! sr_1 (wrap-evt-evt new-evt_0))
                                                             (lambda () (loop_6 sr_1))))
                                                         (if (nack-evt? new-evt_0)
                                                           (let-values ()
                                                             (begin
                                                               (set-syncer-nacks!
                                                                sr_1
                                                                (cons
                                                                 (nack-evt-nack-proc new-evt_0)
                                                                 (syncer-nacks sr_1)))
                                                               (set-syncer-evt! sr_1 (nack-evt-evt new-evt_0))
                                                               (lambda () (loop_6 sr_1))))
                                                           (if (guard-evt? new-evt_0)
                                                             (let-values ()
                                                               (lambda ()
                                                                 (let-values (((generated_0)
                                                                               ((guard-evt-proc new-evt_0))))
                                                                   (begin
                                                                     (set-syncer-evt!
                                                                      sr_1
                                                                      (if (1/evt? generated_0)
                                                                        generated_0
                                                                        (wrap-evt6.1
                                                                         the-always-evt
                                                                         (lambda (a_0) generated_0))))
                                                                     (loop_6 sr_1)))))
                                                             (if (if (never-evt? new-evt_0)
                                                                   (null? (syncer-nacks sr_1))
                                                                   #f)
                                                               (let-values ()
                                                                 (begin
                                                                   (if (syncer-prev sr_1)
                                                                     (set-syncer-next!
                                                                      (syncer-prev sr_1)
                                                                      (syncer-next sr_1))
                                                                     (set-syncing-syncers! s_11 (syncer-next sr_1)))
                                                                   (if (syncer-next sr_1)
                                                                     (let-values ()
                                                                       (set-syncer-prev!
                                                                        (syncer-next sr_1)
                                                                        (syncer-prev sr_1)))
                                                                     (void))
                                                                   (lambda () (loop_6 (syncer-next sr_1)))))
                                                               (let-values ()
                                                                 (begin
                                                                   (set-syncer-evt! sr_1 new-evt_0)
                                                                   (lambda () (loop_6 (syncer-next sr_1))))))))))))))))
                                         (end-atomic)))))))
                   loop_6)
                 (syncing-syncers s_11))))))))))
 (define-values
  (make-result-thunk)
  (lambda (sr_3 results_1)
    (let-values (((wraps_0) (syncer-wraps sr_3)))
      (lambda ()
        ((letrec-values (((loop_7)
                          (lambda (wraps_1 results_2)
                            (if (null? wraps_1)
                              (let-values () (apply values results_2))
                              (if (null? (cdr wraps_1))
                                (let-values () (apply (car wraps_1) results_2))
                                (let-values ()
                                  (loop_7
                                   (cdr wraps_1)
                                   (call-with-values (lambda () (apply (car wraps_1) results_2)) list))))))))
           loop_7)
         wraps_0
         results_1)))))
 (define-values
  (syncing-done!)
  (lambda (s_12 selected-sr_0)
    (begin
      (set-syncing-selected! s_12 selected-sr_0)
      ((letrec-values (((loop_8)
                        (lambda (sr_4)
                          (if sr_4
                            (let-values ()
                              (begin
                                (if (eq? sr_4 selected-sr_0)
                                  (void)
                                  (let-values ()
                                    (begin
                                      (let-values (((lst_0) (syncer-nacks sr_4)))
                                        (begin
                                          (check-list lst_0)
                                          ((letrec-values (((for-loop_0)
                                                            (lambda (lst_1)
                                                              (if (pair? lst_1)
                                                                (let-values (((nack_0) (unsafe-car lst_1))
                                                                             ((rest_0) (unsafe-cdr lst_1)))
                                                                  (let-values ((()
                                                                                (let-values ()
                                                                                  (let-values ((()
                                                                                                (let-values ()
                                                                                                  (begin
                                                                                                    (let-values ()
                                                                                                      (nack_0))
                                                                                                    (values)))))
                                                                                    (values)))))
                                                                    (if (not #f) (for-loop_0 rest_0) (values))))
                                                                (values)))))
                                             for-loop_0)
                                           lst_0)))
                                      (void))))
                                (loop_8 (syncer-next sr_4))))
                            (void)))))
         loop_8)
       (syncing-syncers s_12))
      ((syncing-wakeup s_12)))))
 (define-values
  (all-asynchronous?)
  (lambda (s_13)
    (begin
      (start-atomic)
      (begin0
        (let-values ()
          ((letrec-values (((loop_9)
                            (lambda (sr_5)
                              (if (not sr_5)
                                (let-values () #t)
                                (if (async-evt? (syncer-evt sr_5))
                                  (let-values () (loop_9 (syncer-next sr_5)))
                                  (let-values () #f))))))
             loop_9)
           (syncing-syncers s_13)))
        (end-atomic)))))
 (define-values
  (suspend-syncing-thread)
  (lambda (s_14 timeout-at_5)
    ((begin
       (start-atomic)
       (begin0
         (let-values ()
           (if (syncing-selected s_14)
             (let-values () void)
             (let-values ()
               (let-values (((t_30) (1/current-thread)))
                 (begin
                   (set-syncing-wakeup!
                    s_14
                    (lambda () (begin (set-syncing-wakeup! s_14 void) (thread-internal-resume! t_30))))
                   (thread-internal-suspend!
                    t_30
                    timeout-at_5
                    (lambda ()
                      (if (syncing-selected s_14) (void) (let-values () (syncing-done! s_14 none-syncer))))))))))
         (end-atomic))))))
 (define-values (idle-sema) (1/make-semaphore))
 (define-values (wrapped-idle-sema) (wrap-evt6.1 idle-sema void))
 (define-values
  (struct:system-idle-evt system-idle-evt1.1 system-idle-evt?)
  (let-values (((struct:_0 make-_0 ?_0 -ref_0 -set!_0)
                (let-values ()
                  (let-values ()
                    (make-struct-type
                     'system-idle-evt
                     #f
                     0
                     0
                     #f
                     (list (cons 1/prop:evt (lambda (i_0) wrapped-idle-sema)))
                     (current-inspector)
                     #f
                     '()
                     #f
                     'system-idle-evt)))))
    (values struct:_0 make-_0 ?_0)))
 (define-values (the-idle-evt) (system-idle-evt1.1))
 (define-values (get-system-idle-evt) (let-values (((system-idle-evt_0) (lambda () the-idle-evt))) system-idle-evt_0))
 (define-values (any-idle-waiters?) (lambda () (semaphore-any-waiters? idle-sema)))
 (define-values
  (post-idle)
  (lambda () (if (semaphore-any-waiters? idle-sema) (begin (1/semaphore-post idle-sema) #t) #f)))
 (define-values (TICKS) 100000)
 (define-values (call-in-main-thread) (lambda (thunk_1) (begin (make-initial-thread thunk_1) (select-thread!))))
 (define-values
  (select-thread!)
  (lambda ()
    ((letrec-values (((loop_10)
                      (lambda (g_0 none-k_1)
                        (let-values ((() (begin (check-timeouts) (values))))
                          (let-values ((()
                                        (begin
                                          (if (if (all-threads-poll-done?) (maybe-future-work?) #f)
                                            (let-values ()
                                              (let-values (((or-part_7) (post-idle)))
                                                (if or-part_7 or-part_7 (process-sleep))))
                                            (void))
                                          (values))))
                            (let-values (((child_2) (thread-group-next! g_0)))
                              (if (not child_2)
                                (let-values () (none-k_1))
                                (if (1/thread? child_2)
                                  (let-values () (swap-in-thread child_2))
                                  (let-values () (loop_10 child_2 (lambda () (loop_10 g_0 none-k_1))))))))))))
       loop_10)
     root-thread-group
     maybe-done)))
 (define-values
  (swap-in-thread)
  (lambda (t_31)
    (let-values (((e_2) (thread-engine t_31)))
      (begin
        (set-thread-engine! t_31 'running)
        (set-thread-sched-info! t_31 #f)
        (1/current-thread t_31)
        ((letrec-values (((loop_11)
                          (lambda (e_3)
                            (e_3
                             TICKS
                             (lambda () (1/check-for-break))
                             (lambda args_4
                               (begin
                                 (1/current-thread #f)
                                 (if (zero? (current-atomic))
                                   (void)
                                   (let-values () (internal-error "terminated in atomic mode!")))
                                 (thread-dead! t_31)
                                 (thread-did-work!)
                                 (select-thread!)))
                             (lambda (e_4)
                               (if (zero? (current-atomic))
                                 (let-values ()
                                   (begin (1/current-thread #f) (set-thread-engine! t_31 e_4) (select-thread!)))
                                 (let-values () (loop_11 e_4))))))))
           loop_11)
         e_2)))))
 (define-values
  (maybe-done)
  (lambda ()
    (if (if (is-empty? sleeping-threads) (not (any-idle-waiters?)) #f)
      (let-values () (void))
      (let-values () (select-thread!)))))
 (define-values
  (check-timeouts)
  (lambda ()
    (if (is-empty? sleeping-threads)
      (void)
      (let-values ()
        (let-values (((timeout-at_6 threads_1) (min-key+value sleeping-threads)))
          (if (<= timeout-at_6 (current-inexact-milliseconds))
            (let-values ()
              (if (null? threads_1)
                (void)
                (let-values ()
                  (begin
                    (let-values (((ht_3) threads_1))
                      (begin
                        (check-in-hash-keys ht_3)
                        ((letrec-values (((for-loop_1)
                                          (lambda (i_0)
                                            (if i_0
                                              (let-values (((t_32) (hash-iterate-key ht_3 i_0)))
                                                (let-values ((()
                                                              (let-values ()
                                                                (let-values ((()
                                                                              (let-values ()
                                                                                (begin
                                                                                  (let-values ()
                                                                                    (thread-internal-resume! t_32))
                                                                                  (values)))))
                                                                  (values)))))
                                                  (if (not #f) (for-loop_1 (hash-iterate-next ht_3 i_0)) (values))))
                                              (values)))))
                           for-loop_1)
                         (hash-iterate-first ht_3))))
                    (void)
                    (thread-did-work!)))))
            (void)))))))
 (define-values (all-threads-poll-done?) (lambda () (= (hash-count poll-done-threads) num-threads-in-groups)))
 (define-values
  (maybe-future-work?)
  (lambda ()
    (let-values (((or-part_8) (positive? num-threads-in-groups)))
      (if or-part_8
        or-part_8
        (let-values (((or-part_9) (not (is-empty? sleeping-threads)))) (if or-part_9 or-part_9 (any-idle-waiters?)))))))
 (define-values
  (process-sleep)
  (lambda ()
    (let-values (((ts_0) (thread-group-all-threads root-thread-group null)))
      (let-values (((sleep-timeout_0)
                    (if (is-empty? sleeping-threads)
                      (distant-future)
                      (let-values (((timeout-at_7 threads_2) (min-key+value sleeping-threads))) timeout-at_7))))
        (let-values (((timeout-at_8)
                      (let-values (((lst_2) ts_0))
                        (begin
                          (check-list lst_2)
                          ((letrec-values (((for-loop_2)
                                            (lambda (timeout-at_9 lst_3)
                                              (if (pair? lst_3)
                                                (let-values (((t_33) (unsafe-car lst_3)) ((rest_1) (unsafe-cdr lst_3)))
                                                  (let-values (((timeout-at_10)
                                                                (let-values (((timeout-at_11) timeout-at_9))
                                                                  (let-values (((timeout-at_12)
                                                                                (let-values ()
                                                                                  (let-values (((sched-info_6)
                                                                                                (thread-sched-info
                                                                                                 t_33)))
                                                                                    (let-values (((t-timeout-at_0)
                                                                                                  (if sched-info_6
                                                                                                    (schedule-info-timeout-at
                                                                                                     sched-info_6)
                                                                                                    #f)))
                                                                                      (if (not t-timeout-at_0)
                                                                                        (let-values () timeout-at_11)
                                                                                        (let-values ()
                                                                                          (min
                                                                                           timeout-at_11
                                                                                           t-timeout-at_0))))))))
                                                                    (values timeout-at_12)))))
                                                    (if (not #f) (for-loop_2 timeout-at_10 rest_1) timeout-at_10)))
                                                timeout-at_9))))
                             for-loop_2)
                           sleep-timeout_0
                           lst_2)))))
          (begin (sleep (/ (- timeout-at_8 (current-inexact-milliseconds)) 1000.0)) (thread-did-work!)))))))
 (define-values (distant-future) (lambda () (+ (current-inexact-milliseconds) (* 1000.0 60 60 24 365))))
 (define-values
  (1/wrap-evt)
  (lambda (evt_1 proc_4)
    (begin
      (if (1/evt? evt_1) (void) (let-values () (raise-argument-error 'wrap-evt "evt?" evt_1)))
      (if (procedure? proc_4) (void) (let-values () (raise-argument-error 'wrap-evt "procedure?" proc_4)))
      (wrap-evt6.1 evt_1 proc_4))))
 (define-values
  (1/handle-evt)
  (lambda (evt_2 proc_5)
    (begin
      (if (1/evt? evt_2) (void) (let-values () (raise-argument-error 'handle-evt "evt?" evt_2)))
      (if (procedure? proc_5) (void) (let-values () (raise-argument-error 'handle-evt "procedure?" proc_5)))
      (handle-evt7.1 evt_2 proc_5))))
 (define-values
  (guard-evt)
  (lambda (proc_6)
    (begin
      (if ((lambda (v_27) (if (procedure? v_27) (procedure-arity-includes? v_27 0) #f)) proc_6)
        (void)
        (let-values () (raise-argument-error 'guard-evt "(procedure-arity-includes?/c 0)" proc_6)))
      (guard-evt9.1 proc_6))))
 (define-values
  (1/nack-guard-evt)
  (lambda (proc_7)
    (begin
      (if ((lambda (v_28) (if (procedure? v_28) (procedure-arity-includes? v_28 1) #f)) proc_7)
        (void)
        (let-values () (raise-argument-error 'nack-guard-evt "(procedure-arity-includes?/c 1)" proc_7)))
      (guard-evt9.1
       (lambda ()
         (let-values (((s_15) (1/make-semaphore)))
           (let-values (((v_29) (proc_7 (semaphore-peek-evt2.1 s_15))))
             (nack-evt8.1
              (if (1/evt? v_29) v_29 (1/wrap-evt the-always-evt (lambda () v_29)))
              (lambda () (1/semaphore-post s_15))))))))))
 (define-values
  (1/channel-put-evt)
  (lambda (ch_5 v_18)
    (begin
      (if (1/channel? ch_5) (void) (let-values () (raise-argument-error 'channel-put-evt "channel?" ch_5)))
      (channel-put-evt2.1 ch_5 v_18))))
 (define-values
  (1/semaphore-peek-evt)
  (lambda (s_16)
    (begin
      (if (1/semaphore? s_16) (void) (let-values () (raise-argument-error 'semaphore-peek-evt "semaphore?" s_16)))
      (semaphore-peek-evt2.1 s_16)))))
