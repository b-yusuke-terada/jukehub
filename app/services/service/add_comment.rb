class ::Service::AddComment
  attr_accessor :room

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @room = args[:room] if args.key?(:room)
    @comment = args[:comment] if args.key?(:comment)
  end

  def execute
    now_playing = @room.queues.find_by({state: VideoQueue::STATE_PLAYING})
    now_playing.comments << Comment.create({
      user_id: 1,
      body: @comment
    })
  end
end
