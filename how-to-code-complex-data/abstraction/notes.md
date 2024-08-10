## how to
1. Identify highly repetitive expressions and the point of variance, for example here the point of variance is the argument passed to `sqr`
```racket
(* pi (sqr 4)) ;area of circle radius 4
(* pi (sqr 6)) ;area of circle radius 6
```

2. Introduce a new function around one copy of the repetitive code using a more general name for it with a parameter for the varying position.
```racket
(define (area r)
  (* pi (sqr 4)))
```

3. Replace specific expressions in the point of variance with the parameter (`r` in this case)
```racket
(define (area r)
  (* pi (sqr r)))
```
## using built-in functions
a list of them can be found in the coursepage *Language* section towards the end

necessary to template and create abstract functions that consume (listof X)
## closures
built-in functions appear frequently in *closures*

a type of function that accesses variables in the lexical scope of another function so it depends on it