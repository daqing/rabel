class AddUpdatedAtIndexToNodes < ActiveRecord::Migration[4.2]
  def change
    add_index :nodes, :updated_at
  end
end
