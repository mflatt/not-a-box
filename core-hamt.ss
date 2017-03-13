(define-syntax make-hamt-impl
  (syntax-rules ()
    [(_
      ;; generic hamt parameters
      [NODE-BIT-WIDTH popcount]
      ;; node types
      [bnode? bnode-array bnode-bitmap bnode-count
       bnode/equal? bnode/eqv? bnode/eq?
       make-bnode/equal make-bnode/eqv make-bnode/eq
       cnode? cnode-array cnode-hashcode
       make-cnode]
      ;; array operations
      [array array-length
       array-case array-ref-key array-ref-value
       array-replace array-replace-value
       array-set-child array-replace-child
       array-insert array-remove])
     (let ()
       ;; constants and general utilities
       (define NODE-MASK (fx- (fxsll 1 NODE-BIT-WIDTH) 1))

       (define empty-array (vector))

       (define NOTHING (gensym))

       ;; GENERIC ARRAY OPERATIONS
       (define (array-append arr key val)
	 (array-insert arr (array-length arr) key val))

       (define (array-foldk arr proc nil k)
	 (let ([len (array-length arr)])
	   (let loop ([i 0] [nil nil] [k k])
	     (cond [(fx= i len) (k nil)]
		   [else
		    (array-case arr i
		     [(entry key val)
		      (proc key val nil (lambda (nil) (loop (fx1+ i) nil k)))]
		     [(child c)
		      (node-foldk c proc nil (lambda (nil) (loop (fx1+ i) nil k)))])]))))

       (define (array-keys-subset? eqtype aa abm ba bbm shift)
	 (let ([len (array-length aa)])
	   (let loop ([ai 0] [bi 0] [abit 0] [bbit 0])
	     (cond [(fx= ai len) #t]
		   [(fxlogbit? abit abm)
		    (and
		     (array-case aa ai
		      [(entry ak av)
		       (array-case ba bi
		        [(entry bk bv) (key=? eqtype ak bk)]
			[(child bc)
			 (cond [(cnode? bc) (cnode-index eqtype bc ak)]
			       [else (not (eq? NOTHING
					       (bnode-ref eqtype bc ak (hash-code eqtype ak) (down shift))))])])]
		      [(child ac)
		       (array-case ba bi
		        [(entry bk bv) #f]
			[(child bc) (node-keys-subset? eqtype ac bc (down shift))])])
		     (loop (fx1+ ai) (fx1+ bi) (fx1+ abit) (fx1+ bbit)))]
		   [(fxlogbit? bbit bbm)
		    (loop ai (fx1+ bi) (fx1+ abit) (fx1+ bbit))]
		   [else
		    (loop ai bi (fx1+ abit) (fx1+ bbit))]))))

       (define (array=? eqtype aa abm ba eql? k shift)
	 ;; This function is called only when `bbm` equals `abm`
	 (let ([alen (array-length aa)])
	   (let loop ([ai 0] [abit 0] [k k])
	     (cond
	      [(fx= ai alen) k]
	      [(fxlogbit? abit abm)
	       (let ([k
		      (array-case aa ai
		       [(entry ak av)
			(array-case ba ai
			 [(entry bk bv) (and (key=? eqtype ak bk)
					     (eql? av bv k))]
			 [(child bc) #f])]
		       [(child ac)
			(array-case ba ai
			 [(entry bk bv) #f]
			 [(child bc) (node=? eqtype ac bc eql? k (down shift))])])])
		 (and k
		      (loop (fx1+ ai) (fx1+ abit) k)))]
	      [else
	       (loop ai (fx1+ abit) k)]))))

       (define (array-hash-code aa f hc k shift)
	 ;; Only look at values in the array, since using
	 ;; hamt bitmaps covers the keys
	 (let ([alen (array-length aa)])
	   (let loop ([ai 0] [hc hc] [k k])
	     (cond
	      [(fx= ai alen) (values hc k)]
	      [(fx<= k 0) (values hc 0)]
	      [else
	       (array-case aa ai
		[(entry _ av)
		 (let-values ([(hc k) (f av hc k)])
		   (loop (fx1+ ai) hc k))]
		[(child ac)
		 (let-values ([(hc k) (node-hash-code ac f hc k (down shift))])
		   (loop (fx1+ ai) hc k))])]))))

       (define (array-entry-at-position arr pos)
	 (let ([len (array-length arr)])
	   (let loop ([i 0] [pos pos])
	     (cond [(fx= i len) (values #f #f)]
		   [else
		    (array-case arr i
		     [(entry k v)
		      (if (fxzero? pos)
			  (values k v)
			  (loop (fx1+ i) (fx1- pos)))]
		     [(child c)
		      (let ([count (node-count c)])
			(if (fx< pos count)
			    (node-entry-at-position c pos)
			    (loop (fx1+ i) (fx- pos count))))])]))))

       ;; GENERIC NODE OPERATIONS
       ;;
       (define (key=? eqtype k1 k2)
	 (case eqtype
	   [(eq)    (eq? k1 k2)]
	   [(equal) (equal? k1 k2)]
	   [else    (eqv? k1 k2)]))

       (define (hash-code eqtype key)
	 (case eqtype
	   [(eq)    (eq-hash-code key)]
	   [(equal) (equal-hash-code key)]
	   [else    (eqv-hash-code key)]))

       (define (down n)
	 (fx+ n NODE-BIT-WIDTH))

       (define (node-mask keyhash shift)
	 (fxlogand (fxsrl keyhash shift) NODE-MASK))

       (define (node-count n)
	 (cond [(cnode? n) (array-length (cnode-array n))]
	       [else       (bnode-count n)]))

       (define (node-array n)
	 (cond [(cnode? n) (cnode-array n)]
	       [else       (bnode-array n)]))

       (define (node-ref eqtype node key keyhash shift)
	 (cond [(cnode? node) (cnode-ref eqtype node key)]
	       [else          (bnode-ref eqtype node key keyhash shift)]))

       (define (node-set eqtype node key val keyhash shift)
	 (cond [(cnode? node) (cnode-set eqtype node key val keyhash shift)]
	       [else          (bnode-set eqtype node key val keyhash shift)]))

       (define (node-remove eqtype node key keyhash shift)
	 (cond [(cnode? node) (cnode-remove eqtype node key)]
	       [else          (bnode-remove eqtype node key keyhash shift)]))

       (define (node-foldk node proc nil k)
	 (cond [(cnode? node) (array-foldk (cnode-array node) proc nil k)]
	       [else          (array-foldk (bnode-array node) proc nil k)]))

       (define (node-entry-at-position node pos)
	 (array-entry-at-position (node-array node) pos))

       (define (make-node eqtype key1 val1 k1-hash key2 val2 shift)
	 (let ([k2-hash (hash-code eqtype key2)])
	   (cond [(fx= k1-hash k2-hash)
		  (make-cnode (array [key2 val2] [key1 val1]) k2-hash)]
		 [else
		  (let*-values ([(n _) (bnode-set eqtype (empty-bnode eqtype) key2 val2 k2-hash shift)]
				[(n _) (bnode-set eqtype n key1 val1 k1-hash shift)])
		    n)])))

       (define (node-keys-subset? eqtype a b shift)
	 (cond [(eq? a b) #t]
	       [(fx> (node-count a) (node-count b)) #f]
	       [(cnode? a) (cnode-keys-subset? eqtype a b shift)]
	       [else (bnode-keys-subset? eqtype a b shift)]))

       (define (node=? eqtype na nb eql? k shift)
	 (cond [(eq? na nb) k]
	       [(cnode? na)
		(cond [(cnode? nb)
		       (and (fx= (cnode-hashcode na) (cnode-hashcode nb))
			    (let ([aa (cnode-array na)]
				  [ab (cnode-array nb)])
			      (and (= (array-length aa) (array-length ab))
				   (let loop ([i (array-length aa)] [k k])
				     (cond [(fxzero? i) k]
					   [else
					    (let* ([key (array-ref-key aa (fx1- i))]
						   [val (array-ref-value aa (fx1- i))]
						   [v2 (cnode-ref eqtype nb key)])
					      (and (not (eq? v2 NOTHING))
						   (loop (fx1- i) (eql? val v2 k))))])))))]
		      [else #f])]
	       [(bnode? nb)
		(let ([abm (bnode-bitmap na)]
		      [bbm (bnode-bitmap nb)])
		  (and (fx= abm bbm)
		       (array=? eqtype (bnode-array na) abm (bnode-array nb) eql? k shift)))]
	       [else #f]))

       (define (node-hash-code na f hc k shift)
	 (cond [(cnode? na)
		;; Hash code needs to be order-independent, so
		;; collision nodes are a problem; simplify by just
		;; using the hash code and hope that collisions are
		;; rare
		(f (cnode-hashcode na) k)]
	       [else
		(let-values ([(hc k) (f (bnode-bitmap na) hc k)])
		  (if (fx<= k 0)
		      (values hc 0)
		      (array-hash-code (bnode-array na)
				       f hc k
				       shift)))]))

       ;; BNODE OPERATIONS
       (define empty-bnode/equal (make-bnode/equal empty-array 0 0))
       (define empty-bnode/eqv (make-bnode/eqv empty-array 0 0))
       (define empty-bnode/eq (make-bnode/eq empty-array 0 0))

       (define (empty-bnode eqtype)
	 (case eqtype
	   [(eq)    empty-bnode/eq]
	   [(equal) empty-bnode/equal]
	   [else    empty-bnode/eqv]))

       (define (make-bnode* eqtype array bitmap count)
	 (case eqtype
	   [(eq)    (make-bnode/eq    array bitmap count)]
	   [(equal) (make-bnode/equal array bitmap count)]
	   [else    (make-bnode/eqv   array bitmap count)]))

       (define (bnode-bit-pos hashcode shift)
	 (fxsll 1 (node-mask hashcode shift)))

       (define (bnode-array-index bitmap bit)
	 (popcount (fxand bitmap (fx- bit 1))))

       (define (bnode-ref eqtype node key keyhash shift)
	 (let* ([bitmap (bnode-bitmap node)]
		[bit (bnode-bit-pos keyhash shift)]
		[idx (bnode-array-index bitmap bit)])
	   (cond [(fxzero? (fxlogand bit bitmap)) NOTHING]
		 [else
		  (array-case (bnode-array node) idx
		   [(entry k v)
		    (cond [(key=? eqtype key k) v]
			  [else NOTHING])]
		   [(child c)
		    (node-ref eqtype c key keyhash (down shift))])])))

       (define (bnode-set eqtype node key val keyhash shift)
	 (let* ([bitmap (bnode-bitmap node)]
		[arr (bnode-array node)]
		[bit (bnode-bit-pos keyhash shift)]
		[idx (bnode-array-index bitmap bit)]
		[count (bnode-count node)])
	   (cond [(fxzero? (fxlogand bit bitmap))
		  (values (make-bnode* eqtype (array-insert arr idx key val) (fxior bitmap bit) (fx1+ count))
			  #t)]
		 [else
		  (array-case arr idx
		   [(entry k v)
		    (cond [(key=? eqtype key k)
			   (cond [(eq? val v) (values node #f)]
				 [else (values (make-bnode* eqtype (array-replace-value arr idx val) bitmap count) #f)])]
			  [else
			   (let ([newarr (array-set-child arr idx (make-node eqtype key val keyhash k v (down shift)))])
			     (values (make-bnode* eqtype newarr bitmap (fx1+ count))
				     #t))])]
		   [(child c)
		    (let-values ([(new-child added?) (node-set eqtype c key val keyhash (down shift))])
		      (cond [(eq? new-child c) (values node #f)]
			    [else
			     (let* ([newarr (array-replace-child arr idx new-child)]
				    [new (make-bnode* eqtype newarr bitmap (if added? (fx1+ count) count))])
			       (values new added?))]))])])))

       (define (bnode-remove eqtype node key keyhash shift)
	 (let* ([bitmap (bnode-bitmap node)]
		[arr (bnode-array node)]
		[bit (bnode-bit-pos keyhash shift)]
		[idx (bnode-array-index bitmap bit)])
	   (cond [(fxzero? (fxlogand bit bitmap)) node]
		 [else
		  (let ([count (bnode-count node)])
		    (array-case arr idx
		     [(entry k v)
		      (cond [(key=? eqtype key k)
			     (cond [(fx= bitmap bit) (if (fxzero? shift) (empty-bnode eqtype) #f)]
				   [else (make-bnode* eqtype (array-remove arr idx) (fxxor bitmap bit) (fx1- count))])]
			    [else node])]
		     [(child c)
		      (let ([n (node-remove eqtype c key keyhash (down shift))])
			(cond [(eq? n c) node]
			      [n
			       (cond [(fx= 1 (node-count n))
				      (let* ([ca (node-array n)]
					     [ck (array-ref-key ca 0)]
					     [cv (array-ref-value ca 0)])
					(make-bnode* eqtype (array-replace arr idx ck cv) bitmap (fx1- count)))]
				     [else
				      (make-bnode* eqtype (array-replace-child arr idx n) bitmap (fx1- count))])]
			      [(fx= bitmap bit) (if (fxzero? shift) (empty-bnode eqtype) #f)]
			      [else (make-bnode* eqtype (array-remove arr idx) (fxxor bitmap bit) (fx1- count))]))]))])))

       ;; `a` is a bnode
       (define (bnode-keys-subset? eqtype a b shift)
	 (let ([aa (bnode-array a)])
	   (cond [(cnode? b)
		  (cond [(fx= 1 (array-length aa))
			 (array-case aa 0
			  [(entry k v) (cnode-index eqtype b k)]
			  [(child c) (node-keys-subset? eqtype c b (down shift))])]
			[else #f])]
		 [else
		  (let ([abm (bnode-bitmap a)]
			[bbm (bnode-bitmap b)])
		    (and (fx= abm (fxlogand abm bbm))
			 (array-keys-subset? eqtype aa abm (bnode-array b) bbm shift)))])))

       ;; CNODE OPERATIONS
       (define (cnode-ref eqtype node key)
	 (let ([idx (cnode-index eqtype node key)])
	   (if idx
	       (array-ref-value (cnode-array node) idx)
	       NOTHING)))

       (define (cnode-index eqtype node key)
	 (let* ([arr (cnode-array node)]
		[len (array-length arr)])
	   (let loop ([i 0])
	     (cond [(< i len)
		    (if (key=? eqtype key (array-ref-key arr i))
			i
			(loop (fx+ i 1)))]
		   [else #f]))))

       (define (cnode-set eqtype node key val keyhash shift)
	 (cond [(fx= keyhash (cnode-hashcode node))
		(let ([idx (cnode-index eqtype node key)]
		      [arr (cnode-array node)])
		  (cond [idx
			 (if (eq? val (array-ref-value arr idx))
			     (values node #f)
			     (values (make-cnode (array-replace-value arr idx val) keyhash) #f))]
			[else
			 (values (make-cnode (array-append arr key val) keyhash) #t)]))]
	       [else
		(let ([child (make-bnode* eqtype (array node) (bnode-bit-pos (cnode-hashcode node) shift) 1)])
		  (bnode-set eqtype child key val keyhash shift))]))

       (define (cnode-remove eqtype node key)
	 (let ([idx (cnode-index eqtype node key)]
	       [arr (cnode-array node)])
	   (cond [(not idx) node]
		 [(fx= (array-length arr) 1) #f]
		 [else (make-cnode (array-remove (cnode-array node) idx)
				   (cnode-hashcode node))])))

       ;; `a` is a cnode
       (define (cnode-keys-subset? eqtype a b shift)
	 (let ([aa (cnode-array a)])
	   (cond [(cnode? b)
		  (and (fx= (cnode-hashcode a) (cnode-hashcode b))
		       (let loop ([i (array-length aa)])
			 (cond [(fxzero? i) #t]
			       [else
				(let ([k (array-ref-key aa (fx1- i))])
				  (and (cnode-index eqtype b k)
				       (loop (fx1- i))))])))]
		 [else
		  (let loop ([i (array-length aa)])
		    (cond [(fxzero? i) #t]
			  [else
			   (let ([k (array-ref-key aa (fx1- i))])
			     (and (not (eq? NOTHING
					    (bnode-ref eqtype b k (hash-code eqtype k) shift)))
				  (loop (fx1- i))))]))])))

       ;; HAMT OPERATIONS
       (define empty-hamt    empty-bnode/equal)
       (define empty-hamteqv empty-bnode/eqv)
       (define empty-hamteq  empty-bnode/eq)

       (define (hamt? x)
	 (bnode? x))

       (define (hamt-eq? x)
	 (bnode/eq? x))

       (define (hamt-eqv? x)
	 (bnode/eqv? x))

       (define (hamt-equal? x)
	 (bnode/equal? x))

       (define (hamt=? a b eql? k)
	 (and (fx= (node-count a) (node-count b))
	      (cond [(bnode/equal? a) (node=? 'equal a b eql? k 0)]
		    [(bnode/eq? a)    (node=? 'eq    a b eql? k 0)]
		    [else             (node=? 'eqv   a b eql? k 0)])))

       (define (hamt-hash-code h f hc k)
	 (node-hash-code h f hc k 0))

       (define (return default)
	 (if (procedure? default)
	     (default)
	     default))

       (define (hamt-ref/raw h key)
	 (cond [(bnode/equal? h) (bnode-ref 'equal h key (equal-hash-code key) 0)]
	       [(bnode/eq? h)    (bnode-ref 'eq    h key (eq-hash-code key) 0)]
	       [else             (bnode-ref 'eqv   h key (eqv-hash-code key) 0)]))

       (define (hamt-has-key? h key)
	 (not (eq? NOTHING (hamt-ref/raw h key))))

       (define (hamt-ref h key default)
	 (let ([result (hamt-ref/raw h key)])
	   (if (eq? result NOTHING)
	       (return default)
	       result)))

       (define (hamt-set h key val)
	 (define-values (n _)
	   (cond [(bnode/equal? h) (bnode-set 'equal h key val (equal-hash-code key) 0)]
		 [(bnode/eq? h)    (bnode-set 'eq    h key val (eq-hash-code key) 0)]
		 [else             (bnode-set 'eqv   h key val (eqv-hash-code key) 0)]))
	 n)

       (define (hamt-remove h key)
	 (cond [(bnode/equal? h) (bnode-remove 'equal h key (equal-hash-code key) 0)]
	       [(bnode/eq? h)    (bnode-remove 'eq    h key (eq-hash-code key) 0)]
	       [else             (bnode-remove 'eqv   h key (eqv-hash-code key) 0)]))

       (define (hamt-keys-subset? a b)
	 (cond [(bnode/equal? a) (node-keys-subset? 'equal a b 0)]
	       [(bnode/eq? a)    (node-keys-subset? 'eq    a b 0)]
	       [else             (node-keys-subset? 'eqv   a b 0)]))

       ;; ITERATION
       (define-record-type hamt-position
	 [fields (immutable key)
		 (immutable value)
		 (immutable continue-k)]
	 [sealed #t])

       (define (hamt-iterate-first h)
	 (if (fxzero? (node-count h))
	     #f
	     0))

       (define (hamt-iterate-next h pos)
	 (let ([pos (add1 pos)])
	   (if (fx= pos (node-count h))
	       #f
	       pos)))

       (define (hamt-iterate-key h pos fail)
	 (let-values ([(key _) (node-entry-at-position h pos)])
	   (or key fail)))

       (define (hamt-iterate-value h pos fail)
	 (let-values ([(_ val) (node-entry-at-position h pos)])
	   (or val fail)))

       (define (hamt-iterate-key+value h pos fail)
	 (let-values ([(key val) (node-entry-at-position h pos)])
	   (if key
	       (values key val)
	       fail)))

       (define (hamt-iterate-pair h pos fail)
	 (let-values ([(key val) (node-entry-at-position h pos)])
	   (if key
	       (cons key val)
	       fail)))

       (define (unsafe-hamt-iterate-first h)
	 (node-foldk h
		     (lambda (key val _ k)
		       (make-hamt-position key val k))
		     #f
		     (lambda (nil) nil)))

       (define (unsafe-hamt-iterate-next h pos)
	 ((hamt-position-continue-k pos) #f))

       (define (unsafe-hamt-iterate-key h pos)
	 (hamt-position-key pos))

       (define (unsafe-hamt-iterate-value h pos)
	 (hamt-position-value pos))

       (define (unsafe-hamt-iterate-key+value h pos)
	 (values (hamt-position-key pos)
		 (hamt-position-value pos)))

       (define (unsafe-hamt-iterate-pair h pos)
	 (cons (hamt-position-key pos)
	       (hamt-position-value pos)))

       (values empty-hamt
	       empty-hamteqv
	       empty-hamteq

	       hamt?
	       hamt-equal?
	       hamt-eqv?
	       hamt-eq?

	       hamt=?
	       hamt-hash-code

	       node-count
	       hamt-has-key?
	       hamt-ref
	       hamt-set
	       hamt-remove
	       hamt-keys-subset?

	       node-foldk

	       hamt-iterate-first
	       hamt-iterate-next
	       hamt-iterate-key
	       hamt-iterate-value
	       hamt-iterate-key+value
	       hamt-iterate-pair

	       unsafe-hamt-iterate-first
	       unsafe-hamt-iterate-next
	       unsafe-hamt-iterate-key
	       unsafe-hamt-iterate-value
	       unsafe-hamt-iterate-key+value
	       unsafe-hamt-iterate-pair))]))
