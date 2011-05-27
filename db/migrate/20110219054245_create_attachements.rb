class CreateAttachements < ActiveRecord::Migration
  def self.up
    create_table :attachements do |t|
      t.string :title
      t.string :url
      t.string :description
      t.string :image
      t.string :video

      t.timestamps
    end
  end

  def self.down
    drop_table :attachements
  end
end
