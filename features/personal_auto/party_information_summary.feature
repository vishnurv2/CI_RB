@party_validation @auto
Feature: Party Information Summary

  @TestCaseKey=PAT-T251
  Scenario: Parties Appear on Party Information Summary Page
    Given I have created a new "auto" policy via the API with data in the api_add_account fixture
    And I navigate to "Account Overview" using the left nav
    #When I navigate to "Party Information" using the left nav
    Then I should see parties in the table

  ##### Below this line has NOT been verified ######

  @fixture_party_information_summary_auto_policy_autoplus_combined_none @delete_when_done @wip @TestCaseKey=PAT-T3566
  Scenario Outline: Lessor Party Appears in Included Parties Panel
    # Given I have started a new auto policy through the "auto driver" modal
    Given I have created a new "Auto" policy
    When I begin issuance
    And I navigate to "Party Information" using the left nav
    And I add the party for the <fixture_file>
    Then I should see the party in the included parties panel
    Examples:
      | fixture_file                        |
      | party_information_summary_lessor    |

  @regression @fixture_party_information_summary_auto_policy_autoplus_combined_none @delete_when_done @wip @TestCaseKey=PAT-T3567
  Scenario Outline: Certain Parties Appear in Included Parties Panel
    Given I have started a new auto policy through the "auto driver" modal
    When I begin issuance
    And I navigate to "Party Information" using the left nav
    And I add the party for the <fixture_file>
    Then I should see the party in the included parties panel
    Examples:
      | fixture_file                                  |
      | party_information_summary_applicant           |
      | party_information_summary_loss_payee          |
      | party_information_summary_trust               |
      | party_information_summary_corporate_auto      |
      | party_information_summary_additional_interest |
      | party_information_summary_joint_ownership     |

  @regression @fixture_party_information_summary_edit_party @delete_when_done @wip @TestCaseKey=PAT-T3568
  Scenario: Added Parties Can Be Edited
    Given I have started a new auto policy through the "auto driver" modal
    When I begin issuance
    And I navigate to "Party Information" using the left nav
    And I add the party
    And I edit the party
    Then the appropriate "included" party modal should be visible
    When I add a role
    Then I should see the role I added

  @regression @fixture_party_information_summary_auto_policy_autoplus_combined_none @delete_when_done @wip @TestCaseKey=PAT-T3569
  Scenario Outline: Trashcan is Disabled For Last Applicant and Enabled For Multiple Applicants
    Given I have started a new auto policy through the "auto driver" modal
    When I begin issuance
    And I navigate to "Party Information" using the left nav
    Then I should see the disabled trashcan with an error message
    When I add the party for the <fixture_file>
    Then I should not see the disabled trashcan with an error message
    Examples:
      | fixture_file                             |
      | party_information_summary_applicant      |

  @regression @fixture_party_information_summary_edit_party @delete_when_done @wip @TestCaseKey=PAT-T3570
  Scenario: Party Entry Fields Are Hidden Before Existing Party is Selected
    Given I have started a new auto policy through the "auto driver" modal
    When I begin issuance
    And I navigate to "Party Information" using the left nav
    And I start to add the party
    Then I should not see the trust party information fields
    When I select "Add New" for the "existing party" dropdown on the "trust party" modal
    Then I should see the trust party information fields

  @regression @fixture_party_information_summary_auto_policy_autoplus_combined_none @delete_when_done @wip @TestCaseKey=PAT-T3571
  Scenario: The Last Applicant Cannot Be Deleted From the Role Information Modal
    Given I have started a new auto policy through the "auto driver" modal
    And I have loaded the fixture file named "party_information_summary_one_applicant"
    When I begin issuance
    And I navigate to "Party Information" using the left nav
    And I edit the party
    And I should not be able to remove the applicant

  @regression @fixture_clue_prefill_driver_not_added_with_role @wip @TestCaseKey=PAT-T3572
  Scenario: Prefill Driver Not Added Modal Appears
    Given I have created a new "Auto" policy
    And I begin issuance
    And I navigate to "Party Information" using the left nav
    When I edit the first party in the "other" parties panel
    Then the appropriate "other" party modal should be visible

  @fixture_clue_prefill_driver_not_added_becomes_driver @wip @TestCaseKey=PAT-T3573
  Scenario: Prefill Driver Not Added Becomes Driver
    Given I have created a new "Auto" policy
    #And I begin issuance
    And I navigate to "IN - Auto" using the left nav
    When I add a driver from the policy summary page using the data for "add_prefill_driver_not_added_as_driver"
    And I navigate to "Party Information" using the left nav
    Then I should see the party in the included parties panel using the data for "new_driver_party"

  @regression @fixture_auto_policy_removed_driver_party @wip @TestCaseKey=PAT-T3574
  Scenario: Removed Driver Appears in Other Parties Grid
    Given I have created a new "Auto" policy
    And I add a driver from the auto summary page
    When I remove the first driver for the following reason, "Disabled"
    And I begin issuance
    And I navigate to "Party Information" using the left nav
    Then I should see the party in the other parties panel using the data for "removed_driver_party"
