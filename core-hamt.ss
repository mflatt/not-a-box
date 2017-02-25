;; Based on the "hamt" package by Jon Zeppieri

;; The MIT License (MIT)
;; 
;; Copyright (c) 2013 97jaz
;; 
;; Permission is hereby granted, free of charge, to any person obtaining a copy of
;; this software and associated documentation files (the "Software"), to deal in
;; the Software without restriction, including without limitation the rights to
;; use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
;; the Software, and to permit persons to whom the Software is furnished to do so,
;; subject to the following conditions:
;; 
;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.
;; 
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
;; FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
;; COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
;; IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(define (vector-copy! dest d-start src s-start s-end)
  (let loop ([i (- s-end s-start)])
    (unless (zero? i)
      (let ([i (sub1 i)])
        (vector-set! dest (+ d-start i) (vector-ref src (+ s-start i)))
        (loop i)))))

(define array-length vector-length)
(define array-ref vector-ref)
(define array vector)

(define (array-replace arr idx val)
  (define len (vector-length arr))
  (define new (make-vector len))
  
  (let loop ([i 0])
    (cond [(= i idx)
           (vector-set! new i val)
           (loop (fx+ i 1))]
          [(< i len)
           (vector-set! new i (vector-ref arr i))
           (loop (+ i 1))]
          [else
           new])))

(define (array-insert arr idx val)
  (define new (make-vector (+ (vector-length arr) 1)))
  (vector-copy! new 0 arr 0 idx)
  (vector-set! new idx val)
  (vector-copy! new (fx+ idx 1) arr idx (vector-length arr))
  new)

(define (array-remove arr idx)
  (define new (make-vector (- (vector-length arr) 1)))
  (vector-copy! new 0 arr 0 idx)
  (vector-copy! new idx arr (+ idx 1) (vector-length arr))
  new)

;; node types
(define-record entry (key value))
(define-record bnode (array bitmap count)) ; count includes subtrees
(define-record cnode (array hashcode))

;; To more compactly represent sets, special-case an entry
;; that has a #t value:
(define (entry*? e) (and e (not (bnode? e)) (not (cnode? e))))
(define (entry*-key e) (if (entry? e) (entry-key e) e))
(define (entry*-value e) (if (entry? e) (entry-value e) #t))
(define (make-entry* k v) (if (and k (eq? v #t)) k (make-entry k v)))

(define *nothing* (list '*nothing*))

;; encode equality type in outermost bnode type:
(define-record bnode/eq bnode ())
(define-record bnode/equal bnode ())
(define-record bnode/eqv bnode ())

(define (make-bnode* key= array bitmap count)
  (cond
   [(eq? key= eq?) (make-bnode/eq array bitmap count)]
   [(eq? key= eqv?) (make-bnode/eqv array bitmap count)]
   [else (make-bnode/equal array bitmap count)]))

(define empty-array (array))
(define empty-bnode (make-bnode empty-array 0 0))
(define empty-hasheq (make-bnode/eq empty-array 0 0))
(define empty-hash (make-bnode/equal empty-array 0 0))
(define empty-hasheqv (make-bnode/eqv empty-array 0 0))

(define hamt? bnode?)
(define immutable-hash? hamt?)

(define hamt-equal? bnode/equal?)
(define hamt-eqv? bnode/eqv?)
(define hamt-eq? bnode/eq?)

(define hamt-count bnode-count)

;; iterator position
(define-record hash-position (entry continue-k))

(define-syntax define-hash-constructors
  (syntax-rules ()
    [(_ vararg-constructor list-constructor make-bnode)
     (begin
       (define (vararg-constructor . kvs)
         (let loop ([kvs kvs] [h (make-bnode empty-array 0 0)])
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
                  assocs
                  (loop (hamt-set h (caar assocs) (cdar assocs))
                        (cdr assocs))))])))]))

(define-hash-constructors hash make-immutable-hash make-bnode/equal)
(define-hash-constructors hasheqv make-immutable-hasheqv make-bnode/eqv)
(define-hash-constructors hasheq make-immutable-hasheq make-bnode/eq)

(define make-hamt make-immutable-hash)
(define make-hamteq make-immutable-hasheq)
(define make-hamteqv make-immutable-hasheqv)

(define (hamt-empty? h)
  (= (hamt-count h) 0))

(define (hamt-ref h key default)
  (cond
   [(bnode/eq? h)
    (node-ref h key (eq-hash-code key) eq? 0 default)]
   [(bnode/equal? h)
    (node-ref h key (equal-hash-code key) equal? 0 default)]
   [else
    (node-ref h key (eqv-hash-code key) eqv? 0 default)]))

(define (hamt-set h key val)
  (let-values ([(new-h added?)
                (cond
                 [(bnode/eq? h)
                  (node-set h key val (eq-hash-code key) eq? eq-hash-code 0)]
                 [(bnode/equal? h)
                  (node-set h key val (equal-hash-code key) equal? equal-hash-code 0)]
                 [else
                  (node-set h key val (eqv-hash-code key) eqv? eqv-hash-code 0)])])
    new-h))

(define (hamt-remove h key)
  (cond
   [(bnode/eq? h)
    (node-remove h key (eq-hash-code key) eq? 0)]
   [(bnode/equal? h)
    (node-remove h key (equal-hash-code key) equal? 0)]
   [else
    (node-remove h key (eqv-hash-code key) eqv? 0)]))

(define (hamt-map h proc)
  (hamt-fold h '() (lambda (k v acc) (cons (proc k v) acc))))

(define (hamt-keys h)
  (hamt-fold h '() (lambda (k _ acc) (cons k acc))))

(define (hamt-values h)
  (hamt-fold h '() (lambda (_ v acc) (cons v acc))))

(define (hamt->list h)
  (hamt-fold h '() (lambda (k v acc) (cons (cons k v) acc))))

(define (hamt-for-each h proc)
  (hamt-fold h (void) (lambda (k v _) (proc k v) (void))))

(define (hamt-fold h id proc)
  (node-fold h id proc))

(define (hamt-keys-subset? a b)
  (and (<= (bnode-count a) (bnode-count b))
       (cond
        [(bnode/eq? a)
         (node-keys-subset? a b eq? eq-hash-code 0)]
        [(bnode/equal? a)
         (node-keys-subset? a b equal? equal-hash-code 0)]
        [else
         (node-keys-subset? a b eqv? eqv-hash-code 0)])))

;; generic iteration works by counting

(define (hamt-iterate-first h)
  (if (zero? (bnode-count h))
      #f
      0))

(define (hamt-iterate-next h pos)
  (let ([pos (add1 pos)])
    (if (= pos (bnode-count h))
        #f
        pos)))

(define (hamt-iterate-key h pos fail-k)
  (let ([e (node-entry-at-position h pos)])
    (if e
        (entry*-key e)
        (fail-k))))

(define (hamt-iterate-value h pos fail-k)
  (let ([e (node-entry-at-position h pos)])
    (if e
        (entry*-value e)
        (fail-k))))

(define (hamt-iterate-key+value h pos fail-k)
  (let ([e (node-entry-at-position h pos)])
    (if e
        (values (entry*-key e)
                (entry*-value e))
        (fail-k))))

(define (hamt-iterate-pair h pos fail-k)
  (let ([e (node-entry-at-position h pos)])
    (if e
        (cons (entry*-key e)
              (entry*-value e))
        (fail-k))))

;; "unsafe" iteration works with a record; it's unsafe only in the
;; sense that it doesn't make sure the iteration value is compatible
;; with the hash table

(define (unsafe-hamt-iterate-first h)
  (node-iterate h
                (lambda (e continue-k)
                  (make-hash-position e continue-k))
                (lambda (k) #f)))

(define (unsafe-hamt-iterate-next h pos)
  ((hash-position-continue-k pos)
   (lambda (e continue-k)
     (make-hash-position e continue-k))))

(define (unsafe-hamt-iterate-key h pos)
  (entry*-key (hash-position-entry pos)))

(define (unsafe-hamt-iterate-value h pos)
  (entry*-value (hash-position-entry pos)))

(define (unsafe-hamt-iterate-key+value h pos)
  (let ([e (hash-position-entry pos)])
    (values (entry*-key e)
            (entry*-value e))))

(define (unsafe-hamt-iterate-pair h pos)
  (let ([e (hash-position-entry pos)])
    (cons (entry*-key e)
          (entry*-value e))))

(define unsafe-immutable-hash-iterate-first unsafe-hamt-iterate-first)
(define unsafe-immutable-hash-iterate-next unsafe-hamt-iterate-next)
(define unsafe-immutable-hash-iterate-key unsafe-hamt-iterate-key)
(define unsafe-immutable-hash-iterate-value unsafe-hamt-iterate-value)
(define unsafe-immutable-hash-iterate-key+value unsafe-hamt-iterate-key+value)
(define unsafe-immutable-hash-iterate-pair unsafe-hamt-iterate-pair)

(define (node-ref node key keyhash key= shift default)
  (cond [(bnode? node) (bnode-ref node key keyhash key= shift default)]
        [(cnode? node) (cnode-ref node key keyhash key= default)]
        [else (error 'node-ref "[BUG] node-ref: unknown node type")]))

(define (node-set node key val keyhash key= key-num shift)
  (cond [(bnode? node) (bnode-set node key val keyhash key= key-num shift)]
        [(cnode? node) (cnode-set node key val keyhash key= key-num shift)]
        [else (error 'node-set "[BUG] node-set: unknown node type")]))

(define (node-remove node key keyhash key= shift)
  (cond [(bnode? node) (bnode-remove node key keyhash key= shift)]
        [(cnode? node) (cnode-remove node key keyhash key= shift)]
        [else (error 'node-remove "[BUG] node-remove: unknown node type")]))

(define (node-keys-subset? na nb key= key-num shift)
  (cond
   [(bnode? na)
    (cond
     [(bnode? nb)
      (let ()
        (define abm (bnode-bitmap na))
        (define bbm (bnode-bitmap nb))
        (and (= abm (bitwise-and abm bbm))
             (array-keys-subset? (bnode-array na) abm
                                 (bnode-array nb) bbm
                                 key= key-num shift)))]
     [(cnode? nb)
      (cond
       [(= 1 (array-length (bnode-array na)))
        (let ([e (array-ref (bnode-array na) 0)])
          (cond
           [(entry*? e)
            (not (eq? (cnode-ref nb (entry*-key e) (key-num (entry*-key e)) key= *nothing*)
                      *nothing*))]
           [else (node-keys-subset? e nb key= key-num (down shift))]))]
       [else #f])])]
   [(cnode? na)
    (cond
     [(cnode? nb)
      (and (= (cnode-hashcode na)
              (cnode-hashcode nb))
           (let ([aa (cnode-array na)]
                 [ab (cnode-array nb)])
             (and (<= (array-length aa) (array-length ab))
                  (let loop ([i (array-length aa)])
                    (cond
                     [(= i 0) #t]
                     [else
                      (let ([e (array-ref aa (sub1 i))])
                        (and (not (eq? (cnode-ref nb (entry*-key e) (key-num (entry*-key e)) key= *nothing*)
                                       *nothing*))
                             (loop (sub1 i))))])))))]
     [(bnode? nb)
      (let ([aa (cnode-array na)])
        (let loop ([i (array-length aa)])
          (cond
           [(= i 0) #t]
           [else
            (let ([e (array-ref aa (sub1 i))])
              (and (not (eq? (bnode-ref nb (entry*-key e) (key-num (entry*-key e)) key= shift *nothing*)
                             *nothing*))
                   (loop (sub1 i))))])))])]))

(define (array-keys-subset? aa abm ba bbm key= key-num shift)
  (let loop ([ai 0] [bi 0] [abm abm] [bbm bbm])
    (cond
     [(zero? abm) #t]
     [(bit-set? abm 1)
      (let ()
        (define ae (array-ref aa ai))
        (define be (array-ref ba bi))
        (and
         (cond
          [(entry*? ae)
           (cond
            [(entry*? be)
             (key= (entry*-key ae) (entry*-key be))]
            [(bnode? be)
             (not (eq? (bnode-ref be (entry*-key ae) (key-num (entry*-key ae)) key= (down shift) *nothing*)
                       *nothing*))]
            [(cnode? be)
             (not (eq? (cnode-ref be (entry*-key ae) (key-num (entry*-key ae)) key= *nothing*)
                       *nothing*))])]
          [(entry*? be) #f]
          [else
           (node-keys-subset? ae be key= key-num (down shift))])
         (loop (add1 ai) (add1 bi) (fxarithmetic-shift-right abm 1) (fxarithmetic-shift-right bbm 1))))]
     [(bit-set? bbm 1)
      (loop ai (add1 bi) (fxarithmetic-shift-right abm 1) (fxarithmetic-shift-right bbm 1))]
     [else
      (loop ai bi (fxarithmetic-shift-right abm 1) (fxarithmetic-shift-right bbm 1))])))

(define (node-fold n acc proc)
  (cond
   [(bnode? n) (array-fold (bnode-array n) acc proc)]
   [(cnode? n) (array-fold (cnode-array n) acc proc)]
   [else (error 'node-fold "[BUG] node-fold: unknown node type")]))

(define (array-fold arr acc proc)
  (define len (array-length arr))
  (let loop ([acc acc] [i 0])
    (cond
     [(= i len) acc]
     [else
      (let ([x (array-ref arr i)])
        (if (entry*? x)
            (loop (proc (entry*-key x) (entry*-value x) acc) (add1 i))
            (loop (node-fold x acc proc) (add1 i))))])))

(define (node-iterate n k done-k)
  (cond
   [(bnode? n) (array-iterate (bnode-array n) k done-k)]
   [(cnode? n) (array-iterate (cnode-array n) k done-k)]
   [else (error 'node-fold "[BUG] node-fold: unknown node type")]))

(define (array-iterate arr k done-k)
  (define len (array-length arr))
  (let loop ([i 0] [k k])
    (cond
     [(= i len) (done-k k)]
     [else
      (let ([x (array-ref arr i)])
        (if (entry*? x)
            (k x (lambda (k) (loop (add1 i) k)))
            (node-iterate x k (lambda (k) (loop (add1 i) k)))))])))

(define (bnode-ref node key keyhash key= shift default)
  (define e (bnode-array-ref node keyhash shift))
  (cond
   [(entry*? e)
    (let ()
      (define k (entry*-key e))
      (define v (entry*-value e))
      (cond [(key= key k) v]
            [else (return default)]))]
   [(not e) (return default)]
   [else (node-ref e key keyhash key= (down shift) default)]))

(define (cnode-ref node key keyhash key= default)
  (define e (cnode-array-ref node key keyhash key=))
  (cond
   [(entry*? e) (entry*-value e)]
   [else (return default)]))

(define (bnode-set node key val keyhash key= key-num shift)
  (define arr (bnode-array node))
  (define count (bnode-count node))
  (define bitmap (bnode-bitmap node))
  (define bit (bnode-bit keyhash shift))
  (define idx (bnode-idx bitmap bit))

  (cond [(bit-set? bitmap bit)
         (let ([e (array-ref arr idx)])
           (cond
            [(entry*? e)
             (let ()
               (define k (entry*-key e))
               (define v (entry*-value e))
               (cond [(key= key k)
                      (values (make-bnode* key=
                                           (array-replace arr idx (make-entry* key val))
                                           bitmap
                                           count)
                              #f)]
                     
                     [else
                      (let ([child (make-node k v key val keyhash key= key-num (down shift))])
                        (values (make-bnode* key= (array-replace arr idx child) bitmap (add1 count))
                                #t))]))]
            [else
             (let ()
               (define-values (new-child added?) (node-set e key val keyhash key= key-num (down shift)))
               (values (make-bnode* key= (array-replace arr idx new-child) bitmap (if added? (add1 count) count))
                       added?))]))]
        [else
         (values (make-bnode* key=
                              (array-insert arr idx (make-entry* key val))
                              (bitwise-ior bitmap bit)
                              (add1 count))
                 #t)]))

(define (cnode-set node key val keyhash key= key-num shift)
  (define arr (cnode-array node))
  (define hashcode (cnode-hashcode node))
  (cond [(= hashcode keyhash)
         (let ([idx (cnode-index arr key key=)])
           (cond [idx (values (make-cnode (array-replace arr idx (make-entry* key val)) hashcode)
                              #f)]
                 [else (values (make-cnode (array-insert arr (array-length arr) (make-entry* key val)) hashcode)
                               #t)]))]
        [else
         (let*-values ([(new)        (make-bnode (array node) (bnode-bit hashcode shift) (array-length arr))]
                       [(new added?) (node-set new key val keyhash key= key-num shift)])
           (values new added?))]))

(define (bnode-remove node key keyhash key= shift)
  (define arr (bnode-array node))
  (define count (bnode-count node))
  (define bitmap (bnode-bitmap node))
  (define bit (bnode-bit keyhash shift))
  (define idx (bnode-idx bitmap bit))
  
  (cond [(bit-set? bitmap bit)
         (let ([e (array-ref arr idx)])
           (cond
            [(entry*? e)
             (let ([k (entry*-key e)])
               (cond [(key= key k)
                      (let ([new-arr (array-remove arr idx)])
                        (cond
                         [(contract-node? new-arr shift)
                          (array-ref new-arr 0)]
                         [else
                          (make-bnode* key= new-arr (fxxor bitmap bit) (sub1 count))]))]
                     [else
                      node]))]
            [else
             (let ()
               (define child e)
               (define new-child (node-remove child key keyhash key= (down shift)))

               (cond [(eq? child new-child)
                      node]
                     [else
                      (let ([new-arr (array-replace arr idx new-child)])
                        (cond
                         [(contract-node? new-arr shift)
                          (array-ref new-arr 0)]
                         [else
                          (make-bnode* key= new-arr bitmap (sub1 count))]))]))]))]
        [else node]))

(define (cnode-remove node key keyhash key= shift)
  (define arr (cnode-array node))
  (define hashcode (cnode-hashcode node))
  (cond [(= hashcode keyhash)
         (let ([idx (cnode-index arr key key=)])
           (cond [idx
                  (let ([new-arr (array-remove arr idx)])
                    (cond [(contract-node? new-arr shift)
                           (array-ref new-arr 0)]
                          [else
                           (make-cnode new-arr hashcode)]))]
                 [else
                  node]))]
        [else
         node]))

(define (cnode-array-ref node key keyhash key=)
  (define arr (cnode-array node))
  (define hashcode (cnode-hashcode node))
  (and (= hashcode keyhash)
       (let ([i (cnode-index arr key key=)])
         (and i (array-ref arr i)))))

(define (cnode-index arr key key=)
  (define len (array-length arr))
  (let loop ([i 0])
    (cond
     [(= i len) #f]
     [else
      (let ([e (array-ref arr i)])
        (if (key= key (entry*-key e))
            i
            (loop (add1 i))))])))

(define (make-node k1 v1 k2 v2 k2hash key= key-num shift)
  (define k1hash (key-num k1))

  (cond [(= k1hash k2hash)
         (make-cnode (array (make-entry* k1 v1) (make-entry* k2 v2)) k1hash)]
        [else
         (let*-values ([(n _) (node-set empty-bnode k1 v1 k1hash key= key-num shift)]
                       [(n _) (node-set n k2 v2 k2hash key= key-num shift)])
           n)]))

(define (contract-node? arr shift)
  (and (= (array-length arr) 1)
       (> shift 0)
       (entry*? (array-ref arr 0))))

(define (bnode-array-ref node keyhash shift)
  (define arr (bnode-array node))
  (define bitmap (bnode-bitmap node))
  (define bit (bnode-bit keyhash shift))
  
  (cond [(bit-set? bitmap bit)
         (array-ref arr (bnode-idx bitmap bit))]
        [else
         #f]))

(define (bnode-bit keyhash shift)
  (fxarithmetic-shift-left 1
                           (fxand (fxarithmetic-shift-right keyhash shift) #x0f)))

(define (bnode-idx bitmap bit)
  (popcount (fxand bitmap (fx- bit 1))))

(define (node-entry-at-position n pos)
  (cond
   [(bnode? n) (array-entry-at-position (bnode-array n) pos)]
   [(cnode? n) (array-entry-at-position (cnode-array n) pos)]
   [else (error 'node-fold "[BUG] node-fold: unknown node type")]))

(define (array-entry-at-position arr pos)
  (define len (array-length arr))
  (let loop ([i 0] [pos pos])
    (cond
     [(= i len) #f]
     [else
      (let ([x (array-ref arr i)])
        (cond
         [(entry*? x)
          (if (zero? pos)
              x
              (loop (add1 i) (sub1 pos)))]
         [(bnode? x)
          (let ([count (bnode-count x)])
            (if (< pos count)
                (node-entry-at-position x pos)
                (loop (add1 i) (- pos count))))]
         [(cnode? x)
          (let ([count (array-length (cnode-array x))])
            (if (< pos count)
                (node-entry-at-position x pos)
                (loop (add1 i) (- pos count))))]))])))

(define (bit-set? bitmap bit)
  (not (fx= 0 (fxand bitmap bit))))

(define (down shift)
  (fx+ shift 4))

(define (return default)
  (if (procedure? default)
      (default)
      default))

(define (nothing? x) (eq? x *nothing*))

(define (popcount n)
  (bitwise-bit-count n))
