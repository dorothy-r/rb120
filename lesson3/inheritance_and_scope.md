# Inheritance and Variable Scope

How does inheritance affect variables? Let's see some examples of each type.

## Instance Variables

```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end        # if we add this, the output changes

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                 # bark! bark! bark! bark!
```

In the above example, the `Dog` class doesn't have an `initialize` instance method. When we called `Dog.new`, the method lookup path found and executed `Animal#initialize`, where the `@name` instance variable was initialized.
Although `@name` was initialized in the `Animal` class, we can access it from the `Dog#dog_name` instance method.
However, if we change the code and add an initialize method to the `Dog` class, and that method does not initialize `@name`, `@name` (like all uninitialized instance variables) returns `nil`.

How do modules affect instance variables?

```ruby
module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
teddy.enable_swimming     # need to call this method to initialize `@can_swim`
teddy.swim                # => swimming!
```

With both class inheritence and mixin modules, we need to call the method that initializes the instance variable. Once we have done that, instances that inherit/mixin these variables can access them.
Unlike instance methods, instance variables and their values are not inherited. They must be initialized for each object.

## Class Variables

Let's see what happens with class variables:

```ruby
class Animal
  @@total_animals = 0

  def initialize
    @@total_animals += 1
  end
end

class Dog < Animal
  def total_animals
    @@total_animlas
  end
end

spike = Dog.new
spike.total_animals             # => 1
```

Class variables are accessible to sub-classes. The class variable is initialized in the `Animal` class, and loaded when the class is evaluated by Ruby. We don't need to explicitly invoke a method to initialize it at the object level.
The potential danger when working with class variables is that there is only one copy of the class variable across all sub-classes:

```ruby
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

class Motorcycle < Vehicle
  @@wheels = 2
end

Motorcycle.wheels             # => 2
Vehicle.wheels                # => 2
```

We can't override class variables, like instance methods, when we create a sub-class. The class variable is shared across all sub-classes, and can be modified from any sub-class. Any change to a class variable will affect all subclasses that have access to the class variable.
It's a good idea to avoid using class variables when working with inheritance.
In fact, some Rubyists recommend avoiding class variables entirely.

## Constants

Constants can be accessed from instance or class methods when defined within a class.
Can we reference a constant defined in a different class?
We can't just reference that constant by its name alone. Ruby will look for it within the current class and throw an error if it doesn't find it.
But we can refer to a constant from another class if we use the namespace resolution operator `::` to tell Ruby where to look:

```ruby
class Dog
  LEGS = 4
end

class Cat
  def legs
    Dog::LEGS               # only works with `Dog::`, to show where `LEGS` is
  end
end

kitty = Cat.new
kitty.legs                  # => 4
```

So, how do constants work with inheritance?
A constant initialized in a superclass is inherited by its subclasses, and can be accessed by both class and instance methods.
Things are a bit different with modules:

```ruby
module Maintenance
  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
a_car.change_tires           # => NameError: unititialized constant
```

Contants are not evaluated at runtime (unlike instance methods or instance variables). This means their _lexical scope_, or where they are used in the code, is important.
In the above example, there is a line of code referencing `WHEELS` in the `Maintenance` module. Even though we call that method from the `a_car` object, Ruby will look for it in the `Maintenance` module, and will not find it.
We can fix it by replacing `WHEELS` with either `Vehicle::WHEELS` or `Car::WHEELS`
Constant resolution will look at the lexical scope first, and then look at the inheritance hierarchy.

## Summary

- **Instance variables** behave as we'd expect. We just need to make sure that the instance variable is initialized before referencing it.
- **Class variables** allow sub-lasses to override superclass class variables. Any change will also affect all other subclasses of the superclass. This is tricky behavior, and some Rubyists avoid class variables altogether.
- **Constants** have _lexical scope_, which makes their scoping rules unique compared to other variable types. If ruby doesn't find the constant using lexical scope, it will then look at the inheritance hierarchy.
