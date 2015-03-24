require 'rails_helper'

describe Topic do
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
