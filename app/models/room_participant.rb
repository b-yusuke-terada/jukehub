class RoomParticipant < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def self.recently
    where('updated_at > ?', Time.now - 300)
  end
end
