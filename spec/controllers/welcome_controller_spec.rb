# encoding: utf-8
require 'spec_helper'

describe WelcomeController do
  describe "Get #index" do
    it "should be able to browse home page" do
      get :index
      should respond_with(:success)
    end

    it "should display mobile version" do
      get :index, :format => :mobile
      should respond_with(:success)
    end
  end

  describe "Get #goodbye" do
    it "should display goodbye on mobile device" do
      get :goodbye, :format => :mobile
      should respond_with(:success)
    end
  end

  describe "Get #sitemap" do
    it "should output sitemap" do
      get :sitemap, :format => :xml
      should respond_with(:success)
    end
  end
end
