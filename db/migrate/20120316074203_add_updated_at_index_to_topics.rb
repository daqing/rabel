class AddUpdatedAtIndexToTopics < ActiveRecord::Migration[4.2]
  def change
    add_index :topics, :updated_at
  end
end
