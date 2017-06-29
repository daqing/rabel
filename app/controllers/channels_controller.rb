# encoding: utf-8
class ChannelsController < ApplicationController
  def show
    @channel = Channel.find(params[:id])
    @title = "#{@channel.name} - #{Siteconf.site_name}"

    if params[:p].present?
      @page_num = params[:p].to_i
      @title += " (第 #{@page_num} 页)"
    else
      @page_num = 1
    end

    @total_topics = @channel.topics.count
    @total_pages = (@total_topics * 1.0 / Siteconf.pagination_topics.to_i).ceil
    @next_page_num = (@page_num < @total_pages) ? @page_num + 1 : 0
    @prev_page_num = (@page_num > 1) ? @page_num - 1 : 0
    @topics = @channel.topics.page(@page_num).per(Siteconf.pagination_topics.to_i).order('updated_at DESC')

    @canonical_path = "/go/#{params[:key]}"
    @canonical_path += "?p=#{@page_num}" if @page_num > 1
    @seo_description = @channel.name
  end
end
