class AddCheckinDateToCheckins < ActiveRecord::Migration[5.1]
  def change
    add_column :checkins, :checkin_date, :date
    add_index :checkins, :checkin_date
  end
end
