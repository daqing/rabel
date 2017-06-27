# encoding: utf-8
class Admin::NodesController < Admin::BaseController
  before_action :find_parent_plane, :except => [:sort, :destroy, :move, :move_to]
  before_action :find_node, :only => [:move, :move_to, :destroy]

  def new
    @node = @plane.nodes.new
    respond_to do |format|
      format.js {
        @title = '添加节点'
        render :show_form
      }
    end
  end

  def create
    @node = @plane.nodes.build(node_params)
    respond_to do |format|
      if @node.save
        format.js
      else
        format.js { render :show_form }
      end
    end
  end

  def edit
    @node = @plane.nodes.find(params[:id])
    respond_to do |format|
      format.js {
        @title = '修改节点'
        render :show_form
      }
    end
  end

  def update
    @node = @plane.nodes.find(params[:id])
    respond_to do |format|
      if @node.update_attributes(node_params)
        format.js
      else
        format.js { render :show_form }
      end
    end
  end

  def sort
    params[:position].each_with_index do |id, pos|
      Node.update(id, :position => pos)
    end

    respond_to do |format|
      format.js { head :ok }
    end
  end

  def move
    respond_to do |f|
      f.js
    end
  end

  def move_to
    respond_to do |f|
      f.js {
        render :text => :error, :status => :unprocessable_entity unless @node.update(params.require(:node).permit(:plane_id))
      }
    end
  end

  def destroy
    respond_to do |format|
      if @node.can_delete? and @node.destroy
        format.js
      else
        format.js { render :text => :error, :status => :unprocessable_entity }
      end
    end
  end

  private
  def node_params
    params.require(:node).permit(:name, :key, :introduction, :custom_html, :position, :quiet, :custom_css)
  end
end
