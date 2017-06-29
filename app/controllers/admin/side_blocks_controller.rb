# encoding: utf-8
class Admin::SideBlocksController < Admin::BaseController
  def index
    @side_blocks = SideBlock.default_order.all

    @title = '区块'
  end

  def new
    @side_block = SideBlock.new

    @title = '添加区块'

    render :action
  end

  def create
    @side_block = SideBlock.new(side_block_params)

    if @side_block.save
      redirect_to admin_side_blocks_path
    else
      @title = '添加区块'

      render :action
    end
  end

  def edit
    @side_block = SideBlock.find(params[:id])
    @title = '修改区块'

    render :action
  end

  def update
    @side_block = SideBlock.find(params[:id])

    if @side_block.update(side_block_params)
      redirect_to admin_side_blocks_path
    else
      @title = '修改区块'
      render :action
    end
  end

  def destroy
    @side_block = SideBlock.find(params[:id])

    if @side_block.destroy
      redirect_to admin_side_blocks_path
    else
      redirect_to admin_root_path, notice: '无法删除区块'
    end
  end

  def sort
    params[:position].each_with_index do |id, pos|
      SideBlock.update(id, :position => pos)
    end

    head :ok
  end

  private

  def side_block_params
    params.require(:side_block).permit(:name, :body, :on_homepage, :on_otherpage)
  end
end
