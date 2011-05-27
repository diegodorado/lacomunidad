class RemoveAttachementFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :attachement_id
  end

  def self.down
    add_column :posts, :attachement_id, :integer
  end
end
