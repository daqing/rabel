# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base
  include UploaderHelper
  include PictureExtensionWhiteList
  include CarrierWave::MimeTypes
  process :set_content_type

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #  "uploads/#{model.class.to_s.underscore}_#{mounted_as}/#{model.id % 100}/#{model.id % 1000}"
  # end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/avatar/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [72, 72]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :medium do
    process :resize_to_fit => [48, 48]
  end

  version :mini do
    process :resize_to_fit => [24, 24]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #  %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #  if original_filename.present?
  #    hashed_name = Digest::MD5.hexdigest(original_filename)[5..10]
  #    "#{hashed_name}.#{file.extension}"
  #  end
  # end
end
