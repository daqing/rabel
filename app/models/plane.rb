# == Schema Information
#
# Table name: planes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  position   :integer          default(0), not null
#

class Plane < ActiveRecord::Base
  include Rabel::ActiveCache
  include Sortable

  validates :name, :presence => true
  has_many :nodes, -> { order(Node.default_order_str) }

  def can_delete?
    self.nodes.count == 0
  end
end
