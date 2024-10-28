parenthesizing everything in lambda has the advantage that representing the program as a tree is trivial and unambiguous
- atoms are leaves
- sequences are nodes with elements as children

```racket
(define cube
	(lambda (x)
		(* x x x)))
```

`define` has two branches to `cube` and `lambda`, `lambda` two in turn to x and \*, and * to x x x

**it's the same approach used in HTML**