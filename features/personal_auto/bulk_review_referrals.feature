Feature: Bulk review referrals

  @fixture_home_policy_none_combined_none_pdf_validation @regression @delete_when_done @TestCaseKey=PAT-T5769 @PAT-12217 @homeowners
  Scenario: Verify checkbox is available at each referral and on table header to select all referrals.
    Given I have created a new "home" policy
    And I begin issuance
    Then I navigate to "Referral" using the left nav
    And I verify table header checkbox is present
    And I verify each referral should have checkbox
    Then I select one referral
    And I verify Review button should be appear

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T5770 @PAT-12217 @umbrella
  Scenario: Verify number of selected referrals
    Given I have created a new "umbrella" policy
    And I begin issuance
    Then I navigate to "Referral" using the left nav
    And I select all the referrals and save the count of selected referrals
    Then I verify the selected count text

  @fixture_umbrella_policy_enhanced_no_exposures @regression @delete_when_done @TestCaseKey=PAT-T5771 @PAT-12217 @umbrella
    Scenario: Verify Review referrals modal functionality
    Given I have created a new "umbrella" policy
    And I begin issuance
    Then I navigate to "Referral" using the left nav
    And I select all the referrals and save the count of selected referrals
    Then I click on Review button and Review referrals modal should appear
    And I put comment in comment section and approve it
    And I check the status should be updated to "APPROVED"