class AddDocumentToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.has_attached_file :document
    end
  end

  def self.down
    drop_attached_file :books, :document
  end

end
