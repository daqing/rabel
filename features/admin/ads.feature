Feature: Manage Ads
  Scenario: show all ads
    Given an advertisement exists
      And as an admin, I have logged in as devin
      When I am on the admin ads page
      Then page title should contain 广告位
        And it should display link 添加新广告
        And I should see 开始日期
        And I should see 结束日期
        And I should see 持续时间

  Scenario: create ad
    Given as an admin, I have logged in as devin
      When I am on the admin ads page
        Then it should display link 添加新广告
        When I click the link 添加新广告
          Then page title should contain 添加新广告
          And I should see 广告标题 
          And I should see 广告语

  Scenario: update ad
    Given an advertisement exists
      And as an admin, I have logged in as devin
      When I am on the admin ads page
      Then it should display link 修改
      When I click the link 修改
      Then page title should contain 修改广告
        And I should see 广告标题 
        When I provide new ad title
        Then I should be redirected to the admin ads page
          And I should see Rabel 1.0 Preview


