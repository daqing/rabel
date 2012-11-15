module I18n
  def self.custom_handler(exception, key, locale, options)
    # custom error handling logic
    locale.to_s.humanize
  end
end

I18n.exception_handler = :custom_handler
