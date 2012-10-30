class AddIndexToPages < ActiveRecord::Migration
  def change
    add_index :pages, :key
  end
end
