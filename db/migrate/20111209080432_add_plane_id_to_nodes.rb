class AddPlaneIdToNodes < ActiveRecord::Migration[4.2]
  def change
    add_column :nodes, :plane_id, :integer
    add_index :nodes, :plane_id
  end
end
