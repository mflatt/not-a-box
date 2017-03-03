
(define-syntax begin0
  (syntax-rules ()
    [(_ expr0 expr ...)
     (call-with-values (lambda ()
                         (call-with-values (lambda () expr0)
                           (case-lambda
                            [(x) (values x #f)]
                            [args (values args #t)])))
       (lambda (l apply?)
         expr ...
         (if apply?
             (chez:apply values l)
             l)))]))

;; ----------------------------------------

;; This implementation of continuation marks has not yet been made to
;; work with `call/cc` or exception escapes, so beware of trying
;; program that have escapes or catch exceptions.

(define-record continuation-mark-set (marks k))
(define-record mark-stack-frame (prev   ; prev frame
                                 k      ; continuation for this frame
                                 table  ; hamt mapping keys to values
                                 flat)) ; #f or list that contains only tables
(define mark-stack #f)

(define-syntax with-continuation-mark
  (syntax-rules ()
    [(_ key val body)
     (call/cm key val (lambda () body))]))

(define (call/cm key val proc)
  (call/cc
   (lambda (k)
     (if (and mark-stack
              (eq? k (mark-stack-frame-k mark-stack)))
         (begin
           (set-mark-stack-frame-table! mark-stack
                                        (hamt-set (mark-stack-frame-table mark-stack)
                                                  key
                                                  val))
           (set-mark-stack-frame-flat! mark-stack #f)
           (proc))
         (begin0
          (call/cc
           (lambda (k)
             (set! mark-stack
                   (make-mark-stack-frame mark-stack
                                          k
                                          (hasheq key val)
                                          #f))
             (proc)))
          (set! mark-stack (mark-stack-frame-prev mark-stack)))))))

(define (current-marks)
  (let loop ([mark-stack mark-stack])
   (cond
    [(not mark-stack) null]
    [(mark-stack-frame-flat mark-stack) => (lambda (l) l)]
    [else
     (let ([l (cons (mark-stack-frame-table mark-stack)
                    (loop (mark-stack-frame-prev mark-stack)))])
       (set-mark-stack-frame-flat! mark-stack l)
       l)])))

(define continuation-mark-set-first
  (case-lambda
    [(marks key) (continuation-mark-set-first marks key #f)]
    [(marks key none-v prompt-tag) (continuation-mark-set-first marks key none-v)]
    [(marks key none-v)
     (let loop ([marks (or (and marks
                                (continuation-mark-set-marks marks))
                           (current-marks))])
       (cond
        [(null? marks)
         (if (eq? key parameterization-key)
             empty-parameterization
             none-v)]
        [else
         (let ([v (hamt-ref (car marks) key none)])
           (if (eq? v none)
               (loop (cdr marks))
               v))]))]))

(define (current-continuation-marks)
  (call/cc
   (lambda (k)
     ;; For now, keep `k` for error context
     (make-continuation-mark-set (current-marks) k))))
