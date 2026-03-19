# module Greetings
#   def say_hello
#     puts "hello ji"
#   end
#   def say_good_bye
#     puts "bye ji"
#   end
# end

# class Person
#   include Greetings
# end
# person = Person.new
# person.say_hello
# person.say_good_bye




# module Animal
#   class Dog
#     def speak
#       puts "Woof!"
#     end
#   end
#   class Cat
#     def speak
#       puts "Meow!"
#     end
#   end
# end
# module Robot
#   class Dog
#     def speak
#       puts "Beep Beep!"
#     end
#   end
# end
# animal_dog = Animal::Dog.new
# robot_dog = Robot::Dog.new
# animal_cat =Animal::Cat.new

# animal_dog.speak
# robot_dog.speak
# animal_cat.speak



module Loggable
  def process_data
    puts "Logging: Starting data processing"
    super
    puts "Logging: Finished data processing"
  end
end

class DataProcessor
  prepend Loggable

  def process_data
    puts "Processing the actual data"
  end
end

class SimpleProcessor
  include Loggable

  def process_data
    puts "Simple processing"
    super rescue puts "No super method found"
  end
end

puts "With prepend:"
DataProcessor.new.process_data

puts "\nWith include:"
SimpleProcessor.new.process_data