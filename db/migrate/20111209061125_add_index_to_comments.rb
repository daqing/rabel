class AddIndexToComments < ActiveRecord::Migration[4.2]
  def change
    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
