# encoding: utf-8

Then /^it should display a logout icon$/ do
  page.should have_css("#EjectIcon")
end

When /^I click the logout icon$/ do
  find("#EjectIcon").find(:xpath, '..').click
end

Then /^it should display a settings icon$/ do
  page.should have_css("#GearIcon")
end

Then /^it should display the version number$/ do
  steps %Q(Then I should see #{Rabel.version})
end

When /^I read the notifications$/ do
  find(".notification").click
end

Then /^it should display mark all as read buttun$/ do
  page.should have_css('a.btn')
  page.should have_button('全部标记为已读')
end

When /^I mark all notifications as read$/ do
  find_button('全部标记为已读').find(:xpath, '..').click
end
