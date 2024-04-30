class SectionsController < ApplicationController
  def show
    @section = Section.find_by_key!(params[:key])

    @mini_logs = @section.mini_logs.includes(:user).order(created_at: :desc).limit(10)

    @navbar_name = "首页"
  end
end
