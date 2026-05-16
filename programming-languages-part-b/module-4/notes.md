## What are the key differences between ML and Racket regarding their type systems?

1. ML has a **static** type system, Racket does not. In other words ML does static checking while Racket dynamic, run-time checking.
### What is a static type system?
What is usually meant by *“static checking”* is anything done to reject a program after it (successfully) parses but **before it runs**. 
## Correctness: Soundness, Completeness, Undecidability
 A static checker is correct if it prevents what it claims to prevent. What is "correct" here? When it is sound and complete 
 
 For both, the definition is with respect to some thing X we wish to prevent. For example, X could be “a program looks up a variable that is not in the environment".
### Soundness
A type system is sound if it never accepts a program that, when run with some input, does X
### Completeness
A type system is complete if it never rejects a program that, no matter what input it is run with, will not do X.

In other words: *soundness* prevents false negatives and *completeness* prevents false positives. 

Type systems are not complete because for almost anything you might like to check statically, it is impossible to implement a static checker that given any program in your language (a) always terminates, (b) is sound, and (c) is complete. Since we have to give up one, (c) seems like the best option (programmers do not like compilers that may not terminate)

The impossibility result is exactly the idea of *undecidability* at the heart of the study of the theory of computation.
## Weak typing
>If a language has programs where a legal implementation is allowed to set the computer on fire (even though it probably would not), we call the language weakly typed.

C and C++ are examples of weakly typed languages
## Advantages and Disadvantages of Static Checking
✅ Catches bugs earlier
✅ *May* lead to faster code since it doesn't need to do type tests at run time
❌ Worse for prototyping
❌ Relatively worse for code that changes too frequently