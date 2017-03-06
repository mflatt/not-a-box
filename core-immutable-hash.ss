;; ARRAYS FOR IMMUTABLE HASHES (A.K.A DICT-HAMTs)
;; Dict-hamts store key/value pairs in a flat array where
;; the key is at (vector) index 2i and the value at 2i + 1.
;; If the array index holds a child node, that will be in the value
;; slot, and the key slot will contain the unique NON-KEY value.
(define NON-KEY (gensym))

(define-syntax dict-array
  (syntax-rules ()
    [(_ [k1 v1] [k2 v2]) (vector k1 v1 k2 v2)]
    [(_ c) (vector NON-KEY c)]))

(define (dict-array-length arr)
  (fxsrl (vector-length arr) 1))

(define (dict-array-ref-key arr i)
  (vector-ref arr (fx* 2 i)))

(define (dict-array-ref-value arr i)
  (vector-ref arr (fx1+ (fx* 2 i))))

(define (dict-array-ref arr i)
  (let ([idx (fx* 2 i)])
    (values (vector-ref arr idx)
	    (vector-ref arr (fx1+ idx)))))

(define (dict-array-set! arr i key val)
    (let ([idx (fx* 2 i)])
      (vector-set! arr idx key)
      (vector-set! arr (fx1+ idx) val)))

(define-syntax dict-array-case
  (syntax-rules ()
    [(_ arr i [(entry k v) e1 ...] [(child c) e2 ...])
     (let*-values ([(idx) i]
		   [(k v) (dict-array-ref arr idx)])
       (cond [(eq? NON-KEY k)
	      (let ([c v])
		e2 ...)]
	     [else e1 ...]))]))

(define (dict-array-replace arr i key val)
  (let ([new (vector-copy arr)])
    (dict-array-set! new i key val)
    new))

(define (dict-array-replace-value arr i val)
  (let ([new (vector-copy arr)])
    (vector-set! new (fx1+ (fx* 2 i)) val)
    new))

(define (dict-array-set-child arr i child)
  (dict-array-replace arr i NON-KEY child))

(define dict-array-replace-child dict-array-replace-value)

(define (make-dict-array len)
  (make-vector (fx* 2 len)))

(define (dict-array-copy! dst dst-start src src-start src-end)
  (vector-copy! dst (fx* dst-start 2) src (fx* src-start 2) (fx* src-end 2)))

(define (dict-array-insert arr i key val)
  (let ([new (make-dict-array (fx1+ (dict-array-length arr)))])
    (dict-array-copy! new 0 arr 0 i)
    (dict-array-set! new i key val)
    (dict-array-copy! new (fx1+ i) arr i (dict-array-length arr))
    new))

(define (dict-array-remove arr i)
  (let ([new (make-dict-array (fx1- (dict-array-length arr)))])
    (dict-array-copy! new 0 arr 0 i)
    (dict-array-copy! new i arr (fx1+ i) (dict-array-length arr))
    new))

;; DICT-HAMT POPCOUNT
(define (popcount16 x)
  (let* ([x (fx- x (fxlogand (fxsrl x 1) #x5555))]
	 [x (fx+ (fxlogand x #x3333) (fxlogand (fxsrl x 2) #x3333))]
	 [x (fxlogand (fx+ x (fxsrl x 4)) #x0f0f)]
	 [x (fx+ x (fxsrl x 8))])
    (fxlogand x #x1f)))

;; DICT NODE TYPES
;;
;; bnodes
(define-record-type dict-bnode
  [fields (immutable array)
	  (immutable bitmap)
	  (immutable count)])

(define-record-type dict-bnode/equal
  [parent dict-bnode]
  [sealed #t])

(define-record-type dict-bnode/eqv
  [parent dict-bnode]
  [sealed #t])

(define-record-type dict-bnode/eq
  [parent dict-bnode]
  [sealed #t])

;; cnodes
(define-record-type dict-cnode
  [fields (immutable array)
	  (immutable hashcode)]
  [sealed #t])

;; DICT HAMTs
(define-values
  (empty-hash
   empty-hasheqv
   empty-hasheq

   immutable-hash?
   immutable-hash-equal?
   immutable-hash-eqv?
   immutable-hash-eq?

   immutable-hash=?
   immutable-hash-hash-code

   immutable-hash-count
   immutable-hash-has-key?
   immutable-hash-ref
   immutable-hash-set
   immutable-hash-remove
   immutable-hash-keys-subset?

   immutable-hash-foldk

   immutable-hash-iterate-first
   immutable-hash-iterate-next
   immutable-hash-iterate-key
   immutable-hash-iterate-value
   immutable-hash-iterate-key+value
   immutable-hash-iterate-pair

   unsafe-immutable-hash-iterate-first
   unsafe-immutable-hash-iterate-next
   unsafe-immutable-hash-iterate-key
   unsafe-immutable-hash-iterate-value
   unsafe-immutable-hash-iterate-key+value
   unsafe-immutable-hash-iterate-pair)

  (make-hamt-impl
   [4 popcount16]

   [dict-bnode? dict-bnode-array dict-bnode-bitmap dict-bnode-count
    dict-bnode/equal? dict-bnode/eqv? dict-bnode/eq?
    make-dict-bnode/equal make-dict-bnode/eqv make-dict-bnode/eq
    dict-cnode? dict-cnode-array dict-cnode-hashcode
    make-dict-cnode]

   [dict-array dict-array-length
    dict-array-case dict-array-ref-key dict-array-ref-value
    dict-array-replace dict-array-replace-value
    dict-array-set-child dict-array-replace-child
    dict-array-insert dict-array-remove]))

;; CONSTRUCTORS
(define-syntax define-hash-constructors
  (syntax-rules ()
    [(_ vararg-constructor list-constructor empty)
     (begin
       (define (vararg-constructor . kvs)
         (let loop ([kvs kvs] [h empty])
           (cond
            [(null? kvs) h]
            [else
             (loop (cddr kvs) (immutable-hash-set h (car kvs) (cadr kvs)))])))

       (define list-constructor
         (case-lambda
	  [() (vararg-constructor)]
	  [(assocs)
	   (let loop ([h (vararg-constructor)] [assocs assocs])
	     (if (null? assocs)
		 h
		 (loop (immutable-hash-set h (caar assocs) (cdar assocs))
		       (cdr assocs))))])))]))

(define-hash-constructors hash make-immutable-hash empty-hash)
(define-hash-constructors hasheqv make-immutable-hasheqv empty-hasheqv)
(define-hash-constructors hasheq make-immutable-hasheq empty-hasheq)

;; FOR-EACH AND MAP
(define (immutable-hash-for-each h proc)
  (immutable-hash-foldk h
			(lambda (key val nil k)
			  (proc key val)
			  (k nil))
			(void)
			(lambda (x) x)))

(define (immutable-hash-map h proc)
  (immutable-hash-foldk h
			(lambda (key val xs k)
			  (k (cons (proc key val) xs)))
			'()
			(lambda (xs) xs)))
