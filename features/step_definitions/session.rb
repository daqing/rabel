# encoding: utf-8

When /^I try to sign in$/ do
  click_link '帐号登录'
end

Then /^it should display the login form$/ do
  page.should have_css('form')
  page.should have_content('帐号登录')
  page.should have_content('用户名')
  page.should have_content('密码')
  page.should have_content('找回登录密码')
end

When /^I fill in (.*)\'s credentials$/ do |nickname|
  fill_in 'user_nickname', :with => nickname
  fill_in 'user_password', :with => Settings.default_password
  click_button '帐号登录'
end

Then /^I should be signed in$/ do
  page.should have_no_content('帐号登录')
end

