class ArticlesController < ApplicationController
  def index
    @title = "#{Siteconf.site_name} - 最新文章"
  end
end
