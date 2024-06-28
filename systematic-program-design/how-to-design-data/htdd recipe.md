# how to design data recipe
## identify the [[inherent structure of the information]]
## a data definition consists of 4 or 5 elements

1. a possible structure definition (not until compound data)
2. a type comment that defines a new type name and describes how to form data of that type.
3. an interpretation that describes the correspondence between information and data.
4. one or more examples of the data.
5. a template for a 1 argument function operating on data of this type.
## example
```
; INFORMATION          DATA
; Buenos Aires         "Buenos Aires"
; Lima                 "Lima"
; Rio de Janeiro       "Rio de Janeiro"

;; CityName is String
;; interp. the name of a city
(define CN1 "Buenos Aires")
(define CN2 "Lima")
(define CN3 "Rio de Janeiro")

(define (fn-for-city-name cn)
  (... cn))

;; Template rules used;
;; - atomic non-distinct: String
```