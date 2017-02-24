;;; Based on "5_1.ss" in Chez Scheme's implementation, but this
;;; variant recognizes `prop:equal+hash`.

;;; 5_1.ss
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

(define (equal? x y)
  (define k0 200)
  (define kb -20)

  (define (union-find ht x y) ; htcell version
    (define (find p n) ; splitting
      (if (pair? n)
          (let loop ([p p] [n n])
            (let ([nn (cdr n)])
              (if (pair? nn)
                  (begin (set-cdr! p nn) (loop n nn))
                  n)))
          p))
    (let ([ax (eq-hashtable-cell ht x 0)]
          [ay (eq-hashtable-cell ht y 0)])
      (let ([nx (cdr ax)] [ny (cdr ay)])
        (if (eq? nx 0)
            (if (eq? ny 0)
                (begin
                  (set-cdr! ax ay)
                  (set-cdr! ay 1)
                  #f)
                (begin
                  (set-cdr! ax (find ay ny))
                  #f))
            (if (eq? ny 0)
                (begin
                  (set-cdr! ay (find ax nx))
                  #f)
                (let ([rx (find ax nx)] [ry (find ay ny)])
                  (or (eq? rx ry)
                      (let ([nx (cdr rx)] [ny (cdr ry)])
                        (if (fx> nx ny)
                            (begin
                              (set-cdr! ry rx)
                              (set-cdr! rx (fx+ nx ny))
                              #f)
                            (begin
                              (set-cdr! rx ry)
                              (set-cdr! ry (fx+ ny nx))
                              #f))))))))))

  (define (interleave? x y k)
    (let ([ht (make-eq-hashtable)])
      (define (e? x y k)
        (if (fx<= k 0)
            (if (fx= k kb)
                (fast? x y (random (* 2 k0)))
                (slow? x y k))
            (fast? x y k)))
      (define (slow? x y k)
        (cond
         [(eq? x y) k]
         [(pair? x)
          (and (pair? y)
               (if (union-find ht x y)
                   0
                   (let ([k (e? (car x) (car y) (fx- k 1))])
                     (and k (e? (cdr x) (cdr y) k)))))]
         [(vector? x)
          (and (vector? y)
               (let ([n (vector-length x)])
                 (and (fx= (vector-length y) n)
                      (if (union-find ht x y)
                          0
                          (let f ([i 0] [k (fx- k 1)])
                            (if (fx= i n)
                                k
                                (let ([k (e? (vector-ref x i) (vector-ref y i) k)])
                                  (and k (f (fx+ i 1) k)))))))))]
         [(string? x) (and (string? y) (string=? x y) k)]
         [(number? x) (eqv? x y)]
         [(bytevector? x) (and (bytevector? y) (bytevector=? x y) k)]
         [(fxvector? x)
          (and (fxvector? y)
               (fx= (fxvector-length x) (fxvector-length y))
               (let f ([i (fx- (fxvector-length x) 1)])
                 (if (fx< i 0)
                     k
                     (and (fx= (fxvector-ref x i) (fxvector-ref y i))
                          (f (fx1- i))))))]
         [(box? x)
          (and (box? y)
               (if (union-find ht x y)
                   0
                   (e? (unbox x) (unbox y) (fx- k 1))))]
         [(struct? x)
          (and (struct? y)
               (if (union-find ht x y)
                   0
                   (let ([x-type (struct-type x)]
                         [y-type (struct-type y)])
                     (let-values ([(x-equal x-equal-from) (struct-type-equality x-type)])
                       (cond
                        [x-equal
                         (let-values ([(y-equal y-equal-from) (struct-type-equality y-type)])
                           (and (eq? x-equal-from y-equal-from)
                                (let ([next-k k])
                                  (and (x-equal x y (lambda (x1 y1)
                                                      (let ([k (e? x1 y1 next-k)])
                                                        (and k
                                                             (begin
                                                               (set! next-k k)
                                                               #t)))))
                                       next-k))))]
                        [else
                         (cond
                          [(and (eq? x-type y-type)
                                (struct-type-transparent? x-type))
                           (let loop ([i (fx- (struct-type-field-count x-type) 1)] [k k])
                             (if (fx< i 0)
                                 k
                                 (let ([k (e? (unsafe-struct-ref x i) (unsafe-struct-ref y i) k)])
                                   (and k (loop (fx- i 1) k)))))]
                          [else #f])])))))]
         [else (and (eqv? x y) k)]))
      (define (fast? x y k)
        (let ([k (fx- k 1)])
          (cond
           [(eq? x y) k]
           [(pair? x)
            (and (pair? y)
                 (let ([k (e? (car x) (car y) k)])
                   (and k (e? (cdr x) (cdr y) k))))]
           [(vector? x)
            (and (vector? y)
                 (let ([n (vector-length x)])
                   (and (fx= (vector-length y) n)
                        (let f ([i 0] [k k])
                          (if (fx= i n)
                              k
                              (let ([k (e? (vector-ref x i) (vector-ref y i) k)])
                                (and k (f (fx+ i 1) k))))))))]
           [(string? x) (and (string? y) (string=? x y) k)]
           [(number? x) (eqv? x y)]
           [(bytevector? x) (and (bytevector? y) (bytevector=? x y) k)]
           [(fxvector? x)
            (and (fxvector? y)
                 (fx= (fxvector-length x) (fxvector-length y))
                 (let f ([i (fx- (fxvector-length x) 1)])
                   (if (fx< i 0)
                       k
                       (and (fx= (fxvector-ref x i) (fxvector-ref y i))
                            (f (fx1- i))))))]
           [(box? x) (and (box? y) (e? (unbox x) (unbox y) k))]
           [(struct? x)
            (and (struct? y)
                 (let ([x-type (struct-type x)]
                       [y-type (struct-type y)])
                   (let-values ([(x-equal x-equal-from) (struct-type-equality x-type)])
                     (cond
                      [x-equal
                       (let-values ([(y-equal y-equal-from) (struct-type-equality y-type)])
                         (and (eq? x-equal-from y-equal-from)
                              (let ([next-k k])
                                (and (x-equal x y (lambda (x1 y1)
                                                    (let ([k (e? x1 y1 next-k)])
                                                      (and k
                                                           (begin
                                                             (set! next-k k)
                                                             #t)))))
                                     next-k))))]
                      [else
                       (cond
                        [(and (eq? x-type y-type)
                              (struct-type-transparent? x-type))
                         (let loop ([i (fx- (struct-type-field-count x-type) 1)] [k k])
                           (if (fx< i 0)
                               k
                               (let ([k (e? (unsafe-struct-ref x i) (unsafe-struct-ref y i) k)])
                                 (and k (loop (fx- i 1) k)))))]
                        [else #f])]))))]
           [else (and (eqv? x y) k)])))
      (and (e? x y k) #t)))

  (define (precheck? x y k)
    (cond
     [(eq? x y) k]
     [(pair? x)
      (and (pair? y)
           (if (fx<= k 0)
               k
               (let ([k (precheck? (car x) (car y) (fx- k 1))])
                 (and k (precheck? (cdr x) (cdr y) k)))))]
     [(vector? x)
      (and (vector? y)
           (let ([n (vector-length x)])
             (and (fx= (vector-length y) n)
                  (let f ([i 0] [k k])
                    (if (or (fx= i n) (fx<= k 0))
                        k
                        (let ([k (precheck?
                                  (vector-ref x i)
                                  (vector-ref y i)
                                  (fx- k 1))])
                          (and k (f (fx+ i 1) k))))))))]
     [(string? x) (and (string? y) (string=? x y) k)]
     [(number? x) (and (eqv? x y) k)]
     [(bytevector? x) (and (bytevector? y) (bytevector=? x y) k)]
     [(fxvector? x)
      (and (fxvector? y)
           (fx= (fxvector-length x) (fxvector-length y))
           (let f ([i (fx- (fxvector-length x) 1)])
             (if (fx< i 0)
                 k
                 (and (fx= (fxvector-ref x i) (fxvector-ref y i))
                      (f (fx1- i))))))]
     [(box? x)
      (and (box? y)
           (if (fx<= k 0)
               k
               (precheck? (unbox x) (unbox y) (fx- k 1))))]
     [(struct? x)
      (and (struct? y)
           (let ([x-type (struct-type x)]
                 [y-type (struct-type y)])
             (let-values ([(x-equal x-equal-from) (struct-type-equality x-type)])
               (cond
                [x-equal
                 (let-values ([(y-equal y-equal-from) (struct-type-equality y-type)])
                   (and (eq? x-equal-from y-equal-from)
                        (let ([next-k k])
                          (and (x-equal x y (lambda (x1 y1)
                                              (let ([k (precheck? x1 y1 next-k)])
                                                (and k
                                                     (begin
                                                       (set! next-k k)
                                                       #t)))))
                               next-k))))]
                [else
                 (cond
                  [(and (eq? x-type y-type)
                        (struct-type-transparent? x-type))
                   (let loop ([i (fx- (struct-type-field-count x-type) 1)] [k k])
                     (if (fx< i 0)
                         k
                         (let ([k (precheck? (unsafe-struct-ref x i) (unsafe-struct-ref y i) k)])
                           (and k (loop (fx- i 1) k)))))]
                  [else #f])]))))]
     [else (and (eqv? x y) k)]))

  (let ([k (precheck? x y k0)])
    (and k (or (fx> k 0) (interleave? x y 0)))))
