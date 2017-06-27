class AddPositionToNodes < ActiveRecord::Migration[4.2]
  def change
    add_column :nodes, :position, :integer
    add_index :nodes, :position
  end
end
