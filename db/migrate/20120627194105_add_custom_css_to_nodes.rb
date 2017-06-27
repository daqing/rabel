class AddCustomCssToNodes < ActiveRecord::Migration[4.2]
  def change
    add_column :nodes, :custom_css, :text
  end
end
