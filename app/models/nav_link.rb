class NavLink < ApplicationRecord
  validates :title, :url, presence: true

  def self.default_order
    order('position ASC, created_at ASC')
  end
end
