Feature: Session

  Scenario: sign in
    Given an user exists with nickname: devin
      And I am on the login page
      Then it should display the login form
      When I fill in devin's credentials
        Then I should be signed in

  Scenario: sign out
    Given I have logged in as devin
      And I am on the home page
      Then I should see 登出
      When I click the link 登出
        Then I should be redirected to the goodbye page
        And I should see 登出
        And I should see 没有任何个人信息留在这台设备上
