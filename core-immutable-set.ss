;; ARRAYS FOR SET-HAMTS
;; Set-hamts only store keys and child nodes -- no values.
(define-syntax set-array
  (syntax-rules ()
    [(_ [k1 v1] [k2 v2]) (vector k1 k2)]
    [(_ child) (vector child)]))

(define set-array-length vector-length)
(define set-array-ref-key vector-ref)

;; Can only be called when a value is known to
;; exist for the given key. That means it's always #t
;; for sets.
(define (set-array-ref-value arr i)
  #t)

(define-syntax set-array-case
  (syntax-rules ()
    [(_ arr i [(entry k v) e1 ...] [(child c) e2 ...])
     (let* ([idx i]
	    [c (vector-ref arr idx)])
       (cond [(immutable-set-node? c) e2 ...]
	     [else
	      (let ([k c]
		    [v #t])
		e1 ...)]))]))

(define (set-array-replace arr i key val)
  (let ([new (vector-copy arr)])
    (vector-set! arr i key)
    new))

;; should never be called
(define (set-array-replace-value arr i val)
  arr)

(define (set-array-set-child arr i child)
  (set-array-replace arr i child #f))

(define set-array-replace-child set-array-set-child)

(define (set-array-insert arr i key val)
  (let ([new (make-vector (fx1+ (vector-length arr)))])
    (vector-copy! new 0 arr 0 i)
    (vector-set! new i key)
    (vector-copy! new (fx1+ i) arr i (vector-length arr))
    new))

(define (set-array-remove arr i)
  (let ([new (make-vector (fx1- (vector-length arr)))])
    (vector-copy! new 0 arr 0 i)
    (vector-copy! new i arr (fx1+ i) (vector-length arr))
    new))

;; POPCOUNT
(define (popcount32 x)
  (let* ([x (fx- x (fxlogand (fxsrl x 1) #x55555555))]
	 [x (fx+ (fxlogand x #x33333333) (fxlogand (fxsrl x 2) #x33333333))]
	 [x (fxlogand (fx+ x (fxsrl x 4)) #x0f0f0f0f)]
	 [x (fx+ x (fxsrl x 8))]
	 [x (fx+ x (fxsrl x 16))])
    (fxlogand x #x3f)))


;; SET NODE TYPES
;;
;; bnodes
(define-record-type set-bnode
  [fields (immutable array)
	  (immutable bitmap)
	  (immutable count)])

(define-record-type set-bnode/equal
  [parent set-bnode]
  [sealed #t])

(define-record-type set-bnode/eqv
  [parent set-bnode]
  [sealed #t])

(define-record-type set-bnode/eq
  [parent set-bnode]
  [sealed #t])

;; cnodes
(define-record-type set-cnode
  [fields (immutable array)
	  (immutable hashcode)]
  [sealed #t])

(define (immutable-set-node? x)
  (or (set-bnode? x)
      (set-cnode? x)))


;; IMMUTABLE SET HAMTs
(define-values
  (empty-set
   empty-seteqv
   empty-seteq

   immutable-set?
   immutable-set-equal?
   immutable-set-eqv?
   immutable-set-eq?

   immutable-set=?
   immutable-set-hash-code

   immutable-set-count
   immutable-set-member?
   immutable-set-ref
   immutable-set-put
   immutable-set-remove
   immutable-set-subset?

   immutable-set-foldk

   set-iterate-first
   set-iterate-next
   set-iterate-key
   set-iterate-value
   set-iterate-key+value
   set-iterate-pair

   unsafe-set-iterate-first
   unsafe-set-iterate-next
   unsafe-set-iterate-key
   unsafe-set-iterate-value
   unsafe-set-iterate-key+value
   unsafe-set-iterate-pair)

  (make-hamt-impl
   [5 popcount32]

   [set-bnode? set-bnode-array set-bnode-bitmap set-bnode-count
    set-bnode/equal? set-bnode/eqv? set-bnode/eq?
    make-set-bnode/equal make-set-bnode/eqv make-set-bnode/eq
    set-cnode? set-cnode-array set-cnode-hashcode
    make-set-cnode]

   [set-array set-array-length
    set-array-case set-array-ref-key set-array-ref-value
    set-array-replace set-array-replace-value
    set-array-set-child set-array-replace-child
    set-array-insert set-array-remove]))

(define (immutable-set-add s x)
  (immutable-set-put s x #t))

(define (immutable-set-empty? s)
  (zero? (immutable-set-count s)))

(define (immutable-set-clear s)
  (cond [(immutable-set-equal? s) empty-set]
	[(immutable-set-eqv? s)   empty-seteqv]
	[else                     empty-seteq]))

(define (immutable-set-proper-subset? a b)
  (and (< (immutable-set-count a)
	  (immutable-set-count b))
       (immutable-set-subset? a b)))

(define (immutable-set-fold s proc acc)
  (immutable-set-foldk
   s
   (lambda (key _ acc k)
     (k (proc key acc)))
   acc
   (lambda (x) x)))

(define (set . xs)
  (fold-left
   (lambda (x s) (immutable-set-add s x))
   empty-set
   xs))

(define (seteqv . xs)
  (fold-left
   (lambda (x s) (immutable-set-add s x))
   empty-seteqv
   xs))

(define (seteq . xs)
  (fold-left
   (lambda (x s) (immutable-set-add s x))
   empty-seteq
   xs))

(define set-member? immutable-set-member?)
(define set-add immutable-set-add)
(define set-remove immutable-set-remove)
(define set-clear immutable-set-clear)
(define subset? immutable-set-subset?)
