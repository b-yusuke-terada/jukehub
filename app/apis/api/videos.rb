class API::Videos < Grape::API
  helpers do
    def set_video
    end
  end

  resource :videos do
    desc 'GET /api/videos'
    get do
    end
  end
end
