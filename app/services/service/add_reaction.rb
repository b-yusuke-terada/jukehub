class ::Service::AddReaction
  attr_accessor :room
  attr_accessor :user
  attr_accessor :type

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @room = args[:room]
    @type = args[:type]
    @user = args[:user]
  end

  def execute
    if queue = @room.playing_queue
      QueueReaction.create({queue_id: queue.id, user_id: @user.id, reaction_type: QueueReaction::TYPE_LIKE })
    end
  end
end
