class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :accounts
  has_many :organization_users
  has_many :organizations, through: :organization_users

  def email_required?
    false
  end

  def password_required?
    false
  end

  def nickname
    email.split('@').first
  end

  def image_url
    accounts.length > 0 ?  accounts.first.image_url : "/assets/images/user.png"
  end

  def has_account?(provider)
    accounts.find_by(provider: provider)
  end

  def belong_organization?(organization)
    organizations.find_by({id: organization.id})
  end

  def generate_access_token
    ::Doorkeeper::AccessToken.create({
      application_id: nil,
      resource_owner_id: id,
      scopes: "public",
      expires_in: nil,
      use_refresh_token: false
    }) unless ::Doorkeeper::AccessToken.find_by({resource_owner_id: id})
  end

  def token
    ::Doorkeeper::AccessToken.find_by({resource_owner_id: id}).token
  end
end
