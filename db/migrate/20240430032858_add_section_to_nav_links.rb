class AddSectionToNavLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :nav_links, :section, :string
  end
end
