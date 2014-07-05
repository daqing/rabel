class Plane < ActiveRecord::Base
  include Rabel::ActiveCache
  include Sortable

  validates :name, :presence => true
  has_many :nodes, :order => Node.default_order_str

  attr_accessible :name, :position

  def can_delete?
    self.nodes.count == 0
  end
end
