# == Schema Information
#
# Table name: cloud_files
#
#  id           :integer          not null, primary key
#  content_type :string(255)
#  file_size    :integer
#  asset        :string(255)
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class CloudFile < ActiveRecord::Base

  mount_uploader :asset, CloudFileUploader

  validates :name, :asset, :presence => true

  before_create :save_metadata
  private
    def save_metadata
      self.content_type = asset.file.content_type
      self.file_size = asset.file.size
    end
end
