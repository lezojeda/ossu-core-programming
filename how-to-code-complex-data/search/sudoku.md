**key for the solution:** generate an arbitrary-arity tree and do backtracking search over it

AKA generative recursion

>[!arbitrary-arity???]
each board has 0 to 9 valid next boards

along each branch we either:
- come to a board with no valid next baords -> produce `false`, the "backtracking" part of the backtracking search
- come to a full (and valid) board - the solution ✨