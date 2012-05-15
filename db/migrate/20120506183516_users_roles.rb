class UsersRoles < ActiveRecord::Migration
  def change
    create_table :roles_users, :id => false do |t|
      t.references :user, :null => false
      t.references :role, :null => false
    end
    add_index(:roles_users, [:user_id, :role_id], :unique => true)
  end
end
