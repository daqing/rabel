class AddNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_index :users, :nickname, :unique => true
  end
end
