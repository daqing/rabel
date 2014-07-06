require 'rails_helper'

describe CloudFile do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:asset) }
end
