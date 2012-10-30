# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :advertisement do
    link 'http://www.linode.com/?r=53a41b8f3680a9cd8a06c92cedea7f514f34e17c'
    title 'Linode'
    words 'The Best VPS provider in the world'
    banner { File.open(Rails.root.join('test', 'support', 'ads', 'linode.png')) }
    start_date Date.today
    duration 30
  end
end
