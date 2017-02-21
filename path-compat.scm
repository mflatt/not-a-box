
(define (current-inspector) #f)
(define-values (prop:custom-write custom-write? custom-write-ref)
  (make-struct-type-property 'custom-write))

(define (system-path-convention-type) 'unix)

;; ----------------------------------------

;; Probably the port and path layers are easier to combine as one...

(define (write-string s o) (display s o))

(define bytes->string/latin-1
  (case-lambda
   [(bstr) (bytes->string/latin-1 bstr #\? 0 (bytes-length bstr))]
   [(bstr err-char) (bytes->string/latin-1 bstr err-char 0 (bytes-length bstr))]
   [(bstr err-char start end)
    (define len (- end start))
    (define s (make-string len))
    (let loop ([i len])
      (unless (zero? i)
        (let ([i (sub1 i)])
          (string-set! s i (integer->char (bytevector-u8-ref bstr (+ i start))))
          (loop i))))
    s]))

(define bytes->string/utf-8 bytes->string/latin-1)
(define bytes->string/locale bytes->string/latin-1)

(define string->bytes/utf-8
  (case-lambda
   [(s) (string->bytes/utf-8 s 0 0 (string-length s))]
   [(s err-byte) (string->bytes/utf-8 s err-byte 0 (string-length s))]
   [(s err-byte start end)
    (define len (- end start))
    (define bstr (make-bytevector len))
    (let loop ([i len])
      (unless (zero? i)
        (let ([i (sub1 i)])
          (bytevector-u8-set! bstr i (char->integer (string-ref s (+ i start))))
          (loop i))))
    bstr]))

(define string->bytes/locale string->bytes/utf-8)
