class Transaction
  attr_accessor :id, :customer_id, :acc_no, :type, :amount, :date

  def initialize(id, customer_id, acc_no, type, amount)
    @id = id
    @customer_id = customer_id
    @acc_no = acc_no
    @type = type
    @amount = amount
    @date = Time.now
  end
  def to_s
    "{Transaction ID: #{@id}, Customer ID: #{@customer_id}, Account No: #{@acc_no}, Type: #{@type}, Amount: #{@amount}, Date: #{@date}}"
  end
end