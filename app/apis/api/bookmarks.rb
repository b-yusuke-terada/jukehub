class API::Bookmarks < Grape::API
  helpers do
  end

  resource :bookmarks do
    desc 'GET /api/bookmarks'
    get do
      {
        result: Bookmark.where({user_id: current_user.id}).map{|b|
          {
            title: b.video.title,
            image_url: b.video.image_url,
            video_id: b.video.provider_video_id,
          }
        }
      }
    end

    desc 'GET /api/videos'
    post do
      video = Video.find_by({provider_video_id: params[:video_id]})
      Bookmark.create({
        user_id: current_user.id,
        video_id: video.id,
      })
    end
  end
end
