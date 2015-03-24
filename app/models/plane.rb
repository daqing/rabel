class Plane < ActiveRecord::Base
  include Sortable

  validates :name, :presence => true
  has_many :nodes, -> { order(Node.default_order_str) }

  def can_delete?
    self.nodes.count == 0
  end
end
