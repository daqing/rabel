class AddTopicsCountToNodes < ActiveRecord::Migration[4.2]
  def change
    add_column :nodes, :topics_count, :integer, :null => false, :default => 0
  end
end
