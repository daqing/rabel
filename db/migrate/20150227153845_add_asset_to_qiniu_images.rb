class AddAssetToQiniuImages < ActiveRecord::Migration
  def change
    add_column :qiniu_images, :asset, :string
  end
end
