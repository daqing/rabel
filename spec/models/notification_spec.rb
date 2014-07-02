# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  notifiable_type :string(255)
#  notifiable_id   :integer
#  content         :text
#  action_user_id  :integer
#  action          :string(255)
#  unread          :boolean          default(TRUE)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:action_user) }
  it { should belong_to(:notifiable) }

end
