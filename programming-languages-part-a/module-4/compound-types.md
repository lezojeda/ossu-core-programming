# compound types
- *base* types: `int`, `bool`, `unit` and `char`
- *compound* types: tuples, lists, options
every programming language has 3 most imporant type building blocks:
1. **Each of**: a `t` value contains values of each of `t1`, `t2`, ..., `tn`
   - tuples
2. **One of**: a `t` value contains values of one of `t1`, `t2`, ..., `tn`
   - options
   - see [[datatype-bindings]]
3. **Self reference**: a `t` value can refer to other `t` vavlues
   - lists
## records
there is no need to declare their type first
`val x = { foo=3, bar=false }`
access with `#`, similar to tuples
`#foo x`
`val it = 3 : int`

use records instead of tuples when it is better to access by name instead of by position
### tuples are syntactic sugar
`- val pair = {2=5, 1=6};`
results in:
`val pair = (6,5) : int * int`
tuples are just another way of writing records, REPL tries to always use tuples if possible (whenever there is a record with field names 1, 2, ..., n)
### syntactic sugar
- simplify *understanding* the language
- simplify *implementing* the language
both lead to fewer semantics to worry about even thought we have the syntactic convenience of tuples