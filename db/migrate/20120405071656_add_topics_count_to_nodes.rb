class AddTopicsCountToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :topics_count, :integer, :null => false, :default => 0
  end
end
