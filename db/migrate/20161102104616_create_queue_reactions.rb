class CreateQueueReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :queue_reactions do |t|
      t.integer :queue_id
      t.integer :user_id
      t.integer :reaction_type
      t.timestamps
    end
    add_index :queue_reactions, :queue_id
    add_index :queue_reactions, :user_id
    add_index :queue_reactions, :reaction_type
  end
end
