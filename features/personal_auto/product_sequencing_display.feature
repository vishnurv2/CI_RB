Feature: All Products sequencing display

  @delete_when_done @PAT-11758 @wip
  Scenario: All prods sequencing display on add product modal
    Given I have logged in
    And I log new personal account
    And I fill the data in "new personal account" modal with product fixture file and save and close it
    Then I verify sequencing of all selected products

  
  @fixture_auto_policy_autoplus_combined_none_full_vin @delete_when_done @PAT-11758 @TestCaseKey=PAT-T5792 @regression @wip
  Scenario: All prods sequencing display in all applicable modals/pages
    Given I have created a new "Auto" policy
    And I add an additional Indiana "residential" product till "auto_policy_coverages_modal" using the fixture file "home_policy_issuance_with_prefill_property"
    And I add an additional Indiana "dwelling" product till "auto_policy_coverages_modal" using the fixture file "dwelling_policy_issuance"
    And I add an additional Indiana "umbrella" product till "auto_policy_coverages_modal" using the fixture file "umbrella_policy"
    And I add an additional Indiana "watercraft" product till "watercraft_operator_modal" using the fixture file "watercraft_policy_for_multiple_policies"
    And I add an additional Indiana "scheduled_property" product till "scheduled_property_classes_modal" using the fixture file "scheduled_property_policy_issuance"
    #And I navigate to my quote "Quote Management" using the left nav
    Then I verify sequencing of products across the application in "quotes"
    And I verify sequencing of products across the application in "documents"
    #And I verify sequencing of products across the application in "reports"
    #And I verify sequencing of products across the application in "overrides"
    And I verify sequencing of products across the application in "log activity / note"
    And I verify sequencing of products across the application in "send email"
    And I verify sequencing of products across the application in "underwriting referrals"
    And I verify sequencing of products across the application in "account summary quotes"
    And I verify sequencing of products across the application in "activity tab"
    And I verify sequencing of products across the application in "notes tab"
    And I verify sequencing of products across the application in "emails tab"
    And I verify sequencing of products across the application in "calls tab"
    And I verify sequencing of products across the application in "tasks tab"

