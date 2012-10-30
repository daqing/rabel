require 'spec_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:action_user) }
  it { should belong_to(:notifiable) }

  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:action_user_id) }
  it { should_not allow_mass_assignment_of(:notifiable_type) }
  it { should_not allow_mass_assignment_of(:notifiable_id) }
  it { should_not allow_mass_assignment_of(:unread) }
end
