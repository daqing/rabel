class AddAssetToQiniuImages < ActiveRecord::Migration[4.2]
  def change
    add_column :qiniu_images, :asset, :string
  end
end
