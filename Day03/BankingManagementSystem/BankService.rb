require_relative 'customer'
require_relative 'bankaccount'
require_relative 'transaction'
require_relative 'loan'

class BankService
  
  @accounts = {}
  @customer = {}
  @transactions = {}
  @loan = {}

  # =========== Helper Methods ================

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

  def self.account_type?(account, type)
    account.type == type
  end

  def self.check_pin?(acc)
    puts "Please enter Acc PIN"
    pin = gets.chomp.to_i
    acc.pin == pin
  end

  def self.create_transaction(id, acc_no, type, amount)
    tran_id = @transactions.empty? ? 1 : @transactions.keys.max + 1
    @transactions[tran_id] = Transaction.new(tran_id,id,acc_no,type,amount)
    puts "Transaction -> #{@transactions[tran_id]}"
  end

  # =========== Functionality Methods ================

  def self.register_customer
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
        puts "Minimum age limit is 18"
        return
      elsif age > 120
        puts "Maximum age limit is 120"
        return
      else
        break
      end
    end
    mobile=""
    loop do
      puts "Enter customer phone number:"
      mobile = gets.chomp
      unless mobile.match?(/^\d{10}$/)
        puts "Invalid phone number! Enter exactly 10 digits."
        next
      end
      if @customer.values.any? { |cust| cust.mobile == mobile }
        puts "Mobile number already registered! Enter different number."
      else
        break
      end
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
    puts "{Customer Details -> #{@customer[id]}}"
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
        type = BankAccount::SAVINGS
        break
      when 2
        type = BankAccount::CURRENT
        break
      when 3
        type = BankAccount::LOAN
        break
      else
        puts "Invalid option! Please select 1, 2 or 3."
      end
    end

    accounts = @accounts.values.select{ |acc| acc.customer_id == id }
    if accounts.any? { |a| a.type == type }
      puts "You already have a #{type} account in QuickBank!"
      return
    end

    pin = ""
    loop do
      puts "Create 4 digit PIN"
      pin = gets.chomp

      if pin.match?(/^\d{4}$/)
        pin = pin.to_i
        break
      else
        puts "Invalid PIN! Please enter exactly 4 digits."
      end
    end

    amount = 0
    unless type == BankAccount::LOAN
      loop do
        puts "Enter Minimum deposit of 1000 RS."
        input = gets.chomp

        if input.match?(/^\d+$/) && input.to_i >= 1000
          amount = input.to_i
          break
        else
          puts "Invalid amount! Deposit must be at least 1000 Rs."
        end
      end
    end

    bank_account = BankAccount.new(type,id,pin,amount)
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
        return puts "You entered wrong pin" unless check_pin?(acc)
        acc.status = BankAccount::ACTIVE
        puts "Account #{acc.acc_no} Activated"
      end
    when 2
      if acc.status == BankAccount::DEACTIVE
        puts "Account already Deactive"
      else
        if acc.balance > 0 && acc.type == BankAccount::LOAN
          puts "Please clear your loan first"
          return
        end
        return puts "You entered wrong pin" unless check_pin?(acc)
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
    return puts "You can't deposit into your loan account" if account_type?(acc,BankAccount::LOAN)
    
    puts "Enter amount"
    amount = gets.to_f
    return puts "Invalid amount" if amount <= 0

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
    return puts "You can't withdraw from your loan account" if account_type?(acc,BankAccount::LOAN)

    puts "Enter amount"
    amount = gets.to_f
    return puts "Invalid amount" if amount <= 0

    if acc.balance < amount
      puts "Insufficient Balance"
      return
    end

    return puts "You entered wrong pin" unless check_pin?(acc)

    acc.balance -= amount
    puts "Withdraw successful"

    create_transaction(id, acc.acc_no, "withdraw", amount)
  end

  def self.check_balance
    id = get_customer
    return unless id

    accounts = get_accounts(id)
    return unless accounts

    acc = choose_account(accounts)
    return unless acc

    return puts "You entered wrong pin" unless check_pin?(acc)

    return puts "Your loan amount is #{acc.balance}" if account_type?(acc,BankAccount::LOAN)
    return puts "Your balance is #{acc.balance}"
  end

  def self.transfer
    id = get_customer
    return unless id

    accounts = get_accounts(id)
    return unless accounts

    puts "Select Sender Account"
    sender = choose_account(accounts)
    return unless sender
    return puts "You can't tranfer from your loan account" if account_type?(sender,BankAccount::LOAN)
    return unless active_account?(sender)

    puts "Enter Receiver Account No"
    receiver = @accounts[gets.to_i]

    return puts "Receiver not found" unless receiver
    return puts "You can't transfer into receiver's loan account" if account_type?(receiver,BankAccount::LOAN)

    puts "Enter Amount"
    amount = gets.to_f
    return puts "Invalid amount" if amount <= 0

    if sender.balance < amount
      puts "Insufficient Balance in your account"
      return
    end

    return puts "You entered wrong pin" unless check_pin?(sender)

    sender.balance -= amount
    receiver.balance += amount

    puts "Transfer Successful"

    create_transaction(id, sender.acc_no, "transfer", amount)
  end

  def self.show_transaction
    id = get_customer
    return unless id

    result = @transactions.values.select {|tran| tran.customer_id == id}
    return puts "No transaction found for customers" if result.empty? 

    puts "---------- All Transactions ----------"
    result.each do |t|
      puts "Customer Id : #{t.customer_id}"
      puts "Account No  : #{t.acc_no}"
      puts "Type        : #{t.type}"
      puts "Amount      : #{t.amount}"
      puts "Date        : #{t.date}"
      puts "------------------------------------"
    end
  end

  def self.get_loan
    id = get_customer
    return unless id

    result = @accounts.values.select { |acc| acc.customer_id == id && acc.type == BankAccount::LOAN }
    return "No loan account found for this customer" if result.empty?
    
    puts "Your Loan Accounts:"
    result.each { |acc| puts acc }

    acc = choose_account(result)
    return unless acc
    return unless active_account?(acc)
    return puts "You already have loan in you account!" if acc.balance > 0

    amount = 0
    loop do
      puts "Enter loan amount"
      amount = gets.chomp.to_f
      if amount < 1000 || amount > 500000
        puts "Loan amount must be between 1000 and 5 Lacs"
      else
        break
      end
    end
    
    return puts "You entered wrong pin, please try again" unless check_pin?(acc)

    puts "------------------------------"
    puts "Your loan amount is #{amount}"
    puts "You can make EMI for:- "
    puts "-> 6 Months"
    puts "-> 12 Months"
    puts "-> 18 Months"
    puts "-> 24 Months"
    puts "-> 36 Months"
    puts "-> Enter no of months (6,12,18,24,36) you want to make EMI."
    month = gets.chomp.to_i
    return puts "You entered wrong input" unless month == 6 || month == 12 || month == 18 || month == 24 || month == 36

    puts "Enter Annual Interest Rate (%)"
    rate = gets.chomp.to_f

    p = amount
    n = month
    r = rate / (12 * 100)

    emi = ((p * r * (1 + r)**n) / ((1 + r)**n - 1)).round(2)
    acc.balance += emi*n
    puts "Loan of #{amount} approved for Account #{acc.acc_no}"
    loan = Loan.new(id,acc.acc_no,emi*n,emi,month,0,month)
    puts @loan[loan.loan_id] = loan

    puts "--------------------------------"
    puts "Your Monthly EMI is: #{emi}"
    puts "Total Payable Amount: #{(emi * month)}"
  end

  def self.loan_foreclosure
    id = get_customer
    return unless id

    accounts = get_accounts(id)
    return unless accounts

    result = @accounts.values.select { |acc| acc.customer_id == id && acc.type == BankAccount::LOAN }
    return "No loan account found for this customer" if result.empty?

    acc = choose_account(accounts)
    return unless acc

    puts "You have loan of #{acc.balance}"
    puts "Choose Account No you want to pay from"
    acc2 = choose_account(accounts)
    return unless acc2
    return unless active_account?(acc2)
    return puts "You can't clear your loan from your loan account" if account_type?(acc2,BankAccount::LOAN)

    return puts "Insufficient balance for clear loan" unless acc2.balance > acc.balance

    loan_amount = acc.balance
    acc2.balance -= loan_amount
    acc.balance = 0

    puts "Congrats! You have cleared your Loan in Acc #{acc.acc_no}"

    create_transaction(id, acc.acc_no, "loan_cleared", loan_amount)
  end

  def self.pay_emi
    id = get_customer
    return unless id

    loan_accounts = @accounts.values.select do |acc|
      acc.customer_id == id && acc.type == BankAccount::LOAN
    end

    if loan_accounts.empty?
      puts "No loan account found"
      return
    end

    puts "Your Loan Accounts:"
    loan_accounts.each { |a| puts a }

    loan_acc = choose_account(loan_accounts)
    return unless loan_acc
    return unless active_account?(loan_acc)

    loan = @loan.values.find { |l| l.acc_no == loan_acc.acc_no }
    return puts "Loan record not found" unless loan

    return puts "Loan already cleared!" if loan.emi_pending == 0

    puts "Your EMI amount is: #{loan.per_emi}"
    puts "Remaining EMI: #{loan.emi_pending}"

    puts "You have #{loan.emi_pending} EMI pending."
    puts "How much EMI you want to pay:"
    no = gets.chomp.to_i

    if no <= 0 || no > loan.emi_pending
      puts "Invalid EMI count"
      return
    end

    puts "-----------------------------------"
    puts "Select account to pay EMI from"

    accounts = get_accounts(id)
    return unless accounts

    pay_acc = choose_account(accounts)
    return unless pay_acc
    return unless active_account?(pay_acc)

    if account_type?(pay_acc, BankAccount::LOAN)
      puts "You cannot pay EMI from loan account"
      return
    end

    total_amount = no * loan.per_emi

    if pay_acc.balance < total_amount
      puts "Insufficient balance"
      return
    end

    puts "Enter PIN"
    return puts "Wrong PIN" unless check_pin?(pay_acc)

    pay_acc.balance = (pay_acc.balance - total_amount).round(2)
    loan_acc.balance = (loan_acc.balance - total_amount).round(2)

    loan.emi_paid += no
    loan.emi_pending -= no
    loan.loan_amount = (loan.loan_amount - total_amount).round(2)

    if loan.emi_pending == 0
      loan.loan_amount = 0
      loan_acc.balance = 0
      puts "Congrats!! Loan Fully Paid"
    end

    puts "-----------------------------------"
    puts "EMI Paid Successfully!"
    puts "EMI Paid: #{loan.emi_paid}"
    puts "Remaining EMI: #{loan.emi_pending}"
    puts "Remaining Loan Amount: #{loan.loan_amount}"

    create_transaction(id, pay_acc.acc_no, "emi_payment", total_amount)
  end

  def self.calculate_emi
    id = get_customer
    return unless id

    accounts = @accounts.values.select { |a| a.customer_id == id && a.type == BankAccount::LOAN }
    return puts "No loan account found" if accounts.empty?
    accounts.each { |a| puts a }
    acc = choose_account(accounts)
    return unless acc
    return puts "This is not a LOAN account" unless account_type?(acc,BankAccount::LOAN)
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
  end

  # ============ Queries ================

  # List all Loan entities where the principal_amount is greater than 5x the total balance of the customer account.

  def self.risky_customer
    result = @loan.values.select do |loan|
      account = @accounts.values.find {|acc| acc.customer_id == loan.customer_id && acc.type == BankAccount::SAVINGS}

      account &&  loan.loan_amount > (5 * account.balance)
    end

    if result.empty?
      puts "No customers found whose loan > 5x account balance"
    else
      result.each { |loan| puts loan }
    end
  end
end

while true
  puts "----------------------------------------------------"
  puts "----------- Welcome to QuickBank -------------------"
  puts "0. EXIT"
  puts "1. Register New User"
  puts "2. Create new account"
  puts "3. Activate/Deactivate Account"
  puts "4. Deposit money"
  puts "5. Withdraw money"
  puts "6. Check Balance"
  puts "7. Transfer money"
  puts "8. Transactions history"
  puts "9. Get Loan (We only provide LOAN only in loan account)"
  puts "10. Loan Foreclosure"
  puts "11. Pay EMI"
  puts "12. EMI Calculator"
  puts "13. Risky customer -> (Loan) > 5*(Amount in Savings)"
  puts "----------------------------------------"

  num=""
  puts "Enter the number"
  loop do
    input = gets.chomp
    break num = input.to_i if input.match?(/^\d+$/) && input.to_i.between?(0,13)
    puts "Please enter a number between 0 and 13"
  end

  case num
  when 0 then break
  when 1 then BankService.register_customer
  when 2 then BankService.create_account
  when 3 then BankService.active_deactive_account
  when 4 then BankService.deposit
  when 5 then BankService.withdraw
  when 6 then BankService.check_balance
  when 7 then BankService.transfer
  when 8 then BankService.show_transaction
  when 9 then BankService.get_loan
  when 10 then BankService.loan_foreclosure
  when 11 then BankService.pay_emi
  when 12 then BankService.calculate_emi
  when 13 then BankService.risky_customer
  else puts "Invalid Input"
  end
end