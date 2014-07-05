# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    sequence(:key) { |n| "key_#{n}" }
    title 'Default page'
    content 'This is a default page'
    published true
  end
end
