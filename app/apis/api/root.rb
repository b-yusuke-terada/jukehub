require 'doorkeeper/grape/helpers'

class API::Root < Grape::API
  format :json

  helpers ::Doorkeeper::Grape::Helpers
  helpers do
    def current_user
      User.find(doorkeeper_token.resource_owner_id)
    end
  end

  before do
    doorkeeper_authorize!
  end

  mount API::Organizations
  mount API::Videos
  mount API::Rooms
  mount API::Users
end
