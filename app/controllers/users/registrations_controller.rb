class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    current_user.generate_access_token
  end
end
