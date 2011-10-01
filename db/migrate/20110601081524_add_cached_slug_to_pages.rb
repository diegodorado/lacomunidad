class AddCachedSlugToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :cached_slug, :string
    add_index  :pages, :cached_slug, :unique => true
  end

  def self.down
    remove_column :pages, :cached_slug
  end
end
