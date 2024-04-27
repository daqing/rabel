class ArticlesController < ApplicationController
  def index
    @title = "最新文章 - #{Siteconf.site_name} "
  end

  def show
    @title = "Ditch your free plan"
  end
end
