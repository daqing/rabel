class RenameChannelToSection < ActiveRecord::Migration[7.1]
  def change
    rename_table :channels, :sections
  end
end
