class API::Search < ::Grape::API
  helpers do
  end

  resource :search do
    desc 'GET /api/search'
    params do
      requires :query, type: String, desc: 'Search Query'
    end
    get do
      { result: Service::Video::SearchByQuery.new({query: params[:query]}).execute }
    end
  end
end
