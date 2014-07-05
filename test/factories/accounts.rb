# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    user
    introduction 'hi'
    signature 'Rails is cool'
    personal_website 'xdaqing.com'
    weibo_link 'http://twitter.com/daqing'
  end
end

