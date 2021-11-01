@auto @policy_issuance
Feature: Account Summary Policy View

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T96
  Scenario: Verify left nav is in Policy View Mode
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then I should see "Policies" in the left nav
    Then I should see the following links available in the left nav
      | Reports | Documents | Referrals | Overrides |

  @fixture_auto_policy_autoplus_combined_none_full_vin @regression @TestCaseKey=PAT-T94
  Scenario: While in Policy View Mode - No quotes should exist
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then No quotes should exist

  @fixture_auto_policy_autoplus_combined_none_full_vin @regression @TestCaseKey=PAT-T3704
  Scenario: Products Section Has Cancel Renew Icon
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then The products section has "cancel_renew" in the actions dropdown

  @delete_when_done @fixture_auto_policy_none_combined_none_adjusted @regression @TestCaseKey=PAT-T97 @new_business
  Scenario: Add a product on Issued Policy and left nav will reflect Quote Mode and products tab row
    Given I have created a new "Auto" policy
    And I fully issue the policy
    And I add an additional Indiana "automobile" product using the fixture file "auto_policy_sig_split_uninsured"
    And I should see "1" quote in the products tab row
    When I click the "Quotes" tab in the products list
    Then the product status should be "Incomplete Quote"

  @fixture_auto_policy_autoplus_combined_none_full_vin @TestCaseKey=PAT-T3705
  Scenario: While in Policy View Mode - Cannot edit or add applicant
    Given I have created a new "Auto" policy
    And I fully issue the policy
    Then The "edit" icon should not be visible
    Then The "delete_button" icon should not be visible
    And The "add_applicant_button" button should not be visible

  @delete_when_done @fixture_auto_policy_none_combined_none_adjusted @regression @TestCaseKey=PAT-T95 @new_business
  Scenario: While in Policy View Mode - I should see high-level billing information
    Given I have created a new "Auto" policy
    And I begin issuance
    When I answer the underwriting questions
    Then I order CLUE and MVR reports
    And I resolve any underwriter referrals
    Then I navigate till billing modal and validate it
    When I populate the billing using the "billing_modal_defaults" fixture file
    When I finish issuing the policy after adding billing account
    Then the products status should be "INFORCE" or "ISSUED"
    And I should see a billing account in the Billing Summary
