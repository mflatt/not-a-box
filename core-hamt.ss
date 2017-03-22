(define-syntax define-syntax-rule
  (syntax-rules ()
    [(_ (name h ...) e ...)
     (define-syntax name
       (syntax-rules ()
	 [(_ h ...) e ...]))]))

;; arrays:
;;
;; Arrays are simply vectors for storing key/value pairs,
;; but we store the key at index 2i and the value at 2i + 1.

(define empty-array (vector))
(define array-copy vector-copy)

(define (make-array len)
  (make-vector (#3%fx* len 2) #f))

(define (array-length arr)
  (quotient (#3%vector-length arr) 2))

(define (array-ref-key arr i)
  (#3%vector-ref arr (#3%fx* i 2)))

(define (array-ref-value arr i)
  (#3%vector-ref arr (#3%fx+ (#3%fx* i 2) 1)))

(define-syntax-rule (array-ref arr i)
  (let ([idx i])
    (values (array-ref-key arr idx)
	    (array-ref-value arr idx))))

(define (array-set-key! arr i key)
  (#3%vector-set! arr (#3%fx* i 2) key))

(define (array-set-value! arr i value)
  (#3%vector-set! arr (#3%fx+ (#3%fx* i 2) 1) value))

(define (array-set! arr i key val)
  (array-set-key! arr i key)
  (array-set-value! arr i val))

(define (array-copy! dst dst-start src src-start src-end)
  (vector-copy! dst (#3%fx* dst-start 2) src (#3%fx* src-start 2) (#3%fx* src-end 2)))

(define (array-replace arr idx key val)
  (let ([new (array-copy arr)])
    (array-set! new idx key val)
    new))

(define (array-replace-value arr idx val)
  (let ([new (array-copy arr)])
    (array-set-value! new idx val)
    new))

(define (array-insert arr idx key val)
  (let ([new (make-array (#3%fx+ (array-length arr) 1))])
    (array-copy! new 0 arr 0 idx)
    (array-set! new idx key val)
    (array-copy! new (#3%fx+ idx 1) arr idx (array-length arr))
    new))

(define (array-remove arr idx)
  (let ([new (make-array (#3%fx- (array-length arr) 1))])
    (array-copy! new 0 arr 0 idx)
    (array-copy! new idx arr (#3%fx+ idx 1) (array-length arr))
    new))

(define (array-entry-at-position arr pos)
  (let ([len (array-length arr)])
    (let loop ([i 0] [pos pos])
      (cond [(#3%fx= i len) (values #f #f)]
	    [else
	     (let-values ([(k v) (array-ref arr i)])
	       (cond [k
		      (if (zero? pos)
			  (values k v)
			  (loop (fx1+ i) (fx1- pos)))]
		     [else
		      (let ([count (node-count v)])
			(if (fx< pos count)
			    (node-entry-at-position v pos)
			    (loop (fx1+ i) (fx- pos count))))]))]))))

(define (array-iterate arr k done-k)
  (let ([len (array-length arr)])
    (let loop ([i 0] [k k])
      (cond [(#3%fx= i len) (done-k k)]
            [else
	     (let-values ([(key val) (array-ref arr i)])
               (if key
                   (k key val (lambda (k) (loop (#3%fx1+ i) k)))
                   (node-iterate val k (lambda (k) (loop (#3%fx1+ i) k)))))]))))

(define (array-hash-code aa f hc k shift)
  ;; Only look at values in the array, since using
  ;; hamt bitmaps covers the keys
  (let ([alen (array-length aa)])
    (let loop ([ai 0] [hc hc] [k k])
      (cond
       [(fx= ai alen) (values hc k)]
       [(fx<= k 0) (values hc 0)]
       [else
        (let-values ([(ak av) (array-ref aa ai)])
          (cond
           [ak
            (let-values ([(hc k) (f av hc k)])
              (loop (fx1+ ai) hc k))]
           [else
            (let-values ([(hc k) (node-hash-code av f hc k (down shift))])
              (loop (fx1+ ai) hc k))]))]))))

;; constants
;; 4-bit fields perform best. Not sure why.
(define NODE-BIT-WIDTH 4)
(define NODE-MASK (fx- (fxsll 1 NODE-BIT-WIDTH) 1))
(define NOTHING (gensym))

;; general nodes
(define (down n)
  (#3%fx+ n NODE-BIT-WIDTH))

(define (node-mask hashcode shift)
  (#3%fxlogand (#3%fxsrl hashcode shift) NODE-MASK))

(define (node-count n)
  (cond [(cnode? n) (array-length (cnode-array n))]
	[else       (bnode-count n)]))

(define (node-hash-code na f hc k shift)
  (cond
   [(bnode? na)
    (let-values ([(hc k) (f (bnode-bitmap na) hc k)])
      (if (fx<= k 0)
          (values hc 0)
          (array-hash-code (bnode-array na)
                           f hc k
                           shift)))]
   [else
    ;; Hash code needs to be order-independent, so
    ;; collision nodes are a problem; simplify by just
    ;; using the hash code and hope that collisions are
    ;; rare
    (f (cnode-hashcode na) k)]))

(define-syntax (def/node-ops stx)
  (syntax-case stx ()
    [(_ eqtype)
     (let* ([eqtype-str (chez:symbol->string (syntax->datum #'eqtype))]
	    [key=? (datum->syntax #'eqtype (string->symbol (string-append eqtype-str "?")))]
	    [id (lambda (name)
		  (datum->syntax #'eqtype
				 (string->symbol (string-append name "/" eqtype-str))))]
	    [hash-code (datum->syntax #'eqtype (string->symbol (string-append eqtype-str "-hash-code")))])
       #`(begin
	   (define (#,(id "node-ref") node key keyhash shift)
	     (cond [(cnode? node) (#,(id "cnode-ref") node key)]
		   [else          (#,(id "bnode-ref") node key keyhash shift)]))

	   (define (#,(id "node-set") node key val keyhash shift)
	     (cond [(cnode? node) (#,(id "cnode-set") node key val keyhash shift)]
		   [else          (#,(id "bnode-set") node key val keyhash shift)]))

	   (define (#,(id "node-remove") node key keyhash shift)
	     (cond [(cnode? node) (#,(id "cnode-remove") node key keyhash shift)]
		   [else          (#,(id "bnode-remove") node key keyhash shift)]))

	   (define (#,(id "make-node") key1 val1 k1-hash key2 val2 shift)
	     (let ([k2-hash (#,hash-code key2)])
	       (cond [(#3%fx= k1-hash k2-hash)
		      (make-cnode (vector key2 val2 key1 val1) k2-hash)]
		     [else
		      (let*-values ([(n _) (#,(id "bnode-set") #,(id "empty-bnode") key2 val2 k2-hash shift)]
				    [(n _) (#,(id "bnode-set") n key1 val1 k1-hash shift)])
			n)])))

	   (define (#,(id "node=?") na nb eql? k shift)
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
						(let*-values ([(key val) (array-ref aa (fx1- i))]
							      [(v2) (#,(id "cnode-ref") nb key)])
						  (and (not (eq? v2 NOTHING))
						       (loop (fx1- i) (eql? val v2 k))))])))))]
			  [else #f])]
		   [(bnode? nb)
		    (let ([abm (bnode-bitmap na)]
			  [bbm (bnode-bitmap nb)])
		      (and (fx= abm bbm)
			   (#,(id "array=?") (bnode-array na) abm (bnode-array nb) eql? k shift)))]
		   [else #f]))

	   (define (#,(id "array=?") aa abm ba eql? k shift)
	     ;; This function is called only when `bbm` equals `abm`
	     (let ([alen (array-length aa)])
	       (let loop ([ai 0] [abit 0] [k k])
		 (cond
		  [(fx= ai alen) k]
		  [(fxlogbit? abit abm)
		   (let-values ([(ak av) (array-ref aa ai)]
				[(bk bv) (array-ref ba ai)])
		     (let ([k (cond
			       [ak
				(cond
				 [bk
				  (and (#,key=? ak bk)
				       (eql? av bv k))]
				 [else #f])]
			       [bk #f]
			       [else
				(#,(id "node=?") av bv eql? k (down shift))])])
		       (and k
			    (loop (fx+ ai 1) (fx+ abit 1) k))))]
		  [else
		   (loop ai (fx+ abit 1) k)]))))

	   (define (#,(id "node-keys-subset?") a b shift)
	     (cond [(eq? a b) #t]
		   [(> (node-count a) (node-count b)) #f]
		   [(cnode? a)
		    (let ([aa (cnode-array a)])
		      (cond [(cnode? b)
			     (and (#3%fx= (cnode-hashcode a) (cnode-hashcode b))
				  (let loop ([i (array-length aa)])
				    (cond [(#3%fxzero? i) #t]
					  [else
					   (let-values ([(k v) (array-ref aa (#3%fx1- i))])
					     (and (#,(id "cnode-index") b k)
						  (loop (#3%fx1- i))))])))]
			    [else
			     (let loop ([i (array-length aa)])
			       (cond [(#3%fxzero? i) #t]
				     [else
				      (let-values ([(k v) (array-ref aa (#3%fx1- i))])
					(and (not (eq? (#,(id "bnode-ref") b k (#,hash-code k) shift)
						       NOTHING))
					     (loop (#3%fx1- i))))]))]))]
		   [else
		    (let ([aa (bnode-array a)])
		      (cond [(cnode? b)
			     (cond [(#3%fx= 1 (array-length aa))
				    (let-values ([(k v) (array-ref aa 0)])
				      (cond [(not k) (#,(id "node-keys-subset?") v b (down shift))]
					    [else (#,(id "cnode-index") b k)]))]
				   [else #f])]
			    [else
			     (let ([abm (bnode-bitmap a)]
				   [bbm (bnode-bitmap b)])
			       (and (#3%fx= abm (#3%fxlogand abm bbm))
				    (#,(id "array-keys-subset?") aa abm (bnode-array b) bbm shift)))]))]))

	   (define (#,(id "array-keys-subset?") aa abm ba bbm shift)
	     (let ([alen (array-length aa)])
	       (let loop ([ai 0] [bi 0] [abit 0] [bbit 0])
		 (cond [(#3%fx= ai alen) #t]
		       [(#3%fxlogbit? abit abm)
			(let-values ([(ak av) (array-ref aa ai)]
				     [(bk bv) (array-ref ba bi)])
			  (and
			   (cond [(not ak)
				  (and (not bk)
				       (#,(id "node-keys-subset?") av bv (down shift)))]
				 [bk (#,key=? ak bk)]
				 [(cnode? bv) (#,(id "cnode-index") bv ak)]
				 [else (not (eq? (#,(id "bnode-ref") bv ak (#,hash-code ak) (down shift))
						 NOTHING))])
			   (loop (#3%fx1+ ai) (#3%fx1+ bi) (#3%fx1+ abit) (#3%fx1+ bbit))))]
		       [(#3%fxlogbit? bbit bbm)
			(loop ai (#3%fx1+ bi) (#3%fx1+ abit) (#3%fx1+ bbit))]
		       [else
			(loop ai bi (#3%fx1+ abit) (#3%fx1+ bbit))]))))))]))

(def/node-ops equal)
(def/node-ops eqv)
(def/node-ops eq)

(define (node-entry-at-position node pos)
  (cond [(cnode? node) (array-entry-at-position (cnode-array node) pos)]
	[else          (array-entry-at-position (bnode-array node) pos)]))

(define (node-iterate node k done-k)
  (cond [(bnode? node) (array-iterate (bnode-array node) k done-k)]
        [else          (array-iterate (cnode-array node) k done-k)]))

;; bnodes
(define-record-type bnode
  [fields (immutable array)
	  (immutable bitmap)
	  (immutable count)])

(define-record-type bnode/equal
  [parent bnode]
  [sealed #t])

(define-record-type bnode/eqv
  [parent bnode]
  [sealed #t])

(define-record-type bnode/eq
  [parent bnode]
  [sealed #t])

(define (bnode-bit-pos hashcode shift)
  (#3%fxsll 1 (node-mask hashcode shift)))

(define (bnode-array-index bitmap bit)
  (popcount16 (#3%fxand bitmap (#3%fx- bit 1))))

(define (popcount16 x)
  (let* ([x (#3%fx- x (#3%fxlogand (#3%fxsrl x 1) #x5555))]
	 [x (#3%fx+ (#3%fxlogand x #x3333) (#3%fxlogand (#3%fxsrl x 2) #x3333))]
	 [x (#3%fxlogand (#3%fx+ x (#3%fxsrl x 4)) #x0f0f)]
	 [x (#3%fx+ x (#3%fxsrl x 8))])
    (#3%fxlogand x #x1f)))

(define empty-bnode/equal (make-bnode/equal empty-array 0 0))
(define empty-bnode/eqv (make-bnode/eqv empty-array 0 0))
(define empty-bnode/eq (make-bnode/eq empty-array 0 0))

(define-syntax (def/bnode-ops stx)
  (syntax-case stx ()
    [(_ eqtype)
     (let* ([eqtype-str (chez:symbol->string (syntax->datum #'eqtype))]
	    [key=? (datum->syntax #'eqtype (string->symbol (string-append eqtype-str "?")))]
	    [id (lambda (name)
		  (datum->syntax #'eqtype
				 (string->symbol (string-append name "/" eqtype-str))))])
       #`(begin
	   (define (#,(id "bnode-ref") node key keyhash shift)
	     (let* ([bitmap (bnode-bitmap node)]
		    [bit (bnode-bit-pos keyhash shift)]
		    [idx (bnode-array-index bitmap bit)])
	       (cond [(#3%fxzero? (#3%fxlogand bit bitmap)) NOTHING]
		     [else
		      (let*-values ([(arr) (bnode-array node)]
				    [(k v) (array-ref arr idx)])
			(cond [(not k) (#,(id "node-ref") v key keyhash (down shift))]
			      [(#,key=? key k) v]
			      [else NOTHING]))])))

	   (define (#,(id "bnode-set") node key val keyhash shift)
	     (let* ([bitmap (bnode-bitmap node)]
		    [arr (bnode-array node)]
		    [bit (bnode-bit-pos keyhash shift)]
		    [idx (bnode-array-index bitmap bit)]
		    [count (bnode-count node)])
	       (cond [(#3%fxzero? (#3%fxlogand bit bitmap))
		      (values (#,(id "make-bnode") (array-insert arr idx key val) (#3%fxior bitmap bit) (#3%fx1+ count))
			      #t)]
		     [else
		      (let-values ([(k v) (array-ref arr idx)])
			(cond [(not k)
			       (let-values ([(new added?) (#,(id "node-set") v key val keyhash (down shift))])
				 (cond [(eq? new v) (values node #f)]
				       [else (values (#,(id "make-bnode") (array-replace-value arr idx new) bitmap (if added? (#3%fx1+ count) count))
						     added?)]))]
			      [(#,key=? key k)
			       (cond [(eq? val v) (values node #f)]
				     [else (values (#,(id "make-bnode") (array-replace-value arr idx val) bitmap count) #f)])]
			      [else
			       (values
				(#,(id "make-bnode")
				 (array-replace arr idx #f (#,(id "make-node") key val keyhash k v (down shift)))
				 bitmap
				 (#3%fx1+ count))
				#t)]))])))

	   (define (#,(id "bnode-remove") node key keyhash shift)
	     (let* ([bitmap (bnode-bitmap node)]
		    [arr (bnode-array node)]
		    [bit (bnode-bit-pos keyhash shift)]
		    [idx (bnode-array-index bitmap bit)])
	       (cond [(#3%fxzero? (#3%fxlogand bit bitmap)) node]
		     [else
		      (let-values ([(count) (bnode-count node)]
				   [(k v) (array-ref arr idx)])
			(cond [(not k)
			       (let ([n (#,(id "node-remove") v key keyhash (down shift))])
				 (cond [(eq? n v) node]
				       [n (#,(id "make-bnode") (array-replace-value arr idx n) bitmap (#3%fx1- count))]
				       [(#3%fx= bitmap bit) (if (#3%fxzero? shift) #,(id "empty-bnode") #f)]
				       [else (#,(id "make-bnode") (array-remove arr idx) (#3%fxxor bitmap bit) (#3%fx1- count))]))]
			      [(#,key=? key k)
			       (cond [(#3%fx= bitmap bit) (if (#3%fxzero? shift) #,(id "empty-bnode") #f)]
				     [else (#,(id "make-bnode") (array-remove arr idx) (#3%fxxor bitmap bit) (#3%fx1- count))])]
			      [else node]))])))))]))

(def/bnode-ops equal)
(def/bnode-ops eqv)
(def/bnode-ops eq)

;; cnodes
(define-record-type cnode
  [fields (immutable array)
	  (immutable hashcode)]
  [sealed #t])

(define-syntax (def/cnode-ops stx)
  (syntax-case stx ()
    [(_ eqtype)
     (let* ([eqtype-str (chez:symbol->string (syntax->datum #'eqtype))]
	    [key=? (datum->syntax #'eqtype (string->symbol (string-append eqtype-str "?")))]
	    [id (lambda (name)
		  (datum->syntax #'eqtype
				 (string->symbol (string-append name "/" eqtype-str))))])
       #`(begin
	   (define (#,(id "cnode-ref") node key)
	     (let ([idx (#,(id "cnode-index") node key)])
	       (if idx
		   (array-ref-value (cnode-array node) idx)
		   NOTHING)))

	   (define (#,(id "cnode-index") node key)
	     (let* ([arr (cnode-array node)]
		    [len (array-length arr)])
	       (let loop ([i 0])
		 (cond [(< i len)
			(if (#,key=? key (array-ref-key arr i))
			    i
			    (loop (fx+ i 1)))]
		       [else #f]))))

	   (define (#,(id "cnode-set") node key val keyhash shift)
	     (cond [(#3%fx= keyhash (cnode-hashcode node))
		    (let ([idx (#,(id "cnode-index") node key)]
			  [arr (cnode-array node)])
		      (cond [idx
			     (if (eq? val (array-ref-value arr idx))
				 (values node #f)
				 (values (make-cnode (array-replace-value arr idx val) keyhash) #f))]
			    [else
			     (let ([len (array-length arr)])
			       (values (make-cnode (array-insert arr len key val) keyhash) #t))]))]
		   [else
		    (#,(id "bnode-set")
		     (#,(id "make-bnode") (vector #f node) (bnode-bit-pos (cnode-hashcode node) shift) 1)
		     key val keyhash shift)]))

	   (define (#,(id "cnode-remove") node key keyhash shift)
	     (let ([idx (#,(id "cnode-index") node key)]
		   [arr (cnode-array node)])
	       (cond [(not idx) node]
		     [(#3%fx= (array-length arr) 1) #f]
		     [else (make-cnode (array-remove (cnode-array node) idx)
				       (cnode-hashcode node))])))))]))

(def/cnode-ops equal)
(def/cnode-ops eqv)
(def/cnode-ops eq)

;; hamt
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

(define (return default)
  (if (procedure? default)
      (default)
      default))

(define (hamt-ref h key default)
  (let ([result
	 (cond [(bnode/equal? h) (bnode-ref/equal h key (equal-hash-code key) 0)]
	       [(bnode/eq? h)    (bnode-ref/eq    h key (eq-hash-code key) 0)]
	       [else             (bnode-ref/eqv   h key (eqv-hash-code key) 0)])])
    (if (eq? result NOTHING)
        (return default)
        result)))

(define (hamt-set h key val)
  (define-values (n _)
    (cond [(bnode/equal? h) (bnode-set/equal h key val (equal-hash-code key) 0)]
	  [(bnode/eq? h)    (bnode-set/eq    h key val (eq-hash-code key) 0)]
	  [else             (bnode-set/eqv   h key val (eqv-hash-code key) 0)]))
  n)

(define (hamt-remove h key)
  (cond [(bnode/equal? h) (bnode-remove/equal h key (equal-hash-code key) 0)]
	[(bnode/eq? h)    (bnode-remove/eq    h key (eq-hash-code key) 0)]
	[else             (bnode-remove/eqv   h key (eqv-hash-code key) 0)]))

(define (hamt-keys-subset? a b)
  (cond [(bnode/equal? a) (node-keys-subset?/equal a b 0)]
	[(bnode/eq? a)    (node-keys-subset?/eq    a b 0)]
	[else             (node-keys-subset?/eqv   a b 0)]))

(define (hamt=? a b eql? k)
  (and (= (bnode-count a) (bnode-count b))
       (cond [(bnode/equal? a) (node=?/equal a b eql? k 0)]
	     [(bnode/eq? a)    (node=?/eq    a b eql? k 0)]
	     [else             (node=?/eqv   a b eql? k 0)])))

(define (hamt-hash-code na f hc k)
  (node-hash-code na f hc k 0))

(define (hamt-fold h nil proc)
  (let loop ([pos (unsafe-hamt-iterate-first h)] [res nil])
    (cond [pos
	   (loop (unsafe-hamt-iterate-next h pos)
		 (proc (hamt-position-key pos)
		       (hamt-position-value pos)
		       res))]
	  [else res])))

(define (hamt-for-each h proc)
  (hamt-fold h (void) (lambda (k v _) (proc k v) (void))))

(define (hamt-map h proc)
  (hamt-fold h '() (lambda (k v acc) (cons (proc k v) acc))))

(define (hamt-keys h)
  (hamt-fold h '() (lambda (k _ acc) (cons k acc))))

(define (hamt-values h)
  (hamt-fold h '() (lambda (_ v acc) (cons v acc))))

(define (hamt->list h)
  (hamt-fold h '() (lambda (k v acc) (cons (cons k v) acc))))

(define (hamt-count h)
  (bnode-count h))


;; iteration

;; generic iteration works by counting

(define (hamt-iterate-first h)
  (if (zero? (bnode-count h))
      #f
      0))

(define (hamt-iterate-next h pos)
  (let ([pos (add1 pos)])
    (if (fx= pos (bnode-count h))
        #f
        pos)))

(define (hamt-iterate-key h pos fail)
  (let-values ([(key _) (node-entry-at-position h pos)])
    (if key
        key
        fail)))

(define (hamt-iterate-value h pos fail)
  (let-values ([(key val) (node-entry-at-position h pos)])
    (if key
        val
        fail)))

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

;; "unsafe" iteration works with a record; it's unsafe only in the
;; sense that it doesn't make sure the iteration value is compatible
;; with the hash table

(define-record-type hamt-position
  [fields (immutable key)
	  (immutable value)
	  (immutable continue-k)]
  [sealed #t])

(define (unsafe-hamt-iterate-first h)
  (node-iterate h
                make-hamt-position
                (lambda (k) #f)))

(define (unsafe-hamt-iterate-next h pos)
  ((hamt-position-continue-k pos)
   make-hamt-position))

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

;; hash interface

;; hash constructors
(define empty-hash empty-hamt)
(define empty-hasheqv empty-hamteqv)
(define empty-hasheq empty-hamteq)

(define immutable-hash? hamt?)

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

(define-hash-constructors hash make-immutable-hash empty-hamt)
(define-hash-constructors hasheqv make-immutable-hasheqv empty-hamteqv)
(define-hash-constructors hasheq make-immutable-hasheq empty-hamteq)

(define unsafe-immutable-hash-iterate-first unsafe-hamt-iterate-first)
(define unsafe-immutable-hash-iterate-next unsafe-hamt-iterate-next)
(define unsafe-immutable-hash-iterate-key unsafe-hamt-iterate-key)
(define unsafe-immutable-hash-iterate-value unsafe-hamt-iterate-value)
(define unsafe-immutable-hash-iterate-key+value unsafe-hamt-iterate-key+value)
(define unsafe-immutable-hash-iterate-pair unsafe-hamt-iterate-pair)
