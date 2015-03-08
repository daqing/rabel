require 'rails_helper'

describe TopicsController do
  before(:each) do
    @node = create(:node)
    @topic = create(:topic, :node => @node)
    @topic_params = {:title => 'hi', :content => 'Rails is cool'}
  end

  it "should show topic" do
    get :show, :id => @topic.id
    should respond_with(:success)

  end

  it "should output feed" do
    get :index, :format => :atom
    should respond_with(:success)
  end

  it "should show all topics" do
    get :index
    should respond_with(:success)
  end

  it "should show atom feed" do
    get :index, :format => :atom
    should respond_with(:success)
  end

  context "anonymous users" do
    it "should redirect when trying to create topic" do
      expect {
        post :create, :node_id => @node.id, :topic => @topic_params
      }.to change{Topic.count}.by(0)
      should respond_with(:redirect)
    end

    it "should redirect when trying to edit topic" do
      get :edit, :node_id => @node.id, :id => @topic.id
      should respond_with(:redirect)
    end

    it "should redirect when visit topic creation form" do
      get :new, :node_id => @node.id
      should respond_with(:redirect)
    end

    it "should redirect when updating topic" do
      post :update, :node_id => @node.id, :id => @topic.id, :topic => @topic_params
      should respond_with(:redirect)
    end

    it "should not move topic" do
      get :move, :node_id => @node.id, :id => @topic.id, :format => :js
      should respond_with(:unauthorized)
    end

    it "should redirect when trying to delete topic" do
      delete :destroy, :node_id => @node.id, :id => @topic.id
      should respond_with(:redirect)
    end
  end

  context "authenticated users" do
    login_user(:devin)
    before(:each) do
      @current_user = User.find_by_nickname(:devin)
      @my_topic = create(:topic, :node => @node, :user => @current_user)
    end

    it "can create topic" do
      expect {
        post :create, :node_id => @node.id, :topic => @topic_params
      }.to change{Topic.count}.by(1)

      should respond_with(:redirect)
    end

    it "can create topic without content" do
      expect {
        post :create, :node_id => @node.id, :topic => {:title => 'hi'}
      }.to change{Topic.count}.by(1)

      should respond_with(:redirect)
    end

    it "can edit topic" do
      get :edit, :node_id => @node, :id => @my_topic.id
      should respond_with(:success)
    end

    it "can only edit own topics" do
      nana = create(:user)
      others_topic = create(:topic, :user => nana, :node => @node)
      get :edit, :node_id => @node, :id => others_topic.id
      should respond_with(:redirect)
    end

    it "can't update others topic" do
      post :update, :node_id => @node.id, :id => @topic.id, :topic => @topic_params
      should respond_with(:redirect)
      should set_flash
    end

    it "can't update locked topic" do
      locked_topic = create(:locked_topic, :user => @current_user, :node => @node)

      post :update, :node_id => @node.id, :id => locked_topic.id, :topic => @topic_params
      should respond_with(:redirect)
      should redirect_to(root_path)
      should set_flash
      assigns(:topic).title.should_not == @topic_params[:title]
    end

    it "can update created topics when it's not locked" do
      post :update, :node_id => @node.id, :id => @my_topic.id, :topic => @topic_params
      should respond_with(:redirect)
      should redirect_to(t_path(@my_topic.id))
      should_not set_flash
    end

    it "should redirect when trying to delete topic" do
      expect {
        delete :destroy, :node_id => @node.id, :id => @topic.id
      }.to change{Topic.count}.by(0)
      should respond_with(:redirect)
      should redirect_to(root_path)
    end

    it "should redirect when trying to toggle comments closed status of topic" do
      put :toggle_comments_closed, :topic_id => @topic.id
      should redirect_to(root_path)
      flash[:notice].should_not be_empty
    end

    it "should redirect when trying to toggle sticky status of topic" do
      put :toggle_sticky, :topic_id => @topic.id
      should redirect_to(root_path)
      flash[:notice].should_not be_empty
    end
  end

  context "admins" do
    login_admin :devin
    before(:each) do
      @current_user = User.find_by_nickname(:devin)
      @locked_topic = create(:locked_topic, :node => @node)
    end

    it "can edit locked topics" do
      get :edit, :node_id => @node, :id => @locked_topic.id
      should respond_with(:success)
    end

    it "can update locked topics" do
      post :update, :node_id => @node.id, :id => @locked_topic.id, :topic => @topic_params
      should respond_with(:redirect)
      should redirect_to(t_path(@locked_topic.id))
      should_not set_flash
    end

    it "should move topics" do
      xhr :get, :move, :node_id => @node.id, :id => @topic.id
      should respond_with(:success)
    end

    it "should delete topic" do
      expect {
        delete :destroy, :node_id => @node.id, :id => @topic.id
      }.to change{Topic.count}.by(-1)
    end

    it "can toggle comments_closed status of topic" do
      put :toggle_comments_closed, :topic_id => @topic.id
      expect(assigns(:topic).comments_closed).to be true
      should redirect_to(t_path(@topic.id))
      should_not set_flash
    end

    it "can toggle sticky status of topic" do
      put :toggle_sticky, :topic_id => @topic.id
      expect(assigns(:topic).sticky).to be true
      should redirect_to(t_path(@topic.id))
      should_not set_flash
    end
  end
end

