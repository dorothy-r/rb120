# Below are some practice problems that test your knowledge of the connection
# between classes and objects.

# 1. Given the below usage of the Person class, code the class definition:

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
bob.name
bob.name = 'Robert'
bob.name

# 2. Modify the class definition from above to facilitate the following methods.
# Note that there is no `name=`` setter method now.

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    names = name.split
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end

  def name
    "#{self.first_name} #{self.last_name}".strip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

# 3. Now create a smart `name=` method that can take just a first name or a full
# name, and knows how to set the `first_name` and `last_name` appropriately.

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    parse_name(name)
  end

  def name
    "#{self.first_name} #{self.last_name}".strip
  end

  def name=(name)
    parse_name(name)
  end

  # We can move the redundant code from the `initialize` and `name=` methods to
  # its own private method.

  private
  
  def parse_name(name)
    names = name.split
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

# 4. Using the class definition from step 3, let's create a few more `Person`
# objects. If we're trying to determin whether the two objects contain the same
# name, how can we compare the two objects?

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name      # => true
# We can't compare whether two `Person` objects are the same (given the current
# class definition), but we can compare two `String` objects using `==`.

# 5. Continuing with our Person class definition, what does the below print out?

puts "The person's name is #{bob}"  # For bob, prints out a hex version of its object id

# Let's add a `to_s` method to the class:
class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    parse_name(name)
  end

  def name
    "#{self.first_name} #{self.last_name}".strip
  end

  def name=(name)
    parse_name(name)
  end

  private
  
  def parse_name(name)
    names = name.split
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end

  def to_s
    name
  end
end

# Now, what does this output?
puts "The person's name is #{bob}"   
# => "The person's name is Robert Smith."