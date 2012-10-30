class Comment < ActiveRecord::Base
  include Rabel::ActiveCache

  belongs_to :user
  belongs_to :commentable, :polymorphic => true, :counter_cache => true

  validates :user_id, :commentable_id, :commentable_type, :content, :presence => true
  attr_accessible :content

  after_create :touch_parent_model
  after_create :send_notifications
  after_destroy :update_last_reply

  def mentioned_users
    mentioned_names = self.content.scan(Notifiable::MENTION_REGEXP).collect {|matched| matched.first}.uniq
    mentioned_names.delete(self.user.nickname)
    mentioned_names.delete(self.commentable.user.nickname)
    mentioned_names.map { |name| User.find_by_nickname(name) }.compact
  end

  private
    def touch_parent_model
      created_date = commentable.created_at.to_date
      if commentable.has_attribute?(:last_replied_by) and commentable.has_attribute?(:last_replied_at)
        commentable.last_replied_by = self.user.nickname
        commentable.last_replied_at = self.created_at
        commentable.save
      end

      if commentable.has_attribute?(:involved_at)
        commentable.touch(:involved_at) if created_date.months_since(6) > Time.zone.today
      else
        commentable.touch
      end
    end

    def send_notifications
      # send notification to commentable owner
      # unless the comment was created by the same owner
      send_notification_to(
        self.commentable.user,
        Notification::ACTION_REPLY) unless self.user == self.commentable.user
      send_notification_to_mentioned_users
    end

    def send_notification_to(user, action)
      Notification.notify(
        user,
        self.commentable,
        self.user,
        action,
        self.content
      )
    end

    def send_notification_to_mentioned_users
      mentioned_users.each do |user|
        send_notification_to(user, Notification::ACTION_MENTION)
      end
    end

    def update_last_reply
      if commentable.has_attribute?(:last_replied_by) and commentable.has_attribute?(:last_replied_at)
        if commentable.comments_count == 0
          commentable.last_replied_by = ''
          commentable.last_replied_at = ''
        else
          last_comment = commentable.try(:last_comment)
          if last_comment.present?
            commentable.last_replied_by = last_comment.user.nickname
            commentable.last_replied_at = last_comment.created_at
          end
        end
        commentable.save
      end
    end
end
