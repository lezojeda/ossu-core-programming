## type checking
*statically* typed languages reject programs if type checking fails **before** they run

*dynamically* typed languages do not, they might try to treat a number as a function at run time
## steps SML takes for type inference
1. determine types of bindings in order
2. for each `val` or `fun` binding it analyzes the definition for all necessary facts such as `x > 0` then `x` must be int
3. use type variables for any unconstrained types, `'a` for example