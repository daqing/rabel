Feature: Base features
  @mobile
  Scenario: visit homepage as anonymous user
    Given I am on the home page
    Then I should see 最新讨论
      And I should see 节点导航
      And I should not see 我的收藏
      And I should see 登入
      And I should see 注册

  @mobile
  Scenario: visit homepage as authenticated user
    Given I have logged in as devin
      And I am on the home page
      Then I should not see 登入
        And I should not see 注册
        And it should display a settings icon
        And it should display a logout icon
        And I should see 我的收藏

  @mobile
  Scenario: sign in
    Given an user exists with nickname: devin
      And I am on the home page
      Then I should see 登入
      When I click the link 登入
        Then I should see 用户名
        And I should see 密码
        When I fill in devin's credentials
          Then I should be signed in
          And I should see devin

  @mobile
  Scenario: sign out
    Given I have logged in as devin
      Then it should display a logout icon
      When I click the logout icon
      Then I should see 登出

  @mobile
  Scenario: visit member page
    Given an user exists with nickname: devin
      And I am on devin's profile page
      Then I should see devin
      And I should see 号会员
      And I should see 加入

  @mobile
  Scenario: visit node page as anonymous user
    Given a node exists with name: 电影
      And a topic under the node exists with title: hi
      And I am on the node page
      Then I should see 电影
        And I should see 1 个主题
        And it should not display button 创建新主题

  @mobile
  Scenario: visit node page as authenticated user
    Given a node exists with name: 电影
      And I have logged in as devin
      And I am on the node page
        Then it should display button 创建新主题
        When I click the mobile button 创建新主题
          Then it should display a compact topic creation form
            When I provide topic creation information
            Then I should be redirected to the topic page

  @mobile
  Scenario: visit topic page as anonymous user
    Given a node exists with name: 电影传奇
    Given a topic under the node exists with title: 那继续晒一下韩国电影吧
      And the topic has comments of 3 pages (2 per page)
      And I am on the topic page
      Then it should display the nagination links
        And it should not display a comment form
        And I should see 电影传奇
        And I should see 那继续晒一下韩国电影吧
        And I should see 共收到
        And the current page is the last page
        When I click the second page
        Then the current page should be the second page
        When I click the first page
        Then the current page should be the first page

  @mobile
  Scenario: visit topic page as authenticated user
    Given a node exists with name: 电影传奇
    Given a topic under the node exists with title: 那继续晒一下韩国电影吧
      And the topic has comments of 3 pages (2 per page)
      And I have logged in as devin
      When I am on the topic page
        Then it should display a comment form
        And I should be able to post a new comment

  @mobile
  Scenario: edit profile as authenticated user
    Given I have logged in as devin
      And I am on the settings page
      Then I should see 设置
      When I provide account info
        Then I should be redirected to the settings page
        And I should see 个人设置成功更新

  @mobile
  Scenario: change password as authenticated user
    Given I have logged in as devin
      And I am on the settings page
      Then I should see 安全
      When I provide new password
        Then I should be redirected to the settings page
        And I should see 密码已成功更新，下次请用新密码登录

  @mobile
  Scenario: view pages
    Given a page exists with title: FAQ
      And I am on the page page
        Then page title should contain FAQ
          And I should see FAQ

  @mobile
  Scenario: show custom html on node page
    Given a node exists with custom html: <strong class="heading">认识电影</strong>
      And I am on the node page
        Then I should see 认识电影
