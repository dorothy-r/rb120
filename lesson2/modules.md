# Modules

In Ruby, a class can only directly sub-class from one super class. This is called **single inheritance**.
This can sometimes lead to issues with repetitive code: if classes with different parent classes need the same method/functionality, do we need to repeat the method in each of those classes?
Ruby solves this problem by allowing us to mix in behaviors, using **modules**. A class can only have one direct super class, but it can mix in any number of modules.
Here is an example:

```ruby
module Swimmable
  def swim
    "swimming"
  end
end

class Dog
  include Swimmable
  # ... rest of class omitted
end

class Fish
  include Swimmable
  # ... rest of class omitted
end
```

Now all instance methods defined in `Swimmable` are available in both the `Dog` and `Fish` classes.
Mixing in modules does affect the method lookup path: Ruby will first look in the object's class, then in any of its included modules (in reverse order of how they were included), then in the superclass, etc.
We can use the `.ancestors` method to see a class's method lookup path.
