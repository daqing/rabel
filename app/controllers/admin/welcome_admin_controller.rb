class Admin::WelcomeAdminController < Admin::BaseController
  def index
    @title = "\u8FD0\u884C\u72B6\u6001"
    @notifications_to_clear = Notification.where(unread: false).count
  end
end
