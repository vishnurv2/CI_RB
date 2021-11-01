@account_management
Feature: User can select and agency and agency contact

  Background:
    Given I have logged in
    And I log new personal account

  @fixture_b_1_1 @TestCaseKey=PAT-T75
  Scenario: Agency type ahead
    When I start typing an agency name
    Then I should see my desired agency in the list

  @fixture_b_1_1 @TestCaseKey=PAT-T76
  Scenario: Agency contact list
    When I enter an agency name
    Then The agency contact list is populated with names
