# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = t('tips.no_permission')
    redirect_to root_url, :alert => exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    case request.format.to_sym
    when :html, :mobile
      @title = '404: Not Found'
      @note = '您要访问的页面不存在。'
      @exception = exception
      render 'welcome/exception' and return
    when :js
      render :json => {:error => 'record not found'}, :status => :not_found and return
    end
  end

  rescue_from NoMethodError, RuntimeError do |exception|
    logger.error exception.message
    exception.backtrace.each { |line| logger.error line }

    case request.format.to_sym
    when :html, :mobile
      @title = '500: Internal Error'
      @note = '不好意思，系统运行遇到了错误。'
      @exception = exception
      render 'welcome/exception' and return
    when :js
      render :json => {:error => exception.inspect}, :status => :internal_server_error and return
    end
  end

  before_filter :init
  before_filter :detect_mobile_client

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
      such_able = "@#{$1}able"
      params.each do |name, value|
        if name =~ /(.+)_id$/
          instance_variable_set(such_able.to_sym, $1.classify.constantize.find(value)) and return
        end
      end
    else
      super
    end
  end

  def init
    count_unread_notification
    initialize_breadcrumbs_and_title

    @seo_description = ''
    ActionMailer::Base.default_url_options[:host] = Settings.canonical_host
  end

  def initialize_breadcrumbs_and_title
    unless request.format.to_sym == :js
      basic_name = append_notification_count(Siteconf.site_name)
      @title_items = [basic_name]
      @breadcrumbs = [%(<a class="black" href="#{root_path}">#{Siteconf.site_name}</a>)]
    end
  end

  def mobile_device?
    request.format == :mobile
  end

  private
    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
      goodbye_path
    end

    def count_unread_notification
      unless request.format.to_sym == :js or params[:controller] == 'notifications'
        @unread_count = current_user.try(:unread_notification_count) || 0
      else
        @unread_count = 0
      end
      @show_notification_count = true
    end

    # From Teambox
    def detect_mobile_client
      ua = request.env['HTTP_USER_AGENT']
      session[:posting_device] = ua[/(iPod|iPad|iPhone|Android)/i] if ua.present?

      if [:html, :mobile].include?(request.format.try(:to_sym)) and session[:format]
        # Format has been forced by Sessions#change_format
        request.format = session[:format].to_sym
      else
        # We should autodetect mobile clients and redirect if they ask for html
        mobile_regex = /(iPod|iPhone|Android|Opera mini|Opera mobi|Blackberry|Palm|UCWEB|Windows CE|PSP|Blazer|iemobile|webOS)/i
        mobile =   ua && ua[mobile_regex]
        mobile ||= request.env["HTTP_PROFILE"] || request.env["HTTP_X_WAP_PROFILE"]
        if mobile and request.format == :html
          request.format = :mobile
        end
      end
    end

    def store_location
      # NOTE:
      # This is a hack
      # It works as long as devise doesn't change its source code
      # See: https://github.com/plataformatec/devise/blob/master/lib/devise/controllers/helpers.rb#L172
      session[:user_return_to] = request.fullpath
    end

end

