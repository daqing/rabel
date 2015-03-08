class QiniuImage < ActiveRecord::Base
  belongs_to :user

  mount_uploader :asset, QiniuImageUploader

  validates :asset, :content_type, :size, :filename, :presence => true
  validates_integrity_of :asset

  before_validation :set_metadata

  private
    def set_metadata
      self.content_type = asset.file.content_type
      self.size = asset.file.size
    end

end
