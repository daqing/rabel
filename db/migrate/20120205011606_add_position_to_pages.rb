class AddPositionToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :position, :integer
    add_index :pages, :position
  end
end
