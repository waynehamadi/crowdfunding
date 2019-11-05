require "dry/transaction"

class Users::CreateTransaction
  include Dry::Transaction
  step :validateUser
  tee :createUser
  tee :sendWelcomeEmail

  private

  def validate(input)
    @user = input[:user]
    if @user.valid?
      Success(input)
    else
      raise
    end
  end
  def createUser(input)
    @user.save
  end
  def sendWelcomeEmail
    @user = User.last
    mailer = UserMailer.with(user: @user).welcome_email.deliver_now
  end
end
