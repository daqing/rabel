class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper
  include BootstrapHelper

  layout "three_col"

  helper_method :current_user
  helper_method :user_signed_in?

  def sign_in(user)
    session[:current_user_id] = user.id
  end

  def sign_out
    session.delete(:current_user_id)
  end

  def current_user
    return nil unless user_signed_in?

    user = User.where(id: session[:current_user_id]).first
    if user.blank?
      # 用户已登录，但是找不到，可能是数据被删除了，这时候登出此用户
      sign_out
      return nil
    end

    @current_user ||= User.find(session[:current_user_id])
  end

  def user_signed_in?
    session[:current_user_id].to_i.positive?
  end

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = t("tips.no_permission")
    redirect_to root_url, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    case request.format.to_sym
    when :html, :mobile
      @title = "404: Not Found"
      @note = "\u60A8\u8981\u8BBF\u95EE\u7684\u9875\u9762\u4E0D\u5B58\u5728\u3002"
      @exception = exception
      render "welcome/exception"
    when :js
      render json: { error: "record not found" }, status: :not_found and return
    end
  end

  rescue_from NoMethodError, RuntimeError do |exception|
    logger.error exception.message
    exception.backtrace.each { |line| logger.error line }

    case request.format.to_sym
    when :html, :mobile
      @title = "500: Internal Error"
      @note = "\u4E0D\u597D\u610F\u601D\uFF0C\u7CFB\u7EDF\u8FD0\u884C\u9047\u5230\u4E86\u9519\u8BEF\u3002"
      @exception = exception
      render "welcome/exception"
    when :js
      render json: { error: exception.inspect }, status: :internal_server_error
    end
  end

  before_action :init
  before_action :detect_mobile_client

  def custom_path(model)
    if model.is_a? Topic
      t_path(model.id)
    elsif model.is_a? Node
      go_path(model.key)
    else
      model
    end
  end

  def method_missing(method, *args, &block)
    if method =~ /^find_(.*)able/
      such_able = "@#{::Regexp.last_match(1)}able"
      params.each do |name, value|
        if name =~ /(.+)_id$/
          instance_variable_set(such_able.to_sym,
                                ::Regexp.last_match(1).classify.constantize.find(value)) and return
        end
      end
    else
      super
    end
  end

  def init
    count_unread_notification
    initialize_breadcrumbs_and_title

    ActionMailer::Base.default_url_options[:host] = ENV["RABEL_HOST_NAME"]
  end

  def initialize_breadcrumbs_and_title
    return if request.format.to_sym == :js

    basic_name = append_notification_count(Siteconf.site_name)
    @title_items = [basic_name]
    @breadcrumbs = [%(<a class="black" href="#{root_path}">#{Siteconf.site_name}</a>)]
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_resource_or_scope)
    goodbye_path
  end

  def count_unread_notification
    @unread_count = if request.format.to_sym == :js or params[:controller] == "notifications"
                      0
                    else
                      current_user.try(:unread_notification_count) || 0
                    end
    @show_notification_count = true
  end

  # From Teambox
  def detect_mobile_client
    ua = request.env["HTTP_USER_AGENT"]
    session[:posting_device] = ua[/(iPod|iPad|iPhone|Android)/i] if ua.present?
  end

  def build_title(title)
    "#{title} - #{Siteconf.site_name}"
  end
end
