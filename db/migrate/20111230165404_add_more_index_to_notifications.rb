class AddMoreIndexToNotifications < ActiveRecord::Migration[4.2]
  def change
    change_table :notifications do |t|
      t.index [:notifiable_id, :notifiable_type]
    end
  end
end
