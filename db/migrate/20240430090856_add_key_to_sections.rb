class AddKeyToSections < ActiveRecord::Migration[7.1]
  def change
    add_column :sections, :key, :string
  end
end
