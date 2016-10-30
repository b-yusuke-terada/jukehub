class Account < ApplicationRecord
  belongs_to :user, optional: true

  def self.providers
    ['twitter', 'google']
  end
end
