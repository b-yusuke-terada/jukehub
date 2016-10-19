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

  def token
    ::Doorkeeper::AccessToken.find_or_create_for(nil, id, nil, nil, false).token
  end
end
