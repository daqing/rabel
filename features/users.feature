Feature: Users

  Scenario: edit settings when signed out
    Given I am not authenticated
      And I am on the settings page
      Then I should be redirected to the login page

  Scenario: edit settings after logged in
    Given I have logged in as devin
      And I am on the settings page
      Then it should display the settings form
        And page title should contain 设置
      When I provide account info
      Then I should see 个人设置成功更新

  Scenario: change password
    Given I have logged in as devin
      And I am on the settings page
      Then it should display the settings form
      When I provide new password
      Then I should see 密码已成功更新，下次请用新密码登录

  Scenario: personal homepage
    Given an user exists with nickname: devin
      And I am not authenticated
      And a topic of the user exists with title: Rails is cool
      And I am on the user's profile page
      Then page title should contain devin
        And I should see devin
        And I should not see 加入特别关注
        And I should see Rails is cool

  Scenario: visit other's personal homepage as authenticated user
    Given an user exists with nickname: dhh
      And an user exists with nickname: nana
      And an user exists with nickname: zhiming
      And I have logged in as devin
      And zhiming has followed dhh
      And a topic of the user exists with title: Rails is cool
      And I am on dhh's profile page
      Then page title should contain dhh
        And I should see dhh
        And I should see 加入特别关注
        And I should see Rails is cool
        Given nana has followed dhh
          And I am on dhh's profile page
          Then I should see 关注dhh的人

  Scenario: visit my personal homepage as authenticated user
    Given I have logged in as devin
      And a topic of the user exists with title: Rails is cool
      And I am on devin's profile page
      Then page title should contain devin
        And I should see devin
        And I should not see 加入特别关注
        And I should see Rails is cool

  Scenario: follow and unfollow user
    Given an user exists with nickname: dhh
      And I have logged in as devin
      And I am on dhh's profile page
      Then I should see 加入特别关注
        When I click the link 加入特别关注
          Then I should see 取消特别关注
        When I click the link 取消特别关注
          Then I should see 加入特别关注

  Scenario: my following page
    Given I have logged in as devin
      And devin has followed dhh, linus
      And a topic of dhh exists with title: Rails is not for beginners
      And a topic of linus exists with title: C++ is bullshit
      And I am on my following page
      Then I should see 我的特别关注
        And page title should contain 我的特别关注
        And I should see dhh
        And I should see linus
        And I should see Rails is not for beginners
        And I should see C++ is bullshit

  Scenario: change avatar
    Given I have logged in as devin
      And I am on the settings page
      Then I should see 头像
        And I should see 当前头像
        And it should display button 上传新头像

