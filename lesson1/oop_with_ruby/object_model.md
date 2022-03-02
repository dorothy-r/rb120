# The Object Model

## Why Object Oriented Programming?

The OOP paradigm was created to deal with the complexity of large software systems.
OOP allows us to change and manipulate data in a contained way that doesn't affect the entire program.
With OOP, programs can have many small interacting parts, instead of being one big interdependent unit.

### Important Terminology:

**Encapsulation**: Hiding pieces of functionality, making it unavailable to the rest of the code. This protects data and defines boundaries in an application.
Ruby accomplishes this with objects, which have interfaces (methods) that allow other parts of the program to interact with them.
Objects also allow us to think on a new level of abstraction.

**Polymorphism**: The ability for different types of data to respond to a common interface.
This lets objects of different types respond to the same method invocation, and gives us flexibility in how we use pre-written code.

**Inheritance**: Where a class inherits the behaviors of another class (the **superclass**).
Basic classes can have broad usability and applicability, and we can create **subclasses** with more detailed, specific behaviors.

**Module**: Another way to share behavior among objects. Modules must be mixed in with a class using the `include` method invocation. This is called a **mixin**.
When a module is mixed in to a class, behaviors included in it are available to all objects in that class.

## What Are Objects?

In Ruby, anything that can be said to have a value is an object: This includes numbers, strings, arrays, and even classes and modules.
(Not _everything_ in Ruby is an object; some things are not, including methods, blocks, and variables.)
Objects are created from classes. Individual objects will contain different information, but they can be instances of the same class.

## Classes Define Objects

In Ruby, **classes** define the attributes and behavior of objects.
They can be thought of as basic outlines of what an object consists of and what it can do.
To define a class, we use the `class` keyword and use CamelCase to create its name:

```ruby
class GoodDog
end

sparky = GoodDog.new
```

The last line of code above creates an instance of the `GoodDog` class, and stores it in the variable `sparky`. `sparky` references an object now, an instance of the class `GoodDog`.
Creating a new object from a class is called **instantiation**.
Calling the class method `new` returns a new object.

## Modules

A module is a collection of behaviors that is usable in other classes via **mixins**.
We use the `include` method to mix a module into a class.
Once we include a module in a class, all instances of that class have access to the instance methods in the module. It's as if we copy-pasted the methods from the module into the class.

## Method Lookup

Ruby has a method lookup path that it follows each time a method is called.
We can use the `ancestors` method on any class to find its method lookup chain.
In this chain, modules come in between custom classes and Ruby's `Object` class.
When we call a method, Ruby will first look in the Object's class, then any modules that are included in that class, and then Object, Kernel, and BasicObject. This continues until the method is found or there are no more places to look.

## Exercises

1. How do we create an object in Ruby? Give an example of the creation of an object.

We first need to define a class. Once we have a class, we can use the `.new` method to create (or instantiate) an object that is an instance of that class.
For example:

```ruby
class FloweringPlant
end

rose = FloweringPlant.new
```

2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

A module is a collection of behaviors that can be shared by more than once class. It allows us to group behaviors that many classes might share, and keep them in one place rather than defining the same methods for each class.
A module can be used with a class as a mixin, by using the `include` keyword.
Example:

```ruby
module Grow
end

class FloweringPlant
  include Grow
end

rose = FloweringPlant.new
```
