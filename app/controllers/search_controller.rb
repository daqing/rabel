# coding: utf-8
class SearchController < ApplicationController
  def index
    
    if !params[:query].empty?
      @lists = Sunspot.search Topic do
        keywords params[:query], :highlight => true
        paginate(:page => params[:page] || 1, :per_page => 20)
      end.results
      @keyword=params[:query]
      @lists_amount=@lists.total_entries.to_s
      
      respond_to do |format|
        format.html { render :action => "index" }
        format.xml { render :xml => @lists }
      end
    else
      redirect_to root_path
    end
  end
end
