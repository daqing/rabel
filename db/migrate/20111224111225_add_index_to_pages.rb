class AddIndexToPages < ActiveRecord::Migration[4.2]
  def change
    add_index :pages, :key
  end
end
