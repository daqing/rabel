class AddUpdatedAtIndexToComments < ActiveRecord::Migration[4.2]
  def change
    add_index :comments, :updated_at
  end
end
