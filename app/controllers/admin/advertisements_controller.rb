# encoding: utf-8
class Admin::AdvertisementsController < Admin::BaseController
  before_action :find_ad, :only => [:edit, :update, :destroy]

  def index
    @ads = Advertisement.order('start_date DESC').page(params[:page]).per(4)
    @title = '广告位'
  end

  def new
    @ad = Advertisement.new
    @title = '添加新广告'
  end

  def create
    @ad = Advertisement.new(ad_params)
    if @ad.save
      redirect_to admin_advertisements_path
    else
      flash[:error] = '添加新广告失败'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @title = '修改广告'
  end

  def update
    if @ad.update(ad_params)
      redirect_to admin_advertisements_path
    else
      flash[:error] = '修改广告失败'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @ad.destroy
      flash[:success] = '删除成功'
    else
      flash[:success] = '删除失败'
    end
    redirect_to admin_advertisements_path
  end

  private

  def find_ad
    @ad = Advertisement.find(params[:id])
  end

  def ad_params
    params.require(:advertisement).permit(:link, :banner, :title, :words, :start_date, :expire_date, :duration)
  end
end
