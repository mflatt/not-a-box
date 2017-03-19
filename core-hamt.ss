(define-record-type nothing
  [nongenerative #{nothing pfwik9bfi1xkid1ijd651ojht-0}]
  [sealed #t])

(define-record-type hnode
  [fields (immutable type)
	  (immutable keys)
	  (immutable vals)]
  [nongenerative #{hnode pfwh8wvaevt3r6pcwsqn90ry8-0}])

(define-record-type bnode
  [parent hnode]
  [fields (immutable keymap)
	  (immutable childmap)
	  (immutable count)]
  [nongenerative #{bnode pfwhzqkm2ycuuyedzz2nxjx2e-0}]
  [sealed #t])

(define-record-type cnode
  [parent hnode]
  [fields (immutable hash)]
  [nongenerative #{cnode pfwh0bwrq2nqlke97ikru0ds2-0}]
  [sealed #t])

(define-record-type hamt-position
  [fields (immutable key)
	  (immutable val)
	  (immutable kont)]
  [nongenerative #{hamt-position pfwmmlj69g85z10k8ovevqkoc-0}]
  [sealed #t])

(define-syntax define-hash-constructors
  (syntax-rules ()
    [(_ vararg-constructor list-constructor empty)
     (begin
       (define (vararg-constructor . kvs)
         (let loop ([kvs kvs] [h empty])
           (cond
            [(null? kvs) h]
            [else
             (loop (cddr kvs) (hamt-set h (car kvs) (cadr kvs)))])))

       (define list-constructor
         (case-lambda
	  [() (vararg-constructor)]
	  [(assocs)
	   (let loop ([h (vararg-constructor)] [assocs assocs])
	     (if (null? assocs)
		 h
		 (loop (hamt-set h (caar assocs) (cdar assocs))
		       (cdr assocs))))])))]))

(define (make-empty-bnode eqtype)
  (make-bnode eqtype (vector) #f 0 0 0))

(define empty-hash (make-empty-bnode 'equal))
(define empty-hasheqv (make-empty-bnode 'eqv))
(define empty-hasheq (make-empty-bnode 'eq))

(define-hash-constructors hash make-immutable-hash empty-hash)
(define-hash-constructors hasheqv make-immutable-hasheqv empty-hasheqv)
(define-hash-constructors hasheq make-immutable-hasheq empty-hasheq)

(define hamt? hnode?)
(define immutable-hash? hamt?)
(define hamt-count bnode-count)

(define (hamt-eq? h)
  (and (hamt? h)
       (eq? (hnode-type h) 'eq)))

(define (hamt-eqv? h)
  (and (hamt? h)
       (eq? (hnode-type h) 'eqv)))

(define (hamt-equal? h)
  (and (hamt? h)
       (eq? (hnode-type h) 'equal)))

(define (hamt-ref h k default)
  (let ([v (node-ref h k (hash-code h k) 0)])
    (cond [(eq? v NOTHING)
	   (pariah
	    (cond [(procedure? default) (default)]
		  [else default]))]
	  [else v])))

(define (hamt-set h k v)
  (node-set h k v (hash-code h k) 0))

(define (hamt-remove h k)
  (node-remove h k (hash-code h k) 0))

(define (hamt-iterate-first h)
  (cond [(fxzero? (hamt-count h)) #f]
	[else 0]))

(define (hamt-iterate-next h pos)
  (let ([pos (fx1+ pos)])
    (cond [(fx= pos (hamt-count h)) #f]
	  [else pos])))

(define (hamt-iterate-key h pos fail)
  (let-values ([(k _) (node-entry-at-position h pos)])
    (or k fail)))

(define (hamt-iterate-value h pos fail)
  (let-values ([(_ v) (node-entry-at-position h pos)])
    (or v fail)))

(define (hamt-iterate-key+value h pos fail)
  (let-values ([(k v) (node-entry-at-position h pos)])
    (cond [k (values k v)]
	  [else fail])))

(define (hamt-iterate-pair h pos fail)
  (let-values ([(k v) (node-entry-at-position h pos)])
    (cond [k (cons k v)]
	  [else fail])))

(define (unsafe-hamt-iterate-first h)
  (node-foldk h
	      (lambda (key val _ k)
		(make-hamt-position key val k))
	      #f
	      (lambda (x) x)))

(define (unsafe-hamt-iterate-next h pos)
  ((hamt-position-kont pos) #f))

(define (unsafe-hamt-iterate-key h pos)
  (hamt-position-key pos))

(define (unsafe-hamt-iterate-value h pos)
  (hamt-position-val pos))

(define (unsafe-hamt-iterate-key+value h pos)
  (values (hamt-position-key pos)
	  (hamt-position-val pos)))

(define (unsafe-hamt-iterate-pair h pos)
  (cons (hamt-position-key pos)
	(hamt-position-val pos)))

(define unsafe-immutable-hash-iterate-pair unsafe-hamt-iterate-pair)
(define unsafe-immutable-hash-iterate-key+value unsafe-hamt-iterate-key+value)
(define unsafe-immutable-hash-iterate-value unsafe-hamt-iterate-value)
(define unsafe-immutable-hash-iterate-key unsafe-hamt-iterate-key)
(define unsafe-immutable-hash-iterate-next unsafe-hamt-iterate-next)
(define unsafe-immutable-hash-iterate-first unsafe-hamt-iterate-first)

(define (hamt-foldk h f nil kont)
  (node-foldk h f nil kont))

(define (hamt-for-each h f)
  (hamt-foldk
   h
   (lambda (k v nil kont)
     (f k v)
     (kont nil))
   (void)
   (lambda (x) x)))

(define (hamt-map h f)
  (hamt-foldk
   h
   (lambda (k v nil kont)
     (kont (cons (f k v) nil)))
   '()
   (lambda (x) x)))

(define (hamt-keys-subset? a b)
  (node-keys-subset? a b 0))

(define (hamt=? a b eql? k)
  (and (eq? (hnode-type a) (hnode-type b))
       (node=? a b eql? k)))

(define (hamt-hash-code h f hc k)
  (node-hash-code h f hc k 0))

(define (node=? a b eql? k)
  (or (and (bnode? a) (bnode? b) (bnode=? a b eql? k))
      (and (cnode? a) (cnode? b) (cnode=? a b eql? k))))

(define (node-count node)
  (cond [(bnode? node) (bnode-count node)]
	[else          (cnode-count node)]))

(define (node-ref node key hash shift)
  (cond [(bnode? node) (bnode-ref node key hash shift)]
	[else          (cnode-ref node key)]))

(define (node-set node key val hash shift)
  (cond [(bnode? node) (bnode-set node key val hash shift)]
	[else          (cnode-set node key val)]))

(define (node-has-key? node key hash shift)
  (cond [(bnode? node) (bnode-has-key? node key hash shift)]
	[else          (cnode-has-key? node key)]))

(define (node-remove node key hash shift)
  (cond [(bnode? node) (bnode-remove node key hash shift)]
	[else          (cnode-remove node key hash)]))

(define (node-singleton? node)
  (cond [(bnode? node) (bnode-singleton? node)]
	[else          (cnode-singleton? node)]))

(define (node-entry-at-position h pos)
  (cond [(bnode? h) (bnode-entry-at-position h pos)]
	[else       (cnode-entry-at-position h pos)]))

(define (node-foldk n f nil kont)
  (cond [(bnode? n) (bnode-foldk n f nil kont)]
	[else       (cnode-foldk n f nil kont)]))

(define (node-keys-subset? a b shift)
  (cond [(eq? a b) #t]
	[(fx> (node-count a) (node-count b)) #f]
	[(bnode? a) (bnode-keys-subset? a b shift)]
	[else (cnode-keys-subset? a b shift)]))

(define (node-hash-code na f hc k shift)
  (cond [(bnode? na)
	 (let-values ([(hc k) (f (bnode-keymap na) hc k)])
	   (if (fx<= k 0)
	       (values hc 0)
	       (let-values ([(hc k) (array-hash-code val-ref (bnode-keymap na) na f hc k)])
		 (if (fx< k 0)
		     (values hc 0)
		     (array-hash-code (lambda (n i)
					(node-hash-code (child-ref n i) f hc f (down shift)))
				      (bnode-childmap na) na f hc k)))))]
	[else
	 ;; Hash code needs to be order-independent, so
	 ;; collision nodes are a problem; simplify by just
	 ;; using the hash code and hope that collisions are
	 ;; rare
	 (f (cnode-hash na) k)]))

(define (array-hash-code ref bitmap n f hc k)
  (let ([pop (popcount bitmap)])
    (let loop ([i 0] [hc hc] [k k])
      (cond [(fx= i pop) (values hc k)]
	    [(fx<= k 0) (values hc 0)]
	    [else
	     (let-values ([(hc k) (f (ref n i) hc k)])
	       (loop (fx1+ i) hc k))]))))

(define (bnode=? a b eql? k)
  (or (eq? a b)
      (and (fx= (bnode-count a) (bnode-count b))
	   (fx= (bnode-keymap a) (bnode-keymap b))
	   (fx= (bnode-childmap a) (bnode-childmap b))
	   (let* ([kpop (popcount (bnode-keymap a))]
		  [cpop (popcount (bnode-childmap a))])
	     (and
	      (array=?
	       k kpop
	       (lambda (i)
		 (key=? a (key-ref a i) (key-ref b i))))

	      (let ([k
		     (array=?
		      k kpop
		      (lambda (i)
			(eql? (val-ref a i) (val-ref b i) k)))])

		(array=?
		 k cpop
		 (lambda (i)
		   (node=? (child-ref a i) (child-ref b i) eql? k)))))))))

(define (bnode-ref node key hash shift)
  (let ([bit (bnode-bit-pos hash shift)])

    (cond [(bnode-maps-key? node bit)
	   (let* ([ki (bnode-key-index node bit)]
		  [k  (key-ref node ki)])
	     (if (key=? node k key)
		 (val-ref node ki)
		 NOTHING))]

	  [(bnode-maps-child? node bit)
	   (let* ([ci (bnode-child-index node bit)]
		  [c  (child-ref node ci)])
	     (node-ref c key hash (down shift)))]

	  [else NOTHING])))

(define (bnode-has-key? node key hash shift)
  (not (eq? NOTHING (bnode-ref node key hash shift))))

(define (bnode-set node key val hash shift)
  (let ([bit (bnode-bit-pos hash shift)])

    (cond
     [(bnode-maps-key? node bit)
      (let* ([ki (bnode-key-index node bit)]
	     [k  (key-ref node ki)]
	     [v  (val-ref node ki)])
	(cond
	 [(key=? node k key)
	  (if (eq? v val)
	      node
	      (bnode-replace-val node ki val))]
	 [else
	  (let* ([h (hash-code node k)]
		 [t (hnode-type node)]
		 [child (node-merge k v h key val hash t (down shift))])
	    (bnode-key->child node child ki bit))]))]

     [(bnode-maps-child? node bit)
      (let* ([ci  (bnode-child-index node bit)]
	     [c   (child-ref node ci)]
	     [new (node-set c key val hash (down shift))])
	(if (eq? c new)
	    node
	    (bnode-replace-child node c new ci)))]

     [else
      (bnode-add-key node key val bit)])))

(define (bnode-remove node key hash shift)
  (let ([bit (bnode-bit-pos hash shift)])

    (cond
     [(bnode-maps-key? node bit)
      (let* ([ki (bnode-key-index node bit)]
	     [k  (key-ref node ki)])
	(cond
	 [(key=? node k key)
	  (let ([km (bnode-keymap node)]
		[cm (bnode-childmap node)])
	    (cond
	     [(and (fx= (popcount km) 2)
		   (fxzero? cm))
	      (let* ([new-km (if (fxzero? shift)
				 (fxxor km bit)
				 (bnode-bit-pos hash 0))]
		     [idx (if (fxzero? ki) 1 0)])
		(make-bnode (hnode-type node)
			    (vector (key-ref node idx))
			    (let ([v (val-ref node idx)])
			      (if (eq? v #t)
				  #f
				  (vector v)))
			    new-km
			    0
			    1))]
	     [else
	      (bnode-remove-key node ki bit)]))]
	 [else
	  node]))]

     [(bnode-maps-child? node bit)
      (let* ([ci  (bnode-child-index node bit)]
	     [c   (child-ref node ci)]
	     [new (node-remove c key hash (down shift))])
	(cond
	 [(eq? c new) node]
	 [(node-singleton? new)
	  (if (and (fxzero? (bnode-childmap node))
		   (fx= (popcount (bnode-keymap node)) 1))
	      new
	      (bnode-child->key node new ci bit))]
	 [else
	  (bnode-replace-child node c new ci)]))]

     [else node])))

(define (bnode-entry-at-position node pos)
  (let ([pop (popcount (bnode-keymap node))])
    (cond
     [(fx< pos pop)
      (values (key-ref node pos) (val-ref node pos))]
     [else
      (let* ([keys (hnode-keys node)]
	     [len  (vector-length keys)])
	(let loop ([i pop] [pos (fx- pos pop)])
	  (cond [(fx= i len) (values #f #f)]
		[else
		 (let* ([child (vector-ref keys i)]
			[count (node-count child)])
		   (cond [(fx< pos count)
			  (node-entry-at-position child pos)]
			 [else
			  (loop (fx1+ i) (fx- pos count))]))])))])))

(define (keys-foldk pop n f nil kont)
  (let loop ([i 0] [nil nil] [kont kont])
    (cond
     [(fx= i pop) (kont nil)]
     [else
      (f (key-ref n i) (val-ref n i) nil
	 (lambda (nil) (loop (fx1+ i) nil kont)))])))

(define (child-foldk pop n f nil kont)
  (let* ([keys (hnode-keys n)]
	 [len  (vector-length keys)])
    (let loop ([i pop] [nil nil] [kont kont])
      (cond
       [(fx= i len) (kont nil)]
       [else
	(node-foldk (vector-ref keys i) f nil
		    (lambda (nil) (loop (fx1+ i) nil kont)))]))))

(define (bnode-foldk n f nil kont)
  (let ([pop (popcount (bnode-keymap n))])
    (keys-foldk pop n f nil
		(lambda (nil) (child-foldk pop n f nil kont)))))

(define (array-keys-subset? f abm bbm)
  (let loop ([abm abm] [bbm bbm] [ai 0] [bi 0])
    (cond
     [(fxzero? abm) #t]
     [else
      (let ([alsb (fxxor abm (fxlogand abm (fx1- abm)))]
	    [blsb (fxxor bbm (fxlogand bbm (fx1- bbm)))])
	(cond
	 [(fx= alsb blsb)
	  (and (f ai bi)
	       (loop (fxlogand abm (fxnot alsb))
		     (fxlogand bbm (fxnot blsb))
		     (fx1+ ai)
		     (fx1+ bi)))]
	 [else
	  (loop abm
		(fxlogand bbm (fxnot blsb))
		ai
		(fx1+ bi))]))])))

;; The CHAMP encoding makes this rather more annoying
;; than with a plain HAMT. It can be done without the
;; case analysis, but that requires a bunch of popcounts.
(define (bnode-keys-subset? a b shift)
  (cond
   [(bnode? b)
    (let* ([akm (bnode-keymap a)]
	   [acm (bnode-childmap a)]
	   [bkm (bnode-keymap b)]
	   [bcm (bnode-childmap b)]
	   [abm (fxior akm acm)]
	   [bbm (fxior bkm bcm)])
      (and
       (fx= (fxlogand abm bbm) abm)

       ;; child/key comparison (trivially false)
       (fxzero? (fxlogand acm bkm))

       ;; key/key comparison
       (array-keys-subset?
	(lambda (ai bi)
	  (key=? a (key-ref a ai) (key-ref b bi)))
	(fxlogand akm bkm) bkm)

       ;; key/child comparison
       (array-keys-subset?
	(lambda (ai bi)
	  (let ([k (key-ref a ai)])
	    (node-has-key? (child-ref b bi) k (hash-code a k) (down shift))))
	(fxlogand akm bcm) bcm)

       ;; child/child comparison
       (array-keys-subset?
	(lambda (ai bi)
	  (node-keys-subset? (child-ref a ai) (child-ref b bi) (down shift)))
	(fxlogand acm bcm) bcm)))]

   [else
    (let ([keys (hnode-keys a)])
      (and (fx= (vector-length keys) 1)
	   (let ([x (vector-ref keys 0)])
	     (cond [(hnode? x)
		    (node-keys-subset? x b (down shift))]
		   [else
		    (not (not (cnode-index b x)))]))))]))

(define (cnode-count node)
  (vector-length (hnode-keys node)))

(define (cnode-singleton? node)
  (fx= (cnode-count node) 1))

(define (cnode-index node key)
  (let* ([keys (hnode-keys node)]
	 [len  (vector-length keys)])
    (let loop ([i 0])
      (cond [(fx= i len) #f]
	    [(key=? node key (vector-ref keys i)) i]
	    [else (loop (fx1+ i))]))))

(define (cnode-ref node key)
  (let ([ki (cnode-index node key)])
    (if ki
	(val-ref node ki)
	NOTHING)))

(define (cnode-has-key? node key)
  (not (not (cnode-index node key))))

(define (cnode-set node key val)
  (let ([ki (cnode-index node key)])
    (cond
     [ki
      (let ([v (val-ref node ki)])
	(cond [(eq? v val) node]
	      [else
	       (let ([new-vals (vector-copy (hnode-vals node))])
		 (vector-set! new-vals ki val)

		 (make-cnode (hnode-type node)
			     (hnode-keys node)
			     new-vals
			     (cnode-hash node)))]))]

     [else
      (let* ([keys (hnode-keys node)]
	     [vals (hnode-vals node)]
	     [len  (cnode-count node)]
	     [new-vals
	      (cond [vals (vector-insert vals len val)]
		    [(eq? val #t) #f]
		    [else
		     ;; reify
		     (pariah
		      (let ([v (make-vector (fx1+ len) #t)])
			(vector-set! v len val)
			v))])])
	(make-cnode (hnode-type node)
		    (vector-insert keys len key)
		    new-vals
		    (cnode-hash node)))])))

(define (cnode-remove node key hash)
  (let ([eqtype (hnode-type node)]
	[ki (cnode-index node key)])
    (cond
     [ki
      (case (cnode-count node)
	[(1)
	 (make-empty-bnode eqtype)]
	[(2)
	 (let ([empty (make-empty-bnode eqtype)]
	       [i (if (fxzero? ki) 1 0)])
	   (bnode-set empty (key-ref node i) (val-ref node i) hash 0))]
	[else
	 (make-cnode eqtype
		     (vector-remove (hnode-keys node) ki)
		     (let ([vals (hnode-vals node)])
		       (and vals (vector-remove vals ki)))
		     hash)])]
     [else node])))

(define (cnode-entry-at-position node pos)
  (cond [(fx< pos (cnode-count node))
	 (values (key-ref node pos) (val-ref node pos))]
	[else
	 (values #f #f)]))

(define (cnode-foldk n f nil kont)
  (keys-foldk (cnode-count n) n f nil kont))

(define (cnode-keys-subset? a b shift)
  (cond
   [(cnode? b)
    (and (fx= (cnode-hash a) (cnode-hash b))
	 (let loop ([i (cnode-count a)])
	   (cond
	    [(fxzero? i) #t]
	    [else
	     (and (cnode-index b (key-ref a (fx1- i)))
		  (loop (fx1- i)))])))]
   [else
    (let loop ([i (cnode-count a)])
      (cond
       [(fxzero? i) #t]
       [else
	(let ([k (key-ref a (fx1- i))])
	  (and (bnode-has-key? b k (hash-code a k) shift)
	       (loop (fx1- i))))]))]))

(define (cnode=? a b eql? k)
  (or (eq? a b)
      (and (fx= (cnode-count a) (cnode-count b))
	   (fx= (cnode-hash a) (cnode-hash b))
	   (array=?
	    k (cnode-count a)
	    (lambda (i) (key=? a (key-ref a i) (key-ref b i))))
	   (array=?
	    k (cnode-count a)
	    (lambda (i) (eql? (val-ref a i) (val-ref b i) k))))))

(define NOTHING (make-nothing))
(define HASHCODE-BITS (fxbit-count (most-positive-fixnum))) ; TODO: verify this
(define NODE-BITS 4)
(define NODE-MASK (fx- (fxsll 1 NODE-BITS) 1))

(define (popcount x)
  (let* ([x (fx- x (fxlogand (fxsrl x 1) #x5555))]
	 [x (fx+ (fxlogand x #x3333) (fxlogand (fxsrl x 2) #x3333))]
	 [x (fxlogand (fx+ x (fxsrl x 4)) #x0f0f)]
	 [x (fx+ x (fxsrl x 8))])
    (fxlogand x #x1f)))

(define (copy! dst dst-start src src-start src-end)
  (let loop ([i (fx- src-end src-start 1)])
    (cond
     [(fx> i 0)
      (vector-set! dst (fx+ dst-start i) (vector-ref src (fx+ src-start i)))
      (let ([i (fx1- i)])
	(vector-set! dst (fx+ dst-start i) (vector-ref src (fx+ src-start i)))
	(loop (fx1- i)))]
     [(fxzero? i)
      (pariah
       (vector-set! dst dst-start (vector-ref src src-start)))])))

(define (vector-remove v i)
  (let* ([len (vector-length v)]
	 [new (make-vector (fx1- len))])
    (copy! new 0 v 0 i)
    (copy! new i v (fx1+ i) len)
    new))

(define (vector-insert v i x)
  (let* ([len (vector-length v)]
	 [new (make-vector (fx1+ len))])
    (copy! new 0 v 0 i)
    (vector-set! new i x)
    (copy! new (fx1+ i) v i len)
    new))

(define (down shift)
  (fx+ shift NODE-BITS))

(define (key=? node k1 k2)
  (case (hnode-type node)
    [(eq)  (eq? k1 k2)]
    [(eqv) (eqv? k1 k2)]
    [else  (equal? k1 k2)]))

(define (hash-code node k)
  (case (hnode-type node)
    [(eq)  (eq-hash-code k)]
    [(eqv) (eqv-hash-code k)]
    [else  (equal-hash-code k)]))

(define (node-mask hash shift)
  (fxlogand (fxsrl hash shift) NODE-MASK))

(define (bnode-bit-pos hash shift)
  (fxsll 1 (node-mask hash shift)))

(define (bnode-maps-bit? bitmap bit)
  (not (fxzero? (fxlogand bitmap bit))))

(define (bnode-maps-key? node bit)
  (bnode-maps-bit? (bnode-keymap node) bit))

(define (bnode-maps-child? node bit)
  (bnode-maps-bit? (bnode-childmap node) bit))

(define (bnode-index bitmap bit)
  (popcount (fxlogand bitmap (fx- bit 1))))

(define (bnode-key-index node bit)
  (bnode-index (bnode-keymap node) bit))

(define (bnode-child-index node bit)
  (bnode-index (bnode-childmap node) bit))

(define (key-ref node ki)
  (vector-ref (hnode-keys node) ki))

(define (val-ref node ki)
  (let ([vals (hnode-vals node)])
    (or (not vals)
	(vector-ref vals ki))))

(define (child-ref node ci)
  (let ([vec (hnode-keys node)])
    (vector-ref vec (fx- (vector-length vec) 1 ci))))

(define (bnode-singleton? node)
  (and (fxzero? (bnode-childmap node))
       (fx= (popcount (bnode-keymap node)) 1)))

(define (bnode-replace-val node ki val)
  (let* ([keys (hnode-keys node)]
	 [vals (hnode-vals node)]
	 [copy
	  (if vals
	      (vector-copy vals)
	      (pariah ; reify values
	       (let ([pop (popcount (bnode-keymap node))])
		 (make-vector pop #t))))])
    (vector-set! copy ki val)
    (make-bnode (hnode-type node)
		keys
		copy
		(bnode-keymap node)
		(bnode-childmap node)
		(bnode-count node))))

(define (node-merge k1 v1 h1 k2 v2 h2 eqtype shift)
  (cond
   [(and (fx< HASHCODE-BITS shift) (fx= h1 h2))
    ;; collision: make a cnode
    (pariah
     (let ([vals
	    (if (and (eq? v1 #t) (eq? v2 #t))
		#f
		(vector v1 v2))])
       (make-cnode eqtype (vector k1 k2) vals h1)))]

   [else
    (let ([m1 (node-mask h1 shift)]
	  [m2 (node-mask h2 shift)])
      (cond
       [(fx= m1 m2)
	;; partial collision: descend
	(pariah
	 (let* ([child (node-merge k1 v1 h1 k2 v2 h2 eqtype (down shift))]
		[count (node-count child)]
		[cm (bnode-bit-pos h1 shift)])
	   (make-bnode eqtype (vector child) #f 0 cm count)))]
       [else
	;; no collision
	(let* ([p1 (fxior (bnode-bit-pos h1 shift))]
	       [p2 (fxior (bnode-bit-pos h2 shift))]
	       [km (fxior p1 p2)])
	  (if (and (eq? v1 #t) (eq? v2 #t))
	      (if (fx< m1 m2)
		  (make-bnode eqtype (vector k1 k2) #f km 0 2)
		  (make-bnode eqtype (vector k2 k1) #f km 0 2))
	      (if (fx< m1 m2)
		  (make-bnode eqtype (vector k1 k2) (vector v1 v2) km 0 2)
		  (make-bnode eqtype (vector k2 k1) (vector v2 v1) km 0 2))))]))]))

(define (bnode-key->child node child ki bit)
  ;; We're removing a key from and adding a child to keys, so
  ;; length stays the same.
  (let* ([keys (hnode-keys node)]
	 [vals (hnode-vals node)]
	 [len  (vector-length keys)]
	 [copy (make-vector len)]
	 [ci (fx- len 1 (bnode-child-index node bit))])
    (copy! copy 0 keys 0 ki)
    (copy! copy ki keys (fx1+ ki) (fx1+ ci))
    (vector-set! copy ci child)
    (copy! copy (fx1+ ci) keys (fx1+ ci) len)

    (make-bnode (hnode-type node)
		copy
		(and vals
		     (vector-remove vals ki))
		(fxxor (bnode-keymap node) bit)
		(fxior (bnode-childmap node) bit)
		(fx1+ (bnode-count node)))))

(define (bnode-child->key node child vci bit)
  ;; - `child` is a singleton
  ;; - `vci` is virtual child index; the actual index
  ;;   is computed below
  (let* ([keys (hnode-keys node)]
	 [vals (hnode-vals node)]
	 [len  (vector-length keys)]
	 [ci   (fx- len 1 vci)]
	 [ki   (bnode-key-index node bit)]
	 [k    (key-ref child 0)]
	 [v    (val-ref child 0)]
	 [new-keys
	  (let ([cpy (make-vector len)])
	    (copy! cpy 0 keys 0 ki)
	    (vector-set! cpy ki k)
	    (copy! cpy (fx1+ ki) keys ki ci)
	    (copy! cpy (fx1+ ci) keys ci len)
	    cpy)]
	 [new-vals
	  (cond [vals (vector-insert vals ki v)]
		[(eq? v #t) #f]
		[else
		 ;; reify
		 (pariah
		  (let* ([pop (popcount (bnode-keymap node))]
			 [cpy (make-vector pop #t)])
		    (vector-set! cpy ci v)
		    cpy))])])
    (make-bnode (hnode-type node)
		new-keys
		new-vals
		(fxior (bnode-keymap node) bit)
		(fxxor (bnode-childmap node) bit)
		(fx1- (bnode-count node)))))

(define (bnode-replace-child node old new ci)
  (let* ([keys (hnode-keys node)]
	 [len  (vector-length keys)]
	 [cpy  (vector-copy keys)])
    (vector-set! cpy (fx- len 1 ci) new)
    (make-bnode (hnode-type node)
		cpy
		(hnode-vals node)
		(bnode-keymap node)
		(bnode-childmap node)
		(fx+ (bnode-count node)
		     (fx- (node-count new)
			  (node-count old))))))

(define (bnode-add-key node key val bit)
  (let* ([keys (hnode-keys node)]
	 [vals (hnode-vals node)]
	 [ki   (bnode-key-index node bit)]
	 [new-keys (vector-insert keys ki key)]
	 [new-vals
	  (cond [vals (vector-insert vals ki val)]
		[(eq? val #t) #f]
		[else
		 ;; reify values
		 (pariah
		  (let* ([pop (popcount (bnode-keymap node))]
			 [v (make-vector (fx1+ pop) #t)])
		    (vector-set! v ki val)
		    v))])])
    (make-bnode (hnode-type node)
		new-keys
		new-vals
		(fxior (bnode-keymap node) bit)
		(bnode-childmap node)
		(fx1+ (bnode-count node)))))

(define (bnode-remove-key node ki bit)
  (let* ([keys (hnode-keys node)]
	 [vals (hnode-vals node)]
	 [new-keys (vector-remove keys ki)]
	 [new-vals (and vals (vector-remove vals ki))])
    (make-bnode (hnode-type node)
		new-keys
		new-vals
		(fxxor (bnode-keymap node) bit)
		(bnode-childmap node)
		(fx1- (bnode-count node)))))

(define (array=? k pop f)
  (let loop ([i 0] [k k])
    (cond
     [(not k) #f]
     [(fx= i pop) k]
     [else (loop (fx1+ i) (f i))])))
