class AddPublishedToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :published, :boolean, :default => false
    add_index :pages, :published
  end
end
