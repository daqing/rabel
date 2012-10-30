# encoding: utf-8
class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notifications = current_user.notifications.where(:unread => true).order('created_at DESC').limit(100).all
    current_user.notifications.update_all(:unread => false)
    @unread_count = 0

    @title = '提醒系统'

    respond_to do |format|
      format.html
      format.mobile {
        add_breadcrumb(@title)
        @show_notification_count = false
      }
    end
  end

  def read
    @notification = current_user.notifications.find(params[:id])
    if @notification.present?
      redirect_to @notification.notifiable.notifiable_path
    else
      redirect_to root_path, :error => '无法处理之前的请求'
    end
  end
end
