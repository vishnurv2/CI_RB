@auto @search_activity
Feature: Add banner to PAT search results for CMI users only

  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T5787 @PAT-11815
  Scenario: Add banner to PAT search results for CMI users only
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save name email and phone number from account summary page
    And I save first and last name
    Then I log out
    Then I have logged in
    Then I navigate to "Account Overview" using the left nav
    And I select "Personal Lines" and search by full name
    Then I click on view all results on top
    And I validate banner message for search results
    And I click on advanced search
    Then I search by providing first name and last name
    And I validate banner message for search results
