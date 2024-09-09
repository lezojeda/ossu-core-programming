# notes
## syntaxis vs semantics
**syntaxis** is *how* we write something

**semantics** is what something *means*
	- type checking, **before** program runs
	- evaluation, **as** program **runs**
## expressions
all of them have:
1. syntax
2. type-checking rules: produce a type or failsc
3. evaluation rules: produce a value

then, for each expression, we can ask:
- what is its syntax? AKA how do I write it down
- what are the type checking rules? AKA what type does it have
- what are the evaluation rules?
### example with addition
1. syntax:
	- `e1 + e2` where `e1` and `e2` are expressions themselves
	- the addition is written with two expressions and a `+` in the middle, that is the syntactic rule
2. type-checking:
	- if `e1` and `e2` have type `int` then the addition will have be `int` as well
3. evaluation:
	- if `e1` evaluates to `v1` and `e2` evaluates to `v2`, then `e1 + e2` evaluates to the sum of `v1` and `v2`
### example with less-than
1. syntax:
	- `e1 < e2` where `e1` and `e2` are expressions
	- operator `<` denotes the less than
2.type-checking:
	- `e1` and `e2` must be of type `int`
	- the type of the entire expression is `bool`
3. evaluation rules:
	- evaluate `e1` to `v1`
	- evaluate `e2` to `v2`
	- if `v1` is less than `v2` then the whole expression evaluates to `true`, otherwise to `false`