(import (core))

(define-syntax check
  (syntax-rules ()
    [(_ a b)
     (let ([v a])
       (unless (equal? v b)
         (error 'check (format "failed ~s => ~s" 'a v))))]))

(define tag1 (make-continuation-prompt-tag 'tag1))
(define tag2 (make-continuation-prompt-tag 'tag2))

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

(check (let ([syms null])
         (let ([v (dynamic-wind
                   (lambda () (set! syms (cons 'in syms)))
                   (lambda () 'ok)
                   (lambda () (set! syms (cons 'out syms))))])
           (cons v syms)))
       '(ok out in))

(check (let ([syms null])
         (let ([v (call/cc
                   (lambda (esc)
                     (dynamic-wind
                      (lambda () (set! syms (cons 'in syms)))
                      (lambda () (esc 'esc))
                      (lambda () (set! syms (cons 'out syms))))))])
           (cons v syms)))
       '(esc out in))


(check (let ([syms null])
         (let ([v (call/cc
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

;; Make sure there are no Chez-level excetions handlers when trying this
;; last one:
(current-exception-state (create-exception-state (base-exception-handler)))
(call-with-continuation-prompt
 (lambda ()
   (error 'demo "oops"))
 tag1)
