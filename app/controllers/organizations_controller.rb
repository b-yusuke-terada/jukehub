class OrganizationsController < BaseController
  before_action :set_organization, only: [:show]
  def index
    @organizations = Organization.all
  end

  def show
    if current_user.belong_organization?(@organization)
      room = @organization.rooms.first
      redirect_to room
      # 所属済み
    else
      puts 'not shozoku'
      # 所属していないので所属依頼をだす
      # けど社内プレビュー中は自動的に所属される
      @organization.users << current_user
    end
  end

  private
  def set_organization
    @organization = Organization.find(params[:id])
  end
end
