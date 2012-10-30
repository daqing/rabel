class AddIndexToNotifications < ActiveRecord::Migration
  def change
    change_table :notifications do |t|
      t.index :user_id
      t.index :unread
    end
  end
end
