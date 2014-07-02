# == Schema Information
#
# Table name: accounts
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  personal_website :string(255)
#  location         :string(255)
#  signature        :string(255)
#  introduction     :text
#  created_at       :datetime
#  updated_at       :datetime
#  weibo_link       :string(255)      default("")
#

class Account < ActiveRecord::Base
  belongs_to :user

  validates :signature, :length => {:maximum => 20}

  before_create :set_default_value

  private
    def set_default_value
      self.personal_website ||= ''
      self.location ||= ''
      self.signature ||= ''
      self.introduction ||= ''
    end

end
