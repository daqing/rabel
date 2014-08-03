class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :admin_user_id, default: 0
      t.integer :user_id, default: 0
      t.integer :amount, default: 0
      t.integer :balance, default: 0

      t.text :reason

      t.timestamps
    end
  end
end
