class PagesController < ApplicationController
  def show
    @page = if current_user&.can_manage_site?
              Page.find_by_key!(params[:key])
            else
              Page.where(published: true).find_by!(key: params[:key])
            end

    @title = @page.title
  end
end
