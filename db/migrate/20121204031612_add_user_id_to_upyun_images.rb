class AddUserIdToUpyunImages < ActiveRecord::Migration[4.2]
  def change
    add_column :upyun_images, :user_id, :integer
    add_index :upyun_images, :user_id
  end
end
