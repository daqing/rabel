class AddChannelIdToTopics < ActiveRecord::Migration[4.2]
  def change
    add_column :topics, :channel_id, :integer
    add_index :topics, :channel_id

    Topic.find_each do |t|
      node = Node.find(t.node_id)
      ch = Channel.find_by(name: node.name)
      t.channel_id = ch.id
      t.save
    end
  end
end
