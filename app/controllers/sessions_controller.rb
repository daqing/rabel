# encoding: utf-8
class SessionsController < Devise::SessionsController
  def new
    @title = '登入'
    @seo_description = @title

    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    if mobile_device?
      redirect_to root_path
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

end
