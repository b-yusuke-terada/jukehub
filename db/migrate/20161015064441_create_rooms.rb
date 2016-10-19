class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :organization_id
      t.string :screen_name
      t.text :description
      t.timestamps
    end
    add_index :rooms, :organization_id
  end
end
