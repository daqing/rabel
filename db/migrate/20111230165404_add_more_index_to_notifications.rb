class AddMoreIndexToNotifications < ActiveRecord::Migration
  def change
    change_table :notifications do |t|
      t.index [:notifiable_id, :notifiable_type]
    end
  end
end
