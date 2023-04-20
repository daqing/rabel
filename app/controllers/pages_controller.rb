class PagesController < ApplicationController
  def show
    if current_user && current_user.can_manage_site?
      @page = Page.find_by_key!(params[:key])
    else
      @page = Page.where(:published => true).find_by!(:key => params[:key])
    end

    @title = @page.title

    render layout: 'single-column'
  end
end
