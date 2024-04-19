class Feed::HomeController < ApplicationController
  def index
    @title = "#{Siteconf.site_name} - 动态"
  end
end
