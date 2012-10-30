# encoding: utf-8
class Admin::WelcomeAdminController < Admin::BaseController
  def index
    @title = '运行状态'
    @notifications_to_clear = Notification.where(:unread => false).count
  end
end
