require 'rails_helper'

describe SessionsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it "should GET #new" do
    get :new

    should respond_with(:success)
  end
end
