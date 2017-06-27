class AddUpdatedAtIndexToPlanes < ActiveRecord::Migration[4.2]
  def change
    add_index :planes, :updated_at
  end
end
