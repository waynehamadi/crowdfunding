class PaymentsController < ApplicationController
  def payment
    @contribution = Contribution.find_by_mango_pay_id(params['transactionId'])
    transaction = VerifyPayment.new.call(contribution: @contribution)
    if transaction.failure
      flash[:error] = transaction.failure[:error]
    else
      flash[:success] = 'Payment succeeded'
    end
    redirect_to(project_path(@contribution.project))
  end
end
