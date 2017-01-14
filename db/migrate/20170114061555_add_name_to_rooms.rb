class AddNameToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :name, :string, :after => :id
    remove_column :rooms, :organization_id
  end
end
