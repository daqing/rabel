require 'rails_helper'

describe NotificationsController do
  describe "Get #index" do
    it "should redirect to sign in page for anonymous users" do
      get :index
      should respond_with(:redirect)
      should set_flash
      should redirect_to(new_user_session_path)
    end

    context "authenticated users" do
      login_user(:devin)
      it "should display unread notifications" do
        get :index
        should respond_with(:success)
      end
    end
  end
end
