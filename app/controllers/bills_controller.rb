class BillsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:hook]
  require 'date'
  def billing
    @contribution = Contribution.find(params[:contribution_id].to_i)
    @content = params[:content].to_enum.to_h
    transaction = CreateBill.new.call(
      contribution: @contribution,
      content: @content
    )
    @amount = transaction.success[:amount]
    @bic = transaction.success[:bic]
    @iban = transaction.success[:iban]
    @ref = transaction.success[:ref]
    @currency = transaction.success[:currency]
    @date = transaction.success[:date]
    @fees = transaction.success[:fees]
    @content = transaction.success[:content]

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'billing'
      end
    end
  end

  def hook
    HookReceive.new.call(parameters: params)
  end
end
