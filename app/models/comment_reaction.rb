class CommentReaction < ApplicationRecord
  belongs_to :comment, foreign_key: 'comment_id', class_name: '::Comment'
  belongs_to :user
end
