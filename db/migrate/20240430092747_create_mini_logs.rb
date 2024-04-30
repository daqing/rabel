class CreateMiniLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :mini_logs do |t|
      t.references :section, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
