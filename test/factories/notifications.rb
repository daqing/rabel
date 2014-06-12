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

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user
    association :action_user, :factory => :user
    association :notifiable, :factory => :topic
    action Notification::ACTION_REPLY
    content 'hello'
  end
end
