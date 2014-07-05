require 'spec_helper'

describe CommentsController do
  before do
    @topic = create(:topic)
    @comment = create(:comment, :commentable => @topic)

    def cannot_manage_coments_as(response_status)
      get :edit , :id => @comment.id, :format => :js
      should respond_with(response_status)

      post :update, :id => @comment.id, :comment => {:content => 'hi'}, :format => :js
      should respond_with(response_status)

      delete :destroy, :id => @comment.id, :format => :js
      should respond_with(response_status)
    end
  end

  context "users logged out" do
    it "can't add comment" do
      expect {
        post :create, :topic_id => @topic.id, :comment => {:content => 'Great idea!'}
      }.to_not change{Comment.count}.by(1)
    end

    it "can't manage comments" do
      cannot_manage_coments_as(:unauthorized)
    end
  end

  context "users signed in" do
    login_user(:devin)
    before do
      @my_topic = create(:topic, :user => User.find_by_nickname(:devin))
    end

    it "can add comment" do
      expect {
        post :create, :topic_id => @topic.id, :comment => {:content => 'Great idea!'}
      }.to change{Comment.count}.by(1)
    end

    it "can't add comments for closed topic" do
      @closed_topic = create(:closed_topic)
      post :create, :topic_id => @closed_topic.id, :comment => {:content => 'Great idea!'}
      response.should redirect_to(root_path)
      flash[:notice].should_not be_empty
    end

    it "can't manage comments" do
      cannot_manage_coments_as(:not_found)
    end
  end

  context "admin" do
    login_admin(:devin)

    it "can update comment" do
      get :edit, :id => @comment.id, :format => :js
      should respond_with(:success)

      post :update, :id => @comment.id, :comment => {:content => 'hi'}, :format => :js
      should respond_with(:success)
    end

    it "can delete comment" do
      expect {
        delete :destroy, :id => @comment.id, :format => :js
      }.to change{Comment.count}.by(-1)
      should respond_with(:success)
    end
  end
end
