require 'spec_helper'

describe Following do
  it { should belong_to(:follower) }
  it { should belong_to(:followed_user) }
end
