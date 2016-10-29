class Room < ApplicationRecord
  belongs_to :organization
  has_many :queues, foreign_key: :room_id, class_name: 'RoomQueue'
  has_many :videos, through: :queues
  has_many :comments, through: :queues

  def playing_queue
    queues.find_by({state: RoomQueue::STATE_PLAYING})
  end

  def next_queue
    queues.where({ state: RoomQueue::STATE_QUEUED }).order(:created_at).first
  end

  def add_queue(video)
    queues << RoomQueue.create({
      user_id: 1,
      video_id: video.id,
      state: RoomQueue::STATE_QUEUED,
    })
  end
end
