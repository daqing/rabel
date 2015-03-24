class Channel < ActiveRecord::Base
  has_many :topics

  def self.default_order
    order('created_at ASC')
  end
end
