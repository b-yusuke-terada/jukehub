class ::Service::WatchQueue
  attr_accessor :room

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @room = args[:room] if args.key?(:room)
  end

  def execute
    now_playing = @room.now_playing_video
    unless now_playing
      puts "now playing がない"
      first_queue = @room.queues.where({
        state: VideoQueue::STATE_QUEUED
      }).order(:created_at).first

      if first_queue
        first_queue.play
      end
    end
  end
end
