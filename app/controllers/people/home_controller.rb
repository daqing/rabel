class People::HomeController < ApplicationController
  def index
    @title = "#{Siteconf.site_name} - 成员"
  end
end
