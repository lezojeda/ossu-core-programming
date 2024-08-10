when we have a function consuming two one-of types, before designing the tests and the templates, we have to use a "cross product" table

for example with two `ListOfString`:

| v lstb / lsta >              | `empty`                            | `(cons String ListOfString)`       |
| ---------------------------- | ---------------------------------- | ---------------------------------- |
| `empty`                      | both lists are empty               | lsta is not empty<br>lstb is empty |
| `(cons String ListOfString)` | lstb is not empty<br>lsta is empty | both lists are non empty           |
|                              |                                    |                                    |
*cases of the one-of type comments go along the axes*

what the table tells us is that we need at least **four** test cases for our function
## cross product code
for the code, we need tu use `cond` with four cases, each for one of the table

| v lstb / lsta >              | `empty`                            | `(cons Number ListOfNumber)`       |
| ---------------------------- | ---------------------------------- | ---------------------------------- |
| `empty`                      | both lists are empty               | lsta is not empty<br>lstb is empty |
| `(cons Number ListOfNumber)` | lstb is not empty<br>lsta is empty | both lists are non empty           |
