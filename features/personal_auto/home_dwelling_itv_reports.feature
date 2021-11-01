@new_business @account_management
Feature: UX - ITV Reports - No Hit - Issues to Resolve

  @fixture_home_policy_issuance_itv @delete_when_done @TestCaseKey=PAT-T5825 @PAT-12190 @regression @homeowners
  Scenario:  Home UX - ITV Reports - No Hit - Issues to Resolve
    Given I have started a new home policy through the "auto policy coverages" modal
    And I begin issuance
    Then I order reports and resolve itv no hit
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    When I answer all the underwriting questions
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"

  @fixture_dwelling_policy_issuance_itv @delete_when_done @TestCaseKey=PAT-T5830 @PAT-12190 @regression @dwelling
  Scenario:  Dwelling UX - ITV Reports - No Hit - Issues to Resolve
    Given I have started a new dwelling policy through the "auto policy coverages" modal
    And I begin issuance
    Then I order reports and resolve itv no hit
    And I navigate to my quote "Quote Management" using the left nav
    Then I resolve any underwriter referrals using blue streak seal or approvals
    When I answer all the underwriting questions
    Then I finish issuing the policies
    Then the products status should be "INFORCE" or "ISSUED"