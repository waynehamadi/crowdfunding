class CreateContribution
  include Dry::Transaction
  tee :new_contribution
  step :validate
  tee :create
  tee :callback_url
  step :test_card_web

  private

  def new_contribution(input)
    @contribution = input[:contribution]
    @project = Project.find_by_id(input[:project_id])
    @contribution.project = @project
    @user = @contribution.user
    @contribution.user =@user
  end

  def validate(input)
    if @contribution.valid?
      Success(input)
    else
      Failure(input.merge(project: input[:project_id].to_i, error: @contribution.errors))
    end
  end

  def create(_input)
    @contribution.save
  end

  def callback_url(_input)

    @callback_url = Rails.application.routes.url_helpers.payment_url
  end
  # On cree un PayIn
  def test_card_web(input)
    card_web = MangoPay::PayIn::Card::Web.create(
      'AuthorId': @user.mango_pay_id,
      'CreditedUserId': @user.mango_pay_id,
      'CreditedWalletId': @user.wallet_id,
      'DebitedFunds': { Currency: 'EUR', Amount: @contribution.amount_in_cents },
      'Fees': { Currency: 'EUR', Amount: 0 },
      'CardType': 'CB_VISA_MASTERCARD',
      'ReturnURL': @callback_url,
      'Culture': (@user.country_of_residence == 'FR' ? 'FR' : 'EN'),
      'Tag': 'PayIn/Card/Web',
      "SecureMode": 'DEFAULT',
      "TemplateURL": 'http://www.a-url.com/3DS-redirect'
    )
    # On envoie l'utilisateur sur la page Mango pour qu'il renseigne sa CB
    # Mango nous renvoie le resultat (paiement en succes / echec)
    if card_web['Status'] == 'FAILED'
      Failure({ contribution: @contribution }.merge(error: 'mango_pay_error_card', project: @contribution.project_id))
    else
      @contribution.update(aasm_state: 'payment_pending')
      @contribution.update(mango_pay_id: card_web['Id'])
      Success(input.merge(redirect: card_web['RedirectURL']))
    end
  end
end
