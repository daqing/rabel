Feature: Comments

  Background:
    Given a topic exists with title: Hi
      And a comment exists with content: @daqing 大叔
      And an user exists with nickname: foobar

  Scenario: create comment when signed in
    Given I have logged in as devin
    And I am on the topic page
    Then it should display a comment form
      And I should be able to post a new comment

  Scenario: create comment on mobile device
    Given I have logged in as devin
    And I am on the topic page
    Then it should display a comment form
      Given my user agent is: Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X)
      Then I should be able to post a new comment
      And I should see via iPhone

  @javascript
  Scenario: admin can manage comments
    Given as an admin, I have logged in as devin
      And I am on the topic page
      Then there should be link EDIT in reply
        And there should be link DEL in reply

  Scenario: normal user can't manage comments
    Given I am not authenticated
      And I am on the topic page
      Then it should not display link EDIT
        And it should not display link DEL
      Given I have logged in as devin
      And I am on the topic page
      Then it should not display link EDIT
        And it should not display link DEL

