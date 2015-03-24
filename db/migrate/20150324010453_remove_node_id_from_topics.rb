class RemoveNodeIdFromTopics < ActiveRecord::Migration
  def change
    remove_index :topics, :node_id
    remove_column :topics, :node_id, :integer
  end
end
