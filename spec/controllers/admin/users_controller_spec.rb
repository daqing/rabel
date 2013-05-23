require 'spec_helper'

describe Admin::UsersController do
  it { should extend_the_controller(Admin::BaseController) }
  before(:each) do
    @user = create(:user)
  end

  context "admins" do
    login_admin :devin

    it "should list all users" do
      get :index
      should respond_with(:success)
    end

    it "can manage permissions" do
      post :toggle_admin, :id => @user.id, :format => :js
      should respond_with(:success)
    end
  end

  context "root" do
    login_as_root
    it "should toggle admin" do
      post :toggle_admin, :id => @user.id, :format => :js
      should respond_with(:success)
      assigns(:user).admin?.should be_true
    end

    it "can edit user info" do
      get :edit, :id => @user.id
      should respond_with(:success)
    end
  end
end
