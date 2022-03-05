# Class-based inheritance works great when it's used to model hierarchical domains.

# 1. Given this class, create a sub-class called `Bulldog`, overriding the `swim`
# method to return "can't swim!"

# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end
# end

# class Bulldog < Dog
#   def swim
#     "can't swim!"
#   end
# end

# teddy = Dog.new
# puts teddy.speak
# puts teddy.swim

# karl = Bulldog.new
# puts karl.speak
# puts karl.swim

# 2. Given this `Dog` class, create a new class called `Cat`, which can do
# everything a dog can, except swim or fetch. Come up with a class hierarchy.

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end  
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run
# pete.speak

p kitty.run
p kitty.speak
# kitty.fetch

p dave.speak

p bud.run
p bud.swim

=begin
3. Draw a class hierarchy diagram of the classes from step #2

                                Pet
                                run
                                jump
                              /     \
                          Dog         Cat
                         speak       speak
                         fetch
                         swim
                        /
                  Bulldog
                   swim

4. What is the method lookup path and how is it important?
The method lookup path lays out the order of classes in which Ruby will look for
a method called on an object. It starts with the object's class, then any modules
included in that class, then works up through each classes superclass (and any
modules in those) until it gets to the BasicObject class. 
