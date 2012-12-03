class CreateUpyunImages < ActiveRecord::Migration
  def change
    create_table :upyun_images do |t|
      t.string :asset

      t.timestamps
    end
  end
end
