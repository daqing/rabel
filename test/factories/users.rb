# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:nickname) { |n| "Rabel_#{n}" }
    sequence(:email) { |n| "rabel_#{n}@rabel.com" }
    password Settings.default_password
    password_confirmation Settings.default_password
    after(:create) {|u| u.account = FactoryGirl.create(:account, :user => u)}

    factory :admin do
      role 'admin'
    end

    factory :root do
      role 'root'
    end
  end
end
