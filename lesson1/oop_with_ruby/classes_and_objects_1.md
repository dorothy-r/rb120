# Classes and Objects I

## States and Behaviors

When defining a class, we focus on _states_ and _behaviors_.
States keep track of an object's attributes. We use instance variables to store this information.
Instance variables keep track of state
Behaviors are what objects can do. Instance methods define these behaviors.
Instance methods expose behvior for objects.

## Initializing a New Object

We can define an `initialize` instance method for a class. This gets called every time we create a new object.
Calling the `new` class method leads to the `initialize` instance method.
The `initialize` method is called a _constructor_ since it executes whenever a new object is created.

## Instance Variables

Instance variables exist as long as the object instance exists, and they allow us to associate data with an object.
Instance variables are responsible for keeping track of information about the state of an object.
Every object's state is unique, and instance variables allow us to keep track.
Instance variables are named with an `@` at the beginning of their name.

## Instance Methods

Instance methods allow us to define behaviors that objects within a class can perform.
All objects of a class have the same behaviors, even though they have different states.
Instance methods have access to instance variables, allowing us to use string interpolation and expose information about the object's state.

## Accessor Methods

We can't access instance variables outside of the class, by using code like `sparky.name`.
In order to access information about an object's state, we have to create an instance method that will return that information:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end
end
```

This is called a _getter_ method.
If we want to change an object's state, we can define and use a _setter_ method:

```ruby
def set_name=(name)
  @name = name
end
```

Ruby allows us to use a special syntax with setter methods. Instead of writing `sparky.set_name=("Spartacus")`, we can write `sparky.set_name = "Spartacus"`.
Rubyists typically name _getter_ and _setter_ methods using the same name as the instance variable they are getting and setting: so `name` instead of `get_name` and `name=(n)` instead of `set_name=(n)`.
**note**: Setter methods always return the value that is passed in as an argument, even if we write some other code within the method.
Because getter and setter methods are so common, Ruby has a built-in way to create them automatically" the `attr_accessor` method:

```ruby
class GoodDog
  attr_accessor :name
end
```

This method takes a symbol as an argument, and uses it to create the method name for the getter and setter methods for that particular attribute.
If we only want the getter method, we use the `attr_reader` method, and if we only want the setter method, we use the `attr_writer` method.
All of the `attr_*` methods take a symbol as parameter(s).
To track multiple states, use this syntax:

```ruby
attr_accessor :name, :height, :weight
```

### Accessor Methods in Action

We can also use getter and setter methods from within the class.
It is actually prefeable to use these methods rather than reference an instance variable directly--even though it is available within the class.
One instance where this doesn't work (without some changes) is when we create a method that allows us to change several states at once, like this:

```ruby
def change_info(n, h, w)
  name = n
  height - h
  weight = w
end
```

Ruby thinks that we are initializing local variables here instead of calling setting methods.

### Calling Methods with self

To fix this problem, we need to prepend the method names with `self.`, to let Ruby know that we are calling a method, like this:

```ruby
def change_info(n, h, w)
  self.name = n
  self.height - h
  self.weight = w
end
```

You can use the `self.` prefix with any instance method, not just accessor methods.

## Exercises

- see `my_car.rb` file
