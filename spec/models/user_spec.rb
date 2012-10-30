require 'spec_helper'

describe User do
  before(:each) do
    @user = create(:user)
  end

  it { should validate_uniqueness_of(:nickname) }
  #it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:nickname) }
  it { should validate_presence_of(:email) }

  it { should allow_mass_assignment_of(:nickname) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should_not allow_mass_assignment_of(:role) }
  it { should_not allow_mass_assignment_of(:blocked) }

  it { should have_one(:account).dependent(:destroy) }
  it { should have_many(:topics).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:notifications).dependent(:destroy) }

  it { should have_many(:follower_relationships).dependent(:destroy) }
  it { should have_many(:followed_relationships).dependent(:destroy) }
  it { should have_many(:followers) }
  it { should_not have_many(:followers).dependent(:destroy) }
  it { should have_many(:followed_users) }
  it { should_not have_many(:followed_users).dependent(:destroy) }

  it "should have default account" do
    assert !@user.account.nil?
  end

  it "should not allow @, - or space in nickname" do
    expect {
      create(:user, :nickname => 'hello@world')
    }.to raise_error(ActiveRecord::RecordInvalid)

    expect {
      create(:user, :nickname => 'hello-world')
    }.to raise_error(ActiveRecord::RecordInvalid)

    expect {
      create(:user, :nickname => 'hello world')
    }.to raise_error(ActiveRecord::RecordInvalid)

    expect {
      create(:user, :nickname => 'hello.world')
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should follow other users" do
    nana = create(:user, :nickname => 'nana')
    @user.follow(nana)
    @user.following?(nana).should be_true
    nana.followers.include?(@user).should be_true
    nana.followed_by?(@user).should be_true
  end

  it "should not have custom avatar" do
    @user.has_avatar?.should be_false
  end
end

