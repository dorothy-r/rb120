class GoodDog
  DOG_YEARS = 7

  @@number_of_dogs = 0

  def self.what_am_i
    "I'm a GoodDog class!"
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  attr_accessor :name, :height, :weight, :age

  def initialize(n, h, w, a)
    @@number_of_dogs += 1
    self.name = n
    self.height = h
    self.weight = w
    self.age = a * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end
end


sparky = GoodDog.new('Sparky', '24 in', '45 lb', 4)

sparky.change_info('Spartacus', '15 in', '20 lb')
p sparky.what_is_self
puts sparky