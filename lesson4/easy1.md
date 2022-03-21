1. Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

1) `true`
2) `"hello"`
3) `[1, 2, 3, "happy days"]`
4) `142`

All of these are objects. We can find out their class by calling `Kernel#class` on them:

```ruby
true.class                      # => TrueClass
"hello".class                   # => String
[1, 2, 3, "happy days"].class   # => Array
142.class                       # => Integer
```

2. If we have a `Car` class and a `Truck` class and we want to be able to `go_fast`, how can we add the ability for them to `go_fast` using the module `Speed`? How can you check if you `Car` or `Truck` can now go fast?

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

We can add the ability for `Car` and `Truck` to go fast by adding the line `include Speed` to each of these classes.
To check if they can now go fast, we can create an instance of each class, and call the `go_fast` method on it:

```ruby
my_truck = Truck.new
my_truck.go_fast          # => "I am a Truck and going super fast!"

my_car = Car.new
my_car.go_fast            # => "I am a Car and going super fast!"
```

3. In the last question, we had a modlue called `Speed` which contained a `go_fast` method. We included it in the `Car` class like this:

```ruby
class Car
  include Speed
  # ... rest of code
end
```

When we called the `go_fast` method from an instance of `Car`, the string printed when we go fast includes the name of the type of vehicle we are using: `"I am a Car and going super fast!"`
How is this done?
The string output by `go_fast` includes this string interpolation: `self.class`. This calls the `#class` method on the calling object, and returns its class (in this case, Car).

4. If we have a class `AngryCat` how do we create a new instance of this class?

We use the `::new` method: `cat = AngryCat.new`

5. Which of these two classes has an instance variable and how do you know?

```ruby
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```

`Pizza` has an instance variable. We know this because it has a variable that starts with '@', `@name`. We can double check by calling the `instance_variables` method on an instance of each class:

```ruby
hot_pizza = Pizza.new('cheese')
orange    = Fruit.new('apple')

hot_pizza.instance_variables      # => [:@name]
orange.instance_variables         # => []
```

6. What could we add to the class below to access the instance variable `@volume`?

```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
end
```

We could add an `attr_reader :volume`
Technically, we don't need to add anything, though. We can use the `instance_variable_get` method on an instance of `Cube`, like this:

```ruby
big_cube = Cube.new(5000)
big_cube.instance_variable_get("@volume")   # => 5000
```

This is not good practice, though.

7. What is the default return value of `to_s` when invoked on an object?

   It is a string representation of the object: its class and a hex encoding of its object_id. We can check this by looking up `Object#to_s` in the Ruby docs.

8. In the class below, what does `self` refer to in the `make_one_year_older` method definition?

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

Here, `self` refers to the object (instance of `Cat`) that is calling the `make_one_year_older` method. We are using the setter method for `@age` here, but we need to prepend it with self so that Ruby knows we are calling a method rather than assigning to a local variable called `age`.

9. In the class below, the name of the `cats_count` method uses `self`. What does `self` refer to in this context?

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

Here, `self` refers to the `Cat` class. `cats_count` is a class method, so we call it on the class itself: `Cat.cats_count`, and we define it by placing `self.` at the beginning of the method name.

10. If we have the class below, what would you need to call to create a new instance of this class:

```ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```

We need to provide two arguments when creating a new instance:
`my_bag = Bag.new('red', 'canvas')`
