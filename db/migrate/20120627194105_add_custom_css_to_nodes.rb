class AddCustomCssToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :custom_css, :text
  end
end
