# encoding: utf-8
class Admin::ChannelsController < Admin::BaseController
  def index
    @channels = Channel.default_order.all

    @title = '讨论区'
  end

  def new
    @channel = Channel.new

    @title = '添加讨论区'

    render :action
  end

  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      redirect_to admin_channels_path
    else
      @title = '添加讨论区'

      render :action
    end
  end

  def edit
    @channel = Channel.find(params[:id])
    @title = '修改讨论区'

    render :action
  end

  def update
    @channel = Channel.find(params[:id])

    if @channel.update(channel_params)
      redirect_to admin_channels_path
    else
      @title = '修改讨论区'
      render :action
    end
  end

  def destroy
    @channel = Channel.find(params[:id])

    if @channel.destroy
      redirect_to admin_channels_path
    else
      redirect_to admin_root_path, notice: '无法删除讨论区'
    end
  end

  private

  def channel_params
    params.require(:channel).permit(:name)
  end
end
