require 'spec_helper'

describe Admin::PlanesController do
  it { should extend_the_controller(Admin::BaseController) }
  context "admins" do
    login_admin :devin

    before(:each) do
      @plane = create(:plane)
    end

    it "should display all planes and nodes" do
      get :index
      should respond_with(:success)
    end

    it "should show plane creation form via ajax" do
      get :new, :format => :js
      should respond_with(:success)
    end

    it "should create planes via ajax" do
      expect {
        post :create, :plane => {:name => 'foobar'}, :format => :js
      }.to change{Plane.count}.by(1)

      should respond_with(:success)
    end

    it "should show plane editing form via ajax" do
      get :edit, :id => @plane.id, :format => :js
      should respond_with(:success)
    end

    it "should update plane" do
      new_name = @plane.name + "_new"
      put :update, :id => @plane.id, :plane => {:name => new_name}, :format => :js
      should respond_with(:success)
      assigns(:plane).name.should == new_name
    end

    it "should delete planes via ajax" do
      expect {
        delete :destroy, :id => @plane.id, :format => :js
      }.to change{Plane.count}.by(-1)

      should respond_with(:success)
    end

    it "should not delete planes that have nodes" do
      plane = create(:plane)
      node = create(:node, :plane => plane)
      expect {
        delete :destroy, :id => plane.id, :format => :js
      }.to_not change{Plane.count}.by(-1)

      should respond_with(:unprocessable_entity)
    end
  end
end
