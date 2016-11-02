class CreateCommentReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_reactions do |t|
      t.integer :comment_id
      t.integer :user_id
      t.integer :reaction_type
      t.timestamps
    end
    add_index :comment_reactions, :comment_id
    add_index :comment_reactions, :user_id
    add_index :comment_reactions, :reaction_type
  end
end
