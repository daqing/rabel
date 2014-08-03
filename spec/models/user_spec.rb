require 'rails_helper'

describe User do
  before(:each) do
    @user = create(:user)
  end

  it { should validate_uniqueness_of(:nickname) }
  it { should validate_presence_of(:nickname) }
  it { should validate_presence_of(:email) }


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
    expect(@user.following?(nana)).to be true
    expect(nana.followers.include?(@user)).to be true
    expect(nana.followed_by?(@user)).to be true
  end

  it "should not have custom avatar" do
    expect(@user.has_avatar?).to be false
  end
end

