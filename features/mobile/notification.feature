Feature: mobile notification

  @mobile
  Scenario: show notification
    Given I have logged in as devin
      And I have 1 unread notification
      When I am on the home page
      Then I should see 提醒
        And I should see 1 条未读提醒
        When I read the notifications
        Then I should see 提醒系统
          And I should see 回复了你
  
