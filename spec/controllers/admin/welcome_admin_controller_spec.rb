require 'rails_helper'

describe Admin::WelcomeAdminController do
  it { should extend_the_controller(Admin::BaseController) }

  context "anonymous users" do
    describe "GET 'index'" do
      it "redirects to login page" do
        get :index
        should respond_with(:redirect)
        should set_flash
        should redirect_to(new_user_session_path)
      end
    end
  end

  context "normal users" do
    login_user(:devin)
    describe "Get 'index'" do
      it "redirects to root path because of permission error" do
        get :index
        should respond_with(:redirect)
        should set_flash
        should redirect_to(root_path)
      end
    end
  end

  context "admins" do
    login_admin(:daqing)
    describe "Get 'index'" do
      it "shows admin dashboard" do
        get :index
        should respond_with(:success)
      end
    end
  end
end
