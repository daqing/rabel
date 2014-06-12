# == Schema Information
#
# Table name: upyun_images
#
#  id           :integer          not null, primary key
#  asset        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  size         :integer
#  filename     :string(255)
#  content_type :string(255)
#

class UpyunImage < ActiveRecord::Base
  belongs_to :user


  mount_uploader :asset, UpyunImageUploader

  validates :asset, :content_type, :size, :filename, :presence => true
  validates_integrity_of :asset

  before_validation :set_metadata

  private
    def set_metadata
      self.content_type = asset.file.content_type
      self.size = asset.file.size
    end

end
