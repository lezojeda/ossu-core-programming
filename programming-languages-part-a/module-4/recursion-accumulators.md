>This pattern is common: The base case in the non-accumulator style becomes the initial accumulator and the base case in the accumulator style just returns the accumulator.

While most people rely on intuition for, “which calls are tail calls,” we can be more precise by defining tail position recursively and saying **a call is a tail call if it is in tail position**.

The definition for a *tail position* has one part for each kind of expression; here are several parts:
• In `fun f(x) = e`, `e` is in tail position.
• If an expression is not in tail position, then none of its subexpressions are in tail position.
• If `if e1 then e2 else e3` is in tail position, then `e2` and `e3` are in tail position (but not `e1`). (Case-expressions are similar.)
• If `let b1 ... bn in e end` is in tail position, then `e` is in tail position (but no expressions in the bindings are).
• Function-call arguments are **not** in tail position.
• ...