class AddOggToAudios < ActiveRecord::Migration
  def self.up
    change_table :audios do |t|
      t.has_attached_file :ogg
    end
  end

  def self.down
    drop_attached_file :audios, :ogg
  end
end
