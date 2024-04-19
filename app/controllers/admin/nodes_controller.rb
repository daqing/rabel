class Admin::NodesController < Admin::BaseController
  before_action :find_node, only: %i[move move_to destroy]

  def index
    @nodes = Node.all
  end

  def new
    @node = Node.new
    respond_to do |format|
      format.html do
        @title = "\u6DFB\u52A0\u8282\u70B9"
        render :show_form
      end
    end
  end

  def create
    @node = Node.new(node_params)
    respond_to do |format|
      if @node.save
        format.js
      else
        format.js { render :show_form }
      end
    end
  end

  def edit
    @node = Node.find(params[:id])
    respond_to do |format|
      format.js do
        @title = "\u4FEE\u6539\u8282\u70B9"
        render :show_form
      end
    end
  end

  def update
    @node = Node.find(params[:id])
    respond_to do |format|
      if @node.update(node_params)
        format.js
      else
        format.js { render :show_form }
      end
    end
  end

  def sort
    params[:position].each_with_index do |id, pos|
      Node.update(id, position: pos)
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
      f.js do
        unless @node.update(params.require(:node).permit(:plane_id))
          render text: :error,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @node.can_delete? and @node.destroy
        format.js
      else
        format.js { render text: :error, status: :unprocessable_entity }
      end
    end
  end

  private

  def node_params
    params.require(:node).permit(:name, :key, :introduction, :custom_html, :position, :quiet, :custom_css)
  end
end
