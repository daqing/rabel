Feature: Homepage

  Scenario: browse homepage as an anonymous user
    Given I am not authenticated
      And I am on the home page
      Then I should see 注册
        And I should see 登入

  Scenario: I should not see sign in and register links when logged in
    Given I have logged in as devin
      And I am on the home page
      Then I should see devin
        And I should see 设置
        And I should see 退出
        And it should not display link 注册
        And I should not see 登入

  Scenario: browse homepage as authenticated user
    Given I have logged in as devin
      And I am on the home page
      Then I should see devin

  Scenario: nodes and topics on homepage
    Given a node exists with name: 电影
      And a topic under the node exists with title: 全球最佳电影推荐
      And a comment exists with content: 这些电影都想看!
      And I am on the home page
      Then I should see 电影
        And I should see 全球最佳电影推荐
        And I should see 1

  Scenario: show nav pages in bottom
    Given 3 pages exist
      And I am on the home page
      Then 3 page nav links shold be shown

  Scenario: show ad on homepage
    Given an advertisement exists with title: Rabel is cool
      And I am on the home page
      Then I should see Rabel is cool

  @javascript
  Scenario: search
    Given I am on the home page
      Then it should display the search form

