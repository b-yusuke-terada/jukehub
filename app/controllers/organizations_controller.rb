class OrganizationsController < BaseController
  before_action :set_organization, only: [:show, :join]
  def index
    @public_organizations = Organization.publics
    @belong_organizations = current_user.organizations
  end

  def show
    if current_user.belong_organization?(@organization)
      redirect_to "http://#{@organization.name}.#{ENV["APP_DOMAIN_WITH_PORT"]}/rooms"
    end
  end

  def join
    @organization.users << current_user unless current_user.belong_organization?(@organization)
    redirect_to "http://#{@organization.name}.#{ENV["APP_DOMAIN_WITH_PORT"]}/rooms"
  end

  private
  def set_organization
    @organization = Organization.find(params[:id])
  end
end
