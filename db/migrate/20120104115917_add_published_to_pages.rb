class AddPublishedToPages < ActiveRecord::Migration
  def change
    add_column :pages, :published, :boolean, :default => false
    add_index :pages, :published
  end
end
