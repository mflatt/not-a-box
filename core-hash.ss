;; To support iteration and locking, we wrap Chez's mutable hash
;; tables in a `mutable-hash` record:
(define-record mutable-hash (ht keys keys-stale?))
(define (create-mutable-hash ht) (make-mutable-hash ht '#() #t))

(define (hash? v) (or (immutable-hash? v) (mutable-hash? v) (weak-equal-hash? v)))

(define (make-hash) (create-mutable-hash (make-hashtable equal-hash-code equal?)))

(define (make-hasheq) (create-mutable-hash (make-eq-hashtable)))
(define (make-weak-hasheq) (create-mutable-hash (make-weak-eq-hashtable)))
(define (make-hasheqv) (create-mutable-hash (make-eqv-hashtable)))
(define (make-weak-hasheqv) (create-mutable-hash (make-weak-eqv-hashtable)))

(define (hash-set! ht k v)
  (cond
   [(mutable-hash? ht)
    (set-mutable-hash-keys-stale?! ht #t)
    (hashtable-set! (mutable-hash-ht ht) k v)]
   [(weak-equal-hash? ht) (weak-hash-set! ht k v)]
   [else (raise-argument-error 'hash-set! "(and/c hash? (not/c immutable?))" ht)]))

(define (hash-remove! ht k)
  (cond
   [(mutable-hash? ht)
    (set-mutable-hash-keys-stale?! ht #t)
    (hashtable-delete! (mutable-hash-ht ht) k)]
   [(weak-equal-hash? ht) (weak-hash-remove! ht k)]
   [else (raise-argument-error 'hash-remove! "(and/c hash? (not/c immutable?))" ht)]))

(define (hash-clear! ht)
  (cond
   [(mutable-hash? ht)
    (set-mutable-hash-keys! ht '#())
    (hashtable-clear! (mutable-hash-ht ht))]
   [(weak-equal-hash? ht) (weak-hash-clear! ht)]
   [else (raise-argument-error 'hash-clear! "(and/c hash? (not/c immutable?))" ht)]))

(define (hash-copy ht)
  (cond
   [(mutable-hash? ht) (create-mutable-hash (hashtable-copy (mutable-hash-ht ht) #t))]
   [(weak-equal-hash? ht) (weak-hash-copy ht)]
   [(immutable-hash? ht)
    (let ([cpy (cond
		[(immutable-hash-eq? ht) (make-hasheq)]
		[(immutable-hash-eqv? ht) (make-hasheqv)]
		[else (make-hash)])])
      (immutable-hash-for-each
       ht
       (lambda (k v) (hashtable-set! cpy k v)))
      (create-mutable-hash cpy))]
   [else (raise-argument-error 'hash-copy "hash?" ht)]))

(define (hash-set ht k v)
  (cond
   [(immutable-hash? ht) (immutable-hash-set ht k v)]
   [else (raise-argument-error 'hash-set! "(and/c hash? immutable?)" ht)]))

(define (hash-remove ht k)
  (cond
   [(immutable-hash? ht) (immutable-hash-remove ht k)]
   [else (raise-argument-error 'hash-remove "(and/c hash? immutable?)" ht)]))

(define (hash-eq? ht)
  (cond
   [(mutable-hash? ht)
    (eq? (hashtable-equivalence-function (mutable-hash-ht ht)) eq?)]
   [(immutable-hash? ht)
    (immutable-hash-eq? ht)]
   [(weak-equal-hash? ht) #f]
   [else (raise-argument-error 'hash-eq? "hash?" ht)]))

(define (hash-eqv? ht)
  (cond
   [(mutable-hash? ht)
    (eq? (hashtable-equivalence-function (mutable-hash-ht ht)) eqv?)]
   [(immutable-hash? ht)
    (immutable-hash-eqv? ht)]
   [(weak-equal-hash? ht) #f]
   [else (raise-argument-error 'hash-eqv? "hash?" ht)]))

(define (hash-equal? ht)
  (cond
   [(mutable-hash? ht)
    (eq? (hashtable-equivalence-function (mutable-hash-ht ht)) equal?)]
   [(immutable-hash? ht)
    (immutable-hash-equal? ht)]
   [(weak-equal-hash? ht) #t]
   [else (raise-argument-error 'hash-equal? "hash?" ht)]))

(define (hash-weak? ht)
  (cond
   [(mutable-hash? ht)
    (hashtable-weak? (mutable-hash-ht ht))]
   [(immutable-hash? ht) #f]
   [(weak-equal-hash? ht) #t]
   [else (raise-argument-error 'hash-weak? "hash?" ht)]))

(define hash-ref
  (case-lambda
    [(ht k)
     (let ([v (hash-ref ht k none)])
       (if (eq? v none)
           (raise-arguments-error
            'hash-ref
            "no value found for key"
            "key" k)
           v))]
    [(ht k fail)
     (cond
      [(mutable-hash? ht)
       (if (procedure? fail)
           (let ([v (hashtable-ref (mutable-hash-ht ht) k none)])
             (if (eq? v none)
                 (fail)
                 v))
           (hashtable-ref (mutable-hash-ht ht) k fail))]
      [(immutable-hash? ht) (immutable-hash-ref ht k fail)]
      [(weak-equal-hash? ht) (weak-hash-ref ht k fail)]
      [else (raise-argument-error 'hash-ref "hash?" ht)])]))

(define (hash-for-each ht proc)
  (cond
   [(mutable-hash? ht)
    (let loop ([i (hash-iterate-first ht)])
      (when i
        (let-values ([(key val) (hash-iterate-key+value ht i)])
          (proc key val))
        (loop (hash-iterate-next ht i))))]
   [(immutable-hash? ht) (immutable-hash-for-each ht proc)]
   [(weak-equal-hash? ht) (weak-hash-for-each ht proc)]
   [else (raise-argument-error 'hash-for-each "hash?" ht)]))

(define (hash-map ht proc)
  (cond
   [(mutable-hash? ht)
    (let loop ([i (hash-iterate-first ht)])
      (if (not i)
          '()
          (cons
           (let-values ([(key val) (hash-iterate-key+value ht i)])
             (proc key val))
           (loop (hash-iterate-next ht i)))))]
   [(immutable-hash? ht) (immutable-hash-map ht proc)]
   [(weak-equal-hash? ht) (weak-hash-map ht proc)]
   [else (raise-argument-error 'hash-map "hash?" ht)]))

(define (hash-count ht)
  (cond
   [(mutable-hash? ht) (hashtable-size (mutable-hash-ht ht))]
   [(immutable-hash? ht) (immutable-hash-count ht)]
   [(weak-equal-hash? ht) (weak-hash-count ht)]
   [else (raise-argument-error 'hash-count "hash?" ht)]))

(define (hash-keys-subset? ht1 ht2)
  (cond
   [(and (immutable-hash? ht1)
         (immutable-hash? ht2)
         (or (and (immutable-hash-eq? ht1)
                  (immutable-hash-eq? ht2))
             (and (immutable-hash-eqv? ht1)
                  (immutable-hash-eqv? ht2))
             (and (immutable-hash-equal? ht1)
                  (immutable-hash-equal? ht2))))
    (immutable-hash-keys-subset? ht1 ht2)]
   [(and (hash? ht1)
         (hash? ht2)
         (or (and (hash-eq? ht1)
                  (hash-eq? ht2))
             (and (hash-eqv? ht1)
                  (hash-eqv? ht2))
             (and (hash-equal? ht1)
                  (hash-equal? ht2)))
         (eq? (hash-weak? ht1) (hash-weak? ht2)))
    (and (<= (hash-count ht1) (hash-count ht2))
         (let ([ok? #t])
           (hash-table-for-each
            ht1
            (lambda (k v)
              (not (eq? none (hashtable-ref ht2 k none)))))))]
   [(not (hash? ht1))
    (raise-argument-error 'hash-keys-subset? "hash?" ht1)]
   [(not (hash? ht2))
    (raise-argument-error 'hash-keys-subset? "hash?" ht2)]
   [else
    (raise-arguments-error 'hash-keys-subset?
                           "given hash tables do not use the same key comparison"
                           "first table" ht1
                           "first table" ht2)]))

;; Use `eql?` for recursive comparisons; it consumes `k`
;; and returns a new `k`; stop if `k` becomes #f
(define (hash=? ht1 ht2 eql? k)
  (cond
   [(and (immutable-hash? ht1)
         (immutable-hash? ht2)
         (or (and (immutable-hash-eq? ht1)
                  (immutable-hash-eq? ht2))
             (and (immutable-hash-eqv? ht1)
                  (immutable-hash-eqv? ht2))
             (and (immutable-hash-equal? ht1)
                  (immutable-hash-equal? ht2))))
    (immutable-hash=? ht1 ht2 eql? k)]
   [(and (hash? ht1)
         (hash? ht2)
         (or (and (hash-eq? ht1)
                  (hash-eq? ht2))
             (and (hash-eqv? ht1)
                  (hash-eqv? ht2))
             (and (hash-equal? ht1)
                  (hash-equal? ht2)))
         (eq? (hash-weak? ht1) (hash-weak? ht2)))
    (and (= (hash-count ht1) (hash-count ht2))
         (let loop ([k k] [i (hash-iterate-first ht1)])
           (cond
            [(not i) k]
            [else
             (let-values ([(key val) (hash-iterate-key+value ht1 i)])
               (let ([val2 (hash-ref ht2 key none)])
                 (cond
                  [(eq? val2 none) #f]
                  [else (loop (eql? val val2 k)
                              (hash-iterate-next ht1 i))])))])))]
   [else #f]))


;; Use `hash-code` for recursive hashing, passing
;; a value and hc and k, where the result will be two
;; values as an update hc and k; if k goes to 0,
;; then stop
(define (hash-hash-code ht f hc k)
  (cond
   [(immutable-hash? ht) (immutable-hash-hash-code ht f hc k)]
   [else
    (let loop ([hc hc] [k k] [i (hash-iterate-first ht)])
      (cond
       [(not i) (values hc k)]
       [(fx= 0 k) (values hc 0)]
       [else
        (let-values ([(key val) (hash-iterate-key+value ht i)])
          (let-values ([(hc k) (f key hc k)])
            (cond
             [(fx<= k 0) (values hc 0)]
             [else
              (let-values ([(hc k) (f val hc k)])
                (loop hc k (hash-iterate-next ht i)))])))]))]))


;; A `hash-iterate-first` operation triggers an O(n)
;; gathering of the keys of a mutable hash table. That's
;; unfortunate, but there appears to be no way around it.
(define (prepare-iterate! ht i)
  (let ([vec (mutable-hash-keys ht)])
    (or (and (or i (not (mutable-hash-keys-stale? ht)))
             vec)
        (let ([vec (hashtable-keys (mutable-hash-ht ht))])
          ;; Keep a weak reference to each key, in case
          ;; it's removed or we have a weak hash table:
          (let loop ([i (vector-length vec)])
            (unless (zero? i)
              (let* ([i (sub1 i)]
                     [key (vector-ref vec i)])
                (vector-set! vec i (weak-cons key #f))
                (loop i))))
          (set-mutable-hash-keys! ht vec)
          (set-mutable-hash-keys-stale?! ht #f)
          vec))))

(define (hash-iterate-first ht)
  (cond
   [(immutable-hash? ht)
    (immutable-hash-iterate-first ht)]
   [(mutable-hash? ht)
    (mutable-hash-iterate-next ht #f)]
   [(weak-equal-hash? ht) (weak-hash-iterate-first ht)]
   [else (raise-argument-error 'hash-iterate-first "hash?" ht)]))

(define (check-i who i)
  (unless (and (integer? i)
               (exact? i)
               (>= i 0))
    (raise-argument-error who "exact-nonnegative-integer?" i)))

(define (hash-iterate-next ht i)
  (cond
   [(immutable-hash? ht)
    (check-i 'hash-iterate-next i)
    (immutable-hash-iterate-next ht i)]
   [(mutable-hash? ht)
    (check-i 'hash-iterate-next i)
    (mutable-hash-iterate-next ht i)]
   [(weak-equal-hash? ht)
    (check-i 'hash-iterate-next i)
    (weak-hash-iterate-next ht i)]
   [else (raise-argument-error 'hash-iterate-next "hash?" ht)]))

(define (mutable-hash-iterate-next ht init-i)
  (let* ([vec (prepare-iterate! ht init-i)] ; vec expected to have > `init-i` elements
         [len (vector-length vec)])
    (let loop ([i (or init-i -1)])
      (let ([i (add1 i)])
        (cond
         [(> i len)
          (raise-arguments-error 'hash-iterate-next "no element at index"
                                 "index" init-i)]
         [(= i len)
          #f]
         [else
          (let* ([p (vector-ref vec i)]
                 [key (car p)])
            (cond
             [(bwp-object? key)
              ;; A hash table change or disappeared weak reference
              (loop (add1 i))]
             [else
              (if (or (not (mutable-hash-keys-stale? ht))
                      (hashtable-contains? (mutable-hash-ht ht) key))
                  i
                  ;; Skip, due to a hash table change
                  (loop (add1 i)))]))])))))

(define (do-hash-iterate-key+value who ht i
                                   immutable-hash-iterate-key+value
                                   weak-hash-iterate-key+value
                                   key? value? pair?)
  (cond
   [(immutable-hash? ht)
    (check-i who i)
    (call-with-values (lambda () (immutable-hash-iterate-key+value ht i none))
      (case-lambda
        [(v) (if (eq? v none)
                 (raise-arguments-error who "no element at index"
                                        "index" i)
                 v)]
        [(k v) (values k v)]))]
   [(mutable-hash? ht)
    (check-i who i)
    (let* ([vec (prepare-iterate! ht i)]
           [len (vector-length vec)]
           [p (if (< i len)
                  (vector-ref vec i)
                  '(#f . #f))]
           [key (car p)]
           [v (if (bwp-object? key)
                  none
                  (hashtable-ref (mutable-hash-ht ht) key none))])
      (if (eq? v none)
          (raise-arguments-error who "no element at index"
                                 "index" i)
          (cond
           [(and key? value?)
            (if pair?
                (cons key v)
                (values key v))]
           [key? key]
           [else v])))]
   [(weak-equal-hash? ht)
    (check-i who i)
    (weak-hash-iterate-key+value ht i)]
   [else (raise-argument-error who "hash?" ht)]))

(define (hash-iterate-key ht i)
  (do-hash-iterate-key+value 'hash-iterate-key ht i
                             immutable-hash-iterate-key
                             weak-hash-iterate-key
                             #t #f #f))

(define (hash-iterate-value ht i)
  (do-hash-iterate-key+value 'hash-iterate-value ht i
                             immutable-hash-iterate-value
                             weak-hash-iterate-value
                             #f #t #f))

(define (hash-iterate-key+value ht i)
  (do-hash-iterate-key+value 'hash-iterate-key+value ht i
                             immutable-hash-iterate-key+value
                             weak-hash-iterate-key+value
                             #t #t #f))

(define (hash-iterate-pair ht i)
  (do-hash-iterate-key+value 'hash-iterate-pair ht i
                             immutable-hash-iterate-pair
                             weak-hash-iterate-pair
                             #t #t #t))

(define unsafe-mutable-hash-iterate-first hash-iterate-first)
(define unsafe-mutable-hash-iterate-next hash-iterate-next)
(define unsafe-mutable-hash-iterate-key hash-iterate-key)
(define unsafe-mutable-hash-iterate-value hash-iterate-value)
(define unsafe-mutable-hash-iterate-key+value hash-iterate-key+value)
(define unsafe-mutable-hash-iterate-pair hash-iterate-pair)

(define unsafe-weak-hash-iterate-first hash-iterate-first)
(define unsafe-weak-hash-iterate-next hash-iterate-next)
(define unsafe-weak-hash-iterate-key hash-iterate-key)
(define unsafe-weak-hash-iterate-value hash-iterate-value)
(define unsafe-weak-hash-iterate-key+value hash-iterate-key+value)
(define unsafe-weak-hash-iterate-pair hash-iterate-pair)

;;  ----------------------------------------

;; Chez doesn't provide weak hash table with `equal?` comparisons,
;; so build our own

(define-record weak-equal-hash (ht         ; integer[hash code] -> list of weak pairs
                                count      ; number of items in the table (= sum of list lengths)
                                prune-at   ; count at which we should try to prune empty weak boxes
                                keys))     ; for iteration: a vector that is enlarged on demand

(define (make-weak-hash)
  (make-weak-equal-hash (hasheqv) 0 128 #f))

(define (weak-hash-copy ht)
  (make-weak-equal-hash (weak-equal-hash-ht ht)
                        (weak-equal-hash-count ht)
                        (weak-equal-hash-prune-at ht)
                        #f))

(define (weak-hash-ref t key fail)
  (let* ([code (equal-hash-code key)]
         [vals (immutable-hash-ref (weak-equal-hash-ht t) code '())])
    (let loop ([vals vals])
      (cond
       [(null? vals)
        ;; Not in the table:
        (if (procedure? fail)
            (fail)
            fail)]
       [(equal? (caar vals) key)
        (cdar vals)]
       [else (loop (cdr vals))]))))

(define (weak-hash-ref-key ht key)
  (let* ([code (equal-hash-code key)]
         [vals (immutable-hash-ref (weak-equal-hash-ht ht) code '())])
    (let loop ([vals vals])
      (cond
       [(null? vals) #f]
       [(equal? (car vals) key) (car vals)]
       [else (loop (cdr vals))]))))

(define (weak-hash-set! t k v)
  (let* ([code (equal-hash-code k)]
         [vals (immutable-hash-ref (weak-equal-hash-ht t) code '())])
    (let loop ([vals vals])
      (cond
       [(null? vals)
        ;; Not in the table:
        (set-weak-equal-hash-keys! t #f)
        (when (= (weak-equal-hash-count t) (weak-equal-hash-prune-at t))
          (prune-table! t))
        (let* ([ht (weak-equal-hash-ht t)])
          (set-weak-equal-hash-count! t
                                      (add1 (weak-equal-hash-count t)))
          (set-weak-equal-hash-ht! t
                                   (immutable-hash-set ht code
                                                       (cons (weak-cons k v)
                                                             (immutable-hash-ref ht code '())))))]
       [(equal? (caar vals) k)
        (set-cdr! (car vals) v)]
       [else (loop (cdr vals))]))))

(define (weak-hash-remove! t k)
  (let* ([code (equal-hash-code k)]
         [vals (immutable-hash-ref (weak-equal-hash-ht t) code '())])
    (let loop ([vals vals])
      (cond
       [(null? vals)
        ;; Not in the table
        (void)]
       [(equal? (caar vals) k)
        (set-car! (car vals) #f)
        (set-cdr! (car vals) #f)]
       [else (loop (cdr vals))]))))

(define (weak-hash-clear! t)
  (set-weak-equal-hash-ht! t (hasheqv))
  (set-weak-equal-hash-count! t 0)
  (set-weak-equal-hash-prune-at! t 128))

(define (weak-hash-for-each ht proc)
  (immutable-hash-for-each
   (weak-equal-hash-ht ht)
   (lambda (k l)
     (let loop ([l l])
       (cond
        [(null? l) (void)]
        [else
         (let ([k (caar l)])
           (unless (bwp-object? k)
             (proc k (cdar l))))
         (loop (cdr l))])))))

(define (weak-hash-map t proc)
  (let ([ht (weak-equal-hash-ht t)])
    (let loop ([i (unsafe-immutable-hash-iterate-first ht)])
      (cond
       [i (let iloop ([l (unsafe-immutable-hash-iterate-value ht i)])
            (cond
             [(null? l) (loop (unsafe-immutable-hash-iterate-next ht i))]
             [else
              (let ([k (caar l)])
                (if (bwp-object? k)
                    (iloop (cdr l))
                    (cons (proc k (cdar l))
                          (iloop (cdr l)))))]))]
       [else '()]))))

(define (weak-hash-count ht)
  (define c 0)
  (weak-hash-for-each ht (lambda (k v) (set! c (add1 c))))
  c)

(define (prepare-weak-iterate! ht i)
  (let* ([current-vec (weak-equal-hash-keys ht)])
    (or (and i
             (> (vector-length current-vec) i)
             current-vec)
        (let* ([len (max 16
                         (* 2 (if current-vec
                                  (vector-length current-vec)
                                  0))
                         (if i (* 2 i) 0))]
               [vec (make-vector len #f)]
               [pos 0])
          (call/cc
           (lambda (esc)
             (immutable-hash-for-each
              (weak-equal-hash-ht ht)
              (lambda (k l)
                (let loop ([l l])
                  (cond
                   [(null? l) (void)]
                   [else
                    ;; Add `(car l)` even if the key is #!bwp,
                    ;; so that iteration works right if a key
                    ;; is removed
                    (vector-set! vec pos (car l))
                    (set! pos (add1 pos))
                    (if (= pos len)
                        ;; That's enough keys
                        (esc (void))
                        (loop (cdr l)))]))))))
          vec))))

(define (weak-hash-iterate-first ht)
  (weak-hash-iterate-next ht #f))

(define (weak-hash-iterate-next ht init-i)
  (let retry ([i init-i])
    (let* ([vec (prepare-weak-iterate! ht i)]
           [len (vector-length vec)])
      (let loop ([i i])
        (cond
         [(= i len)
          ;; expand set of prepared keys
          (retry i)]
         [(> i len)
          (raise-arguments-error 'hash-iterate-next "no element at index"
                                 "index" init-i)]
         [else
          (let ([p (vector-ref vec i)])
            (cond
             [(not p)
              ;; no more keys available
              #f]
             [(bwp-object? (car p)) (add1 i)]
             [else i]))])))))

(define (do-weak-hash-iterate-key who ht i)
  (let* ([vec (weak-equal-hash-keys ht)]
         [p (and vec
                 (< i (vector-length vec))
                 (vector-ref vec i))]
         [k (if p
                (car p)
                #!bwp)])
    (cond
     [(bwp-object? k)
      (raise-arguments-error who "no element at index"
                             "index" i)]
     [else k])))

(define (weak-hash-iterate-key ht i)
  (do-weak-hash-iterate-key 'weak-hash-iterate-key ht i))

(define (weak-hash-iterate-value ht i)
  (define key (do-weak-hash-iterate-key 'weak-hash-iterate-value ht i))
  (weak-hash-ref ht key (lambda ()
                          (raise-arguments-error
                           'weak-hash-iterate-value "no element at index"
                           "index" i))))

(define (weak-hash-iterate-key+value ht i)
  (define key (do-weak-hash-iterate-key 'weak-hash-iterate-key+value ht i))
  (values key
          (weak-hash-ref ht key (lambda ()
                                  (raise-arguments-error
                                   'weak-hash-iterate-key+value "no element at index"
                                   "index" i)))))

(define (weak-hash-iterate-pair ht i)
  (define key (do-weak-hash-iterate-key 'weak-hash-iterate-pair ht i))
  (cons key
        (weak-hash-ref ht key (lambda ()
                                (raise-arguments-error
                                 'weak-hash-iterate-paur "no element at index"
                                 "index" i)))))

;; Remove empty weak boxes from a table. Count the number
;; of remaining entries, and remember to prune again when
;; the number of entries doubles (up to at least reaches 128)
(define (prune-table! t)
  (let ([ht (weak-equal-hash-ht t)])
    (let-values ([(new-ht count)
                  (let loop ([ht ht]
                             [i (immutable-hash-iterate-first ht)]
                             [count 0])
                    (cond
                     [(not i) (values ht count)]
                     [else
                      (let-values ([(key l) (immutable-hash-iterate-key+value ht i #f)])
                        (let ([l (filter (lambda (p) (not (bwp-object? (car p)))) l)])
                          (loop (if (null? l)
                                    ht
                                    (hash-set ht key l))
                                (immutable-hash-iterate-next ht i)
                                (+ count (length l)))))]))])
      (set-weak-equal-hash-ht! t new-ht)
      (set-weak-equal-hash-count! t count)
      (set-weak-equal-hash-prune-at! t (max 128 (* 2 count))))))
