class HomeController < ApplicationController
  def index
    if current_user
      redirect_to organizations_path
    else
    end
  end
end
