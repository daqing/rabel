# == Schema Information
#
# Table name: cloud_files
#
#  id           :integer          not null, primary key
#  content_type :string(255)
#  file_size    :integer
#  asset        :string(255)
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe CloudFile do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:asset) }
end
