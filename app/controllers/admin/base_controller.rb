# encoding: utf-8
class Admin::BaseController < ApplicationController
  include Admin::BaseHelper
  before_filter :authenticate_user!
  before_filter do |c|
    raise CanCan::AccessDenied unless current_user.can_manage_site?
  end

  before_filter do |c|
    add_title_item '管理后台'
  end

  layout 'admin'

  def method_missing(method)
    if method =~ /^find_parent_(.*)$/
      model = $1.classify.constantize
      instance_variable_set("@#{$1}".to_sym, model.find(params["#{$1}_id".to_sym]))
    elsif method =~ /^find_(.*)$/
      model = $1.classify.constantize
      instance_variable_set("@#{$1}".to_sym, model.find(params[:id]))
    else
      super
    end
  end
end
