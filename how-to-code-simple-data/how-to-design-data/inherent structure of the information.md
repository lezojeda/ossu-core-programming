**information**: real context
**data**: the information in our program context

- the **structure of the information** in the program's domain determines the kind of data definition used,
- which in turn determines **the structure of the templates** and helps determine the function examples (check-expects),
- and therefore the **structure of much of the final program design**.
![[structure flow.png]]
in other words: *the structure of information flows through*
## information <-> data definition correspondence

| information form                                                                | use a data definition of the kind        | example      |
| ------------------------------------------------------------------------------- | ---------------------------------------- | ------------ |
| atomic                                                                          | Simple Atomic Data                       | cities       |
| numbers within a certain range                                                  | Interval                                 | temperatures |
| consists of a fixed number of distinct items                                    | Enumeration                              | days         |
| comprised of 2 or more subclasses, at least one of which is not a distinct item | Itemization                              |              |
| consists of 2 or more items that naturally belon toether                        | Compound data                            |              |
| naturally composed of different parts                                           | References to other defined type         |              |
| of arbitrary (unknown) size                                                     | self-referential or mutually referential |              |
## htdf recipe orthogonality
the [[htdd recipe]] is mostly orthogonal AKA independent to the **form of data**