class AddUserToCandidate < ActiveRecord::Migration
  def change
    change_table :candidates do |t|
      t.references :user
    end
  end
end
