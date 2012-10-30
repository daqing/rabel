class AddLastRepliedAtToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_replied_at, :datetime
    Topic.find_each do |topic|
      if topic.comments_count > 0
        topic.last_replied_at = topic.last_comment.created_at
        topic.save
      end
    end
  end
end
