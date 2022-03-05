# Polymorphism and Encapsulation

## Polymorphism

**Polymorphism** refers to the ability of objects with different types to respond in different ways to the same message (or method invocation); that is, data of different types can respond to a common interface.
When we don't care what type of object is calling a method, we are using polymorphism.
This often involves inheritance from a common superclass, but not always.
There are two main ways to implement polymorphism: inheritance and duck typing.

### Polymorphism through inheritance

Here is an example of how to implement polymorphism through inheritance:

```ruby
class Animal
  def move
  end
end

class Fish < Animal
  def move
    puts "swim"
  end
end

class Cat < Animal
  def move
    puts "walk"
  end
end

class Sponge <Animal; end
class Coral < Animal; end

animals = [Fish.new, Cat.new, Sponge.new, Coral.new]
animals.each { |animal| animal.move }

```

Every object in the array above is a different type, but we can call a `move` method for each of them in the block passed to `each`.
The way this class hierarchy is set up lets us work with each of these types in the same way, even though their individual implementations are different. That is polymorphism.
Polymorphism through inheritance can work by either simply inheriting or **overriding** the behavior of a superclass.
The important thing is that the 'client code' (the code interacting with the objects) can treat them all the same.
The public interface of the `move` method is the same for all of these types--we can call it with no arguments--and so we can work with all of them in the same way, even though the implementation may be different for the different types.

### Polymorphism through duck typing

**Duck typing** occurs when objects of different _unrelated_ types both respond to the same method name.
We aren't concerned with the object's class, just whether it has a particular behavior: _if it quacks like a duck, we can treat it as a duck_.
As long as the objects use the same method name, and the method takes the same number of arguments, we can treat them the same (in terms of invoking that method/behavior).
Duck typing is an informal way to classify objects.
Here is an example of polymorphism with duck typing:

```ruby
 class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performace(wedding.songs)
  end

  def prepare_performace(songs)
    #implementation
  end
end
```

Even though there is no inheritance in the above example (no `Preparer` superclass, for example), we still have polymorphism since each class provides a `prepare_wedding` method. So all of the objects respond to the `prepare_wedding` method call, and perform the actions associated with their own particular implementation of it.
Having two different objects with a method of the same name and compatible arguments doesn't necessarily mean we have polymorphism. We have to actually be using/calling the method in a polymorphic manner.
In practice, polymorphic methods are intentionally designed to be polymorphic.

## Encapsulation

**Encapsulation** lets us hide the internal representation of an object from the outside and only expose the methods and properties that users of the object _need_.
We can use _method access control_ to expose these properties and methods through a class's public methods.

Here's an example:

```ruby
class Dog
  attr_reader :nickname

  def initialize(n)
    @nickname = n
  end

  def change_nickname(n)
    self.nickname = n
  end

  def greeting
    "#{nickname.capitalize} says Woof Woof!"
  end

  private
    attr_writer :nickname
end

dog = Dog.new("rex")
dog.change_nickname("barny")
puts dog.greeting
```

Note that it is legal to call private methods with a literal `self` as the caller(from inside the current object). But we cannot call it with any other object.
Generally speaking, a class should have as few public methods as possible. It makes using the class simpler, and protects data from undesired changes.
