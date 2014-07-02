# == Schema Information
#
# Table name: followings
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  followed_user_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Following do
  it { should belong_to(:follower) }
  it { should belong_to(:followed_user) }
end
