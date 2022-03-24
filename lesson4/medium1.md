1. Ben asked Alyssa to code review the following code:

```ruby
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
```

Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot to put the `@` before `balance` when you refer to the balance instance variable in the body of the `positive_balance?` method.
"Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an `@`!"
Who is right, Ben or Alyssa, and why?

Ben is right. He defined a getter method for `@balance` using `attr_reader :balance`. In the `positive_balance?` method, he is using the getter method, `balance` to access the value of the instance variable `@balance`.

2. Alan created the following code to keep track of items for a shopping cart application he's writing:

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
```

Alyssa looked at the code and spotted an mistake. "This will fail when `update_quantity` is called", she says.
Can you spot the mistake and how to address it?

The mistake is in assigning `updated_count` to `quantity`. Without the `@`, Ruby interprets it as a local variable.
There are two ways to address it: we could add the `@` to the beginning of the variable name, so that Ruby knows we are updating the instance variable `@quantity`. Or we could define a setter method for `@quantity`, using `attr_writer or attr_accessor :quantity` and call that method within `update_quantity`, like so: `self.quantity = updated_count`.

3. In the last question, one possible solution is to change `attr_reader` to `attr_accessor` and change `quantity` to `self.quantity`.
   Is there anything wrong with fixing it this way?

The syntax is correct, and the code will work as expected if we fix it in this way. A possible drawback is that creating a setter method for `@quantity` exposes the variable, and makes it possible to change it directly, without the check that `update_quality` uses to prevent negative quantities.

4. Let's practice creating an object hierarchy.
   Create a class called `Greeting` with a single instance method called `greet` that takes a string argument and prints that argument to the terminal.
   Now create two other classes that are derived from `greeting`: on called `Hello` and one called `Goodbye`. The first shoudl have a `hi` method that takes no arguments and prints `'Hello'`. The second should have a `bye` method to say "Goodbye". Make use of the `Greeting` class `greet` method when implementing the `Hello` and `Goodbye` classes (don't use `puts`).

```ruby
class Greeting
  def greet(string)
    puts string
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

5. You are given the following class that has been implemented:

```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end
```

And the following specification of expected behavior:

```ruby
donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "Chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  => "Plain"

puts donut2
  => "Vanilla"

puts donut3
  => "Plain with sugar"

puts donut4
  => "Plain with chocolate sprinkles"

puts donut5
  => "Custard with icing"
```

Write additional code for `KrispyKreme` such that the `puts` statements will work as specified above.

```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    type = @filling_type ? @filling_type : "Plain"
    topping = "with #{@glazing}" if @glazing
    "#{type} #{topping}
  end
end
```

6. If we have these two versions of the `Computer` class, what is the difference in the way the code works?

```ruby
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end
```

Both versions of `create_template` do the same thing, set the `@template` instance variable to the provided string. However they do it in different ways.
The first version assigns the string directly to the instance variable. The second version uses the setter method `template=` created by the `attr_accessor`.
Both versions of `show_template` do the same thing: they call the getter method `template` created by the `attr_accessor`. The second version just puts an explicit `self` before the method call (this is unnecessary).

7. How could you change the method name below so that the method name is more clear and less repetitive?

```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end
```

I would change the name of `light_status` to `status`. The `light` is unnecessary, since the class is `Light` and instances of it are likely to have `light` in their names as well. Therefore, including `light` in the method name is redundant.
