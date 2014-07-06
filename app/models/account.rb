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
