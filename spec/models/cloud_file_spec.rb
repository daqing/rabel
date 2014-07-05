require 'spec_helper'

describe CloudFile do
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:asset) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:asset) }
end
