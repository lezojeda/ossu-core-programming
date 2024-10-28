
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below
(define ones (lambda () (cons 1 ones)))
(define (sequence low high stride)
  (if (> low high)
      empty
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
  (cond [(< n 0)
         (error "list-nth-mod: negative number")]
        [(empty? xs) (error "list-nth-mod: empty list")]
        [else (list-ref xs (modulo n (length xs)))]))

;; stream example
(define (odd-numbers-from n)
  (if (= (modulo n 2) 0)
      (error "n must be an odd number")
      (lambda () (cons n (odd-numbers-from (+ n 2))))))

(define (stream-for-n-steps s n)
  (if (= n 0)
      empty
      (let ([pr (s)])
        (cons (car pr) (stream-for-n-steps (cdr pr) (- n 1))))))

(define funny-number-stream
  (let ([make-funny (lambda (n) (if (= (modulo n 5) 0)
                                    (* -1 n)
                                    n))]) 
    (letrec ([f (lambda (x)
                  (cons (make-funny x)
                        (lambda () (f (+ x 1)))))])
      (lambda () (f 1)))))

(define dan-then-dog
  (letrec ([f (lambda (s)
                (cons s
                      (lambda () (f (if (string=? s "dan.jpg") "dog.jpg" "dan.jpg")))))])
    (lambda () (f "dan.jpg"))))

(define (stream-add-zero s)
  (letrec ([f (lambda () 
                (let ([pr (s)])
                  (cons (cons 0 (car pr))
                        (lambda () (stream-add-zero (cdr pr))))))])
    f))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons (cons (list-nth-mod xs n)
                            (list-nth-mod ys n))
                      (lambda () (f (+ n 1)))))])
    (lambda () (f 0))))

(define (vector-assoc v vec)
  (let loop ([i 0])
    (cond
      [(>= i (vector-length vec)) #f]
      [(and (pair? (vector-ref vec i))
            (equal? v (car (vector-ref vec i))))
       (vector-ref vec i)]
      [else (loop (+ i 1))])))

(define (cached-assoc xs n)
  (letrec([memo (make-vector n)]
          [slot 0]
          [f (lambda (xs v) v
               ;check if v exists in memo
               (let [lookup (vector-assoc v memo)]
                 (if (equal? lookup #f)
                     ;call assoc with xs and v, store the value in memo, increase slot by 1
                     ;returns the corresponding value if it does
                     lookup
               )])
    f))













