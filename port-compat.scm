
(define null '())

(define (raise-argument-error who what arg)
  (error who "bad argument: ~a: ~s" what arg))
(define (raise-arguments-error who what . more)
  (error who "bad arguments: ~a" what))
(define (raise-result-error who what arg . more)
  (error who "bad result: ~a: ~s" what arg))
(define (raise-mismatch-error who what . more)
  (error who "bad arguments: ~a" what))
(define (raise-range-error who what . more)
  (error who "bad arguments: ~a" what))

(define (read-byte in) (get-u8 in))

(define bytes bytevector)
(define bytes? bytevector?)
(define (exact-integer? n) (and (integer? n) (exact? n)))
(define (exact-nonnegative-integer? n) (and (exact-integer? n) (>= n 0)))
(define (exact-positive-integer? n) (and (exact-integer? n) (> n 0)))
(define (byte? n) (and (exact-integer? n) (>= n 0) (<= n 255)))
(define (string->immutable-string s) s)
(define (bytes->immutable-bytes s) s)
(define (procedure-arity-includes? p n) #t)

(define bytes-append
  (case-lambda 
    [(a b)
     (define alen (bytevector-length a))
     (define blen (bytevector-length b))
     (define c (make-bytevector (+ alen blen)))
     (bytevector-copy! a 0 c 0 alen)
     (bytevector-copy! b 0 c alen blen)
     c]
    [(a) a]
    [() #vu8()]
    [args
     (define size (let loop ([args args])
                    (cond
                     [(null? args) 0]
                     [else (+ (bytevector-length (car args))
                              (loop (cdr args)))])))
     (define c (make-bytevector size))
     (let loop ([args args] [pos 0])
       (cond
        [(null? args) c]
        [else
         (let ([len (bytevector-length (car args))])
           (bytes-copy! c pos (car args) 0 len)
           (loop (cdr args) (+ pos len)))]))]))

(define (subbytes bstr start end)
  (define len (- end start))
  (define c (make-bytevector len))
  (bytevector-copy! bstr 0 c 0 len)
  c)

(define string-locale-downcase string-downcase)

(define (bytes-copy! dest d-start src s-start s-end)
  (bytevector-copy! src s-start dest d-start (- s-end s-start)))

(define (bytes=? a b)
  (define alen (bytes-length a))
  (and (= alen (bytes-length b))
       (let loop ([i 0])
         (cond
          [(= i alen) #t]
          [(= (bytes-ref a i) (bytes-ref b i))
           (loop (add1 i))]
          [else #f]))))

(define (vector-copy! dest d-start src s-start s-end)
  (let loop ([i (- s-end s-start)])
    (unless (zero? i)
      (let ([i (sub1 i)])
        (vector-set! dest (+ d-start i) (vector-ref src (+ s-start i)))
        (loop i)))))

(define bytes-length bytevector-length)
(define make-bytes make-bytevector)
(define bytes-set! bytevector-u8-set!)
(define bytes->list bytevector->u8-list)
(define list->bytes u8-list->bytevector)
(define bytes-ref bytevector-u8-ref)

(define unsafe-bytes-ref bytes-ref)
(define unsafe-bytes-set! bytes-set!)

(define unsafe-string-length string-length)
(define unsafe-string-ref string-ref)
(define unsafe-string-set! string-set!)

(define read-bytes-avail!*
  (case-lambda
    [(bstr) (read-bytes-avail!* bstr (current-input-port))]
    [(bstr in) (read-bytes-avail!* bstr in 0 (bytes-length bstr))]
    [(bstr in start-pos) (read-bytes-avail!* bstr in start-pos (bytes-length bstr))]
    [(bstr in start-pos end-pos)
     (if (input-port-ready? in)
         (get-bytevector-some! in bstr start-pos (- end-pos start-pos))
         0)]))

(define (open-input-file path mode mode2)
  (open-file-input-port path))

(define peek-byte lookahead-u8)

(define eof (eof-object))

(define arithmetic-shift bitwise-arithmetic-shift)

(define (->string p)
  (if (path? p) (path->string p) p))

(define (directory-exists? p)
  (file-directory? (->string p)))

(define (resolve-path p) p)

(define parameterization-key  'parameterization-key)

(define (extend-parameterization p . args)
  (let loop ([p p] [args args])
    (cond
     [(null? args) p]
     [else (loop (hash-set p (car args) (cadr args))
                 (cddr args))])))

(define mt-hasheq (hasheq))

(define make-parameter
  (case-lambda
    [(v) (make-parameter v (lambda (x) x))]
    [(v guard)
     (define self
       (case-lambda
         [() (hash-ref
              (continuation-mark-set-first
               (current-continuation-marks)
               parameterization-key
               mt-hasheq)
              self
              v)]
         [(v2) (set! v v2)]))
     self]))             

(define current-marks (chez:make-parameter null))

(define-syntax with-continuation-mark
  (syntax-rules ()
    [(_ key val body)
     (parameterize ([current-marks (cons (cons key val)
                                         (current-marks))])
       body)]))

(define continuation-mark-set-first
  (case-lambda
    [(marks k) (continuation-mark-set-first marks k #f)]
    [(marks k none-v)
     (let loop ([marks marks])
       (cond
        [(null? marks) none-v]
        [(eq? k (caar marks)) (cdar marks)]
        [else (loop (cdr marks))]))]))

(define (current-continuation-marks)
  (current-marks))

(define (object-name n) 'unknown-name)

(define (vector->immutable-vector x) x)

(define (current-inspector) #f)
