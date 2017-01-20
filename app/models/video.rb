class Video < ApplicationRecord
  has_many :queues, class_name: 'RoomQueue', foreign_key: :video_id
  has_many :rooms, through: :queues

  has_many :bookmarks, class_name: 'Bookmark', foreign_key: :video_id

  PROVIDER_YOUTUBE = 1
end
