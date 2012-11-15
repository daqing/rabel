# encoding: utf-8
class Admin::PlanesController < Admin::BaseController
  before_filter :find_plane, :only => [:edit, :update, :destroy]

  def index
    @planes = Plane.default_order
    @title = '位面节点'
  end

  def new
    @title = '添加位面'
    @plane = Plane.new
    respond_to do |format|
      format.js { render :show_form }
    end
  end

  def create
    @plane = Plane.new(params[:plane])
    respond_to do |format|
      if @plane.save
        format.js
      else
        format.js { render :show_form }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js {
        @title = '修改位面'
        render :show_form
      }
    end
  end

  def update
    respond_to do |format|
      if @plane.update_attributes(params[:plane])
        format.js { render :js => 'window.location.reload()' }
      else
        format.js { render :show_form }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @plane.can_delete? and @plane.destroy
        format.js
      else
        format.js { render :json => {:error => 'delete plane failed'}, :status => :unprocessable_entity }
      end
    end
  end

  def sort
    if params[:position].present?
      params[:position].each_with_index do |id, pos|
        Plane.update(id, :position => pos)
      end

      respond_to do |f|
        f.js { head :ok }
      end
    else
      respond_to do |f|
        f.js {
          @planes = Plane.default_order
        }
      end
    end
  end
end
