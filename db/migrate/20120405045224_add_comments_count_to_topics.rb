class AddCommentsCountToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :comments_count, :integer, :null => false, :default => 0
  end
end
