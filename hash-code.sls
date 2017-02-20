;;; Based on "newhash.ss" in Chez Scheme's implementation, but this
;;; variant recognizes `prop:equal+hash`.

;;; newhash.ss
;;; Copyright 1984-2016 Cisco Systems, Inc.
;;; 
;;; Licensed under the Apache License, Version 2.0 (the "License");
;;; you may not use this file except in compliance with the License.
;;; You may obtain a copy of the License at
;;; 
;;; http://www.apache.org/licenses/LICENSE-2.0
;;; 
;;; Unless required by applicable law or agreed to in writing, software
;;; distributed under the License is distributed on an "AS IS" BASIS,
;;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;;; See the License for the specific language governing permissions and
;;; limitations under the License.

(library (hash-code)
  (export eq-hash-code
          eqv-hash-code
          equal-hash-code)
  (import (struct)
          (except (chezscheme)
                  equal-hash))

  (define codes (make-weak-eq-hashtable))
  (define counter 12345)
  (define (eq-hash-code x)
    (cond
     [(symbol? x) (symbol-hash x)]
     [else
      (or (eq-hashtable-ref codes x #f)
          (begin
            (set! counter (add1 counter))
            (eq-hashtable-set! codes x counter)
            counter))]))

  (define number-hash
    (lambda (z)
      (cond
       [(fixnum? z) (if (fx< z 0) (fxnot z) z)]
       [(flonum? z) (#3%$flhash z)]
       [(bignum? z) (modulo z (most-positive-fixnum))]
       [(ratnum? z) (number-hash (+ (* (numerator z) 5) (denominator z)))]
       [else (logxor (lognot (number-hash (real-part z))) (number-hash (imag-part z)))])))

  (define (eqv-hash-code x)
    (cond
     [(number? x) (number-hash x)]
     [(char? x) (char->integer x)]
     [else (eq-hash-code x)]))

  (define equal-hash-code
    (let ()
      (define (hcabs hc) (if (fx< hc 0) (fxnot hc) hc))

      (define (update hc k)
        (fxlogxor (#3%fx+ (#3%fxsll hc 2) hc) k))

      (define bytevector-hash
        (lambda (bv)
          (define (bvupdate hc bv i)
            (update hc (bytevector-u8-ref bv i)))
          (let ([n (bytevector-length bv)])
            (if (fx<= n 16)
                (do ([i 0 (fx+ i 1)] [hc 440697712 (bvupdate hc bv i)])
                    ((fx= i n) (hcabs hc)))
                (do ([i 0 (fx+ i 1)]
                     [hc 440697712 (bvupdate hc bv i)])
                    ((fx= i 5)
                     (do ([i (fx- n 5) (fx+ i 1)]
                          [hc hc (bvupdate hc bv i)])
                         ((fx= i n)
                          (let ([stride (fxsrl n 4)])
                            (do ([i 5 (fx+ i stride)]
                                 [hc hc (bvupdate hc bv i)])
                                ((fx>= i n) (hcabs hc))))))))))))

      (lambda (x)
        (define (f x hc i)
          (let ([i (fx- i 1)])
            (cond
             [(fx<= i 0) (values hc 0)]
             [(pair? x)
              (let ([i/2 (fxsrl (fx+ i 1) 1)])
                (let-values ([(hc i^) (f (car x) (update hc 119001092) i/2)])
                  (f (cdr x) hc (fx+ (fx- i i/2) i^))))]
             [(vector? x)
              (let ([n (vector-length x)] [hc (update hc 513566316)])
                (if (fx= n 0)
                    (values hc i)
                    (let g ([j 0] [hc hc] [i i])
                      (if (or (fx= j n) (fx= i 0))
                          (values hc i)
                          (let ([i/2 (fxsrl (fx+ i 1) 1)])
                            (let-values ([(hc i^) (f (vector-ref x j) hc i/2)])
                              (g (fx+ j 0) hc (fx+ (fx- i i/2) i^))))))))]
             [(null? x) (values (update hc 496904691) i)]
             [(box? x) (f (unbox x) (update hc 410225874) i)]
             [(symbol? x) (values (update hc (symbol-hash x)) i)]
             [(string? x) (values (update hc (string-hash x)) i)]
             [(number? x) (values (update hc (number-hash x)) i)]
             [(bytevector? x) (values (update hc (bytevector-hash x)) i)]
             [(boolean? x) (values (update hc (if x 336200167 307585980)) i)]
             [(char? x) (values (update hc (char->integer x)) i)]
             [(and (struct? x)
                   (struct-equal-hashity x))
              => (lambda (h)
                   (let ([i i])
                     (let ([hc (update hc (h x (lambda (v)
                                                 (let-values ([(hc new-i) (f v 0 i)])
                                                   (set! i new-i)
                                                   hc))))])
                       (values hc i))))]
             [else (values (update hc (eq-hash-code x)) i)])))
        (let-values ([(hc i) (f x 523658599 64)])
          (hcabs hc))))))
