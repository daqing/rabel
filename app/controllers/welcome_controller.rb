# encoding: utf-8
class WelcomeController < ApplicationController
  def index
    @topics = Topic.home_topics(Siteconf::HOMEPAGE_TOPICS)
    @sticky_topics = Topic.sticky_topics
    @canonical_path = '/'
    @full_title = site_intro

    respond_to do |format|
      format.html
      format.mobile { @planes = Plane.all }
    end
  end

  def goodbye
    @title = '登出'

    respond_to do |format|
      format.html
      format.mobile { add_breadcrumb @title }
    end
  end

  def captcha
    head :ok and return unless Siteconf.show_captcha?

    respond_to do |format|
      format.gif {
        session[:captcha] = Rabel::Captcha.random_code
        send_data Rabel::Captcha.image(session[:captcha]), :type => 'image/gif', :disposition => 'ineline'
      }
    end
  end
end
