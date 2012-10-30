# encoding: utf-8

class Admin::SiteSettingsController < Admin::BaseController
  def show
    @settings = Siteconf
    @title = '基本设置'
  end

  def appearance
    @settings = Siteconf
    @title = '外观'
  end

  def update
    params[:settings].each_key do |key|
      Siteconf.send("#{key}=", params[:settings][key])
    end
    flash[:success] = '保存成功'
    redirect_to :back
  end
end
