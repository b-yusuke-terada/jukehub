class VideoQueue < ApplicationRecord
  belongs_to :user
  belongs_to :video
  belongs_to :room

  has_many :comments, foreign_key: 'queue_id'

  STATE_QUEUED = 0
  STATE_PLAYING = 1
  STATE_FINISHED = 2
  STATE_STOPED = 3

  def play
    update({
      state: STATE_PLAYING,
      started_at: DateTime.now,
      finish_at: (DateTime.now.to_time + video.duration).to_datetime
    })
  end

  def finish
    update({state: STATE_FINISHED, finished_at: DateTime.now})
  end
end
