class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_organization
  helper_method :access_token

  def set_organization
    name = request.env["HTTP_HOST"].split('.').first
    @organization = Organization.find_by({name: name})
  end

  def access_token
    current_user.token
  end
end
