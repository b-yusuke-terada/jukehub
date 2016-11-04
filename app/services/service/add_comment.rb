class ::Service::AddComment
  attr_accessor :room
  attr_accessor :user

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @room = args[:room] if args.key?(:room)
    @comment = args[:comment] if args.key?(:comment)
    @user = args[:user]
  end

  def execute
    p @user
    now_playing = @room.queues.find_by({state: RoomQueue::STATE_PLAYING})
    now_playing.comments << Comment.create({
      user_id: @user.id,
      body: @comment
    })
  end
end
