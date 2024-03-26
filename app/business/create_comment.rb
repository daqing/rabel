class CreateComment
  def self.call(user, commentable, params)
    @comment = commentable.comments.build(params)
    @comment.user = user

    @comment if @comment.save
  end
end
