# encoding: utf-8
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, :only => [:create]
  before_action :find_comment_and_auth, :only => [:edit, :update, :destroy]

  def create
    redirect_to root_path, :notice => I18n.t('tips.comments_closed') and return if @commentable.try(:comments_closed)

    @comment = CreateComment.new(current_user, @commentable, comment_params).perform
    flash[:error] = '添加回复失败' if @comment.blank?
    redirect_to custom_path(@commentable)
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.js
      else
        render :json => :error, :status => :unprocessable_entity
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js
      else
        render :json => :error, :status => :unprocessable_entity
      end
    end
  end

  private
    def find_comment_and_auth
      render :text => :error, :status => :not_found and return unless current_user.can_manage_site?
      @comment = Comment.find(params[:id])
    end

    def comment_params
      p = params.require(:comment).permit(:content)
      p[:posting_device] = session[:posting_device] if session[:posting_device].present?
      p
    end

end
