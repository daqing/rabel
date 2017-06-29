module Notifiable
  MENTION_REGEXP = /@([a-zA-Z0-9_\-\p{han}]+)/u

  def notifiable_title
    raise "Notifiable callback was not implemented."
  end

  def notifiable_path
    raise "Notifiable callback was not implemented."
  end
end
