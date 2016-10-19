class API::Users < ::Grape::API
  helpers do
    def get_user
      @user = User.find(params[:id])
    end
  end

  resource :users do
    desc 'GET /api/users'
    get do
      User.all
    end

    route_param :id, type: Integer do
      before do
        get_user
      end

      desc 'GET /api/users/:id'
      get do
        @user
      end
    end
  end
end
