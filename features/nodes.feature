Feature: Nodes
  Scenario: visit node page when signed out
    Given I am not authenticated
      And a node exists with name: 电影
      And a topic under the node exists with title: 韩国电影推荐
      And I am on the node page
      Then page title should contain 电影
        And I should see 电影
        And I should see 韩国电影推荐
        And it should not display a compact topic creation form
        And I should not see 加入收藏
        And I should not see 取消收藏

  Scenario: visit node page when logged in
    Given I have logged in as devin
      And a node exists with name: 电影
      And a topic under the node exists with title: 韩国电影推荐
      And I am on the node page
      Then page title should contain 电影
        And I should see 电影
        And I should see 韩国电影推荐
        And it should display a topic creation form

  Scenario: create topic on node page
    Given a node exists with name: 电影
    And I have logged in as devin
    When I am on the node page
    Then it should display a topic creation form
      When I provide topic creation information
      Then I should be redirected to the topic page

  Scenario: topic pagination
    Given a node exists with name: 电影
      And the node has topics of 2 pages
      And I am on the node page
      Then I should see 下一页
        And I should not see 上一页
        And it should display one page topics
      When I click the link 下一页 →
        Then I should see 上一页
        And I should not see 下一页
        When I click the link ← 上一页
        Then I should see 下一页

  Scenario: show custom html on node page
    Given a node exists with custom html: <strong class="heading">认识电影</strong>
      And I am on the node page
        Then I should see 认识电影

  Scenario: show node introduction
    Given a node exists with introduction: A cool node
      And I am on the node page
        Then I should see A cool node
