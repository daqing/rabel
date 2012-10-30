class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :notifiable_type
      t.integer :notifiable_id
      t.text :content
      t.integer :action_user_id
      t.string :action
      t.boolean :unread, :default => true

      t.timestamps
    end
  end
end
