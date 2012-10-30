module Notifiable
  MENTION_REGEXP = /@([a-zA-Z0-9_\-\p{han}]+)/u

  def notifiable_title
    default_implementation
  end

  def notifiable_path
    default_implementation
  end

  private
    def default_implementation
      raise "Notifiable callback was not implemented."
    end
end
