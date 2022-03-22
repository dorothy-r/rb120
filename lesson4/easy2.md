1. What is the result of executing the following code?

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
   ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future
```

The code will return a string: "You will " concatenated with one of the strings in the array returned by `choices` (which will be chosen at random, by the `sample` method).

2. We have an `Oracle` class and a `RoadTrip` class that inherits from the `Oracle` class. What is the result of the following:

```ruby
class Oracle
  # ... as above
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
trip.predict_the_future
```

The code will return the string "You will " concatenated with one of the strings in the array returned by `RoadTrip#choices`, chosen at random. Because `RoadTrip` is a subclass of `Oracle`, it has access to the `predict_the_future` method via inheritance. When Ruby doesn't find a method with that name in `RoadTrip`, it goes up the chain of inheritance until it finds one in `Oracle`. However, `RoadTrip` defines its own `choices` method, so that is what is used when `choices` is called from within `predict_the_future`. Ruby looks in an object's own class for methods first, even if that method is called from a method defined in another class.

3. How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?
   Ruby will look for a method in the object's class, then in any modules, then in the object's superclass, and so on up the chain of its ancestors.
   To find an objects ancestors, you can call the `ancestors` method on its class. This is a class method, and it won't work if you call it on an instance of a class.
   What is the lookup chain for `Orange` and `HotSauce`:

```ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```

`Orange`: Orange > Taste > Object > Kernel > BasicObject
`HotSauce`: HotSauce > Taste > Object > Kernel > BasicObject

4. What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

```ruby
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
   @ type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

We could add `attr_accessor :type` to the class and remove the `type` and `type=` methods. We can also replace `@type` with `type` in the `describe_type` method. (It is standard practice to use the getter method rather than referring to instance variables directly.)

5. There are a number of variables listed below. What are the different types and how do you know which is which?

```ruby
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
```

The first is a local variable. We know this because its name is in lowercase letters with no symbols in front.
The second is an instance variable. We know this because its name starts with one `@` symbol.
The third is a class variable. We know this because its name starts with two `@` symbols.

6. Given the following class, how do you know if one of the methods is a class method? How would you call a class method?

```ruby
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```

The `self.manufacturer` method is a class method. You can tell because it starts with `self.` in the method definition.
You call a class method on the class itself, not on an instance of it: `Television.manufacturer`.

7. Given the class below, explain what the `@@cats_count` variable does and how it works. What code would you need to write to test your theory?

```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```

The `@@cats_count` variable is a class variable that keeps track of how many objects of the `Cat` class have been instantiated.
Each time a new `Cat` object is created, the `initialize` method is executed. Within that method, `@@cats_count` is incremented by 1, which allows it to track the number of `Cat` objects that have been created.
We could test it like this:

```ruby
cat1 = Cat.new('calico')
cat2 = Cat.new('tabby')

Cat.cats_count      # should return 2
```

8. If we have these two classes, what can we add to the Bingo class to allow it to inherit the `play` method from the `Game` class?

```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo
  def rules_of_play
    # method implementation
  end
end
```

We can define the `Bingo` class like this: `class Bingo < Game`

9. If we make that change to the `Bingo` class, what would happen if we added a `play` method to `Bingo`, keeping in mind that there is already a method of this name in the `Game` class that the `Bingo` class inherits from?

The `play` method in the `Bingo` class would override the `play` methhod in the `Game` class, for `Bingo` objects. Ruby looks for a method definition in an object's class first, then looks in superclasses.

10. What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

- it helps us to better organize our code
- it allows us to avoid repetition in our code by grouping methods/variables such that they can be shared/reused in different areas of code
- it allows us to think about our code at a higher level of abstraction
- it allows us to conceptualize our code more easily, since objects are represented by nouns and we can consider their relationships with the rest of the code
- it allows us to encapsulate functionality in our code, only exposing methods to the parts of code that need it, which helps to prevent accidental access/changes to variables
- it allows us to work faster since we can reuse code in different places
- it allows us to manage complexity more easily
