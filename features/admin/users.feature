Feature: Manage Users

  Scenario: show all users
    Given as root, I have logged in as devin
      And an user exists with nickname: nana
      And an admin exists
      When I am on the admin users page
        Then page title should contain 用户
          And I should see 权限
          And I should see 操作
          And it should display link 提升为管理员
          And it should display link 取消管理权限

  @javascript
  Scenario: root can de-active users
    Given a root exists with nickname: devin
      And an user exists with nickname: zhiming
    When I have logged in as devin
      And I am on the admin users page
      Then it should display link 屏蔽
      When I click the link 屏蔽
      Then it should display link 取消屏蔽

