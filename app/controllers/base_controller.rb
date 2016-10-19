class BaseController < ApplicationController
  before_action :set_organization
  before_action :authenticate_user
  helper_method :access_token

  def authenticate_user
    redirect_to root_path and return unless current_user
  end

  def access_token
    current_user.token
  end
end
