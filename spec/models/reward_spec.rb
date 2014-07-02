# == Schema Information
#
# Table name: rewards
#
#  id            :integer          not null, primary key
#  admin_user_id :integer          default(0)
#  user_id       :integer          default(0)
#  amount        :integer          default(0)
#  balance       :integer          default(0)
#  reason        :text
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Reward do
end
