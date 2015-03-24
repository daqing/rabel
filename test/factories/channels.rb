# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    sequence(:name) { |n| "Node - #{n}" }
  end
end
