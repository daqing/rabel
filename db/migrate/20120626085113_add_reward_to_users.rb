class AddRewardToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :reward, :integer, :default => 0
  end
end
