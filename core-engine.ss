;; Like Chez's engine API, but
;;   - works with delimites-continuations entensions in "core-control.ss"
;;   - doesn't run winders when suspending or resuming an engine
;;   - accepts an extra "prefix" argument to run code within an engine
;;     just before resuming te engine's continuation
;;
;; Don't mix Chez engines with this implementation, because we take
;; over the timer.

(define-record engine-state (mc complete expire thread-cell-values))
(define current-engine-state (chez:make-parameter #f))

(define root-thread-cell-values (make-weak-eq-hashtable))

(define (make-engine thunk)
  (let ([paramz (current-parameterization)])
    (create-engine (lambda (prefix)
                     (with-continuation-mark
                         parameterization-key paramz
                         (begin
                           (prefix)
                           (call-with-values thunk engine-return))))
                   (new-engine-thread-cell-values))))


(define (create-engine proc thread-cell-values)
  (lambda (ticks prefix complete expire)
    (swap-metacontinuation
     empty-metacontinuation
     (lambda (saves)
       (current-engine-state (make-engine-state saves complete expire thread-cell-values))
       (call-with-current-continuation
        (lambda (k)
          (parameterize ([reset-handler (lambda () (|#%app| k))]
                         [timer-interrupt-handler engine-block])
            (set-timer ticks)
            (proc prefix))))))))

(define (engine-block)
  (let ([es (current-engine-state)])
    (unless es
      (error 'engine-block "not currently running an engine"))
    ;; Extra pair of parens awround swap is to apply a prefix
    ;; function on swapping back in:
    ((swap-metacontinuation
     (engine-state-mc es)
     (lambda (saves)
       (current-engine-state #f)
       ((engine-state-expire es)
        (create-engine
         (lambda (prefix)
           (swap-metacontinuation
            saves
            (lambda (ignored)
              prefix)))
         (engine-state-thread-cell-values es))))))))

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

(define (current-engine-thread-cell-values)
  (let ([es (current-engine-state)])
    (if es
        (engine-state-thread-cell-values es)
        root-thread-cell-values)))

(define (new-engine-thread-cell-values)
  (let ([current-t (current-engine-thread-cell-values)]
        [new-t (make-weak-eq-hashtable)])
    (when current-t
      (hash-table-for-each
       current-t
       (lambda (c v)
         (when (thread-cell-preserved? c)
           (hashtable-set! new-t c v)))))
    new-t))
