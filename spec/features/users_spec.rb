# encoding: utf-8
require 'spec_helper.rb'

describe "Registration", :type => :feature do
  it "should allow registration when captcha off" do
    Siteconf.show_captcha = :off

    visit new_user_registration_path

    page.should have_content('用户名')
    page.should have_content('电子邮件')
    page.should have_content('密码')
    page.should have_content('密码确认')

    fill_in "user[nickname]", :with => 'foobar'
    fill_in "user[email]", :with => 'hi@gmail.com'
    fill_in "user[password]", :with => '123456789001007'
    fill_in "user[password_confirmation]", :with => '123456789001007'

    expect { click_button '加入社区' }.to change { User.count }.by(1)
    expect(current_url).to eq(root_url)
  end
end

