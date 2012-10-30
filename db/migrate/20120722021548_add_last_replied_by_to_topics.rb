class AddLastRepliedByToTopics < ActiveRecord::Migration
  def up
    add_column :topics, :last_replied_by, :string, default: ''
    Topic.find_each do |topic|
      topic.update_column(:last_replied_by, topic.last_comment.user.nickname) if topic.comments_count > 0
    end
  end

  def down
    remove_column :topics, :last_replied_by
  end
end
