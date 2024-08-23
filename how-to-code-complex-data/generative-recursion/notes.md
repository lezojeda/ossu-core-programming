## recipe
The template for generative recursion is:
```racket
(define (genrec-fn d)
  (cond [(trivial? d) (trivial-answer d)]
        [else
         (... d 
              (genrec-fn (next-problem d)))]))
```
## termination arguments
they are 3 parts and let as be sure that calls to generative recursive functions will end.
Using the `hailstones` in `termination-starter` and sierpinski fractals files as examples we can see the three parts:
### Base case
hailstones:
`(= n 1)`

sierpinski:
`(<= s CUTOFF)`
### Reduction step
hailstones:
`(/ n 2)`
`(+ 1 (* n 3))`

sierpinski:
`(/ s 3)`
### Argument that repeated application of reduction step will eventually reach the base case:
hailstones: there is **none**, mathematicians have not found it

spiernski: as long as CUTOFF is > 0 and s starts >= 0, repeated division by 3 will eventually reach base case
### The full examples
see parts marked with ###

hailstones:
```
(define (hailstones n)
  (if (= n 1) ###
      (list 1)
      (cons n 
            (if (even? n)
                (hailstones (/ n 2)) ###
                (hailstones (add1 (* n 3))))))) ###

```