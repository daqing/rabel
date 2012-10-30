class AddPostingDeviceToComments < ActiveRecord::Migration
  def change
    add_column :comments, :posting_device, :string, null: false, default: ''
  end
end
