class SectionsController < ApplicationController
  def show
    @section = Section.find_by_key!(params[:key])
  end
end
