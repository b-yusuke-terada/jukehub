class BaseController < ApplicationController
  before_action :authenticate_user

  def authenticate_user
    redirect_to new_user_session_path and return unless current_user
  end
end
