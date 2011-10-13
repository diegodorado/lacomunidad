class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :slug

      t.timestamps
    end
    add_index :pages, :slug, :unique => true
  end

  def self.down
    drop_table :pages
  end
end
