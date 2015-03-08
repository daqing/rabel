require 'rails_helper'

describe BookmarksController do
  before do
    @node = create(:node)
    @topic = create(:topic)
  end

  context "anonymous users" do
    it "should not create bookmark" do
      expect {
        post :create, :topic_id => @topic.id
      }.to change{Bookmark.count}.by(0)

      should respond_with(:redirect)
      should set_flash
    end

    it "should not destroy bookmark" do
      @bookmark = create(:bookmark)
      expect {
        delete :destroy, :id => @bookmark.id
      }.to change{Bookmark.count}.by(0)

      should respond_with(:redirect)
      should set_flash
    end
  end

  context "authenticated users" do
    login_user(:devin)
    it "should create bookmark" do
      expect {
        post :create, :topic_id => @topic.id
      }.to change{Bookmark.count}.by(1)

      should respond_with(:redirect)
      should_not set_flash
    end

    it "should destroy his/her own bookmark" do
      @bookmark = create(:bookmark, :user => User.find_by_nickname(:devin))

      expect {
        delete :destroy, :id => @bookmark.id
      }.to change{Bookmark.count}.by(-1)

      should respond_with(:redirect)
      should_not set_flash
    end

    it "should not destroy other's bookmark" do
      nana = create(:user, :nickname => 'nana')
      @bookmark = create(:bookmark, :user => nana)

      expect {
        delete :destroy, :id => @bookmark.id
      }.to change{Bookmark.count}.by(0)

      should respond_with(:redirect)
      should redirect_to(root_path)
      should set_flash
    end
  end
end
