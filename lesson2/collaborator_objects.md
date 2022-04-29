# Collaborator Objects

So far we have learned that:

- classes group common behaviors
- objects encapsulate state
- an object's state is saved in its instance variables
- instance methods can operate on instance variables

Instance variables can hold any type of object: strings, integers, data structures like arrays or hashes, even an object of a custom class.

For example, we could have a `Person` with a pet `Bulldog`:

```ruby
class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Person
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
bud = Bulldog.new

bob.pet = bud
```

In the last line of the above code, we set `bob`'s `@pet` instance variable to the `Bulldog` object `bud`.
Calling `bob.pet` returns a `Bulldog` object, and so we can chain `Bulldog` methods to the end of that call:

```ruby
bob.pet.class  # => Bulldog
bob.pet.speak  # => "bark!"
bob.pet.fetch  # => "fetching!"
```

Objects that are stored as state within another object are called **collaborator objects**. So, we would say that `bob` has a collaborator object stored in the `@pet` variable.
Technically, any object stored in another object's instance variable is a collaborator object (even the String object stored in `@name`), but we usually use the term to refer to custom objects, not those inherited from the Ruby core library.
Collaborator objects are important in OOP, since they represent the connections between classes in a program. It is important to consider the collaborators our custom classes will have, and whether they make sense both technically and conceptually.
Here's an updated version of the code above that allows an instance of the `Person` class to have multiple pets, stored in an array of `Pet` objects:

```ruby
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets            # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]
```

Because `@pets` is an Array object, we cannot call `Pet` methods on it directly. We have to iterate through the elements, or operate on a specific one:

```ruby
bob.pets.each { |pet| pet.jump }
```

Collaborator objects allow us to modularize our programs into cohesive pieces, that interact in understandable ways. They play an important role in modeling complicated problems.

A collaborative relationship between objects is a relationship of association ("has a"), rather than inheritance ("is a").
A collaborator object is part of another object's state, and can be an object of any class.
Collaborative relationships exist from the design phase of the program; even before the collaborator object is added to the primary object's state. The collaborative relationship exists within the definition of the primary class.
