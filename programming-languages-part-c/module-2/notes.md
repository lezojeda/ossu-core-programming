# about ruby
- pure object-oriented language
- all values are *objects*
	- as a counter-example, in Java some values are _not_ objects, but in Ruby every expression evaluates to one
- class-based -> every object is an instance of a class
- has mixins
- dynamically typed
- blocks and closures
## the rules of class-based OOP
1. all values (as usual, the result of evaluating expressions) are references to objects.
2. given an object, code “communicates with it” by calling its methods. A synonym for calling a method is sending a message. (In processing such a message, an object is likely to send other messages to other objects, leading to arbitrarily sophisticated computations.)
3. each object has its own private state. Only an object’s methods can directly access or update this state.
4. every object is an instance of a class.
5. an object’s class determines the object’s behavior. The class contains method definitions that dictate how an object handles method calls it receives.
## duck typing
the idea that the specific class of an object doesn't matter as long as it can respond to what it's expected to

for example
```ruby
def mirror_update pt
	pt.x = pt.x * -1
end
```
here we don't care if pt is an instance of a certain class `Point` as long as it has a numeric getter x
## blocks
a particular feature of Ruby are blocks that some methods take, like `times`, for integers:

```ruby
x.times { puts "hi" }
```
blocks are _not_ objects but they are like closures (not exactly because they are not classes) in the sense that they can access variables in the scope where the block is defined
## closures
with the `Proc` class we can create proper closures

suppose we wanted to create an array of blocks, i.e., an array where each element was something we could “call” with a value. You cannot do this in Ruby because arrays hold objects and blocks are not objects.

so this is an error:
`c = a.map {|x| {|y| x >= y} } # wrong, a syntax error`

but we can use **lambda** to create an array of instances of **Proc**:

`c = a.map {|x| lambda {|y| x >= y} }`

Now we can send the call message to elements of the c array:

```ruby
c[2].call 17
j = c.count { |x| x.call(5) }
```
## the precise definition of method lookup
semantics of OO language constructs, particularly calls to methods
