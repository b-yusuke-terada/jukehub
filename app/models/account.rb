class Account < ApplicationRecord
  belongs_to :user, optional: true

  def self.providers
    ['twitter', 'google']
  end

  def provider_url
    if provider == 'twitter'
      "https://twitter.com/#{name}"
    else
      nil
    end
  end
end
