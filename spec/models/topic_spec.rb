require 'rails_helper'

describe Topic do
  it { should belong_to(:node) }
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:notifications).dependent(:destroy) }


  it { should validate_presence_of(:node_id) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:title) }
  it { should_not validate_presence_of(:content) }

  it "should have default hit value" do
    topic = create(:topic)
    topic.hit.should == Topic::DEFAULT_HIT
  end

  it "should send notifications to mentioned users" do
    user = create(:user)
    topic = create(:topic, :title => "@#{user.nickname} hello")
    user.unread_notification_count.should be > 0
  end
end
