## 1. signature, purpose and stub
### signature
type of data it consumes and produces
`;;{type1}, {type2}...{typen} -> {type}`
### purpose
**1 line** description of what it produces in terms of what it consumes
`;; produce 2 times the given number`
### stub
scaffolding that will stay for a short period of time
produces a dummy result of correct type
`(define (double n) 0)`
## 2. define examples and tests, wrap each one in check-expect
the correct definition of the stub ensures the correct definition of the examples
```
(check-expect (double 3) 6)
(check-expect (double 2.4) 4.4)
```
## 3. template and inventory
comment out the stub
```
(define (myfunc n)
  (... n))
```
what the three dots mean is that the function will "do something" to `n`
## 4. code the function body
```
(define (double n) ;body
  (* 2 n))
```
## 5. test and debug until correct
run tests again now with code body, stub and template must be commented or deleted