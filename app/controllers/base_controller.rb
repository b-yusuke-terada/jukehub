class BaseController < ApplicationController
  before_action :set_organization
  before_action :authenticate_user

  def authenticate_user
    redirect_to root_path and return unless current_user
  end

end
