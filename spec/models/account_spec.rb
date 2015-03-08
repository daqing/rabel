require 'rails_helper'

describe Account do
  it { should belong_to(:user) }
  it { should validate_length_of(:signature).is_at_most(20) }
end
