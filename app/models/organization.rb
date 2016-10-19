class Organization < ApplicationRecord
  has_many :rooms
  has_many :organization_users
  has_many :users, through: :organization_users
end
