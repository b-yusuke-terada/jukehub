class CreateVideoQueues < ActiveRecord::Migration[5.0]
  def change
    create_table :video_queues do |t|
      t.integer :room_id
      t.integer :video_id
      t.integer :user_id
      t.integer :state
      t.datetime :start_at
      t.datetime :started_at
      t.datetime :finish_at
      t.datetime :finished_at
      t.timestamps
    end
    add_index :video_queues, :room_id
    add_index :video_queues, :video_id
    add_index :video_queues, :user_id
    add_index :video_queues, :state
    add_index :video_queues, :start_at
    add_index :video_queues, :started_at
    add_index :video_queues, :finish_at
    add_index :video_queues, :finished_at
  end
end
