require 'digest'
require 'carrierwave/processing/mime_types'

module UploaderHelper
  def store_dir
    "uploads/#{model.class.to_s.underscore}_#{mounted_as}/#{model.id % 100}/#{model.id % 1000}"
  end

  def cache_dir
    "/tmp"
  end

  def filename
    if original_filename.present?
      hashed_name = Digest::MD5.hexdigest(File.dirname(current_path))[5..15]
      "#{hashed_name}.#{file.extension}"
    end
  end
end
