# encoding: utf-8
class WelcomeController < ApplicationController
  def index
    @topics = Topic.home_topics(Siteconf::HOMEPAGE_TOPICS)
    @sticky_topics = Topic.sticky_topics
    @canonical_path = '/'
    @full_title = site_intro
    @seo_description = Siteconf.seo_description

    respond_to do |format|
      format.html
    end
  end

  def goodbye
    @title = '登出'

    respond_to do |format|
      format.html
    end
  end

  def captcha
    head :ok and return unless Siteconf.show_captcha?

    respond_to do |format|
      format.gif {
        expires_now
        session[:captcha] = Rabel::Captcha.random_code
        send_data Rabel::Captcha.image(session[:captcha]), :type => 'image/gif', :disposition => 'inline'
      }
    end
  end

  def sitemap
    respond_to do |f|
      f.xml {
        max = 50000
        @lastmod = [
          Topic.order('updated_at DESC').first.try(:updated_at),
          Page.only_published.order('updated_at DESC').first.try(:updated_at),
          Comment.order('updated_at DESC').first.try(:updated_at),
        ].compact.max

        @pages = Page.only_published.all
        @topics = Topic.select('id, comments_count, updated_at').order('created_at DESC').limit(max - @pages.size - 1)
      }
    end
  end
end
