# how to design data recipe
## identify the [[inherent structure of the information]]
## a data definition consists of 4 or 5 elements
1. a possible structure definition if compound data
2. a type comment that defines a new type name and describes how to form data of that type.
3. an interpretation that describes the correspondence between information and data.
4. one or more examples of the data.
5. a template for a 1 argument function operating on data of this type.
## example
```
; INFORMATION          DATA
; Buenos Aires         "Buenos Aires"
; Lima                 "Lima"
; Rio de Janeiro       "Rio de Janeiro"

;; CityName is String
;; interp. the name of a city
(define CN1 "Buenos Aires")
(define CN2 "Lima")
(define CN3 "Rio de Janeiro")

(define (fn-for-city-name cn)
  (... cn))

;; Template rules used;
;; - atomic non-distinct: String
```

## Compound Data Examples

### Example 1: Book (Simple Compound)
```racket
; INFORMATION                    DATA
; Book "1984" by Orwell, $15     (make-book "1984" "Orwell" 15)
; Book "Dune" by Herbert, $20    (make-book "Dune" "Herbert" 20)

(define-struct book [title author price])
;; Book is (make-book String String Number)
;; interp. a book with title, author name, and price in dollars
(define B1 (make-book "1984" "George Orwell" 15))
(define B2 (make-book "Dune" "Frank Herbert" 20))
(define B3 (make-book "The Hobbit" "J.R.R. Tolkien" 12))

(define (fn-for-book b)
  (... (book-title b)     ; String
       (book-author b)    ; String  
       (book-price b)))   ; Number
;; Template rules used:
;; - compound: 3 fields
```
## Java Object Translation
### Book Class in Java
```java
class Book {
    String title;
    String author;
    double price;
    
    Book(String title, String author, double price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }
    
    // Template for methods operating on Book
    /* Template:
     * FIELDS:
     * this.title -- String
     * this.author -- String  
     * this.price -- double
     * METHODS:
     * this.methodName() -- ReturnType
     * METHODS OF FIELDS:
     * this.title.length() -- int
     * this.title.substring(int) -- String
     * this.author.equals(Object) -- boolean
     */
}

// Examples
Book B1 = new Book("1984", "George Orwell", 15.0);
Book B2 = new Book("Dune", "Frank Herbert", 20.0);
```
## Design Recipe Steps for Compound Data
### Step 1: Information Analysis
- What pieces of information naturally belong together?
- What are the types of each piece?
- Are there any constraints or relationships?
### Step 2: Structure Definition
**Racket:** `(define-struct name [field1 field2 ...])` 
**Java:** Class with fields and constructor
### Step 3: Type Comment
**Format:** `TypeName is (make-constructor Type1 Type2 ...)` 
**Java:** Class name serves as the type
### Step 4: Interpretation
- Explain what each field represents
- Include units, constraints, or special meanings
- Connect back to the real-world information
### Step 5: Examples
- Create at least 2-3 varied examples
- Cover edge cases if applicable
- Use meaningful, realistic data
### Step 6: Template
- List all fields with their types
- Include method signatures for planned operations
- **Java:** Include methods of fields that might be useful
## Key Principles for Compound Data
1. **Group Related Information:** Fields should logically belong together
2. **Meaningful Names:** Use descriptive field and constructor names
3. **Appropriate Types:** Choose types that accurately represent the information
4. **Complete Examples:** Examples should demonstrate the full range of the data
5. **Clear Interpretation:** Make the real-world meaning explicit
