# == Schema Information
#
# Table name: topics
#
#  id              :integer          not null, primary key
#  node_id         :integer
#  user_id         :integer
#  title           :string(255)
#  content         :text
#  hit             :integer
#  created_at      :datetime
#  updated_at      :datetime
#  involved_at     :datetime
#  comments_count  :integer          default(0), not null
#  comments_closed :boolean          default(FALSE), not null
#  sticky          :boolean          default(FALSE)
#  last_replied_by :string(255)      default("")
#  last_replied_at :datetime
#

require 'spec_helper'

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
  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:content) }
  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:node_id) }
  it { should_not allow_mass_assignment_of(:comments_closed) }

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
