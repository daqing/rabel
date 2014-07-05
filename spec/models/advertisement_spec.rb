require 'spec_helper'

describe Advertisement do
  it { should validate_presence_of(:link) }
  it { should validate_presence_of(:banner) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:words) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:expire_date) }
  it { should validate_presence_of(:duration) }
  it { should validate_numericality_of(:duration) }
  it { should_not allow_mass_assignment_of(:expire_date) }
end
