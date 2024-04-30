class RefineNodesTable < ActiveRecord::Migration[7.1]
  def change
    rename_column :nodes, :plane_id, :section_id
    remove_column :nodes, :topics_count, :integer
    remove_column :nodes, :quiet, :boolean
  end
end
