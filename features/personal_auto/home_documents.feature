@homeowners @documents @new_business
Feature: Home policies - Documents page

  @fixture_home_policy_protection_class_override @delete_when_done @TestCaseKey=PAT-T30 @PAT-4024 @PAT-7681 @regression
  Scenario:  Home - Documents Page - Forward to Central
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    And I navigate to "Documents" using the left nav
    Then I should see "ISO Location PPC Inquiry Form" document in "Forward To Central" section
    When I navigate to "IN - Homeowners" using the left nav
    And I click on modify property information modal
    And I provide details and save and close property information modal using "property_info_protection_class_override" fixture
    Then I navigate to "Documents" using the left nav
    And I should not see "ISO Location PPC Inquiry Form" document in "Forward To Central" section

  @fixture_home_policy_protection_class_override @delete_when_done @TestCaseKey=PAT-T46 @PAT-4025 @PAT-7681
  Scenario:  Home - documents page - Retain in agency
    Given I have started a new home policy through the "auto policy coverages" modal
    And I navigate to "Documents" using the left nav
    Then I should not see "Application" document in "Retain in Agency" section
    And I begin issuance
    And I navigate to "Documents" using the left nav
    Then I should see "Application" document in "Retain in Agency" section