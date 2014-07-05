require 'spec_helper'

describe Account do
  it { should belong_to(:user) }
  it { should_not allow_mass_assignment_of(:user_id) }
  it { should ensure_length_of(:signature).is_at_most(20) }
end
