class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :title
      t.string :thumb_url
      t.text :embed
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
