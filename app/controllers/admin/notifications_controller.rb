class Admin::NotificationsController < Admin::BaseController
  # only delete read notifications
  def clear
    Notification.where(:unread => false).delete_all

    redirect_to admin_root_path
  end
end
