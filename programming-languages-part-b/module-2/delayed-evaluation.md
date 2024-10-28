`(define b (lambda () (+ 3 2)))`

Wrapping the expression in a `lambda` function delays evaluation, which is what it means to *thunk* an expression.