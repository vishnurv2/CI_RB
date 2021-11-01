@auto @account_management
Feature: Address scrubbing

  @TestCaseKey=PAT-T73
  Scenario: Entering a non-unique address generates a prompt
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "account_address_scrubber"
    When I try by adding an applicant with a partial address
    Then I should see an address scrubber alert with the message "We were unable to verify the address as entered. Please confirm your entry or update the address."

  @TestCaseKey=PAT-T72
  Scenario: Remain and correct hides the alert
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "account_address_scrubber"
    When I try by adding an applicant with a partial address
    When I select answer the address scrubber alert with "Edit"
    Then the address scrubber alert should disappear

  @TestCaseKey=PAT-T74
  Scenario: Use entered keeps the entered address
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "account_address_scrubber"
    When I try by adding an applicant with a partial address
    When I select answer the address scrubber alert with "Use As Entered"
    Then the address should match what I entered

  @TestCaseKey=PAT-T71
  Scenario: Use suggested fixes the entered address
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    And I have loaded the fixture file named "account_address_scrubber"
    When I try by adding an applicant with a partial address
    When I select answer the address scrubber alert with "Use Suggested Address"
    Then the address should be corrected
