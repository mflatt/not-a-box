(import (core))

(define-syntax check
  (syntax-rules ()
    [(_ a b)
     (let ([v a])
       (unless (equal? v b)
         (error 'check (format "failed ~s => ~s" 'a v))))]))

(define tag1 (make-continuation-prompt-tag 'tag1))
(define tag2 (make-continuation-prompt-tag 'tag2))

(check (eq? (make-continuation-prompt-tag)
            (make-continuation-prompt-tag))
       #f)

(check (call-with-continuation-prompt
        (lambda () 10))
       10)

(check (call-with-continuation-prompt
        (lambda () 10)
        tag1)
       10)

(check (let ([saved #f])
         (let ([a (call-with-continuation-prompt
                   (lambda ()
                     (+ 10
                        (call-with-composable-continuation
                         (lambda (k)
                           (set! saved k)
                           12)
                         tag1)))
                   tag1)])
           (list a
                 (|#%app| saved -12))))
       (list 22 -2))

(check (let ([saved #f])
         (let ([a (call-with-continuation-prompt
                   (lambda ()
                     (+ 10
                        (call-with-continuation-prompt
                         (lambda ()
                           (call-with-composable-continuation
                            (lambda (k)
                              (set! saved k)
                              12)
                            tag1))
                         tag2)))
                   tag1)])
           (list a
                 (|#%app| saved -12))))
       (list 22 -2))

;; Shouldn't take long or use much memory:
(check (call-with-continuation-prompt
        (lambda ()
          (let loop ([n 1000000])
            (call-with-composable-continuation
             (lambda (k)
               (if (zero? n)
                   'ok
                   ;; In tail position:
                   (loop (sub1 n))))
             tag1)))
        tag1)
       'ok)

;; Also shouldn't take long or use much memory:
(check (let ([old-k (lambda (p) (p))]
             [n 100000])
         (call-with-continuation-prompt
          (lambda ()
            (let loop ()
              ((call-with-composable-continuation
                (lambda (k)
                  (let ([prev-k old-k])
                    (set! old-k k)
                    (|#%app| prev-k (lambda ()
                                      (call-with-composable-continuation
                                       (lambda (k)
                                         (cond
                                          [(zero? n)
                                           (lambda () 'also-ok)]
                                          [else
                                           (set! n (sub1 n))
                                           loop])))))))
                tag1))))
          tag1))
       'also-ok)

(check (let ([t (make-continuation-prompt-tag)])
         (call-with-continuation-prompt
          (lambda ()
            (call-with-continuation-prompt
             (lambda ()
               (abort-current-continuation
                t
                17))
             (make-continuation-prompt-tag)))
          t
          values))
       17)

(check (let ([syms null])
         (let ([v (dynamic-wind
                   (lambda () (set! syms (cons 'in syms)))
                   (lambda () 'ok)
                   (lambda () (set! syms (cons 'out syms))))])
           (cons v syms)))
       '(ok out in))

(check (let ([syms null])
         (let ([v (call-with-current-continuation
                   (lambda (esc)
                     (dynamic-wind
                      (lambda () (set! syms (cons 'in syms)))
                      (lambda () (|#%app| esc 'esc))
                      (lambda () (set! syms (cons 'out syms))))))])
           (cons v syms)))
       '(esc out in))

(check (let ([syms null])
         (let ([v (call-with-current-continuation
                   (lambda (esc)
                     (dynamic-wind
                      (lambda () (set! syms (cons 'in syms)))
                      (lambda ()
                        (call-with-continuation-prompt
                         (lambda ()
                           'in-prompt)))
                      (lambda () (set! syms (cons 'out syms))))))])
           (cons v syms)))
       '(in-prompt out in))

(check (let ([saved #f]
             [syms null])
         (let ([a (call-with-continuation-prompt
                   (lambda ()
                     (dynamic-wind
                      (lambda () (set! syms (cons 'in syms)))
                      (lambda ()
                        (+ 10
                           (call-with-composable-continuation
                            (lambda (k)
                              (set! saved k)
                              12)
                            tag1)))
                      (lambda () (set! syms (cons 'out syms)))))
                   tag1)])
           (let ([b (|#%app| saved -10)])
             (list a
                   b
                   syms))))
       (list 22 0 '(out in out in)))

(check (let ([saved #f])
         (with-continuation-mark
             'x 0
             (let ([a (call-with-continuation-prompt
                       (lambda ()
                         (with-continuation-mark
                             'x 1
                             (begin
                               (call-with-composable-continuation
                                (lambda (k)
                                  (set! saved k)))
                               (continuation-mark-set->list
                                (current-continuation-marks)
                                'x)))))])
               (list a
                     (|#%app| saved #f)))))
       '((1) (1 0)))

(check (call-with-current-continuation
        (lambda (k)
          (|#%app| k 0)))
       0)

(check (call-with-current-continuation
        (lambda (k)
          (call-with-continuation-prompt
           (lambda ()
             (|#%app| k 100))
           tag1)))
       100)

(check (let ([syms null])
         (let ([saved #f])
           (let ([v
                  (call-with-continuation-prompt
                   (lambda ()
                     ;; This metacontinuation frame will be shared between the
                     ;; capture and invocation:
                     (dynamic-wind
                      (lambda () (set! syms (cons 'in0 syms)))
                      (lambda ()
                        (let ([a (call-with-continuation-prompt
                                  (lambda ()
                                    ;; This metacontinuation frame will not
                                    ;; be shared:
                                    (dynamic-wind
                                     (lambda () (set! syms (cons 'in syms)))
                                     (lambda ()
                                       (+ 10
                                          (call-with-current-continuation
                                           (lambda (k)
                                             (set! saved k)
                                             12)
                                           tag1)))
                                     (lambda () (set! syms (cons 'out syms)))))
                                  tag1)])
                          (let ([b (call-with-continuation-prompt
                                    (lambda ()
                                      (|#%app| saved -8))
                                    tag1)])
                            (list a b))))
                      (lambda () (set! syms (cons 'out0 syms))))))])
             (list v syms))))
       (list (list 22 2) '(out0 out in out in in0)))

;; ----------------------------------------
;; Engines

(define e (make-engine (lambda () 'done) #f))
(check (cdr (e 20 void list vector))
       '(done))

(define e-forever (make-engine (lambda () (let loop () (loop))) #f))
(check (vector? (e-forever 10 void list vector))
       #t)

(define e-10 (make-engine (lambda () 
                            (let loop ([n 10])
                              (cond
                               [(zero? n)
                                (engine-return 1 2 3)
                                (loop 0)]
                               [else
                                (engine-block)
                                (loop (sub1 n))])))
                          #f))
(check (let ([started 0])
         (let loop ([e e-10] [n 0])
           (e 100
              (lambda () (set! started (add1 started)))
              (lambda (remain a b c) (list a b c n started))
              (lambda (e)
                (loop e (add1 n))))))
       '(1 2 3 10 11))

;; Check that winders are not run on engine swaps:
(let ([pre 0]
      [post 0])
  (let ([e-10/dw (make-engine (lambda ()
                                (let loop ([n 10])
                                  (cond
                                   [(zero? n)
                                    (values 1 2 3 pre post)]
                                   [else
                                    (engine-block)
                                    (dynamic-wind
                                     (lambda () (set! pre (add1 pre)))
                                     (lambda () (loop (sub1 n)))
                                     (lambda () (set! post (add1 post))))])))
                              #f)])
    (check (let loop ([e e-10/dw] [n 0])
             (e 200
                void
                (lambda (remain a b c pre t-post) (list a b c pre t-post post n))
                (lambda (e)
                  (loop e (add1 n)))))
           '(1 2 3 10 0 10 11))))

;; ----------------------------------------
;; Thread cells (which are really engine cells):

(let ([ut (make-thread-cell 1)]
      [pt (make-thread-cell 100 #t)])
  (define (gen)
    (define u-old (thread-cell-ref ut))
    (define p-old (thread-cell-ref pt))
    (thread-cell-set! ut (add1 u-old))
    (thread-cell-set! pt (add1 p-old))
    (list u-old
          p-old
          (make-engine gen #f)
          (thread-cell-ref ut)
          (thread-cell-ref pt)))
  (define l1 ((make-engine gen #f)
              100
              void
              (lambda (remain l) l)
              (lambda (e) (error 'engine "oops"))))
  (define l2 ((list-ref l1 2)
              100
              void
              (lambda (remain l) l)
              (lambda (e) (error 'engine "oops"))))
  (check (list-ref l1 0) 1)
  (check (list-ref l1 1) 100)
  (check (list-ref l1 3) 2)
  (check (list-ref l1 4) 101)
  (check (list-ref l2 0) 1)
  (check (list-ref l2 1) 101)
  (check (list-ref l2 3) 2)
  (check (list-ref l2 4) 102))

;; ----------------------------------------
;; Parameters:

(define my-param (make-parameter 'init))
(let ([e (parameterize ([my-param 'set])
           (make-engine (lambda () (my-param)) #f))])
  (check 'init (my-param))
  (check 'set (e 100 void (lambda (remain v) v) (lambda (e) (error 'engine "oops")))))

;; ----------------------------------------

(call-with-continuation-prompt
 (lambda ()
   (error 'demo "this is an intended error"))
 tag1)
