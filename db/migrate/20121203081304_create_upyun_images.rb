class CreateUpyunImages < ActiveRecord::Migration[4.2]
  def change
    create_table :upyun_images do |t|
      t.string :asset

      t.timestamps
    end
  end
end
