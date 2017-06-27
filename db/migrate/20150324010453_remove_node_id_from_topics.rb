class RemoveNodeIdFromTopics < ActiveRecord::Migration[4.2]
  def change
    remove_column :topics, :node_id, :integer
  end
end
