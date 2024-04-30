class Node < ApplicationRecord
  belongs_to :section

  validates :name, :key, presence: true
end
