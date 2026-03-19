class Loan
  @@loan_counter = 0
  attr_accessor :loan_id, :customer_id, :acc_no, :loan_amount, :per_emi, :tenure, :emi_paid, :emi_pending, :created_at

  def initialize(customer_id,acc_no,loan_amount,per_emi,tenure,emi_paid,emi_pending)
    @@loan_counter += 1
    @loan_id = @@loan_counter
    @customer_id = customer_id
    @acc_no = acc_no
    @loan_amount = loan_amount
    @per_emi = per_emi
    @tenure = tenure
    @emi_paid = emi_paid
    @emi_pending = emi_pending
    @created_at = Time.now
  end

  def to_s
    "{ Loan Id: #{@loan_id}, Customer Id: #{@customer_id}, AccNo: #{@acc_no}, Loan Amount: #{@loan_amount}, Per EMI: #{@per_emi}, Tenure: #{@tenure}, EMI Paid: #{@emi_paid}, EMI Pending: #{@emi_pending}, Created At: #{@created_at} }"
  end
end