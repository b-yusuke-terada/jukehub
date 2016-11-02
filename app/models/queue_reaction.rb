class QueueReaction < ApplicationRecord
  TYPE_LIKE = 1
  TYPE_DISLIKE = 2

  belongs_to :queue, foreign_key: 'queue_id', class_name: 'RoomQueue'
  belongs_to :user
end
