# encoding: utf-8
#
When /^I add comment:(.*)$/ do |comment|
  fill_in "comment[content]", :with => comment
  click_button '发送'
end

Then /^there should be EDIT link in reply$/ do
  within(".reply") do
    page.should have_css("a.edit", :visible => false)
  end
end

Then /^there should be DEL link in reply$/ do
  within(".reply") do
    page.should have_css("a.rabel[data-method=delete]", :visible => false)
  end
end

Then /^there's no link (.*) in reply$/ do |link|
  within(".reply") do
    page.should have_no_link(link)
  end
end
