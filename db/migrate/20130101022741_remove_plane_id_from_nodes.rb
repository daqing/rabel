class RemovePlaneIdFromNodes < ActiveRecord::Migration
  def up
    remove_index :nodes, :column => :plane_id
    remove_column :nodes, :plane_id
  end

  def down
    add_column :nodes, :plane_id, :integer
    add_index :nodes, :plane_id
  end
end
