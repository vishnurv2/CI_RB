@regression @umbrella @account_management
Feature: Underwriting Questions Page

  @fixture_underwriting_questions @delete_when_done @TestCaseKey=PAT-T281
  Scenario: Underwriting Questions are Answered
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Underwriting Questions" tab on quote management page
    Then The unflagged underwriting question answers should be "No"
    When I answer the underwriting questions "Yes" using uw_questions fixture
    Then The unflagged underwriting question answers should be "Yes"

  @fixture_underwriting_questions @delete_when_done @TestCaseKey=PAT-T282
  Scenario: Auto - Underwriting Questions are Answered
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Underwriting Questions" tab on quote management page
    Then The unflagged "auto" underwriting question answers should be "No"
    When I answer the auto underwriting questions "Yes" using uw_questions fixture
    Then The unflagged "auto" underwriting question answers should be "Yes"

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5373 @PAT-11789 @regression
  Scenario: WT - UW Questions - Remove "Any other products" question
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I validate that any other products question is not present anymore

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5374 @PAT-11807 @regression
  Scenario: WT - Auto underwriting questions - remove question "Household member in military service"
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I validate that household member in military service question is not present anymore

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5379 @PAT-12140 @PAT-11907 @regression
  Scenario: WT - Update format of "Residence Employees" under Home UW Questions
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I validate format of "Residence Employees" under home uw questions

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5380 @PAT-11915 @regression
  Scenario: WT - UW Questions - Fuel Storage - Age of Tank
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I validate age of tank under fuel storage question

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5381 @PAT-11908 @regression
  Scenario: WT - UW Questions - Flooding, Brush, Landslide - Expanded Questions
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I validate format of "flooding, brush, forest fire hazard, landslide" under home uw questions

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5388 @PAT-11912 @PAT-12145 @regression
  Scenario: WT - UW Questions - Exotic Pets - Expanded Questions
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I validate format of "any exotic pets" under home uw questions

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5389 @PAT-12142 @PAT-11909 @regression
  Scenario: WT - Update format of Has the applicant had a foreclosure, repossession or bankruptcy during the past 5 years under Home UW Questions
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I validate format of "foreclosure, repossession or bankruptcy" under home uw questions

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5390 @PAT-12148 @regression
  Scenario: WT - Update format of Property wn 300 of commercial property under Home UW Questions
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I validate format of "300 feet of commercial or non-residential property" under home uw questions

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5391 @PAT-11911 @regression
  Scenario: WT - UW Questions - Any Dogs Listed Below - Wording Change
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I validate are there any dogs kept on premises question

  @fixture_watercraft_policy @delete_when_done @PAT-12283 @TestCaseKey=PAT-T5396 @regression
  Scenario: WT - Watercraft - UW Q's
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I begin issuance
    Then I validate "Any Watercraft meet the criteria?" watercraft question

  @fixture_watercraft_policy @delete_when_done @PAT-12281 @TestCaseKey=PAT-T5395 @regression
  Scenario: WT - Watercraft - UW Q's - Additional Owners Wording
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I begin issuance
    Then I validate "Are there any additional owners not listed as an applicant for any of the boats?" watercraft question

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5528 @PAT-11791 @regression
  Scenario: WT - Move the "Any coverage cancelled or Non-renewed" out of All products into each product UW questions
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I validate all products underwriting question section is removed

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5794 @PAT-12150 @regression
  Scenario: WT - Update format of Work from Home Business under Home UW Questions
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I validate work from home question

  @fixture_watercraft_policy @delete_when_done @PAT-12282 @TestCaseKey=PAT-T5907 @regression
  Scenario: WT - Watercraft - UW Q's - Suspended Revoked Driver Dropdown
    Given I have created a new "watercraft" policy
    And I add a watercraft operator
    And I begin issuance
    Then I validate "Any driver's license been suspended/revoked during the last 7 years?" watercraft question and its fields

  @fixture_scheduled_property_policy_issuance @delete_when_done @TestCaseKey=PAT-T5933 @PAT-12266 @regression
  Scenario: WT - SPP UW Q's - Used Professionally / Commercially - Remove Add Another
    Given I have created a new "scheduled_property" policy
    And I begin issuance
    Then I validate format of "Is any property used professionaly/commercially?" under spp uw questions

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5934 @PAT-11962 @regression
  Scenario: WT - Update format of "Are any vehicles used for delivery" under Auto UW Questions
    Given I have created a new "Auto" policy
    And I begin issuance
    Then I validate are any vehicles used for delivery question