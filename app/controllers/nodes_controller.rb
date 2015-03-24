# encoding: utf-8
class NodesController < ApplicationController
  def show
    @node = Node.where(key: params[:key]).first
    @title = @node.name

    if params[:p].present?
      @page_num = params[:p].to_i
      @title += " (第 #{@page_num} 页)"
    else
      @page_num = 1
    end

    @total_topics = @node.topics_count
    @total_pages = (@total_topics * 1.0 / Siteconf.pagination_topics.to_i).ceil
    @next_page_num = (@page_num < @total_pages) ? @page_num + 1 : 0
    @prev_page_num = (@page_num > 1) ? @page_num - 1 : 0
    @topics = @node.topics.page(@page_num).per(Siteconf.pagination_topics.to_i).order('updated_at DESC')

    @canonical_path = "/go/#{params[:key]}"
    @canonical_path += "?p=#{@page_num}" if @page_num > 1
    @seo_description = "#{@node.name} - #{@node.introduction}"

    respond_to do |format|
      format.html
    end
  end
end
