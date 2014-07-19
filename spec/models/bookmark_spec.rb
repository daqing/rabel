require 'rails_helper'

describe Bookmark do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:bookmarkable_type) }
  it { should validate_presence_of(:bookmarkable_id) }
  it { should belong_to(:user) }
  it { should belong_to(:bookmarkable) }
end
