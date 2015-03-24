class RemoveNodeIdFromTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :node_id, :integer
  end
end
