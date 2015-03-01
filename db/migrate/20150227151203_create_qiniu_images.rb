class CreateQiniuImages < ActiveRecord::Migration
  def change
    create_table :qiniu_images do |t|

      t.timestamps
    end
  end
end
