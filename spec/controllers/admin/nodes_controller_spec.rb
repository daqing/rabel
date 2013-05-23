require 'spec_helper'

describe Admin::NodesController do
  it { should extend_the_controller(Admin::BaseController) }
  context "admins" do
    login_admin :devin
    
    before(:each) do
      @plane = create(:plane)
      @node = create(:node, :plane => @plane)
    end

    it "should show node creation form via ajax" do
      get :new, :plane_id => @plane.id, :format => :js
      should respond_with(:success)
    end

    it "should create node via ajax" do
      expect {
        post :create, :plane_id => @plane.id, :node => {:key => 'rails', :name => 'Ruby on Rails'}, :format => :js
      }.to change{Node.count}.by(1)
      should respond_with(:success)
    end

    it "should show node editing form via ajax" do
      get :edit, :plane_id => @plane.id, :id => @node.id, :format => :js
      should respond_with(:success)
    end

    it "should update node via ajax" do
      new_name = 'Nginx 1.0'
      put :update, :plane_id => @plane.id, :id => @node.id, :node => {:name => new_name}, :format => :js
      should respond_with(:success)
      assigns(:node).name.should == new_name
    end

    it "should sort nodes" do
      @n1 = create(:node)
      @n2 = create(:node)

      post :sort, :position => [@n1, @n2], :format => :js
      should respond_with(:success)
    end

    it "should destroy node" do
      expect {
        delete :destroy, :id => @node, :format => :js
      }.to change{Node.count}.by(-1)

      should respond_with(:success)
    end

    it "should not destroy nodes that have topics" do
      node = create(:node)
      t = create(:topic, :node => node)

      expect {
        delete :destroy, :id => node.id, :format => :js
      }.to_not change{Node.count}.by(-1)

      should respond_with(:unprocessable_entity)
    end
  end
end
