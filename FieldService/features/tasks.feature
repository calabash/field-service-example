Feature: Tasks

  Scenario: Tracking time on a task
    Given I am on the Assignments screen
    When I start recording on #2001
    Then the timer should start ticking
