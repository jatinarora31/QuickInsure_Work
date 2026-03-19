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

class BankAccount
  @@acc_counter = 1000
  attr_accessor :acc_no, :balance, :customer_id, :status, :type
  ACTIVE = "Active"
  DEACTIVE = "Deactive"

  def initialize(type,customer_id)
    @@acc_counter += 1
    @acc_no = @@acc_counter
    @type = type
    @balance = 0.0
    @customer_id = customer_id
    @status = ACTIVE
  end

  def to_s
    "{AccNo: #{@acc_no}, CustomerId: #{@customer_id}, Type: #{@type}, Balance: #{@balance}, Status: #{@status}}"
  end
end


class BankSystem
  
  @accounts = {}
  @customer = {}
  @transactions = {}

  def self.get_customer
    puts "Enter customer Id"
    id = gets.to_i

    customer = @customer[id]

    unless customer
      puts "Customer not found"
      return nil
    end
    id
  end

  def self.get_accounts(id)
    accounts = @accounts.values.select { |acc| acc.customer_id == id }
    if accounts.empty?
      puts "No accounts found for this customer"
      return nil
    end

    puts "Your Accounts:"
    accounts.each { |acc| puts acc }
    accounts
  end

  def self.choose_account(accounts)
    puts "Enter Account No"
    acc_no = gets.to_i
    acc = accounts.find { |a| a.acc_no == acc_no }

    unless acc
      puts "Invalid Account Number"
      return nil
    end
    acc
  end

  def self.active_account?(acc)
    if acc.status == "Deactive"
      puts "Account is deactivated"
      return false
    end
    true
  end

  def self.create_transaction(id, acc_no, type, amount)
    tran_id = @transactions.empty? ? 1 : @transactions.keys.max + 1

    @transactions[tran_id] = {
      customer_id: id,
      AccNo: acc_no,
      type: type,
      amount: amount,
      date: Time.now
    }

    puts "Transaction -> #{@transactions[tran_id]}"
  end

  def self.register_customer()
    name=""
    loop do
      puts "Enter customer name:"
      name = gets.chomp
      break unless name.empty?
      puts "Name cannot be empty. Please enter again."
    end
    age=0
    loop do
      puts "Enter customer age:"
      age = gets.chomp.to_i
      if age < 17
        puts "You are under age (Minimum age is 18)"
        return
      elsif age > 101
        puts "You are above age (Maximum age is 100)"
        return
      else
        break
      end
    end
    mobile=""
    loop do
      puts "Enter customer phone number:"
      mobile = gets.chomp
      break if mobile.match?(/^\d{10}$/)
      puts "Invalid phone number! Enter exactly 10 digits."
    end
    city=""
    loop do
      puts "Enter your city:"
      city = gets.chomp
      break unless city.empty?
      puts "City cannot be empty. Please enter again"
    end
    id = @customer.empty? ? 1 : @customer.keys.max + 1
    @customer[id] = Customer.new(name,age,mobile,city)
    puts "------------------------------"
    puts "User Registered successfully"
    puts "{Customer Id -> #{id}}"
    puts "{Customer Details -> #{@customer[id]}"
  end

  def self.create_account
    id = get_customer
    return unless id
    puts "------------------------------"
    puts "Press 1 for Savings Account"
    puts "Press 2 for Current Account"
    puts "Press 3 for Loan Account"
    type=""
    loop do
      print "Press -> "
      choice = gets.chomp.to_i
      case choice
      when 1
        type = "savings"
        break
      when 2
        type = "current"
        break
      when 3
        type = "loan"
        break
      else
        puts "Invalid option! Please select 1, 2 or 3."
      end
    end

    bank_account = BankAccount.new(type,id)
    @accounts[bank_account.acc_no] = bank_account
    puts "Account created successfully with account number --> #{bank_account.acc_no}"
    puts @accounts[bank_account.acc_no]
  end

  def self.active_deactive_account
    id = get_customer
    return unless id

    accounts = get_accounts(id)
    return unless accounts

    acc = choose_account(accounts)
    return unless acc

    puts "Press 1 for Activate"
    puts "Press 2 for Deactivate"
    print "Press ->   "
    choice = gets.chomp.to_i

    case choice
    when 1
      if acc.status == "Active"
        puts "Account already Active"
      else
        acc.status = BankAccount::ACTIVE
        puts "Account #{acc.acc_no} Activated"
      end
    when 2
      if acc.status == BankAccount::DEACTIVE
        puts "Account already Deactive"
      else
        acc.status = "Deactive"
        puts "Account #{acc.acc_no} Deactivated"
      end
    end
  end

  def self.deposit
    id = get_customer
    return unless id

    accounts = get_accounts(id)
    return unless accounts

    acc = choose_account(accounts)
    return unless acc
    return unless active_account?(acc)

    puts "Enter amount"
    amount = gets.to_f

    acc.balance += amount
    puts "Amount #{amount} deposited successfully"

    create_transaction(id, acc.acc_no, "deposit", amount)
  end

  def self.withdraw
    id = get_customer
    return unless id

    accounts = get_accounts(id)
    return unless accounts

    acc = choose_account(accounts)
    return unless acc
    return unless active_account?(acc)

    puts "Enter amount"
    amount = gets.to_f

    if acc.balance < amount
      puts "Insufficient Balance"
      return
    end

    acc.balance -= amount
    puts "Withdraw successful"

    create_transaction(id, acc.acc_no, "withdraw", amount)
  end

  def self.transfer
    id = get_customer
    return unless id

    accounts = get_accounts(id)
    return unless accounts

    puts "Select Sender Account"
    sender = choose_account(accounts)
    return unless sender
    return unless active_account?(sender)

    puts "Enter Receiver Account No"
    receiver = @accounts[gets.to_i]

    unless receiver
      puts "Receiver not found"
      return
    end

    puts "Enter Amount"
    amount = gets.to_f

    if sender.balance < amount
      puts "Insufficient Balance"
      return
    end

    sender.balance -= amount
    receiver.balance += amount

    puts "Transfer Successful"

    create_transaction(id, receiver.acc_no, "transfer", amount)
  end

  def self.transaction
    id = get_customer
    return unless id

    result = @transactions.values.select {|tran| tran[:customer_id] == id}
    return puts "No transaction found for customers" if result.empty? 

    puts "------ All Transactions ------"
    result.each do |t|
      puts "Customer Id : #{t[:customer_id]}"
      puts "Account No  : #{t[:AccNo]}"
      puts "Type        : #{t[:type]}"
      puts "Amount      : #{t[:amount]}"
      puts "Date        : #{t[:date]}"
      puts "-----------------------------"
    end
  end

  def self.loan
    id = get_customer
    return unless id

    result = @accounts.values.select { |acc| acc.customer_id == id && acc.type == "loan" }
    return "No loan account found for this customer" if result.empty?
    
    puts "Your Loan Accounts:"
    result.each { |acc| puts acc }

    acc = choose_account(result)
    return unless acc
    return unless active_account?(acc)

    amount = 0
    loop do
      puts "Enter loan amount"
      amount = gets.chomp.to_f
      break if amount > 0
      puts "Loan amount must be greater than 0"
    end

    acc.balance += amount
    puts "Loan of #{amount} approved for Account #{acc.acc_no}"
    puts "Updated Balance: #{acc.balance}"

    create_transaction(id, acc.acc_no, "loan", amount)
  end

  def self.emi
    id = get_customer
    return unless id

    accounts = @accounts.values.select { |a| a.customer_id == id && a.type == "loan" }
    return puts "No loan account found" if accounts.empty?
    accounts.each { |a| puts a }
    acc = choose_account(accounts)
    return unless acc
    return unless active_account?(acc)

    puts "Enter Loan Amount"
    p = gets.to_f
    puts "Enter Annual Interest Rate (%)"
    rate = gets.to_f
    puts "Enter Tenure (months)"
    n = gets.to_i
    r = rate / (12 * 100)
    emi = (p * r * (1 + r)**n) / ((1 + r)**n - 1)
    puts "Your EMI: #{emi.round(2)} per month"
    create_transaction(id, acc.acc_no, "EMI", emi)
  end
end


while true
  puts "----------------------------------------"
  puts "0. EXIT"
  puts "1. Register New User"
  puts "2. Create new account"
  puts "3. Activate/Deactivate Account"
  puts "4. Deposit money"
  puts "5. Withdraw money"
  puts "6. Transfer money"
  puts "7. See all Transactions"
  puts "8. Get Loan"
  puts "9. Get EMI of Loan"
  puts "----------------------------------------"

  puts "Enter the number"
  begin
    num = gets.chomp.to_i
  rescue
    puts "------------------------------------------"
    puts "Invalid input! Please enter only numbers."
    puts "------------------------------------------"
  end

  case num
  when 0 then break
  when 1 then BankSystem.register_customer
  when 2 then BankSystem.create_account
  when 3 then BankSystem.active_deactive_account
  when 4 then BankSystem.deposit
  when 5 then BankSystem.withdraw
  when 6 then BankSystem.transfer
  when 7 then BankSystem.transaction
  when 8 then BankSystem.loan
  when 9 then BankSystem.emi
  else puts "Invalid Input"
  end
end
