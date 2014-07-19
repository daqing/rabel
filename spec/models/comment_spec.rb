require 'rails_helper'

describe Comment do
  it { should belong_to(:commentable) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
  it { should validate_presence_of(:content) }
  context "an instance" do
    it "should mention existing user" do
      nickname = 'nana'
      user = create(:user, :nickname => nickname)
      c = create(:comment, :content => "@#{nickname} hi")
      expect(c.mentioned_users.include?(user)).to be true
    end

    it "mentioned users should not contain the commenter" do
      user = create(:user)
      c = create(:comment, :user => user, :content => "@#{user.nickname} hi")
      expect(c.mentioned_users.include?(user)).not_to be true
    end

    it "mentioned users should not contain the commentable creator" do
      topic = create(:topic)
      c = create(:comment, :commentable => topic, :content => "@#{topic.user.nickname} hi")
      expect(c.mentioned_users.include?(topic.user)).not_to be true
    end
  end
end
