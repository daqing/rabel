class AddPositionToPlanes < ActiveRecord::Migration[4.2]
  def change
    add_column :planes, :position, :integer, :null => false, :default => 0
  end
end
