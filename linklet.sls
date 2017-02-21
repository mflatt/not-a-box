(library (linklet)
  (export primitive-table
          linklet?
          compile-linklet
          recompile-linklet
          eval-linklet
          read-compiled-linklet
          instantiate-linklet
              
          linklet-import-variables
          linklet-export-variables
          
          instance?
          make-instance
          instance-name
          instance-data
          instance-variable-names
          instance-variable-value
          instance-set-variable-value!
          instance-unset-variable!

          linklet-directory?
          hash->linklet-directory
          linklet-directory->hash

          linklet-bundle?
          hash->linklet-bundle
          linklet-bundle->hash
          
          variable-reference?
          variable-reference->instance
          variable-reference-constant?)
  (import (except (chezscheme)
                  error)
          (hash)
          (error)
          (struct)
          (regexp)
          (bytes)
          (schemify))

  (define (primitive-table key)
    (case key
      [(|#%linklet|) '|not-yet-the-#%linklet-table|]
      [else #f]))

  (define (primitive->compiled-position prim) #f)
  (define (compiled-position->primitive pos) #f)

  (define-record-type linklet (fields code name importss exports))
              
  (define compile-linklet
    (case-lambda
     [(c) (compile-linklet c #f #f (lambda (key) (values #f #f)))]
     [(c name) (compile-linklet c name #f (lambda (key) (values #f #f)))]
     [(c name import-keys) (compile-linklet c name import-keys (lambda (key) (values #f #f)))]
     [(c name import-keys get-import)
      (schemify-linklet c primitive-procs)]))
  
  (define (recompile-linklet . args)
    (error 'recompile-linklet "no"))
  
  (define (eval-linklet linklet)
    linklet)

  (define (read-compiled-linklet in)
    (read in))

  (define instantiate-linklet
    (case-lambda
     [(linklet import-instances)
      (instantiate-linklet linklet import-instances #f #f)]
     [(linklet import-instances target-instance)
      (instantiate-linklet linklet import-instances #f)]
     [(linklet import-instances target-instance use-prompt?)
      (cond
       [target-instance
        (apply (linklet-code linklet) target-instance import-instances)]
       [else
        (let ([i (make-instance (linklet-name linklet))])
          (apply (linklet-code linklet) i import-instances)
          i)])]))
              
  (define (linklet-import-variables linklet)
    (linklet-importss linklet))

  (define (linklet-export-variables linklet)
    (linklet-exports linklet))

  (define-record-type (instance new-instance instance?)
    (fields name data hash))

  (define make-instance
    (case-lambda
     [(name) (make-instance name #f)]
     [(name data . content)
      (let ([ht (make-hasheq)])
        (let loop ([content content])
          (cond
           [(null? content) (void)]
           [(null? (cdr content))
            (raise-arguments-error 'make-instance "odd number of arguments")]
           [else
            (hash-set! ht (car content) (cdar content))
            (loop (cdr content))]))
        (new-instance name data ht))]))

  (define (instance-variable-names i)
    (hash-map (instance-hash i) (lambda (k v) k)))

  (define instance-variable-value
    (case-lambda
     [(i sym fail-k)
      (hash-ref (instance-hash i) sym fail-k)]
     [(i sym)
      (instance-variable-value i sym (lambda () (error "instance variable not found:" sym)))]))
  
  (define (instance-set-variable-value! i k v)
    (hash-set! (instance-hash i) k v))

  (define (instance-unset-variable! i k)
    (hash-remove! (instance-hash i) k))

  (define-record-type linklet-directory (fields hash))

  (define (hash->linklet-directory ht)
    (make-linklet-directory ht))
  
  (define (linklet-directory->hash ld)
    (linklet-directory-hash ld))

  (define-record-type linklet-bundle (fields hash))

  (define (hash->linklet-bundle ht)
    (make-linklet-bundle ht))

  (define (linklet-bundle->hash b)
    (linklet-bundle-hash b))

  (define-record variable-reference (var constant? instance-link))
              
  (define (variable-reference->instance vr)
    (car (variable-reference-instance-link vr))))
