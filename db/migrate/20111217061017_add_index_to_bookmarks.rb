class AddIndexToBookmarks < ActiveRecord::Migration
  def change
    change_table :bookmarks do |t|
      t.index :user_id
      t.index [:bookmarkable_id, :bookmarkable_type]
    end
  end
end
