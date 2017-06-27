class CreateQiniuImages < ActiveRecord::Migration[4.2]
  def change
    create_table :qiniu_images do |t|

      t.timestamps
    end
  end
end
