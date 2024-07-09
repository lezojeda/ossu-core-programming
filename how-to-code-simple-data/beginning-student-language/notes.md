## evaluation
the rules that DrRacket language follows to evaluate BSL are:
### from left to right, inside to outside
1. reduce operands to values
	- For example `(+ (* 3 4) 1` it reduces `(* 3 4)` to the value of 12
2. apply primitive to the values
	- Following the previous example it now applies $+$ to 12 and 1
## constant definitions
`(define <name> <expression>)`
example: `(define WIDTH 400)`
## function definitions
```
(define (bulb c)
  (circle 40 "solid" c))
```
`c` is for "changing value", a parameter