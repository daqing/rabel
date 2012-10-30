# encoding: utf-8
When /^I fill in the password reset form$/ do
  u = User.first
  fill_in "user[nickname]", :with => u.nickname
  fill_in "user[email]", :with => u.email
  click_button '重新设置密码'
end
