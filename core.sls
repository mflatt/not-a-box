(library (core)
  (export with-continuation-mark
          continuation-mark-set-first
          current-continuation-marks

          parameterization-key
          make-parameter
          extend-parameterization
          parameterization?

          error-print-width
          error-value->string-handler

          current-inspector
          make-inspector

          struct:exn exn exn? exn-message exn-continuation-marks
          struct:exn:break exn:break exn:break? exn:break-continuation
          struct:exn:fail exn:fail exn:fail?
          struct:exn:fail:contract exn:fail:contract exn:fail:contract?
          struct:exn:fail:contract:variable exn:fail:contract:variable exn:fail:contract:variable?
          struct:exn:fail:filesystem exn:fail:filesystem exn:fail:filesystem?
          struct:exn:fail:read exn:fail:read exn:fail:read? exn:fail:read-srclocs
          struct:exn:fail:read:eof exn:fail:read:eof exn:fail:read:eof?
          struct:exn:fail:read:non-char exn:fail:read:non-char exn:fail:read:non-char?

          struct:srcloc srcloc srcloc?
          srcloc-source srcloc-line srcloc-column srcloc-position srcloc-span

          raise-argument-error
          raise-arguments-error
          raise-result-error
          raise-mismatch-error
          raise-range-error
          raise-result-arity-error

          make-struct-type-property
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
          struct->vector
          struct-equal-hashity
          struct-type-transparent?
          struct-transparent-type
          prefab-key?
          prefab-struct-key
          prefab-key->struct-type
          make-prefab-struct
          prop:equal+hash
          prop:procedure
          prop:method-arity-error
          procedure-or-applicable-struct?
          apply/extract
          |#%app|
          procedure-extract-target
          inspector?
          inspector-superior?

          equal?
          eq-hash-code
          eqv-hash-code
          equal-hash-code

          hash hasheqv hasheq
          make-hash make-hasheqv make-hasheq
          make-immutable-hash make-immutable-hasheqv make-immutable-hasheq
          make-weak-hash make-weak-hasheq make-weak-hasheqv
          hash-ref hash-set hash-set! hash-remove hash-remove!
          hash-for-each hash-map hash-copy hash-clear!
          hash-iterate-first hash-iterate-next
          hash-iterate-key hash-iterate-value hash-iterate-key+value
          unsafe-immutable-hash-iterate-first unsafe-immutable-hash-iterate-next
          unsafe-immutable-hash-iterate-key unsafe-immutable-hash-iterate-value unsafe-immutable-hash-iterate-key+value
          hash? hash-eq? hash-equal? hash-eqv? immutable-hash?
          hash-count
          hash-keys-subset?
          ;; For intern tables:
          weak-hash-ref-key

          bytes bytes?
          bytes-length
          make-bytes
          bytes-ref bytes-set!
          bytes->list list->bytes
          bytes->immutable-bytes
          bytes-copy! bytes-copy
          bytes=? bytes<? bytes>? bytes<=? bytes>=?
          bytes-append
          subbytes

          keyword?
          keyword->string
          string->keyword
          keyword<?

          symbol<?)
  (import (rename (except (chezscheme)
                          equal?)
                  [make-parameter chez:make-parameter])
          (only (chezscheme csv7)
                record-field-accessor
                record-field-mutator))

  (define none (gensym "none"))

  (include "core-equal.ss")
  (include "core-hash-code.ss")
  (include "core-struct.ss")
  (include "core-hamt.ss")
  (include "core-hash.ss")
  (include "core-error.ss")
  (include "core-bytes.ss")
  (include "core-keyword.ss")
  
  (set-base-exception-handler!)
  (set-primitive-applicables!))
