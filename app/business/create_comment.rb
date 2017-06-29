class CreateComment < Fanli::Base
  def initialize(user, commentable, params)
    @user = user
    @commentable = commentable
    @params = params
  end

  def perform
    @comment = @commentable.comments.build(@params)
    @comment.user = @user

    return @comment if @comment.save
  end
end
