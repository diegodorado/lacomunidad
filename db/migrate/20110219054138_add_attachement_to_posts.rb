class AddAttachementToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :attachement_id, :integer
  end

  def self.down
    remove_column :posts, :attachement_id
  end
end
