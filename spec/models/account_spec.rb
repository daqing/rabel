# == Schema Information
#
# Table name: accounts
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  personal_website :string(255)
#  location         :string(255)
#  signature        :string(255)
#  introduction     :text
#  created_at       :datetime
#  updated_at       :datetime
#  weibo_link       :string(255)      default("")
#

require 'spec_helper'

describe Account do
  it { should belong_to(:user) }
  it { should ensure_length_of(:signature).is_at_most(20) }
end
