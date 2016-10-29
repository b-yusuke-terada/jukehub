class ::Service::WatchQueue
  attr_accessor :room

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @room = args[:room] if args.key?(:room)
  end

  def execute
    queue = @room.playing_queue
    if !queue
      if next_queue = @room.next_queue
        next_queue.play
      end
    elsif queue.can_finish?
      queue.finish
      if next_queue = @room.next_queue
        next_queue.play
      end
    end
  end
end
