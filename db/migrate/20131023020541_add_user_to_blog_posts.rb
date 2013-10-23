class AddUserToBlogPosts < ActiveRecord::Migration
  def self.up
    change_table :blog_posts do |t|
      t.references :user
    end
  end

  def self.down
    remove_column :blog_posts, :user_id
  end
end
