from the package `2htdp/universe`, the big-bang is a function to create interactive programs AKA "worlds"

```racket
(big-bang {initial-world-state}
		  (on-tick {fn})
		  (to-draw {fn2}))
```

the function is important because it is used in the [[htdw recipe]]