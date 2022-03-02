# Classes and Objects I

## Class Methods

Class methods can be called directly on the class itself, without having to instantiate any objects.
To define a class method, prepend the method name with the reserved word `self.`:

```ruby
def self.what_am_i
  "I'm a GoodDog class!"
end
```

To call a class method, use its class name follwed by the method name:
`GoodDog.what_am_i`
Class methods are for functionality that does not pertain to individual objects.
Objects have different states, so if we have a method that does not deal with state, we can use a class method.

## Class Variables

Class variables capture information related to an entire class. They are created by adding `@@` before the variable name.
We can use class variables to keep track of details that pertain only to the class, not individual objects, such as the total number of objects in that class.
Instance methods can access and modify class variables.

## Constants

We can use constants when creating classes, if there are certain variables that we never want to change.

## The `to_s` Method

The `to_s` instance method comes built in to every class in Ruby.
We actually use it every time we call the `puts` method. `puts` calls `to_s` on its argument, so `puts sparky` is equivalent to `puts sparky.to_s`.
The default behavior of `to_s`, when called on an object, is to return the name of the object's class and an encoding of its object id.
We can add a custom `to_s` method to a class, and override the default `to_s` that comes built in.
`p` is similar to `puts`, but it calls the built-in instance method `inspect` on its argument, rather than `to_s`. (We wouldn't want to override `inspect` since it is useful for debugging purposes.)
`to_s` is also called automatically in string interpolation, which we should also keep in mind when we have written a custom `to_s` instance method.

## More About `self`

`self` can refer to different things depending on where it is used.
So far we have seen these use cases:

1. Use `self` when calling setter methods from within the class, to allow Ruby to recognize that we are calling a setter method, not initializing a local variable.
2. Use `self` for class method definitions.

When an instance method uses `self` from within the class, `self` references the calling object. So if you call `self.name=` on an object, `sparky`, from within the class, that is the same as calling `sparky.name=` from outside the class. (`sparky` is not in scope inside of the class).
When `self` is used inside a class but outside an instance method, to define a class method, it refers to the class itself. So `def self.a_method` is equivalent to `def GoodDog.a_method`.
So to summarize:

1. When used inside an instance method within a class, `self` references the instance that called the method (the calling object).
2. When used within a class outside of an instance method, `self` references the class itself and can be used to define class methods.

What `self` is referencing changes depending on the scope in which it is used, so it is important to note whether you are inside an instance method or not.

## Exercises

1. & 2. See `my_car.rb`

2. When running the following code:

```ruby
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

We get the following error:

```
test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
```

Why do we get this error and how do we fix it?

Within the Person class, we used `attr_reader` to establish a getter method for the `name` instance variable; however, we do not have a setter method that allows us to change a `name` instance variable.
Thus, when we try to change it, we get an error.
To fix this, we should use `attr_accessor` for `:name` to establish both a getter and setter method.
