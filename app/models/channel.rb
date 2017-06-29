class Channel < ApplicationRecord
  has_many :topics

  def self.default_order
    order('created_at ASC')
  end
end
