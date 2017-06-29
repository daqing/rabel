class TouchCommentable
  def self.on_create_comment(ev)
    comment = ev.result
    commentable = comment.commentable

    created_date = commentable.created_at.to_date
    if commentable.has_attribute?(:last_replied_by) and commentable.has_attribute?(:last_replied_at)
      commentable.last_replied_by = comment.user.nickname
      commentable.last_replied_at = comment.created_at
      commentable.save
    end

    if commentable.has_attribute?(:involved_at)
      commentable.touch(:involved_at) if created_date.months_since(6) > Time.zone.today
    else
      commentable.touch
    end
  end

  def self.on_destroy_comment(ev)
    commentable = ev.result.commentable

    if commentable.has_attribute?(:last_replied_by) and commentable.has_attribute?(:last_replied_at)
      if commentable.comments.count == 0
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
