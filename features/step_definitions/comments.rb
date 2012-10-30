# encoding: utf-8
#
When /^I add comment:(.*)$/ do |comment|
  fill_in "comment[content]", :with => comment
  click_button '发送'
end

Then /^there should be link (.*) in reply$/ do |link|
  within(".reply") do
    page.should have_link(link)
  end
end

Then /^there's no link (.*) in reply$/ do |link|
  within(".reply") do
    page.should have_no_link(link)
  end
end
