class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.path :string
      t.title :string
      t.content :text

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
