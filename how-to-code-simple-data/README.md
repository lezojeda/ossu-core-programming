## [Course](https://learning.edx.org/course/course-v1:UBCx+SPD1x+2T2015/home)
## 1a. Beginning student language
introduces the basics of Racket language, a dialect of [Lisp](https://en.wikipedia.org/wiki/Lisp_(programming_language))
## 1b. How to design functions
- a systematic step by step approach for creating functions
- [recipe](https://github.com/luz-ojeda/ossu-core-cs/blob/main/how-to-code-simple-data/how-to-design-functions/htdf%20recipe.md)
## 2. How to design data
- [recipe](https://github.com/luz-ojeda/ossu-core-cs/blob/main/how-to-code-simple-data/how-to-design-data/htdd%20recipe.md)
- the **structure of the information** in the program's domain determines the kind of data definition used which in turn determines **the structure of the templates** and helps determine the function examples (check-expects), and therefore the **structure of much of the final program design**.
## 3a. How to design worlds
- how to design interactive programs through the [big bang](https://docs.racket-lang.org/teachpack/2htdpuniverse.html#%28form._world._%28%28lib._2htdp%2Funiverse..rkt%29._big-bang%29%29) function
- made extensive use of the [template](https://github.com/luz-ojeda/ossu-core-cs/blob/main/how-to-code-simple-data/how-to-design-worlds/template%20for%20world%20program.md) in the practice problems, a template that could be used in any other programming language
- this part of the course is what made me start to realize how good it is and find the true benefits of the _systematic_ approach on designing programs
- [recipe](https://github.com/luz-ojeda/ossu-core-cs/blob/main/how-to-code-simple-data/how-to-design-worlds/htdw%20recipe.md)
## 3b. Compound data
- data definitions of two or more connected values, _similar_ to objects in JavaScript, for example through the `define-struct` primitive
## 4a. Self reference
- self refence lets us work with data of arbitrary size
- introduces a concept very similar to recursion
## 4b. Reference rule
- start to work with more than one data definition
- for example: a list of X that references X
## 5a. Naturals
- stemming from previous chapters, self-reference lets us define a `Natural` data definition for numbers between 0 and n, both inclusive
## 5b. Helpers
- when and how should I break functions into smaller ones?
- function composition
- creating "wishes" that represent functions to be defined afterwards
## 6a. Binary Search Trees
- when should binary search trees be used to represent information?
## 6b. Mutual references
- how do we work with a list of a compound data type, for example?
## Final project: space invaders
- Putting together all things learned in the course a simple [space invaders game](https://github.com/luz-ojeda/ossu-core-cs/blob/main/how-to-code-simple-data/space-invaders.rkt) was developed:

![DrRacket_MMhPotwXBa-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/84bce05c-534c-4275-b281-8b7c49c7c614)
