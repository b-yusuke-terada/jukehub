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
          @room.playing_queue.comments.map{|c| { user: c.user, body: c.body }}
        end

        desc 'POST /api/rooms/:id/comments'
        post do
          ::Service::AddComment.new({room: @room, comment: @params[:comment], user: current_user}).execute
        end
      end

      resource :participants do
        desc 'GET /api/rooms/:id/participants'
        get do
          @room.participants.where('updated_at > ?', DateTime.now - 300).map{|m|
            { name: m.user.nickname, image_url: m.user.image_url }
          }
        end
      end

      resource :reactions do
        desc 'GET /api/rooms/:id/reactions'
        get do
          { like: @room.playing_queue.reactions.length }
        end

        desc 'POST /api/rooms/:id/reactions'
        params do
          requires :type,  type: String
        end
        post do
          ::Service::AddReaction.new({room: @room, user: current_user, type: params[:type]}).execute
        end
      end

      resource :queues do
        desc 'GET /rooms/:id/queues'
        get do
          ::Service::AddParticipant.new({room: @room, user: current_user}).execute
          queues = @room.current_queues
          queues.map{|q|
            duration_sec = q.video.duration
            duration_text = ''
            if duration_sec > 3600
              duration_text = "#{duration_sec / 3600}時間#{(duration_sec % 3600) / 60}分#{duration_sec % 60}秒"
            elsif duration_sec > 60
              duration_text = "#{duration_sec / 60}分#{duration_sec % 60}秒"
            else
              duration_text = "#{duration_sec}秒"
            end
            {
              id: q.id,
              image_url: q.video.image_url,
              title: q.video.title,
              state: q.state,
              user: {
                name: q.user.email.split('@').first,
              },
              duration: q.video.duration,
              duration_text: duration_text
            }
          }
        end

        desc 'GET /rooms/:id/queues/:queue_id'
        get ':queue_id' do
          status 200

          if params[:queue_id] == 'playing'
            room = ::Room.find(params[:id])
            now_playing = room.queues.find_by({state: RoomQueue::STATE_PLAYING})
            if now_playing
              { video: now_playing.video, image_url: now_playing.user.image_url, user_name: now_playing.user.email.split('@').first, user: now_playing.user }
            else
              false
            end
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
            res = Service::AddQueue.new({room: room, video_id: video_id, user_id: current_user.id}).execute
          end
        end

        desc 'DELETE /rooms/:id/queues/:queue_id'
        delete ':queue_id' do
          queue = ::RoomQueue.find(params[:queue_id])
          queue.finish
        end
      end
    end
  end
end
