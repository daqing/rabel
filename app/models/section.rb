class Section < ApplicationRecord
  has_many :nodes
  has_many :topics
  has_many :mini_logs

  validates :name, :key, presence: true

  def self.sorted
    order("position ASC, created_at ASC")
  end
end
