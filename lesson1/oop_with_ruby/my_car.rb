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
=end

class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def self.mileage(gallons, miles)
    puts "#{miles/gallons} mpg"
  end

  def initialize(year, model, color)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def accelerate(number)
    @current_speed += number
    puts "You accelerated by #{number} mph. Your speed is now #{@current_speed} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You slowed down by #{number} mph. Your speed is now #{@current_speed} mph."
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
    "A #{color} #{year} #{model}"
  end
end

honda = MyCar.new(2010, "honda fit", "blue")
honda.accelerate(20)
honda.accelerate(20)
honda.brake(20)
honda.brake(20)
honda.shut_off
puts honda.color
honda.spray_paint("black")
puts honda.color
puts honda.year

puts honda

puts MyCar.mileage(15, 351)