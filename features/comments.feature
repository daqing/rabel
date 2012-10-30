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

  @javascript
  Scenario: admin can manage comments
    Given as an admin, I have logged in as devin
      And I am on the topic page
      Then there should be link EDIT in reply
        And there should be link DEL in reply

  Scenario: normal user can't manage comments
    Given I am not authenticated
      And I am on the topic page
      Then it should not display link 编辑
        And it should not display link 删除
      Given I have logged in as devin
      And I am on the topic page
      Then it should not display link 编辑
        And it should not display link 删除

