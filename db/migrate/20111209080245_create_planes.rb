class CreatePlanes < ActiveRecord::Migration[4.2]
  def change
    create_table :planes do |t|
      t.string :name

      t.timestamps
    end
  end
end
