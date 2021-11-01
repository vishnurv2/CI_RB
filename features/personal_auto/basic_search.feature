@auto @search_activity
Feature: Basic search

  @fixture_auto_policy_applicants_details @TestCaseKey=PAT-T271
  Scenario: Basic search by email address
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save name email and phone number from account summary page
    Then I log out
    Then I have logged in
    Then I navigate to "Account Overview" using the left nav
    And I search for "email" using the basic search
    Then I select "address_icon" record matching with secondary text of "email"
    And I validate "email" in applicants panel

  @fixture_auto_policy_applicants_details @TestCaseKey=PAT-T272 @regression
  Scenario: Basic search by phone number
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save name email and phone number from account summary page
    Then I log out
    Then I have logged in
    Then I navigate to "Account Overview" using the left nav
    And I search for "phone" using the basic search
    Then I select "address_icon" record matching with secondary text of "phone"
    And I validate "phone" in applicants panel

  @fixture_auto_policy_applicants_details @TestCaseKey=PAT-T284 @regression
  Scenario: Basic search by first Name
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save name email and phone number from account summary page
    Then I log out
    Then I have logged in
    Then I navigate to "Account Overview" using the left nav
    And I search for "name" using the basic search
    Then I select "address_icon" record matching with primary text "name"
    And I validate "name" in applicants panel

  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T383
  Scenario: Basic search by full Name
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save name email and phone number from account summary page
    Then I log out
    Then I have logged in
    Then I navigate to "Account Overview" using the left nav
    And I select "Personal Lines" and search by full name
    Then I select "address_icon" record matching with primary text "name"
    And I validate "name" in applicants panel

  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T384
  Scenario: Basic search validate when invalid letter is placed
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save name email and phone number from account summary page
    Then I log out
    Then I have logged in
    Then I navigate to "Account Overview" using the left nav
    And I search for "first_name" along with invalid letter
    Then I validate empty message

   # PAT-9859 - added a @browser.refresh to get it to pass
  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T291
  Scenario: Basic search by policy number
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I save policy number from account summary page
    Then I log out
    Then I have logged in using the credentials from the file "valid_creds"
    Then I navigate to "Account Overview" using the left nav
    And I search for policy number in the basic search
    Then I select "car_icon" record matching with primary text "policy number"
    And I validate "product" in products panel

    # PAT-9859 - added a @browser.refresh to get it to pass
  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T398
  Scenario: Basic search by quote number
    Given I have created a new "Auto" policy
    And I save policy or quote number from account summary page
    Then I log out
    Then I have logged in using the credentials from the file "valid_creds"
    Then I navigate to "Account Overview" using the left nav
    And I search for quote number in the basic search
    Then I select "car_icon" record matching with primary text "quote number"
    And I validate "product" in products panel

  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T291
  Scenario: Basic search by account number
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I save account number and quote number from payments page and account summary page
    Then I log out
    Then I have logged in using the credentials from the file "valid_creds"
    Then I navigate to "Account Overview" using the left nav
    And I search for account number in the basic search
    Then I select "car_icon" record matching with primary text "account number"
    And I validate "product" in products panel

  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T399
  Scenario: Basic search view all results
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save name email and phone number from account summary page
    Then I log out
    Then I have logged in
    Then I navigate to "Account Overview" using the left nav
    And I select "Personal Lines" and search by full name
    Then I click on view all results on top
    And I validate search results page and its details

  @regression @TestCaseKey=PAT-T295
  Scenario: Search Results No Results found validation
    Given I have logged in
    And I navigate to "Account Overview" using the left nav
    Then I search for non existing "email"
    And I validate empty message
    Then I search for non existing "phone"
    And I validate empty message
    Then I search for non existing "name"
    And I validate empty message

  @fixture_auto_policy_applicants_details @regression @TestCaseKey=PAT-T344
  Scenario: Basic search view all results Filters
    Given I have started a new auto policy through the "auto policy coverages" modal
    And I save name email and phone number from account summary page
    Then I log out
    Then I have logged in
    Then I navigate to "Account Overview" using the left nav
    And I select "Personal Lines" and search by full name
    Then I click on view all results on top
    And I validate filters on search results page
