class NotifyMentionedUsers
  def self.on_create_topic(ev)
    topic = ev.result
    txt = topic.title + topic.content

    names = txt.scan(Notifiable::MENTION_REGEXP).collect {|matched| matched.first}.uniq
    names.delete(topic.user.nickname)
    users = names.map { |name| User.find_by_nickname(name) }.compact

    users.each do |user|
      Notification.notify(
        user,
        topic,
        topic.user,
        Notification::ACTION_TOPIC,
        topic.content
      )
    end
  end

  def self.on_create_comment(ev)
    # send notification to commentable owner
    # unless the comment was created by the same owner
    comment = ev.result
    if comment.user != comment.commentable.user
      notify_comment(comment.commentable.user, comment, Notification::ACTION_REPLY)
    end

    names = comment.content.scan(Notifiable::MENTION_REGEXP).collect {|matched| matched.first}.uniq
    names.delete(comment.user.nickname)
    names.delete(comment.commentable.user.nickname)
    users = names.map { |name| User.find_by_nickname(name) }.compact

    users.each do |user|
      notify_comment(user, comment, Notification::ACTION_MENTION)
    end
  end

  private

  def self.notify_comment(user, comment, action)
    Notification.notify(
      user,
      comment.commentable,
      comment.user,
      action,
      comment.content
    )
  end
end
