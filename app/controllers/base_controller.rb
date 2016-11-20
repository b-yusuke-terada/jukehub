class BaseController < ApplicationController
  before_action :set_organization
  before_action :authenticate_user

  def authenticate_user
    redirect_to ENV["APP_HOSTNAME"] and return unless current_user
  end

end
