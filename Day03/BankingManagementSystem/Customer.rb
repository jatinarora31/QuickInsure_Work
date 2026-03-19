class Customer
  attr_accessor :name, :age, :mobile, :city

  def initialize(name,age,mobile,city)
    @name = name
    @age = age
    @mobile = mobile
    @city = city
  end

  def to_s
    "{Name: #{@name}, Age: #{@age}, Mobile: #{@mobile}, City: #{@city}}"
  end
end