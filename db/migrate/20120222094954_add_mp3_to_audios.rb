class AddMp3ToAudios < ActiveRecord::Migration
  def self.up
    change_table :audios do |t|
      t.has_attached_file :mp3
    end
  end

  def self.down
    drop_attached_file :audios, :mp3
  end
end
