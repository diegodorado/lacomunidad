class SerializeAttachementIntoPostTable < ActiveRecord::Migration
  def up
    drop_table :attachements
    add_column :posts, :attach, :text
  end
  def down
    create_table :attachements do |t|
      t.string :title
      t.string :url
      t.string :description
      t.string :image
      t.string :video

      t.timestamps
    end
    remove_column :posts, :attach, :text
  end
end
