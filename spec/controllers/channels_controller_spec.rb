require 'rails_helper'

describe ChannelsController do
  before(:each) do
    @channel = create(:channel)
  end

  it "should display node" do
    get :show, :id => @channel.id
    should respond_with(:success)
  end
end
