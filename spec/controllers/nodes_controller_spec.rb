require 'spec_helper'

describe NodesController do
  before(:each) do
    @node = create(:node)
  end
  it "should display node" do
    get :show, :key => @node.key
    should respond_with(:success)
    should assign_to(:node)
    should assign_to(:page_num)
    should assign_to(:topics)
    should assign_to(:total_pages)
    should assign_to(:total_topics)
    should assign_to(:prev_page_num)
    should assign_to(:next_page_num)
    should assign_to(:title)
    should assign_to(:canonical_path)
  end

  it "should display node in mobile version" do
    get :show, :key => @node.key, :format => :mobile
    should respond_with(:success)
  end
end
