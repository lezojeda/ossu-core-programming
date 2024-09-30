with the keyword `type`, different from [[datatype-bindings|datatype bindings]]

useful for things like this:
```sml
datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen ...

type card = suit * rank
```

so if we want to write a function that accepts `card -> bool` we can instead of doing `suit * rank -> bool`, convenience, increases modularity
