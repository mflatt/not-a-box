
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

(define (symbol-interned? s) (not (gensym? s)))

(define (symbol->string s)
  (or (and (gensym? s)
           (getprop s 'racket-string))
      (chez:symbol->string s)))
      
(define (string->uninterned-symbol s)
  (let ([sym (gensym s)])
    (putprop sym 'racket-string (string->immutable-string s))
    sym))

(define (string->unreadable-symbol s)
  (let ([sym (string->symbol s)])
    (or (getprop sym 'racket-unreadable)
        (let ([u-sym (gensym s)])
          (putprop u-sym 'racket-string (string->immutable-string s))
          (putprop sym 'racket-unreadable u-sym)
          u-sym))))
