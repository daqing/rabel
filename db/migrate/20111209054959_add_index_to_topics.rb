class AddIndexToTopics < ActiveRecord::Migration[4.2]
  def change
    add_index :topics, :node_id
    add_index :topics, :user_id
  end
end
