class UpyunImage < ActiveRecord::Base
  attr_accessible :asset

  mount_uploader :asset, UpyunImageUploader

  validates :asset, :presence => true
  validates_integrity_of :asset

end
