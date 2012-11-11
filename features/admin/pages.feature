Feature: Manage Pages
  Scenario: show all pages
    Given as an admin, I have logged in as devin
      And a page exists
      And I am on the admin pages page
        Then page title should contain 页面
          And I should see 页面
          And I should see 创建新页面
          And I should see 发布状态
          And I should see 修改
          And I should see 删除

  Scenario: create page
    Given as an admin, I have logged in as devin
      And I am on the admin page creation page
        Then page title should contain 创建新页面
          And I should see 页面管理
          And I should see 创建新页面
          And I should see 发布状态
          And I should see 立刻发布
          And I should see 保存为草稿
          And it should display button 保存
          When I fill in the page form
            Then I should be redirected to the admin pages page

  Scenario: edit page
    Given as an admin, I have logged in as devin
      And a page exists
      And I am on the admin edit page page
        Then page title should contain 修改页面
          And I should see 页面管理
          And I should see 发布状态
          And I should see 修改页面
          And it should display button 保存
          When I click the button 保存
            Then I should be redirected to the admin pages page

  @javascript
  Scenario: delete page
    Given as an admin, I have logged in as devin
      And a page exists
      And I am on the admin pages page
        Then I should see 删除
        When I click the link 删除
          Then an alert message is shown as 真的要删除吗?
          When I confirm the alert message
            Then I should be redirected to the admin pages page
            And I should not see 删除

  Scenario: show only published pages
    Given a page is published
      And a page is in draft
      When I am on the home page
        Then it should only display 1 page
