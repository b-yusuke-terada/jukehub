class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.integer :provider
      t.string :title
      t.string :provider_video_id
      t.integer :duration
      t.string :image_url

      t.timestamps
    end
    add_index :videos, :provider
    add_index :videos, :title
    add_index :videos, :provider_video_id
  end
end
