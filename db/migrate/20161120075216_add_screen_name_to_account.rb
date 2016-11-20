class AddScreenNameToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :screen_name, :string, after: :name
    add_index :accounts, :screen_name
  end
end
