require 'spec_helper'

describe Admin::TopicsController do
  it { should extend_the_controller(Admin::BaseController) }
  context "admins" do
    login_admin :devin

    it "should show all topics" do
      get :index
      should respond_with(:success)
    end
  end
end
