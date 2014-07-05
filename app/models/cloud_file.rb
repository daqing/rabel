class CloudFile < ActiveRecord::Base
  attr_accessible :name, :asset

  mount_uploader :asset, CloudFileUploader

  validates :name, :asset, :presence => true

  before_create :save_metadata
  private
    def save_metadata
      self.content_type = asset.file.content_type
      self.file_size = asset.file.size
    end
end
