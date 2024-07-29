![[BST example.png]]
The following data definition is for this image.

A compound data with 4 values: key, value, the left BST and the right BST. Has a double self-reference from each binary search tree (`fn-for-bst` appears twice in the template).

```racket
(define-struct node (key val l r))

;; BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST) two self-references
;; interp. false means no BST, or empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; INVARIANT: for a given node:
;;     key is > all keys in its l(eft) child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree


;; Examples:
(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 (make-node 42 "ily"
                         (make-node 27 "wit"
                                    (make-node 14 "olp" false false)
                                    false)
                         (make-node 50 "dug" false false)))
(define BST10
  (make-node 10 "why" BST3 BST42))


;; Template:
#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)                 ;Integer
              (node-val t)                 ;String
              (fn-for-bst (node-l t))      ;BST
              (fn-for-bst (node-r t)))]))  ;BST


;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: false
;;  - compound: (make-node Integer String BST BST)
;;  - self reference (node-l t) has type BST
;;  - self reference (node-r t) has type BST
```

