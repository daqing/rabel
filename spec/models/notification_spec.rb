require 'rails_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:action_user) }
  it { should belong_to(:notifiable) }

end
