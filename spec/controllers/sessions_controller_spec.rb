require 'spec_helper'

describe SessionsController do
  it "should allow signing in on mobile platform" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    post :create, :user => {:nickname => user.nickname, :password => Settings.default_password}, :format => :mobile
    should respond_with(:redirect)
    should redirect_to(root_path)
  end
end
