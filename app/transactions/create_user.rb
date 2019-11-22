class CreateUser
  include Dry::Transaction
  step :validate
  tee :create_user
  step :create_mango_pay_user
  step :create_user_wallet
  tee :send_welcome_email

  private

  def validate(input)
    @user = input[:user]
    if @user.valid?
      Success(input)
    else
      Failure(input.merge(error: @user.errors.full_messages.uniq.join('. ')))
    end
  end

  def create_user(input)
    @user.save
  end
  def create_mango_pay_user(input)
    mango_pay_user = MangoPay::NaturalUser.create(
      'FirstName': @user.first_name,
      'LastName': @user.last_name,
      'Birthday': @user.birthday.to_i,
      'Nationality': @user.nationality,
      'CountryOfResidence': @user.country_of_residence,
      'Email': @user.email
    )
    if mango_pay_user['Id']
      @user.mango_pay_id = mango_pay_user['Id']
      Success(input)
    else
      Failure({ resource: @user }.merge(error('create_account_error')))
    end
    rescue MangoPay::ResponseError => e
      Failure(input.merge(error: 'mango_pay_error_user'))
  end

  def create_user_wallet(input)
    user_wallet = MangoPay::Wallet.create(
      'Owners': [@user.mango_pay_id],
      'Description': "Wallet de: #{@user.email}",
      'Currency': 'EUR'
    )
    @user.wallet_id = user_wallet['Id']
    if user_wallet['Id'] && @user.save
      Success(input.merge(resource: @user))
    else
      Failure(error('create_account_error'))
    end
    rescue MangoPay::ResponseError => e
      Failure(input.merge(error: 'mango_pay_error_wallet'))
  end
  def send_welcome_email(input)
    mailer = UserMailer.with(user: @user).welcome_email.deliver_now
  end
end
