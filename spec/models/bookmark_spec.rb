# == Schema Information
#
# Table name: bookmarks
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  bookmarkable_type :string(255)
#  bookmarkable_id   :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Bookmark do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:bookmarkable_type) }
  it { should validate_presence_of(:bookmarkable_id) }
  it { should belong_to(:user) }
  it { should belong_to(:bookmarkable) }
end
