# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node do
    sequence(:name) { |n| "Node - #{n}" }
    sequence(:key) { |n| "key_#{n}" }
    introduction('this is a small node')
    custom_html(%(<span class="fade">hi</span>))
    quiet false
    plane
  end
end
