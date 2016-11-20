class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from :twitter
  end

  def google
    callback_from :google
  end

  private
  def callback_from(provider)
    user = Service::User::ConnectSocialAccount.new({user: current_user, auth: request.env['omniauth.auth']}).execute
    redirect_to settings_account_path
  end
end
