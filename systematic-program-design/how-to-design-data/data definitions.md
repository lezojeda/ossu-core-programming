## problem domain
- represents the specific area or subject matter the software intends to address.
- the information of the problem domain is represented by data in the program
- for example: a red light might be a 0 in the program

- **data definitions** tell us how we represent the information as data
- for example:
```racket
;; Data definitions:

;; TLColor is one of:
;;  - 0
;;  - 1
;;  - 2
;; interp. 0 means red, 1 yellow, 2 green               
#;
(define (fn-for-tlcolor c)
  (cond [(= c 0) (...)]
        [(= c 1) (...)]
        [(= c 2) (...)]))
```