class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def new_csv(from, to, message)
    @from, @to, @message = from, to, message
    mail(:subject => 'Testing csv export')
  end
end
