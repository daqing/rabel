class AddPlaneIdToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :plane_id, :integer
    add_index :nodes, :plane_id
  end
end
