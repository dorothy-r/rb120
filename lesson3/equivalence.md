# Equivalence

Testing for equivalence in Ruby is much more complicated than it seems.
A string is equal to another string of the same value. An integer is equal to another integer of the same value. A symbol is equal to another symbol of the same value.
However, strings, integers, and symbols are all objects. What exactly are we comparing when using `==`?
A string literal is an object of the String class:

```ruby
str1 = "something"
str2 = "something"

str1.class      # => String
str2.class      # => String
```

In the code above, `str1` and `str2` are different objects. So an equality comparison between strings is asking, "Are the values within the two objects the same?" and _not_ "Are the two objects the same?"
If we want to find out the answer to the second question, whether two variables are actually pointing to the same object, we can use the `equal?` method:

```ruby
str1 = "something"
str2 = "something"
str1_copy = str1

# comparing the string objects' values:
str1 == str2            # => true
str1 == str1_copy       # => true
str2 == str1_copy       # => true

# comparing the actual objects:
str1.equal? str2        # => false
str1.equal? str1_copy   # => true
str2.equal? str1_copy   # => false
```

As seen above, the `==` method compares two variables' values, while the `equal?` method determines whether two variables point to the same object.
How does `==` know which value to use for comparison? What if we are not comparing Strings, but Array objects? Or custom objects? How will `==` determine an object's value?

## The `==` method

In Ruby, `==` is not an operator; it is an instance method available to all objects. Ruby allows us to use the syntax `str1 == str2` instead of `str1.==(str2)`, though both options work.
Since it is an instance method, the answer to "how does `==` know what value to use for comparison?" is: it is determined by the class.
The `BasicObject` class (the parent class for all classes in Ruby) defines the original `==` method. This implies that every Ruby object has a `==` method.
However, each class should define its own version of the `==` method to specify the value to compare.
The default implementation for `==` is the same as `equal?`, which isn't very useful. To get the `==` method to answer the question "Are the values in the two variables the same?", we need to define the `==` method to tell Ruby what "the same" means for a particular object. In doing so, we override the default `BasicObject#==` behavior:

```ruby
class Person
  attr_accessor :name

  def ==(other)
    name == other.name
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2       # => true
```

The `==` method defined above uses the `String#==` method.
Almost every class in the Ruby core library has its own `==` method, specifically defined for `Array`, `Hash`, `Integer`, `String`, etc objects.
So, for example, the `Integer#==` method considers the possibility of comparing an Integer with a Float, and handles the necessary conversion:

```ruby
45 == 45.00    # => true
```

One more note: when you define a `==` method, you also get the `!=` method.

## `object_id`

Every object has a method called `object_id`, which returns a numerical value that uniquely identifies the object. This method allows us to determine whether two variables are pointing to the same object.
Because `object_id` returns an integer, we can compare the object ids of various objects:

```ruby
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id    # => false

sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id    # => true

int1 = 5
int2 = 5
int1.object_id == int2.object_id    # => true
```

The above comparisons show us that symbols and integers behave differently than other objects in Ruby. If two symbols or two integers have the same value, they are also the same object.
This optimizes performance in Ruby, since symbols and integers can't be modified. (This is also why Rubyists prefer symbols over strings as hash keys: it optimizes performance and saves on memory.)

## `===` and `eql?`

There are two more methods related to equality in Ruby.
First, there is the `===` method, which also looks like an operator, but is actually a method. This method is used implicitly by the `case` statement.
An example of this is when we have ranges in a `when` clause:

```ruby
num = 25

case num
when 1..50
  puts "small number"
when 51..100
  puts "large number"
else
  puts "not in range"
end

# Behind the scenes, the `Range#===` method is used for each clause, like this:
if (1..50) === num
  puts "small number"
elsif (51..100) === num
  puts "large number"
else
  puts "not in range"
end
```

When `===` compares two objects, it is essentially asking, "If the first object is a group, would the second belong in the group?" So `(1..50) === 25` is asking, "does `25` belong in `(1..50)`?
`String === 'hello'` returns `true`, because `hello` is an instance of `String`.
Finally, `eql?` determines whether two objects contain the same value and if they are of the same class. This method is not used very often; its most common use is by `Hash` to determine equality among its members.

## Summary

**Most Important**
`==`

- frequently used
- for most objects, `==` compares the values of the objects
- `==` is actually a method, not an operator
- most built-in Ruby classes provide their own `==` method to specify how to compare objects of those classes
- by default, `BasicObject#==` returns true if two objects are the same object (this is why most other classes provide their own behavior for `#==`)
- if you need to compare custom objects, define the `==` method for the custom class

Less Important
`equal?`

- this method goes one level deeper than `==` and determines whether two variables actually point to the same object
- do not define `equal?` for custom classes
- not used very often
- comparing two objects' `object_id` has the same effect as using `equal?`

`===`

- used implicitly in `case` statements
- rarely called explicitly
- actually a method, not an operator
- only define it in a custom class if you anticipate its objects will be used in `case` statements (should be pretty rare, in practice)

`eql?`

- used implicitly by `Hash`
- very rarely used explicitly
