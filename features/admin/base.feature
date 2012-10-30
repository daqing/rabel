Feature: Admin
  Scenario: show dashboard
    Given as an admin, I have logged in as devin
      And I am on the home page
      Then I should see 管理后台
      When I click the link 管理后台
      Then page title should contain 管理后台
        And I should see 运行状态
        And I should see 基本设置
        And I should see 外观
        And I should see 用户
        And I should see 位面节点
        And I should see 讨论话题
        And I should see 页面
        And I should see 广告位

