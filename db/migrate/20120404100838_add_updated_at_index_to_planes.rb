class AddUpdatedAtIndexToPlanes < ActiveRecord::Migration
  def change
    add_index :planes, :updated_at
  end
end
