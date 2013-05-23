require 'spec_helper'

describe PagesController do
  before(:each) do
    @page = create(:page)
  end

  it "should display page" do
    get :show, :key => @page.key
    should respond_with(:success)
  end

  it "should not show draft page" do
    page = create(:page, :published => false)
    get :show, :key => page.key
    should respond_with(:success)
    should render_template('welcome/exception')
  end

  it "should not show draft page on mobile view" do
    page = create(:page, :published => false)
    get :show, :key => page.key, :format => :mobile
    should respond_with(:success)
    should render_template('welcome/exception')
  end
end

