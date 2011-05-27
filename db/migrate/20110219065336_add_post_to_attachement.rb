class AddPostToAttachement < ActiveRecord::Migration
  def self.up
    add_column :attachements, :post_id, :integer
  end

  def self.down
    remove_column :attachements, :post_id
  end
end
