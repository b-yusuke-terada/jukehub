class Video < ApplicationRecord
  has_many :queues, class_name: 'RoomQueue', foreign_key: :video_id
  has_many :rooms, through: :queues

  PROVIDER_YOUTUBE = 1
end
