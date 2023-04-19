# encoding: utf-8
class SessionsController < Devise::SessionsController
  layout 'single-column'
  before_action { @hide_navbar = true }

  def new
    @title = "登入 - #{Siteconf.site_name}"
    super
  end

  def create
    old_session = session.dup
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    sign_in(resource_name, resource)
    reset_session
    session.merge!(old_session)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
end
