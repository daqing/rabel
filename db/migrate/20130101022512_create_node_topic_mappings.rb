class CreateNodeTopicMappings < ActiveRecord::Migration
  def change
    create_table :node_topic_mappings do |t|
      t.references :node
      t.references :topic
    end
    add_index :node_topic_mappings, :node_id
    add_index :node_topic_mappings, :topic_id
  end
end
