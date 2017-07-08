class AddContinuousCheckInsAndCheckInsCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :continuous_checkins, :integer, default: 0
    add_column :users, :checkins_count, :integer, default: 0
  end
end
