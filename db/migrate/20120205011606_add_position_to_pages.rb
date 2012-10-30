class AddPositionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :position, :integer
    add_index :pages, :position
  end
end
