require 'rails_helper'

describe Admin::AdvertisementsController do
  it { should extend_the_controller(Admin::BaseController) }

  context "admins" do
    login_admin :devin

    before(:each) do
      @ad = create(:advertisement)
    end

    it "should show all ads" do
      get :index
      should respond_with(:success)
    end

    it "should show ad creation form" do
      get :new
      should respond_with(:success)
    end

    it "should show ad editing form" do
      get :edit, :id => @ad.id
      should respond_with(:success)
    end

    it "should update ad" do
      new_title = 'Rabel 1.0 Preview'
      post :update, :id => @ad.id, :advertisement => {:title => new_title}
      should respond_with(:redirect)
      should_not set_flash
      assigns(:ad).title.should == new_title
    end
  end
end
