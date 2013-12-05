Feature: Assignments

  Scenario: Login with valid user proceeds to Assignments
    Given I am on the Login screen
    When I login as "Nat"
    Then I should go to the Assignments screen


  Scenario: Login with invalid user
    Given I am on the Login screen
    When I login as "Invalid"
    Then I should not be logged in
    And I should see a login error message

