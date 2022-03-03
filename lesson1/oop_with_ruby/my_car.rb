=begin
1. Create a class called MyCar. When you initialize a new instance or object of
the class, allow the user to define some instance variables that tell us the
year, color, and model of the car. Create an instance variable that is set to 
`0` during instantiation of the object to track the current speed of the car as
well. Create instance methods that allow the car to speed up, brake, and shut
the car off.
2. Add an accessor method to your MyCar class to change and view the color of
your car. Then add an accessor method that allows you to view, but not modify,
the year of your car.
3. You want to create a nice interface that allows you to accurately describe the 
action you want your program to perform. Create a method called `spray_paint`
that can be called on an object and will modify the color of the car.
4. Add a class method to your MyCar class that calculates the gas mileage of any
car.
5. Override the `to_s` method to create a user-friendly print out of your object.
6. Create a superclass called `Vehicle` for your `MyCar` class to inherit from
and move the behavior that isn't specific to `MyCar` to the superclass. Create a
constant in your `MyCar` class that stores information about the vehicle that
makes it different from other types of Vehicles.
Then create a new class called MyTruck that inherits from your superclass, with
its own constant defined that separates it from the MyCar class in some way.
7. Add a class variable to your superclass that can keep track of the number of
objects created that inherit from the superclass. Create a method to print out
the value of this class variable as well.
8. Create a module that you can mix in to ONE of your subclasses that describes
a behavior unique to that subclass.
9. Print to the screen your method lookup for the classes that you have created.
10. Move all of the methods from the MyCar class that also pertain to the MyTruck
class into the Vehicle class. Make sure that all of your previous method calls
are working when you are finished.
11. Write a method called `age` that calls a private method to calculate the age
of the vehicle. Make sure the private method is not available from outside of the
class. You'll need to use Ruby's built-in Time class to help.
end
=end

module Haulable
  def haul_trailer
    puts "Your trailer is connected."
  end
end

class Vehicle
  CURRENT_YEAR = Time.now.year
  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def self.total_number_of_vehicles
    puts "The total number of vehicles is #{@@number_of_vehicles}."
  end

  def self.mileage(gallons, miles)
    puts "#{miles/gallons} mpg"
  end

  def initialize(year, model, color)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def age
    puts "Your #{model} is #{years_old} years old."
  end

  def accelerate(number)
    @current_speed += number
    puts "You accelerated by #{number} mph. Your speed is now #{@current_speed} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You slowed down by #{number} mph. Your speed is now #{@current_speed} mph."
  end

  def current_speed
    puts "Your current speed is #{@current_speed} mph."
  end

  def shut_off
    current_speed = 0
    puts "You have turned off the car."
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def to_s
    "A #{year} #{color} #{model}"
  end

  private

  def years_old
    CURRENT_YEAR - self.year.to_i
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  include Haulable

  NUMBER_OF_DOORS = 2
end

my_car = MyCar.new('2010', 'Honda Fit', 'blue')
my_truck = MyTruck.new('2022', 'Kia Sorrento', 'red')

my_car.accelerate(20)
my_car.current_speed
my_car.brake(10)
my_car.current_speed
my_car.shut_off
my_car.spray_paint("silver")
puts my_car
puts my_car.age

MyCar.mileage(12, 350)

puts "---MyCar Method Lookup Path---"
puts MyCar.ancestors
puts ""
puts "---MyTruck Method Lookup Path---"
puts MyTruck.ancestors
puts ""
puts "---Vehicle Method Lookup Path---"
puts Vehicle.ancestors