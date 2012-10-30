# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plane do
    sequence(:name) { |n| "Plane - #{n}" }
  end
end
