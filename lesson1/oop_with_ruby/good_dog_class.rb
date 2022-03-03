module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "I'm an animal, and I speak!"
  end

  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable

  attr_accessor :name

  def initialize(color, name)
    super(name)
    @color = color
  end

  def speak 
    super + " from GoodDog class"
  end
end

class Cat < Animal
end

fido = Animal.new('Fido')
p fido.a_public_method
p Animal.superclass