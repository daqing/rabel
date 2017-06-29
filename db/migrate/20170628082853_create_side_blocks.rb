class CreateSideBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :side_blocks do |t|
      t.string :name
      t.text :body
      t.integer :position, default: 0
      t.boolean :on_homepage, default: false
      t.boolean :on_otherpage, default: false

      t.timestamps
    end
  end
end
