class SetTopicsCountOnNodes < ActiveRecord::Migration
  def up
    Node.find_each do |node|
      Node.reset_counters(node.id, :topics)
    end
  end

  def down
    Node.find_each do |node|
      node.update_attribute(:topics_count, 0)
    end
  end
end
