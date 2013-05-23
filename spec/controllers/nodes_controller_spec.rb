require 'spec_helper'

describe NodesController do
  before(:each) do
    @node = create(:node)
  end
  it "should display node" do
    get :show, :key => @node.key
    should respond_with(:success)
  end

  it "should display node in mobile version" do
    get :show, :key => @node.key, :format => :mobile
    should respond_with(:success)
  end
end
