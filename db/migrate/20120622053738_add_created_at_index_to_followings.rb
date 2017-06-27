class AddCreatedAtIndexToFollowings < ActiveRecord::Migration[4.2]
  def change
    add_index :followings, :created_at
  end
end
