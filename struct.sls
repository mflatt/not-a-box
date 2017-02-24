(library (struct)
  (export make-struct-type-property
          make-struct-type
          struct-type-install-properties!
          make-struct-field-accessor
          make-struct-field-mutator
          struct?
          struct-type?
          struct-type
          struct-type-equality
          struct-type-field-count
          unsafe-struct-ref
          unsafe-struct-set!
          struct-equal-hashity
          struct-type-transparent?
          struct-transparent-type
          prop:equal+hash
          prop:procedure
          prop:method-arity-error
          procedure-or-applicable-struct?
          apply/extract
          |#%app|
          inspector?
          inspector-superior?
          root-inspector
          new-inspector
          set-current-inspector-parameter!)
  (import (chezscheme)
          (only (chezscheme csv7)
                record-field-accessor
                record-field-mutator))

  (define-record struct-type-prop (name table guard))
  
  (define none (gensym))

  (define rtd-props (make-weak-eq-hashtable))
  (define rtd-inspectors (make-weak-eq-hashtable))
  
  (define make-struct-type-property
    (case-lambda
     [(name) (make-struct-type-property name #f '() #f)]
     [(name guard) (make-struct-type-property name guard '() #f)]
     [(name guard supers) (make-struct-type-property name guard supers #f)]
     [(name guard supers can-inpersonate?)
      (define table (make-weak-eq-hashtable))
      (values (make-struct-type-prop name table guard)
              (lambda (v) (and (record? v)
                          (not (eq? none (hashtable-ref table (record-rtd v) none)))))
              (lambda (v)
                (hashtable-ref table (record-rtd v) #f)))]))

  (define-record inspector (parent))

  (define root-inspector (make-inspector #f))

  ;; Used to create the public `make-inspector` that checks
  ;; its argument:
  (define (new-inspector parent) (make-inspector parent))
  
  (define current-inspector (lambda () root-inspector))
  (define (set-current-inspector-parameter! param)
    (set! current-inspector param))

  (define (inspector-superior? sup-insp sub-insp)
    (if (eq? sub-insp root-inspector)
        #f
        (let ([parent (inspector-parent sub-insp)])
          (or (eq? parent sup-insp)
              (inspector-superior? sup-insp parent)))))

  (define-record position-based-accessor (rtd offset field-count))
  (define-record position-based-mutator (rtd offset field-count))

  (define make-struct-type
    (case-lambda 
     [(name parent-rtd fields auto-fields auto-val)
      (make-struct-type name parent-rtd fields auto-fields auto-val '() (current-inspector) '() #f name)]
     [(name parent-rtd fields auto-fields auto-val props)
      (make-struct-type name parent-rtd fields auto-fields auto-val props (current-inspector) '() #f name)]
     [(name parent-rtd fields auto-fields auto-val props insp)
      (make-struct-type name parent-rtd fields auto-fields auto-val props insp #f name)]
     [(name parent-rtd fields auto-fields auto-val props insp proc-spec)
      (make-struct-type name parent-rtd fields auto-fields auto-val props insp proc-spec '() #f name)]
     [(name parent-rtd fields auto-fields auto-val props insp proc-spec immutables)
      (make-struct-type name parent-rtd fields auto-fields auto-val props insp proc-spec immutables #f name)]
     [(name parent-rtd fields auto-fields auto-val props insp proc-spec immutables guard)
      (make-struct-type name parent-rtd fields auto-fields auto-val props insp proc-spec immutables guard name)]
     [(name parent-rtd fields-count auto-fields auto-val props insp proc-spec immutables guard constructor-name)
      (unless (zero? auto-fields)
        (error 'make-struct-type "auto fields not supported"))
      (let* ([fields (let loop ([fields fields-count])
                       (if (zero? fields)
                           '()
                           (cons (string->symbol (format "a~a" fields))
                                 (loop (sub1 fields)))))]
             [rtd (if parent-rtd
                      (make-record-type parent-rtd (symbol->string name) fields)
                      (make-record-type (symbol->string name) fields))]
             [parent-count (if parent-rtd
                               (struct-type-field-count parent-rtd)
                               0)])
        (struct-type-install-properties! rtd name fields-count auto-fields parent-rtd
                                         props insp proc-spec immutables guard name)
        (values rtd
                (record-constructor rtd)
                (lambda (v) (record? v rtd))
                (make-position-based-accessor rtd parent-count (+ fields-count auto-fields))
                (make-position-based-mutator rtd parent-count (+ fields-count auto-fields))))]))

  (define struct-type-install-properties!
    (case-lambda
     [(rtd name fields auto-fields parent-rtd)
      (struct-type-install-properties! rtd parent-rtd '() (current-inspector) '() #f name)]
     [(rtd name fields auto-fields parent-rtd props)
      (struct-type-install-properties! rtd parent-rtd props '(current-inspector) '() #f name)]
     [(rtd name fields auto-fields parent-rtd props insp)
      (struct-type-install-properties! rtd parent-rtd props insp #f name)]
     [(rtd name fields auto-fields parent-rtd props insp proc-spec)
      (struct-type-install-properties! rtd parent-rtd props insp proc-spec '() #f name)]
     [(rtd name fields auto-fields parent-rtd props insp proc-spec immutables)
      (struct-type-install-properties! rtd parent-rtd props insp proc-spec immutables #f name)]
     [(rtd name fields auto-fields parent-rtd props insp proc-spec immutables guard)
      (struct-type-install-properties! rtd parent-rtd props insp proc-spec immutables guard name)]
     [(rtd name fields auto-fields parent-rtd props insp proc-spec immutables guard constructor-name)
      (define parent-props
        (cond
         [parent-rtd
          (let ([props (hashtable-ref rtd-props parent-rtd '())])
            (for-each (lambda (prop)
                        (define table (struct-type-prop-table prop))
                        (hashtable-set! table rtd (hashtable-ref table parent-rtd #f)))
                      props)
            props)]
         [else
          '()]))
      (hashtable-set! rtd-props rtd (let ([props (append (map car props) parent-props)])
                                      (if proc-spec
                                          (cons prop:procedure props)
                                          props)))
      (for-each (lambda (prop+val)
                  (let ([prop (car prop+val)]
                        [val (cdr prop+val)])
                    (hashtable-set! (struct-type-prop-table prop)
                                    rtd
                                    (let ([guard (struct-type-prop-guard prop)])
                                      (if guard
                                          (let ([parent-count (if parent-rtd
                                                                  (struct-type-field-count parent-rtd)
                                                                  0)])
                                            (guard val
                                                   (list name
                                                         fields
                                                         auto-fields
                                                         (make-position-based-accessor rtd parent-count (+ fields auto-fields))
                                                         (make-position-based-mutator rtd parent-count (+ fields auto-fields))
                                                         immutables
                                                         parent-rtd
                                                         #f)))
                                          val)))))
                props)
      (when proc-spec
        (hashtable-set! (struct-type-prop-table prop:procedure) rtd proc-spec))
      (hashtable-set! rtd-inspectors rtd insp)]))
  
  (define make-struct-field-accessor
    (case-lambda
     [(pba pos)
      (record-field-accessor (position-based-accessor-rtd pba)
                             (+ pos (position-based-accessor-offset pba)))]
     [(pba pos name)
      (make-struct-field-accessor pba pos)]))
  (define make-struct-field-mutator
    (case-lambda
     [(pbm pos)
      (record-field-mutator (position-based-mutator-rtd pbm)
                            (+ pos (position-based-mutator-offset pbm)))]
     [(pbm pos name)
      (make-struct-field-mutator pbm pos)]))

  (define struct? record?)
  (define struct-type? record-type-descriptor?)
  (define struct-type record-rtd)

  (define (struct-type-field-count rtd)
    (+ (let ([p-rtd (record-type-parent rtd)])
         (if p-rtd
             (struct-type-field-count p-rtd)
             0))
       (vector-length (record-type-field-names rtd))))

  (define (struct-type-parent-field-count rtd)
    (let ([p-rtd (record-type-parent rtd)])
      (if p-rtd
          (struct-type-field-count p-rtd)
          0)))

  (define (unsafe-struct-ref s i)
    (#3%vector-ref s i))
  (define (unsafe-struct-set! s i v)
    (#3%vector-set! s i v))

  (define-values (prop:equal+hash equal+hash? equal+hash-ref)
    (make-struct-type-property 'equal+hash
                               (lambda (val info)
                                 (cons (gensym) val))))

  (define (struct-type-equality rtd)
    (let ([v (hashtable-ref (struct-type-prop-table prop:equal+hash) rtd #f)])
      (if v
          (values (cadr v) (car v))
          (values #f #f))))

  (define (struct-equal-hashity r)
    (let ([v (hashtable-ref (struct-type-prop-table prop:equal+hash) (record-rtd r) #f)])
      (and v
           (caddr v))))

  (define (struct-type-transparent? rtd)
    (let ([insp (hashtable-ref rtd-inspectors rtd #f)])
      (and (or (not insp)
               (inspector-superior? (current-inspector) insp))
           (let ([p-rtd (record-type-parent rtd)])
             (or (not p-rtd)
                 (struct-type-transparent? p-rtd))))))
    
  (define (struct-transparent-type r)
    (let ([t (record-rtd r)])
      (and (struct-type-transparent? t)
           t)))

  ;; ----------------------------------------

  (define-values (prop:procedure procedure-struct? procedure-struct-ref)
    (make-struct-type-property 'procedure))

  (define (procedure-or-applicable-struct? v)
    (or (procedure? v)
        (and (record? v)
             (hashtable-ref (struct-type-prop-table prop:procedure) (record-rtd v) #f))))

  (define apply/extract
    (case-lambda
     [(proc args)
      (if (procedure? proc)
          (apply proc args)
          (apply (extract-procedure proc) args))]
     [(proc . argss)
      (if (procedure? proc)
          (apply apply proc argss)
          (apply apply (extract-procedure proc) argss))]))
  
  (define-syntax |#%app|
    (syntax-rules ()
      [(_ rator rand ...)
       ((extract-procedure rator) rand ...)]))

  (define (extract-procedure f)
    (cond
     [(procedure? f) f]
     [else (try-extract-procedure f)]))

  (define (try-extract-procedure f)
    (cond
     [(record? f)
      (let ()
        (define rtd (record-rtd f))
        (define v (hashtable-ref (struct-type-prop-table prop:procedure) rtd #f))
        (cond
         [(procedure? v) (lambda args (apply v f args))]
         [(fixnum? v) (unsafe-struct-ref f v)]
         [else (not-a-procedure f)]))]
     [else (not-a-procedure f)]))

  (define (not-a-procedure f)
    (error 'apply (format "not a procedure: ~s" f)))

  ;; ----------------------------------------

  (define-values (prop:method-arity-error method-arity-error? method-arity-error-ref)
    (make-struct-type-property 'method-arity-error))

  ;; ----------------------------------------

  (hashtable-set! (struct-type-prop-table prop:procedure)
                  (record-type-descriptor position-based-accessor)
                  (lambda (pba s p)
                    (if (and (record? s (position-based-accessor-rtd pba))
                             (< p (position-based-accessor-field-count pba)))
                        (unsafe-struct-ref s (+ p (position-based-accessor-offset pba)))
                        (error "bad access"))))

  (hashtable-set! (struct-type-prop-table prop:procedure)
                  (record-type-descriptor position-based-mutator)
                  (lambda (pbm s p v)
                    (if (and (record? s (position-based-mutator-rtd pbm))
                             (< p (position-based-mutator-field-count pbm)))
                        (unsafe-struct-set! s (+ p (position-based-mutator-offset pbm)) v)
                        (error "bad assignment")))))
