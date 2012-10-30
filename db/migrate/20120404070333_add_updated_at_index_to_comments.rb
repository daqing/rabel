class AddUpdatedAtIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, :updated_at
  end
end
