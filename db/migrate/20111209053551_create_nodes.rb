class CreateNodes < ActiveRecord::Migration[4.2]
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :key
      t.string :introduction
      t.text :custom_html

      t.timestamps
    end
  end
end
