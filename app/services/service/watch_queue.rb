require 'gcp/youtube'

class ::Service::WatchQueue
  attr_accessor :room

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @room = args[:room] if args.key?(:room)
  end

  def execute
    return unless @room.participants.recently.length > 0

    queue = @room.playing_queue
    if !queue
      if next_queue = @room.next_queue
        next_queue.play
      else
        latest_queue = @room.latest_queue
        video_id = latest_queue ? latest_queue.video.provider_video_id : 'ZWdMi2Cfp70'
        res = ::Gcp::Youtube.new.get_relation_video(video_id)
        # random
        video_id = res["items"].sample["id"]["videoId"]
        Service::AddQueue.new({room: @room, video_id: video_id}).execute
      end
    elsif queue.can_finish?
      queue.finish
      if next_queue = @room.next_queue
        next_queue.play
      end
    end
  end
end
