# encoding: utf-8
class Admin::NavLinksController < Admin::BaseController
  def index
    @nav_links = NavLink.default_order.all

    @title = '导航链接'
  end

  def new
    @nav_link = NavLink.new

    @title = '添加导航链接'

    render :action
  end

  def create
    @nav_link = NavLink.new(nav_link_params)

    if @nav_link.save
      redirect_to admin_nav_links_path
    else
      @title = '添加导航链接'

      render :action
    end
  end

  def edit
    @nav_link = NavLink.find(params[:id])
    @title = '修改导航链接'

    render :action
  end

  def update
    @nav_link = NavLink.find(params[:id])

    if @nav_link.update(nav_link_params)
      redirect_to admin_nav_links_path
    else
      @title = '修改导航链接'
      render :action
    end
  end

  def destroy
    @nav_link = NavLink.find(params[:id])

    if @nav_link.destroy
      redirect_to admin_nav_links_path
    else
      redirect_to admin_root_path, notice: '无法删除导航链接'
    end
  end

  def sort
    params[:position].each_with_index do |id, pos|
      NavLink.update(id, :position => pos)
    end

    head :ok
  end

  private

  def nav_link_params
    params.require(:nav_link).permit(:title, :url)
  end
end
