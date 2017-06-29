class SideBlock < ApplicationRecord
  validates :name, :body, presence: true

  def self.default_order
    order("position ASC, created_at ASC")
  end
end
