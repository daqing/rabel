require 'spec_helper'

describe Admin::SiteSettingsController do
  it { should extend_the_controller(Admin::BaseController) }

  context "admin" do
    login_admin :devin

    it "should show settings form" do
      get :show
      should respond_with(:success)
    end
  end
end
