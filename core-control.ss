;; The full continuation is a chain of metacontinuations. Each
;; metacontinuation contains a host Scheme continuation, and
;; every prompt is on a boundary between metacontinuations. When
;; a composable continuation is applied, the composition boundary
;; is also a metacontinuation boundary.

;; "Continuation" as exported from the core is "metacontinuation"
;; here. So, `call-with-current-continuation` defined here and
;; exported captures the current metacontinuation (up to a prompt).
;; The `call/cc` function is the host's notion of continuation, which
;; corresponds to a single metacontinuation frame.

;; A picture where the continuation grows down:

;;                   [root empty continuation]
;;                    ---
;; metacontinuation  |
;;     frame         |
;;                   |--- resume-k & resume/no-wind
;;                   |<-- tag represents this point
;;                    --- empty-k
;;                    ---
;; metacontinuation  |
;;     frame         |
;;                   |
;;                   |--- resume-k & resume/no-wind
;;                   |<-- tag represents this point
;;                    --- empty-k
;;                    ---
;;   current host    |
;;   continuation    |
;;                   v

;; Concretely, the metacontinuation is the current host continuation
;; plus the frames in the list `*metacontinuation*`, where the
;; shallowest (= lowest in the picture above) frame is first in the
;; list.

;; The host Scheme implementation takes care of winders from
;; `dynamic-wind`, which means that tings generally work if host
;; functions uses `dynamic-wind` (e.g., for `with-input-from-file`).
;; We assume that no host Scheme winders end up using continuations
;; (or calling client-provided code that can use continuations), so
;; that cross-frame jumps at the metacontinuation level are not
;; triggered by the host Scheme.

;; The continuation within a metacontinuation frame is kept in two
;; forms: one that has the frame's winders (from `dynamic-wind`)
;; attached, and one that doesn't. The one without winders is used to
;; reinstantiate the frame's continuation as the host continuation
;; when control returns to that frame. The one with winders is used to
;; compose a captured frame onto the current continuation. See
;; `call/cc-no-winders` for the way Chez internals are used to get a
;; continuation disconnected from winders. See also the use of
;; `#%$current-stack-link` to disconnect a fresh metacontinuation
;; frame's continuation from the formerly current continuation.

;; A metacontinuation frame's `empty-k` continuation is used to detect
;; when the current host continuation is empty (i.e., when it matches
;; the `empty-k` field of the shallowest metacontinuation frame). When
;; it's empty, then calling a composable continuation doesn't need to
;; add a new metacontinuation frame, and the application gets the
;; right "tail" behavior.

;; A metacontinuation frame's `resume-k/no-wind` is called when
;; control returns or needs to escape through the frame:
;;
;; * When returning normally to a metacontinuation frame, the
;;   `resume-k/no-wind` continuation receives the values returned to the
;;   frame.
;;
;; * When aborting to a prompt tag, the `resume-k/no-wind`
;;   continination receives a special value that indicates an abort to a
;;   specific tag, and the frames will jump to the next metacontinuation
;;   frame (running the current frame's "out" winders) until a frame
;;   with the right tag is hit.
;;
;; * Calling a non-composable continuation is similar to aborting,
;;   except that the target prompt's abort handler is not called.
;;   In fact, the metacontinuation-frame unwinding process stops
;;   before the frame with the target prompt tag (since that prompt
;;   is meant to be preserved).
;;
;; * When composing a metacontinuation frame onto the current
;;   metacontinuation, `resume-k` is called instead of
;;   `resume-k/no-wind` so that the frame's "in" winders get run.

;; The continuation marks for the frame represented by the current
;; host continuation are kept in `*mark-stack*`. When a metacontinuation
;; frame is created, it takes the current `*mark-stack*` value and
;; `*mark-stack*` is set back to empty. To keep winders and the mark
;; stack in sync, `dynamic-wind` is wrapped to reset the mark stack on
;; entry to a pre or post thunk.

;; A metacontinuation frame has an extra cache slot to contain a list
;; of mark-stack lists down to the root continuation. When a delimited
;; sequence of metacontinuation frames are copied out of or into the
;; metacontinuation, the slot is flushed and will be reset on demand.

;; ----------------------------------------

(define *metacontinuation* '())

(define-record metacontinuation-frame (tag          ; continuation prompt tag or #f
                                       resume-k     ; delivers values to the prompt
                                       resume-k/no-wind ; same, but doesn't run winders jumping in
                                       empty-k      ; just after delivery frame
                                       mark-stack   ; mark stack to restore
                                       mark-chain)) ; #f or a cached list of (cons tag mark-stack)

;; Messages to `resume-k[/no-wind]`:
(define-record appending (resume))  ; composing the frame, so run "in" winders
(define-record aborting (tag args)) ; aborting, so run "out" winders
(define-record applying (c args))   ; applying a non-composable continuation

(define-record-type (continuation-prompt-tag create-continuation-prompt-tag continuation-prompt-tag?)
  (fields name))

(define the-default-continuation-prompt-tag (create-continuation-prompt-tag 'default))

;; Not actually set, but allows access to the full continuation:
(define the-root-continuation-prompt-tag (create-continuation-prompt-tag 'root))

(define make-continuation-prompt-tag
  (case-lambda
    [() (create-continuation-prompt-tag #f)]
    [(name)
     (unless (symbol? name)
       (raise-argument-error 'make-continuation-prompt-tag "symbol?" name))
     (create-continuation-prompt-tag name)]))
     
(define (default-continuation-prompt-tag) the-default-continuation-prompt-tag)

;; FIXME: add caching to avoid full traversal
(define (continuation-prompt-available? tag)
  (unless (continuation-prompt-tag? tag)
    (raise-argument-error 'continuation-prompt-tag-available? "continuation-prompt-tag?" tag))
  (or (eq? tag the-default-continuation-prompt-tag)
      (let loop ([mc *metacontinuation*])
        (cond
         [(null? mc)
          #f]
         [(eq? tag (metacontinuation-frame-tag (car mc)))
          #t]
         [else (loop (cdr mc))]))))

(define call-with-continuation-prompt
  (case-lambda
    [(proc) (call-with-continuation-prompt proc the-default-continuation-prompt-tag #f)]
    [(proc tag) (call-with-continuation-prompt proc tag #f)]
    [(proc tag handler . args)
     (unless (procedure? proc)
       (raise-argument-error 'call-with-continuation-prompt "procedure?" proc))
     (unless (continuation-prompt-tag? tag)
       (raise-argument-error 'call-with-continuation-prompt "continuation-prompt-tag?" tag))
     (unless (or (not handler) (procedure? handler))
       (raise-argument-error 'call-with-continuation-prompt "(or/c #f procedure?)" handler))
     (call-in-empty-metacontinuation-frame
      tag
      (or handler (make-default-abort-handler tag))
      (lambda ()
        (apply proc args)))]))

(define (make-default-abort-handler tag)
  (lambda (abort-thunk)
    (unless (and (procedure? abort-thunk)
                 (procedure-arity-includes? abort-thunk 1))
      (raise-argument-error 'default-abort-handler "(procedure-arity-includes/c 1)" abort-thunk))
    (call-with-continuation-prompt abort-thunk tag #f)))

(define (resume-metacontinuation results)
  ;; pop a metacontinuation frame
  (let ([mf (car *metacontinuation*)])
    (set! *metacontinuation* (cdr *metacontinuation*))
    (set! *mark-stack* (metacontinuation-frame-mark-stack mf))
    ;; resume
    (apply (metacontinuation-frame-resume-k/no-wind mf) results)))

(define (call-in-empty-metacontinuation-frame tag handler proc)
  ;; Call `proc` in an empty metacontinuation frame, reifying the
  ;; current metacontinuation as needed (i.e., if non-empty) as a new
  ;; frame on `*metacontinuations*`; if the tag is #f and the 
  ;; current metacontinuation frame is already empty, don't push more
  (call/cc
   (lambda (k)
     (cond
      [(and (not tag)
            (pair? *metacontinuation*)
            (let ([current-mf (car *metacontinuation*)])
              (and (eq? tag (metacontinuation-frame-tag current-mf))
                   (eq? k (metacontinuation-frame-empty-k current-mf))
                   current-mf)))
       =>
       (lambda (current-mf)
         ;; empty continuation in the current frame; don't push a
         ;; new metacontinuation frame --- and, in fact, keep the
         ;; current one if metadata hasn't changed; we assume that
         ;; there are no new winders and the handler is the same,
         ;; otherwise the continuation would be bigger
         (cond
          [(not *mark-stack*)
           (proc)]
          [else
           ;; update metacontinuation for new mark-stack elements:
           (set! *metacontinuation*
                 (cons (metacontinuation-frame-merge current-mf *mark-stack*)
                       (cdr *metacontinuation*)))]))]
      [else
       (let-values ([results
                     (call/cc
                      (lambda (k)
                        (call/cc-no-winders
                         ;; Not necessarily called in tail position, but that's ok:
                         (lambda (k/no-wind)
                           ;; At this point, the winders list is empty.
                           ;; Push another continuation frame so we can drop it's `next`
                           (call-as-non-tail
                            (lambda ()
                              ;; drop the rest of the current continuation from the
                              ;; new metacontinuation frame:
                              (#%$current-stack-link #%$null-continuation)
                              (let-values ([results
                                            (call/cc
                                             ;; remember the "empty" continuation frame
                                             ;; that just continues the metacontinuation:
                                             (lambda (empty-k)
                                               (let ([mf (make-metacontinuation-frame tag
                                                                                      k
                                                                                      k/no-wind
                                                                                      empty-k
                                                                                      *mark-stack*
                                                                                      #f)])
                                                 (set! *mark-stack* #f)
                                                 ;; push the metacontinuation:
                                                 (set! *metacontinuation* (cons mf *metacontinuation*))
                                                 ;; ready:
                                                 (proc))))])
                                ;; continue normally; the metacontinuation could be different
                                ;; than when we captured this metafunction frame, though:
                                (resume-metacontinuation results))))))))])
         (let ([r (and (pair? results)
                       (car results))])
           (cond
            [(appending? r)
             ;; We applied this metacontinuation frame just to run its "in" winders
             ((appending-resume r))]
            [(aborting? r)
             ;; We're aborting to a given tag
             (cond
              [(eq? tag (aborting-tag r))
               ;; Found the right tag. Remove the prompt as we call the handler:
               (set! *metacontinuation* (cdr *metacontinuation*))
               (apply handler
                      (aborting-args r))]
              [else
               ;; Aborting to an enclosing prompt, so keep going:
               (set! *metacontinuation* (cdr *metacontinuation*))
               (apply abort-current-continuation
                      (aborting-tag r)
                      (aborting-args r))])]
            [(applying? r)
             ;; We're applying a non-composable continuation --- past
             ;; this prompt, or else we would have stopped.
             ;; Continue escaping to an encloding prompt:
             (set! *metacontinuation* (cdr *metacontinuation*))
             (apply-continuation (applying-c r)
                                 (applying-args r))]
            [else
             ;; We're returning normally; the metacontinuation frame has
             ;; been popped already by `resume-metacontinuation`
             (apply values results)])))]))))

(define (call/cc-no-winders proc)
  (let ([prev-winders (#%$current-winders)])
    (cond
     [(null? prev-winders)
      (call/cc proc)]
     [else
      ;; drop winders before capturing continuation:
      (#%$current-winders '())
      (begin0
       (call/cc proc)
       (#%$current-winders prev-winders))])))

(define (call-as-non-tail proc)
  (proc)
  '(error 'call-as-non-tail "shouldn't get to frame that was meant to be discarded"))
  
;; Make a frame like `current-mf`, but with more of a mark stack appended
(define (metacontinuation-frame-merge current-mf mark-stack)
  (make-metacontinuation-frame (metacontinuation-frame-tag current-mf)
                               (metacontinuation-frame-resume-k current-mf)
                               (metacontinuation-frame-resume-k/no-wind current-mf)
                               (metacontinuation-frame-empty-k current-mf)
                               (mark-stack-append mark-stack
                                                  (metacontinuation-frame-mark-stack current-mf))
                               #f))

(define (abort-current-continuation tag . args)
  (unless (continuation-prompt-tag? tag)
    (raise-argument-error 'abort-current-continuation "continuation-prompt-tag?" tag))
  (check-prompt-tag-available 'abort-current-continuation tag)
  (cond
   [(null? *metacontinuation*)
    ((reset-handler))]
   [else
    ((metacontinuation-frame-resume-k/no-wind (car *metacontinuation*))
     (make-aborting tag args))]))

;; ----------------------------------------

(define-record continuation (composable? k tag mark-stack mc))

(define call-with-current-continuation
  (case-lambda
    [(proc) (call-with-current-continuation proc
                                            the-default-continuation-prompt-tag)]
    [(proc tag)
     (unless (and (procedure? proc)
                  (procedure-arity-includes? proc 1))
       (raise-argument-error 'call-with-current-continuation "(procedure-arity-includes/c 1)" proc))
     (unless (continuation-prompt-tag? tag)
       (raise-argument-error 'call-with-current-continuation "continuation-prompt-tag?" tag))
     (call/cc
      (lambda (k)
        (proc
         (make-continuation #f ; => non-composable
                            k
                            tag
                            *mark-stack*
                            (extract-metacontinuation 'call-with-current-continuation tag)))))]))

(define call-with-composable-continuation
  (case-lambda
    [(p) (call-with-composable-continuation p the-default-continuation-prompt-tag)]
    [(p tag)
     (unless (and (procedure? p)
                  (procedure-arity-includes? p 1))
       (raise-argument-error 'call-with-composable-continuation "(procedure-arity-includes/c 1)" p))
     (unless (continuation-prompt-tag? tag)
       (raise-argument-error 'call-with-composable-continuation "continuation-prompt-tag?" tag))
     (call/cc
      (lambda (k)
        (p
         (make-continuation #t ; => composable
                            k
                            tag
                            *mark-stack*
                            (extract-metacontinuation 'call-with-composable-continuation tag)))))]))

;; Applying a continuation calls this internal function:
(define (apply-continuation c args)
  (cond
   [(continuation-composable? c)
    ;; To compose the metacontinuation, first make sure the current
    ;; continuation is reified in `*metacontinuation*`:
    (call-in-empty-metacontinuation-frame
     #f
     fail-abort-to-delimit-continuation
     (lambda ()
       ;; The current metacontinuation frame has an
       ;; empty continuation, so we can "replace" that
       ;; with the composable one:
       (apply-immediate-continuation c args)))]
   [else
    (let* ([tag (continuation-tag c)]
           [common-mc
            ;; We check every time, just in case control operations
            ;; change the current continuation out from under us.
            (find-common-metacontinuation (continuation-mc c)
                                          *metacontinuation*
                                          tag)])
      (cond
       [(eq? common-mc *metacontinuation*)
        ;; Replace the current metacontinuation frame's continuation
        ;; with the saved one; this replacement will take care of any
        ;; shared winders within the frame:
        (apply-immediate-continuation c args)]
       [else
        ;; Jump back to the nearest prompt, then continue jumping
        ;; as needed from there:
        ((metacontinuation-frame-resume-k/no-wind (car *metacontinuation*))
         ;; An `applying` record tells the metacontinuation's continuation
         ;; to continue jumping:
         (make-applying c args))]))]))

;; Apply a continuation within the current metacontinuation frame:
(define (apply-immediate-continuation c args)
  (call-with-appended-metacontinuation
   (continuation-mc c)
   (lambda ()
     (set! *mark-stack* (mark-stack-append (continuation-mark-stack c) *mark-stack*))
     (apply (continuation-k c) args))))

;; Used as a "handler" for a prompt without a tag, which is used for
;; composable continuations
(define (fail-abort-to-delimit-continuation . args)
  (error 'abort "trying to abort to a delimiter continuation frame"))

;; Find common metacontinuation to keep due to a combination of:
;; the metacontinuation is beyond the relevant prompt, or the
;; metacontinuation fragment before the prompt is also shared
;; with the composable continuation's metacontinuation (so we
;; should not unwind and rewind those metacontinuation frames)
(define (find-common-metacontinuation mc current-mc tag)
  (define-values (rev-current ; (list (cons mf mc) ...)
                  base-current-mc)
    ;; Get the reversed prefix of `current-mc` that is to be
    ;; replaced by `mc`:
    (let loop ([current-mc current-mc] [accum null])
      (cond
       [(null? current-mc)
        (unless (eq? tag the-default-continuation-prompt-tag)
          (raise-arguments-error 'apply-continuaiton
                                 "continuation includes no prompt with the given tag"
                                 "tag" tag))
        (values accum null)]
       [(eq? tag (metacontinuation-frame-tag (car current-mc)))
        (values accum current-mc)]
       [else
        (loop (cdr current-mc)
              ;; Accumulate this frame plus the chain that
              ;; we should keep if this frame is shared:
              (cons (cons (car current-mc) current-mc)
                    accum))])))
  (define rev-mc (reverse mc))
  ;; Work from the tail backwards (which is forward in the reverse
  ;; lists): If the continuations are the same for two frames, then the
  ;; metacontinuation frame should not be unwound
  (let loop ([rev-current rev-current]
             [rev-mc rev-mc]
             [base-current-mc base-current-mc])
    (cond
     [(null? rev-mc) base-current-mc]
     [(null? rev-current) base-current-mc]
     [(eq? (metacontinuation-frame-resume-k (car rev-mc))
           (metacontinuation-frame-resume-k (caar rev-current)))
      ;; Matches, so update base and look shallower
      (loop (cdr rev-current)
            (cdr rev-mc)
            (cdar rev-current))]
     [else
      ;; Doesn't match, so we've found the shared part
      rev-current])))

(define (set-continuation-applicables!)
  (struct-property-set! prop:procedure
                        (record-type-descriptor continuation)
                        (lambda (c . args)
                          (apply-continuation c args))))

;; ----------------------------------------

;; Extract a prefix of `*metacontinuation*` up to `tag`
(define (extract-metacontinuation who tag)
  (let loop ([mc *metacontinuation*])
    (cond
     [(null? mc)
      (if (or (eq? tag the-root-continuation-prompt-tag)
              (eq? tag the-default-continuation-prompt-tag))
          '()
          (raise-arguments-error who "continuation includes no prompt with the given tag"
                                 "tag" tag))]
     [(eq? (metacontinuation-frame-tag (car mc)) tag)
      '()]
     [else
      (cons (metacontinuation-frame-clear-cache (car mc)) (loop (cdr mc)))])))

(define (check-prompt-tag-available who tag)
  (unless (continuation-prompt-available? tag)
    (raise-arguments-error who "continuation includes no prompt with the given tag"
                           "tag" tag)))

(define (call-with-appended-metacontinuation mc proc)
  ;; Assumes that the current metacontinuation frame is ready to be
  ;; replaced with `mc` plus `proc`.
  ;; In the simple case of no winders and an empty frame immediate
  ;;  metacontinuation fame, we could just
  ;;  (set! *metacontinuation* (append mc *metacontinuation*))
  ;; But, to run winders and replace anything in the current frame,
  ;; we proceed frame-by-frame in `mc`.
  (let loop ([rmc (reverse mc)])
    (cond
     [(null? rmc) (proc)]
     [else
      (let ([mf (metacontinuation-frame-clear-cache (car rmc))]
            [rmc (cdr rmc)])
        (cond
         [(eq? (metacontinuation-frame-resume-k mf)
               (metacontinuation-frame-resume-k/no-wind mf))
          ;; No winders in this metacontinuation frame, so take a shortcut
          (set! *metacontinuation* (cons mf *metacontinuation*))
          (loop rmc)]
         [else
          ((metacontinuation-frame-resume-k mf)
           (make-appending (lambda ()
                             ;; resuming appended winders, but we'll keep
                             ;; them in the metacontinuation, instead:
                             (#%$current-winders '())
                             ;; addend frame:
                             (set! *metacontinuation* (cons mf *metacontinuation*))
                             ;; next...
                             (loop rmc))))]))])))

(define (metacontinuation-frame-clear-cache mf)
  (metacontinuation-frame-merge mf #f))

;; Get/cache a converted list of marks for a metacontinuation
(define (metacontinuation-marks mc)
  (cond
   [(null? mc) null]
   [else (let ([mf (car mc)])
           (or (metacontinuation-frame-mark-chain mf)
               (let* ([r (metacontinuation-marks (cdr mc))]
                      [l (cons (cons (metacontinuation-frame-tag mf)
                                     (mark-stack-to-marks
                                      (metacontinuation-frame-mark-stack mf)))
                               r)])
                 (set-metacontinuation-frame-mark-chain! mf l)
                 l)))]))

;; ----------------------------------------

(define-record continuation-mark-set (marks k))
(define-record mark-stack-frame (prev   ; prev frame
                                 k      ; continuation for this frame
                                 table  ; hamt mapping keys to values
                                 flat)) ; #f or list that contains only tables
(define *mark-stack* #f)

(define-syntax with-continuation-mark
  (syntax-rules ()
    [(_ key val body)
     (call/cm key val (lambda () body))]))

(define (call/cm key val proc)
  (call/cc
   (lambda (k)
     (if (and *mark-stack*
              (eq? k (mark-stack-frame-k *mark-stack*)))
         (begin
           (set-mark-stack-frame-table! *mark-stack*
                                        (hamt-set (mark-stack-frame-table *mark-stack*)
                                                  key
                                                  val))
           (set-mark-stack-frame-flat! *mark-stack* #f)
           (proc))
         (begin0
          (call/cc
           (lambda (k)
             (set! *mark-stack*
                   (make-mark-stack-frame *mark-stack*
                                          k
                                          (hasheq key val)
                                          #f))
             (proc)))
          (set! *mark-stack* (mark-stack-frame-prev *mark-stack*)))))))

(define (current-marks)
  (get-current-marks *mark-stack* *metacontinuation*))

(define (mark-stack-to-marks mark-stack)
  (let loop ([mark-stack mark-stack])
    (cond
     [(not mark-stack) null]
     [(mark-stack-frame-flat mark-stack) => (lambda (l) l)]
     [else
      (let ([l (cons (mark-stack-frame-table mark-stack)
                     (loop (mark-stack-frame-prev mark-stack)))])
        (set-mark-stack-frame-flat! mark-stack l)
        l)])))
  
(define (get-current-marks mark-stack mc)
  (cons (cons #f (mark-stack-to-marks mark-stack))
        (metacontinuation-marks mc)))

(define continuation-mark-set-first
  (case-lambda
    [(marks key) (continuation-mark-set-first marks key #f)]
    [(marks key none-v)
     (continuation-mark-set-first marks key none-v the-default-continuation-prompt-tag)]
    [(marks key none-v prompt-tag)
     (unless (or (not marks)
                 (continuation-mark-set? marks))
       (raise-argument-error 'continuation-mark-set-first "(or/c continuation-mark-set? #f)" marks))
     (unless (continuation-prompt-tag? prompt-tag)
       (raise-argument-error 'continuation-mark-set-first "continuation-prompt-tag?" prompt-tag))
     (let loops ([markss (or (and marks
                                  (continuation-mark-set-marks marks))
                             (current-marks))])
       (cond
        [(null? markss)
         (if (eq? key parameterization-key)
             empty-parameterization
             none-v)]
        [(eq? (caar markss) prompt-tag)
         none-v]
        [else
         (let loop ([marks (cdar markss)])
           (cond
            [(null? marks)
             (loops (cdr markss))]
            [else
             (let ([v (hamt-ref (car marks) key none)])
               (if (eq? v none)
                   (loop (cdr marks))
                   v))]))]))]))

(define continuation-mark-set->list
  (case-lambda
    [(marks key) (continuation-mark-set->list marks key the-default-continuation-prompt-tag)]
    [(marks key prompt-tag)
     (unless (or (not marks)
                 (continuation-mark-set? marks))
       (raise-argument-error 'continuation-mark-set->list "(or/c continuation-mark-set? #f)" marks))
     (unless (continuation-prompt-tag? prompt-tag)
       (raise-argument-error 'continuation-mark-set->list "continuation-prompt-tag?" prompt-tag))
     (let loops ([markss (or (and marks
                                  (continuation-mark-set-marks marks))
                             (current-marks))])
       (cond
        [(null? markss)
         null]
        [(eq? (caar markss) prompt-tag)
         null]
        [else
         (let loop ([marks (cdar markss)])
           (cond
            [(null? marks)
             (loops (cdr markss))]
            [else
             (let ([v (hamt-ref (car marks) key none)])
               (if (eq? v none)
                   (loop (cdr marks))
                   (cons v (loop (cdr marks)))))]))]))]))

(define current-continuation-marks
  (case-lambda
    [() (current-continuation-marks the-default-continuation-prompt-tag)]
    [(tag)
     (unless (continuation-prompt-tag? tag)
       (raise-argument-error 'current-continuation-marks "continuation-prompt-tag?" tag))
     ;; For now, keep `k` for error context:
     (call/cc
      (lambda (k)
        ;; FIXME: use `tag` to limit saved marks
        (make-continuation-mark-set (current-marks) k)))]))

(define (continuation-marks k)
  (cond
   [(continuation? k)
    (get-current-marks (continuation-mark-stack k)
                       (continuation-mc k))]
   [(not k)
    (make-continuation-mark-set null #f)]
   [else
    (raise-argument-error 'continuation-marks "(or/c continuation? #f)" k)]))

(define (mark-stack-append a b)
  (cond
   [(not a) b]
   [(not b) a]
   [else
    (make-mark-stack-frame (mark-stack-append (mark-stack-frame-prev a) b)
                           (mark-stack-frame-k a)
                           (mark-stack-frame-table a)
                           #f)]))

;; ----------------------------------------

;; Wrap `dynamic-wind` to set the mark stack on entry and exit to the
;; saved mark stack. The saved mark stack is confined to the current
;; continuation frame, so it's ok to use it if the current
;; continuation is later applied to a different metacontinuation.

(define (dynamic-wind pre thunk post)
  (let ([saved-mark-stack *mark-stack*])
    (#%dynamic-wind
     (lambda ()
       (set! *mark-stack* saved-mark-stack)
       (pre))
     thunk
     (lambda ()
       (set! *mark-stack* saved-mark-stack)
       (post)))))
