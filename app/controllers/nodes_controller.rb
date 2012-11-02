# encoding: utf-8
class NodesController < ApplicationController
  def show
    @node = Node.find_by_attr_cached!(:key, params[:key])
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
    @topics = @node.cached_assoc_pagination(:topics, @page_num, Siteconf.pagination_topics.to_i, 'updated_at')

    @canonical_path = "/go/#{params[:key]}"
    @canonical_path += "?p=#{@page_num}" if @page_num > 1
    @seo_description = "#{@node.name} - #{@node.introduction}"

    respond_to do |format|
      format.html
      format.mobile { add_breadcrumb @node.name }
    end
  end
end
