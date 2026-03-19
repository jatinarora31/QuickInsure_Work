## ----- Getter & Setters -----------

# class Bank
#   def initialize(name, total_balance)
#     @total_balance = total_balance
#     @name = name 
#   end

#   def display
#     puts "#{@name} -> #{@total_balance}"
#     @name
#   end
  
#   def name=(name)
#     @name = name
#   end
# end
# bank = Bank.new("Jatin",30000)
# puts bank.display
# bank.name = "Rahul"
# puts.display


## --------- attr_accessor ---------------

# class Bank
#   attr_accessor :name, :total_balance
  
#   def initialize(name, total_balance)
#     @total_balance = total_balance
#     @name = name 
#   end

#   def display
#     puts "#{@name} -> #{@total_balance}"
#   end
# end
# bank = Bank.new("Jatin",30000)
# puts bank.display
# bank.name = "Rahul"
# puts bank.display


## ------------ class method and variables ------------
class Bank
  @@name = "Rahul"
  def self.display
    puts "#{@@name} -> 10000"
  end
end
Bank.display