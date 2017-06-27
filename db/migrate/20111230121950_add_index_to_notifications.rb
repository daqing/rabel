class AddIndexToNotifications < ActiveRecord::Migration[4.2]
  def change
    change_table :notifications do |t|
      t.index :user_id
      t.index :unread
    end
  end
end
