class VerifyPayment
  include Dry::Transaction
  tee  :initialize_payment
  step :validate_payment

  private

  def initialize_payment(input)
    @contribution = input[:contribution]
    @pay_in = MangoPay::PayIn.fetch(@contribution.mango_pay_id)
    @state = @pay_in['Status']
  end

  def validate_payment(input)
    if @state == 'SUCCEEDED'
      @contribution.update(aasm_state: 'paid')
      Success(input)
    else
      @contribution.update(aasm_state: 'canceled')
      Failure(input.merge(error: 'Payment failed'))
    end
  end
end
