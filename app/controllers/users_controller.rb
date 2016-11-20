class UsersController < BaseController
  before_action :set_user, only: [:show]

  def show
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end
end
