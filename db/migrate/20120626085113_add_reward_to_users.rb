class AddRewardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reward, :integer, :default => 0
  end
end
