# Inheritance

**Inheritance** is when a class inherits behavior from another class.
The class that is inheriting behavior is called the subclass, and the class it inherits from is called the superclass.
Inheritance allows us to extract common behaviors from classes that share them, and move them to a superclass. This keeps the logic in one place and makes the code more DRY.

## Class Inheritance

Inheritance makes all of a superclass's methods available to its subclasses.
We use the `<` symbol to signify that one class is inheriting from another, like this:
`class GoodDog < Animal`
We can **override** a method from a superclass by defining a method with the same name in a subclass. Ruby looks for a method in an object's class before it looks in its superclass.
Inheritance is a great way to remove duplication in your code base by extracting logic that is used repeatedly to one place.

## `super`

The `super` keyword allows us to call methods from farther along the method lookup path.
When you call `super` from within a method, it searches the method lookup path for a method with the same name, and invokes it.
So, we can override a superclass's method by creating a method with the same name in the subclass. But within that method, we can use `super` to invoke the method from the superclass, and then extend its functionality to meet the more specific needs of the subclass.
It is common to use this with `initialize`:

```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color, name)
    super(name)
    @color = color
  end
end

bruno = GoodDog.new("brown", "Bruno")
```

When the method from the superclass takes arguments, `super` automatically forwards the arguments that were passed to the method from which `super` is called.
When called with specific arguments, the specified arguments will be sent up the method lookup chain.
If there is a method in your superclass that takes no arguments, the safest (and sometimes only) way to call it is as `super()`, with parentheses. Otherwise, Ruby may try to pass it an argument intended only for the subclass-specific method, and raise an error.

## Mixing in Modules

Using **modules** also helps to keep your code DRY.
While extracting common methods to a superclass works well for concepts that are naturally hierarchical, it doesn't account for exceptions where subclasses in different 'branches' of the hierarchy share certain behaviors.
For these situations, we can group those behaviors into a module, and then mix in that module to the classes requiring those behaviors:

```ruby
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable
end
```

A common naming convention for modules is to use the "able" suffix on a verb that describes the behavior modeled by the module.

## Inheritance vs Modules

There are two primary ways that Ruby implements inheritance. Class inheritance is the traditional way: one type inherits the behvaiors of another type, resulting in a new specialized type.
The other way is sometimes called **interface inheritance**: this is what is happening with modules. The class doesn't inherit behaviors from another type, but instead inherits the the interface provided by the mixin module. The resulting type is not a specialized version of the module.
Some guidelines on when to use class inheritance vs module mixins:

- You can only subclass from one class, while you can mix in as many modules as you'd like.
- Class inheritance is usually the right choice for an "is a" relationship, and interface inheritance is usually the right choice for a "has a" relationship.
  A dog "is a" mammal (class inheritance) and "has an" ability to swim (interface inheritance).
- You cannot instantiate (create an object from) modules. Modules are only used for grouping common methods together (and for namespacing).

## Method Lookup Path

How does including mixins affect the method lookup path (the order in which classes are inspected when we call a method)?
We can use the `ancestors` class method to see a class's method lookup path.
For example, `Animal.ancestors` returns the following list:

```
Animal
Walkable
Object
Kernel
BasicObject
```

So when we call a method on an Animal object, Ruby first looks in the Animal class, then the Walkable module, then the Object class, then the Kernel module, and finally the BasicObject class.
If we include multiple modules in a class, Ruby looks at the last module we included _first_. A class can also access any modules mixed in to any of its superclasses.

## More Modules

Modules have other uses, besides mixing in behaviors to classes.
One use is **namespacing**, which (in this context) means organizing similar classes under a module.
Using modules to group related classes makes it easy to recognize them in our code. It also reduces the likelihood of classes colliding with similarly named classes in a codebase. Here's an example;

```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end
```

To call a class in a module, append the class name to the module name with two colons: `buddy = Mammal::Dog.new`

Another use for modules is using them as a **container** for methods, called module methods. This is useful for methods that seem out of place elswhere in the code. So in the `Mammal` module above, we could add something like:

```ruby
module Mammal
  #...
  def self.some_out_of_place_method(num)
    num ** 2
  end
end
```

When we define methods this way, we can call them directly from the module:
`value = Mammal.some_out_of_place_method(4)`
We can also use the double colons (::) after the module name, but the above is preferred.

## Private, Protected, and Public

**Method Access Control** allows us to allow or restrict access to the methods defined in a class.
In Ruby, this is implemented through the `public`, `private`, and `protected` access modifiers.
A **public method** is a method that is readily available for the rest of the program to use (you just need to know the class or object name to reference); these methods comprise the class's interface.
A **private method** is one that does work in the class but doesn't need to be available to the rest of the program. To define a private method, we use the `private` method call: anything below it is private (unless another method is called later to negate it).
Trying to call a private method from outside the class raises an error. Private methods are only accessible from other methods in the class, called with the current object.
Public and private methods are the most common, but **protected methods** can be used for something in-between. We use the `protected` method to create them (works like the `private` method).
Protected methods are accessible like public methods inside the class. You can also access protected methods in a different instance of the same class. But outside the class, they act like private methods. In practice, they are not used very often.

## Accidental Method Overriding

Every class we create inherently subclasses from the `Object` class, which is built in to Ruby and includes many critical methods. These methods are available in _all classes_.
Through inheritance, a subclass can override a superclass's method. So, you could accidentally create issues in your code by overriding a method that was originally defined in the `Object` class. To avoid this, it is important to be familiar with common `Object` methods, and not use their names for instance methods.
One `Object` instance method that is often overridden without any major side-effects is the `to_s` method.

## Exercises

1. - 6. See `my_car.rb`

2. Create a class 'Student' with attributes `name` and `grade`. Do NOT make the
   grade getter public, so `joe.grade` will raise an error. Create a `better_grade_than?` method, that you can call like so:

```
puts "Well done!" if joe.better_grade_than?(bob)
```

```ruby
class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(classmate)
    grade > classmate.grade
  end

  protected

  attr_reader :grade
end

bob = Student.new('Bob', 97)
joe = Student.new('Joe', 52)

puts "Well done!" if bob.better_grade_than(joe)
```

8. Given the following code and error message:

```ruby
bob = Person.new
bob.hi

NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'
```

What is the problem, and how would you go about fixing it?

The error is that `hi` is a private method in the `Person` class. To fix this, I would either make the method public, or write another public method that allows us to access the functionality of `hi` that we need to use.
