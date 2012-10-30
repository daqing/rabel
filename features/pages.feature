Feature: Pages
  Scenario: visit page
    Given a page exists with title: FAQ
      And I am on the page page
      Then page title should contain FAQ
        And I should see FAQ
  Scenario: visit draft page
    Given an root exists
      And a page is in draft with title: FAQ
      And I am on the page page
      Then it should display a record not found message
      Given I have logged in as devin
        And I am on the page page
        Then it should display a record not found message
        When I logout
        Given as an admin, I have logged in as zhiming
          And I am on the page page
          Then page title should contain FAQ
            And I should see FAQ

