class HomeController < ApplicationController
  def index
    # organization subdomain のとき
    if @organization
      render '/organizations/show'
    elsif current_user
      redirect_to organizations_path
    else
    end
  end

  def how_to_use
  end
end
