class CreatePages < ActiveRecord::Migration[4.2]
  def change
    create_table :pages do |t|
      t.string :key
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
