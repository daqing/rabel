require 'rails_helper'

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
      xhr :post, :toggle_admin, :id => @user.id
      should respond_with(:success)
    end
  end

  context "root" do
    login_as_root
    it "should toggle admin" do
      xhr :post, :toggle_admin, :id => @user.id
      should respond_with(:success)
      expect(assigns(:user).admin?).to be true
    end

    it "can edit user info" do
      get :edit, :id => @user.id
      should respond_with(:success)
    end
  end
end
