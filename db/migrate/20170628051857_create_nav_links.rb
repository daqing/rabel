class CreateNavLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :nav_links do |t|
      t.string :title
      t.string :url
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
