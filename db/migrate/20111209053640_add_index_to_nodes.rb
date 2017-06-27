class AddIndexToNodes < ActiveRecord::Migration[4.2]
  def change
    add_index :nodes, :key, :unique => true
  end
end
