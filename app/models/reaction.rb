class Reaction < ApplicationRecord
  belongs_to :queue, foreign_key: 'queue_id', class_name: 'VideoQueue'
  belongs_to :user
end
