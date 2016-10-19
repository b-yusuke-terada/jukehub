require 'uri'

class API::Rooms < ::Grape::API
  helpers do
    def get_room
      @room = ::Room.find(params[:id])
    end
  end

  resource :rooms do
    desc 'GET /api/rooms'
    get do
      status 200
    end

    route_param :id, type: Integer do
      before do
        get_room
      end

      desc 'GET /api/rooms/:id'
      get do
        @room
      end

      resource :comments do
        desc 'GET /api/rooms/:id/comments'
        get do
          @room.comments
        end

        desc 'POST /api/rooms/:id/comments'
        post do
          ::Service::AddComment.new({room: @room, comment: @params[:comment]}).execute
        end
      end

      resource :reactions do
      end

      resource :queues do
        desc 'GET /rooms/:id/queues'
        get do
          puts 'koko'
          @room.videos
        end

        desc 'GET /rooms/:id/queues/:queue_id'
        get ':queue_id' do
          status 200

          if params[:queue_id] == 'playing'
            room = ::Room.find(params[:id])
            now_playing = room.queues.find_by({state: VideoQueue::STATE_PLAYING})
            {
              video: now_playing.video,
              user: now_playing.user
            }
          else
            room = Queue.find(params[:queue_id]) and return
          end
        end

        desc 'POST /rooms/:id/queues'
        params do
          requires :id,   type: Integer
          requires :url,  type: String
        end

        post do
          uri = ::URI.parse(params[:url])
          room = ::Room.find(params[:id])
          v = uri.query.split('&').map{|m| m.split('=')}.select{|m| m[0] == 'v'}.first
          if v
            video_id = v[1]
            res = Service::AddQueue.new({room: room, video_id: video_id}).execute
          end
        end

        desc 'DELETE /rooms/:id/queues/:queue_id'
        delete ':queue_id' do
          queue = ::Queue.find(params[:queue_id])
          queue.finish
        end
      end
    end
  end
end
