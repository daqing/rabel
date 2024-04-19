class Forum::HomeController < ApplicationController
  def index
    @title = "#{Siteconf.site_name} - 论坛"
  end
end
