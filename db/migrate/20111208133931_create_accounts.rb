class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :personal_website
      t.string :location
      t.string :signature
      t.text :introduction
      t.string :twitter_id

      t.timestamps
    end
  end
end
