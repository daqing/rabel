class Admin::BaseController < ApplicationController
  include Admin::BaseHelper

  before_action do |_c|
    raise CanCan::AccessDenied unless user_signed_in?
    raise CanCan::AccessDenied unless current_user.can_manage_site?
  end

  layout "admin"

  def method_missing(method, _x)
    if method =~ /^find_parent_(.*)$/
      model = ::Regexp.last_match(1).classify.constantize
      instance_variable_set("@#{::Regexp.last_match(1)}".to_sym,
                            model.find(params["#{::Regexp.last_match(1)}_id".to_sym]))
    elsif method =~ /^find_(.*)$/
      model = ::Regexp.last_match(1).classify.constantize
      instance_variable_set("@#{::Regexp.last_match(1)}".to_sym, model.find(params[:id]))
    else
      super
    end
  end
end
