(define (time->ms t)
  (+ (* 1000. (time-second t))
     (/ (time-nanosecond t) 1000000.)))

(define (time-apply f extra)
  (let ([stats (statistics)])
    (call-with-values (lambda () (apply f extra))
      (lambda args
        (let ([new-stats (statistics)])
          (values
           args
           (inexact->exact (floor (time->ms
                                   (time-difference (sstats-cpu new-stats)
                                                    (sstats-cpu stats)))))
           (inexact->exact (floor (time->ms
                                   (time-difference (sstats-real new-stats)
                                                    (sstats-real stats)))))
           (inexact->exact (floor (time->ms
                                   (time-difference (sstats-gc-cpu new-stats)
                                                    (sstats-gc-cpu stats)))))))))))

(define (current-gc-milliseconds)
  (let ([stats (statistics)])
    (sstats-gc-cpu stats)))

(define (current-milliseconds)
  (inexact->exact (floor (current-inexact-milliseconds))))

(define (current-inexact-milliseconds)
  (time->ms (current-time 'time-utc)))

(define (current-seconds)
  (let ((t (current-time 'time-utc)))
    (time-second t)))

