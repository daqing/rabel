class UpyunImage < ActiveRecord::Base
  belongs_to :user

  attr_accessible :asset

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
