require 'spec_helper'

describe NodeTopicMapping do
  it { should belong_to(:node) }
  it { should belong_to(:topic) }
end
