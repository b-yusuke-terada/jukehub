class Video < ApplicationRecord
  has_many :video_queues, class_name: 'VideoQueue', foreign_key: :video_id
  has_many :rooms, through: :video_queues

  PROVIDER_YOUTUBE = 1
end
