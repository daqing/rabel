class Siteconf < RailsSettings::CachedSettings
  def self.boolean_attributes(*args)
    args.each do |m|
      self.instance_eval <<-CODE
        def #{m}?
          Siteconf.send(:#{m}) == 'on'
        end
      CODE
    end
  end

  boolean_attributes :show_captcha, :allow_markdown_in_topics,
    :allow_markdown_in_comments,
    :allow_markdown_in_pages

  class << self
    def seo_keywords_str
      self.seo_keywords.join(',')
    end

    def seo_keywords_str=(str)
      self.seo_keywords = str.split(',')
    end

    def marketing_str
      self.marketing.join(',') rescue ''
    end

    def marketing_str=(str)
      self.marketing = str.split(',')
    end

    def topic_editable_period
      5.minutes
    end

    def simple_topic_list_style?
      self.topic_list_style == 'simple'
    end

    def pagination_topics
      25
    end

    def pagination_comments
      100
    end
  end
end
