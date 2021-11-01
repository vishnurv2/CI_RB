@auto @policy_change
Feature: Auto - Coverage Named Non Owned - Validation

  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @regression @PAT-7048 @TestCaseKey=PAT-T256
  Scenario Outline: Coverage Named Non Owned - Validation
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then the product status should be "Issued"
    Then I add a policy change and specify the effective date
    When I add named non owned coverage with option "Named Individual and Resident Relatives" in policy level coverages modal
    Then I navigate to policies "Open Policy Changes" using the left nav
    Then I should see <issue message> on issues to resolve page
    Examples:
      |issue message|
      |More than 1 driver is needed when the Named Individual and Resident Relatives option is selected|

    # Note : In policy change, if a driver is added and Named Non-Owner exists with the option of Named Individual and Resident Relatives.
    # The newly added driver will also have this coverage and this driver's name would be shown on the policy declaration page showing this coverage applies.
    # This note will be covered in future, its related to validating pdf document.