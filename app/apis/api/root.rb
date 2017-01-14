require 'doorkeeper/grape/helpers'

class API::Root < Grape::API
  format :json

  helpers ::Doorkeeper::Grape::Helpers
  helpers do
    def current_user
      User.find(doorkeeper_token.resource_owner_id)
    end

    def jukehub_authorize!(*scopes)
      unless scopes.select{|scope| doorkeeper_token.scopes.exists?(scope) }.length > 0
        error!({ error: "missing scopes #{scopes.join(', ')}" }, 403)
      end
    end
  end

  before do
    jukehub_authorize! :public
  end

  mount API::Videos
  mount API::Rooms
  mount API::Users
  mount API::Search
end
