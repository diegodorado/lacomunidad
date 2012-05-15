class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.text :bio

      t.timestamps
    end
  end
end
