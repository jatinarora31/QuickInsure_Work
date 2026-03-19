$accounts = {}

def separator
  puts "----------------------------------------"
end

def find_account(acc_no)
  $accounts.values.find { |acc| acc[:acc_no] == acc_no }
end

def no_account(acc_no)
  separator
  puts "No account found with acc_no #{acc_no}"
  separator
end

def valid_amount
  loop do
    amount = gets.chomp.to_f
    return amount if amount > 0
    puts "Invalid amount! Enter amount greater than 0"
  end
end

def create_new_account
  id = $accounts.empty? ? 1 : $accounts.keys.max + 1
  acc_no = $accounts.empty? ? 101 : $accounts.values.last[:acc_no] + 1

  puts "Enter customer name:"
  name = gets.chomp

  puts "Enter age:"
  age = gets.chomp.to_i

  puts "Enter phone number:"
  mobile = gets.chomp

  unless mobile.match?(/^\d{10}$/)
    puts "Invalid phone number!"
    return
  end

  $accounts[id] = {
    acc_no: acc_no,
    total_balance: 0,
    loan: 0,
    customer: {
      name: name,
      age: age,
      mobile: mobile
    }
  }

  separator
  puts "Account created successfully with AccNo #{acc_no}"
  separator
end

def get_account
  puts "Enter account number:"
  acc_no = gets.chomp.to_i

  account = find_account(acc_no)

  if account
    p account
  else
    no_account(acc_no)
  end
end

def deposit_money 
  puts "Enter account number:"
  acc_no = gets.chomp.to_i

  account = find_account(acc_no)
  return no_account(acc_no) unless account

  puts "Enter amount to deposit:"
  amount = valid_amount

  account[:total_balance] += amount

  separator
  puts "Deposited #{amount} successfully"
  puts "Current Balance: #{account[:total_balance]}"
  separator
end

def withdraw_money
  puts "Enter account number:"
  acc_no = gets.chomp.to_i

  account = find_account(acc_no)
  return no_account(acc_no) unless account

  puts "Enter amount to withdraw:"
  amount = valid_amount

  if amount > account[:total_balance]
    separator
    puts "Insufficient Balance"
    puts "Current Balance: #{account[:total_balance]}"
    separator
    return
  end

  account[:total_balance] -= amount

  separator
  puts "Withdraw successful"
  puts "Remaining Balance: #{account[:total_balance]}"
  separator
end

def transfer_money
  puts "Enter sender account:"
  sender_acc = gets.chomp.to_i

  sender = find_account(sender_acc)
  return no_account(sender_acc) unless sender

  puts "Enter receiver account:"
  receiver_acc = gets.chomp.to_i

  receiver = find_account(receiver_acc)
  return no_account(receiver_acc) unless receiver

  puts "Enter amount:"
  amount = valid_amount

  if sender[:total_balance] < amount
    separator
    puts "Insufficient balance"
    separator
    return
  end

  sender[:total_balance] -= amount
  receiver[:total_balance] += amount

  separator
  puts "Transfer successful"
  puts "Sender Balance: #{sender[:total_balance]}"
  puts "Receiver Balance: #{receiver[:total_balance]}"
  separator
end

def get_loan
 puts "Enter account number:"
  acc_no = gets.chomp.to_i

  account = find_account(acc_no)
  return no_account(acc_no) unless account

  if account[:loan] > 0
    puts "Loan already exists: #{account[:loan]}"
    return
  end

  puts "Enter loan amount:"
  amount = valid_amount

  account[:loan] = amount

  separator
  puts "Loan #{amount} granted"
  separator
end

def get_emi
  puts "Enter account number:"
  acc_no = gets.chomp.to_i

  account = find_account(acc_no)
  return no_account(acc_no) unless account

  if account[:loan] == 0
    puts "No loan for this account"
    return
  end

  total = account[:loan] * 1.1
  emi = total / 12

  separator
  puts "Monthly EMI: #{emi.round(2)} for 12 months"
  separator
end


while true
  separator
  puts "0. EXIT"
  puts "1. Create Account"
  puts "2. Get Account Details"
  puts "3. Deposit"
  puts "4. Withdraw"
  puts "5. Transfer Money"
  puts "6. Get Loan"
  puts "7. EMI"
  separator

  puts "Enter the number"
  begin
    num = Integer(gets.chomp)
  rescue
    separator
    puts "Invalid input! Please enter only numbers."
    separator
  end

  case num
  when 0 then break
  when 1 then create_new_account
  when 2 then get_account
  when 3 then deposit_money
  when 4 then withdraw_money
  when 5 then transfer_money
  when 6 then get_loan
  when 7 then get_emi
  else
    puts "Invalid Input"
  end
end
