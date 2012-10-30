Feature: Manage Planes/Nodes
  Scenario: show all planes/nodes
    Given a plane exists
      And a node exists
      And as an admin, I have logged in as devin
      When I am on the admin planes page
        Then page title should contain 位面节点
        And it should display link 添加节点
        And it should display link 修改

  @javascript
  Scenario: create plane
    Given as an admin, I have logged in as devin
      And I am on the admin planes page
      Then it should display link 添加位面
      When I click the link 添加位面
        Then it should display the plane creation form
        When I provide the plane name: Web 2.0
        Then I should see Web 2.0

  @javascript
  Scenario: update plane
    Given a plane exists with name: Games
      And as an admin, I have logged in as devin
      And I am on the admin planes page
      Then I should see Games
      And it should display link 修改位面
      When I click the link 修改位面
        Then it should display the plane editing form
        When I provide the plane name: Web 2.0
        Then I should see Web 2.0

  @javascript
  Scenario: delete plane
    Given a plane exists with name: Nginx
      And as an admin, I have logged in as devin
      And I am on the admin planes page
      Then I should see Nginx
        And it should display link 删除
      When I click the link 删除
        Then an alert message is shown as 真的要删除吗?
        When I confirm the alert message
        Then I should not see Nginx

