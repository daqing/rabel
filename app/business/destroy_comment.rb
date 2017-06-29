class DestroyComment < Fanli::Base
  def initialize(comment)
    @comment = comment
  end

  def perform
    @comment.destroy
  end
end
