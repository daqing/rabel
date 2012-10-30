# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user
    association :commentable, :factory => :topic
    content 'great!'
  end
end
