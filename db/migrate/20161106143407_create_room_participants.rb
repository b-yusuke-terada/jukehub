class CreateRoomParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :room_participants do |t|
      t.integer :user_id
      t.integer :room_id
      t.timestamps
    end
    add_index :room_participants, :user_id
    add_index :room_participants, :room_id
    add_index :room_participants, :created_at
    add_index :room_participants, :updated_at
  end
end
