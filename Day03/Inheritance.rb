class Vehicle
  def start
    puts "Vehicle started"
  end
end

class Car < Vehicle
  def drive
    puts "Car is driving"
  end
end

class Bike < Vehicle
end

vehicle = Vehicle.new
car = Car.new
bike = Vehicle.new

vehicle.start
car.start
car.drive
bike.start
