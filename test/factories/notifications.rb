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
