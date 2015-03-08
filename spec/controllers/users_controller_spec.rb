require 'rails_helper'

describe UsersController do
  before do
    @signature = 'Rails is so cool!'
  end

  it "displays user's personal homepage" do
    create(:user, :nickname => 'devin')
    get :show, :nickname => 'devin'
    response.should be_success
  end

  it "should display user's all topics" do
    create(:user, :nickname => 'devin')
    get :topics, :nickname => 'devin'

    should respond_with(:success)
  end

  context "authenticated user" do
    login_user(:devin)
    it "allows editing profile" do
      get :edit
      response.should be_success
    end

    it "allows update account without password" do
      post :update_account, :user => {:account_attributes => {:signature => @signature}}
      should respond_with(:redirect)
      should set_flash
      flash[:error].should be_nil
      flash[:success].should_not be_nil
      assigns(:user).account.signature.should == @signature
    end

    it "allows update password" do
      post :update_password, :user => {:current_password => ENV['RABEL_TEST_DEFAULT_PASSWORD'], :password => 'foobar', :password_confirmation => 'foobar'}
      should respond_with(:redirect)
      flash[:error].should be_nil
      flash[:success].should_not be_nil
    end

    it "can visit my bookmarked topics" do
      get :my_topics
      should respond_with(:success)
      should_not set_flash
    end

    it "can visit my following page" do
      get :my_following
      should respond_with(:success)
    end

    it "should follow people" do
      dhh = create(:user, :nickname => 'dhh')
      post :follow, :nickname => 'dhh'
      should respond_with(:redirect)
      should_not set_flash
      current_user = User.find_by_nickname(:devin)
      expect(assigns(:followed_user).followed_by?(current_user)).to be true
    end

    it "should unfollow people" do
      dhh = create(:user, :nickname => 'dhh')
      devin = User.find_by_nickname(:devin)
      devin.follow(dhh)
      post :unfollow, :nickname => 'dhh'
      should respond_with(:redirect)
      should_not set_flash
      expect(devin.following?(dhh)).to be false
    end
  end

  context "anonymous user" do
    it "redirect to sign in page when trying to edit profile" do
      get :edit
      should respond_with(:redirect)
      should set_flash
    end

    it "redirect to sign in page when trying to update account" do
      post :update_account, :user => {:account =>{:signature => @signature}}
      should respond_with(:redirect)
      should set_flash
    end

    it "redirect to sign in page when trying to update password" do
      post :update_password
      should respond_with(:redirect)
      should set_flash
    end

    it "redirect to sign in page when visiting my topics" do
      get :my_topics
      should respond_with(:redirect)
      should set_flash
    end

    it "redirect to sign in page when visiting my following page" do
      get :my_following
      should respond_with(:redirect)
      should set_flash
    end

    it "redirect to sign in page when following people" do
      post :follow, :nickname => 'nana'
      should respond_with(:redirect)
      should set_flash
    end

    it "redirect to sign in page when unfollowing people" do
      post :unfollow, :nickname => 'nana'
      should respond_with(:redirect)
      should set_flash
    end
  end
end

