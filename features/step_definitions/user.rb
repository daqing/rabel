# encoding: utf-8

Then /^it should display the registration form$/ do
  page.should have_css('form')
  page.should have_content('注册')
  page.should have_content('用户名')
  page.should have_content('密码')
  page.should have_content('电子邮件')
end

When /^I provide the necessary registration infomation$/ do
  fill_in 'user_nickname', :with => 'Rabel_1'
  fill_in 'user_password', :with => Settings.default_password
  fill_in 'user_password_confirmation', :with => Settings.default_password
  fill_in 'user_email', :with => 'rabel_1@rabel.com'
  click_button '注册'
end

When /^I try to edit my profile settings$/ do
  visit settings_path
end

Then /^it should display the settings form$/ do
  page.should have_css('form.edit_user')

  # account
  page.should have_content('用户名')
  page.should have_content('电子邮件')
  page.should have_content('个人网站')
  page.should have_content('所在地')
  page.should have_content('签名')
  page.should have_content('个人简介')

  # password
  page.should have_content('当前密码')
  page.should have_content('新密码')
  page.should have_content('新密码确认')
end

When /^I provide account info$/ do
  fill_in 'user[account_attributes][personal_website]', :with => 'http://rabelapp.com'
  click_button '保存设置'
end

When /^I provide new password$/ do
  new_password = "new_#{Settings.default_password}"
  fill_in 'user[current_password]', :with => Settings.default_password
  fill_in 'user[password]', :with => new_password
  fill_in 'user[password_confirmation]', :with => new_password
  click_button '更改密码'
end

Given /^(.*) has followed (.*)$/ do |who, nicknames|
  actor = User.find_by_nickname(who)
  nicknames.split(', ').each do |nickname|
    user = User.find_by_nickname(nickname)
    unless user.present?
      user = FactoryGirl.create(:user, :nickname => nickname)
    end
    actor.follow(user)
  end
end

