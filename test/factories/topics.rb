# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    user
    node
    title 'Hello'
    content 'Hello, world'
    comments_closed false
    sticky false

    factory :locked_topic do
      created_at Time.now - Siteconf.topic_editable_period
    end

    factory :closed_topic do
      comments_closed true
    end
  end
end
