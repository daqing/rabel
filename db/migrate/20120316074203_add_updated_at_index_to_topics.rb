class AddUpdatedAtIndexToTopics < ActiveRecord::Migration
  def change
    add_index :topics, :updated_at
  end
end
