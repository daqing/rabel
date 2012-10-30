require 'spec_helper'

describe Node do
  context "model" do
    before(:each) do
      create(:node)
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:key) }
    it { should validate_presence_of(:plane_id) }
    it { should validate_uniqueness_of(:key) }

    it { should have_many(:topics) }
    it { should_not have_many(:topics).dependent(:destroy) }
    it { should belong_to(:plane) }
    it { should have_many(:bookmarks).dependent(:destroy) }

    it { should allow_mass_assignment_of(:plane_id) }
    it { should allow_mass_assignment_of(:position) }
  end
end
