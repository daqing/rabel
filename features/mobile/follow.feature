Feature: mobile follow

  Background:
    Given an user exists with nickname: nana
      And an user exists with nickname: devin

  @mobile
  Scenario: can't follow when not signed in
    Given I am not authenticated
      And I am on nana's profile page
      Then I should not see 加入特别关注

  @mobile
  Scenario: follow and unfollow user
    Given I have logged in as devin
      And I am on nana's profile page
      Then it should display link 加入特别关注
      When I click the link 加入特别关注
      Then it should display link 取消特别关注

  @mobile
  Scenario: can't follow myself
    Given I have logged in as devin
      And I am on devin's profile page
      Then it should not display link 加入特别关注

