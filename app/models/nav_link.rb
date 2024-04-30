class NavLink < ApplicationRecord
  validates :title, :url, :section, presence: true

  def self.navbar
    where(section: "navbar").sorted
  end

  def self.header
    where(section: "header").sorted
  end

  def self.sorted
    order("position ASC, created_at ASC")
  end
end
