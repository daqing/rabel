require 'spec_helper'

describe Bookmark do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:bookmarkable_type) }
  it { should validate_presence_of(:bookmarkable_id) }
  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:bookmarkable_type) }
  it { should_not allow_mass_assignment_of(:bookmarkable_id) }
  it { should belong_to(:user) }
  it { should belong_to(:bookmarkable) }
end
