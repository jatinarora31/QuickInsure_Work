# Send method

# class Calculator
#   private
#   def add(a,b)
#     a+b
#   end
# end

# calc = Calculator.new
# result = calc.send(:add,5,3)
# puts result

# ---------------------------------------------

# User class with send method

class User
  attr_accessor :name, :email, :role

  def initialize(name, email, role)
    @name = name
    @email = email
    @role = role
  end
end

def find_by_attribute(users, attribute, value)
  users.select {|user| user.send(attribute) == value}
end

users = [
  User.new('Alice', 'alice@gmail.com', 'admin'),
  User.new('Bob', 'bob@gmail.com', 'user'),
  User.new('Charlie', 'charlie@gmail.com', 'admin')
]

admins = find_by_attribute(users,:role,'admin')
admins.each {|user| puts user.name}
    
