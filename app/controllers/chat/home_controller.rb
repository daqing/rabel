class Chat::HomeController < ApplicationController
  def index
    @title = "#{Siteconf.site_name} - 聊天室"
  end
end
