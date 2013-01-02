class DropPlanesTable < ActiveRecord::Migration
  def up
    drop_table :planes
  end

  def down
    create_table :planes do |t|
      t.string :name

      t.timestamps
    end
  end
end
