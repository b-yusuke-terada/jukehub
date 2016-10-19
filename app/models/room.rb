class Room < ApplicationRecord
  belongs_to :organization
  has_many :queues, foreign_key: :room_id, class_name: 'VideoQueue'
  has_many :videos, through: :queues

  has_many :comments, through: :queues

  def now_playing_video
    queues.find_by({state: VideoQueue::STATE_PLAYING}).video
  end

  def add_queue(video)
    queues << VideoQueue.create({
      user_id: 1,
      video_id: video.id,
      state: VideoQueue::STATE_QUEUED,
    })
  end
end
