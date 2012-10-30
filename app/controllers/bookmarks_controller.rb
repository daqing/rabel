# encoding: utf-8
class BookmarksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_bookmarkable, :only => :create

  def create
    @bookmark = @bookmarkable.bookmarks.build
    @bookmark.user = current_user
    flash[:error] = '收藏失败' unless @bookmark.save
    redirect_to custom_path(@bookmarkable)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize! :update, @bookmark
    if @bookmark.destroy
      redirect_to custom_path(@bookmark.bookmarkable)
    else
      flash[:error] = '取消收藏失败'
      redirect_to root_path
    end
  end

end
