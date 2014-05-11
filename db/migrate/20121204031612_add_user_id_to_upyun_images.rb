class AddUserIdToUpyunImages < ActiveRecord::Migration
  def change
    add_column :upyun_images, :user_id, :integer
    add_index :upyun_images, :user_id
  end
end
