class NavLink < ApplicationRecord
  validates :title, :url, presence: true

  def self.sorted
    order("position ASC, created_at ASC")
  end
end
