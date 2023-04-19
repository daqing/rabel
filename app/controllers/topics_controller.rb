# encoding: utf-8
class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_channel, except: [:show, :index, :preview, :toggle_comments_closed, :toggle_sticky, :new_from_home, :create_from_home]
  before_action :find_topic_and_auth, only: [:edit_title,:update_title,
    :edit, :update, :move, :destroy]
  before_action only: [:toggle_comments_closed, :toggle_sticky] do |c|
    auth_admin
  end

  def index
    per_page = 20
    @title = '全站最新更改记录'
    if params[:page].present?
      current_page = params[:page].to_i
      @title += " (第 #{current_page} 页)"
    else
      current_page = 1
    end

    @topics = Topic.page(current_page).per(per_page).order('updated_at DESC')
  end

  def show
    @topic = Topic.find(params[:id])
    store_location

    Topic.increment_counter(:hit, @topic.id)

    @channel = @topic.channel
    @title = "#{@topic.title} - #{@channel.name}"

    @total_comments = @topic.comments.count
    @total_pages = (@total_comments * 1.0 / Siteconf.pagination_comments.to_i).ceil
    @current_page = params[:p].nil? ? @total_pages : params[:p].to_i
    @per_page = Siteconf.pagination_comments.to_i
    @comments = @topic.comments.page(@current_page).per(@per_page).order('created_at ASC')

    @new_comment = @topic.comments.new
    @total_bookmarks = @topic.bookmarks.count

    @prev_topic = PrevTopicQuery.new(@channel, @topic).get!
    @next_topic = NextTopicQuery.new(@channel, @topic).get!
  end

  def new
    @topic = @channel.topics.new

    @title = build_title('创建新话题')
  end

  def new_from_home
    @topic = Topic.new
    @topic.channel = Channel.find(params[:channel_id]) if params[:channel_id]

    @title = build_title('创建新话题')
    render layout: 'single-column'
  end

  def create
    if CreateTopic.with(current_user, @channel, topic_params)
      redirect_to t_path(@topic.id)
    else
      render :new
    end
  end

  def create_from_home
    @channel = Channel.find(params[:topic][:channel_id])

    @topic = CreateTopic.with(current_user, @channel, topic_params)
    if @topic
      redirect_to t_path(@topic.id)
    else
      render :new_from_home
    end
  end

  def edit_title
    respond_to do |f|
      f.js
    end
  end

  def update_title
    respond_to do |f|
      f.js {
        unless @topic.update(topic_params)
          render text: :error, status: :unprocessable_entity
        end
      }
    end
  end

  def edit
  end

  def update
    if params[:new_channel_id].present?
      # move to new channel
      @new_channel = Channel.find(params[:new_channel_id])
      respond_to do |format|
        format.js {
          if @new_channel.present?
            @topic.channel = @new_channel
            if @topic.save
              render js: "window.location.reload()"
            else
              render js: "$.facebox('移动帖子失败')"
            end
          else
            render js: "$.facebox('节点不存在')"
          end
        }
      end
    else
      if @topic.update(topic_params)
        redirect_to t_path(@topic.id)
      else
        flash[:error] = '之前的更新有误，请编辑后再提交'
        render :edit
      end
    end
  end

  def move
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @topic.destroy
      redirect_to root_path, notice: '帖子删除成功'
    else
      raise RuntimeError.new('删除帖子出错')
    end
  end

  def preview
    @type = ['topic', 'comment', 'page'].delete params[:type]
    respond_to do |f|
      if @type.present?
        f.text { @content = params[:content] }
      else
        render text: :error, status: :unprocessable_entity
      end
    end
  end

  def toggle_comments_closed
    @topic = Topic.find(params[:topic_id])
    @topic.toggle!(:comments_closed)
    @topic.touch
    redirect_to t_path(@topic.id)
  end

  def toggle_sticky
    @topic = Topic.find(params[:topic_id])
    @topic.toggle!(:sticky)
    @topic.touch
    redirect_to t_path(@topic.id)
  end

  private
    def find_channel
      @channel = Channel.find(params[:channel_id])
    end

    def find_topic_and_auth
      @topic = @channel.topics.find(params[:id])
      authorize! :update, @topic, message: '你没有权限管理此主题'
    end

    def topic_params
      if current_user.can_manage_site?
        params.require(:topic).permit(:title, :content, :comments_closed, :sticky)
      else
        params.require(:topic).permit(:title, :content)
      end
    end
end
