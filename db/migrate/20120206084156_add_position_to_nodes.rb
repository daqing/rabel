class AddPositionToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :position, :integer
    add_index :nodes, :position
  end
end
