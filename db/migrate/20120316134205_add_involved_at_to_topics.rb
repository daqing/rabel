class AddInvolvedAtToTopics < ActiveRecord::Migration
  def up
    add_column :topics, :involved_at, :datetime
    add_index :topics, :involved_at
    remove_index :topics, :updated_at
    Topic.all.each do |topic|
      topic.update_column(:involved_at, topic.updated_at)
    end
  end

  def down
    remove_index :topics, :involved_at
    remove_column :topics, :involved_at
    add_index :topics, :updated_at
  end
end
