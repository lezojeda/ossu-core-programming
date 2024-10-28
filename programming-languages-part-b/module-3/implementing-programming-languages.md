## typical workflow
concrete syntax which leads to possible errors/warnings and is parsed

then if syntax valid it would proceed to type checking which may lead to possible errors/warnings as well
## interpreter or compiler
1. write an interpreter in another language A
- better names: evaluator or executor
- take a program in B and produce an answer (in B)

or

2. write a compiler in another language A to a third language C
- better name: translator
- translation must preserve meaning (equivalence)

we call A the **metalanguage**

evaluation (interpreter) and translation (compiler) are the options
## examples
- java compiler to **bytecode intermediate language**
- have an interpreter for bytecode (in binary), but compile frequent functions to binary at run-time
- the chip itself an interpreter for **binary**
an important thing is that languages are not interpreted or compiled by themselves, the **implementations** of the programs are either interpreted or compiled