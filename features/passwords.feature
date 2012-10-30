Feature: Passwords
  Scenario: reset password
    Given an user exists
      And I am on the password reset page
      Then I should see 重新设置密码
        And I should see 用户名
        And I should see 注册邮箱
        When I fill in the password reset form
          Then I should see 现在请去查看你的注册邮箱，其中有帮助你重新设置密码的链接
