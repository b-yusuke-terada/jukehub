class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :queue_id
      t.integer :reference_comment_id
      t.integer :user_id
      t.text    :body
      t.timestamps
    end
    add_index :comments, :queue_id
    add_index :comments, :user_id
    add_index :comments, :reference_comment_id
  end
end
