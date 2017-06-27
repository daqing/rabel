class AddPostingDeviceToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :posting_device, :string, null: false, default: ''
  end
end
