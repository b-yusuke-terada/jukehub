class CreateReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :reactions do |t|
      t.integer :queue_id
      t.integer :reference_comment_id
      t.integer :user_id
      t.integer :reaction_type
      t.timestamps
    end
    add_index :reactions, :queue_id
    add_index :reactions, :reference_comment_id
    add_index :reactions, :user_id
    add_index :reactions, :reaction_type
  end
end
