class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :image_url
      t.timestamps
    end
    add_index :accounts, [:provider, :uid], unique: true
  end
end
