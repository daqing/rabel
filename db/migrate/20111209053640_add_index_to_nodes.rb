class AddIndexToNodes < ActiveRecord::Migration
  def change
    add_index :nodes, :key, :unique => true
  end
end
