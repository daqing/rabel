# encoding: utf-8
Given /^an advertisement exists with title: (.*)$/ do |title|
  FactoryGirl.create(:advertisement, :title => title)
end

When /^I provide new ad title$/ do
  fill_in "advertisement[title]", :with => 'Rabel 1.0 Preview'
  click_button '保存'
end
