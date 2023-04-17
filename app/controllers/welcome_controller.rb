class WelcomeController < ApplicationController
  def index
    @num = 20
    @topics = HomeTopicsQuery.new.get!(@num)
    @sticky_topics = StickyTopicsQuery.new.get!(10)

    @title = site_intro
  end

  def goodbye
    @title = build_title "登出"
  end

  def captcha
    head :ok and return unless Siteconf.show_captcha?

    respond_to do |format|
      format.gif do
        expires_now
        session[:captcha] = Rabel::Captcha.random_code
        send_data Rabel::Captcha.image(session[:captcha]), type: "image/gif", disposition: "inline"
      end
    end
  end

  def sitemap
    respond_to do |f|
      f.xml do
        max = 50_000
        @lastmod = [
          Topic.order("updated_at DESC").first.try(:updated_at),
          Page.only_published.order("updated_at DESC").first.try(:updated_at),
          Comment.order("updated_at DESC").first.try(:updated_at)
        ].compact.max

        @pages = Page.only_published.all
        @topics = Topic.select("id, comments_count, updated_at").order("created_at DESC").limit(max - @pages.size - 1)
      end
    end
  end
end
