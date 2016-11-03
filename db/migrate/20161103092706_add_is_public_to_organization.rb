class AddIsPublicToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :is_public, :boolean, default: true, after: :description
    add_column :organizations, :state, :integer, default: 0, after: :is_public

    add_index :organizations, :is_public
    add_index :organizations, :state
  end
end
