class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :link
      t.string :banner
      t.string :title
      t.string :words
      t.date :start_date
      t.date :expire_date
      t.integer :duration

      t.timestamps
    end
  end
end
