class Admin::NavLinksController < Admin::BaseController
  def index
    @nav_links = NavLink.sorted.all

    @title = "\u5BFC\u822A\u94FE\u63A5"
  end

  def new
    @nav_link = NavLink.new

    @title = "\u6DFB\u52A0\u5BFC\u822A\u94FE\u63A5"

    render :action
  end

  def create
    @nav_link = NavLink.new(nav_link_params)

    if @nav_link.save
      redirect_to admin_nav_links_path
    else
      @title = "\u6DFB\u52A0\u5BFC\u822A\u94FE\u63A5"

      render :action
    end
  end

  def edit
    @nav_link = NavLink.find(params[:id])
    @title = "\u4FEE\u6539\u5BFC\u822A\u94FE\u63A5"

    render :action
  end

  def update
    @nav_link = NavLink.find(params[:id])

    if @nav_link.update(nav_link_params)
      redirect_to admin_nav_links_path
    else
      @title = "\u4FEE\u6539\u5BFC\u822A\u94FE\u63A5"
      render :action
    end
  end

  def destroy
    @nav_link = NavLink.find(params[:id])

    if @nav_link.destroy
      redirect_to admin_nav_links_path
    else
      redirect_to admin_root_path, notice: "\u65E0\u6CD5\u5220\u9664\u5BFC\u822A\u94FE\u63A5"
    end
  end

  def sort
    params[:position].each_with_index do |id, pos|
      NavLink.update(id, position: pos)
    end

    head :ok
  end

  private

  def nav_link_params
    params.require(:nav_link).permit(:title, :url)
  end
end
