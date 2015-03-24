class PagesController < ApplicationController
  def show
    if current_user && current_user.can_manage_site?
      @page = Page.find_by_key!(params[:key])
    else
      @page = Page.where(:published => true).find_by!(:key => params[:key])
    end

    @title = @page.title

    if @page.content.size > 100
      @seo_description = @page.content.slice(0, 100) + '...'
    else
      @seo_description = @page.content
    end
  end
end
