class AddSizeAndFilenameAndContentTypeToUpyunImages < ActiveRecord::Migration[4.2]
  def change
    add_column :upyun_images, :size, :integer
    add_column :upyun_images, :filename, :string
    add_column :upyun_images, :content_type, :string
  end
end
