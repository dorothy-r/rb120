1. If we have this code:

```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

What happens in each of the following cases?

1.

```ruby
hello = Hello.new
hello.hi
# > "Hello"
```

2.

```ruby
hello = Hello.new
hello.bye
# NoMethodError
```

3.

```ruby
hello = Hello.new
hello.greet
# ArgumentError
```

4.

```ruby
hello = Hello.new
hello.greet("Goodbye")
# > "Goodbye"
```

5.

```ruby
Hello.hi
# NoMethodError
```

2. In the last question, calling `Hello.hi` raised an exception. How would you fix this?
   We could define a class method `hi` in the `Hello` class, like this:

```ruby
class Hello
  def self.hi
    puts "Hello from Hello"
    # if we want to use `greet` in this method, we'd have to do this, because `greet` is an instance method:
    greeting = Greeting.new
    greeting.greet("Hello")
  end

  #...rest of code
end
```

3. When objects are created they are a separate realization of a particular class.
   Given the class below, how do we create two different instances of this class with separate names and ages?

```ruby
class AngryCat
  def initialize(age, name)
    @age = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hissssss!!!"
  end
end

# Like this;
cat1 = AngryCat.new(5, "Princess")
cat2 = AngryCat.new(3, "Winnie")
```

4. Given the class below, if we created a new instance of the class and then called `to_s` on that instance, we could get something like "#<Cat:0x007ff39b356d30>". How could we go about changing the `to_s` output on this method to look like this: `I am a tabby cat`? (assuming "tabby" is the `type` we passed in during intialization).

```ruby
class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  # We could implement our own `to_s` method like this:
  def to_s
    "I am a #{type} cat"
end
```

5. If I have the following class:

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

What would happen if I called the methods as shown below?

```ruby
tv = Television.new
tv.manufacturer         # NoMethodError (this is a class method)
tv.model                # executes method

Television.manufacturer # executes method
Television.model        # NoMethodError (this is an instance method)
```

6. In the class below, we have used `self` in the `make_one_year_older` method. What is another way we could write this method so we don't have to use the `self` prefix?

```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```

We could write it like this:

```ruby
def make_one_year_older
  @age += 1
end
```

7. What is used in this class but doesn't add any value?

```ruby
class Light
  attr_accessor :brigthness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end
```

The explicit `return` in `self.information` is not necessary. The last evaluated expression of the method would be returned automatically anyway.
