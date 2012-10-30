Feature: Manage Topics
  Scenario: show all topics
    Given a topic exists
      And as an admin, I have logged in as devin
      When I am on the admin topics page
      Then page title should contain 讨论话题
        And I should see 节点
        And I should see 标题
        And I should see 作者
        And it should display link 编辑
        And it should display link 删除

