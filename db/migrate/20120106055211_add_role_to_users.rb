class AddRoleToUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :admin
    add_column :users, :role, :string
    add_index :users, :role
  end
end
