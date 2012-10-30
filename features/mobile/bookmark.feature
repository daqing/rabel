Feature: mobile bookmark

  Background:
    Given I have logged in as devin

  @mobile
  Scenario: show my bookmarks on home page
    When I am on the home page
    Then I should see 话题收藏
      And I should see 特别关注
  
  @mobile
  Scenario: show topic bookmarks
    When I am on my bookmarked topics page
    Then I should see 我收藏的话题

  @mobile
  Scenario: show following
    When I am on my following page
    Then I should see 我的特别关注

  @mobile
  Scenario: bookmark topic
    Given a topic exists
      And I am on the topic page
      Then it should display link 加入收藏
      When I click the link 加入收藏
      Then it should display link 取消收藏
      When I click the link 取消收藏
      Then it should display link 加入收藏
