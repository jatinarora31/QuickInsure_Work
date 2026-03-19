class BankAccount
  @@acc_counter = 1000
  attr_accessor :acc_no, :balance, :customer_id, :status, :type, :pin, :created_at

  SAVINGS = "savings"
  CURRENT = "current"
  LOAN = "loan"

  ACTIVE = "Active"
  DEACTIVE = "Deactive"

  def initialize(type,customer_id,pin,amount)
    @@acc_counter += 1
    @acc_no = @@acc_counter
    @type = type
    @pin = pin
    @balance = amount
    @customer_id = customer_id
    @status = ACTIVE
    @created_at = Time.now
  end

  def to_s
    "{AccNo: #{@acc_no}, PIN: #{@pin}, CustomerId: #{@customer_id}, Type: #{@type}, Balance: #{@balance}, Status: #{@status}, Created At: #{@created_at}}"
  end
end