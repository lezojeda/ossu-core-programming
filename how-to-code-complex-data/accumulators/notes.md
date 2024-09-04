three types of accumulators:
- [[#context preserving]]
- [[#tail recursion||results so far]]
- [[worklist]]
## context preserving
to preserve the position of the current element being checked in a list, for example

the `i` while looping in a for loop in javascript

another example with a function that skips every other element of a list, in Racket. notice the `(add1 acc)` calls
```racket
(define (skip1 lox0)
  ;; acc: Natural; 1-based position of (first lox) in lox0
  ;; (skip1 (list "a" "b" "c") 1)
  ;; (skip1 (list     "b" "c") 2)
  ;; (skip1 (list         "c") 3)
  (local [(define (skip1 lox acc)
            (cond [(empty? lox) empty]
                  [else
                   (if (odd? acc)
                       (cons (first lox)
                             (skip1 (rest lox)
                                   (add1 acc)))
                       (skip1 (rest lox)
                              (add1 acc)))]))]
    (skip1 lox0 1)))
```
## tail recursion
the tail position is the **final** result of a recursive call

example:
```racket
(define (sum lon0)
  ;; acc: Number; the sum of the elements seen so far
  ;; (sum (list 2 4 5))
  ;; (sum (list 2 4 5) 0)
  ;; (sum (list   4 5) 2)
  ;; (sum (list     5) 6)
  ;; (sum (list      ) 11)
  (local [(define (sum lon acc)
            (cond [(empty? lon) acc]
                  [else
                   (sum (rest lon)
                        (+ acc (first lon)))]))]
    (sum lon0 0)))
```
