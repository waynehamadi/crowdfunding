class CreateContribution
  include Dry::Transaction
  tee :new_contribution
  step :validate
  tee :create
  tee :callback_url
  step :create_card_web

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

  def callback_url(_input)
    @callback_url = Rails.application.routes.url_helpers.payment_url
  end

  def create_card_web(input)
    card_web = MangoPay::PayIn::Card::Web.create(
      'AuthorId': @contribution.user.mango_pay_id,
      'CreditedUserId': @contribution.user.mango_pay_id,
      'CreditedWalletId': @contribution.user.wallet_id,
      'DebitedFunds': { Currency: 'EUR', Amount: @contribution.amount_in_cents },
      'Fees': { Currency: 'EUR', Amount: 0 },
      'CardType': 'CB_VISA_MASTERCARD',
      'ReturnURL': @callback_url,
      'Culture': (@contribution.user.country_of_residence == 'FR' ? 'FR' : 'EN'),
      'Tag': 'PayIn/Card/Web',
      "SecureMode": 'DEFAULT',
      "TemplateURL": 'http://www.a-url.com/3DS-redirect'
    )
    @contribution.update(aasm_state: 'payment_pending', mango_pay_id: card_web['Id'])
    Success(input.merge(redirect: card_web['RedirectURL']))
  rescue MangoPay::ResponseError => e
    Failure(input.merge(error: 'mango_pay_error_card'))
  end
end
