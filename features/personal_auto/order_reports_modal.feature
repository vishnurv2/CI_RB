Feature: WT - UX - Order Reports Modal - return to page launched from

#  looking into it - throwing wait for ajax error
  @delete_when_done @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T5764 @PAT-11756 @regression @auto @policy_issuance
  Scenario: WT - UX - Order Reports Modal - from policy summary page
    Given I have created a new "Auto" policy
    And I begin issuance
    And I navigate to my quote "IN - Auto" using the left nav
    Then I order reports through actions dropdown
    And I validate reports modal
    When I answer the underwriting questions
    And I resolve any underwriter referrals
    When I finish issuing the policy
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_home_policy_issuance @delete_when_done @TestCaseKey=PAT-T5763 @PAT-11756 @regression @multiple @policy_issuance
  Scenario:  WT - UX - Order Reports Modal - from quote management page
    Given I have started a new home policy through the "auto policy coverages" modal
    And I add an additional Indiana "dwelling" product till "auto_policy_coverages_modal" using the fixture file "dwelling_policy_issuance"
    And I begin issuance
    Then I order reports through actions dropdown
    When I answer all the underwriting questions
    Then I resolve any underwriter referrals using blue streak seal or approvals
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"



