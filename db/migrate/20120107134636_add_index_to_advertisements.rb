class AddIndexToAdvertisements < ActiveRecord::Migration
  def change
    change_table :advertisements do |t|
      t.index :start_date
      t.index :expire_date
    end
  end
end
