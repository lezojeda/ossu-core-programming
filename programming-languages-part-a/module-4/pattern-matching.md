The evaluation of a `case` expression.

It is similar to [destructuring](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)
## pattern matching for "one of"
We can summarize what we know about datatypes and pattern matching so far as follows: 

The binding

`datatype t = C1 of t1 | C2 of t2 | ... | Cn of tn`

introduces a new type t and each constructor Ci is a function of type ti->t. One omits the “of ti” for a variant that “carries nothing” and such a constructor just has type t. To “get at the pieces” of a t we use a case expression:

`case e of p1 => e1 | p2 => e2 | ... | pn => en`

A case expression evaluates e to a value v, finds the first pattern pi that matches v, and evaluates ei to produce the result for the whole case expression. So far, patterns have looked like Ci(x1,...,xn) where Ciis a constructor of type t1 * ... * tn -> t (or just Ci if Ci carries nothing). Such a pattern matches a value of the form Ci(v1,...,vn) and binds each xi to vi for evaluating the corresponding ei.
## val binding patterns
`val p = e`, variables as seen in the very first part of the course are just one kind of *pattern* (denoted by `p`)
## the truth about functions
all functions take only *one* argument, a tuple

SML makes pattern matching on the tuple passed, three arguments are instead one single tuple with 3 values