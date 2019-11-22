class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    user_found = User.find_by_email(@user.email)
    if user_found.present?
      sign_in_and_redirect user_found, event: :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session[:user] = @user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
