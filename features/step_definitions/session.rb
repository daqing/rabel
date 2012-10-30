# encoding: utf-8

When /^I try to sign in$/ do
  click_link '登入'
end

Then /^it should display the login form$/ do
  page.should have_css('form')
  page.should have_content('登入')
  page.should have_content('用户名')
  page.should have_content('密码')
  page.should have_content('我忘记密码了')
end

When /^I fill in (.*)\'s credentials$/ do |nickname|
  fill_in 'user_nickname', :with => nickname
  fill_in 'user_password', :with => Settings.default_password
  click_button '登入'
end

Then /^I should be signed in$/ do
  page.should have_no_content('登入')
end
