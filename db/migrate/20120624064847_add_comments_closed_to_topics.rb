class AddCommentsClosedToTopics < ActiveRecord::Migration[4.2]
  def change
    add_column :topics, :comments_closed, :boolean, null: false, default: false
  end
end
