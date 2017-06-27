class AddIndexToAccounts < ActiveRecord::Migration[4.2]
  def change
    add_index :accounts, :user_id
  end
end
