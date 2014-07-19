require 'rails_helper'

describe Page do
  it { should validate_presence_of(:key) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
end
