class AddCommentsClosedToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :comments_closed, :boolean, null: false, default: false
  end
end
