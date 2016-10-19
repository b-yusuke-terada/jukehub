class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from :twitter
  end

  def google
    callback_from :google
  end

  private
  def callback_from(provider)
    user = Service::User::OauthAuthenticate.new({auth: request.env['omniauth.auth']}).execute
    sign_in_and_redirect user
  end
end
