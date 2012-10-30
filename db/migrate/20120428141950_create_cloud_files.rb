class CreateCloudFiles < ActiveRecord::Migration
  def change
    create_table :cloud_files do |t|
      t.string :content_type
      t.integer :file_size
      t.string :asset
      t.string :name

      t.timestamps
    end
  end
end
