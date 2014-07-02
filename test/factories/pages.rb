# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  published  :boolean          default(FALSE)
#  position   :integer
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    sequence(:key) { |n| "key_#{n}" }
    title 'Default page'
    content 'This is a default page'
    published true
  end
end
