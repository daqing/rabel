# encoding: utf-8
Then /^it should display the plane creation form$/ do
  page.should have_css('form.new_plane')
  steps %Q(And I should see 名称)
  steps %Q(And it should display button 保存)
end

Then /^it should display the plane editing form$/ do
  page.should have_css('form.edit_plane')
  steps %Q(And I should see 名称)
  steps %Q(And it should display button 保存)
end

When /^I provide the plane name: (.*)$/ do |name|
  fill_in "plane[name]", :with => name
  click_button '保存'
end

Given /^a plane exists with name: (.*)$/ do |name|
  FactoryGirl.create(:plane, :name => name)
end

