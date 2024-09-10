empty list: `[]`
a list of values is a value: `[v1, v2, ..., vn]`
all values of **same type**

type-checking: `t list` for any list of elements of type `t`
## accessing
`null e`: to know if it's empty AKA equal to `[]`
`hd e` returns the head, the first element
`tl e` returns a list with all the values minus the head, the tail; empty if the list has only one value