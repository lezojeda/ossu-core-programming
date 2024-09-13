**mutation**: assign to variables or parts of tuples and lists, in other words, change the contents of a binding

it's a feature of **functional** programming in general

writing your code you can rely on no other code doing something that would make your code wrong, incomplete, or difficult to use. Having immutable data is probably the most important “non-feature” a language can have, and it is one of the main contributions of functional programming.

**it makes sharing and aliasing irrelevant**
## ML vs imperative languages
ml creates aliases all the time without thinking about it
for example `tl` is constant time, it does not copy rest of the list