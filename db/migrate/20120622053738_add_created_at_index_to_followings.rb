class AddCreatedAtIndexToFollowings < ActiveRecord::Migration
  def change
    add_index :followings, :created_at
  end
end
