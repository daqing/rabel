class AddPositionToPlanes < ActiveRecord::Migration
  def change
    add_column :planes, :position, :integer, :null => false, :default => 0
  end
end
