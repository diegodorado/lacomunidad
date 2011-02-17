class AddDataToAuthentications < ActiveRecord::Migration
  def self.up
    add_column :authentications, :name, :string
    add_column :authentications, :email, :string
    add_column :authentications, :nickname, :string
    add_column :authentications, :image, :string
    add_column :authentications, :token, :string
    add_column :authentications, :secret, :string
  end

  def self.down
    remove_column :authentications, :name
    remove_column :authentications, :email
    remove_column :authentications, :nickname
    remove_column :authentications, :image
    remove_column :authentications, :token
    remove_column :authentications, :secret
  end
end
