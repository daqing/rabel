Feature: Channels
  Scenario: visit channel page when signed out
    Given I am not authenticated
      And a channel exists with name: 电影
      And a topic under the channel exists with title: 韩国电影推荐
      And I am on the channel page
      Then page title should contain 电影
        And I should see 电影
        And I should see 韩国电影推荐

  Scenario: visit channel page when logged in
    Given I have logged in as devin
      And a channel exists with name: 电影
      And a topic under the channel exists with title: 韩国电影推荐
      And I am on the channel page
      Then page title should contain 电影
        And I should see 电影
        And I should see 韩国电影推荐

  Scenario: topic pagination
    Given a channel exists with name: 电影
      And the channel has topics of 2 pages
      And I am on the channel page
      Then I should see 下一页
        And I should not see 上一页
        And it should display one page topics
      When I click the link 下一页 →
        Then I should see 上一页
        And I should not see 下一页
        When I click the link ← 上一页
        Then I should see 下一页
