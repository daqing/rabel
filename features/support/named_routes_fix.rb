World(ApplicationHelper)

module RoutingFixHelper
  def member_path(nickname)
    "/member/#{nickname}"
  end
  
  def go_path(key)
    "/go/#{key}"
  end

  def t_path(id)
    "/t/#{id}"
  end

  def my_following_path
    '/my/following'
  end

  def page_path(key)
    "/page/#{key}"
  end
end
