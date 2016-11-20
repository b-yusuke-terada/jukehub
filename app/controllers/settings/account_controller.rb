class Settings::AccountController < BaseController
  before_action :set_user, only: [:show, :update]

  def show
  end

  def update
    if @user.update(account_params)
      flash[:success] = "アカウント名を保存しました"
      redirect_to settings_account_path
    else
      if @user.find_by(name: params[:name])
        flash[:error] = "すでに利用されています"
      else
        flash[:error] = "すでに利用されています"
      end
      redirect_to settings_account_path
    end
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end

  def account_params
    params.require(:user).permit(:name)
  end
end
