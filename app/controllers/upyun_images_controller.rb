class UpyunImagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    redirect_to root_path if Figaro.env.RABEL_UPYUN_SWITCH != 'on'

    respond_to do |f|
      f.json {
        result = []

        upyun_image_params[:asset].each do |file|
          img = UpyunImage.new(:asset => file)
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

  private
  def upyun_image_params
    params.require(:upyun_image).permit(:asset)
  end
end
