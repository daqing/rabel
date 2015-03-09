Feature: Topics

  Scenario: visit topic page when logged in
    Given a topic exists with title: 那继续晒一下韩国电影吧
      And a comment exists with content: 大叔
      And I have logged in as devin
      And I am on the topic page
      Then page title should contain 那继续晒一下韩国电影吧
        And I should see 那继续晒一下韩国电影吧
        And I should see 大叔
        And it should display a comment form
        And I should not see 编辑全部
        And I should see Ctrl + Enter

  @javascript
  Scenario: visit topic page as anonymous user
    Given a topic exists with title: 那继续晒一下韩国电影吧
      And a comment exists with content: 大叔
      And I am not authenticated
      When I am on the topic page
      Then I should see 那继续晒一下韩国电影吧
        And I should see 大叔
        And it should not display a comment form
        And I should not see 加入收藏
        And I should not see 取消收藏
        And it should not display any mention buttons

  Scenario: visit topic that without comments
    Given a topic exists with title: 那继续晒一下韩国电影吧
      And I am not authenticated
      When I am on the topic page
      Then I should see 那继续晒一下韩国电影吧
        And I should see 目前尚无回复
        And I should not see 直到
        And it should not display a comment form

  Scenario: visit a topic created by myself
    Given I have logged in as devin
    And a topic of me exists with title: 那继续晒一下韩国电影吧
    And I am on the topic page
      Then I should see 编辑全部

  Scenario: edit topic
    Given a root exists
      And an user exists with nickname: devin
      And I have logged in as devin
    And a topic of devin exists with title: Hi
    And I am on the topic page
    Then I should see 编辑全部
    When I click the link 编辑全部
    Then it should display a topic edit form

  Scenario: normal user can't edit locked topics
    Given a root exists
      And an user exists with nickname: devin
      And I have logged in as devin
    And a locked topic of devin exists with title: Hi
    And I am on the topic page
    Then it should not display link 编辑全部

  Scenario: admin can edit locked topics
    Given a locked_topic exists
      And as an admin, I have logged in as devin
      When I am on the topic page
      Then it should display link 编辑全部
        When I click the link 编辑全部
        Then it should display a topic edit form

  Scenario: admin can move or delete topics
    Given a locked_topic exists
      And as an admin, I have logged in as devin
      When I am on the topic page
      Then it should display link 移动
        And it should display link 删除

  Scenario: admin can close comments for topic
    Given as an admin, I have logged in as devin
      And a node exists
      When I am on the node page
      Then I should see 禁止回复

  Scenario: topic comments pagination
    Given a topic exists with title: 那继续晒一下韩国电影吧
      And the topic has comments of 3 pages
      And I am on the topic page
      Then it should display the pagination links
        And the current page is the last page
        When I click the second page
        Then the current page should be the second page
        When I click the first page
        Then the current page should be the first page

  Scenario: show topic comment sequence id on multi pages
    Given a topic exists with title: 那继续晒一下韩国电影吧
      And the topic has comments of 3 pages
      And I am on the topic page
      Then I should see #300
        And I should see #299
      When I click the second page
        Then I should see #200
          And I should see #199
        When I click the first page
        Then I should see #1
          And I should see #2

  Scenario: show custom rightbar widget
    Given a node exists with custom html: <strong class="heading">认识电影</strong>
      And a topic under the node exists with title: Hi
      And I am on the topic page
      Then it should display custom widget: 认识电影

  @javascript
  Scenario: mention someone using mention button as authenticated user
    Given I have logged in as devin
      And a topic exists with title: Hi
      And a comment exists with content: 大叔
      And I am on the topic page
      Then it should display a mention button
      When I click the mention button
      Then the commenter user name should appear in the comment box

  Scenario: visit topic with comments that have mentions
      Given a topic exists with title: Hi
        And an user exists with nickname: daqing
        And a comment exists with content: @daqing 大叔
        And I am on the topic page
        Then I can see that daqing was mentioned in the comment
          When I click the link daqing
          Then it should display personal homepage of daqing

  Scenario: reply topic will create notification
    Given an user exists with nickname: nana
      And a topic of nana exists with title: Rails is cool
      And I have logged in as devin
      And I am on the topic page
        When I add comment: 我爱北京天安门
        Then I should be redirected to the topic page
        Given I logout
          And I have logged in as nana
          And I am on the home page
          Then page title should contain 1
          When I click the link 1 条未读提醒
            Then page title should contain 提醒系统
              And I should not see 全部标记为已读
              And it should display 1 notification
              And I should see Rails is cool
              When I click the link Rails is cool
              Then I should see Rails is cool
                And page title should not contain 1 条未读提醒
                And I should not see 1 条未读提醒

  Scenario: topic feed
    Given a topic exists
      And I have subscribed to the topic feed
      Then it should display topic feeds
