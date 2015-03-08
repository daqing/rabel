class QiniuImagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    redirect_to root_path and return if Figaro.env.RABEL_QINIU_SWITCH != 'on'

    respond_to do |f|
      f.json {
        result = []

        params[:qiniu_image][:asset].each do |file|
          img = QiniuImage.new(:asset => file)
          img.filename = file.original_filename
          img.user = current_user
          if img.save
            result << {
              :name => file.original_filename,
              :size => img.size,
              :url => img.asset.url,
              :thumbnail_url => img.asset.url,
              :delete_url => upyun_image_path(img),
              :delete_type => 'DELETE'
            }
          end
        end

        render :json => result
      }
    end
  end
end
