require 'rails_helper'

describe Admin::PagesController do
  it { should extend_the_controller(Admin::BaseController) }
  context "admins" do
    login_admin(:devin)

    before(:each) do
      @page = create(:page)
    end

    it "should display all pages" do
      get :index
      should respond_with(:success)
    end

    it "should display page creation form" do
      get :new
      should respond_with(:success)
    end

    it "should create page" do
      expect {
        post :create, :page => {:key => 'foo', :title => 'hi', :content => 'ok'}
      }.to change{Page.count}.by(1)

      should respond_with(:redirect)
      should_not set_flash
    end

    it "should edit page" do
      get :edit, :id => @page.id
      should respond_with(:success)
    end

    it "should update page" do
      post :update, :id => @page.id, :page => {:title => 'hello'}
      should respond_with(:redirect)
      should_not set_flash
    end

    it "should delete page" do
      expect {
        delete :destroy, :id => @page.id
      }.to change{Page.count}.by(-1)

      should respond_with(:redirect)
      should_not set_flash
    end

    it "should sort page" do
      @p1 = create(:page)
      @p2 = create(:page)

      post :sort, :position => [@p2.id, @p1.id], :format => :js
      should respond_with(:success)
    end
  end
end
