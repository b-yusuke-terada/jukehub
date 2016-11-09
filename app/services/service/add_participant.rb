class ::Service::AddParticipant
  attr_accessor :room
  attr_accessor :user_id

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @room = args[:room]
    @user = args[:user]
  end

  def execute
    room_participant = RoomParticipant.find_or_create_by({user_id: @user.id})
    room_participant.update({room_id: @room.id, updated_at: DateTime.now})
  end
end
