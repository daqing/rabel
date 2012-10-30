class SetCommentsCountOnTopics < ActiveRecord::Migration
  def up
    Topic.find_each do |t|
      Topic.reset_counters(t.id, :comments)
    end
  end

  def down
    Topic.find_each do |t|
      t.update_attribute(:comments_count, 0)
    end
  end
end
