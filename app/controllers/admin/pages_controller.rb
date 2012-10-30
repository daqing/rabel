# encoding: utf-8
class Admin::PagesController < Admin::BaseController
  before_filter :find_page, :only => [:edit, :update, :destroy]

  def index
    @pages = Page.default_order
    @title = '页面'
  end

  def new
    @page = Page.new
    @title = '创建新页面'
    render :action
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to admin_pages_path
    else
      @title = '创建新页面'
      render :action
    end
  end

  def edit
    @title = '修改页面'
    render :action
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to admin_pages_path
    else
      @title = '编辑页面'
      render :action
    end
  end

  def destroy
    if @page.destroy
      redirect_to admin_pages_path
    else
      flash[:error] = '删除页面出错'
      redirect_to admin_root_path
    end
  end

  def sort
    params[:position].each_with_index do |id, pos|
      Page.update(id, :position => pos)
    end

    respond_to do |format|
      format.js { head :ok }
    end
  end

end
