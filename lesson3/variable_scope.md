# Variable Scope

Previously, we learned variable scoping rules for _local variables_.
Now, we'll learn about scoping rules for _instance_ and _class_ variables, as well as _constants_.

## Instance Variable Scope

Instance variables have names that start with `@`. They are scoped at the _object_ level. They are used to track the state of an individual object, and do not cross over between objects. We can use instance variables to separate the state of objects from the same class:

```ruby
class Person
  def initialize(n)
    @name = n
  end
end

bob = Person.new('bob')
joe  Person.new('joe')

puts bob.inspect        # => #<Person:0x007f9c830e5f70 @name="bob">
puts joe.inspect        # => #<Person:0x007f9c830e5f20 @name="joe">
```

Because instance variables are scoped at the object level, an instance variable is accessible in any of an object's instance methods, even if it is initialized outside of that method.
Unlike local variables, instance variables are accessible within an instance method even if they are not passed into it; the scope is at _object level_.

```ruby
class Person
  def initialize(n)
    @name = n
  end

  def get_name
    @name
  end
end

bob = Person.new('bob')
bob.get_name                # => "bob"
```

If we try to access an instance variable that is not yet initialized, we get `nil`. (This is unlike referencing an uninitialized local variable, which causes a `NameError`.):

```ruby
class Person
  def get_name
    @name
  end
end

bob = Person.new
bob.get_name                # => nil
```

As a sidenote, what happens if we accidentally put an instance variable at the _class_ level?

```ruby
class Person
  @name = "bob"

  def get_name
    @name
  end
end

bob = Person.new
bob.get_name                # => nil
```

Instance variables initialized at the class level are an entirely different thing, called _class instance variables_. We don't need to know about these yet; for now, just remember to always initialize instance variables within instance methods.

## Class Variable Scope

Class variables start with `@@`. They are scoped at the class level, and exhibit two main behaviors:

- all objects share 1 copy of any class variable (and can access class variables by way of instance methods)
- class methods can access class variables, regardless of where they are initialized
  Here's an example:

```ruby
class Person
  @@total_people = 0          # initialized at the class level

  def self.total_people
    @@total_people            # accessible from class method
  end

  def initialize
    @@total_people += 1       # mutable from instance method
  end

  def total_people
    @@total_people            # accessible from instance method
  end
end

Person.total_people           # => 0
Person.new
Person.new
Person.total_people           # => 2

bob = Person.new
bob.total_people              # => 3

joe = Person.new
joe.total_people              # => 4

Person.total_people           # => 4
```

Above, we have two different `Person` objects that can effectively access and modify one copy of the `@@total_people` class variable.
We can't do this with instance variables or local variables; only class variables can share state between objects.

## Constant Variable Scope

Constant variables are usually just called constants, since we are not supposed to reassign them. (If you do, Ruby will warn you but won't throw an error.)
Constants begin with a capital letter and have _lexical_ scope:

```ruby
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  attr_reader :name

  def self.titles
    TITLES.join(', ')
  end

  def initialize(n)
    @name = "#{TITLES.sample} #{n}"
  end
end

Person.titles                   # =>  "Mr, Mrs, Ms, Dr"

bob = Person.new('bob')
bob.name                        # => "Ms bob" (output will vary)
```

Within one class, the rules for accessing constants are pretty easy: a constant is available in class methods and instance methods (which implies it's also accessible from objects).
If we try to reference a constant from an unconnected class, a `NameError` is thrown; an unrelated class is not part of the lexical scope, so Ruby will not look for the constant there.
We can reference a constant from a different class by using that class name followed by the namespace resolution operator (`::`).

```ruby
class Computer
  GREETINGS = ["Beep", "Boop"]
end

class Person
  def self.greetings
    Computer::GREETINGS.join(', ')
  end

  def greet
    Computer::GREETINGS.sample
  end
end

puts Person.greetings # => "Beep, Boop"
puts Person.new.greet # => "Beep"
```

Things get trickier when inheritance is involved; that's when it is important to remember that constants have _lexical_ scope. We'll cover that in the next section.
