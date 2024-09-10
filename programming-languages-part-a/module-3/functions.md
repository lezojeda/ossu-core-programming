# functions
bindings defined with the `fun` keyword
## function binding
### syntax
`fun x0 (x1 : t1, ..., xn : tn) = e`
`n` arguments `x1` to `xn` of types `t1` to `tn` with expression `e` as body
### evaluation
every function is a value
adds `x0` to environmentso later expressiones can call it
### type checking
adds binding `x0 : (t1 * ... * tn) -> t` if:
can type check body `e` to have type `t` in the static environment containing:
- "enclosing" static environment
- `x1 : t1, ..., xn : tn` (arguments with their types)
- `x0 : (t1 * ... * tn) -> t` (for recursion)

---
important to note the difference between function **binding** and function **calling**.

the evaluation of the binding is trivial while that of the calling is not.