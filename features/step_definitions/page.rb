# encoding: utf-8
When /^I fill in the page form$/ do
  fill_in "page[key]", :with => 'faq'
  fill_in "page[title]", :with => 'hi'
  fill_in "page[content]", :with => 'ok'
  click_button '保存'
end

Given /^(\d+) pages exist$/ do |n|
  n.to_i.times do
    FactoryGirl.create(:page)
  end
end

Then /^(\d+) page nav links shold be shown$/ do |n|
  page.all('#footer .page-links a.nav').size.should == n.to_i
end

Given /^a page exists with title: (.*)$/ do |title|
  FactoryGirl.create(:page, :title => title)
end

Given /^a page is published$/ do
  FactoryGirl.create(:page, :published => true)
end

Given /^a page is in draft$/ do
  FactoryGirl.create(:page, :published => false)
end

Given /^a page is in draft with title: (.*)$/ do |title|
  FactoryGirl.create(:page, :published => false, :title => title)
end

Then /^it should only display (\d+) page$/ do |num|
  all("#footer .page-links a.nav").size.should == num.to_i
end
