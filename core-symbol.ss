
(define gensym
  (case-lambda
   [() (chez:gensym)]
   [(s) (cond
         [(string? s) (chez:gensym s)]
         [(symbol? s) (chez:gensym (symbol->string s))]
         [else (raise-argument-error
                'gensym
                "(or/c symbol? string?)"
                s)])]))

(define (symbol-interned? s)
  (unless (symbol? s)
    (raise-argument-error 'symbol-interned? "symbol?" s))
  (not (gensym? s)))

(define (symbol->string s)
  (unless (symbol? s)
    (raise-argument-error 'symbol->string "symbol?" s))
  (or (and (gensym? s)
           (getprop s 'racket-string))
      (let ([str (chez:symbol->string s)])
        (unless (zero? (string-length str))
          (string-set-immutable! str))
        str)))
      
(define (string->uninterned-symbol str)
  (unless (string? str)
    (raise-argument-error 'string->uninterned-symbol "string?" str))
  (let* ([str (string->immutable-string str)]
         [sym (gensym str)])
    (putprop sym 'racket-string str)
    sym))

(define (string->unreadable-symbol str)
  (unless (string? str)
    (raise-argument-error 'string->unreadable-symbol "string?" str))
  (let ([str (string->immutable-string str)]
        [sym (string->symbol str)])
    (or (getprop sym 'racket-unreadable)
        (let ([u-sym (gensym str)])
          (putprop u-sym 'racket-string str)
          (putprop sym 'racket-unreadable u-sym)
          u-sym))))
