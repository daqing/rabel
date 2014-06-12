class Admin::NotificationsController < Admin::BaseController
  # only delete read notifications
  def clear
    Notification.where(:unread => false).delete_all

    redirect_to admin_root_path
  end

  private
  def notification_params
    params.require(:notification).permit(:content, :action)
  end
end
