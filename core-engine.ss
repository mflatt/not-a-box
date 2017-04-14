;; Like Chez's engine API, but
;;   - works with delimites-continuations entensions in "core-control.ss"
;;   - doesn't run winders when suspending or resuming an engine
;;
;; Don't mix Chez engines with this implementation, because we take
;; over the timer.

(define-record engine-state (mc complete expire identity))
(define current-engine-state (chez:make-parameter #f))

(define (make-engine thunk identity)
  (lambda (ticks complete expire)
    (swap-metacontinuation
     empty-metacontinuation
     (lambda (saves)
       (current-engine-state (make-engine-state saves complete expire identity))
       (call-with-current-continuation
        (lambda (k)
          (parameterize ([reset-handler (lambda () (|#%app| k))]
                         [timer-interrupt-handler engine-block])
            (set-timer ticks)
            (call-with-values thunk engine-return))))))))

(define (engine-block)
  (let ([es (current-engine-state)])
    (unless es
      (error 'engine-block "not currently running an engine"))
    (swap-metacontinuation
     (engine-state-mc es)
     (lambda (saves)
       (current-engine-state #f)
       ((engine-state-expire es)
        (make-engine
         (lambda ()
           (swap-metacontinuation
            saves
            (lambda (ignores)
              (void))))
         (engine-state-identity es)))))))

(define (engine-return . args)
  (let ([es (current-engine-state)])
    (unless es
      (error 'engine-return "not currently running an engine"))
    (swap-metacontinuation
     (engine-state-mc es)
     (lambda (saves)
       (let ([remain-ticks (set-timer 0)])
         (current-engine-state #f)
         (apply (engine-state-complete es) remain-ticks args))))))

(define (current-engine-identity)
  (let ([es (current-engine-state)])
    (and es (engine-state-identity es))))
