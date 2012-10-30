class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :node_id
      t.integer :user_id
      t.string :title
      t.text :content
      t.integer :hit

      t.timestamps
    end
  end
end
