## when to use
- small functions only used in one place
- body so easily understood that naming the function doesn't make the code easier to understand
## example
```racket
(define (only-bigger threshold lon)
    (filter (lambda (n) (> n threshold)) lon))
```