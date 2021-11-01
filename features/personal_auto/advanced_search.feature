@search_activity
Feature: Advanced search

  @fixture_auto_policy_applicants_details @TestCaseKey=PAT-T387
  Scenario: Advanced search - Validate details on Advanced search modal
    Given I have logged in
    When I navigate to "Account Overview" using the left nav
    And I click on advanced search
    Then I validate advanced search details
    And I should see the following search criteria dropdown options
      | search criteria   |
      | Category          |
      | First Name        |
      | Last Name         |
      | Business Name     |
      | State             |
      | Zip               |
      | Email             |
      | Phone             |
      | VIN               |
      | Billing Account # |
      | Region            |
      | Agency            |
    And I should see the following condition dropdown options
      | condition   |
      | Begins With |
      | Contains    |
      | Is          |
    And I validate condition field as disabled

  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T401
  Scenario: Advanced search by selecting First Name and Last Name
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save first and last name
    Then I log out
    Then I have logged in
    When I navigate to "Account Overview" using the left nav
    And I click on advanced search
    Then I search by providing first name and last name
    And I validate the results
    And I click on advanced search
    Then I search by providing only first name
    And I validate the results
