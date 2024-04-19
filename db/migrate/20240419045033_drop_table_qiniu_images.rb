class DropTableQiniuImages < ActiveRecord::Migration[7.1]
  def change
    drop_table :qiniu_images
  end
end
