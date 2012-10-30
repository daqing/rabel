Feature: mobile topic

  @mobile
  Scenario: admin can close comments for topic
    Given as an admin, I have logged in as devin
      And a node exists
      When I am on the node page
        And I click the mobile button 创建新主题
        Then I should see 禁止回复

