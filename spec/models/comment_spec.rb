require 'spec_helper'

describe Comment do
  it { should belong_to(:commentable) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
  it { should validate_presence_of(:content) }
  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:commentable_id) }
  it { should_not allow_mass_assignment_of(:commentable_type) }
  context "an instance" do
    it "should mention existing user" do
      nickname = 'nana'
      user = create(:user, :nickname => nickname)
      c = create(:comment, :content => "@#{nickname} hi")
      c.mentioned_users.include?(user).should be_true
    end

    it "mentioned users should not contain the commenter" do
      user = create(:user)
      c = create(:comment, :user => user, :content => "@#{user.nickname} hi")
      c.mentioned_users.include?(user).should_not be_true
    end

    it "mentioned users should not contain the commentable creator" do
      topic = create(:topic)
      c = create(:comment, :commentable => topic, :content => "@#{topic.user.nickname} hi")
      c.mentioned_users.include?(topic.user).should_not be_true
    end
  end
end
