class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :access_token

  def access_token
    current_user.token
  end

  def after_sign_in_path_for(resource)
    rooms_path
  end
end
