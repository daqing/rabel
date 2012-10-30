class AddRoleToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :admin
    add_column :users, :role, :string
    add_index :users, :role
  end
end
