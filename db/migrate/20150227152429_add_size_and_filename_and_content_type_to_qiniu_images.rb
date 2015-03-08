class AddSizeAndFilenameAndContentTypeToQiniuImages < ActiveRecord::Migration
  def change
    add_column :qiniu_images, :size, :integer
    add_column :qiniu_images, :filename, :string
    add_column :qiniu_images, :content_type, :string
    add_column :qiniu_images, :user_id, :integer
  end
end
