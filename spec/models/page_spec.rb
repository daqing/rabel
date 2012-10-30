require 'spec_helper'

describe Page do
  it { should validate_presence_of(:key) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should allow_mass_assignment_of(:key) }
  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:content) }
  it { should allow_mass_assignment_of(:published) }
  it { should allow_mass_assignment_of(:position) }
end
