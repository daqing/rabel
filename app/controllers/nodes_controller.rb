class NodesController < ApplicationController
  def show
    @node = Node.find_by_attr_cached!(:key, params[:key])
    @title = @node.name
    @page_num = params[:p].nil? ? 1 : params[:p].to_i
    @total_topics = @node.topics_count
    @total_pages = (@total_topics * 1.0 / Siteconf.pagination_topics.to_i).ceil
    @next_page_num = (@page_num < @total_pages) ? @page_num + 1 : 0
    @prev_page_num = (@page_num > 1) ? @page_num - 1 : 0
    @topics = @node.cached_assoc_pagination(:topics, @page_num, Siteconf.pagination_topics.to_i, 'updated_at')

    @canonical_path = "/go/#{params[:key]}?p=#{@page_num}"
    @seo_description = "#{@node.name} - #{@node.introduction}"

    respond_to do |format|
      format.html
      format.mobile { add_breadcrumb @node.name }
    end
  end
end
