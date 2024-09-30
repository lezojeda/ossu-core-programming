# datatype bindings
```sml
datatype mytype = TwoInts of int * int
		 | Str of string
		 | Pizza
```
adds a new type `mytype` and two the constructors twoInts, Str and Pizza

a constructor is a function that makes values of the new type
## how to access them
1. check what variant it is AKA what constructor made it
2. extract the data AKA if that variant has any
## case expressions
to access one-of values created with datatype bindings

```sml
fun f (x : mytype) =
	case x of
		Pizza => 3
	    |   Str s => 8
	    |   TwoInts(i1,i2) => i1 + i2
```
`s`, `i1` and `i2` are local bindings to their branches, of course
## useful datatypes examples
```sml
datatype id = StudentNum of int
	    | Name of string
	              * (string option)
		      * string
```
the alternative, using each-of type, is bad style:
```sml
{ student_num : int,
  first	      : string,
  middle      : string option,
  last        : string }
```
## lists and options are datatypes
## polymorphic datatypes
`int list`, `string list`, etc. are **polymorphic** type constructors, besides being datatype bindings

function may and may be not polymorphic
`val sum_list : int list -> int` non-polymorphic
`val append : 'a list * 'a list -> 'a list` polymorphic
### how to define them
`datatype 'a option = NONE | SOME of 'a` this is literally how they are defined before any program is run
`datatype 'a mylist = Empty | Cons of 'a * 'a mylist`