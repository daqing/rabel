class Siteconf < RailsSettings::CachedSettings
  REWARD_TITLE = "\u94F6\u5E01".freeze

  def self.homepage_title
    "#{site_name} - #{slogan}"
  end

  def self.site_name
    ENV.fetch("RABEL_SITE_NAME", "Rabel")
  end

  def self.slogan
    ENV.fetch("RABEL_SLOGAN", "简洁社区软件")
  end

  def self.boolean_attributes(*args)
    args.each do |m|
      instance_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{m}?
          Siteconf.send(:#{m}) == 'on'
        end
      CODE
    end
  end

  boolean_attributes :allow_markdown_in_topics,
                     :allow_markdown_in_comments,
                     :allow_markdown_in_pages

  class << self
    def seo_keywords_str
      seo_keywords.join(",")
    end

    def seo_keywords_str=(str)
      self.seo_keywords = str.split(",")
    end

    def marketing_str=(str)
      self.marketing = str.split(",")
    end

    def topic_editable_period
      5.minutes
    end

    def simple_topic_list_style?
      topic_list_style == "simple"
    end

    def pagination_topics
      25
    end

    def pagination_comments
      100
    end

    def reward_title
      REWARD_TITLE
    end
  end
end
