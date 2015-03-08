# encoding: utf-8
class TopicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_node, :except => [:show, :index, :preview, :toggle_comments_closed, :toggle_sticky, :new_from_home, :create_from_home]
  before_filter :find_topic_and_auth, :only => [:edit_title,:update_title,
    :edit, :update, :move, :destroy]
  before_filter :only => [:toggle_comments_closed, :toggle_sticky] do |c|
    auth_admin
  end

  def index
    respond_to do |format|
      format.html {
        per_page = Siteconf::HOMEPAGE_TOPICS
        @title = '全站最新更改记录'
        if params[:page].present?
          current_page = params[:page].to_i
          @title += " (第 #{current_page} 页)"
        else
          current_page = 1
        end

        @topics = Topic.cached_pagination(current_page, per_page, 'updated_at')

        @canonical_path = topics_path
        @canonical_path += "?page=#{current_page}" if current_page > 1

        @seo_description = @title
      }
      format.atom {
        @feed_items = Topic.recent_topics(Siteconf::HOMEPAGE_TOPICS)
        @last_update = @feed_items.first.updated_at unless @feed_items.empty?
        render :layout => false
      }
    end
  end

  def show
    raise ActiveRecord::RecordNotFound.new if params[:id].to_i.to_s != params[:id]

    @topic = Topic.find_cached(params[:id])
    store_location

    Topic.increment_counter(:hit, @topic.id)

    @title = @topic.title
    @node = @topic.cached_assoc_object(:node)

    @total_comments = @topic.comments_count
    @total_pages = (@total_comments * 1.0 / Siteconf.pagination_comments.to_i).ceil
    @current_page = params[:p].nil? ? @total_pages : params[:p].to_i
    @per_page = Siteconf.pagination_comments.to_i
    @comments = @topic.cached_assoc_pagination(:comments, @current_page, @per_page, 'created_at', Rabel::Model::ORDER_ASC)

    @new_comment = @topic.comments.new
    @total_bookmarks = @topic.bookmarks.count

    @canonical_path = "/t/#{params[:id]}"
    @canonical_path += "?p=#{@current_page}" if @total_pages > 1
    @seo_description = "#{@node.name} - #{@topic.user.nickname} - #{@topic.title}"

    @prev_topic = @topic.prev_topic(@node)
    @next_topic = @topic.next_topic(@node)

    respond_to do |format|
      format.html
    end
  end

  def new
    @topic = @node.topics.new

    respond_to do |format|
      format.html
    end
  end

  def new_from_home
    @topic = Topic.new
  end

  def create
    @topic = @node.topics.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to t_path(@topic.id)
    else
      render :new
    end
  end

  def create_from_home
    @topic = Topic.new(topic_params)
    @topic.user = current_user

    if @topic.save
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
        unless @topic.update_attributes(topic_params)
          render :text => :error, :status => :unprocessable_entity
        end
      }
    end
  end

  def edit
  end

  def update
    if params[:new_node_id].present?
      # move to new node
      @new_node = Node.find(params[:new_node_id])
      respond_to do |format|
        format.js {
          if @new_node.present?
            @topic.node = @new_node
            if @topic.save
              render :js => "window.location.reload()"
            else
              render :js => "$.facebox('移动帖子失败')"
            end
          else
            render :js => "$.facebox('节点不存在')"
          end
        }
      end
    else
      if @topic.update_attributes(topic_params)
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
      redirect_to root_path, :notice => '帖子删除成功'
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
        render :text => :error, :status => :unprocessable_entity
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
    def find_node
      @node = Node.find(params[:node_id])
    end

    def find_topic_and_auth
      @topic = @node.topics.find(params[:id])
      authorize! :update, @topic, :message => '你没有权限管理此主题'
    end

    def topic_params
      if current_user.can_manage_site?
        params.require(:topic).permit(:title, :content, :node_id, :comments_closed, :sticky)
      else
        params.require(:topic).permit(:title, :content, :node_id)
      end
    end
end
