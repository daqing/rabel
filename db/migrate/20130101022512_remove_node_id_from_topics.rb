class RemoveNodeIdFromTopics < ActiveRecord::Migration
  def up
    Topic.find_each do |topic|
      topic.node.topics << topic
    end

    remove_index :topics, :column => :node_id
    remove_column :topics, :node_id
  end

  def down
    add_column :topics, :node_id, :integer
    add_index :topics, :node_id
  end
end
