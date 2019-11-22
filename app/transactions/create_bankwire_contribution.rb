class CreateBankwireContribution
  include Dry::Transaction
  tee :new_contribution
  step :validate
  tee :create
  step :create_bankwire

  private

  def new_contribution(input)
    @contribution = input[:contribution]
  end

  def validate(input)
    if @contribution.valid?
      Success(input)
    else
      Failure(input.merge( error: @contribution.errors))
    end
  end

  def create(_input)
    @contribution.save
  end

  def create_bankwire(input)
    bankwire = MangoPay::PayIn::BankWire::Direct.create(
      {
        'AuthorId': @contribution.user.mango_pay_id,
        'CreditedUserId': @contribution.user.mango_pay_id,
        'CreditedWalletId': @contribution.user.wallet_id,
        'DeclaredDebitedFunds': {
          'Currency': "EUR",
          'Amount': @contribution.amount_in_cents
        },
        'DeclaredFees': {
          'Currency': "EUR",
          'Amount': 0
        }
      })
    if bankwire['Status'] == 'FAILED'
      Failure({ contribution: @contribution }.merge(error: 'mango_pay_error_bankwire', project: @contribution.project_id))
    else
      @contribution.update(aasm_state: 'payment_pending')
      @contribution.update(mango_pay_id: bankwire['Id'])
      Success(input.merge(redirect: Rails.application.routes.url_helpers.billing_path(content: bankwire.to_enum.to_h, contribution_id: @contribution.id)))
    end
  end
end
