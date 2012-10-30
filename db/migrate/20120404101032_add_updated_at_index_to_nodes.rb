class AddUpdatedAtIndexToNodes < ActiveRecord::Migration
  def change
    add_index :nodes, :updated_at
  end
end
