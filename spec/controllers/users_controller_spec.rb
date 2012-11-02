require 'spec_helper'

describe UsersController do
  before do
    @signature = 'Rails is so cool!'
  end

  it "displays user's personal homepage" do
    create(:user, :nickname => 'devin')
    get :show, :nickname => 'devin'
    response.should be_success
    should assign_to(:canonical_path)
  end

  it "displays user's personal homepage in mobile version" do
    create(:user, :nickname => 'devin')
    get :show, :nickname => 'devin', :format => :mobile
    response.should be_success
  end

  it "should display user's all topics" do
    create(:user, :nickname => 'devin')
    get :topics, :nickname => 'devin'

    should respond_with(:success)
    should assign_to(:title)
    should assign_to(:seo_description)
  end

  context "authenticated user" do
    login_user(:devin)
    it "allows editing profile" do
      get :edit
      response.should be_success
    end

    it "allows editing profile on mobile device" do
      get :edit, :format => :mobile
      response.should be_success
    end

    it "allows update account without password" do
      post :update_account, :user => {:account_attributes => {:signature => @signature}}
      should assign_to(:user)
      should respond_with(:redirect)
      should set_the_flash
      flash[:error].should be_nil
      flash[:success].should_not be_nil
      assigns(:user).account.signature.should == @signature
    end

    it "allows update password" do
      post :update_password, :user => {:current_password => Settings.default_password, :password => 'foobar', :password_confirmation => 'foobar'}
      should respond_with(:redirect)
      should assign_to(:user)
      flash[:error].should be_nil
      flash[:success].should_not be_nil
    end

    it "can visit my bookmarked topics" do
      get :my_topics
      should respond_with(:success)
      should_not set_the_flash
      should assign_to(:my_topics)
    end

    it "can visit my following page" do
      get :my_following
      should respond_with(:success)
      should assign_to(:my_followed_users)
      should assign_to(:followed_topic_timeline)
      should assign_to(:title)
    end

    it "should follow people" do
      dhh = create(:user, :nickname => 'dhh')
      post :follow, :nickname => 'dhh'
      should respond_with(:redirect)
      should_not set_the_flash
      should assign_to(:followed_user)
      current_user = User.find_by_nickname(:devin)
      assigns(:followed_user).followed_by?(current_user).should be_true
    end

    it "should unfollow people" do
      dhh = create(:user, :nickname => 'dhh')
      devin = User.find_by_nickname(:devin)
      devin.follow(dhh)
      post :unfollow, :nickname => 'dhh'
      should respond_with(:redirect)
      should_not set_the_flash
      devin.following?(dhh).should be_false
    end
  end

  context "anonymous user" do
    it "redirect to sign in page when trying to edit profile" do
      get :edit
      should respond_with(:redirect)
      should set_the_flash
      should_not assign_to(:user)
    end

    it "redirect to sign in page when trying to update account" do
      post :update_account, :user => {:account =>{:signature => @signature}}
      should respond_with(:redirect)
      should set_the_flash
      should_not assign_to(:user)
    end

    it "redirect to sign in page when trying to update password" do
      post :update_password
      should respond_with(:redirect)
      should set_the_flash
      should_not assign_to(:user)
    end

    it "redirect to sign in page when visiting my topics" do
      get :my_topics
      should respond_with(:redirect)
      should set_the_flash
      should_not assign_to(:my_topics)
    end

    it "redirect to sign in page when visiting my following page" do
      get :my_following
      should respond_with(:redirect)
      should set_the_flash
      should_not assign_to(:my_followed_users)
      should_not assign_to(:followed_topic_timeline)
    end

    it "redirect to sign in page when following people" do
      post :follow, :nickname => 'nana'
      should respond_with(:redirect)
      should set_the_flash
    end

    it "redirect to sign in page when unfollowing people" do
      post :unfollow, :nickname => 'nana'
      should respond_with(:redirect)
      should set_the_flash
    end
  end
end

