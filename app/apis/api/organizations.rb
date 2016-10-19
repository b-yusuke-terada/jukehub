class API::Organizations < ::Grape::API
  helpers do
    def get_organization
      @organization = Organization.find(params[:id])
    end
  end

  resource :organizations do
    desc 'GET /api/organizations'
    get do
      Organization.all
    end

    route_param :id, type: Integer do
      before do
        get_organization
      end

      desc 'GET /api/organizations/:id'
      get do
        @organization
      end
    end
  end
end
